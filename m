Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5E2DC3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 08:46:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 725FA22DBF
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 08:46:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QlJ6KAk2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728432AbfICIqb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 04:46:31 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:34384 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728309AbfICIqZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 04:46:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=oKltuC+bB0pJtvp7qUclBSom6VtgzauxKPZ6u/A2tVA=; b=QlJ6KAk20XGkQDBVS98nV/rEN3
        6Td6kdBXVqr9N0zcgE7xRDLUvdlVxBPRUH+s065LXXUY0/ukchTUvC9XCTzI0BFuqqbZTJV2kBOp7
        JMjdXklo9soii250kn0j1raivpm13RZffrS+jqkHWeGFLKE0ABrO9RD5fauLQqzHb5K57Q92xBAv3
        hFIn6LVBrlrb+hnwcfx5a6wmNxHLpGLY94B1ut95+1LrmuZcMMJ9rQpDr2ef8JAIDCz7tDH+tFkrB
        8q6+Osk615QF2/2e7kA/37UMThCmBU+RxUnBHQcnoBiuuHjdENg9CqoBYp0/G/BUWKD22YFLnXJHR
        l+DK8KYQ==;
Received: from clnet-p19-102.ikbnet.co.at ([83.175.77.102] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i54SF-0003rU-BK; Tue, 03 Sep 2019 08:46:23 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Lee Jones <lee.jones@linaro.org>
Cc:     Alan Stern <stern@rowland.harvard.edu>, linux-usb@vger.kernel.org,
        usb-storage@lists.one-eyed-alien.net, linux-kernel@vger.kernel.org
Subject: [PATCH 2/6] usb/ohci-tmio: remove the HCD_DMA flag
Date:   Tue,  3 Sep 2019 10:46:11 +0200
Message-Id: <20190903084615.19161-3-hch@lst.de>
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

This driver doesn't support normal DMA, only direct access to its
local memory.  Remove the HCD_DMA flag to properly express that fact.

Fixes: 1e4946c4412e ("usb: add a HCD_DMA flag instead of guestimating DMA capabilities")
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/usb/host/ohci-tmio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/host/ohci-tmio.c b/drivers/usb/host/ohci-tmio.c
index 8edbacd3eb17..d5a293a707b6 100644
--- a/drivers/usb/host/ohci-tmio.c
+++ b/drivers/usb/host/ohci-tmio.c
@@ -153,7 +153,7 @@ static const struct hc_driver ohci_tmio_hc_driver = {
 
 	/* generic hardware linkage */
 	.irq =			ohci_irq,
-	.flags =		HCD_USB11 | HCD_DMA | HCD_MEMORY,
+	.flags =		HCD_USB11 | HCD_MEMORY,
 
 	/* basic lifecycle operations */
 	.start =		ohci_tmio_start,
-- 
2.20.1

