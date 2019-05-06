Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E13A5C04AAD
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 07:28:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B23752087F
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 07:28:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BIbUM15m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726327AbfEFH2y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 03:28:54 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40431 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726255AbfEFH2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 03:28:53 -0400
Received: by mail-pg1-f196.google.com with SMTP id d31so6029222pgl.7
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 00:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=yZiVOrjB2GkVNwkAlHEh8RFkK/dk9IRsTM24Q28H3wk=;
        b=BIbUM15mdf5AnhdYErzvP660w8KBiAQdvle7iP059JvrT4k+uzyqvT//ZxuanToIjD
         1Kb9X+z0JegAGTabVvBbhp740j9+Izw32tIaWryq1OWoDktcb7SFTJXvkSBBS7XIy5BS
         w/TZVda78BdDeIrOpWMJpPJlAeW2kdDO0hhjnbpr4wjtjYlJEebf+aTL7fDHI9F84eWI
         b+hqqNP3fOdVK/ZGwIf6/bOjKzgQR1ABGO4qaoTi/1KjD7SJ2JO9i/V7XHK+JE2/5OOZ
         sqZ+h030Cbc/0UU7plh6j9v/Vf5ktuW4KK9cnoS69oR0f4KFJGhBgsbgaYtwMB8gc300
         CBPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=yZiVOrjB2GkVNwkAlHEh8RFkK/dk9IRsTM24Q28H3wk=;
        b=O398iFE2ZC5p7Jwjwr/JHvtpt2axRFtsCaLLYA6mWy6ngoCO6dzx2T/oPKQe43OBr9
         87Pe4FwEwOuriJcAwJcRYXvsvay2cReAD/yd8hTPL4scFtYWlbujRBu3nx3Z1KKH82RY
         Rc2Tqopm0DgiF1pmJsUtbPgh+2oQvO4kYtv+SZ5Kbj+3iCDZmRxP8i62rSVIid9U4g9H
         ORYU3S+7xGwlINJi2tLfvVtR4+2Y5+7hedUPMH2Q8e5iIVx5oCxIeEJxc+aQtiJNNs+V
         mQX+n/ADp9ueJV/SZ2ySiHOcHxpJAvpyduWNaBkRHVzFmesfQ+gcnUZtIeU+zt8uzlSQ
         A3fA==
X-Gm-Message-State: APjAAAUW0nK7RGmfozyAfL9yWxR2RzZtzw12r5jfjIBn2YIrb+sCgArD
        Pbg1I+FwZawZd+Aad2g2bdPbJg==
X-Google-Smtp-Source: APXvYqzHzKI5EXvMMXIj3Xf2ZtcA2DXEhYvat7pS5eMq/YjxE0hsjieqQIDbWkY7srVfcJRNFsGL6g==
X-Received: by 2002:a63:5c24:: with SMTP id q36mr30268665pgb.314.1557127732915;
        Mon, 06 May 2019 00:28:52 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id w38sm21700894pgk.90.2019.05.06.00.28.49
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 06 May 2019 00:28:52 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     dan.j.williams@intel.com, vkoul@kernel.org
Cc:     eric.long@unisoc.com, orsonzhai@gmail.com, zhang.lyra@gmail.com,
        vincent.guittot@linaro.org, baolin.wang@linaro.org,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/6] dmaengine: sprd: Fix the possible crash when getting descriptor status
Date:   Mon,  6 May 2019 15:28:28 +0800
Message-Id: <a9a7084ff0914dce047a8a31bab79a9314a6e0f0.1557127239.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1557127239.git.baolin.wang@linaro.org>
References: <cover.1557127239.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1557127239.git.baolin.wang@linaro.org>
References: <cover.1557127239.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We will get a NULL virtual descriptor by vchan_find_desc() when the descriptor
has been submitted, that will crash the kernel when getting the descriptor
status.

In this case, since the descriptor has been submitted to process, but it
is not completed now, which means the descriptor is listed into the
'vc->desc_submitted' list now. So we can not get current processing descriptor
by vchan_find_desc(), but the pointer 'schan->cur_desc' will point to the
current processing descriptor, then we can use 'schan->cur_desc' to get
current processing descriptor's status to avoid this issue.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/dma/sprd-dma.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/sprd-dma.c b/drivers/dma/sprd-dma.c
index 48431e2..e29342a 100644
--- a/drivers/dma/sprd-dma.c
+++ b/drivers/dma/sprd-dma.c
@@ -625,7 +625,7 @@ static enum dma_status sprd_dma_tx_status(struct dma_chan *chan,
 		else
 			pos = 0;
 	} else if (schan->cur_desc && schan->cur_desc->vd.tx.cookie == cookie) {
-		struct sprd_dma_desc *sdesc = to_sprd_dma_desc(vd);
+		struct sprd_dma_desc *sdesc = schan->cur_desc;
 
 		if (sdesc->dir == DMA_DEV_TO_MEM)
 			pos = sprd_dma_get_dst_addr(schan);
-- 
1.7.9.5

