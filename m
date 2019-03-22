Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41096C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 22:26:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14082218B0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 22:26:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728107AbfCVW0Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 18:26:24 -0400
Received: from terminus.zytor.com ([198.137.202.136]:43481 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726205AbfCVW0Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 18:26:24 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x2MMPRUx752717
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 22 Mar 2019 15:25:27 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x2MMPRbR752714;
        Fri, 22 Mar 2019 15:25:27 -0700
Date:   Fri, 22 Mar 2019 15:25:27 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Changbin Du <tipbot@zytor.com>
Message-ID: <tip-39df730b09774bd860e39ea208a48d15078236cb@git.kernel.org>
Cc:     acme@redhat.com, rostedt@goodmis.org, tglx@linutronix.de,
        changbin.du@gmail.com, hpa@zytor.com, namhyung@kernel.org,
        mingo@kernel.org, daniel@iogearbox.net, jolsa@kernel.org,
        ast@kernel.org, peterz@infradead.org, linux-kernel@vger.kernel.org
Reply-To: linux-kernel@vger.kernel.org, peterz@infradead.org,
          jolsa@kernel.org, daniel@iogearbox.net, ast@kernel.org,
          mingo@kernel.org, hpa@zytor.com, namhyung@kernel.org,
          changbin.du@gmail.com, acme@redhat.com, rostedt@goodmis.org,
          tglx@linutronix.de
In-Reply-To: <20190316080556.3075-3-changbin.du@gmail.com>
References: <20190316080556.3075-3-changbin.du@gmail.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf list: Don't forget to drop the reference to
 the allocated thread_map
Git-Commit-ID: 39df730b09774bd860e39ea208a48d15078236cb
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

Commit-ID:  39df730b09774bd860e39ea208a48d15078236cb
Gitweb:     https://git.kernel.org/tip/39df730b09774bd860e39ea208a48d15078236cb
Author:     Changbin Du <changbin.du@gmail.com>
AuthorDate: Sat, 16 Mar 2019 16:05:42 +0800
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 19 Mar 2019 16:52:04 -0300

perf list: Don't forget to drop the reference to the allocated thread_map

Detected via gcc's ASan:

  Direct leak of 2048 byte(s) in 64 object(s) allocated from:
    6     #0 0x7f606512e370 in __interceptor_realloc (/usr/lib/x86_64-linux-gnu/libasan.so.5+0xee370)
    7     #1 0x556b0f1d7ddd in thread_map__realloc util/thread_map.c:43
    8     #2 0x556b0f1d84c7 in thread_map__new_by_tid util/thread_map.c:85
    9     #3 0x556b0f0e045e in is_event_supported util/parse-events.c:2250
   10     #4 0x556b0f0e1aa1 in print_hwcache_events util/parse-events.c:2382
   11     #5 0x556b0f0e3231 in print_events util/parse-events.c:2514
   12     #6 0x556b0ee0a66e in cmd_list /home/changbin/work/linux/tools/perf/builtin-list.c:58
   13     #7 0x556b0f01e0ae in run_builtin /home/changbin/work/linux/tools/perf/perf.c:302
   14     #8 0x556b0f01e859 in handle_internal_command /home/changbin/work/linux/tools/perf/perf.c:354
   15     #9 0x556b0f01edc8 in run_argv /home/changbin/work/linux/tools/perf/perf.c:398
   16     #10 0x556b0f01f71f in main /home/changbin/work/linux/tools/perf/perf.c:520
   17     #11 0x7f6062ccf09a in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.6+0x2409a)

Signed-off-by: Changbin Du <changbin.du@gmail.com>
Reviewed-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt (VMware) <rostedt@goodmis.org>
Fixes: 89896051f8da ("perf tools: Do not put a variable sized type not at the end of a struct")
Link: http://lkml.kernel.org/r/20190316080556.3075-3-changbin.du@gmail.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/parse-events.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 4dcc01b2532c..2e9035c4c252 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -2271,6 +2271,7 @@ static bool is_event_supported(u8 type, unsigned config)
 		perf_evsel__delete(evsel);
 	}
 
+	thread_map__put(tmap);
 	return ret;
 }
 
