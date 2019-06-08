Return-Path: <SRS0=LGpO=UH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35068C28CC5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 10:57:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D857208E3
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 10:57:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P5TaHMYr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727364AbfFHK52 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Jun 2019 06:57:28 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:40549 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727312AbfFHK5Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jun 2019 06:57:25 -0400
Received: by mail-pl1-f196.google.com with SMTP id a93so1795064pla.7
        for <linux-kernel@vger.kernel.org>; Sat, 08 Jun 2019 03:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WK1yhfHvG1QfbUB2fLHTgsNDlC/LVWhcW+SQQQ3zIFM=;
        b=P5TaHMYrl9Q1636e65HEhxx53wl5ghsKpUnjUVPljQFBgbRgD5ewkHDj4yKxwLQy2C
         ztApbHv3CAJs5LjqjZllaTC8G7owYNQL51ykpN/SIdd6SPwtPrkBBJncmbP1mwrX827V
         PMrebk9Hgl6Hx+R4M2Vr7jSa1Ls6WGD+sZI14QZ2Wayo9LThwRuMUIM47SZ0wN/FPx0j
         kd1hcau3c3yk1f256w1nkBD7jgfHn/Nu4uE0cYAKT1WBfBFFWRwHP7cFe2O2sUD3gs+b
         Td0SHdIP9vflq4qOXHxmDm2e73kKFVKCwjwFQZhqqGgjR0/9GB3vP9MmgVNZ5KIthq7y
         tG6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WK1yhfHvG1QfbUB2fLHTgsNDlC/LVWhcW+SQQQ3zIFM=;
        b=ulGpIlcFx5oMMx0ksJpreKFxtsHBGv6pxtvDI8vn/fcXIrrlyQk7B+J+Gv1ZRJVwyV
         J+JzIv3WaKOhgu5Yc7/A7+GHO/joiOYMcH3ihoFwqixAsZ2oO6thziEe8fUYGFGrQ1xG
         FPRryCeE1qCu+Wz4H8wn6evxe6MALKYT51A5Lckpr11FdUDUbP4mh5PJZkbmhBbX8Xk6
         k24OvnpkRIFG2CyfI2nIzoc3xC6jUziPabwmDhEImyTpqonSXtetWDWrB6IC9RGtmDbC
         yZVf8Ef/dT8zs/fbm0At+gkZYMEbugZtT6vr2E1oYAayTSMBk0dchjAx3e1cHf9zTvvG
         dWHg==
X-Gm-Message-State: APjAAAXDpLaJSwwECbs3zxJ+MOMxxZUoIYoi9hwkTqpvi4YFx+HAuJis
        vPjynJ6sX54hyO3MKptgolGsk4aC
X-Google-Smtp-Source: APXvYqxUUF4rcv/IAwcIr3H2RZTC7dMav9IBOTL5ytBPw11Vcve3TGXbVRgCt6/1gipvtiNzi+n2qw==
X-Received: by 2002:a17:902:864b:: with SMTP id y11mr57209579plt.92.1559991444088;
        Sat, 08 Jun 2019 03:57:24 -0700 (PDT)
Received: from localhost.localdomain ([117.192.25.72])
        by smtp.googlemail.com with ESMTPSA id s24sm5021384pfh.133.2019.06.08.03.57.19
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 08 Jun 2019 03:57:23 -0700 (PDT)
From:   Deepak Mishra <linux.dkm@gmail.com>
To:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        linux.dkm@gmail.com, straube.linux@gmail.com
Subject: [PATCH v4 1/6] staging: rtl8712: Fixed CamelCase for EepromAddressSize
Date:   Sat,  8 Jun 2019 16:26:56 +0530
Message-Id: <48c99e4448fde40713827332b14c38de7f32eda6.1559990697.git.linux.dkm@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <cover.1559990697.git.linux.dkm@gmail.com>
References: <cover.1559990697.git.linux.dkm@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch renames CamelCase EepromAddressSizefrom to eeprom_address_size in
struct _adapter and in related files drv_types.h, rtl871x_eeprom.c, usb_intf.c

This was reported by checkpatch.pl

Signed-off-by: Deepak Mishra <linux.dkm@gmail.com>
---
 drivers/staging/rtl8712/drv_types.h      | 2 +-
 drivers/staging/rtl8712/rtl871x_eeprom.c | 6 +++---
 drivers/staging/rtl8712/usb_intf.c       | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8712/drv_types.h b/drivers/staging/rtl8712/drv_types.h
index 9ae86631fa8b..d4262a68dd4d 100644
--- a/drivers/staging/rtl8712/drv_types.h
+++ b/drivers/staging/rtl8712/drv_types.h
@@ -150,7 +150,7 @@ struct _adapter {
 	bool	suspended;
 	u32	IsrContent;
 	u32	ImrContent;
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

