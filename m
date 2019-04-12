Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 057C0C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 16:39:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D32982077C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 16:39:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727006AbfDLQjD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 12:39:03 -0400
Received: from terminus.zytor.com ([198.137.202.136]:57341 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726624AbfDLQjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 12:39:03 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3CGcqQ81752936
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 12 Apr 2019 09:38:52 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3CGcqeg1752933;
        Fri, 12 Apr 2019 09:38:52 -0700
Date:   Fri, 12 Apr 2019 09:38:52 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-d2d0aef9277a7e9e110545552b48b8f523ac62a4@git.kernel.org>
Cc:     hpa@zytor.com, linux-kernel@vger.kernel.org, peterz@infradead.org,
        namhyung@kernel.org, tglx@linutronix.de,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        acme@redhat.com, mingo@kernel.org
Reply-To: tglx@linutronix.de, namhyung@kernel.org, mingo@kernel.org,
          jolsa@kernel.org, acme@redhat.com,
          alexander.shishkin@linux.intel.com, linux-kernel@vger.kernel.org,
          hpa@zytor.com, peterz@infradead.org
In-Reply-To: <20190409100156.20303-1-jolsa@kernel.org>
References: <20190409100156.20303-1-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf stat: Disable DIR_FORMAT feature for 'perf
 stat record'
Git-Commit-ID: d2d0aef9277a7e9e110545552b48b8f523ac62a4
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

Commit-ID:  d2d0aef9277a7e9e110545552b48b8f523ac62a4
Gitweb:     https://git.kernel.org/tip/d2d0aef9277a7e9e110545552b48b8f523ac62a4
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Tue, 9 Apr 2019 12:01:56 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 9 Apr 2019 10:17:34 -0300

perf stat: Disable DIR_FORMAT feature for 'perf stat record'

Arnaldo reported assertion in perf stat record:

  assertion failed at util/header.c:875

There's no support for this in the 'perf state record' command, disable
the feature for that case.

Reported-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Fixes: 258031c017c3 ("perf header: Add DIR_FORMAT feature to describe directory data")
Link: http://lkml.kernel.org/r/20190409100156.20303-1-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-stat.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 49ee3c2033ec..c3625ec374e0 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -1308,6 +1308,7 @@ static void init_features(struct perf_session *session)
 	for (feat = HEADER_FIRST_FEATURE; feat < HEADER_LAST_FEATURE; feat++)
 		perf_header__set_feat(&session->header, feat);
 
+	perf_header__clear_feat(&session->header, HEADER_DIR_FORMAT);
 	perf_header__clear_feat(&session->header, HEADER_BUILD_ID);
 	perf_header__clear_feat(&session->header, HEADER_TRACING_DATA);
 	perf_header__clear_feat(&session->header, HEADER_BRANCH_STACK);
