Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 775F6C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 07:46:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 501E321850
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 07:46:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731742AbfB1Hq1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 02:46:27 -0500
Received: from terminus.zytor.com ([198.137.202.136]:48323 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725967AbfB1Hq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 02:46:27 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x1S7jGvf2950093
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 27 Feb 2019 23:45:16 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x1S7jGcp2950090;
        Wed, 27 Feb 2019 23:45:16 -0800
Date:   Wed, 27 Feb 2019 23:45:16 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-6e7e8b9fec45f7bef11a5d9d2dd9febe439d4047@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, alexander.shishkin@linux.intel.com,
        mingo@kernel.org, hpa@zytor.com, namhyung@kernel.org,
        acme@redhat.com, tglx@linutronix.de, peterz@infradead.org,
        jolsa@kernel.org, ak@linux.intel.com
Reply-To: linux-kernel@vger.kernel.org, alexander.shishkin@linux.intel.com,
          mingo@kernel.org, acme@redhat.com, namhyung@kernel.org,
          hpa@zytor.com, jolsa@kernel.org, ak@linux.intel.com,
          peterz@infradead.org, tglx@linutronix.de
In-Reply-To: <20190220122800.864-3-jolsa@kernel.org>
References: <20190220122800.864-3-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf evsel: Force sample_type for slave events
Git-Commit-ID: 6e7e8b9fec45f7bef11a5d9d2dd9febe439d4047
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

Commit-ID:  6e7e8b9fec45f7bef11a5d9d2dd9febe439d4047
Gitweb:     https://git.kernel.org/tip/6e7e8b9fec45f7bef11a5d9d2dd9febe439d4047
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Wed, 20 Feb 2019 13:27:56 +0100
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 20 Feb 2019 16:08:59 -0300

perf evsel: Force sample_type for slave events

Force sample_type setup for slave events in group leader sessions.

We don't get sample for slave events, we make them when delivering group
leader sample. Set the slave event to follow the master sample_type to
ease up report.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190220122800.864-3-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/evsel.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 684c893ca6bc..dfe2958e6287 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -956,6 +956,14 @@ void perf_evsel__config(struct perf_evsel *evsel, struct record_opts *opts,
 		attr->sample_freq    = 0;
 		attr->sample_period  = 0;
 		attr->write_backward = 0;
+
+		/*
+		 * We don't get sample for slave events, we make them
+		 * when delivering group leader sample. Set the slave
+		 * event to follow the master sample_type to ease up
+		 * report.
+		 */
+		attr->sample_type = leader->attr.sample_type;
 	}
 
 	if (opts->no_samples)
