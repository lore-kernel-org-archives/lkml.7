Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76E6AC004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 06:10:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48C9120C01
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 06:10:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uzv8EVMR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726964AbfEGGKf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 02:10:35 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41384 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726486AbfEGGKd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 02:10:33 -0400
Received: by mail-pf1-f193.google.com with SMTP id l132so3121062pfc.8
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 23:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=SIcVyU2wUJ5jnbmBXFPsqnRHsqNC2CkR/vX822PSMOY=;
        b=uzv8EVMR3eIzQHGMxtSinQ33vYdmES17QK9vAF+is0gNJPHupQ6KVAf610h40rDqTl
         mKBgUTk+Ut4Bj4VyJSGfixnwuP75KxLZ3rR/dD2erhsgubg4C/SDOyF3lwNeXv/ZK/Uz
         vqb4YQm36emaqBt81ttPnG4INyLLePjLgEmt1v999Hrge64h4BYHk6qG/Mm0fiZHHeZ6
         +SOakh5BXaVbgLcpXRF457kFitWiq+XbN65xMG0L42NrHyiIk6ZXZ65Ekx2ps3k33kBs
         wFL151kgbUjIgQ1PyFgu6oGhvnecnO7t3n2+7Rq3rM0GwUhfQR9XNOT1c9vmI362POjI
         D3/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=SIcVyU2wUJ5jnbmBXFPsqnRHsqNC2CkR/vX822PSMOY=;
        b=BJsAVCd+cFIfBK1QBs0ZX+FLBYxidyyL0TFfZca/MLQOhSant9E4QCabH5jyIIy+MZ
         zUlS9ebvroiyegYH/i8jsfCcfwGDy1G+ObogPibcVbOguWdLR5EP7i4GoIiWfjmsauN9
         O2wzOtPnf/YAEYa6mIqd/blfkfocPn4083SS1vPsVqgl7MvrcNaCWXGHzz7BSsfqkemq
         MBwVfFv2zZRMSF6iXaBs+T79d9aEidu8fMTKFpHzVsegWJs2TQ1Wf2mqujPDm72hk0ef
         1RpjYbcKlcFY+hvry2+cehqqz3m2SVSlqy5/xsADSHCphVFBqqT5rpkh/B1aM++VY0YU
         rKbA==
X-Gm-Message-State: APjAAAWN0ZgdLBTvfECe0QfJuRBrJHBBCDCD5O5ykC8AmScG3cN+4zo4
        XpbvRlEDK1sVsmj6gOB5/m6cdQ==
X-Google-Smtp-Source: APXvYqxJz/xZPJSmy2/wQh18OVGnuvH8hrc1Fkm+22VpZKanUEMOAKKkcCUjI1avaibd+/UwNwKGfw==
X-Received: by 2002:aa7:98c6:: with SMTP id e6mr226683pfm.191.1557209433209;
        Mon, 06 May 2019 23:10:33 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id e184sm30786325pfc.102.2019.05.06.23.10.28
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 06 May 2019 23:10:32 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     dan.j.williams@intel.com, vkoul@kernel.org
Cc:     thierry.reding@gmail.com, jonathanh@nvidia.com,
        linux-tegra@vger.kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, Zubair.Kakakhel@imgtec.com,
        wsa+renesas@sang-engineering.com, jroedel@suse.de,
        vincent.guittot@linaro.org, baolin.wang@linaro.org,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 5/8] dmaengine: mmp_tdma: Let the core do the device node validation
Date:   Tue,  7 May 2019 14:09:42 +0800
Message-Id: <1c420603d220b1ab28f7d98165bb37feaf706f61.1557206859.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1557206859.git.baolin.wang@linaro.org>
References: <cover.1557206859.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1557206859.git.baolin.wang@linaro.org>
References: <cover.1557206859.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let the DMA engine core do the device node validation instead of drivers.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/dma/mmp_tdma.c |   10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/dma/mmp_tdma.c b/drivers/dma/mmp_tdma.c
index 0c56faa0..e76858b 100644
--- a/drivers/dma/mmp_tdma.c
+++ b/drivers/dma/mmp_tdma.c
@@ -586,18 +586,12 @@ static int mmp_tdma_chan_init(struct mmp_tdma_device *tdev,
 }
 
 struct mmp_tdma_filter_param {
-	struct device_node *of_node;
 	unsigned int chan_id;
 };
 
 static bool mmp_tdma_filter_fn(struct dma_chan *chan, void *fn_param)
 {
 	struct mmp_tdma_filter_param *param = fn_param;
-	struct mmp_tdma_chan *tdmac = to_mmp_tdma_chan(chan);
-	struct dma_device *pdma_device = tdmac->chan.device;
-
-	if (pdma_device->dev->of_node != param->of_node)
-		return false;
 
 	if (chan->chan_id != param->chan_id)
 		return false;
@@ -615,13 +609,13 @@ static struct dma_chan *mmp_tdma_xlate(struct of_phandle_args *dma_spec,
 	if (dma_spec->args_count != 1)
 		return NULL;
 
-	param.of_node = ofdma->of_node;
 	param.chan_id = dma_spec->args[0];
 
 	if (param.chan_id >= TDMA_CHANNEL_NUM)
 		return NULL;
 
-	return dma_request_channel(mask, mmp_tdma_filter_fn, &param);
+	return __dma_request_channel(&mask, mmp_tdma_filter_fn, &param,
+				     ofdma->of_node);
 }
 
 static const struct of_device_id mmp_tdma_dt_ids[] = {
-- 
1.7.9.5

