Return-Path: <SRS0=7o0M=UP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56CF5C31E53
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Jun 2019 23:36:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23AA820861
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Jun 2019 23:36:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bGyGx5aV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727621AbfFPXg0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Jun 2019 19:36:26 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:45360 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727542AbfFPXgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jun 2019 19:36:18 -0400
Received: by mail-lf1-f65.google.com with SMTP id u10so5112142lfm.12;
        Sun, 16 Jun 2019 16:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cnCOL4jqcTgycmpwDNSMV8gWvyfoEAgx3Vm4xYozxms=;
        b=bGyGx5aV//R5YzLF1R1swccwIUP3gdW91U2txEvqZKpXK3NVkrrdyXCeZ97Z7phWqA
         10EOgXZQaHjtbLHVf1Qqw8AilCO28us9WpYImPukwlhUIUPwSM1qrXfpfNrOY1yC/REh
         7oRCiFyHqha627Z7rNcv4rSv/DdRJljAqVS+0GjgVcurlvPrIgpbzQV5ZCH8YO0VE8VO
         jrOw15BkbuMo53NwOkOn3xo9N+ruPH/8GQclL9cubC+R+/CApLI0GWzwjkwPr9rlBLgv
         KgrIFM5ky1U5okmCjDF+xLhFKtKRtCOnmbPSSj+qSkKq0qF0ABqAeMtvKXeBC7/sNSO4
         NqvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cnCOL4jqcTgycmpwDNSMV8gWvyfoEAgx3Vm4xYozxms=;
        b=ZyxAKpd4dWwjDSJ5bi/FBytdvdn2xGD9DO55b+cv/ABCMonv418rZyJDUPItSYUew8
         GVS4QrNZaam3Ok42jsGOQX5Y5B221DCt+S4H715TX5KUrskJjH8QlO92rKCp8qNbP5jt
         jt1/vBTW5D5C1yKb5UkJaZ8hYTXSzR4atF0xo5CHYm8vi53T5mmXK6UyUYoLrBMCJmNQ
         neVF1FchdahzPhI89L74BPb1TovPrIE1nsZmjzFcfixLJs7jeWj6cW4ZE85gZ6r9iVf4
         sGRT23/hyzSJbNUjFfLQVMxn/e8VZ/jHteurSJbSf/i9qylgE+4Yo+j6+4dC3JfMye8r
         gQng==
X-Gm-Message-State: APjAAAViqjJ4nJF0nPEuNpLZVWxTCadM+dOV9A/dGOL8x0KDsfDVdjSO
        hN+wyLRD1I1ZE184drumLNc=
X-Google-Smtp-Source: APXvYqyrGRyfz6wzXD0gs9u1m5fgQ/58HMc0N8IiTeFT6YE7fonDdo4wGiW2VZAR3MRwBYgbon4qAA==
X-Received: by 2002:a19:ae0d:: with SMTP id f13mr3470129lfc.123.1560728175163;
        Sun, 16 Jun 2019 16:36:15 -0700 (PDT)
Received: from localhost.localdomain (ppp91-79-162-197.pppoe.mtu-net.ru. [91.79.162.197])
        by smtp.gmail.com with ESMTPSA id q4sm2008377lje.99.2019.06.16.16.36.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 16 Jun 2019 16:36:14 -0700 (PDT)
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
Subject: [PATCH v4 09/10] memory: tegra: Consolidate registers definition into one place
Date:   Mon, 17 Jun 2019 02:35:50 +0300
Message-Id: <20190616233551.6838-10-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190616233551.6838-1-digetx@gmail.com>
References: <20190616233551.6838-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Memory Controller registers definition is sparse and duplicated,
let's consolidate everything into a common place for consistency.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/memory/tegra/mc.c       | 30 -------------------
 drivers/memory/tegra/mc.h       | 52 +++++++++++++++++++++++++++++----
 drivers/memory/tegra/tegra124.c | 20 -------------
 drivers/memory/tegra/tegra30.c  | 20 -------------
 4 files changed, 47 insertions(+), 75 deletions(-)

diff --git a/drivers/memory/tegra/mc.c b/drivers/memory/tegra/mc.c
index 4c1492c653e1..c926aa81a6ac 100644
--- a/drivers/memory/tegra/mc.c
+++ b/drivers/memory/tegra/mc.c
@@ -21,36 +21,6 @@
 
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
index abc565b42225..65783063612f 100644
--- a/drivers/memory/tegra/mc.h
+++ b/drivers/memory/tegra/mc.h
@@ -15,6 +15,37 @@
 
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
@@ -25,17 +56,28 @@
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
index 8f8487bda642..c0acf988d7a5 100644
--- a/drivers/memory/tegra/tegra124.c
+++ b/drivers/memory/tegra/tegra124.c
@@ -13,26 +13,6 @@
 
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
 static const unsigned long tegra124_mc_emem_regs[] = {
 	MC_EMEM_ARB_CFG,
 	MC_EMEM_ARB_OUTSTANDING_REQ,
diff --git a/drivers/memory/tegra/tegra30.c b/drivers/memory/tegra/tegra30.c
index 67676677fd6a..f17488a0c5c7 100644
--- a/drivers/memory/tegra/tegra30.c
+++ b/drivers/memory/tegra/tegra30.c
@@ -13,26 +13,6 @@
 
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
 static const unsigned long tegra30_mc_emem_regs[] = {
 	MC_EMEM_ARB_CFG,
 	MC_EMEM_ARB_OUTSTANDING_REQ,
-- 
2.22.0

