Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5EE0C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 12:15:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9298E218A1
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 12:15:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qLRP/D/h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727481AbfDOMPZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 08:15:25 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46393 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727335AbfDOMPX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 08:15:23 -0400
Received: by mail-pf1-f194.google.com with SMTP id 9so8476310pfj.13
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2019 05:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=XiE8oaht+rMtBmlWqUkyAiRGtKqurxER2iPBNv/AZyQ=;
        b=qLRP/D/hBzlVyCM9RDEp0f+vh3r0DuWzHyoLapUEEZa49Vw6obIm07znxPAArbNXDx
         y6lOAS00ZKnidgR6SGOXa/t9lPXGvLz2q1ti+8fdgPMQz+fteVALwWaLWAie/7RPNYgl
         g6ubl5Vdy9CbG1gzDzKSgBj6TNhnWikVKlpJld4b4VDeqtqp32k3aX7QErvNQEfWWE6e
         iuq1j14ALAK4WEAVMOv7851BZgFKS2KkKlZ0dujn8lAzV3Twm+7blCirxwnLpnlfdlA+
         FBtgU/fzY7iGtpk5ap8KVOqTRhlwfUHIGmPAcKDwT927EK3tNeHmrW5+kIdlQ4osChFs
         FAxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=XiE8oaht+rMtBmlWqUkyAiRGtKqurxER2iPBNv/AZyQ=;
        b=Rav1SxelHocZ2LtX/22n5I8tkCw0J/LKeUg1LGkdv1+SHpwHQJkSzDQITcVGAcUxwc
         FWy3bO98YMemY59LFKUGkxN7M3aWdmZ4ObluWjCRVJmJ3v6H0E7OSy2LYNNDdv6EqOID
         JmaBTRCVAWz4l1hZ1Xg3u7wYkhQY9LpwFcfx8lI6o9HQFRjYbpPm8dsX5IEbsx0/ncxR
         DQaKSb9UkNO+k0UWv2vrI99wGMI6v16L/CTCSPMhc+lnZCyd1UgIsf1KniYaNpvh5fym
         ZTciuZpE694oPN2hq3aSVoxRg4umpNYAnmnrpPtB3vMUHq40rEfwNjPBQaLdsl2TzhwV
         TAoA==
X-Gm-Message-State: APjAAAWmsEUAFSHCieGvgFhwf6b6ygko39owhV1/KWufkT8ycLrKrJ7B
        bS7vUmEf4L6R/GogsUpcRFoEIg==
X-Google-Smtp-Source: APXvYqxjlmrCVN54lGUd6cUjcklkpR8/UtXRZeB3Cgyt1f6wd//reg/A3MEZcNsaUsGIwwC8zLMF9Q==
X-Received: by 2002:a63:185a:: with SMTP id 26mr43154699pgy.337.1555330522160;
        Mon, 15 Apr 2019 05:15:22 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id 6sm64157155pfj.95.2019.04.15.05.15.18
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 15 Apr 2019 05:15:21 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     dan.j.williams@intel.com, vkoul@kernel.org
Cc:     eric.long@unisoc.com, orsonzhai@gmail.com, zhang.lyra@gmail.com,
        broonie@kernel.org, baolin.wang@linaro.org,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/7] dmaengine: sprd: Add validation of current descriptor in irq handler
Date:   Mon, 15 Apr 2019 20:14:56 +0800
Message-Id: <e2f3b8f2f5391565d0662d98524acf239ae8da6e.1555330115.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1555330115.git.baolin.wang@linaro.org>
References: <cover.1555330115.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1555330115.git.baolin.wang@linaro.org>
References: <cover.1555330115.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When user terminates one DMA channel to free all its descriptors, but
at the same time one transaction interrupt was triggered possibly, now
we should not handle this interrupt by validating if the 'schan->cur_desc'
was set as NULL to avoid crashing the kernel.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/dma/sprd-dma.c |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/sprd-dma.c b/drivers/dma/sprd-dma.c
index e29342a..431e289 100644
--- a/drivers/dma/sprd-dma.c
+++ b/drivers/dma/sprd-dma.c
@@ -552,12 +552,17 @@ static irqreturn_t dma_irq_handle(int irq, void *dev_id)
 		schan = &sdev->channels[i];
 
 		spin_lock(&schan->vc.lock);
+
+		sdesc = schan->cur_desc;
+		if (!sdesc) {
+			spin_unlock(&schan->vc.lock);
+			return IRQ_HANDLED;
+		}
+
 		int_type = sprd_dma_get_int_type(schan);
 		req_type = sprd_dma_get_req_type(schan);
 		sprd_dma_clear_int(schan);
 
-		sdesc = schan->cur_desc;
-
 		/* cyclic mode schedule callback */
 		cyclic = schan->linklist.phy_addr ? true : false;
 		if (cyclic == true) {
-- 
1.7.9.5

