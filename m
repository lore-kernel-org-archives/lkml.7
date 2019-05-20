Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E03F4C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 11:33:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B28FC21019
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 11:33:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kGzjAWx0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732984AbfETLdG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 07:33:06 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40561 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732972AbfETLdG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 07:33:06 -0400
Received: by mail-pg1-f193.google.com with SMTP id d30so6670620pgm.7
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 04:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=S4gzzO6EwH6f41hdnpuqebXlIsK5G8TT4DFszJQHgV0=;
        b=kGzjAWx09b8i614qTj93eApuhAYdKFfSCQb0+hZtpocLm2MSIaH0rF9+HiZf0A+vcj
         DFTljdFN5pWcPxuYfUOJ68tQFKj30ZgtibGH2S3BXHbVCKNLZZhwrhp/XsRkXdFInukP
         Xjk9fWaCFqZJ8jZcXhR3aezzU8FJfnpD/f2ytgb8QX23t5dF/R+yuoTqXH0C0ZF9DjXK
         kK/Z6PNz6xn9BbWuEogWU+jIyoiUOisWLQVu90JBLpFdeKSeAFeaYkcaW1tllFwwnKdZ
         nJfsJF6cAcVhHJ/woNRx2z15cQYdmwdMhtceda3QpfeXnUfr/bh84yM2S2fBpXB8Pd1R
         Y6ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=S4gzzO6EwH6f41hdnpuqebXlIsK5G8TT4DFszJQHgV0=;
        b=kE82bO7m2nhGyE5dV8MD53cGtqNV0orliJDh24HOJlwsLBh5tVeGsc2pISjhHmFbOI
         LbCSdjDlPUZxs6z8+YfG3OScVXaEQDtLxV3TNzlkK2CVXV4SSgKT5U1SlgDX6H82fYYz
         nrsVbGnwpNfqAcKM8GiKtbzZ9syqwiGd68jdWnR0ABNSHWOz2+1uVxb99j7eS58aehrT
         o1Cn347j7bsMsEDCgHRdbLzLDc4O7ojIxfqqp1AEJuT+gEXB0eYSaBzR0FY2hCwJe8zx
         UwXoK/5O2tjmkHgvHXfOWASSWuVCaYmKPQiE0jNwNMyUZNRUVTQJ5xmAAL6M6o0x15WL
         8ijg==
X-Gm-Message-State: APjAAAX1aHppyj/VsvlXV60J6tkqf0/v8kRCjGgSNolg+6M5LCklerdU
        NLxPm3XKEKL3tigqa4H8jNmgbA==
X-Google-Smtp-Source: APXvYqz1+ao7UVqG40GQmasG5WxCT+39UIx+E5Jw485BRv+ugxfxElvHdFQ11VJd43Wx3nTx7nGipA==
X-Received: by 2002:a63:6cc5:: with SMTP id h188mr13909311pgc.105.1558351985496;
        Mon, 20 May 2019 04:33:05 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id z124sm21310020pfz.116.2019.05.20.04.33.00
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 20 May 2019 04:33:05 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     dan.j.williams@intel.com, vkoul@kernel.org
Cc:     thierry.reding@gmail.com, jonathanh@nvidia.com,
        linux-tegra@vger.kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, wsa+renesas@sang-engineering.com,
        jroedel@suse.de, vincent.guittot@linaro.org,
        baolin.wang@linaro.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 7/8] dmaengine: sh: rcar-dmac: Let the core do the device node validation
Date:   Mon, 20 May 2019 19:32:20 +0800
Message-Id: <6e544656cea22f93bdb2626620b381b00d1b38bf.1558351667.git.baolin.wang@linaro.org>
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
 drivers/dma/sh/rcar-dmac.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/sh/rcar-dmac.c b/drivers/dma/sh/rcar-dmac.c
index 33ab1b6..67df54a 100644
--- a/drivers/dma/sh/rcar-dmac.c
+++ b/drivers/dma/sh/rcar-dmac.c
@@ -1654,8 +1654,7 @@ static bool rcar_dmac_chan_filter(struct dma_chan *chan, void *arg)
 	 * Forcing it to call dma_request_channel() and iterate through all
 	 * channels from all controllers is just pointless.
 	 */
-	if (chan->device->device_config != rcar_dmac_device_config ||
-	    dma_spec->np != chan->device->dev->of_node)
+	if (chan->device->device_config != rcar_dmac_device_config)
 		return false;
 
 	return !test_and_set_bit(dma_spec->args[0], dmac->modules);
@@ -1675,7 +1674,8 @@ static struct dma_chan *rcar_dmac_of_xlate(struct of_phandle_args *dma_spec,
 	dma_cap_zero(mask);
 	dma_cap_set(DMA_SLAVE, mask);
 
-	chan = dma_request_channel(mask, rcar_dmac_chan_filter, dma_spec);
+	chan = __dma_request_channel(&mask, rcar_dmac_chan_filter, dma_spec,
+				     ofdma->of_node);
 	if (!chan)
 		return NULL;
 
-- 
1.7.9.5

