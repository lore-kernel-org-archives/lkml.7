Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 458A6C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:15:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16198206BA
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:15:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556126117;
	bh=q/XacYOV9TgfTbRiEOOedtvOy9Bf17HFY0BLcZIqsGg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cAcT458t3wLWdzaOMipRs7iEMFRzpJWNuvQHkaTskexISviYc8z7s6pX6kgSO42s2
	 bQcAhXC58Bp4K/TCX2UMfAElu2I1EjveG7/h8g3XSJiQKONPCnhbuaoSaHG4B7tEAc
	 yyoUY5/Ji7fjEwLE8ZcujqW511zwx8L78TnJVTxc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388201AbfDXRPP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:15:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:39558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388193AbfDXRPM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:15:12 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DA3562054F;
        Wed, 24 Apr 2019 17:15:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556126111;
        bh=q/XacYOV9TgfTbRiEOOedtvOy9Bf17HFY0BLcZIqsGg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jUr1SOURO/zyDihzxuLU4vUdHZH62MS9O/8pkgWePNC055cvkw2ba6BLXasPkL9Cc
         MFeo5r71PeGipQ0/D52MlI1zVxLDfTJCtvAuBzRIEVnxzRP+RRZwwtT65FDualkhWI
         mj0LAZ5MRu8xgIdhm81Uzc4v0bC7tVbCZTD4gaK4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ian Abbott <abbotti@mev.co.uk>
Subject: [PATCH 3.18 098/104] staging: comedi: vmk80xx: Fix possible double-free of ->usb_rx_buf
Date:   Wed, 24 Apr 2019 19:09:55 +0200
Message-Id: <20190424170910.236996666@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424170839.996641496@linuxfoundation.org>
References: <20190424170839.996641496@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ian Abbott <abbotti@mev.co.uk>

commit 663d294b4768bfd89e529e069bffa544a830b5bf upstream.

`vmk80xx_alloc_usb_buffers()` is called from `vmk80xx_auto_attach()` to
allocate RX and TX buffers for USB transfers.  It allocates
`devpriv->usb_rx_buf` followed by `devpriv->usb_tx_buf`.  If the
allocation of `devpriv->usb_tx_buf` fails, it frees
`devpriv->usb_rx_buf`,  leaving the pointer set dangling, and returns an
error.  Later, `vmk80xx_detach()` will be called from the core comedi
module code to clean up.  `vmk80xx_detach()` also frees both
`devpriv->usb_rx_buf` and `devpriv->usb_tx_buf`, but
`devpriv->usb_rx_buf` may have already been freed, leading to a
double-free error.  Fix it by removing the call to
`kfree(devpriv->usb_rx_buf)` from `vmk80xx_alloc_usb_buffers()`, relying
on `vmk80xx_detach()` to free the memory.

Signed-off-by: Ian Abbott <abbotti@mev.co.uk>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/staging/comedi/drivers/vmk80xx.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

--- a/drivers/staging/comedi/drivers/vmk80xx.c
+++ b/drivers/staging/comedi/drivers/vmk80xx.c
@@ -757,10 +757,8 @@ static int vmk80xx_alloc_usb_buffers(str
 
 	size = le16_to_cpu(devpriv->ep_tx->wMaxPacketSize);
 	devpriv->usb_tx_buf = kzalloc(size, GFP_KERNEL);
-	if (!devpriv->usb_tx_buf) {
-		kfree(devpriv->usb_rx_buf);
+	if (!devpriv->usb_tx_buf)
 		return -ENOMEM;
-	}
 
 	return 0;
 }


