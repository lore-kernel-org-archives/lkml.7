Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47772C0650F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 20:19:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17F582173E
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 20:19:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="GyFq/1P/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404715AbfHHUTf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 16:19:35 -0400
Received: from terminus.zytor.com ([198.137.202.136]:44911 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404590AbfHHUTf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 16:19:35 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x78KJLJD3321297
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 8 Aug 2019 13:19:21 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x78KJLJD3321297
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1565295561;
        bh=rdLSYTltPvgVpgyaIOKiiracGRusZLtBYcxcQ7fm2V8=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=GyFq/1P/T5PH3rG6NsY5SGXkEL0fbvHNlIksWDeuTaHCAbPMVkx9K2OfdtTUEJ8HG
         Wzc/D+rarV2r/hzxmLvQQWXhkzrj9p3wOBspmPotqzDMSZl1h8+OkePVrZvEY+1B7f
         qMOfhiy5o2TkpfbqbJ8VeDtyq+xFBZeIE3mVAiVBPx12HVOtlkN438smH2ubGA5bea
         ajqon4KQo1UMVTxzCl95mVgqvB+cAt87S3NgWgvHWt50naJFPF97wmTNdK3/zMpfNQ
         iGbtcPY5PEKh230rC+fvVNG4iClZT/nSO9UrCDVnHlDEx2XBVatew8DJKu97VWLVbi
         40QgdEjPxwZjQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x78KJKPh3321280;
        Thu, 8 Aug 2019 13:19:20 -0700
Date:   Thu, 8 Aug 2019 13:19:20 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for He Zhe <tipbot@zytor.com>
Message-ID: <tip-5f5e25f1c7933a6e1673515c0b1d5acd82fea1ed@git.kernel.org>
Cc:     namhyung@kernel.org, alexey.budankov@linux.intel.com,
        zhe.he@windriver.com, hpa@zytor.com, acme@redhat.com,
        peterz@infradead.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org, alexander.shishkin@linux.intel.com,
        eranian@google.com, kan.liang@linux.intel.com, jolsa@redhat.com,
        tglx@linutronix.de
Reply-To: alexander.shishkin@linux.intel.com, eranian@google.com,
          kan.liang@linux.intel.com, jolsa@redhat.com, tglx@linutronix.de,
          hpa@zytor.com, acme@redhat.com, peterz@infradead.org,
          mingo@kernel.org, linux-kernel@vger.kernel.org,
          zhe.he@windriver.com, namhyung@kernel.org,
          alexey.budankov@linux.intel.com
In-Reply-To: <1564734592-15624-2-git-send-email-zhe.he@windriver.com>
References: <1564734592-15624-2-git-send-email-zhe.he@windriver.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf cpumap: Fix writing to illegal memory in
 handling cpumap mask
Git-Commit-ID: 5f5e25f1c7933a6e1673515c0b1d5acd82fea1ed
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

Commit-ID:  5f5e25f1c7933a6e1673515c0b1d5acd82fea1ed
Gitweb:     https://git.kernel.org/tip/5f5e25f1c7933a6e1673515c0b1d5acd82fea1ed
Author:     He Zhe <zhe.he@windriver.com>
AuthorDate: Fri, 2 Aug 2019 16:29:52 +0800
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 8 Aug 2019 15:41:10 -0300

perf cpumap: Fix writing to illegal memory in handling cpumap mask

cpu_map__snprint_mask() would write to illegal memory pointed by
zalloc(0) when there is only one cpu.

This patch fixes the calculation and adds sanity check against the input
parameters.

Signed-off-by: He Zhe <zhe.he@windriver.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Fixes: 4400ac8a9a90 ("perf cpumap: Introduce cpu_map__snprint_mask()")
Link: http://lkml.kernel.org/r/1564734592-15624-2-git-send-email-zhe.he@windriver.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/cpumap.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/cpumap.c b/tools/perf/util/cpumap.c
index 3acfbe34ebaf..39cce66b4ebc 100644
--- a/tools/perf/util/cpumap.c
+++ b/tools/perf/util/cpumap.c
@@ -751,7 +751,10 @@ size_t cpu_map__snprint_mask(struct cpu_map *map, char *buf, size_t size)
 	unsigned char *bitmap;
 	int last_cpu = cpu_map__cpu(map, map->nr - 1);
 
-	bitmap = zalloc((last_cpu + 7) / 8);
+	if (buf == NULL)
+		return 0;
+
+	bitmap = zalloc(last_cpu / 8 + 1);
 	if (bitmap == NULL) {
 		buf[0] = '\0';
 		return 0;
