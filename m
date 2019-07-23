Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08EF6C76186
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 03:14:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBF5B2238E
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 03:14:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CVvdXyDM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732500AbfGWDO2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 23:14:28 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:41654 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730048AbfGWDOZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 23:14:25 -0400
Received: by mail-lj1-f194.google.com with SMTP id d24so39544910ljg.8;
        Mon, 22 Jul 2019 20:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZWQH59p1BAhtVxgjPSmUyGH/iZiK4gbSDXkFIng0cVs=;
        b=CVvdXyDM+VAJD7BMeD+lOVJLQQ66aJ0KbDwnIkYqZBK9VKrnhsn4oe4Uqln8dkBdSQ
         UF34aaZs1xBBTieI6UrfbgYXE0Oa6+udqG1Z7TwU3cPNB5dpkfGdj3OQUVSVPNiS2P22
         Mme+HJOkIUe02WELDNQSoWqRhX2I2/zrhKp8eq0q6/R0bqllGcGuIVVBNFH8WAKlkD8z
         v+ePWcAkTvbfWNOHbLxg5juNsuoaRnYZeEBt1Odz0oUdlGTIR0/thHukFr5j+sXfl1k1
         QFZSYQpNmqHAa2AR2YQWstlhHk7rUexgk33B1QvktvgWONiSILil+0hyK037HzRGZt9m
         mwvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZWQH59p1BAhtVxgjPSmUyGH/iZiK4gbSDXkFIng0cVs=;
        b=ieZLUIgs0kRKMncF7o9ZdsZvztfDvAIbAkk2G6drmOnG7zf5XIBbSoMtA2z3wp67Iy
         WafUoyE2buSXBJDbe2m77uXuWY9bFDdEpMJRVdcyB9iY37dyDO/irEXsUvxRmmdWTqnF
         TcWmfQ65jgBmg1qQPh7LCo8jE2bIdH7mM70dzu9xoDmngbMJxmlhBN+vBaouKr1TMG57
         LGKvEHH/PpzHZsmz5bVEcvR0nqNQy6tZF0Izf16XJCrZc7NJrIT5wR8R7PDv+TqnkJhA
         EnbyBBFfydKMakJ+ZK1w9JPvGsrppaxJsWAlUTz0Hj0x2lylNrYKSZr+JDEPZc2OjVA9
         pmuA==
X-Gm-Message-State: APjAAAU/MXjcpcGFKCYh9j0sLkls5a+icpjcLrhUXs+cIXKe1k2BKn7R
        XwssX0yACT3koegtmN61gdA=
X-Google-Smtp-Source: APXvYqzIvMPcoasMzLfPTlj2Z8SX8YuuPV07aURYCq7kKaNAGh2nc0nnd8QPlI4uxKXX17L80VNrMA==
X-Received: by 2002:a2e:9a49:: with SMTP id k9mr37702482ljj.78.1563851662010;
        Mon, 22 Jul 2019 20:14:22 -0700 (PDT)
Received: from localhost.localdomain (ppp91-78-220-99.pppoe.mtu-net.ru. [91.78.220.99])
        by smtp.gmail.com with ESMTPSA id u18sm6217184lfe.65.2019.07.22.20.14.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Jul 2019 20:14:21 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Joseph Lo <josephl@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v8 14/15] memory: tegra: Consolidate registers definition into common header
Date:   Tue, 23 Jul 2019 06:12:46 +0300
Message-Id: <20190723031247.31932-15-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190723031247.31932-1-digetx@gmail.com>
References: <20190723031247.31932-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Memory Controller registers definition is sparse and duplicated,
let's consolidate everything into a common place for consistency.

Acked-by: Peter De Schrijver <pdeschrijver@nvidia.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/memory/tegra/mc.c       | 30 -------------------
 drivers/memory/tegra/mc.h       | 52 +++++++++++++++++++++++++++++----
 drivers/memory/tegra/tegra124.c | 20 -------------
 drivers/memory/tegra/tegra30.c  | 19 ------------
 4 files changed, 47 insertions(+), 74 deletions(-)

diff --git a/drivers/memory/tegra/mc.c b/drivers/memory/tegra/mc.c
index 1bad7f238881..955f1d3f6b6a 100644
--- a/drivers/memory/tegra/mc.c
+++ b/drivers/memory/tegra/mc.c
@@ -18,36 +18,6 @@
 
 #include "mc.h"
 
