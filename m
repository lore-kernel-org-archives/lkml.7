Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC2FDC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 18:33:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7796B21655
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 18:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573497206;
	bh=KW29bxFCR8ObVquCB47QdEOjTPiY0g2W7TMZB3dGVmQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=c+wsUwY13bps68WVuDsQvM+Eo8HJvUcB41Owd3yn32IN6ROQkNb26Z7O9rMnifWzY
	 5yPABkkkjkCJuwOrcCWpSLyLqUFWrZTou1D0Mg4f+ZNlo1Ur7JbV36HpKGEX8jWNj1
	 EOhrnHCgXP+IxV8JyZgImbSLilUCYAMc8wMZMpoQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728150AbfKKSdZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 13:33:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:50690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728128AbfKKSdT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 13:33:19 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6611221925;
        Mon, 11 Nov 2019 18:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573497198;
        bh=KW29bxFCR8ObVquCB47QdEOjTPiY0g2W7TMZB3dGVmQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uYCc+94PmQmpZERjFe43eAo5AsJmU4b3PREq8pI49dF5tOt7nTWkoQxVLrsTvgXII
         DWiEpQxEC7JYiHSLzYNdbv8CGqlX6t2NFJgIi1SAk/B0ix2BGKQvDauMOwohWTWTIH
         GtJ9BdiWIVfSlI/zK6MvcZuSx3Atjgwil4QQ7t64=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: [PATCH 4.9 36/65] drivers: usb: usbip: Add missing break statement to switch
Date:   Mon, 11 Nov 2019 19:28:36 +0100
Message-Id: <20191111181347.075259756@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191111181331.917659011@linuxfoundation.org>
References: <20191111181331.917659011@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gustavo A. R. Silva <garsilva@embeddedor.com>

commit 7c92e5fbf4dac0dd4dd41a0383adc54f16f403e2 upstream.

Add missing break statement to prevent the code for case
USB_PORT_FEAT_C_RESET falling through to the default case.

Addresses-Coverity-ID: 143155
Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/usbip/vhci_hcd.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/usb/usbip/vhci_hcd.c
+++ b/drivers/usb/usbip/vhci_hcd.c
@@ -318,6 +318,7 @@ static int vhci_hub_control(struct usb_h
 			default:
 				break;
 			}
+			break;
 		default:
 			usbip_dbg_vhci_rh(" ClearPortFeature: default %x\n",
 					  wValue);


