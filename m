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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36020C3A5A1
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 03:19:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B3422168B
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 03:19:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fFw50hwj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729663AbfHZDTA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Aug 2019 23:19:00 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43925 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729522AbfHZDS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Aug 2019 23:18:56 -0400
Received: by mail-pf1-f194.google.com with SMTP id v12so10811413pfn.10;
        Sun, 25 Aug 2019 20:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/FIc4QaBXsWcQmRvb8jAc1XDRIewyQvawzEI4Q440V0=;
        b=fFw50hwjuuBIgrKHpwqmGHOmiBAV42sshCD1p743yGmGNghgndEcIodbbtnvM0PLRt
         W2Iny4F7pnH09tO2E7oma2qxb0UXRa+zfWtjij4DKIw7ynqn/AGV8CVJvtjTZrtef4I6
         9FP1he4JMM8AMjEpGU9iRC/K9p97hd0CyCK+FsurX3dXPNGptRFsjI6CFQn7riXmcfhm
         hVepmA0ZofMPfwVuKqqmqjfKEa1FRmE6+IyFj2MEVyRq4tCPZWr0w62NiNNJ5UivAsP2
         /cS5EllyW1hl6mbppzZvsOflN52gkdmHsWds5iqKOZKJZ9x4guKqZcGioZKbYCBGBrFv
         m4CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/FIc4QaBXsWcQmRvb8jAc1XDRIewyQvawzEI4Q440V0=;
        b=PIzJSFYNT1IGOCE51pY3LsFdKLhQ95NvrZQM8gc1TrgzH4aOcHdgr2iwzzNmLtlBK8
         3zufBHY2AL4zx0TrCwZG2nM/iqYuYX+67HaQRYvbVuQUzfhs8xPtAWFJDNesFqLoa9DX
         7bOjZYi/8pWrYqR3b/DoTvwtg3YDMdNNZYEjzGS+UD1yT4sYE0D75CN+gyn2dR71rcTj
         gVyI/i+OiYGcRUb5RNa3CU7JIyj90Ht9XRWnalbFaAiOK3l0ohleUtOgpXAHdid2al1K
         gMlDVHc+p7xBDu/HhJvNuYuAtRA8SxmKu5HGsTvmjrKd1C4nzIxsK23IdVs4J9GeFawt
         OSLA==
X-Gm-Message-State: APjAAAUJlAnkGkerKb/1Fe+O1nCsWdYdFpiGaRcYw2EWVQCEbs0p8vyn
        sfY3YZ6u0vF1HvD5xq0jc8w=
X-Google-Smtp-Source: APXvYqx2AO+6o+bv8ItxkVBL110+bvMgndV0QBQYXottFJzuo4Yn0a1kHsBLdyKZsQWgyYET6GByPQ==
X-Received: by 2002:a65:5003:: with SMTP id f3mr589602pgo.335.1566789535830;
        Sun, 25 Aug 2019 20:18:55 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id y23sm12565905pfr.86.2019.08.25.20.18.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Aug 2019 20:18:55 -0700 (PDT)
From:   Chunyan Zhang <zhang.lyra@gmail.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linaro.org>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chunyan Zhang <zhang.lyra@gmail.com>
Subject: [PATCH 2/5] mmc: sdhci-sprd: add get_ro hook function
Date:   Mon, 26 Aug 2019 11:18:27 +0800
Message-Id: <20190826031830.30931-3-zhang.lyra@gmail.com>
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

sprd's sd host controller doesn't support write protect to sd card.

Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
Signed-off-by: Chunyan Zhang <zhang.lyra@gmail.com>
---
 drivers/mmc/host/sdhci-sprd.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/mmc/host/sdhci-sprd.c b/drivers/mmc/host/sdhci-sprd.c
index d5871865a1e9..90cb2af91159 100644
--- a/drivers/mmc/host/sdhci-sprd.c
+++ b/drivers/mmc/host/sdhci-sprd.c
@@ -374,6 +374,11 @@ static unsigned int sdhci_sprd_get_max_timeout_count(struct sdhci_host *host)
 	return 1 << 31;
 }
 
+static unsigned int sdhci_sprd_get_ro(struct sdhci_host *host)
+{
+	return 0;
+}
+
 static struct sdhci_ops sdhci_sprd_ops = {
 	.read_l = sdhci_sprd_readl,
 	.write_l = sdhci_sprd_writel,
@@ -386,6 +391,7 @@ static struct sdhci_ops sdhci_sprd_ops = {
 	.set_uhs_signaling = sdhci_sprd_set_uhs_signaling,
 	.hw_reset = sdhci_sprd_hw_reset,
 	.get_max_timeout_count = sdhci_sprd_get_max_timeout_count,
+	.get_ro = sdhci_sprd_get_ro,
 };
 
 static void sdhci_sprd_request(struct mmc_host *mmc, struct mmc_request *mrq)
-- 
2.20.1