-#define MC_INTSTATUS 0x000
-
-#define MC_INTMASK 0x004
-
-#define MC_ERR_STATUS 0x08
-#define  MC_ERR_STATUS_TYPE_SHIFT 28
-#define  MC_ERR_STATUS_TYPE_INVALID_SMMU_PAGE (6 << MC_ERR_STATUS_TYPE_SHIFT)
-#define  MC_ERR_STATUS_TYPE_MASK (0x7 << MC_ERR_STATUS_TYPE_SHIFT)
-#define  MC_ERR_STATUS_READABLE (1 << 27)
-#define  MC_ERR_STATUS_WRITABLE (1 << 26)
-#define  MC_ERR_STATUS_NONSECURE (1 << 25)
-#define  MC_ERR_STATUS_ADR_HI_SHIFT 20
-#define  MC_ERR_STATUS_ADR_HI_MASK 0x3
-#define  MC_ERR_STATUS_SECURITY (1 << 17)
-#define  MC_ERR_STATUS_RW (1 << 16)
-
-#define MC_ERR_ADR 0x0c
-
-#define MC_GART_ERROR_REQ		0x30
-#define MC_DECERR_EMEM_OTHERS_STATUS	0x58
-#define MC_SECURITY_VIOLATION_STATUS	0x74
-
-#define MC_EMEM_ARB_CFG 0x90
-#define  MC_EMEM_ARB_CFG_CYCLES_PER_UPDATE(x)	(((x) & 0x1ff) << 0)
-#define  MC_EMEM_ARB_CFG_CYCLES_PER_UPDATE_MASK	0x1ff
-#define MC_EMEM_ARB_MISC0 0xd8
-
-#define MC_EMEM_ADR_CFG 0x54
-#define MC_EMEM_ADR_CFG_EMEM_NUMDEV BIT(0)
-
 static const struct of_device_id tegra_mc_of_match[] = {
 #ifdef CONFIG_ARCH_TEGRA_2x_SOC
 	{ .compatible = "nvidia,tegra20-mc-gart", .data = &tegra20_mc_soc },
diff --git a/drivers/memory/tegra/mc.h b/drivers/memory/tegra/mc.h
index cd52628c2b96..957c6eb74ff9 100644
--- a/drivers/memory/tegra/mc.h
+++ b/drivers/memory/tegra/mc.h
@@ -12,6 +12,37 @@
 
 #include <soc/tegra/mc.h>
 
+#define MC_INTSTATUS					0x00
+#define MC_INTMASK					0x04
+#define MC_ERR_STATUS					0x08
+#define MC_ERR_ADR					0x0c
+#define MC_GART_ERROR_REQ				0x30
+#define MC_EMEM_ADR_CFG					0x54
+#define MC_DECERR_EMEM_OTHERS_STATUS			0x58
+#define MC_SECURITY_VIOLATION_STATUS			0x74
+#define MC_EMEM_ARB_CFG					0x90
+#define MC_EMEM_ARB_OUTSTANDING_REQ			0x94
+#define MC_EMEM_ARB_TIMING_RCD				0x98
+#define MC_EMEM_ARB_TIMING_RP				0x9c
+#define MC_EMEM_ARB_TIMING_RC				0xa0
+#define MC_EMEM_ARB_TIMING_RAS				0xa4
+#define MC_EMEM_ARB_TIMING_FAW				0xa8
+#define MC_EMEM_ARB_TIMING_RRD				0xac
+#define MC_EMEM_ARB_TIMING_RAP2PRE			0xb0
+#define MC_EMEM_ARB_TIMING_WAP2PRE			0xb4
+#define MC_EMEM_ARB_TIMING_R2R				0xb8
+#define MC_EMEM_ARB_TIMING_W2W				0xbc
+#define MC_EMEM_ARB_TIMING_R2W				0xc0
+#define MC_EMEM_ARB_TIMING_W2R				0xc4
+#define MC_EMEM_ARB_DA_TURNS				0xd0
+#define MC_EMEM_ARB_DA_COVERS				0xd4
+#define MC_EMEM_ARB_MISC0				0xd8
+#define MC_EMEM_ARB_MISC1				0xdc
+#define MC_EMEM_ARB_RING1_THROTTLE			0xe0
+#define MC_EMEM_ARB_OVERRIDE				0xe8
+#define MC_TIMING_CONTROL_DBG				0xf8
+#define MC_TIMING_CONTROL				0xfc
+
 #define MC_INT_DECERR_MTS				BIT(16)
 #define MC_INT_SECERR_SEC				BIT(13)
 #define MC_INT_DECERR_VPR				BIT(12)
@@ -22,17 +53,28 @@
 #define MC_INT_INVALID_GART_PAGE			BIT(7)
 #define MC_INT_DECERR_EMEM				BIT(6)
 
-#define MC_EMEM_ARB_OUTSTANDING_REQ			0x94
+#define MC_ERR_STATUS_TYPE_SHIFT			28
+#define MC_ERR_STATUS_TYPE_INVALID_SMMU_PAGE		(0x6 << 28)
+#define MC_ERR_STATUS_TYPE_MASK				(0x7 << 28)
+#define MC_ERR_STATUS_READABLE				BIT(27)
+#define MC_ERR_STATUS_WRITABLE				BIT(26)
+#define MC_ERR_STATUS_NONSECURE				BIT(25)
+#define MC_ERR_STATUS_ADR_HI_SHIFT			20
+#define MC_ERR_STATUS_ADR_HI_MASK			0x3
+#define MC_ERR_STATUS_SECURITY				BIT(17)
+#define MC_ERR_STATUS_RW				BIT(16)
+
+#define MC_EMEM_ADR_CFG_EMEM_NUMDEV			BIT(0)
+
+#define MC_EMEM_ARB_CFG_CYCLES_PER_UPDATE(x)		((x) & 0x1ff)
+#define MC_EMEM_ARB_CFG_CYCLES_PER_UPDATE_MASK		0x1ff
+
 #define MC_EMEM_ARB_OUTSTANDING_REQ_MAX_MASK		0x1ff
 #define MC_EMEM_ARB_OUTSTANDING_REQ_HOLDOFF_OVERRIDE	BIT(30)
 #define MC_EMEM_ARB_OUTSTANDING_REQ_LIMIT_ENABLE	BIT(31)
 
-#define MC_EMEM_ARB_OVERRIDE				0xe8
 #define MC_EMEM_ARB_OVERRIDE_EACK_MASK			0x3
 
-#define MC_TIMING_CONTROL_DBG				0xf8
-
-#define MC_TIMING_CONTROL				0xfc
 #define MC_TIMING_UPDATE				BIT(0)
 
 static inline u32 mc_readl(struct tegra_mc *mc, unsigned long offset)
diff --git a/drivers/memory/tegra/tegra124.c b/drivers/memory/tegra/tegra124.c
index 5d0ccb2be206..4d80c81a4581 100644
--- a/drivers/memory/tegra/tegra124.c
+++ b/drivers/memory/tegra/tegra124.c
@@ -10,26 +10,6 @@
 
 #include "mc.h"
 
-#define MC_EMEM_ARB_CFG				0x90
-#define MC_EMEM_ARB_OUTSTANDING_REQ		0x94
-#define MC_EMEM_ARB_TIMING_RCD			0x98
-#define MC_EMEM_ARB_TIMING_RP			0x9c
-#define MC_EMEM_ARB_TIMING_RC			0xa0
-#define MC_EMEM_ARB_TIMING_RAS			0xa4
-#define MC_EMEM_ARB_TIMING_FAW			0xa8
-#define MC_EMEM_ARB_TIMING_RRD			0xac
-#define MC_EMEM_ARB_TIMING_RAP2PRE		0xb0
-#define MC_EMEM_ARB_TIMING_WAP2PRE		0xb4
-#define MC_EMEM_ARB_TIMING_R2R			0xb8
-#define MC_EMEM_ARB_TIMING_W2W			0xbc
-#define MC_EMEM_ARB_TIMING_R2W			0xc0
-#define MC_EMEM_ARB_TIMING_W2R			0xc4
-#define MC_EMEM_ARB_DA_TURNS			0xd0
-#define MC_EMEM_ARB_DA_COVERS			0xd4
-#define MC_EMEM_ARB_MISC0			0xd8
-#define MC_EMEM_ARB_MISC1			0xdc
-#define MC_EMEM_ARB_RING1_THROTTLE		0xe0
-
 static const struct tegra_mc_client tegra124_mc_clients[] = {
 	{
 		.id = 0x00,
diff --git a/drivers/memory/tegra/tegra30.c b/drivers/memory/tegra/tegra30.c
index b1226d3f067f..fdc0b342cf80 100644
--- a/drivers/memory/tegra/tegra30.c
+++ b/drivers/memory/tegra/tegra30.c
@@ -10,25 +10,6 @@
 
 #include "mc.h"
 
-#define MC_EMEM_ARB_CFG				0x90
-#define MC_EMEM_ARB_OUTSTANDING_REQ		0x94
-#define MC_EMEM_ARB_TIMING_RCD			0x98
-#define MC_EMEM_ARB_TIMING_RP			0x9c
-#define MC_EMEM_ARB_TIMING_RC			0xa0
-#define MC_EMEM_ARB_TIMING_RAS			0xa4
-#define MC_EMEM_ARB_TIMING_FAW			0xa8
-#define MC_EMEM_ARB_TIMING_RRD			0xac
-#define MC_EMEM_ARB_TIMING_RAP2PRE		0xb0
-#define MC_EMEM_ARB_TIMING_WAP2PRE		0xb4
-#define MC_EMEM_ARB_TIMING_R2R			0xb8
-#define MC_EMEM_ARB_TIMING_W2W			0xbc
-#define MC_EMEM_ARB_TIMING_R2W			0xc0
-#define MC_EMEM_ARB_TIMING_W2R			0xc4
-#define MC_EMEM_ARB_DA_TURNS			0xd0
-#define MC_EMEM_ARB_DA_COVERS			0xd4
-#define MC_EMEM_ARB_MISC0			0xd8
-#define MC_EMEM_ARB_RING1_THROTTLE		0xe0
-
 static const unsigned long tegra30_mc_emem_regs[] = {
 	MC_EMEM_ARB_CFG,
 	MC_EMEM_ARB_OUTSTANDING_REQ,
-- 
2.22.0

