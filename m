Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 028B7C606C1
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 15:17:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFB47216E3
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 15:17:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562599028;
	bh=IAXx6J5+4g+IypF8z+h3SMSC6jRMrnV/kPpeNlSDu0M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sEcg5a3FovIAfXMYKpVxojBUhtDybd4VO/zA1DUakdTtOk0e1rmb8kbgwo2q7Le6C
	 ZI0axulKIANm5uu7CnIAJFOoO4iOf0IHcSFfx6QfQZP+5c8ZAVxWMToXPB2o2+TST0
	 hzoYOmWV/XVHjbSZdVztDW/FDfQBt1YgfTD6eiUw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732752AbfGHPRH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 11:17:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:40300 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732738AbfGHPRF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 11:17:05 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 54D6E216E3;
        Mon,  8 Jul 2019 15:17:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562599024;
        bh=IAXx6J5+4g+IypF8z+h3SMSC6jRMrnV/kPpeNlSDu0M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YiSrHkec6fFcwP02N6ZqhqvRQmAukDcXpfMPI82PLTFJrLfyMAvf/wm2pVfH5f0i0
         rEq/mOjgFWZrHK7vGaihW/N92KLP3bboTrsSMnCPLsSEtr1wIoNRD66V2j2f+D7Lw5
         54rIHQSp2JG2Qhx8bCQwmHLo7TBQ4I0WbsTKzAZw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sylvain Lemieux <slemieux.tyco@gmail.com>,
        James Grant <jamesg@zaltys.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 53/73] usb: gadget: udc: lpc32xx: allocate descriptor with GFP_ATOMIC
Date:   Mon,  8 Jul 2019 17:13:03 +0200
Message-Id: <20190708150524.153548224@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190708150513.136580595@linuxfoundation.org>
References: <20190708150513.136580595@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
index 00b5006baf15..90d24f62bd81 100644
--- a/drivers/usb/gadget/udc/lpc32xx_udc.c
+++ b/drivers/usb/gadget/udc/lpc32xx_udc.c
@@ -964,8 +964,7 @@ static struct lpc32xx_usbd_dd_gad *udc_dd_alloc(struct lpc32xx_udc *udc)
 	dma_addr_t			dma;
 	struct lpc32xx_usbd_dd_gad	*dd;
 
-	dd = (struct lpc32xx_usbd_dd_gad *) dma_pool_alloc(
-			udc->dd_cache, (GFP_KERNEL | GFP_DMA), &dma);
+	dd = dma_pool_alloc(udc->dd_cache, GFP_ATOMIC | GFP_DMA, &dma);
 	if (dd)
 		dd->this_dma = dma;
 
-- 
2.20.1



