Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94CD7C3A5A1
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 03:19:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 678422173E
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 03:19:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dHBCEhI8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729714AbfHZDTP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Aug 2019 23:19:15 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44827 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729649AbfHZDS7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Aug 2019 23:18:59 -0400
Received: by mail-pg1-f193.google.com with SMTP id i18so9659679pgl.11;
        Sun, 25 Aug 2019 20:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6BeSiLacM+7Sf7qkApv2ILwpaNC8CAg80TkB/80zAMU=;
        b=dHBCEhI8bkVnrMwYo7YJ8PhlPCqUep6tSWtsOokJAMP4et4c8vM9f4Dj7egMNymU04
         CbeglpMLTmFGPV8yTEtHABw0nYZyw5HyA9y/LVok6uypta0JKZr+1eWykALD+BMUKO+H
         yh0an2x03stI7vwMoW1Q6kFl1RtFUZby53sS9ToXE4A1ZATgZXDT5UsVBumyeU2TjnEG
         tH8y1dzSy6yRTYFPnaxlpLzLIdqUiyyOX/oGD7h2A2IsuDp4z4aQUBiPCU5618yKPVuH
         lRSyKLlGeZsHntBXRwHTX+2oKsuMZSSmX1vpleu1pK4jFhQTH9oOhBPbujAuJ6YUXam3
         H7hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6BeSiLacM+7Sf7qkApv2ILwpaNC8CAg80TkB/80zAMU=;
        b=QUv3hiixYmqhX/V+iyJBHX5lZ2QkvSlkM+WARVBIrL8TZDFiRqgZh4xyDfNiEXzYxh
         GSC6rergR8C77Vc0IUGo6lkRkHRpjVVkSZj8DJCfq8NSTgTVXO70+HclRx2UV7JScKAO
         ncP0Hc5YZLWt7kYHDUYJZgzKRcA9wRM00B2iBs/aS2AmrqjNEfoYDNk2ZLnfcQS723bj
         zN5rkXzigwvoLINRQLBH4sMtNLAidPwSLpZn/zWuGA4PK2VF456xQieC4QNdZa5K/pfv
         s7cznpVY66yms46cmgfObGzUgWs9s7LUXvfSkWoUZcZxWB8Vc9DlJ9g04N3Fs9MmH8CC
         /iVA==
X-Gm-Message-State: APjAAAUEFG3wVA3M7swfgKHnYM6uwPotXODZOZ407x+LK4k7VjoPloIw
        9CkUgvbdsar8AqbqFPMe13IF+2yE
X-Google-Smtp-Source: APXvYqyrpOKfW/bqg6wcyNH+zve0gIXtYwD7oQT38XJCZ43UVMLJyAqS3R3Khc7CGWfEXdmnhaDeqA==
X-Received: by 2002:a62:cd45:: with SMTP id o66mr1430131pfg.112.1566789538833;
        Sun, 25 Aug 2019 20:18:58 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id y23sm12565905pfr.86.2019.08.25.20.18.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Aug 2019 20:18:58 -0700 (PDT)
From:   Chunyan Zhang <zhang.lyra@gmail.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linaro.org>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chunyan Zhang <zhang.lyra@gmail.com>
Subject: [PATCH 3/5] mmc: sdhci-sprd: add SDHCI_QUIRK2_PRESET_VALUE_BROKEN
Date:   Mon, 26 Aug 2019 11:18:28 +0800
Message-Id: <20190826031830.30931-4-zhang.lyra@gmail.com>
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

The bit of PRESET_VAL_ENABLE in HOST_CONTROL2 register is reserved on
sprd's sd host controller, set quirk2 to disable configuring this.

Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
Signed-off-by: Chunyan Zhang <zhang.lyra@gmail.com>
---
 drivers/mmc/host/sdhci-sprd.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-sprd.c b/drivers/mmc/host/sdhci-sprd.c
index 90cb2af91159..27d0b57f3f89 100644
--- a/drivers/mmc/host/sdhci-sprd.c
+++ b/drivers/mmc/host/sdhci-sprd.c
@@ -510,7 +510,8 @@ static void sdhci_sprd_phy_param_parse(struct sdhci_sprd_host *sprd_host,
 static const struct sdhci_pltfm_data sdhci_sprd_pdata = {
 	.quirks = SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK,
 	.quirks2 = SDHCI_QUIRK2_BROKEN_HS200 |
-		   SDHCI_QUIRK2_USE_32BIT_BLK_CNT,
+		   SDHCI_QUIRK2_USE_32BIT_BLK_CNT |
+		   SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
 	.ops = &sdhci_sprd_ops,
 };
 
-- 
2.20.1

