Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 915A5C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 11:33:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6675521019
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 11:33:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cPRtb7tQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733008AbfETLdM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 07:33:12 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:46744 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732996AbfETLdL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 07:33:11 -0400
Received: by mail-pl1-f195.google.com with SMTP id r18so6586142pls.13
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 04:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=kSx/2bQ8k2nUJmyS2liy45fCcO2iYHSDnrOKKw/RGV4=;
        b=cPRtb7tQHJTTiLOHkiEpYP+wKGEqufi5OlZI8LAVDn750p0hkPo7BlZXT75VNfp9dR
         bKCNesFU3UCDsME+gGsOPK0VHvOUsTWH5NPfg+xK8mJwmFd5vbJmaO0EKQMFmNQ+n19H
         U8mqxoNBif5syGeoUe2lEXsWbDC1YB0BzSBgumFCN8STOyMNeJCtTeNLvgnvh10BAtQu
         5J6eaQFuVUuyZhLT2t+Y0NRhAjRTWOVvbNG74UrINXey6BdbxtdfZyTEs6vh0o0X64Ku
         AulkUGud8AZoQWHpwMC3klVwa3PQ8CDJYu9MkPTAavxbcDPzAhTfuFpg/fcSO03u0aXx
         CAKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=kSx/2bQ8k2nUJmyS2liy45fCcO2iYHSDnrOKKw/RGV4=;
        b=KqwuHo6Wj5/hwxgcdG9sk0hE6lPMrz/WWxxPfXqTxmetbt9MrKmmHSR3s3ganm9T0a
         uRu4sGU80msZNGB9kNvdI7oDzVcRhLLUKRFYB+qjn0KmEu0YBJvKj4P+AwyvJ/2Kv8WL
         7ZfpvfHnX7NjHhZqb4jwZMxuZKkLy3iBbK4SwlisM1fSiNSDC7JIzkue8u3yN/r9fMkh
         i9Y2JjgovoLBnIP2e+2GCXVUb2ygwxlP+Y6DSoUS+g6I0iGrv7LR1+aZxJ+noukC0CED
         AuHkV+0MFb+3y9afYm4wOTsqkLEoL5fzWC4R/gHffus/54vDML1ioixd8FpUg1Ldo4+k
         CUgg==
X-Gm-Message-State: APjAAAWJrF/nz4um7QNDDJPRqMZ7ZpKeg+GdLUKlZVVFZ+7dA5Gqvrza
        uCdCVOKLE0efET1qi7j6dklwqA==
X-Google-Smtp-Source: APXvYqxhkwURFkAYdOsYEFVXpnFbD8H/TQI0K1REXB9rdjkjQNCy7pJURAn59WPfwElP41gCPmfnxw==
X-Received: by 2002:a17:902:18b:: with SMTP id b11mr50155937plb.264.1558351990778;
        Mon, 20 May 2019 04:33:10 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id z124sm21310020pfz.116.2019.05.20.04.33.05
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 20 May 2019 04:33:10 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     dan.j.williams@intel.com, vkoul@kernel.org
Cc:     thierry.reding@gmail.com, jonathanh@nvidia.com,
        linux-tegra@vger.kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, wsa+renesas@sang-engineering.com,
        jroedel@suse.de, vincent.guittot@linaro.org,
        baolin.wang@linaro.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 8/8] dmaengine: sh: usb-dmac: Let the core do the device node validation
Date:   Mon, 20 May 2019 19:32:21 +0800
Message-Id: <0b4418a1891261a6a4f8e8356b68e38f4ed6a1d5.1558351667.git.baolin.wang@linaro.org>
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
 drivers/dma/sh/usb-dmac.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/sh/usb-dmac.c b/drivers/dma/sh/usb-dmac.c
index 59403f6..0afabf3 100644
--- a/drivers/dma/sh/usb-dmac.c
+++ b/drivers/dma/sh/usb-dmac.c
@@ -636,9 +636,6 @@ static bool usb_dmac_chan_filter(struct dma_chan *chan, void *arg)
 	struct usb_dmac_chan *uchan = to_usb_dmac_chan(chan);
 	struct of_phandle_args *dma_spec = arg;
 
-	if (dma_spec->np != chan->device->dev->of_node)
-		return false;
-
 	/* USB-DMAC should be used with fixed usb controller's FIFO */
 	if (uchan->index != dma_spec->args[0])
 		return false;
@@ -659,7 +656,8 @@ static struct dma_chan *usb_dmac_of_xlate(struct of_phandle_args *dma_spec,
 	dma_cap_zero(mask);
 	dma_cap_set(DMA_SLAVE, mask);
 
-	chan = dma_request_channel(mask, usb_dmac_chan_filter, dma_spec);
+	chan = __dma_request_channel(&mask, usb_dmac_chan_filter, dma_spec,
+				     ofdma->of_node);
 	if (!chan)
 		return NULL;
 
-- 
1.7.9.5

