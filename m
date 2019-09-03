Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BF99C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 08:46:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 715F122CF8
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 08:46:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="avP8nNbY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728525AbfICIqf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 04:46:35 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:34454 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728496AbfICIqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 04:46:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=6pguZUqffeAIWG1P6RYECfJD+WZFqcyfjatQr1iJ62o=; b=avP8nNbYk/erK+VOiHrBGc5KyF
        mkzgA3hN/OmPaaxgqsUNLGf0YJqjmJ1UCXLxqrpXiFEeaOaCR+TuB0f19YXDg5UuWCjT75BzePIay
        XBF48xjmAFEoBQflJxuIEvNKnvH3sNdrhpYK8qPa7zpq5Rv0OtpccRahZgtIYf/ieGkm+hYFdYfg/
        cl0C0RSY8yLLZf8jZQddmrNm+MKaSSsqB/liMsHnrU1411sjWZedyBizmF5FUkKhFQm7yol7pmqp9
        YgCeN3JLabopP6XPQcI1stRS5q+hBDYl+oBgsta/RcN5illsOjXfFlN+MhZiDoJ5j01XYh5Y+eIhF
        /CUgW+/A==;
Received: from clnet-p19-102.ikbnet.co.at ([83.175.77.102] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i54SO-0003tL-80; Tue, 03 Sep 2019 08:46:32 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Lee Jones <lee.jones@linaro.org>
Cc:     Alan Stern <stern@rowland.harvard.edu>, linux-usb@vger.kernel.org,
        usb-storage@lists.one-eyed-alien.net, linux-kernel@vger.kernel.org
Subject: [PATCH 6/6] mfd: don't select DMA_DECLARE_COHERENT for the sm501 and tc6393xb drivers
Date:   Tue,  3 Sep 2019 10:46:15 +0200
Message-Id: <20190903084615.19161-7-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190903084615.19161-1-hch@lst.de>
References: <20190903084615.19161-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that these drivers use the usb localmem pool there is no need to
select DMA_DECLARE_COHERENT.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/mfd/Kconfig | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index f129f9678940..c8cbde59bbf6 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -1105,7 +1105,6 @@ config MFD_SI476X_CORE
 config MFD_SM501
 	tristate "Silicon Motion SM501"
 	depends on HAS_DMA
-	select DMA_DECLARE_COHERENT
 	 ---help---
 	  This is the core driver for the Silicon Motion SM501 multimedia
 	  companion chip. This device is a multifunction device which may
@@ -1714,7 +1713,6 @@ config MFD_TC6393XB
 	select GPIOLIB
 	select MFD_CORE
 	select MFD_TMIO
-	select DMA_DECLARE_COHERENT
 	help
 	  Support for Toshiba Mobile IO Controller TC6393XB
 
-- 
2.20.1

