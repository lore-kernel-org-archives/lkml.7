Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CD61C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 11:48:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06F9821872
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 11:48:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730424AbfDELsI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 07:48:08 -0400
Received: from terminus.zytor.com ([198.137.202.136]:33321 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726124AbfDELsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 07:48:08 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x35BlifO2737414
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 5 Apr 2019 04:47:44 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x35BlixN2737411;
        Fri, 5 Apr 2019 04:47:44 -0700
Date:   Fri, 5 Apr 2019 04:47:44 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Tzvetomir Stoyanov <tipbot@zytor.com>
Message-ID: <tip-fea6b632235b9bedc58c72cd24f1865bb0c365db@git.kernel.org>
Cc:     tglx@linutronix.de, acme@redhat.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, mingo@kernel.org,
        namhyung@kernel.org, tstoyanov@vmware.com, jolsa@redhat.com,
        hpa@zytor.com, rostedt@goodmis.org
Reply-To: namhyung@kernel.org, jolsa@redhat.com, tstoyanov@vmware.com,
          hpa@zytor.com, rostedt@goodmis.org, acme@redhat.com,
          tglx@linutronix.de, akpm@linux-foundation.org,
          linux-kernel@vger.kernel.org, mingo@kernel.org
In-Reply-To: <20190401164344.121717482@goodmis.org>
References: <20190326154328.28718-9-tstoyanov@vmware.com>
        <20190401164344.121717482@goodmis.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] tools lib traceevent: Remove call to exit() from
 tep_filter_add_filter_str()
Git-Commit-ID: fea6b632235b9bedc58c72cd24f1865bb0c365db
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

Commit-ID:  fea6b632235b9bedc58c72cd24f1865bb0c365db
Gitweb:     https://git.kernel.org/tip/fea6b632235b9bedc58c72cd24f1865bb0c365db
Author:     Tzvetomir Stoyanov <tstoyanov@vmware.com>
AuthorDate: Mon, 1 Apr 2019 12:43:15 -0400
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 1 Apr 2019 15:18:09 -0300

tools lib traceevent: Remove call to exit() from tep_filter_add_filter_str()

This patch removes call to exit() from tep_filter_add_filter_str(). A
library function should not force the application to exit. In the
current implementation tep_filter_add_filter_str() calls exit() when a
special "test_filters" mode is set, used only for debugging purposes.
When this mode is set and a filter is added - its string is printed to
the console and exit() is called. This patch changes the logic - when in
"test_filters" mode, the filter string is still printed, but the exit()
is not called. It is up to the application to track when "test_filters"
mode is set and to call exit, if needed.

Signed-off-by: Tzvetomir Stoyanov <tstoyanov@vmware.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: http://lkml.kernel.org/r/20190326154328.28718-9-tstoyanov@vmware.com
Link: http://lkml.kernel.org/r/20190401164344.121717482@goodmis.org
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/lib/traceevent/parse-filter.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/tools/lib/traceevent/parse-filter.c b/tools/lib/traceevent/parse-filter.c
index 4ffd8b25a852..3320c0a0e343 100644
--- a/tools/lib/traceevent/parse-filter.c
+++ b/tools/lib/traceevent/parse-filter.c
@@ -1346,9 +1346,6 @@ enum tep_errno tep_filter_add_filter_str(struct tep_event_filter *filter,
 
 	free_events(events);
 
-	if (rtn >= 0 && pevent->test_filters)
-		exit(0);
-
 	return rtn;
 }
 
