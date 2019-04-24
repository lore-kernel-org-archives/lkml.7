Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CBEAC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:46:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CF5921773
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:46:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556127978;
	bh=XXiYrON0C4xHGI6RqUGq+OUixt+Nb+T11hfDrSwNsY8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vbvBlg1k+n7kiwGaqV29QM/RqNq6AkKg1h/p2lSDJZQwQMW59oTFaUEw31d4zPiOh
	 zLnVO4rLOdESuvQw0qpgJ7fSurHd/oLLtUGYMVmEX2H7PawSNZQfBXlJAJH2TWE7l2
	 cae4fqdq4P9fXRLiF4hLaPWzN21UTnmAHx60qKnI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391415AbfDXRcr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:32:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:59502 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391401AbfDXRco (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:32:44 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 136E42054F;
        Wed, 24 Apr 2019 17:32:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556127163;
        bh=XXiYrON0C4xHGI6RqUGq+OUixt+Nb+T11hfDrSwNsY8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1KP7mmO1ni/Oc6p+xYZAfvufSYbGLFwqx5fu13wCdFLM7LQqDFl2/sFlEIo8HNI6h
         Z+oS/iexH5CJuEysBv6Mu3DivVoB1ZwV9Zx4zv9IL6VD6iFJ/rNGWGOPj3cbbKF7/6
         9yCPwB5DgOp1og7IJFAlXigkRDJF29psecsoXgE8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ian Abbott <abbotti@mev.co.uk>
Subject: [PATCH 4.19 49/96] staging: comedi: vmk80xx: Fix possible double-free of ->usb_rx_buf
Date:   Wed, 24 Apr 2019 19:09:54 +0200
Message-Id: <20190424170923.148546767@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424170919.829037226@linuxfoundation.org>
References: <20190424170919.829037226@linuxfoundation.org>
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
@@ -682,10 +682,8 @@ static int vmk80xx_alloc_usb_buffers(str
 
 	size = usb_endpoint_maxp(devpriv->ep_tx);
 	devpriv->usb_tx_buf = kzalloc(size, GFP_KERNEL);
-	if (!devpriv->usb_tx_buf) {
-		kfree(devpriv->usb_rx_buf);
+	if (!devpriv->usb_tx_buf)
 		return -ENOMEM;
-	}
 
 	return 0;
 }


