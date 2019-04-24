Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C18F2C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 23:18:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CD88217FA
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 23:18:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bVNjo/CR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728061AbfDXXS2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 19:18:28 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:38431 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727945AbfDXXS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 19:18:27 -0400
Received: by mail-lj1-f194.google.com with SMTP id p14so18462845ljg.5;
        Wed, 24 Apr 2019 16:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3SWil8fXUv08kqinX3hYmvZH788sYA0vKX106ff7czk=;
        b=bVNjo/CREbsXIw2upxUCOy5WeHGRR5BoRsbxd/AK/PuzP1D3hdgJzamdz1n/M7Q62z
         u8yS0ecyncyJHx7bpAyE8wTQZLz16+sD33ey3X44LgUjru36shIk/FpOMeGkagb99nyJ
         OyOBJUuDy9U2pr1laTY7lPzAlcqfGj85u7SXjoxWrQtQ9+PX28g4b5CKLRuKmCn1Jh9K
         NV9pC5qxCcob0DyblLiDVHtbhHyrvhVdVjMhPRglSACszeUy/eDyYTAZmJ967cJ0nhCg
         +oyCJkwQNyF60449cBykm2S9NtcGCvP6nQQCNK4GgUoKZNdlW1Iy9vqhX9/cC+E86ylp
         HeHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3SWil8fXUv08kqinX3hYmvZH788sYA0vKX106ff7czk=;
        b=eiA3YIXe82BzZyXHul6y7JjykC7Q7v6P8Ptw5rLuKKZT6WgyG7ZIbQzlDf4WFZn6Rk
         425L25uO9c5Yn+7HrF/HcnTtyRRLJEsalHy1WCAuCCFGbBSjvw6j8eb102SQEkFEUCbe
         //qURkdp1+VdoGB3Y2sKdC0F4ZRD8RvE3JAiXlJ4GizZUMd/WJN/eE548TCrj5Nz9lGr
         3B4EbboQRHv3cxmVBxotnzheQVfphc/wuVYEd58GZ5bz5Dw9keRPJYBtR67ALwio6nTZ
         vqeIho5jRNNoAvCqBvPtRv6i7CwAJlhHfl4a+D+AhReV8X0BUqIzYixSo8FHsttsBuj6
         oinw==
X-Gm-Message-State: APjAAAVMMgerbmCPMxYrSv0ylpo+5bP0hCWYwvsBU6KBEOigtwMarEEG
        YpoYo5YW3DCDvaNYMHSRK2c=
X-Google-Smtp-Source: APXvYqzTODQRoKzG1HhNkcjlO8yvJ9/ZOS0I9zGBBnncViYQi2ZlGKSszVlNsSZjNzEX61fRKhGKqg==
X-Received: by 2002:a2e:9812:: with SMTP id a18mr1439076ljj.146.1556147905499;
        Wed, 24 Apr 2019 16:18:25 -0700 (PDT)
Received: from localhost.localdomain (ppp94-29-35-107.pppoe.spdop.ru. [94.29.35.107])
        by smtp.gmail.com with ESMTPSA id p72sm41861lja.41.2019.04.24.16.18.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Apr 2019 16:18:24 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1] dmaengine: tegra: Use relaxed versions of readl/writel
Date:   Thu, 25 Apr 2019 02:17:08 +0300
Message-Id: <20190424231708.21219-1-digetx@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The readl/writel functions are inserting memory barrier in order to
ensure that memory stores are completed. On Tegra20 and Tegra30 this
results in L2 cache syncing which isn't a cheapest operation. The
tegra20-apb-dma driver doesn't need to synchronize generic memory
accesses, hence use the relaxed versions of the functions.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/dma/tegra20-apb-dma.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/tegra20-apb-dma.c b/drivers/dma/tegra20-apb-dma.c
index cf462b1abc0b..e646e1c7b299 100644
--- a/drivers/dma/tegra20-apb-dma.c
+++ b/drivers/dma/tegra20-apb-dma.c
@@ -241,23 +241,23 @@ struct tegra_dma {
 
 static inline void tdma_write(struct tegra_dma *tdma, u32 reg, u32 val)
 {
-	writel(val, tdma->base_addr + reg);
+	writel_relaxed(val, tdma->base_addr + reg);
 }
 
 static inline u32 tdma_read(struct tegra_dma *tdma, u32 reg)
 {
-	return readl(tdma->base_addr + reg);
+	return readl_relaxed(tdma->base_addr + reg);
 }
 
 static inline void tdc_write(struct tegra_dma_channel *tdc,
 		u32 reg, u32 val)
 {
-	writel(val, tdc->chan_addr + reg);
+	writel_relaxed(val, tdc->chan_addr + reg);
 }
 
 static inline u32 tdc_read(struct tegra_dma_channel *tdc, u32 reg)
 {
-	return readl(tdc->chan_addr + reg);
+	return readl_relaxed(tdc->chan_addr + reg);
 }
 
 static inline struct tegra_dma_channel *to_tegra_dma_chan(struct dma_chan *dc)
-- 
2.21.0

