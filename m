Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4979C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 17:48:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA64D21873
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 17:48:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZK++xmKu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727411AbfCTRs1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 13:48:27 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:46935 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727103AbfCTRsY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 13:48:24 -0400
Received: by mail-lj1-f195.google.com with SMTP id z26so2990322lja.13;
        Wed, 20 Mar 2019 10:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GwYNiu8yIWI3Q9wqZ1wcU3AHJ+j3+pORIgl4ynqCl7E=;
        b=ZK++xmKuSwNM5000UaN5YDhLz5YwoBJFyBrig31lHssklwrkLv4Q7tAiiBYHAw47ca
         RtEHhw5cq8ywnW+zAYoHRdE6U6gxhFYnaUv3a7PMIV3KcfpVTx+q1xyYOF6LrphkKglZ
         x3bZq8+bbX+NXlIAxg6gyI+dEEMLOiKF/L12W1RP7tzHMuDTC+1ReQRv3ciaKPi8JQ3o
         T8Wh0AkVLfRvRoNaf91lZZcbtVo9cygCzKAwhh98s3b6M/dstOw7WT+hc1xZtQtMbrrq
         UjXlR3gu/KsQb0AcpzRTQTrmS2/Lzfhq7E+TTv0E0foKlhfMrxR9ZD59fNbpLc+N3+RN
         qRTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GwYNiu8yIWI3Q9wqZ1wcU3AHJ+j3+pORIgl4ynqCl7E=;
        b=krS0h2l+p2IZYgt3OEGBg1p2FLGJbM83V15uieku2nQzfieXyQ5GK5b/6FvtNSKweL
         xE45mbPbqkOmADJ2xXg8wnK3OUXfRN8a6TzVlRSXv8o++q5CTcOusy762iL0tTilZs6M
         v1Js73eITrENNd80AExFSim+QWqC/1iaWomiAEbYA/m6SFzolju3JN5mvXVV9jvPr3wx
         MdGRfDe6hy/6DPyxKJOeKuBvcWPlXV/DV3lvN5WhWZJi31kGgJG4T5YXFxdQGIp5P1vG
         U5M+lQhJKCDFW0HD6mkqwCUhv2F/OwDO03jf2T9CY5tHxa3b71Ev05h8UjyoHUyBS1iI
         of6Q==
X-Gm-Message-State: APjAAAVH92m+1mKcJaQ8qz1pUi++EQchyrLrw7wwnsN3CG6HjSeAmqM6
        PgrIOryz1/NzRe6dre4gYOpmc8e+
X-Google-Smtp-Source: APXvYqyeF/eSetNw3zqNaX4wFhR3LHAufxVgDX775K8UY2FHJlyAb9qjRNZYY0VJjbmxCfmthFSbFQ==
X-Received: by 2002:a2e:9597:: with SMTP id w23mr10922036ljh.111.1553104102469;
        Wed, 20 Mar 2019 10:48:22 -0700 (PDT)
Received: from ubuntu.lintech.local ([80.87.144.137])
        by smtp.gmail.com with ESMTPSA id m19sm479959lfb.78.2019.03.20.10.48.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Mar 2019 10:48:21 -0700 (PDT)
From:   Alexander Kochetkov <al.kochet@gmail.com>
To:     Jaehoon Chung <jh80.chung@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Alexander Kochetkov <al.kochet@gmail.com>
Subject: [PATCH 1/2] mmc: dw_mmc: add init_slot() hook to platform function table
Date:   Wed, 20 Mar 2019 20:48:04 +0300
Message-Id: <1553104085-32312-2-git-send-email-al.kochet@gmail.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1553104085-32312-1-git-send-email-al.kochet@gmail.com>
References: <1553104085-32312-1-git-send-email-al.kochet@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The init_slot() hook allow platform driver override slot defaults
provided by generic dw_mmc driver. It's required to fix EDMA based
transfer hangs observed on rockchip rk3188.

Signed-off-by: Alexander Kochetkov <al.kochet@gmail.com>
---
 drivers/mmc/host/dw_mmc.c |    4 ++++
 drivers/mmc/host/dw_mmc.h |    2 ++
 2 files changed, 6 insertions(+)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 80dc2fd..d3ecee9 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -2819,6 +2819,7 @@ static int dw_mci_init_slot_caps(struct dw_mci_slot *slot)
 
 static int dw_mci_init_slot(struct dw_mci *host)
 {
+	const struct dw_mci_drv_data *drv_data = host->drv_data;
 	struct mmc_host *mmc;
 	struct dw_mci_slot *slot;
 	int ret;
@@ -2876,6 +2877,9 @@ static int dw_mci_init_slot(struct dw_mci *host)
 		mmc->max_seg_size = mmc->max_req_size;
 	}
 
+	if (drv_data && drv_data->init_slot)
+		drv_data->init_slot(host);
+
 	dw_mci_get_cd(mmc);
 
 	ret = mmc_add_host(mmc);
diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
index 46e9f8e..de51c59 100644
--- a/drivers/mmc/host/dw_mmc.h
+++ b/drivers/mmc/host/dw_mmc.h
@@ -548,6 +548,7 @@ struct dw_mci_slot {
  * @caps: mmc subsystem specified capabilities of the controller(s).
  * @num_caps: number of capabilities specified by @caps.
  * @init: early implementation specific initialization.
+ * @init_slot: platform specific slot initialization.
  * @set_ios: handle bus specific extensions.
  * @parse_dt: parse implementation specific device tree properties.
  * @execute_tuning: implementation specific tuning procedure.
@@ -560,6 +561,7 @@ struct dw_mci_drv_data {
 	unsigned long	*caps;
 	u32		num_caps;
 	int		(*init)(struct dw_mci *host);
+	void		(*init_slot)(struct dw_mci *host);
 	void		(*set_ios)(struct dw_mci *host, struct mmc_ios *ios);
 	int		(*parse_dt)(struct dw_mci *host);
 	int		(*execute_tuning)(struct dw_mci_slot *slot, u32 opcode);
-- 
1.7.9.5

