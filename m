Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97765C31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 19:40:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B2AD2084B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 19:40:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="kq8JoTIC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728923AbfFQTkv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 15:40:51 -0400
Received: from terminus.zytor.com ([198.137.202.136]:46941 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726151AbfFQTku (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 15:40:50 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5HJdbxY3566604
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 17 Jun 2019 12:39:37 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5HJdbxY3566604
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1560800378;
        bh=NpW/oj2lgQpLIAQHUqih4c4oiFhtvOwEwDNe6HeRyDY=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=kq8JoTICKzx3fujW6U0MTpIldIgGWHGZFk9ykue56cCQ7jP5Xeq1Ts9hSSTz7ZG4r
         A+wC4Mmcbw+JEZ63NdqioNNZrp0l1uJU/7M3l7aMyGMLuEoyiXgHyfoIY4hU/9gapy
         Wf8T+pknrPlZjMKDMkSryKvb/wjli5X7MLlHqeTTmpHJRKZx2Bj9VehbS3VUE2P11T
         bDoG8mAhVnK0ziqZCgpxPPb8B/Ld7RkWdi2uYzh/UYDOXG8/NfgBNDIJVWytaacFg3
         EqxyK8PXinTEL98vjJJjAAH2miefVFlSW1tB2qPyZfQw607gHt01SMnuYjXiN2xSNQ
         fe675l/DEUkww==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5HJdbul3566601;
        Mon, 17 Jun 2019 12:39:37 -0700
Date:   Mon, 17 Jun 2019 12:39:37 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Adrian Hunter <tipbot@zytor.com>
Message-ID: <tip-4885c90c5e84926cfb083c58d8b6d70d1b1ac7cf@git.kernel.org>
Cc:     yao.jin@linux.intel.com, adrian.hunter@intel.com, acme@redhat.com,
        mingo@kernel.org, hpa@zytor.com, tglx@linutronix.de,
        jolsa@redhat.com, linux-kernel@vger.kernel.org
Reply-To: acme@redhat.com, yao.jin@linux.intel.com,
          adrian.hunter@intel.com, jolsa@redhat.com, tglx@linutronix.de,
          linux-kernel@vger.kernel.org, hpa@zytor.com, mingo@kernel.org
In-Reply-To: <20190604130017.31207-4-adrian.hunter@intel.com>
References: <20190604130017.31207-4-adrian.hunter@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf report: Set perf time interval in
 itrace_synth_ops
Git-Commit-ID: 4885c90c5e84926cfb083c58d8b6d70d1b1ac7cf
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

Commit-ID:  4885c90c5e84926cfb083c58d8b6d70d1b1ac7cf
Gitweb:     https://git.kernel.org/tip/4885c90c5e84926cfb083c58d8b6d70d1b1ac7cf
Author:     Adrian Hunter <adrian.hunter@intel.com>
AuthorDate: Tue, 4 Jun 2019 16:00:01 +0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 10 Jun 2019 16:20:12 -0300

perf report: Set perf time interval in itrace_synth_ops

Instruction trace decoders can optimize output based on what time
intervals will be filtered, so pass that information in
itrace_synth_ops.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20190604130017.31207-4-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-report.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 1ca533f06a4c..91c40808380d 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -1428,6 +1428,10 @@ repeat:
 						  &report.range_num);
 		if (ret < 0)
 			goto error;
+
+		itrace_synth_opts__set_time_range(&itrace_synth_opts,
+						  report.ptime_range,
+						  report.range_num);
 	}
 
 	if (session->tevent.pevent &&
@@ -1449,8 +1453,10 @@ repeat:
 		ret = 0;
 
 error:
-	if (report.ptime_range)
+	if (report.ptime_range) {
+		itrace_synth_opts__clear_time_range(&itrace_synth_opts);
 		zfree(&report.ptime_range);
+	}
 	zstd_fini(&(session->zstd_data));
 	perf_session__delete(session);
 	return ret;
