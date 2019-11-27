Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67D3CC432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 21:11:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4039621775
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 21:11:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574889110;
	bh=keyMyZOrwHJ8/Mma4YkJTZvdUatq7dXMHRjU0gDH6+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GRTghdePq7FGeivGdIHW0ZDyHJ+YZlw+NGyWwYR2gOSvVQS//jskiLGqbuUD3Zzdy
	 mlk00FO8n78fBYmFRS9mWClhCH8iQEz81Y1LzB+r2QAm+kDjqCxBWMjYn2BcSN3WzH
	 SOQZd8B1C3YcyNlPIEf5RgaA3rVaek1ghz7Km0Dg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733227AbfK0VLt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 16:11:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:40928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733221AbfK0VLr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 16:11:47 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8415521555;
        Wed, 27 Nov 2019 21:11:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574889107;
        bh=keyMyZOrwHJ8/Mma4YkJTZvdUatq7dXMHRjU0gDH6+k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WePrDqoZEGrf9W0ORQURsli9V9mjdwSLOAuhAJhiM+7E/+6FIyKq8F0BLknY2rbMO
         L8JZjj+BiMsdL2f76KaacLEesz+MdZ3X1qMpnIpl7IwWqLxN5u6GMoeQbKlop49wtZ
         2/wtlMCdz/nXzdZwfnUtl7gD+wBbryqOww9l2jPY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Joel Jennings <joel.jennings@makeitlabs.com>,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH 5.3 84/95] usb-serial: cp201x: support Mark-10 digital force gauge
Date:   Wed, 27 Nov 2019 21:32:41 +0100
Message-Id: <20191127202952.557834989@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191127202845.651587549@linuxfoundation.org>
References: <20191127202845.651587549@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

commit 347bc8cb26388791c5881a3775cb14a3f765a674 upstream.

Add support for the Mark-10 digital force gauge device to the cp201x
driver.

Based on a report and a larger patch from Joel Jennings

Reported-by: Joel Jennings <joel.jennings@makeitlabs.com>
Cc: stable <stable@vger.kernel.org>
Acked-by: Johan Hovold <johan@kernel.org>
Link: https://lore.kernel.org/r/20191118092119.GA153852@kroah.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/serial/cp210x.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/usb/serial/cp210x.c
+++ b/drivers/usb/serial/cp210x.c
@@ -125,6 +125,7 @@ static const struct usb_device_id id_tab
 	{ USB_DEVICE(0x10C4, 0x8341) }, /* Siemens MC35PU GPRS Modem */
 	{ USB_DEVICE(0x10C4, 0x8382) }, /* Cygnal Integrated Products, Inc. */
 	{ USB_DEVICE(0x10C4, 0x83A8) }, /* Amber Wireless AMB2560 */
+	{ USB_DEVICE(0x10C4, 0x83AA) }, /* Mark-10 Digital Force Gauge */
 	{ USB_DEVICE(0x10C4, 0x83D8) }, /* DekTec DTA Plus VHF/UHF Booster/Attenuator */
 	{ USB_DEVICE(0x10C4, 0x8411) }, /* Kyocera GPS Module */
 	{ USB_DEVICE(0x10C4, 0x8418) }, /* IRZ Automation Teleport SG-10 GSM/GPRS Modem */


