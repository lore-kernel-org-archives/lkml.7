Return-Path: <SRS0=vISB=2T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1955C2D0CE
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 17:35:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71E5D20722
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 17:35:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577640952;
	bh=GkB5R2UJ6ARn4a70f3TzS5/TimRwnPueAlRS5du8h58=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aklCrJ4PMYGp1PLexyJv1k4dTh/kQs2h0iZMtrh8PFgtm2mTvhWy217cPsRIEacjs
	 n94ueeb1zOA5zTY/9XmmpS3cfVOT0JJFVM0G3XmFoIQazrZeSyuKZ0e9PHM+ntEveb
	 7L9voA1fY1UBOf0NwmSSUI0mM5mnDHOhdgM5c5eE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729965AbfL2Rfv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Dec 2019 12:35:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:40550 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729949AbfL2Rft (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Dec 2019 12:35:49 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 70B0E20722;
        Sun, 29 Dec 2019 17:35:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577640948;
        bh=GkB5R2UJ6ARn4a70f3TzS5/TimRwnPueAlRS5du8h58=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zWWgaRtxa2FbRfNJ1NaqfBlo0jG/2Z82yd72XWIyP3nEX3Bm1dIw5A5hhyb9qokQx
         oIvbmgFzsrk9eoI9KpUbqU6JMQUrIdrRA6Y7rvdl8kSXorsyTKOqb3KImlk2vqRsi9
         YLTuZH0HUclqd2B3E2foaU4EzXOfwiFUgnGrvGz4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ian Abbott <abbotti@mev.co.uk>
Subject: [PATCH 4.19 204/219] staging: comedi: gsc_hpdi: check dma_alloc_coherent() return value
Date:   Sun, 29 Dec 2019 18:20:06 +0100
Message-Id: <20191229162540.582899217@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191229162508.458551679@linuxfoundation.org>
References: <20191229162508.458551679@linuxfoundation.org>
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
@@ -623,6 +623,11 @@ static int gsc_hpdi_auto_attach(struct c
 		    dma_alloc_coherent(&pcidev->dev, DMA_BUFFER_SIZE,
 				       &devpriv->dio_buffer_phys_addr[i],
 				       GFP_KERNEL);
+		if (!devpriv->dio_buffer[i]) {
+			dev_warn(dev->class_dev,
+				 "failed to allocate DMA buffer\n");
+			return -ENOMEM;
+		}
 	}
 	/* allocate dma descriptors */
 	devpriv->dma_desc = dma_alloc_coherent(&pcidev->dev,
@@ -630,6 +635,11 @@ static int gsc_hpdi_auto_attach(struct c
 					       NUM_DMA_DESCRIPTORS,
 					       &devpriv->dma_desc_phys_addr,
 					       GFP_KERNEL);
+	if (!devpriv->dma_desc) {
+		dev_warn(dev->class_dev,
+			 "failed to allocate DMA descriptors\n");
+		return -ENOMEM;
+	}
 	if (devpriv->dma_desc_phys_addr & 0xf) {
 		dev_warn(dev->class_dev,
 			 " dma descriptors not quad-word aligned (bug)\n");


