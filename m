Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4698DC04E87
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 11:32:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D5A220863
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 11:32:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QKc8XOBs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732956AbfETLc5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 07:32:57 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33891 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732946AbfETLc4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 07:32:56 -0400
Received: by mail-pf1-f196.google.com with SMTP id n19so7106797pfa.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 04:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=SIcVyU2wUJ5jnbmBXFPsqnRHsqNC2CkR/vX822PSMOY=;
        b=QKc8XOBsWShq6QEmKaBcAza24sj5L89yQgva5BBJBD15azjrDgyggyl2Y6xH7l9m0+
         qnbIVd8x46sGrGKbAFeOh9JcMuN8/8jHVUwKDDhLh5QIfnAQQVJcZo5GHolCqHVWUW1O
         HOOJE3BxF5szua4H8FJtxAzbduLES4VIQYRkDnjzWncNLnDgwlxQgwChnpNXpKFovDT6
         4ZR45hFmVZ3QeHbNTfQ+mYMUwLMzZPT9tDEZSw9OLO4EKIVIp293+huklSqG+P9pT0sK
         JqjJIHo8V9bygr+sN87cZAnBBnSAcX+nCot+RqBM0luM5W3PidNFeReMZjG/yi3x4T1B
         DwzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=SIcVyU2wUJ5jnbmBXFPsqnRHsqNC2CkR/vX822PSMOY=;
        b=dGB5mFZAPBgwFPVFDcFzYYwukSpN173oOL2565dHLBz0b4mvloST1AufrRvVVmrP+r
         oqhNb7d3MvhDD72Sr9ZaMZoOEET1rPZnEJY+v0Q0hbJNEqBlUvsW6n8RHsKu/196PCb2
         Nclcs2wSb390Hauu3x7zJr0Kv/+OPMwqmmg8hZU+xQdstCNigupWd6DrMLXiBpBXw4TW
         42lWL4ImzLMOgHg9SITqjbxOy2XyBrjlK8Ee2CRXLNWnffeQ2hv4TsPorV6tLU2V+qF0
         bUi3Gcph0JZPjfkFpBoivU29529wfvZjN571RwpJgoJUl6mSnBGSMyrOQ3yG1P/V6MCD
         aokg==
X-Gm-Message-State: APjAAAUQ43Z4RfCH3iyqmtw98ojfuyvAQyyF8VOFczTehAriKfyOJ7nD
        Qio7hpih5vWKZuKQ2Zj+uDMvmWmi7ubsvg==
X-Google-Smtp-Source: APXvYqxLeHaPHSHfiQmInEnHejopO5Ea8Zrwi3xZ14RXUo26VmHyfg5o1zIlWo3HHOh+5pmpHodGlw==
X-Received: by 2002:a63:184:: with SMTP id 126mr48415643pgb.420.1558351976125;
        Mon, 20 May 2019 04:32:56 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id z124sm21310020pfz.116.2019.05.20.04.32.51
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 20 May 2019 04:32:55 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     dan.j.williams@intel.com, vkoul@kernel.org
Cc:     thierry.reding@gmail.com, jonathanh@nvidia.com,
        linux-tegra@vger.kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, wsa+renesas@sang-engineering.com,
        jroedel@suse.de, vincent.guittot@linaro.org,
        baolin.wang@linaro.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 5/8] dmaengine: mmp_tdma: Let the core do the device node validation
Date:   Mon, 20 May 2019 19:32:18 +0800
Message-Id: <5600ce71701aac33035d78bf038d97ca331bf18b.1558351667.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1558351667.git.baolin.wang@linaro.org>
References: <cover.1558351667.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1558351667.git.baolin.wang@linaro.org>
References: <cover.1558351667.git.baolin.wang@linaro.org>
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

