Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9486EC5DF60
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 20:17:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 659C221882
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 20:17:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EC/SX8oo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726612AbfKGURL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 15:17:11 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37832 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725792AbfKGURJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 15:17:09 -0500
Received: by mail-wr1-f66.google.com with SMTP id t1so4572306wrv.4
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2019 12:17:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qbI1BAgAkPaImSA31avjQBXyIdfFKUwTp+KLI6AEZH0=;
        b=EC/SX8ooYqTxr5pQUlGH6g2yvyeF1kpJrkFWbvWtgr9gM5Iyl2llrDdEp7D0xc/ckc
         ylpxAJXxfPTRewHYEUFf27rRf6OgKgwfod65R20q3y8PspodxrnnoNVES54RwWuDDEpq
         SsHlynYxsuBNvn0l2/BMHVk1L0kCIEaI31sdizplPtimHczDVHahZ8j/MIxu3T9GpPTn
         M5jVzoulmUi+TraL/W6sI7/MBMMzPtNWYjvL46ILMEWPqXx2zbH0RJBFrbBv+JFvYPqr
         k+PMcl6B7+yLQprGnJqMAS3oiTZ6vHClRRoA7MElF5y2dMfk5TLqZOALfA0c6ZwIhoj/
         jyVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qbI1BAgAkPaImSA31avjQBXyIdfFKUwTp+KLI6AEZH0=;
        b=B3D+k4uwioAG57dLmHH+69lSjGNV65HYfY/8NOR94YxewCRgsCzPW6ooAp6Wiqmgod
         lYRDYNrn3zAjj/9v5Her1ninK2v9OmPIwBmMaXoe5AsA2hAfekI5KKLVWLlgECIiE8mi
         gz39nN56T3hmr7KFwLs3WwFohZ7BNXHp+4yCmzjFZ0ZiuG6/BA1dWHPKmp3HhLyH9Hku
         uDVXkBUd05dLXKXPn1caEyFXT4onqmTtFk1HVzKekHDyLXPwp3tLMBNgG0an8gcKash5
         UKw+IFHNnGJW/Lt4m9DRPXn0SaOg0WgvAJkVyCQ3OT6AHnM/XMJEtTPXaoD//6my38DZ
         3llA==
X-Gm-Message-State: APjAAAXQG0xa70V0ymS24nXfGYkVN3iS8jqKTdZ5RKJsel69+2bLrwyw
        BdgYaNjtlBHG8vJtb73ECPuoFSsDqpA=
X-Google-Smtp-Source: APXvYqwsnkG5W3lQgjzDjrPN3gpk1F2MAlnJ4iiacsTzP9kRpXXiviPWMQMCMjJN24d9pILn7v49QQ==
X-Received: by 2002:adf:8481:: with SMTP id 1mr5190613wrg.189.1573157827384;
        Thu, 07 Nov 2019 12:17:07 -0800 (PST)
Received: from localhost.localdomain ([95.147.198.88])
        by smtp.gmail.com with ESMTPSA id d11sm3215162wrn.28.2019.11.07.12.17.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2019 12:17:06 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     gregkh@google.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Sylvain Lemieux <slemieux.tyco@gmail.com>,
        James Grant <jamesg@zaltys.org>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 02/10] usb: gadget: udc: lpc32xx: allocate descriptor with GFP_ATOMIC
Date:   Thu,  7 Nov 2019 20:16:54 +0000
Message-Id: <20191107201702.27023-2-lee.jones@linaro.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191107201702.27023-1-lee.jones@linaro.org>
References: <20191107201702.27023-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexandre Belloni <alexandre.belloni@bootlin.com>

[ Upstream commit fbc318afadd6e7ae2252d6158cf7d0c5a2132f7d ]

Gadget drivers may queue request in interrupt context. This would lead to
a descriptor allocation in that context. In that case we would hit
BUG_ON(in_interrupt()) in __get_vm_area_node.

Also remove the unnecessary cast.

Acked-by: Sylvain Lemieux <slemieux.tyco@gmail.com>
Tested-by: James Grant <jamesg@zaltys.org>
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Change-Id: Iac6fdb2f664de82dde243dfa15b81e4add2198bf
---
 drivers/usb/gadget/udc/lpc32xx_udc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/usb/gadget/udc/lpc32xx_udc.c b/drivers/usb/gadget/udc/lpc32xx_udc.c
index 23d0475a9136..928e0dd2f2d3 100644
--- a/drivers/usb/gadget/udc/lpc32xx_udc.c
+++ b/drivers/usb/gadget/udc/lpc32xx_udc.c
@@ -966,8 +966,7 @@ static struct lpc32xx_usbd_dd_gad *udc_dd_alloc(struct lpc32xx_udc *udc)
 	dma_addr_t			dma;
 	struct lpc32xx_usbd_dd_gad	*dd;
 
-	dd = (struct lpc32xx_usbd_dd_gad *) dma_pool_alloc(
-			udc->dd_cache, (GFP_KERNEL | GFP_DMA), &dma);
+	dd = dma_pool_alloc(udc->dd_cache, GFP_ATOMIC | GFP_DMA, &dma);
 	if (dd)
 		dd->this_dma = dma;
 
-- 
2.24.0

