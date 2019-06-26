Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DED97C4646B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 03:48:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A337F205ED
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 03:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561520930;
	bh=vCYeM5EFMB1SOUuq5Ofz12ylpaMRCJKxg1kTA73sMW8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ps1AT3cvSLovc+1Qf31iDcdDgxPGM8Vy/d5s0720We8pytxETSMo3zmI5UAj+1Ask
	 8vVTleFnJo+Z/iiqWFiwSQglQZE/08W2qlLWjvT23ywe0Y9XgytxhaZE7gvby7kkdW
	 nEBS5vTSiZulRHoSI8rhH0tcGjKsC3fmVX6WiVpg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727567AbfFZDoa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 23:44:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:55758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727069AbfFZDoZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 23:44:25 -0400
Received: from sasha-vm.mshome.net (mobile-107-77-172-98.mobile.att.net [107.77.172.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 20FE72082F;
        Wed, 26 Jun 2019 03:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561520664;
        bh=vCYeM5EFMB1SOUuq5Ofz12ylpaMRCJKxg1kTA73sMW8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rXCC5w0/7foQK+VazHhcGztGtD/B3ic+MgNxE1fxC9LnkCxqMQxqoO1m+rHsquAz4
         1+eJTxqyciNaHkpqDcR6bGKuVKTpGyNNfTmYD6i9CICjWx6+Ep+/r0LjZhCy2enbqv
         XN02pp01LT08MqHyD4SdrQ82sdbXXv/420wSvINs=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Sylvain Lemieux <slemieux.tyco@gmail.com>,
        James Grant <jamesg@zaltys.org>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>, linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 18/34] usb: gadget: udc: lpc32xx: allocate descriptor with GFP_ATOMIC
Date:   Tue, 25 Jun 2019 23:43:19 -0400
Message-Id: <20190626034335.23767-18-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190626034335.23767-1-sashal@kernel.org>
References: <20190626034335.23767-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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
---
 drivers/usb/gadget/udc/lpc32xx_udc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/usb/gadget/udc/lpc32xx_udc.c b/drivers/usb/gadget/udc/lpc32xx_udc.c
index b0781771704e..eafc2a00c96a 100644
--- a/drivers/usb/gadget/udc/lpc32xx_udc.c
+++ b/drivers/usb/gadget/udc/lpc32xx_udc.c
@@ -922,8 +922,7 @@ static struct lpc32xx_usbd_dd_gad *udc_dd_alloc(struct lpc32xx_udc *udc)
 	dma_addr_t			dma;
 	struct lpc32xx_usbd_dd_gad	*dd;
 
-	dd = (struct lpc32xx_usbd_dd_gad *) dma_pool_alloc(
-			udc->dd_cache, (GFP_KERNEL | GFP_DMA), &dma);
+	dd = dma_pool_alloc(udc->dd_cache, GFP_ATOMIC | GFP_DMA, &dma);
 	if (dd)
 		dd->this_dma = dma;
 
-- 
2.20.1

