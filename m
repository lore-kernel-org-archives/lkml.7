Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0982C3A5A1
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 03:19:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 849ED2173E
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 03:19:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A3/3vOqC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729680AbfHZDTE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Aug 2019 23:19:04 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44027 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729518AbfHZDTC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Aug 2019 23:19:02 -0400
Received: by mail-pg1-f195.google.com with SMTP id k3so9654333pgb.10;
        Sun, 25 Aug 2019 20:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gQzlqbeBy0rOgCuibxrwv7llgsxt3/gPsmmcGEamYmM=;
        b=A3/3vOqCSl0LJb39V9Jod6GpISEy6Jf4A8gF8gU9ihjlZMMUP7x5xtqO0ZubVHjltX
         ndMLp4GywdCBNxtJTuq6OXhda2ARtksCIKLn7WMcNj10yV1AJ2m0rwnakrjv+7wpGhF0
         pJ41IvrKBmRfmQ4mOr3d1kwAJWUzp+bXiz59SCSBQcrfm5IGTRnw7Dbq5gCEocTASgp5
         8vJ+vyMCyrynzhGREsWBuZJgtN35yK68OSOcrM2KgTFaOZKTyC273gJcx0XohM05KL4N
         7hNH/LyATrtNpXhOCweXQUhenV/WA8w0Um+0fVp6i3zCT7aphQDPW/GOoL+rDGlKUIDo
         fW7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gQzlqbeBy0rOgCuibxrwv7llgsxt3/gPsmmcGEamYmM=;
        b=IUosqDY+USdiSKcTsduJ4vCLPmTfbS/9V1KT1xr/othwjpXdTBkyhEH11StsoLpC7f
         yhV9URA2E7vc65Vjta1SJ3IZ1jCGGTfXN3CdRNis5FmXaFvtIxdyRzaDGV8xD++kQnUh
         4u9s1RNsCUFz/dfCOt5qHc0ibgeLxr8MDPvhPBeMFr73sITiRAL2RLyetO+WxPkuv/S2
         gxrsiJrb2G5khh0xQUe6cVpjlQ0S4rv5ovrTD4Qesz2wwouSlfg80fBC1xMiF6zPnakk
         yvzffuEQbeJgXDigVCkjVphiBHUAOEe8stVdj/fzYkKfHC6TNRnaUd9j/KfoF31s0ewv
         JU3w==
X-Gm-Message-State: APjAAAWMFYpjTqyko1pwm9+ovDM6ir1QBeUCQZ/2NF/Eos+rp1d0B3zA
        LEifdbbpQZgf9kUd6XNt454aO5Gj
X-Google-Smtp-Source: APXvYqydnaG10dbmwma3vb52FGG0Qof19L9QcerzYmucYOBMA2Q3UfoiISjqleQiaDyFcHaGm2zZRg==
X-Received: by 2002:a17:90a:22c9:: with SMTP id s67mr4736144pjc.22.1566789542040;
        Sun, 25 Aug 2019 20:19:02 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id y23sm12565905pfr.86.2019.08.25.20.18.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Aug 2019 20:19:01 -0700 (PDT)
From:   Chunyan Zhang <zhang.lyra@gmail.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linaro.org>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chunyan Zhang <zhang.lyra@gmail.com>
Subject: [PATCH 4/5] mms: sdhci-sprd: add SDHCI_QUIRK_BROKEN_CARD_DETECTION
Date:   Mon, 26 Aug 2019 11:18:29 +0800
Message-Id: <20190826031830.30931-5-zhang.lyra@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190826031830.30931-1-zhang.lyra@gmail.com>
References: <20190826031830.30931-1-zhang.lyra@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chunyan Zhang <chunyan.zhang@unisoc.com>

sprd's sd host controller doesn't support detection to
card insert or remove.

Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
Signed-off-by: Chunyan Zhang <zhang.lyra@gmail.com>
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

