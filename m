Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0516FC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 18:30:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6EF221872
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 18:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573497038;
	bh=HdtFNxoTPLhhrcYzweLwnXMSkfQyx/SykXzCvleGZ/A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YhJvNkvpooExACjhP2aiOENHLaEBgYuhx+HkcmCcCTKGCRKBP0ClLNDJ+xUi4HiV6
	 c7zkZlJOlu1hWdvPgFy5rhpmvzaAgdGAwK2njGGRqCGgf1CZnf9jSqjf1dsok7HE2r
	 iNRNUyUjMlEig7FmX/8Gn2tcjBL4omr1i7TVRdHg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727388AbfKKSah (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 13:30:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:46932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727366AbfKKSaf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 13:30:35 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9F9B8214E0;
        Mon, 11 Nov 2019 18:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573497035;
        bh=HdtFNxoTPLhhrcYzweLwnXMSkfQyx/SykXzCvleGZ/A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JJcwSQsdbBMCIDgFhmFMUuJgPWsWliUGvuEmX79Y0eN2Vfq7K0TA1/y0ix4UfrWQj
         ieNlgde2oyxBs7hw5nlEO0MA0D2OThrqk6YotCiDq1QpXggJkzGgiJiLrLxn4KObBQ
         YU/DNgne072PqQOZxegAha7oqriUX8iDgYHZo3K0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: [PATCH 4.4 23/43] drivers: usb: usbip: Add missing break statement to switch
Date:   Mon, 11 Nov 2019 19:28:37 +0100
Message-Id: <20191111181314.607907458@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191111181246.772983347@linuxfoundation.org>
References: <20191111181246.772983347@linuxfoundation.org>
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
@@ -303,6 +303,7 @@ static int vhci_hub_control(struct usb_h
 			default:
 				break;
 			}
+			break;
 		default:
 			usbip_dbg_vhci_rh(" ClearPortFeature: default %x\n",
 					  wValue);


