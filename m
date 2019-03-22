Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41A64C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 22:32:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1559E218D4
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 22:32:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728145AbfCVWcy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 18:32:54 -0400
Received: from terminus.zytor.com ([198.137.202.136]:34817 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727673AbfCVWcy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 18:32:54 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x2MMVu32753784
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 22 Mar 2019 15:31:56 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x2MMVtmn753781;
        Fri, 22 Mar 2019 15:31:55 -0700
Date:   Fri, 22 Mar 2019 15:31:55 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Changbin Du <tipbot@zytor.com>
Message-ID: <tip-1e5b0cf8672e622257df024074e6e09bfbcb7750@git.kernel.org>
Cc:     tglx@linutronix.de, daniel@iogearbox.net, changbin.du@gmail.com,
        linux-kernel@vger.kernel.org, jolsa@kernel.org,
        namhyung@kernel.org, rostedt@goodmis.org, ast@kernel.org,
        hpa@zytor.com, mingo@kernel.org, peterz@infradead.org,
        acme@redhat.com
Reply-To: tglx@linutronix.de, peterz@infradead.org, mingo@kernel.org,
          hpa@zytor.com, rostedt@goodmis.org, namhyung@kernel.org,
          jolsa@kernel.org, linux-kernel@vger.kernel.org,
          changbin.du@gmail.com, daniel@iogearbox.net, acme@redhat.com,
          ast@kernel.org
In-Reply-To: <20190316080556.3075-13-changbin.du@gmail.com>
References: <20190316080556.3075-13-changbin.du@gmail.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf top: Fix global-buffer-overflow issue
Git-Commit-ID: 1e5b0cf8672e622257df024074e6e09bfbcb7750
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

Commit-ID:  1e5b0cf8672e622257df024074e6e09bfbcb7750
Gitweb:     https://git.kernel.org/tip/1e5b0cf8672e622257df024074e6e09bfbcb7750
Author:     Changbin Du <changbin.du@gmail.com>
AuthorDate: Sat, 16 Mar 2019 16:05:52 +0800
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 19 Mar 2019 16:52:05 -0300

perf top: Fix global-buffer-overflow issue

The array str[] should have six elements.

  =================================================================
  ==4322==ERROR: AddressSanitizer: global-buffer-overflow on address 0x56463844e300 at pc 0x564637e7ad0d bp 0x7f30c8c89d10 sp 0x7f30c8c89d00
  READ of size 8 at 0x56463844e300 thread T9
      #0 0x564637e7ad0c in __ordered_events__flush util/ordered-events.c:316
      #1 0x564637e7b0e4 in ordered_events__flush util/ordered-events.c:338
      #2 0x564637c6a57d in process_thread /home/changbin/work/linux/tools/perf/builtin-top.c:1073
      #3 0x7f30d173a163 in start_thread (/lib/x86_64-linux-gnu/libpthread.so.0+0x8163)
      #4 0x7f30cfffbdee in __clone (/lib/x86_64-linux-gnu/libc.so.6+0x11adee)

  0x56463844e300 is located 32 bytes to the left of global variable 'flags' defined in 'util/trace-event-parse.c:229:26' (0x56463844e320) of size 192
  0x56463844e300 is located 0 bytes to the right of global variable 'str' defined in 'util/ordered-events.c:268:28' (0x56463844e2e0) of size 32
  SUMMARY: AddressSanitizer: global-buffer-overflow util/ordered-events.c:316 in __ordered_events__flush
  Shadow bytes around the buggy address:
    0x0ac947081c10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
    0x0ac947081c20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
    0x0ac947081c30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
    0x0ac947081c40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
    0x0ac947081c50: 00 00 00 00 00 00 00 00 f9 f9 f9 f9 00 00 00 00
  =>0x0ac947081c60:[f9]f9 f9 f9 00 00 00 00 00 00 00 00 00 00 00 00
    0x0ac947081c70: 00 00 00 00 00 00 00 00 00 00 00 00 f9 f9 f9 f9
    0x0ac947081c80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
    0x0ac947081c90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
    0x0ac947081ca0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
    0x0ac947081cb0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  Shadow byte legend (one shadow byte represents 8 application bytes):
    Addressable:           00
    Partially addressable: 01 02 03 04 05 06 07
    Heap left redzone:       fa
    Freed heap region:       fd
    Stack left redzone:      f1
    Stack mid redzone:       f2
    Stack right redzone:     f3
    Stack after return:      f5
    Stack use after scope:   f8
    Global redzone:          f9
    Global init order:       f6
    Poisoned by user:        f7
    Container overflow:      fc
    Array cookie:            ac
    Intra object redzone:    bb
    ASan internal:           fe
    Left alloca redzone:     ca
    Right alloca redzone:    cb
  Thread T9 created by T0 here:
      #0 0x7f30d179de5f in __interceptor_pthread_create (/usr/lib/x86_64-linux-gnu/libasan.so.5+0x4ae5f)
      #1 0x564637c6b954 in __cmd_top /home/changbin/work/linux/tools/perf/builtin-top.c:1253
      #2 0x564637c7173c in cmd_top /home/changbin/work/linux/tools/perf/builtin-top.c:1642
      #3 0x564637d85038 in run_builtin /home/changbin/work/linux/tools/perf/perf.c:302
      #4 0x564637d85577 in handle_internal_command /home/changbin/work/linux/tools/perf/perf.c:354
      #5 0x564637d8597b in run_argv /home/changbin/work/linux/tools/perf/perf.c:398
      #6 0x564637d860e9 in main /home/changbin/work/linux/tools/perf/perf.c:520
      #7 0x7f30cff0509a in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.6+0x2409a)

Signed-off-by: Changbin Du <changbin.du@gmail.com>
Reviewed-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt (VMware) <rostedt@goodmis.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Fixes: 16c66bc167cc ("perf top: Add processing thread")
Fixes: 68ca5d07de20 ("perf ordered_events: Add ordered_events__flush_time interface")
Link: http://lkml.kernel.org/r/20190316080556.3075-13-changbin.du@gmail.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/ordered-events.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/util/ordered-events.c b/tools/perf/util/ordered-events.c
index ea523d3b248f..989fed6f43b5 100644
--- a/tools/perf/util/ordered-events.c
+++ b/tools/perf/util/ordered-events.c
@@ -270,6 +270,8 @@ static int __ordered_events__flush(struct ordered_events *oe, enum oe_flush how,
 		"FINAL",
 		"ROUND",
 		"HALF ",
+		"TOP  ",
+		"TIME ",
 	};
 	int err;
 	bool show_progress = false;
