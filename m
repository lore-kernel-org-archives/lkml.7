Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86E7CC4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 18:59:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E3F921882
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 18:59:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560279582;
	bh=2xQ+rYH0eY0Das/QD86dhs/72bS8PeZ5h8R2EDanUFw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OZJt2GrOEl5Yt7zNw0CmncdGlCfldLsK+q8DYevA2ghrUoGRBr4FGEpL2s8Sr1rZe
	 Iy8qvrulysvjRVZ+BkOQqqJ+KZthgB/SKxjW0TWo318PxE6XQggagaK/7psGbsWVM5
	 iN8rMW6PMxzJyOGOvy93OQquC4WS3NPYCycXNX74=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406991AbfFKS7l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 14:59:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:36434 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392180AbfFKS7l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 14:59:41 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A2FA821852;
        Tue, 11 Jun 2019 18:59:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560279580;
        bh=2xQ+rYH0eY0Das/QD86dhs/72bS8PeZ5h8R2EDanUFw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f2LXSAjzgExKcSFhmqEdMLuhR/ne/MFPTcv/ARggPKvujED4ghqH4VCqAExzn0TGJ
         aaFqjMGGcTsn8Y5PbutdSetRnxi0QAKSX9vnuC0DsKPW/9uVMR+bVNmg8xxVounM2P
         9y7Y19y1676NLCjmUPOW6FlmOXeGD+d1h/9EPX1Q=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 05/85] perf symbols: Remove unused variable 'err'
Date:   Tue, 11 Jun 2019 15:57:51 -0300
Message-Id: <20190611185911.11645-6-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190611185911.11645-1-acme@kernel.org>
References: <20190611185911.11645-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Leo Yan <leo.yan@linaro.org>

Variable 'err' is defined but never used in function symsrc__init(),
remove it and directly return -1 at the end of the function.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190530093801.20510-1-leo.yan@linaro.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/symbol-elf.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index 4ad106a5f2c0..fdc5bd7dbb90 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -699,7 +699,6 @@ bool __weak elf__needs_adjust_symbols(GElf_Ehdr ehdr)
 int symsrc__init(struct symsrc *ss, struct dso *dso, const char *name,
 		 enum dso_binary_type type)
 {
-	int err = -1;
 	GElf_Ehdr ehdr;
 	Elf *elf;
 	int fd;
@@ -793,7 +792,7 @@ int symsrc__init(struct symsrc *ss, struct dso *dso, const char *name,
 	elf_end(elf);
 out_close:
 	close(fd);
-	return err;
+	return -1;
 }
 
 /**
-- 
2.20.1

