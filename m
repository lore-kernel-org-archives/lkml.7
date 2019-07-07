Return-Path: <SRS0=HQPa=VE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74F34C48BDE
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jul 2019 22:55:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 434CE206A2
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jul 2019 22:55:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Km952F9l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728249AbfGGWzX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Jul 2019 18:55:23 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:35971 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728006AbfGGWzU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jul 2019 18:55:20 -0400
Received: by mail-qk1-f195.google.com with SMTP id g18so11905126qkl.3;
        Sun, 07 Jul 2019 15:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZWQH59p1BAhtVxgjPSmUyGH/iZiK4gbSDXkFIng0cVs=;
        b=Km952F9lvbL+uPMU5XsUZuuuvKnsxLvLmir8Jgt8FhZQEWIov+8R/Nsxcg9WcdB0J9
         roQqRdM6wTC1wOz1TpsQIIipr6LG6k25Dus+v8JuxwYzC2+bEgSUWof0yp0kly9tvDeT
         qU2UmcPCJDZ8VsKTGCHcf+CWnjWEcB95Au5G1MzPm1vDz+RzC7kjVT/lvsf9U2nFkoVX
         WpFJ+19E4frM/ZY2dVKZh+oBYEk0mVqnLYPlbLXdyzmkN9Es33ldPUhejhX6VMIOIDyn
         WvhEjE3LEZa0HkHBRu7wzvyjb85Glb/5ZF6yS8zqDB85D5KjQw/3TAgJqCVFjOsCh33w
         Vxzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZWQH59p1BAhtVxgjPSmUyGH/iZiK4gbSDXkFIng0cVs=;
        b=o4+UucJybYjyo6jVcbmh7KQhQkWcYn2pXct1bGq2NHm78y6GSkTTBFDlkTYrNQGQix
         eiLZ1HpOk2f2+5VQjoJtgsXHTRVnw+ktH6HnuC724rC/jDcjNkZv4n2Y8eAkhWFeq+TT
         Fdo2X1r3Z4xQ9WcGZOvgOQkMR4DQhAsqSfRiVwQqx9ZaLAG4m8FzoxD0Y5ewotHIvH4C
         5GtSwEIOVAzV6ZuLlMug31cbNaJiT8HXTpTAnZGsDBSB9+bMreAY4XZGQbwtoSCzLXXa
         5xccIvjEi1rpr1itye3yctbu6eNOj3nAjx5rG2qVcsw4txq1gw6RGF20a5V7U0OwWbX2
         sdrQ==
X-Gm-Message-State: APjAAAW63ZIRf9/sXpL/RbgP+0Tndyba/JKq5yVvnMTAPrwUJhxgcg+F
        C+mW8s6JPVC5NdEaP9QffCEnm868
X-Google-Smtp-Source: APXvYqx1r671RW3JQwF9wqhGcEAQpQSGfsaQWW4B1nFcvayt3OFJSPBUS8FuMWFh7ih33P4CAEKp6g==
X-Received: by 2002:a37:61d4:: with SMTP id v203mr11647803qkb.458.1562540119476;
        Sun, 07 Jul 2019 15:55:19 -0700 (PDT)
Received: from localhost.localdomain (ppp79-139-233-208.pppoe.spdop.ru. [79.139.233.208])
        by smtp.gmail.com with ESMTPSA id t2sm8217556qth.33.2019.07.07.15.55.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Jul 2019 15:55:19 -0700 (PDT)
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
Subject: [PATCH v7 12/13] memory: tegra: Consolidate registers definition into common header
Date:   Mon,  8 Jul 2019 01:54:23 +0300
Message-Id: <20190707225424.9562-13-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190707225424.9562-1-digetx@gmail.com>
References: <20190707225424.9562-1-digetx@gmail.com>
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

