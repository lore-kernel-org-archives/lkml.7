Return-Path: <SRS0=BIzH=UB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA4A2C28CC6
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Jun 2019 10:27:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90608278D3
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Jun 2019 10:27:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f9UqLVUs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbfFBK1A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Jun 2019 06:27:00 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36856 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726980AbfFBK06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jun 2019 06:26:58 -0400
Received: by mail-pf1-f194.google.com with SMTP id u22so8873678pfm.3
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jun 2019 03:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=H/UOYaUuSv3BYs/6fr1qvCTOeBxayYz1L+t266OVcrM=;
        b=f9UqLVUs392Ph0L/TbCTOTvNh9vDFyO6aBR8WM/VEfZ7Ao6Y64ouJoLftyedkTp+wH
         v4gVQBWvrGbgMXmXQfn0LH2GrVSMt02eslWBvymjU1L63NCBc9dpQSIer8uqXYBF6S44
         SVw5dGM3K8A75YExPXrhD8VXbmyqjRvtb1jo0RKZP6DubHn+HOm7wuOTIPA5fdG/1gPM
         4G5Y/7F4VWY4m3PG7tNP0a2Vbr87GyAVU32KGLoao6JiT9kUf7rZWWXz95Y+deHchgbk
         dwtFvlvOuX15bmRjEjVX71ic10c2546Sj8pkFLu53U/xaH1dy+t2D3Q1x/Vv/DbifDqn
         Tfnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=H/UOYaUuSv3BYs/6fr1qvCTOeBxayYz1L+t266OVcrM=;
        b=nQG1Wkdx6Qt24mHREuyms+e5Fd6Jag/5Ax7qnJBOA+CBQfL92aj3ANB4v2jfTofQTG
         Cn4lYQRt0O29/5JS0UchCzYjlATzQ+YuaYadFAwFQvPrbxh3C+Uywc9b4uswfsVy1SaU
         HZ968OA5TDTTNjceNan+p4CX3ZpXQ7rEjkKqr6ayVScbg4GBj67GBJo5XAUt2PEBVrU2
         EU5Wsy3Px2YV9zn9PVYVLXejGwe0FL1jimBRrMyxByxyR/qF0kX4ChUagG3gLL8clOKg
         w+NmszvDc8eHp3Gzaw15pUtBcFbcgypAZxZI3pyNTe60mpLpbswIF9zn6x3FClgbLOHW
         wdwA==
X-Gm-Message-State: APjAAAW5dOV2iEqiSz2lL+ldOpPuKZXk1R49eRcWx302kq2/7MJPTvL0
        0kCTfOe8waKU//GtJM8tyswsFlsK
X-Google-Smtp-Source: APXvYqyWHPGgP7CteLevTrGH/40QdENuEg0lSDPHbszWS+obd++S0D+jxFWGaTJAA2u8g9C5tmx+sQ==
X-Received: by 2002:a63:eb56:: with SMTP id b22mr20492557pgk.81.1559471217156;
        Sun, 02 Jun 2019 03:26:57 -0700 (PDT)
Received: from localhost.localdomain ([117.192.23.157])
        by smtp.googlemail.com with ESMTPSA id j13sm12221099pfh.13.2019.06.02.03.26.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 02 Jun 2019 03:26:56 -0700 (PDT)
From:   Deepak Mishra <linux.dkm@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, joe@perches.com, wlanfae@realtek.com,
        Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        linux.dkm@gmail.com, himadri18.07@gmail.com,
        straube.linux@gmail.com
Subject: [PATCH v2 9/9] staging: rtl8712: Fixed CamelCase lockRxFF0Filter
Date:   Sun,  2 Jun 2019 15:55:38 +0530
Message-Id: <c555df2475320ac55d1498d87ca0e38681934af3.1559470738.git.linux.dkm@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <cover.1559470737.git.linux.dkm@gmail.com>
References: <cover.1559470737.git.linux.dkm@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes CamelCase lockRxFF0Filter by renaming to
lock_rx_ff0_filter in drv_types.h and related files
usb_intf.c and xmit_linux.c

This was reported by checkpatch.pl

Signed-off-by: Deepak Mishra <linux.dkm@gmail.com>
---
 drivers/staging/rtl8712/drv_types.h  | 2 +-
 drivers/staging/rtl8712/usb_intf.c   | 2 +-
 drivers/staging/rtl8712/xmit_linux.c | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8712/drv_types.h b/drivers/staging/rtl8712/drv_types.h
index e3e2b32e964e..087fad7a4433 100644
--- a/drivers/staging/rtl8712/drv_types.h
+++ b/drivers/staging/rtl8712/drv_types.h
@@ -165,7 +165,7 @@ struct _adapter {
 	int pid; /*process id from UI*/
 	struct work_struct wk_filter_rx_ff0;
 	bool enable_rx_ff0_filter;
-	spinlock_t lockRxFF0Filter;
+	spinlock_t lock_rx_ff0_filter;
 	const struct firmware *fw;
 	struct usb_interface *pusb_intf;
 	struct mutex mutex_start;
diff --git a/drivers/staging/rtl8712/usb_intf.c b/drivers/staging/rtl8712/usb_intf.c
index 200a271c28e1..d0daae0b8299 100644
--- a/drivers/staging/rtl8712/usb_intf.c
+++ b/drivers/staging/rtl8712/usb_intf.c
@@ -571,7 +571,7 @@ static int r871xu_drv_init(struct usb_interface *pusb_intf,
 	/* step 6. Load the firmware asynchronously */
 	if (rtl871x_load_fw(padapter))
 		goto error;
-	spin_lock_init(&padapter->lockRxFF0Filter);
+	spin_lock_init(&padapter->lock_rx_ff0_filter);
 	mutex_init(&padapter->mutex_start);
 	return 0;
 error:
diff --git a/drivers/staging/rtl8712/xmit_linux.c b/drivers/staging/rtl8712/xmit_linux.c
index 9fa1abcf5e50..1b52be50c04c 100644
--- a/drivers/staging/rtl8712/xmit_linux.c
+++ b/drivers/staging/rtl8712/xmit_linux.c
@@ -102,9 +102,9 @@ void r8712_SetFilter(struct work_struct *work)
 	newvalue = oldvalue & 0xfe;
 	r8712_write8(padapter, 0x117, newvalue);
 
-	spin_lock_irqsave(&padapter->lockRxFF0Filter, irqL);
+	spin_lock_irqsave(&padapter->lock_rx_ff0_filter, irqL);
 	padapter->enable_rx_ff0_filter = true;
-	spin_unlock_irqrestore(&padapter->lockRxFF0Filter, irqL);
+	spin_unlock_irqrestore(&padapter->lock_rx_ff0_filter, irqL);
 	do {
 		msleep(100);
 	} while (padapter->enable_rx_ff0_filter == true);
-- 
2.19.1

