Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 688A5C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:15:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36C7F2190A
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:15:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556126126;
	bh=R580lzfzdQEJtXUu5mhGG4c1inGPATvBJyNZdGLnAZc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AdiJ69wkI23CNFOHAfEH87FpVem3awQjedGjrV6K+CTHYSw633pEZu5ie7eLhiaVB
	 bdpvYyh/0H31D8vxjTnMKtegxh7lTUjptuF7gdmMzb7/iySiLvzC6AMR7r6u5t6w1h
	 VSJ20bLCRtV1jrSNsdD7udiCQXHNNPmPi2fiS9us=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388211AbfDXRPU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:15:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:39618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388198AbfDXRPO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:15:14 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 79B2F218B0;
        Wed, 24 Apr 2019 17:15:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556126114;
        bh=R580lzfzdQEJtXUu5mhGG4c1inGPATvBJyNZdGLnAZc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KbE1AK6allPJ/EcvDV6d6/ff/5I2ct4tBl0OgBbsiMk6FZ1Ecy0xjPCn9vyjP9YDM
         9MdSZlMTESPxGpOopwX/gWq7m6u/wlbwQ0tl6VN1X9touRQvvlHigrVcE1gMExpPr4
         v03zM68S6CS/cjVgfrpAFvSZ06FRYWo0KamiUcuc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ian Abbott <abbotti@mev.co.uk>
Subject: [PATCH 3.18 099/104] staging: comedi: ni_usb6501: Fix possible double-free of ->usb_rx_buf
Date:   Wed, 24 Apr 2019 19:09:56 +0200
Message-Id: <20190424170910.400338006@linuxfoundation.org>
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

commit af4b54a2e5ba18259ff9aac445bf546dd60d037e upstream.

`ni6501_alloc_usb_buffers()` is called from `ni6501_auto_attach()` to
allocate RX and TX buffers for USB transfers.  It allocates
`devpriv->usb_rx_buf` followed by `devpriv->usb_tx_buf`.  If the
allocation of `devpriv->usb_tx_buf` fails, it frees
`devpriv->usb_rx_buf`, leaving the pointer set dangling, and returns an
error.  Later, `ni6501_detach()` will be called from the core comedi
module code to clean up.  `ni6501_detach()` also frees both
`devpriv->usb_rx_buf` and `devpriv->usb_tx_buf`, but
`devpriv->usb_rx_buf` may have already beed freed, leading to a
double-free error.  Fix it bu removing the call to
`kfree(devpriv->usb_rx_buf)` from `ni6501_alloc_usb_buffers()`, relying
on `ni6501_detach()` to free the memory.

Signed-off-by: Ian Abbott <abbotti@mev.co.uk>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/staging/comedi/drivers/ni_usb6501.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

--- a/drivers/staging/comedi/drivers/ni_usb6501.c
+++ b/drivers/staging/comedi/drivers/ni_usb6501.c
@@ -478,10 +478,8 @@ static int ni6501_alloc_usb_buffers(stru
 
 	size = le16_to_cpu(devpriv->ep_tx->wMaxPacketSize);
 	devpriv->usb_tx_buf = kzalloc(size, GFP_KERNEL);
-	if (!devpriv->usb_tx_buf) {
-		kfree(devpriv->usb_rx_buf);
+	if (!devpriv->usb_tx_buf)
 		return -ENOMEM;
-	}
 
 	return 0;
 }


