Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3615C3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 01:47:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9776E214DA
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 01:47:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vNhPBn8W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727294AbfH2Brg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 21:47:36 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:40884 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727251AbfH2Brf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 21:47:35 -0400
Received: by mail-pl1-f196.google.com with SMTP id h3so802486pls.7;
        Wed, 28 Aug 2019 18:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lKatwZV9g/yI2OBBcKsk1xQjsJeHSwIuue1+ya8AQR4=;
        b=vNhPBn8WuAyD46AWEONXHeF7j1/L5oY2D2IBbWXrkb+YGxvIH/60jVIMZ/Q3fsdLvI
         lf5+8Um1B5DPWLyugTRRP4DLUUK8HP5hlRhTgNUztXEAVYt7pzaf5U2d1cnxdNWgBKIG
         M3QdBOMTUp09wB7tycFSH8YdZVK1DoDWD6vW99lq0sorAuik5oQZ8aoyQvinCL3gXqAj
         f+RdyU5xBQjv/vGYGG+peSFLxLin9iR2YcwCnJs0JW3zj0oPJabExB/zpAY3xuqUT2py
         D9X3IkFcIHALFDTf//FZp8GKr2lx/4yabDm3+K0ZGXfVTFiRl2OQNp0+chXIaoxVMCVk
         77uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lKatwZV9g/yI2OBBcKsk1xQjsJeHSwIuue1+ya8AQR4=;
        b=fOlVVBCwoFOvWHoI+p6DmW5gr2Duyr120hWoSB/Kb0qXQgGbobDgf26KYlnSfZuHpW
         u+CaAePr3xRA08P0qIvuWCws8mHvVm6YTfTasg1xrp1rsCIDNArkRrhCgqFjlhB9H0Po
         EZwwaRAew4bumUptZoJHzAANscJoFnsvW+C0pJho0RIxCbPv+WU7vN9z9ITNfnucMTEy
         lLPUGIT/IDyPgEs5PTNv6tzzS4AyJxLnwKHkWTn6yMjxmoTkURgLPjNGpZisosrRoOOE
         CZRAkjLheob9Gha/3xBHerliCBvh90NeA+3UJteGetQJeoqdOVsXQoEoKHz8y65yfpMw
         n9NA==
X-Gm-Message-State: APjAAAUl9tzMsjapidLV1VgyB634G5wIezbpbKdyr5hKlh9n70a++0Fb
        MSldijYu3P2DYJmHtWHRMKQ=
X-Google-Smtp-Source: APXvYqwVKH3GrlQNmocO2B5tep6crTgeMnaTqoSgGmaNnZjlUz0d02+W3cus/vH/WWnO4MkOhfdN5Q==
X-Received: by 2002:a17:902:110b:: with SMTP id d11mr7501823pla.84.1567043255012;
        Wed, 28 Aug 2019 18:47:35 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id j10sm404548pjn.3.2019.08.28.18.47.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2019 18:47:34 -0700 (PDT)
From:   Chunyan Zhang <zhang.lyra@gmail.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linaro.org>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chunyan Zhang <zhang.lyra@gmail.com>
Subject: [RESEND PATCH v2 4/5] mms: sdhci-sprd: add SDHCI_QUIRK_BROKEN_CARD_DETECTION
Date:   Thu, 29 Aug 2019 09:46:44 +0800
Message-Id: <20190829014645.4479-5-zhang.lyra@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190829014645.4479-1-zhang.lyra@gmail.com>
References: <20190829014645.4479-1-zhang.lyra@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chunyan Zhang <chunyan.zhang@unisoc.com>

sprd's sd host controller doesn't support detection to
card insert or remove.

Fixes: fb8bd90f83c4 ("mmc: sdhci-sprd: Add Spreadtrum's initial host controller")
Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
Signed-off-by: Chunyan Zhang <zhang.lyra@gmail.com>
Reviewed-by: Baolin Wang <baolin.wang@linaro.org>
Tested-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/mmc/host/sdhci-sprd.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-sprd.c b/drivers/mmc/host/sdhci-sprd.c
index 27d0b57f3f89..1fecf055682c 100644
--- a/drivers/mmc/host/sdhci-sprd.c
+++ b/drivers/mmc/host/sdhci-sprd.c
@@ -508,7 +508,8 @@ static void sdhci_sprd_phy_param_parse(struct sdhci_sprd_host *sprd_host,
 }
 
 static const struct sdhci_pltfm_data sdhci_sprd_pdata = {
-	.quirks = SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK,
+	.quirks = SDHCI_QUIRK_BROKEN_CARD_DETECTION |
+		  SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK,
 	.quirks2 = SDHCI_QUIRK2_BROKEN_HS200 |
 		   SDHCI_QUIRK2_USE_32BIT_BLK_CNT |
 		   SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
-- 
2.20.1

