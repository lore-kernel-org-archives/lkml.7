Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9951CA9EC9
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 07:11:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AC4B2080F
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 07:11:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=loebl.cz header.i=@loebl.cz header.b="Tz4BfjhK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729683AbfKAHLh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 03:11:37 -0400
Received: from mout-u-107.mailbox.org ([91.198.250.252]:34466 "EHLO
        mout-u-107.mailbox.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727038AbfKAHLh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 03:11:37 -0400
X-Greylist: delayed 450 seconds by postgrey-1.27 at vger.kernel.org; Fri, 01 Nov 2019 03:11:36 EDT
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:105:465:1:2:0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mout-u-107.mailbox.org (Postfix) with ESMTPS id 474Cps2xbrzKnpg;
        Fri,  1 Nov 2019 08:04:05 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=loebl.cz; s=MBO0001;
        t=1572591843;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=wYB7gWeMkic0uqXrLTJzZICWUYeAmNA/YASt+6ZikrE=;
        b=Tz4BfjhKysPUJVfZ/CZWodiCVW84sKynXsVw7Hjl/ICijY4EXgI0ItfbXyH/jRrUfJD+Ok
        Cexz7QCEGjW+GqC2Xk0iQARIIQvIQatpbmsX+Wdap2SDqFjyMIlAGETAdWaPr4vBwyjMyF
        HHMkXS18WaTMyfTACaDrI3eVwvhIiQdnTLmtFVuZwGEuJQRdUw3+vP4frz212POUsW9x0+
        GxpOKv89W8ps/KjeGorgJHCCb6Qz+DYIUbAjw9hwo+Wt0GBBWKwzhE92bpXKS/AWrC++Sa
        rEUJnl1ZmOwf19pLmWRVODJctPaUhkm6Yz69VQogOUaovinX8t4gEK6Y2/aAmA==
Received: from smtp2.mailbox.org ([80.241.60.241])
        by spamfilter06.heinlein-hosting.de (spamfilter06.heinlein-hosting.de [80.241.56.125]) (amavisd-new, port 10030)
        with ESMTP id 2Kt61vzO82YB; Fri,  1 Nov 2019 08:04:02 +0100 (CET)
From:   =?UTF-8?q?Pavel=20L=C3=B6bl?= <pavel@loebl.cz>
To:     linux-kernel@vger.kernel.org
Cc:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?q?Pavel=20L=C3=B6bl?= <pavel@loebl.cz>
Subject: [PATCH] usb: serial: mos7840: Add USB ID to support Moxa UPort 2210
Date:   Fri,  1 Nov 2019 08:01:50 +0100
Message-Id: <20191101070150.4216-1-pavel@loebl.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds usb ID for MOXA UPort 2210. This device contains mos7820 but
it passes GPIO0 check implemented by driver and it's detected as
mos7840. Hence product id check is added to force mos7820 mode.

Signed-off-by: Pavel Löbl <pavel@loebl.cz>
---
 drivers/usb/serial/mos7840.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/usb/serial/mos7840.c b/drivers/usb/serial/mos7840.c
index a698d46ba773..13aff04ad027 100644
--- a/drivers/usb/serial/mos7840.c
+++ b/drivers/usb/serial/mos7840.c
@@ -119,10 +119,13 @@
 /* This driver also supports
  * ATEN UC2324 device using Moschip MCS7840
  * ATEN UC2322 device using Moschip MCS7820
+ * MOXA UPort 2210 device using Moschip MCS7820
  */
 #define USB_VENDOR_ID_ATENINTL		0x0557
 #define ATENINTL_DEVICE_ID_UC2324	0x2011
 #define ATENINTL_DEVICE_ID_UC2322	0x7820
+#define USB_VENDOR_ID_MXU2      0x110a
+#define MXU2_DEVICE_ID_2210     0x2210
 
 /* Interrupt Routine Defines    */
 
@@ -195,6 +198,7 @@ static const struct usb_device_id id_table[] = {
 	{USB_DEVICE(USB_VENDOR_ID_BANDB, BANDB_DEVICE_ID_USOPTL2_4)},
 	{USB_DEVICE(USB_VENDOR_ID_ATENINTL, ATENINTL_DEVICE_ID_UC2324)},
 	{USB_DEVICE(USB_VENDOR_ID_ATENINTL, ATENINTL_DEVICE_ID_UC2322)},
+	{USB_DEVICE(USB_VENDOR_ID_MXU2, MXU2_DEVICE_ID_2210)},
 	{}			/* terminating entry */
 };
 MODULE_DEVICE_TABLE(usb, id_table);
@@ -2030,6 +2034,11 @@ static int mos7840_probe(struct usb_serial *serial,
 		goto out;
 	}
 
+	if (product == MXU2_DEVICE_ID_2210) {
+		device_type = MOSCHIP_DEVICE_ID_7820;
+		goto out;
+	}
+
 	buf = kzalloc(VENDOR_READ_LENGTH, GFP_KERNEL);
 	if (!buf)
 		return -ENOMEM;
-- 
2.24.0.rc1

