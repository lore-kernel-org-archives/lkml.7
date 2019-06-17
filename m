Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F4E7C31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 21:27:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6051420673
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 21:27:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560806821;
	bh=KQRPPfBfIe6EpwOI41pQA4ra/TRfh8MbVhGnotLGUnA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rwP7Isb3LUULlxrPJsJk1oZ8LUv7QL3i6yjuTVow2Pu24sQc6WhOG79K0trNMiW11
	 I1Ak+LhUMMee2MY4PblMdAfiAH3E0im5Zu9m+zr0Occqn7le0jJ/SyD66aQkLTqw3T
	 yXWIgZ5wdIjGMm/GWe88Y5QVILXdbs+/uwBAepDk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730320AbfFQV07 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 17:26:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:53700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729999AbfFQV05 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 17:26:57 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 348042063F;
        Mon, 17 Jun 2019 21:26:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560806816;
        bh=KQRPPfBfIe6EpwOI41pQA4ra/TRfh8MbVhGnotLGUnA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JXGtRR5zF1wpJXlev56VGojeIYgnK4docXEmM8JhVYOYEMxtH+yFgq/eZb/IeOBID
         4exq+s0nh28JBkvxO+r8rqsHYYwgWFhHK60NlUY/FAmp2URnOXZ5/YmPnRFP6JRS14
         MAGTIo3iSyAfn8DjJorw9Bc1aEiha79WwpGxtDBg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Daniele Palmas <dnlplm@gmail.com>,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH 4.19 65/75] USB: serial: option: add Telit 0x1260 and 0x1261 compositions
Date:   Mon, 17 Jun 2019 23:10:16 +0200
Message-Id: <20190617210755.598477789@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190617210752.799453599@linuxfoundation.org>
References: <20190617210752.799453599@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniele Palmas <dnlplm@gmail.com>

commit f3dfd4072c3ee6e287f501a18b5718b185d6a940 upstream.

Added support for Telit LE910Cx 0x1260 and 0x1261 compositions.

Signed-off-by: Daniele Palmas <dnlplm@gmail.com>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/serial/option.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -1171,6 +1171,10 @@ static const struct usb_device_id option
 	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, TELIT_PRODUCT_LE920A4_1213, 0xff) },
 	{ USB_DEVICE(TELIT_VENDOR_ID, TELIT_PRODUCT_LE920A4_1214),
 	  .driver_info = NCTRL(0) | RSVD(1) | RSVD(2) | RSVD(3) },
+	{ USB_DEVICE(TELIT_VENDOR_ID, 0x1260),
+	  .driver_info = NCTRL(0) | RSVD(1) | RSVD(2) },
+	{ USB_DEVICE(TELIT_VENDOR_ID, 0x1261),
+	  .driver_info = NCTRL(0) | RSVD(1) | RSVD(2) },
 	{ USB_DEVICE(TELIT_VENDOR_ID, 0x1900),				/* Telit LN940 (QMI) */
 	  .driver_info = NCTRL(0) | RSVD(1) },
 	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x1901, 0xff),	/* Telit LN940 (MBIM) */


