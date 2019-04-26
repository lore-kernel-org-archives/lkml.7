Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E243AC43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 13:54:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A062A206A3
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 13:54:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b="oKHoEf3S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726198AbfDZNy1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 09:54:27 -0400
Received: from smtp121.iad3b.emailsrvr.com ([146.20.161.121]:36200 "EHLO
        smtp121.iad3b.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726039AbfDZNy1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 09:54:27 -0400
Received: from smtp24.relay.iad3b.emailsrvr.com (localhost [127.0.0.1])
        by smtp24.relay.iad3b.emailsrvr.com (SMTP Server) with ESMTP id 5824A400D8;
        Fri, 26 Apr 2019 09:54:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
        s=20190130-41we5z8j; t=1556286865;
        bh=UOe40i2Y23dEygZrclzy87I0/z/uiia7Fj0PEZwCn5k=;
        h=From:To:Subject:Date:From;
        b=oKHoEf3SYX0XE6Tqj59fG0UFdrs2ZWAHP/2i5KUAo4Dgv+avBb6pRPdBBii5ZiRNR
         +1+viijvxMh6rWJej7rdBNMCzNVZ9CKzJoDJVVW09jj+deu500Epo7mH3ewMOicEwS
         MSUq9fJ/ePiHJL5J6u0FEa/vgbddFa5zlaBfhDog=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp24.relay.iad3b.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id 8565A400E6;
        Fri, 26 Apr 2019 09:54:24 -0400 (EDT)
X-Sender-Id: abbotti@mev.co.uk
Received: from ian-deb.inside.mev.co.uk (remote.quintadena.com [81.133.34.160])
        (using TLSv1.2 with cipher DHE-RSA-AES128-GCM-SHA256)
        by 0.0.0.0:465 (trex/5.7.12);
        Fri, 26 Apr 2019 09:54:25 -0400
From:   Ian Abbott <abbotti@mev.co.uk>
To:     devel@driverdev.osuosl.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ian Abbott <abbotti@mev.co.uk>,
        H Hartley Sweeten <hsweeten@visionengravers.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] staging: comedi: comedi_isadma: Use a non-NULL device for DMA API
Date:   Fri, 26 Apr 2019 14:54:13 +0100
Message-Id: <20190426135413.21532-1-abbotti@mev.co.uk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190425162644.21947-1-abbotti@mev.co.uk>
References: <20190425162644.21947-1-abbotti@mev.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "comedi_isadma" module calls `dma_alloc_coherent()` and
`dma_free_coherent()` with a NULL device pointer which is no longer
allowed.  If the `hw_dev` member of the `struct comedi_device` has been
set to a valid device, that can be used instead.  Unfortunately, all the
current users of the "comedi_isadma" module leave the `hw_dev` member
set to NULL.  In that case, fall back to using the comedi "class" device
pointed to by the `class_dev` member if that is non-NULL.  In that case,
make it "DMA-capable" with a coherent DMA mask set to the ISA bus limit
of 16MB (24 bits).

Signed-off-by: Ian Abbott <abbotti@mev.co.uk>
---
v2: Use the comedi "class" device instead of a static fallback device.
---
 drivers/staging/comedi/drivers/comedi_isadma.c | 17 +++++++++++++++--
 drivers/staging/comedi/drivers/comedi_isadma.h |  3 +++
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/comedi/drivers/comedi_isadma.c b/drivers/staging/comedi/drivers/comedi_isadma.c
index b77dc8d5d3ff..c729094298c2 100644
--- a/drivers/staging/comedi/drivers/comedi_isadma.c
+++ b/drivers/staging/comedi/drivers/comedi_isadma.c
@@ -172,6 +172,19 @@ struct comedi_isadma *comedi_isadma_alloc(struct comedi_device *dev,
 		goto no_dma;
 	dma->desc = desc;
 	dma->n_desc = n_desc;
+	if (dev->hw_dev) {
+		dma->dev = dev->hw_dev;
+	} else {
+		/* Fall back to using the "class" device. */
+		if (!dev->class_dev)
+			goto no_dma;
+		/* Need 24-bit mask for ISA DMA. */
+		if (dma_coerce_mask_and_coherent(dev->class_dev,
+						 DMA_BIT_MASK(24))) {
+			goto no_dma;
+		}
+		dma->dev = dev->class_dev;
+	}
 
 	dma_chans[0] = dma_chan1;
 	if (dma_chan2 == 0 || dma_chan2 == dma_chan1)
@@ -192,7 +205,7 @@ struct comedi_isadma *comedi_isadma_alloc(struct comedi_device *dev,
 		desc = &dma->desc[i];
 		desc->chan = dma_chans[i];
 		desc->maxsize = maxsize;
-		desc->virt_addr = dma_alloc_coherent(NULL, desc->maxsize,
+		desc->virt_addr = dma_alloc_coherent(dma->dev, desc->maxsize,
 						     &desc->hw_addr,
 						     GFP_KERNEL);
 		if (!desc->virt_addr)
@@ -224,7 +237,7 @@ void comedi_isadma_free(struct comedi_isadma *dma)
 		for (i = 0; i < dma->n_desc; i++) {
 			desc = &dma->desc[i];
 			if (desc->virt_addr)
-				dma_free_coherent(NULL, desc->maxsize,
+				dma_free_coherent(dma->dev, desc->maxsize,
 						  desc->virt_addr,
 						  desc->hw_addr);
 		}
diff --git a/drivers/staging/comedi/drivers/comedi_isadma.h b/drivers/staging/comedi/drivers/comedi_isadma.h
index 2bd1329d727f..9d2b12db7e6e 100644
--- a/drivers/staging/comedi/drivers/comedi_isadma.h
+++ b/drivers/staging/comedi/drivers/comedi_isadma.h
@@ -10,6 +10,7 @@
 #include <linux/types.h>
 
 struct comedi_device;
+struct device;
 
 /*
  * These are used to avoid issues when <asm/dma.h> and the DMA_MODE_
@@ -38,6 +39,7 @@ struct comedi_isadma_desc {
 
 /**
  * struct comedi_isadma - ISA DMA data
+ * @dev:	device to allocate non-coherent memory for
  * @desc:	cookie for each DMA buffer
  * @n_desc:	the number of cookies
  * @cur_dma:	the current cookie in use
@@ -45,6 +47,7 @@ struct comedi_isadma_desc {
  * @chan2:	the second DMA channel requested
  */
 struct comedi_isadma {
+	struct device *dev;
 	struct comedi_isadma_desc *desc;
 	int n_desc;
 	int cur_dma;
-- 
2.20.1

