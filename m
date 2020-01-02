Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23BA8C3276C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 22:40:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFBE521835
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 22:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578004842;
	bh=DrMkQubWzL8TRWQ6BdEhxtUI4bDasxnhwOZ4Cpj6aeM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=g/CHvvO11AheiiwLLVL1n7U+WbVNcQPbpAnwfkOPe9FA4byrgH4Or/AQh8TuYtyrJ
	 +Jj6CAyJ2ROxQ1zwfRPkTpaaUlp7y5A5Q/z3wKvX3CVhI4J1tZUgCGVYg7mDvBlfLV
	 yT/GMzqt/Pu/YrMx4SwQhscu8fY87FCVbVD99rYg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731200AbgABWkk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 17:40:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:51778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731273AbgABWiL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 17:38:11 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A5AE9217F4;
        Thu,  2 Jan 2020 22:38:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578004691;
        bh=DrMkQubWzL8TRWQ6BdEhxtUI4bDasxnhwOZ4Cpj6aeM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vqC7JMZD52O50zOqq0F5QKnZzv9WRZHsKMxc+VbzKyD+DnQMllsEV2Fz40e+BegwD
         dbP0i9HiAcdlVIw5SOAt1XQW8JSTabTqMUjiw8NojS/MNASzAb/cprAtjTA7bukQu0
         Yzj9nfLrUzprfbWETc7toXH8MWdsC+qt9QRobZzo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ian Abbott <abbotti@mev.co.uk>
Subject: [PATCH 4.4 085/137] staging: comedi: gsc_hpdi: check dma_alloc_coherent() return value
Date:   Thu,  2 Jan 2020 23:07:38 +0100
Message-Id: <20200102220558.121434781@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200102220546.618583146@linuxfoundation.org>
References: <20200102220546.618583146@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ian Abbott <abbotti@mev.co.uk>

commit ab42b48f32d4c766420c3499ee9c0289b7028182 upstream.

The "auto-attach" handler function `gsc_hpdi_auto_attach()` calls
`dma_alloc_coherent()` in a loop to allocate some DMA data buffers, and
also calls it to allocate a buffer for a DMA descriptor chain.  However,
it does not check the return value of any of these calls.  Change
`gsc_hpdi_auto_attach()` to return `-ENOMEM` if any of these
`dma_alloc_coherent()` calls fail.  This will result in the comedi core
calling the "detach" handler `gsc_hpdi_detach()` as part of the
clean-up, which will call `gsc_hpdi_free_dma()` to free any allocated
DMA coherent memory buffers.

Cc: <stable@vger.kernel.org> #4.6+
Signed-off-by: Ian Abbott <abbotti@mev.co.uk>
Link: https://lore.kernel.org/r/20191216110823.216237-1-abbotti@mev.co.uk
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/staging/comedi/drivers/gsc_hpdi.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

--- a/drivers/staging/comedi/drivers/gsc_hpdi.c
+++ b/drivers/staging/comedi/drivers/gsc_hpdi.c
@@ -632,12 +632,22 @@ static int gsc_hpdi_auto_attach(struct c
 		devpriv->dio_buffer[i] =
 		    pci_alloc_consistent(pcidev, DMA_BUFFER_SIZE,
 					 &devpriv->dio_buffer_phys_addr[i]);
+		if (!devpriv->dio_buffer[i]) {
+			dev_warn(dev->class_dev,
+				 "failed to allocate DMA buffer\n");
+			return -ENOMEM;
+		}
 	}
 	/* allocate dma descriptors */
 	devpriv->dma_desc = pci_alloc_consistent(pcidev,
 						 sizeof(struct plx_dma_desc) *
 						 NUM_DMA_DESCRIPTORS,
 						 &devpriv->dma_desc_phys_addr);
+	if (!devpriv->dma_desc) {
+		dev_warn(dev->class_dev,
+			 "failed to allocate DMA descriptors\n");
+		return -ENOMEM;
+	}
 	if (devpriv->dma_desc_phys_addr & 0xf) {
 		dev_warn(dev->class_dev,
 			 " dma descriptors not quad-word aligned (bug)\n");


