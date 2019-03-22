Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF4A4C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 22:30:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82D8621925
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 22:30:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728021AbfCVWa6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 18:30:58 -0400
Received: from terminus.zytor.com ([198.137.202.136]:49247 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726205AbfCVWa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 18:30:57 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x2MMTxWC753328
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 22 Mar 2019 15:29:59 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x2MMTwiV753325;
        Fri, 22 Mar 2019 15:29:58 -0700
Date:   Fri, 22 Mar 2019 15:29:58 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Changbin Du <tipbot@zytor.com>
Message-ID: <tip-cb6186aeffda4d27e56066c79e9579e7831541d3@git.kernel.org>
Cc:     namhyung@kernel.org, linux-kernel@vger.kernel.org,
        mingo@kernel.org, jolsa@kernel.org, changbin.du@gmail.com,
        peterz@infradead.org, rostedt@goodmis.org, daniel@iogearbox.net,
        ast@kernel.org, kjlx@templeofstupid.com, hpa@zytor.com,
        tglx@linutronix.de, acme@redhat.com
Reply-To: tglx@linutronix.de, hpa@zytor.com, acme@redhat.com,
          rostedt@goodmis.org, daniel@iogearbox.net, ast@kernel.org,
          kjlx@templeofstupid.com, changbin.du@gmail.com, jolsa@kernel.org,
          peterz@infradead.org, namhyung@kernel.org, mingo@kernel.org,
          linux-kernel@vger.kernel.org
In-Reply-To: <20190316080556.3075-10-changbin.du@gmail.com>
References: <20190316080556.3075-10-changbin.du@gmail.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf hist: Add missing map__put() in error case
Git-Commit-ID: cb6186aeffda4d27e56066c79e9579e7831541d3
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

Commit-ID:  cb6186aeffda4d27e56066c79e9579e7831541d3
Gitweb:     https://git.kernel.org/tip/cb6186aeffda4d27e56066c79e9579e7831541d3
Author:     Changbin Du <changbin.du@gmail.com>
AuthorDate: Sat, 16 Mar 2019 16:05:49 +0800
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 19 Mar 2019 16:52:04 -0300

perf hist: Add missing map__put() in error case

We need to map__put() before returning from failure of
sample__resolve_callchain().

Detected with gcc's ASan.

Signed-off-by: Changbin Du <changbin.du@gmail.com>
Reviewed-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Krister Johansen <kjlx@templeofstupid.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt (VMware) <rostedt@goodmis.org>
Fixes: 9c68ae98c6f7 ("perf callchain: Reference count maps")
Link: http://lkml.kernel.org/r/20190316080556.3075-10-changbin.du@gmail.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/hist.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index 1f230285d78a..7ace7a10054d 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -1111,8 +1111,10 @@ int hist_entry_iter__add(struct hist_entry_iter *iter, struct addr_location *al,
 
 	err = sample__resolve_callchain(iter->sample, &callchain_cursor, &iter->parent,
 					iter->evsel, al, max_stack_depth);
-	if (err)
+	if (err) {
+		map__put(alm);
 		return err;
+	}
 
 	err = iter->ops->prepare_entry(iter, al);
 	if (err)
