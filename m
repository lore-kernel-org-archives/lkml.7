Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14471C31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 21:29:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAF012070B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 21:29:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560806977;
	bh=9PkkKS4eK3cHYIwtOop9pQXBjR3OgNjWLKjzMomaHd4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jKlegQnQXV/ZXluEr6b07v2Atxqk3ar7qg8MDvnnDKLcoGIPzTiHIl5/dBFv0pTHZ
	 6xf+/7YBQDLkPvAZZo7XzyPRudvl9eCwGeA62fTWIw2McbR/3wBqWV1KDlJlIFDhSJ
	 gJhD0BsRzimZ6szfu6ESHxcx7qTZTMsrHj0pNyKo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730214AbfFQV3g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 17:29:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:56748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730436AbfFQV3c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 17:29:32 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7A167204FD;
        Mon, 17 Jun 2019 21:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560806972;
        bh=9PkkKS4eK3cHYIwtOop9pQXBjR3OgNjWLKjzMomaHd4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SLRLRdTWCLvrvoPYEFaqMh2HIB1SNIFhm9kkEgK6KUYpshKxaiEnx04O2XHVY9cii
         9XmzDHwaISy9vtkpQASzqml4DyWrOG1oQyxhcwTreADEdUcNqpbh3AazzQS7syq07t
         ZJfyEfcssHod0sf7pMt0kK2Ox0GUYbuCDzZnbaDE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Marco Zatta <marco@zatta.me>
Subject: [PATCH 4.14 45/53] USB: Fix chipmunk-like voice when using Logitech C270 for recording audio.
Date:   Mon, 17 Jun 2019 23:10:28 +0200
Message-Id: <20190617210752.338665036@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190617210745.104187490@linuxfoundation.org>
References: <20190617210745.104187490@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marco Zatta <marco@zatta.me>

commit bd21f0222adab64974b7d1b4b8c7ce6b23e9ea4d upstream.

This patch fixes the chipmunk-like voice that manifets randomly when
using the integrated mic of the Logitech Webcam HD C270.

The issue was solved initially for this device by commit 2394d67e446b
("USB: add RESET_RESUME for webcams shown to be quirky") but it was then
reintroduced by e387ef5c47dd ("usb: Add USB_QUIRK_RESET_RESUME for all
Logitech UVC webcams"). This patch is to have the fix back.

Signed-off-by: Marco Zatta <marco@zatta.me>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/core/quirks.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/usb/core/quirks.c
+++ b/drivers/usb/core/quirks.c
@@ -70,6 +70,9 @@ static const struct usb_device_id usb_qu
 	/* Cherry Stream G230 2.0 (G85-231) and 3.0 (G85-232) */
 	{ USB_DEVICE(0x046a, 0x0023), .driver_info = USB_QUIRK_RESET_RESUME },
 
+	/* Logitech HD Webcam C270 */
+	{ USB_DEVICE(0x046d, 0x0825), .driver_info = USB_QUIRK_RESET_RESUME },
+
 	/* Logitech HD Pro Webcams C920, C920-C, C925e and C930e */
 	{ USB_DEVICE(0x046d, 0x082d), .driver_info = USB_QUIRK_DELAY_INIT },
 	{ USB_DEVICE(0x046d, 0x0841), .driver_info = USB_QUIRK_DELAY_INIT },


