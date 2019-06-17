Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3152DC31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 19:49:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F37A3208C0
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 19:49:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="Md8Q0ir9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728381AbfFQTth (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 15:49:37 -0400
Received: from terminus.zytor.com ([198.137.202.136]:60685 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbfFQTth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 15:49:37 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5HJnLtR3570127
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 17 Jun 2019 12:49:21 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5HJnLtR3570127
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1560800961;
        bh=o72oEHSogqN+xw5BWRHuXKpRZyGSpztWBzpFqIFU//k=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=Md8Q0ir9/G8Z3c9o6zoEsJYsYKKQvC9MfMrPPGmdtuyk5Dru2k4MWeFP/OLdF9GO9
         0RRCUCXWFTiJpPmDh2x4sM+VqRshBFAHVAuuI5c1GNleyH76HitEh3TDsEKnbzaKtU
         mbMNHDRYe56UcOjzExsRLm1c8Lx2+UYLacTx3edXBJyU3nPSVXvOgRsZJ8D/N04x+L
         eCnBeT6VTJOIhSAQS4sfeNaRdXsN9w53eG44wyZSxNLKkhbgfsZmulr61yEh+xxK1+
         XD60k/cp6uCZzNrupIO4hpdoykqK4Wy/fM40bqE+qEuGARLG1IqLioL5J/OqXHGJgk
         1jnxJcV9rxMsw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5HJnKN53570124;
        Mon, 17 Jun 2019 12:49:20 -0700
Date:   Mon, 17 Jun 2019 12:49:20 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Adrian Hunter <tipbot@zytor.com>
Message-ID: <tip-929afa0092d0ea6be2fbd0ac087319092595eba6@git.kernel.org>
Cc:     adrian.hunter@intel.com, hpa@zytor.com, mingo@kernel.org,
        linux-kernel@vger.kernel.org, acme@redhat.com, tglx@linutronix.de,
        yao.jin@linux.intel.com, jolsa@redhat.com
Reply-To: linux-kernel@vger.kernel.org, yao.jin@linux.intel.com,
          tglx@linutronix.de, acme@redhat.com, mingo@kernel.org,
          jolsa@redhat.com, adrian.hunter@intel.com, hpa@zytor.com
In-Reply-To: <20190604130017.31207-18-adrian.hunter@intel.com>
References: <20190604130017.31207-18-adrian.hunter@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf time-utils: Make perf_time__parse_for_ranges()
 more logical
Git-Commit-ID: 929afa0092d0ea6be2fbd0ac087319092595eba6
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

Commit-ID:  929afa0092d0ea6be2fbd0ac087319092595eba6
Gitweb:     https://git.kernel.org/tip/929afa0092d0ea6be2fbd0ac087319092595eba6
Author:     Adrian Hunter <adrian.hunter@intel.com>
AuthorDate: Tue, 4 Jun 2019 16:00:15 +0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 10 Jun 2019 16:20:12 -0300

perf time-utils: Make perf_time__parse_for_ranges() more logical

Explicit time ranges never contain a percent sign whereas percentage
ranges always do, so it is possible to call the correct parser.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20190604130017.31207-18-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/time-utils.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/time-utils.c b/tools/perf/util/time-utils.c
index 9a463752dba8..d942840356e3 100644
--- a/tools/perf/util/time-utils.c
+++ b/tools/perf/util/time-utils.c
@@ -402,6 +402,7 @@ int perf_time__parse_for_ranges(const char *time_str,
 				struct perf_time_interval **ranges,
 				int *range_size, int *range_num)
 {
+	bool has_percent = strchr(time_str, '%');
 	struct perf_time_interval *ptime_range;
 	int size, num, ret = -EINVAL;
 
@@ -409,7 +410,7 @@ int perf_time__parse_for_ranges(const char *time_str,
 	if (!ptime_range)
 		return -ENOMEM;
 
-	if (perf_time__parse_str(ptime_range, time_str) != 0) {
+	if (has_percent) {
 		if (session->evlist->first_sample_time == 0 &&
 		    session->evlist->last_sample_time == 0) {
 			pr_err("HINT: no first/last sample time found in perf data.\n"
@@ -427,6 +428,8 @@ int perf_time__parse_for_ranges(const char *time_str,
 		if (num < 0)
 			goto error_invalid;
 	} else {
+		if (perf_time__parse_str(ptime_range, time_str))
+			goto error_invalid;
 		num = 1;
 	}
 
