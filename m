Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ECF4C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 07:49:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6818B218AE
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 07:49:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731799AbfB1HtZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 02:49:25 -0500
Received: from terminus.zytor.com ([198.137.202.136]:39389 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725918AbfB1HtR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 02:49:17 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x1S7n9NS2950603
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 27 Feb 2019 23:49:09 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x1S7n9Xo2950599;
        Wed, 27 Feb 2019 23:49:09 -0800
Date:   Wed, 27 Feb 2019 23:49:09 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Adrian Hunter <tipbot@zytor.com>
Message-ID: <tip-1f35cd65386e02430546727bd3cc2508d052e3ec@git.kernel.org>
Cc:     jolsa@kernel.org, linux-kernel@vger.kernel.org, acme@redhat.com,
        adrian.hunter@intel.com, tglx@linutronix.de, mingo@kernel.org,
        hpa@zytor.com
Reply-To: linux-kernel@vger.kernel.org, acme@redhat.com, jolsa@kernel.org,
          hpa@zytor.com, mingo@kernel.org, tglx@linutronix.de,
          adrian.hunter@intel.com
In-Reply-To: <20190109091835.5570-6-adrian.hunter@intel.com>
References: <20190109091835.5570-6-adrian.hunter@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf thread-stack: Improve
 thread_stack__no_call_return()
Git-Commit-ID: 1f35cd65386e02430546727bd3cc2508d052e3ec
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  1f35cd65386e02430546727bd3cc2508d052e3ec
Gitweb:     https://git.kernel.org/tip/1f35cd65386e02430546727bd3cc2508d052e3ec
Author:     Adrian Hunter <adrian.hunter@intel.com>
AuthorDate: Wed, 9 Jan 2019 11:18:34 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Fri, 22 Feb 2019 11:42:34 -0300

perf thread-stack: Improve thread_stack__no_call_return()

Improve thread_stack__no_call_return() to better handle 'returns' that
do not match the stack i.e. 'no call'. See code comments for details.
The example below shows how retpolines are affected:

Example:

  $ cat simple-retpoline.c
  __attribute__((noinline)) int bar(void)
  {
          return -1;
  }

  int foo(void)
  {
          return bar() + 1;
  }

  __attribute__((indirect_branch("thunk"))) int main()
  {
          int (*volatile fn)(void) = foo;

          fn();
          return fn();
  }
  $ gcc -ggdb3 -Wall -Wextra -O2 -o simple-retpoline simple-retpoline.c
  $ objdump -d simple-retpoline
  <SNIP>
  0000000000001040 <main>:
      1040:       48 83 ec 18             sub    $0x18,%rsp
      1044:       48 8d 05 25 01 00 00    lea    0x125(%rip),%rax        # 1170 <foo>
      104b:       48 89 44 24 08          mov    %rax,0x8(%rsp)
      1050:       48 8b 44 24 08          mov    0x8(%rsp),%rax
      1055:       e8 1f 01 00 00          callq  1179 <__x86_indirect_thunk_rax>
      105a:       48 8b 44 24 08          mov    0x8(%rsp),%rax
      105f:       48 83 c4 18             add    $0x18,%rsp
      1063:       e9 11 01 00 00          jmpq   1179 <__x86_indirect_thunk_rax>
  <SNIP>
  0000000000001160 <bar>:
      1160:       b8 ff ff ff ff          mov    $0xffffffff,%eax
      1165:       c3                      retq
  <SNIP>
  0000000000001170 <foo>:
      1170:       e8 eb ff ff ff          callq  1160 <bar>
      1175:       83 c0 01                add    $0x1,%eax
      1178:       c3                      retq
  0000000000001179 <__x86_indirect_thunk_rax>:
      1179:       e8 07 00 00 00          callq  1185 <__x86_indirect_thunk_rax+0xc>
      117e:       f3 90                   pause
      1180:       0f ae e8                lfence
      1183:       eb f9                   jmp    117e <__x86_indirect_thunk_rax+0x5>
      1185:       48 89 04 24             mov    %rax,(%rsp)
      1189:       c3                      retq
  <SNIP>
  $ perf record -o simple-retpoline.perf.data -e intel_pt/cyc/u ./simple-retpoline
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0,017 MB simple-retpoline.perf.data ]
  $ perf script -i simple-retpoline.perf.data --itrace=be -s ~/libexec/perf-core/scripts/python/export-to-sqlite.py simple-retpoline.db branches calls
  2019-01-08 14:03:37.851655 Creating database...
  2019-01-08 14:03:37.863256 Writing records...
  2019-01-08 14:03:38.069750 Adding indexes
  2019-01-08 14:03:38.078799 Done
  $ ~/libexec/perf-core/scripts/python/exported-sql-viewer.py simple-retpoline.db

