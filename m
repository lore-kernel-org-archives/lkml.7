Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34A89C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 07:44:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03B7321850
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 07:44:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731599AbfB1Hos (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 02:44:48 -0500
Received: from terminus.zytor.com ([198.137.202.136]:56891 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725973AbfB1Hos (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 02:44:48 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x1S7ib8B2949822
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 27 Feb 2019 23:44:37 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x1S7iaeB2949817;
        Wed, 27 Feb 2019 23:44:36 -0800
Date:   Wed, 27 Feb 2019 23:44:36 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-529c1a9e18c3b470d2eff7879923eda40b1431db@git.kernel.org>
Cc:     hpa@zytor.com, peterz@infradead.org, ak@linux.intel.com,
        jolsa@kernel.org, acme@redhat.com, mingo@kernel.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        alexander.shishkin@linux.intel.com, namhyung@kernel.org
Reply-To: hpa@zytor.com, peterz@infradead.org, ak@linux.intel.com,
          jolsa@kernel.org, acme@redhat.com, mingo@kernel.org,
          alexander.shishkin@linux.intel.com, linux-kernel@vger.kernel.org,
          tglx@linutronix.de, namhyung@kernel.org
In-Reply-To: <20190220122800.864-2-jolsa@kernel.org>
References: <20190220122800.864-2-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf session: Don't report zero period samples for
 slave events
Git-Commit-ID: 529c1a9e18c3b470d2eff7879923eda40b1431db
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

Commit-ID:  529c1a9e18c3b470d2eff7879923eda40b1431db
Gitweb:     https://git.kernel.org/tip/529c1a9e18c3b470d2eff7879923eda40b1431db
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Wed, 20 Feb 2019 13:27:55 +0100
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 20 Feb 2019 16:07:51 -0300

perf session: Don't report zero period samples for slave events

There's no reason to deliver a sample with zero period.  It means there
was no value for slave event since its last group leader sample.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190220122800.864-2-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/session.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 18fb9c8cbf9c..c764bbc91009 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1202,6 +1202,13 @@ static int deliver_sample_value(struct perf_evlist *evlist,
 		return 0;
 	}
 
+	/*
+	 * There's no reason to deliver sample
+	 * for zero period, bail out.
+	 */
+	if (!sample->period)
+		return 0;
+
 	return tool->sample(tool, event, sample, sid->evsel, machine);
 }
 
