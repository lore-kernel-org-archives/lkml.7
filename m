Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70B3CC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 17:48:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4757221873
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 17:48:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WAuQEzpG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727427AbfCTRsb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 13:48:31 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:45780 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726438AbfCTRs0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 13:48:26 -0400
Received: by mail-lf1-f67.google.com with SMTP id 5so2532915lft.12;
        Wed, 20 Mar 2019 10:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0E6xQZ+auWvet4Xcp79XBuUAWGpSmBQziO8fsTek7SA=;
        b=WAuQEzpGuPs6NFILtsb1ghIJPeE7TA7gryuq7o2f+YMsMVnT5wwYD2mNSdwpwmO4Lw
         GK/Nm5cy++oAMnbntXq9Os+V8prBDtscoiw0/6Nky8oTx8r5pck2LljHO+tO2C4lerlf
         dsEXHoyy8N/fKgDpd4+4zo48jWYv7Wd6+MHcWsCvZiFY+qdGKkkHe5/8SWEyN0CiFk+Q
         OQHcTWTD2hK00jP9uC8gM0NuYb54HalDlrtrvP++Triwely2oODVsRZlMCVLcOPE8oQP
         AKfPkW2BoXCau3TAd7G1qF32pq4Gd441PSbsayBfhEmI3nB2Nhe3OQVHFdHmJYSsVLfz
         MAbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0E6xQZ+auWvet4Xcp79XBuUAWGpSmBQziO8fsTek7SA=;
        b=DHdI+wATDc0tMuTygI1/GuMDTqQCdByhWhJAv4uERPmhRvmekTouXoXsK7b0tMIKNh
         cMLgFmHu3ao9VqTsjUOqBJ3A/EDuPbISFNqCYpOBSJNgAz122VE9Q6yt7yRoCwsjTlak
         Lpu8Dm9TE99dkxw4GOU4YjjLWdUNQMhcbbJBgLj8IJNu853ARZ9pc+17smAL06m20XsX
         PkY0RCcjFin1RwE4M7uQPvCtUuRABwmsA6xzrM3wBovxDPJksTad1MBWJfuFWUa5h2/X
         WCvuPZy/698zJ9CIzcrQo4wKHoVd9C77H2dmmj36MFiOjPHQec1EqY+h7P69HLEypzBT
         QvdA==
X-Gm-Message-State: APjAAAVpoCFrZ+Bdr0eNebQfTbW8z8p3325JBQsF53icV27jdKZs/ATk
        HZu7H1usVEbZFxQAyhtiF7E=
X-Google-Smtp-Source: APXvYqztN7jsAEaMxsvSCIAP5Y7C6hLZ8itdssoOAfIgoR8Wmsn+ea7gdoZl9nAe/a4U47u+WmwKUg==
X-Received: by 2002:a19:5217:: with SMTP id m23mr16664029lfb.19.1553104103535;
        Wed, 20 Mar 2019 10:48:23 -0700 (PDT)
Received: from ubuntu.lintech.local ([80.87.144.137])
        by smtp.gmail.com with ESMTPSA id m19sm479959lfb.78.2019.03.20.10.48.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Mar 2019 10:48:23 -0700 (PDT)
From:   Alexander Kochetkov <al.kochet@gmail.com>
To:     Jaehoon Chung <jh80.chung@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Alexander Kochetkov <al.kochet@gmail.com>
Subject: [PATCH 2/2] mmc: dw_mmc-rockchip: fix transfer hangs on rk3188
Date:   Wed, 20 Mar 2019 20:48:05 +0300
Message-Id: <1553104085-32312-3-git-send-email-al.kochet@gmail.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1553104085-32312-1-git-send-email-al.kochet@gmail.com>
References: <1553104085-32312-1-git-send-email-al.kochet@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I've found that sometimes dw_mmc in my rk3188 based board stop transfer
any data with error:

kernel: dwmmc_rockchip 1021c000.dwmmc: Unexpected command timeout, state 3

Further digging into problem showed that sometimes one of EDMA-based
transfers hangs and abort with HTO error. I've made test, that 100%
reproduce the error. I found, that setting max_segs parameter to 1 fix
the problem.

I guess the problem is hardware related and relates to DMA controller
implementation for rk3188. Probably it can relates to missed FLUSHP,
see commit 271e1b86e691 ("dmaengine: pl330: add quirk for broken no
flushp"). It is possible that pl330 and dw_mmc become out of sync then
pl330 driver switch from one scatterlist to another. If we limit
scatterlist size to 1, we can avoid switching scatterlists and avoid
hardware problem. Setting max_segs to 1 tells mmc core to use maximum
one scatterlist for one transfer.

I guess that all other rk3xxx chips that lacks FLUSHP also affected by
the problem. So I made fix for all rk3xxx chips from rk2928 to rk3188.

Signed-off-by: Alexander Kochetkov <al.kochet@gmail.com>
---
 drivers/mmc/host/dw_mmc-rockchip.c |   19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/mmc/host/dw_mmc-rockchip.c b/drivers/mmc/host/dw_mmc-rockchip.c
index 8c86a80..2eed922 100644
--- a/drivers/mmc/host/dw_mmc-rockchip.c
+++ b/drivers/mmc/host/dw_mmc-rockchip.c
@@ -292,6 +292,24 @@ static int dw_mci_rk3288_parse_dt(struct dw_mci *host)
 	return 0;
 }
 
+static void dw_mci_rk2928_init_slot(struct dw_mci *host)
+{
+	struct mmc_host *mmc = host->slot->mmc;
+
+	if (host->use_dma == TRANS_MODE_EDMAC) {
+		/*
+		 * Using max_segs > 1 leads to rare EDMA transfer hangs
+		 * resulting in HTO errors.
+		 */
+		mmc->max_segs = 1;
+		mmc->max_blk_size = 65535;
+		mmc->max_blk_count = 64 * 512;
+		mmc->max_req_size =
+				mmc->max_blk_size * mmc->max_blk_count;
+		mmc->max_seg_size = mmc->max_req_size;
+	}
+}
+
 static int dw_mci_rockchip_init(struct dw_mci *host)
 {
 	/* It is slot 8 on Rockchip SoCs */
@@ -314,6 +332,7 @@ static int dw_mci_rockchip_init(struct dw_mci *host)
 
 static const struct dw_mci_drv_data rk2928_drv_data = {
 	.init			= dw_mci_rockchip_init,
+	.init_slot		= dw_mci_rk2928_init_slot,
 };
 
 static const struct dw_mci_drv_data rk3288_drv_data = {
-- 
1.7.9.5

