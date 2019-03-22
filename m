Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BECCC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 22:28:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3234218D4
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 22:28:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728070AbfCVW2w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 18:28:52 -0400
Received: from terminus.zytor.com ([198.137.202.136]:42229 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726205AbfCVW2v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 18:28:51 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x2MMS0nl753183
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 22 Mar 2019 15:28:00 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x2MMRxBD753179;
        Fri, 22 Mar 2019 15:27:59 -0700
Date:   Fri, 22 Mar 2019 15:27:59 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Changbin Du <tipbot@zytor.com>
Message-ID: <tip-8bde8516893da5a5fdf06121f74d11b52ab92df5@git.kernel.org>
Cc:     acme@redhat.com, jolsa@kernel.org, changbin.du@gmail.com,
        namhyung@kernel.org, peterz@infradead.org, rostedt@goodmis.org,
        masami.hiramatsu.pt@hitachi.com, hpa@zytor.com, ast@kernel.org,
        tglx@linutronix.de, mingo@kernel.org, daniel@iogearbox.net,
        linux-kernel@vger.kernel.org
Reply-To: mingo@kernel.org, linux-kernel@vger.kernel.org,
          daniel@iogearbox.net, jolsa@kernel.org, acme@redhat.com,
          changbin.du@gmail.com, peterz@infradead.org, namhyung@kernel.org,
          rostedt@goodmis.org, masami.hiramatsu.pt@hitachi.com,
          hpa@zytor.com, ast@kernel.org, tglx@linutronix.de
In-Reply-To: <20190316080556.3075-7-changbin.du@gmail.com>
References: <20190316080556.3075-7-changbin.du@gmail.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf build-id: Fix memory leak in
 print_sdt_events()
Git-Commit-ID: 8bde8516893da5a5fdf06121f74d11b52ab92df5
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

Commit-ID:  8bde8516893da5a5fdf06121f74d11b52ab92df5
Gitweb:     https://git.kernel.org/tip/8bde8516893da5a5fdf06121f74d11b52ab92df5
Author:     Changbin Du <changbin.du@gmail.com>
AuthorDate: Sat, 16 Mar 2019 16:05:46 +0800
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 19 Mar 2019 16:52:04 -0300

perf build-id: Fix memory leak in print_sdt_events()

Detected with gcc's ASan:

  Direct leak of 4356 byte(s) in 120 object(s) allocated from:
      #0 0x7ff1a2b5a070 in __interceptor_strdup (/usr/lib/x86_64-linux-gnu/libasan.so.5+0x3b070)
      #1 0x55719aef4814 in build_id_cache__origname util/build-id.c:215
      #2 0x55719af649b6 in print_sdt_events util/parse-events.c:2339
      #3 0x55719af66272 in print_events util/parse-events.c:2542
      #4 0x55719ad1ecaa in cmd_list /home/changbin/work/linux/tools/perf/builtin-list.c:58
      #5 0x55719aec745d in run_builtin /home/changbin/work/linux/tools/perf/perf.c:302
      #6 0x55719aec7d1a in handle_internal_command /home/changbin/work/linux/tools/perf/perf.c:354
      #7 0x55719aec8184 in run_argv /home/changbin/work/linux/tools/perf/perf.c:398
      #8 0x55719aeca41a in main /home/changbin/work/linux/tools/perf/perf.c:520
      #9 0x7ff1a07ae09a in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.6+0x2409a)

Signed-off-by: Changbin Du <changbin.du@gmail.com>
Reviewed-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt (VMware) <rostedt@goodmis.org>
Fixes: 40218daea1db ("perf list: Show SDT and pre-cached events")
Link: http://lkml.kernel.org/r/20190316080556.3075-7-changbin.du@gmail.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/build-id.c     | 1 +
 tools/perf/util/parse-events.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/tools/perf/util/build-id.c b/tools/perf/util/build-id.c
index bff0d17920ed..0c5517a8d0b7 100644
--- a/tools/perf/util/build-id.c
+++ b/tools/perf/util/build-id.c
@@ -185,6 +185,7 @@ char *build_id_cache__linkname(const char *sbuild_id, char *bf, size_t size)
 	return bf;
 }
 
+/* The caller is responsible to free the returned buffer. */
 char *build_id_cache__origname(const char *sbuild_id)
 {
 	char *linkname;
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 2e9035c4c252..5ef4939408f2 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -2342,6 +2342,7 @@ void print_sdt_events(const char *subsys_glob, const char *event_glob,
 				printf("  %-50s [%s]\n", buf, "SDT event");
 				free(buf);
 			}
+			free(path);
 		} else
 			printf("  %-50s [%s]\n", nd->s, "SDT event");
 		if (nd2) {
