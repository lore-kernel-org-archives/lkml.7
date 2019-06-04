Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D85E3C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 04:22:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADBCF24A31
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 04:22:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ruGY8pLR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726555AbfFDEWJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 00:22:09 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33906 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725267AbfFDEWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 00:22:08 -0400
Received: by mail-pg1-f194.google.com with SMTP id h2so6308394pgg.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2019 21:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ENLiHSDk/br0xoKT0numiTuJUHrTL0/MjClfpbchOcw=;
        b=ruGY8pLRmgtWQudDGgTiSOCqKOtRUb0BKOprW+HnYbBrQ47c9MwNgH3eJ+ypOOuZ0e
         9IYAxS6A2DIg32DSifbHodAajnYvpz/l8pZtsrjNIGj8rlfa6h4ohzDea432a8JADQ2p
         LA0trgiJ55D4n0uEFf1AcV+NSYKUDJBs5l5AuCdFdgsJuE8pgoUugQ5Z4kDFWtmU8t2C
         7KeKDEvDEEdgzO2FzBX1ViXkZXT3cY0xuUAvWpncqQdsGRaV6nyOlC2FRFw0G4iFntmW
         A4Hj6Fv/jtBc5sxyrNYiZmbVMwSezh2tkvIAcKdhlYutKM2Vhdv03bj3UMIcRF2/eM66
         f1TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ENLiHSDk/br0xoKT0numiTuJUHrTL0/MjClfpbchOcw=;
        b=kcHKIemf1RSA9OOIFC/0fgmNrJg7jA10Bszv+272ML22bwY273qTOXOOMbnLD95VkM
         SwnQrgy/TAvbhlko13uuA9do5o1lI6Al7FMl9/mHW46lVsqYoNmqQlFTbmTUB1XqWnsz
         zCs1RupyHFmdcWeGdt1ppCdktFxdK0IfTpcxqX7vzMdgG4m8vZ15cwJBHMCfnmjjTtWm
         z46DlqJibJ0KMWLRUrhor0h2n9VCIaY6UMoT/EdGB1BAlcBieyNi/UcAqTkQMTUogg5h
         f0C9LesHFRnq3dS40M0J/MQn2N8Huvr31tUT2RYzphHLiGMsFrMant/BX+9bj8OPPBao
         Jk6g==
X-Gm-Message-State: APjAAAUv3aPT0ogmWi4auYK+9kpH9Xcye6MMjbCAba22sRCNUPa3hyBI
        ffgvNYLgGq42ADSFKgacNQa5Ut8+
X-Google-Smtp-Source: APXvYqx7dxOXERucqXGRvIpcIGo1B6ynZ/B7PGsp11/3RFCpVE+ojb8SOHFS1LK7Eh/2uiPPfE6f0Q==
X-Received: by 2002:a63:b1d:: with SMTP id 29mr32938337pgl.103.1559622127307;
        Mon, 03 Jun 2019 21:22:07 -0700 (PDT)
Received: from localhost.localdomain ([117.192.17.118])
        by smtp.googlemail.com with ESMTPSA id q3sm14382390pgv.21.2019.06.03.21.22.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Jun 2019 21:22:06 -0700 (PDT)
From:   Deepak Mishra <linux.dkm@gmail.com>
To:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org
Cc:     joe@perches.com, Larry.Finger@lwfinger.net,
        florian.c.schilhabel@googlemail.com, linux.dkm@gmail.com
Subject: [PATCH v3 1/4] staging: rtl8712: Fixed CamelCase for EepromAddressSize and removed unused variable
Date:   Tue,  4 Jun 2019 09:51:33 +0530
Message-Id: <23fdeda6601c9a40e90882ea52171ae43079e012.1559615579.git.linux.dkm@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <cover.1559615579.git.linux.dkm@gmail.com>
References: <cover.1559615579.git.linux.dkm@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch renames CamelCase EepromAddressSizefrom to eeprom_address_size in
struct _adapter and in related files drv_types.h, rtl871x_eeprom.c, usb_intf.c

CHECK: Avoid CamelCase: <EepromAddressSize>

This patch removed unused variable ImrContent from struct _adapter and
struct pwrctrl_priv and redundant lines from rtl871x_mp_ioctl.c

Signed-off-by: Deepak Mishra <linux.dkm@gmail.com>
---
 drivers/staging/rtl8712/drv_types.h        | 3 +--
 drivers/staging/rtl8712/rtl871x_eeprom.c   | 6 +++---
 drivers/staging/rtl8712/rtl871x_mp_ioctl.c | 5 -----
 drivers/staging/rtl8712/rtl871x_pwrctrl.h  | 1 -
 drivers/staging/rtl8712/usb_intf.c         | 2 +-
 5 files changed, 5 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/rtl8712/drv_types.h b/drivers/staging/rtl8712/drv_types.h
index 9ae86631fa8b..9fbd19f03ca9 100644
--- a/drivers/staging/rtl8712/drv_types.h
+++ b/drivers/staging/rtl8712/drv_types.h
@@ -149,8 +149,7 @@ struct _adapter {
 	bool	surprise_removed;
 	bool	suspended;
 	u32	IsrContent;
-	u32	ImrContent;
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
diff --git a/drivers/staging/rtl8712/rtl871x_mp_ioctl.c b/drivers/staging/rtl8712/rtl871x_mp_ioctl.c
index 588346da1412..add6c18195d6 100644
--- a/drivers/staging/rtl8712/rtl871x_mp_ioctl.c
+++ b/drivers/staging/rtl8712/rtl871x_mp_ioctl.c
@@ -661,11 +661,6 @@ uint oid_rt_pro_write_register_hdl(struct oid_par_priv *poid_par_priv)
 			status = RNDIS_STATUS_NOT_ACCEPTED;
 			break;
 		}
-
-		if ((status == RNDIS_STATUS_SUCCESS) &&
-		    (RegRWStruct->offset == HIMR) &&
-		    (RegRWStruct->width == 4))
-			Adapter->ImrContent = RegRWStruct->value;
 	}
 	return status;
 }
diff --git a/drivers/staging/rtl8712/rtl871x_pwrctrl.h b/drivers/staging/rtl8712/rtl871x_pwrctrl.h
index 11b5034f203d..2dd9f558d351 100644
--- a/drivers/staging/rtl8712/rtl871x_pwrctrl.h
+++ b/drivers/staging/rtl8712/rtl871x_pwrctrl.h
@@ -88,7 +88,6 @@ struct	pwrctrl_priv {
 	uint pwr_mode;
 	uint smart_ps;
 	uint alives;
-	uint ImrContent;	/* used to store original imr. */
 	uint bSleep; /* sleep -> active is different from active -> sleep. */
 
 	struct work_struct SetPSModeWorkItem;
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

