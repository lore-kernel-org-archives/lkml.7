Return-Path: <SRS0=//ty=TS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CE83C04AAF
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 09:26:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09E0920872
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 09:26:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="IFM4m5wN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729926AbfERJ0G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 May 2019 05:26:06 -0400
Received: from terminus.zytor.com ([198.137.202.136]:42335 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725268AbfERJ0F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 May 2019 05:26:05 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x4I9PsAQ1741268
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 18 May 2019 02:25:54 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x4I9PsAQ1741268
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1558171555;
        bh=p8hGlLyY5wcMoY8I+WtQuDpq4NxU2FyKw+//UsXP2uk=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=IFM4m5wNRTNLZEB49wLcBOBO125af0unSP8WpCrTCRLNL8geFLBoIcUAQtBAB975D
         tYdwEhYb4cm94VhsmReUSahQjJ13ZZvGbdwNWPFSPpk3W+zSz+ejwQdHz/tEfqF0jN
         f+dSjqzc7ZhAubP1h8FK/I0LWbs33iksDaIIyhSV7wr2N04ldIBiTnT/dsOH395/W1
         08TeFLh0NHaQFYtEk83ZnNf2GP8vddYACHetlT9ByjC6xVcqt/IkqoP1GDGlZccx96
         KLq1U50nkG81rdlgacPAf81kO5+bRspSJoET3QzMlnkUNChBcLB2dCSjfjS4fVx26o
         zidQSS6b+CArQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x4I9Pr2T1741265;
        Sat, 18 May 2019 02:25:53 -0700
Date:   Sat, 18 May 2019 02:25:53 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Alexey Budankov <tipbot@zytor.com>
Message-ID: <tip-371a3378d83a755add84b2dca730a3a641002f3a@git.kernel.org>
Cc:     jolsa@kernel.org, peterz@infradead.org, acme@redhat.com,
        hpa@zytor.com, ak@linux.intel.com, mingo@kernel.org,
        alexander.shishkin@linux.intel.com, linux-kernel@vger.kernel.org,
        alexey.budankov@linux.intel.com, tglx@linutronix.de,
        namhyung@kernel.org
Reply-To: namhyung@kernel.org, linux-kernel@vger.kernel.org,
          alexander.shishkin@linux.intel.com, mingo@kernel.org,
          alexey.budankov@linux.intel.com, tglx@linutronix.de,
          ak@linux.intel.com, peterz@infradead.org, jolsa@kernel.org,
          hpa@zytor.com, acme@redhat.com
In-Reply-To: <c27d7500-ecdd-3569-cab5-8f70bbed5ea4@linux.intel.com>
References: <c27d7500-ecdd-3569-cab5-8f70bbed5ea4@linux.intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf inject: Enable COMPRESSED record decompression
Git-Commit-ID: 371a3378d83a755add84b2dca730a3a641002f3a
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

Commit-ID:  371a3378d83a755add84b2dca730a3a641002f3a
Gitweb:     https://git.kernel.org/tip/371a3378d83a755add84b2dca730a3a641002f3a
Author:     Alexey Budankov <alexey.budankov@linux.intel.com>
AuthorDate: Mon, 18 Mar 2019 20:45:44 +0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 15 May 2019 16:36:49 -0300

perf inject: Enable COMPRESSED record decompression

Initialized decompression part of Zstd based API so COMPRESSED records
would be decompressed into the resulting output data file.

Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
Reviewed-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/c27d7500-ecdd-3569-cab5-8f70bbed5ea4@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-inject.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index 24086b7f1b14..8e0e06d3edfc 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -837,6 +837,9 @@ int cmd_inject(int argc, const char **argv)
 	if (inject.session == NULL)
 		return -1;
 
+	if (zstd_init(&(inject.session->zstd_data), 0) < 0)
+		pr_warning("Decompression initialization failed.\n");
+
 	if (inject.build_ids) {
 		/*
 		 * to make sure the mmap records are ordered correctly
@@ -867,6 +870,7 @@ int cmd_inject(int argc, const char **argv)
 	ret = __cmd_inject(&inject);
 
 out_delete:
+	zstd_fini(&(inject.session->zstd_data));
 	perf_session__delete(inject.session);
 	return ret;
 }
