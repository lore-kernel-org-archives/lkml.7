Return-Path: <SRS0=BIzH=UB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B526C28CC6
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Jun 2019 10:26:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6459C278C3
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Jun 2019 10:26:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kKWvD2by"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726824AbfFBK0g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Jun 2019 06:26:36 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:37241 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726716AbfFBK0g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jun 2019 06:26:36 -0400
Received: by mail-pl1-f193.google.com with SMTP id e7so5330899pln.4
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jun 2019 03:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0hMsepfH6IW6HUx1sRcRU95Hyuebg+1T2jfeo69Aps4=;
        b=kKWvD2byAMrDFbNiBErUBinleobA8A28SYr/lwZPDBK6GD0Z5oVivMCMlvv1PN1iIJ
         LiF7tIPxXUstpFwAXo9sE53L1FgJb3z81/Tq51SB7Lu/IY+O2x/6WVv/R9pYTMPnuvVD
         Gr7E/lHp9fDv3uq80PicP/+Oyh7/lkOrqD5lPHniXAU3gOzW67Wfpm6rFsymrFYAmm+R
         9KPQU991Pp3rbCbKnQaBgbadsmFnYikil/r6wK8mNH8m5LjU/m7zr0EtuZF+UQpkejVo
         TzyWp1M/ThaTe2nVMirLcmvR6c7yxB76KHnVHC0/tQq6QXO+i5iXMssYq5cYuMfgoHt2
         Axkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0hMsepfH6IW6HUx1sRcRU95Hyuebg+1T2jfeo69Aps4=;
        b=lcMNKWAy2ybuq4ucDzs+yjmXaTaLmlh9QmTQ6Z9BFq5b2cyvYEmVkmXm5tfrojJ4mc
         RKl4KdZ9QU1Q3GhzfoppZkcXMSxa0MCSzLrfutC4c/aEQCFlXUPwIQkMqYaAmCFDaq3H
         CfShvfandSG7yWpsjgbtPsQJVxCRXi44HNiu9L8u4lroT5kt/jDckz7tvpozju1ThPAi
         Ex3arlKZUtTnzWXa2urTweyjU5RNMUq7Y5ZJKR9WuAg3umyyWMcead1xdeZR06TGvwC+
         8NLSrEUPJyPDDubbhpbDL/YTvcYkxBAlFiUo+MK+KMepfZJ+ech9wfGXgBmOLYrcZUHl
         fvCQ==
X-Gm-Message-State: APjAAAWisHugrNuaty3dIIRtCLXa/NhiAblETfQ7XOKkW/gOx5B89qWo
        krGWhCfeMvXwR9Roc8n5Fex0hdtu
X-Google-Smtp-Source: APXvYqwP+MSt5agqTt3E+EWvDO2QTlyYYt7ki0E30HyA8o9FLQyfugnxPrlPa6O9PxZBxaqqaaWAiA==
X-Received: by 2002:a17:902:26c:: with SMTP id 99mr22745197plc.215.1559471195080;
        Sun, 02 Jun 2019 03:26:35 -0700 (PDT)
Received: from localhost.localdomain ([117.192.23.157])
        by smtp.googlemail.com with ESMTPSA id j13sm12221099pfh.13.2019.06.02.03.26.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 02 Jun 2019 03:26:34 -0700 (PDT)
From:   Deepak Mishra <linux.dkm@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, joe@perches.com, wlanfae@realtek.com,
        Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        linux.dkm@gmail.com, himadri18.07@gmail.com,
        straube.linux@gmail.com
Subject: [PATCH v2 2/9] staging: rtl8712: Fixed CamelCase EepromAddressSize rename to eeprom_address_size
Date:   Sun,  2 Jun 2019 15:55:31 +0530
Message-Id: <2af0899bc0c3e9b46ad6bcec8078a8f3f3fe0689.1559470738.git.linux.dkm@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <cover.1559470737.git.linux.dkm@gmail.com>
References: <cover.1559470737.git.linux.dkm@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch renames CamelCase EepromAddressSizefrom to eeprom_address_size in
struct _adapter and in related files drv_types.h, rtl871x_eeprom.c, usb_intf.c

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

