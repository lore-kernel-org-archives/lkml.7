Return-Path: <SRS0=kYop=UV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D519C43613
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 15:15:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C18742070B
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 15:15:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JMEp6RRy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726350AbfFVPO7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Jun 2019 11:14:59 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37046 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726276AbfFVPO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jun 2019 11:14:58 -0400
Received: by mail-wr1-f68.google.com with SMTP id v14so9343363wrr.4
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jun 2019 08:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Hlltdd819Z4HVUHqJ9lASsafkzr+pdN9swCMNOEn+uU=;
        b=JMEp6RRyKVagF6YXQZtgcQqe5WLVUPYmZKfxBDy7DjIJNeBtOObNnyV0oBEXlqHu6o
         QsGdEHWuaBJKvinbLbjtPLrUOXOKRFb3lJevOZJwrGsr2qNDtu4COpgoFgv7fkoXvOS7
         +673At4K8ULUXLPGShuwQ6r3WthiNsI+pFHMY+sFsQOiDBmYbaMSTpqF1hm6DTKDgnPF
         1POuuMt9khERXny3SG6T12YOMr/0O8Uv/5e30Kn/8KgBDgrUn7Zj9hGSn5IcOw3DH1+k
         zga+aKy6L5VEPcWuUPJL0KMu+qCLtBejxA67hsgamLfLmayrrKjfwkJEeO/HSQaMn6NW
         fKCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Hlltdd819Z4HVUHqJ9lASsafkzr+pdN9swCMNOEn+uU=;
        b=XCfEdtdk++O7u3/Eg0hfU0TnwiWRRWcZZPnynTpK23zRsrhzKfrrLV7qNRQ4BjnsVI
         2e7T6k0WSOWfmuiwwWFdsi0Dmj0jLPTCf1A9Vwjuuhvm+zCEPTFBGASFcmLHcOKBrUCb
         18Zvlu1lkMIDZji0JD+ZdvmFAFRhhQTBM7adxcKK8LxDgGnEWdXB1V1KURojYRuXuLdF
         Z595fTMl8+B7jB04i6VzM4IjISr1R0e0nTXuRSNwbJw8aOtE36HKpdJcLhD0taif58+s
         OzsK45XiXUXCFxSzigA/jr4shtxA7xvyePVqBeHXsC5pxGcX+D0NUvZyIGuKVc1l2Tif
         owGg==
X-Gm-Message-State: APjAAAWQJvCrlvhnnoDY3E/1LY5WoB+6KvZxqdldTn2X29E+vd2X6s7R
        5T5QMyjae7uFgmNGf5d4ztPMbJ4a
X-Google-Smtp-Source: APXvYqzrBDzoHXcM0oue9IFG8oz5bocZlC3fvcptI5/FtWs3NAX2vXEJGq8oICuh/k0KOoO8+7LJzA==
X-Received: by 2002:adf:de8e:: with SMTP id w14mr25259242wrl.130.1561216496722;
        Sat, 22 Jun 2019 08:14:56 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96bf:e0ab:2b68:5d76:a12a:e6ba])
        by smtp.gmail.com with ESMTPSA id o126sm7099847wmo.1.2019.06.22.08.14.55
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 22 Jun 2019 08:14:56 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 1/2] staging: rtl8188eu: cleanup lines ending with a '('
Date:   Sat, 22 Jun 2019 17:14:48 +0200
Message-Id: <20190622151449.32095-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cleanup checkpatch issues in usb_halinit.c.
CHECK: Lines should not end with a '('

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/hal/usb_halinit.c | 21 +++++----------------
 1 file changed, 5 insertions(+), 16 deletions(-)

diff --git a/drivers/staging/rtl8188eu/hal/usb_halinit.c b/drivers/staging/rtl8188eu/hal/usb_halinit.c
index 70c02c49b177..69008accb015 100644
--- a/drivers/staging/rtl8188eu/hal/usb_halinit.c
+++ b/drivers/staging/rtl8188eu/hal/usb_halinit.c
@@ -469,10 +469,7 @@ static void usb_AggSettingTxUpdate(struct adapter *Adapter)
  *
  *---------------------------------------------------------------------------
  */
-static void
-usb_AggSettingRxUpdate(
-		struct adapter *Adapter
-	)
+static void usb_AggSettingRxUpdate(struct adapter *Adapter)
 {
 	struct hal_data_8188e *haldata = Adapter->HalData;
 	u8 valueDMA;
@@ -1044,10 +1041,7 @@ static void Hal_EfuseParseMACAddr_8188EU(struct adapter *adapt, u8 *hwinfo, bool
 		 eeprom->mac_addr));
 }
 
-static void
-readAdapterInfo_8188EU(
-		struct adapter *adapt
-	)
+static void readAdapterInfo_8188EU(struct adapter *adapt)
 {
 	struct eeprom_priv *eeprom = GET_EEPROM_EFUSE_PRIV(adapt);
 
@@ -1067,9 +1061,7 @@ readAdapterInfo_8188EU(
 	Hal_ReadThermalMeter_88E(adapt, eeprom->efuse_eeprom_data, eeprom->bautoload_fail_flag);
 }
 
-static void _ReadPROMContent(
-	struct adapter *Adapter
-	)
+static void _ReadPROMContent(struct adapter *Adapter)
 {
 	struct eeprom_priv *eeprom = GET_EEPROM_EFUSE_PRIV(Adapter);
 	u8 eeValue;
@@ -1782,11 +1774,8 @@ void rtw_hal_get_hwreg(struct adapter *Adapter, u8 variable, u8 *val)
 /*	Description: */
 /*		Query setting of specified variable. */
 /*  */
-u8 rtw_hal_get_def_var(
-		struct adapter *Adapter,
-		enum hal_def_variable eVariable,
-		void *pValue
-	)
+u8 rtw_hal_get_def_var(struct adapter *Adapter, enum hal_def_variable eVariable,
+		       void *pValue)
 {
 	struct hal_data_8188e *haldata = Adapter->HalData;
 	u8 bResult = _SUCCESS;
-- 
2.22.0

