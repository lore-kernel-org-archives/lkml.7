Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F1ABC32753
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 17:22:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D20A206C2
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 17:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565803320;
	bh=bbV/8pJFh2CJ+OTFXl4xsgxVcDcaQJ5Cl2Q4N6T3Ltc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ahcYxwT39MKNHpRcwDmIWBBUTziBy2O43ZbFC3OZCja9mEn3DoNOz0HL8pcIUvs9n
	 8GO5YgkDOSDvpsYSZ7QdmCc+HHZuHoHHwwrrf1byKxXSVtwlDrKNH2yrjQOp6GUG26
	 dl542mXKBzak4J+lNKxw8uePPkdan4MAysmtTV8M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730166AbfHNRV7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 13:21:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:59474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730273AbfHNRJM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 13:09:12 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 51D38214DA;
        Wed, 14 Aug 2019 17:09:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565802551;
        bh=bbV/8pJFh2CJ+OTFXl4xsgxVcDcaQJ5Cl2Q4N6T3Ltc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GfU0gLg5JFo/T/f92oNNxQvdHDrKzfkALivijUfLq9jMOkucx6+jf/Wa84Aeoxfff
         KQb1ZhFOkTYg/kz3BrrOYxlMso7QY2nME9vm7devqr+DYEnKlQWo+VPLb9e5eLp2K7
         pmddBtG8JR/ky4pIDxX50wTS/YeAIeybbx6Fc7BM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH 4.19 25/91] usb: host: xhci-rcar: Fix timeout in xhci_suspend()
Date:   Wed, 14 Aug 2019 19:00:48 +0200
Message-Id: <20190814165750.766614263@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190814165748.991235624@linuxfoundation.org>
References: <20190814165748.991235624@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

commit 783bda5e41acc71f98336e1a402c180f9748e5dc upstream.

When a USB device is connected to the host controller and
the system enters suspend, the following error happens
in xhci_suspend():

	xhci-hcd ee000000.usb: WARN: xHC CMD_RUN timeout

Since the firmware/internal CPU control the USBSTS.STS_HALT
and the process speed is down when the roothub port enters U3,
long delay for the handshake of STS_HALT is neeed in xhci_suspend().
So, this patch adds to set the XHCI_SLOW_SUSPEND.

Fixes: 435cc1138ec9 ("usb: host: xhci-plat: set resume_quirk() for R-Car controllers")
Cc: <stable@vger.kernel.org> # v4.12+
Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Link: https://lore.kernel.org/r/1564734815-17964-1-git-send-email-yoshihiro.shimoda.uh@renesas.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/host/xhci-rcar.c |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

--- a/drivers/usb/host/xhci-rcar.c
+++ b/drivers/usb/host/xhci-rcar.c
@@ -238,10 +238,15 @@ int xhci_rcar_init_quirk(struct usb_hcd
 	 * pointers. So, this driver clears the AC64 bit of xhci->hcc_params
 	 * to call dma_set_coherent_mask(dev, DMA_BIT_MASK(32)) in
 	 * xhci_gen_setup().
+	 *
+	 * And, since the firmware/internal CPU control the USBSTS.STS_HALT
+	 * and the process speed is down when the roothub port enters U3,
+	 * long delay for the handshake of STS_HALT is neeed in xhci_suspend().
 	 */
 	if (xhci_rcar_is_gen2(hcd->self.controller) ||
-			xhci_rcar_is_gen3(hcd->self.controller))
-		xhci->quirks |= XHCI_NO_64BIT_SUPPORT;
+			xhci_rcar_is_gen3(hcd->self.controller)) {
+		xhci->quirks |= XHCI_NO_64BIT_SUPPORT | XHCI_SLOW_SUSPEND;
+	}
 
 	if (!xhci_rcar_wait_for_pll_active(hcd))
 		return -ETIMEDOUT;


