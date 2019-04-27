Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD851C43219
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:33:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4ADD206C1
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:33:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728828AbfD0Pdh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 11:33:37 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:60572 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725942AbfD0PPK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 11:15:10 -0400
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP2h-0000zF-JF; Sat, 27 Apr 2019 16:15:07 +0100
Received: from ben by deadeye with local (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP2h-0004OL-AX; Sat, 27 Apr 2019 16:15:07 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Daniele Palmas" <dnlplm@gmail.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Date:   Sat, 27 Apr 2019 16:13:09 +0100
Message-ID: <lsq.1556377989.299831282@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 010/202] usb: cdc-acm: send ZLP for Telit 3G Intel
 based modems
In-Reply-To: <lsq.1556377988.384060557@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.66-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Daniele Palmas <dnlplm@gmail.com>

commit 34aabf918717dd14e05051896aaecd3b16b53d95 upstream.

Telit 3G Intel based modems require zero packet to be sent if
out data size is equal to the endpoint max packet size.

Signed-off-by: Daniele Palmas <dnlplm@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/usb/class/cdc-acm.c | 7 +++++++
 1 file changed, 7 insertions(+)

--- a/drivers/usb/class/cdc-acm.c
+++ b/drivers/usb/class/cdc-acm.c
@@ -1903,6 +1903,13 @@ static const struct usb_device_id acm_id
 	.driver_info = IGNORE_DEVICE,
 	},
 
+	{ USB_DEVICE(0x1bc7, 0x0021), /* Telit 3G ACM only composition */
+	.driver_info = SEND_ZERO_PACKET,
+	},
+	{ USB_DEVICE(0x1bc7, 0x0023), /* Telit 3G ACM + ECM composition */
+	.driver_info = SEND_ZERO_PACKET,
+	},
+
 	/* control interfaces without any protocol set */
 	{ USB_INTERFACE_INFO(USB_CLASS_COMM, USB_CDC_SUBCLASS_ACM,
 		USB_CDC_PROTO_NONE) },

