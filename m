Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D96EC04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 11:32:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 749CD2081C
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 11:32:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Mc4UZBCT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732944AbfETLcw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 07:32:52 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42363 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732933AbfETLcw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 07:32:52 -0400
Received: by mail-pg1-f195.google.com with SMTP id 145so6664710pgg.9
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 04:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=Cnx84NxIhSp4uZgqi6VSWZYaVNVqt10XSPlG8JL56aM=;
        b=Mc4UZBCTGeP16M5dC8d43FPiSMsrdIIRD0s1wJ3KIvGHw+JOobzUKZHB0Q73iG3BTg
         V1l22QS5KJy5tXZPxHsQ9Mo7fVFBsMD7FRweoPvewbBbo62lTppD8pPJHBkor7ekGe3j
         PPFqi5Wdl4B9MzR3QJGHoKzN9KO9A5aa2u6lsjS6tZ9ohu5PS1AQTwdCEgh1IVHPURc5
         Py3c2rYZyRrff+CtksSQP1kLT7g3w0aSUXqFbK2960r8YJHBAG0F6FtkWv/SXPaG5Gq8
         XKa7McsxohMfNawU7tUAhFpQfWCIpWFs89ePwMm5HMMISDMi9KE0isl13qia+OwjzVYJ
         H+fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=Cnx84NxIhSp4uZgqi6VSWZYaVNVqt10XSPlG8JL56aM=;
        b=FEgPB0fsLZ1LLJ/yUMdfsFcOVBRRKoe/ltOLTQZJeu8bdxG/l7kVJsClVDeVFldf76
         iIAu8FSKiTn9P7MDmIOivIt1LpbMjAxJap5rmrT5uX/V3uLDY0cOAkFHEU6IT7u5ohOL
         Fu+s2a9fCJYqI6ic0ZL13njET9T3eE3BNebzsWmzNKVQeiSKbSfHIeWm8OSs1mHZNaLX
         EIQ12AQn7g+V2h9CljDn3YizOMmebTA/skge8gzRDX00YAI2gTM7bJgjxoCxvENWUEoI
         LEoLHiBZpaNougtLggJov5XNM8IxJkjZz64kA1jOCiCW86VLWWP+D8k7wVE2ljItahKT
         akdw==
X-Gm-Message-State: APjAAAUww3tFGqNlkI8+Q7/1ZaoAGGE+7x3MWOHW248pD1mO/fkmzGcl
        aSfd1dd7/T4jVx3TbfGJY5UWJA==
X-Google-Smtp-Source: APXvYqwEGtRYs32a6qVJ0IDeIICdhKvEjXa4z1alPx313+QuihcD0g4n814DyWumr6jWnBbSFvUJJg==
X-Received: by 2002:a65:42cd:: with SMTP id l13mr21734824pgp.72.1558351971654;
        Mon, 20 May 2019 04:32:51 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id z124sm21310020pfz.116.2019.05.20.04.32.47
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 20 May 2019 04:32:51 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     dan.j.williams@intel.com, vkoul@kernel.org
Cc:     thierry.reding@gmail.com, jonathanh@nvidia.com,
        linux-tegra@vger.kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, wsa+renesas@sang-engineering.com,
        jroedel@suse.de, vincent.guittot@linaro.org,
        baolin.wang@linaro.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 4/8] dmaengine: dma-jz4780: Let the core do the device node validation
Date:   Mon, 20 May 2019 19:32:17 +0800
Message-Id: <231f063f65d0f4ca9a69edfb267fb82500954415.1558351667.git.baolin.wang@linaro.org>
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
 drivers/dma/dma-jz4780.c |    7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/dma-jz4780.c b/drivers/dma/dma-jz4780.c
index 9ce0a38..7e1d381 100644
--- a/drivers/dma/dma-jz4780.c
+++ b/drivers/dma/dma-jz4780.c
@@ -160,7 +160,6 @@ struct jz4780_dma_dev {
 };
 
 struct jz4780_dma_filter_data {
-	struct device_node *of_node;
 	uint32_t transfer_type;
 	int channel;
 };
@@ -765,8 +764,6 @@ static bool jz4780_dma_filter_fn(struct dma_chan *chan, void *param)
 	struct jz4780_dma_dev *jzdma = jz4780_dma_chan_parent(jzchan);
 	struct jz4780_dma_filter_data *data = param;
 
-	if (jzdma->dma_device.dev->of_node != data->of_node)
-		return false;
 
 	if (data->channel > -1) {
 		if (data->channel != jzchan->id)
@@ -790,7 +787,6 @@ static struct dma_chan *jz4780_of_dma_xlate(struct of_phandle_args *dma_spec,
 	if (dma_spec->args_count != 2)
 		return NULL;
 
-	data.of_node = ofdma->of_node;
 	data.transfer_type = dma_spec->args[0];
 	data.channel = dma_spec->args[1];
 
@@ -815,7 +811,8 @@ static struct dma_chan *jz4780_of_dma_xlate(struct of_phandle_args *dma_spec,
 		return dma_get_slave_channel(
 			&jzdma->chan[data.channel].vchan.chan);
 	} else {
-		return dma_request_channel(mask, jz4780_dma_filter_fn, &data);
+		return __dma_request_channel(&mask, jz4780_dma_filter_fn, &data,
+					     ofdma->of_node);
 	}
 }
 
-- 
1.7.9.5