Before:

    main
        -> __x86_indirect_thunk_rax
            -> __x86_indirect_thunk_rax
                -> __x86_indirect_thunk_rax
                    -> bar

After:

    main
        -> __x86_indirect_thunk_rax
            -> __x86_indirect_thunk_rax
                -> foo
                    -> bar

Committer testing:

Chose "Reports", Then "Context-Sensitive Call Graph" and then go on
expanding:

Before:

simple-retpolin
   PID:PID
      _start
         _start
            __libc_start_main
               main
                   __x86_indirect_thunk_rax
                      __x86_indirect_thunk_rax
                      bar

After:

Remove the "simple.retpoline.db" file, run again the 'perf script' line
to regenerate the .db file and run the exported-sql-viewer.py again to
get the same all the way to 'main', then, from there, including 'main':

               main
                   __x86_indirect_thunk_rax
                       __x86_indirect_thunk_rax
                           foo
                               bar

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Link: http://lkml.kernel.org/r/20190109091835.5570-6-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/thread-stack.c | 49 +++++++++++++++++++++++++++++++++++++++---
 1 file changed, 46 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/thread-stack.c b/tools/perf/util/thread-stack.c
index f52c0f90915d..632c07a125ab 100644
--- a/tools/perf/util/thread-stack.c
+++ b/tools/perf/util/thread-stack.c
@@ -638,14 +638,57 @@ static int thread_stack__no_call_return(struct thread *thread,
 	else
 		parent = root;
 
-	/* This 'return' had no 'call', so push and pop top of stack */
-	cp = call_path__findnew(cpr, parent, fsym, ip, ks);
+	if (parent->sym == from_al->sym) {
+		/*
+		 * At the bottom of the stack, assume the missing 'call' was
+		 * before the trace started. So, pop the current symbol and push
+		 * the 'to' symbol.
+		 */
+		if (ts->cnt == 1) {
+			err = thread_stack__call_return(thread, ts, --ts->cnt,
+							tm, ref, false);
+			if (err)
+				return err;
+		}
+
+		if (!ts->cnt) {
+			cp = call_path__findnew(cpr, root, tsym, addr, ks);
+
+			return thread_stack__push_cp(ts, addr, tm, ref, cp,
+						     true, false);
+		}
+
+		/*
+		 * Otherwise assume the 'return' is being used as a jump (e.g.
+		 * retpoline) and just push the 'to' symbol.
+		 */
+		cp = call_path__findnew(cpr, parent, tsym, addr, ks);
+
+		err = thread_stack__push_cp(ts, 0, tm, ref, cp, true, false);
+		if (!err)
+			ts->stack[ts->cnt - 1].non_call = true;
+
+		return err;
+	}
+
+	/*
+	 * Assume 'parent' has not yet returned, so push 'to', and then push and
+	 * pop 'from'.
+	 */
+
+	cp = call_path__findnew(cpr, parent, tsym, addr, ks);
 
 	err = thread_stack__push_cp(ts, addr, tm, ref, cp, true, false);
 	if (err)
 		return err;
 
-	return thread_stack__pop_cp(thread, ts, addr, tm, ref, tsym);
+	cp = call_path__findnew(cpr, cp, fsym, ip, ks);
+
+	err = thread_stack__push_cp(ts, ip, tm, ref, cp, true, false);
+	if (err)
+		return err;
+
+	return thread_stack__call_return(thread, ts, --ts->cnt, tm, ref, false);
 }
 
 static int thread_stack__trace_begin(struct thread *thread,
