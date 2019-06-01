Return-Path: <SRS0=TpO6=UA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7EB3C28CC1
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Jun 2019 18:44:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8ADB327791
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Jun 2019 18:44:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SbUKeTjS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbfFASoK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Jun 2019 14:44:10 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34025 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726075AbfFASoI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jun 2019 14:44:08 -0400
Received: by mail-pf1-f193.google.com with SMTP id c14so5777394pfi.1
        for <linux-kernel@vger.kernel.org>; Sat, 01 Jun 2019 11:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gC38v4AGxJyMRQChaegbCAHgTavb59G/fUoY/aBJi7k=;
        b=SbUKeTjSVLQt+ZcTxSizpClJ6wwHb6fd+j4suDI4b2ntQ6gdeC/aGPI8IO+SPry8CO
         wmVbYFqSPlrcP9gfsS56vedlb4EOi9pQKqcEygOZ//E2Qng2iADeACoagr/s3Oeect/q
         SPB9IpZCM/fOS4NOyVAESdeciAC4Ci3MnDFbH3S9BacFUGog7gv52gCWMdYC5y9bnj2v
         2BVfqfPO4CJAKe4e2IIWj5S15HvwLI8lLfxkzrOpvzOeJnwmoYiR45ArRdq8FLTHRQiM
         6zrDLrsoocgqYGMq/es4N/c3xvsUKGdZaBZr/r9yVUTvpvL/jYbbdYaxbnr4kxnkq2SE
         z3AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gC38v4AGxJyMRQChaegbCAHgTavb59G/fUoY/aBJi7k=;
        b=p2SmPL/NhtpsVNBbUnpxpMZ3PoPQEEUPNq3UGuDaaBytlbWYH+T0kaU7h1s2OuoKXL
         nHvlR0j9BmzJBwJfv3xT9WqqsEA9UGmxJCYQ7VMhtKGbJ9Y6J6rjgF1c9kbkVRoEeHPs
         hH4K6l+koKZFc1zHhIs3d4mnmeymDfXKbYyssOIV3Y52noBmmCreLI1yxPWTCFGmfOnj
         rciUxkvcXB2rNWq1jQbF0g7xwZfhFF2POv4aXTYgkNL2YbzZHo/zlLupMFuF7oomzn1C
         U8bKPmY581pufIT4w8Qg+JFJ+csjW3bexesod8u98vXqYCYe4b+Sh6CuM29Sh5pXgdyh
         XgtA==
X-Gm-Message-State: APjAAAUSBvQWcy+7HE8Ae0Y0ik/JfM+cVtx1pg2+93xgG4nGtVMh/Wg8
        sGu3YkpkufFUEfVMIJUbPzHjtBbe
X-Google-Smtp-Source: APXvYqwLALCMoTvNivPUYi2bQLErhbIXDYuNI15NK7KYdSTbwqR0+o/+AbhXrWGn6DhjADcgbXLZ3Q==
X-Received: by 2002:a63:4d05:: with SMTP id a5mr9750563pgb.19.1559414647433;
        Sat, 01 Jun 2019 11:44:07 -0700 (PDT)
Received: from localhost.localdomain ([117.192.16.207])
        by smtp.googlemail.com with ESMTPSA id w187sm13287950pfw.20.2019.06.01.11.44.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 01 Jun 2019 11:44:07 -0700 (PDT)
From:   Deepak Mishra <linux.dkm@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, Larry.Finger@lwfinger.net,
        florian.c.schilhabel@googlemail.com, linux.dkm@gmail.com,
        himadri18.07@gmail.com, straube.linux@gmail.com
Subject: [PATCH 2/8] staging: rtl8712: Fixed CamelCase in struct _adapter from drv_types.h
Date:   Sun,  2 Jun 2019 00:13:36 +0530
Message-Id: <bd66c1bb291720a4dfd58114e8b4bdccea074b39.1559412149.git.linux.dkm@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <cover.1559412149.git.linux.dkm@gmail.com>
References: <cover.1559412149.git.linux.dkm@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes CamelCase ImrContent from struct _adapter and in related
files drv_types.h, rtl871x_eeprom.c, usb_intf.c

