Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED94CC43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:33:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4691208CA
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:33:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728782AbfD0PdK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 11:33:10 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:60616 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726578AbfD0PPK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 11:15:10 -0400
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP2h-0000zH-O6; Sat, 27 Apr 2019 16:15:07 +0100
Received: from ben by deadeye with local (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP2h-0004OW-Cf; Sat, 27 Apr 2019 16:15:07 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Alan Stern" <stern@rowland.harvard.edu>,
        "Icenowy Zheng" <icenowy@aosc.io>
Date:   Sat, 27 Apr 2019 16:13:09 +0100
Message-ID: <lsq.1556377989.89095326@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 012/202] USB: storage: add quirk for SMI SM3350
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

From: Icenowy Zheng <icenowy@aosc.io>

commit 0a99cc4b8ee83885ab9f097a3737d1ab28455ac0 upstream.

The SMI SM3350 USB-UFS bridge controller cannot handle long sense request
correctly and will make the chip refuse to do read/write when requested
long sense.

Add a bad sense quirk for it.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
Acked-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/usb/storage/unusual_devs.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

--- a/drivers/usb/storage/unusual_devs.h
+++ b/drivers/usb/storage/unusual_devs.h
@@ -1194,6 +1194,18 @@ UNUSUAL_DEV( 0x090c, 0x1132, 0x0000, 0xf
 		USB_SC_DEVICE, USB_PR_DEVICE, NULL,
 		US_FL_FIX_CAPACITY ),
 
+/*
+ * Reported by Icenowy Zheng <icenowy@aosc.io>
+ * The SMI SM3350 USB-UFS bridge controller will enter a wrong state
+ * that do not process read/write command if a long sense is requested,
+ * so force to use 18-byte sense.
+ */
+UNUSUAL_DEV(  0x090c, 0x3350, 0x0000, 0xffff,
+		"SMI",
+		"SM3350 UFS-to-USB-Mass-Storage bridge",
+		USB_SC_DEVICE, USB_PR_DEVICE, NULL,
+		US_FL_BAD_SENSE ),
+
 /* Reported by Paul Hartman <paul.hartman+linux@gmail.com>
  * This card reader returns "Illegal Request, Logical Block Address
  * Out of Range" for the first READ(10) after a new card is inserted.