CHECK: Avoid CamelCase: <EepromAddressSize>

Signed-off-by: Deepak Mishra <linux.dkm@gmail.com>
---
 drivers/staging/rtl8712/drv_types.h      | 2 +-
 drivers/staging/rtl8712/rtl871x_eeprom.c | 6 +++---
 drivers/staging/rtl8712/usb_intf.c       | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8712/drv_types.h b/drivers/staging/rtl8712/drv_types.h
index 89ebb5a49d25..7d1178278ecc 100644
--- a/drivers/staging/rtl8712/drv_types.h
+++ b/drivers/staging/rtl8712/drv_types.h
@@ -150,7 +150,7 @@ struct _adapter {
 	bool	suspended;
 	u32	IsrContent;
 	u32	imr_content;
-	u8	EepromAddressSize;
+	u8	eeprom_address_size;
 	u8	hw_init_completed;
 	struct task_struct *cmdThread;
 	pid_t evtThread;
diff --git a/drivers/staging/rtl8712/rtl871x_eeprom.c b/drivers/staging/rtl8712/rtl871x_eeprom.c
index 0027d8eb22fa..221bf92e1b1c 100644
--- a/drivers/staging/rtl8712/rtl871x_eeprom.c
+++ b/drivers/staging/rtl8712/rtl871x_eeprom.c
@@ -150,7 +150,7 @@ void r8712_eeprom_write16(struct _adapter *padapter, u16 reg, u16 data)
 	x |= _EEM1 | _EECS;
 	r8712_write8(padapter, EE_9346CR, x);
 	shift_out_bits(padapter, EEPROM_EWEN_OPCODE, 5);
-	if (padapter->EepromAddressSize == 8)	/*CF+ and SDIO*/
+	if (padapter->eeprom_address_size == 8)	/*CF+ and SDIO*/
 		shift_out_bits(padapter, 0, 6);
 	else	/* USB */
 		shift_out_bits(padapter, 0, 4);
@@ -165,7 +165,7 @@ void r8712_eeprom_write16(struct _adapter *padapter, u16 reg, u16 data)
 	 */
 	shift_out_bits(padapter, EEPROM_WRITE_OPCODE, 3);
 	/* select which word in the EEPROM that we are writing to. */
-	shift_out_bits(padapter, reg, padapter->EepromAddressSize);
+	shift_out_bits(padapter, reg, padapter->eeprom_address_size);
 	/* write the data to the selected EEPROM word. */
 	shift_out_bits(padapter, data, 16);
 	if (wait_eeprom_cmd_done(padapter)) {
@@ -207,7 +207,7 @@ u16 r8712_eeprom_read16(struct _adapter *padapter, u16 reg) /*ReadEEprom*/
 	 * The opcode is 3bits in length, reg is 6 bits long
 	 */
 	shift_out_bits(padapter, EEPROM_READ_OPCODE, 3);
-	shift_out_bits(padapter, reg, padapter->EepromAddressSize);
+	shift_out_bits(padapter, reg, padapter->eeprom_address_size);
 	/* Now read the data (16 bits) in from the selected EEPROM word */
 	data = shift_in_bits(padapter);
 	eeprom_clean(padapter);
diff --git a/drivers/staging/rtl8712/usb_intf.c b/drivers/staging/rtl8712/usb_intf.c
index 7478bbd3de78..200a271c28e1 100644
--- a/drivers/staging/rtl8712/usb_intf.c
+++ b/drivers/staging/rtl8712/usb_intf.c
@@ -246,7 +246,7 @@ static uint r8712_usb_dvobj_init(struct _adapter *padapter)
 	struct usb_device *pusbd = pdvobjpriv->pusbdev;
 
 	pdvobjpriv->padapter = padapter;
-	padapter->EepromAddressSize = 6;
+	padapter->eeprom_address_size = 6;
 	phost_iface = &pintf->altsetting[0];
 	piface_desc = &phost_iface->desc;
 	pdvobjpriv->nr_endpoint = piface_desc->bNumEndpoints;
-- 
2.19.1

