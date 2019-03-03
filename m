Return-Path: <SRS0=GAfv=RG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED2CAC43381
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 20:16:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BABF520835
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 20:16:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cgsNV9fP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726655AbfCCUQp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 15:16:45 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:37665 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726560AbfCCUQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 15:16:43 -0500
Received: by mail-lf1-f67.google.com with SMTP id z196so1997833lff.4
        for <linux-kernel@vger.kernel.org>; Sun, 03 Mar 2019 12:16:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vxg6nL5ZL1nlLrsFLJRm0Et8CGCgajaMVbUxf1C8lIo=;
        b=cgsNV9fPWU7+IRSEckG17pDnMX6Avc8hrmC9SgXmQ5f0s4I8yAEFt8z94O3f/efxk+
         CfTeC0XbDpysM/W+WpE5T5WiLeyeJIOpp//pu+YHLwQPM2MmegsrbC6MLW8UasQtp440
         ItTKMFCTByTB7pI8yWcJx9GZnh5orbQJem+jyEBuJrgr0W76oCgfHP0sRlXlg9fClA4Z
         EtaOnyWlSG28aPQ0jx9ePOvH5LQTmPml+Q3xjLREJo/vXZ0CmrrOJJWn7Gpb1XF9Ls1B
         eJdQZDdY2uWZ7eK8mQRvzDscVfw4zqGy6u9WEpAm1gOnnENr9TG/+TU/qiQ3cIECtFPt
         rT0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vxg6nL5ZL1nlLrsFLJRm0Et8CGCgajaMVbUxf1C8lIo=;
        b=lAIxUjkgwocdVEg5+3fLL6ojhek3FWMPMWo0yOx74BplALegp0TmwNcR3afjnt3Vk1
         1IfUs5nvFK1mU3isjJHYUfelicOz6ixu9v/Wl2HX+nj72pCzlfoW0v0s5/NLFR948qb8
         3uBfo0gkZQQTNxgnJRgiUEZrguYRaN+N9eqDyXTA+zvpTe2suLdT3m5G8fyYKjXFpMaU
         eRD5CzgjVwuvVYFVYuR3ZpIZlKZEnqjFUlnYmwdxNbG7LNtNk4d1SARZbYkII7FC13qP
         aRELJ3dWrbk7m7IB159EabQa8tU7iRKh0H723cMrxpmB5e9PfbmvkfGdE+A5zt1U7Tjh
         OT6g==
X-Gm-Message-State: APjAAAUhOqsQ97SR7wMgl/bn1cVrH3jN2NRbWJvfw7h3BSF/lGqfbiZZ
        FPb8nrh3gCBx1vgR93p0UDiJEUTs
X-Google-Smtp-Source: APXvYqzBv3sAu3xF+VIiMsS5X1SnprEpJQC9n9bMv4ZEyPEJV8K95d5Pax3Xqyr2URxZ+yYO7O3CCQ==
X-Received: by 2002:a19:ef12:: with SMTP id n18mr8368809lfh.82.1551644201313;
        Sun, 03 Mar 2019 12:16:41 -0800 (PST)
Received: from localhost.localdomain ([46.216.192.153])
        by smtp.gmail.com with ESMTPSA id y14sm1149303lfl.24.2019.03.03.12.16.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 03 Mar 2019 12:16:39 -0800 (PST)
Received: from jek by localhost.localdomain with local (Exim 4.92-RC4)
        (envelope-from <jekhor@gmail.com>)
        id 1h0XXK-0005Bk-7c; Sun, 03 Mar 2019 23:16:38 +0300
From:   Yauhen Kharuzhy <jekhor@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Yauhen Kharuzhy <jekhor@gmail.com>
Subject: [PATCH v3 2/2] extcon intel-cht-wc: Enable external charger
Date:   Sun,  3 Mar 2019 23:16:13 +0300
Message-Id: <20190303201613.19884-3-jekhor@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190303201613.19884-1-jekhor@gmail.com>
References: <20190303201613.19884-1-jekhor@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In some configuration external charger "#charge enable" signal is
connected to PMIC. Enable it at device probing to allow charging.

Save CHGRCTRL0 and CHGDISCTR registers at driver probing and restore
them at driver unbind to re-enable hardware charging control if it was
enabled before.

Tested at Lenovo Yoga Book (YB1-X91L).

Signed-off-by: Yauhen Kharuzhy <jekhor@gmail.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/extcon/extcon-intel-cht-wc.c | 34 +++++++++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/drivers/extcon/extcon-intel-cht-wc.c b/drivers/extcon/extcon-intel-cht-wc.c
index 8d20e913536f..53b28ecc4ad1 100644
--- a/drivers/extcon/extcon-intel-cht-wc.c
+++ b/drivers/extcon/extcon-intel-cht-wc.c
@@ -56,6 +56,13 @@
 #define CHT_WC_USBSRC_TYPE_OTHER	8
 #define CHT_WC_USBSRC_TYPE_DCP_EXTPHY	9
 
+#define CHT_WC_CHGDISCTRL		0x5e2f
+#define CHT_WC_CHGDISCTRL_OUT		BIT(0)
+/* 0 - open drain, 1 - regular push-pull output */
+#define CHT_WC_CHGDISCTRL_DRV		BIT(4)
+/* 0 - pin is controlled by SW, 1 - by HW */
+#define CHT_WC_CHGDISCTRL_FN		BIT(6)
+
 #define CHT_WC_PWRSRC_IRQ		0x6e03
 #define CHT_WC_PWRSRC_IRQ_MASK		0x6e0f
 #define CHT_WC_PWRSRC_STS		0x6e1e
@@ -218,6 +225,18 @@ static void cht_wc_extcon_set_otgmode(struct cht_wc_extcon_data *ext,
 		dev_err(ext->dev, "Error updating CHGRCTRL1 reg: %d\n", ret);
 }
 
+static void cht_wc_extcon_enable_charging(struct cht_wc_extcon_data *ext,
+					  bool enable)
+{
+	unsigned int val = enable ? 0 : CHT_WC_CHGDISCTRL_OUT;
+	int ret;
+
+	ret = regmap_update_bits(ext->regmap, CHT_WC_CHGDISCTRL,
+				 CHT_WC_CHGDISCTRL_OUT, val);
+	if (ret)
+		dev_err(ext->dev, "Error updating CHGDISCTRL reg: %d\n", ret);
+}
+
 /* Small helper to sync EXTCON_CHG_USB_SDP and EXTCON_USB state */
 static void cht_wc_extcon_set_state(struct cht_wc_extcon_data *ext,
 				    unsigned int cable, bool state)
@@ -242,6 +261,7 @@ static void cht_wc_extcon_pwrsrc_event(struct cht_wc_extcon_data *ext)
 
 	id = cht_wc_extcon_get_id(ext, pwrsrc_sts);
 	if (id == USB_ID_GND) {
+		cht_wc_extcon_enable_charging(ext, false);
 		cht_wc_extcon_set_otgmode(ext, true);
 
 		/* The 5v boost causes a false VBUS / SDP detect, skip */
@@ -249,6 +269,7 @@ static void cht_wc_extcon_pwrsrc_event(struct cht_wc_extcon_data *ext)
 	}
 
 	cht_wc_extcon_set_otgmode(ext, false);
+	cht_wc_extcon_enable_charging(ext, true);
 
 	/* Plugged into a host/charger or not connected? */
 	if (!(pwrsrc_sts & CHT_WC_PWRSRC_VBUS)) {
@@ -302,6 +323,14 @@ static int cht_wc_extcon_sw_control(struct cht_wc_extcon_data *ext, bool enable)
 {
 	int ret, mask, val;
 
+	val = enable ? 0 : CHT_WC_CHGDISCTRL_FN;
+	ret = regmap_update_bits(ext->regmap, CHT_WC_CHGDISCTRL,
+				 CHT_WC_CHGDISCTRL_FN, val);
+	if (ret)
+		dev_err(ext->dev,
+			"Error setting sw control for CHGDIS pin: %d\n",
+			ret);
+
 	mask = CHT_WC_CHGRCTRL0_SWCONTROL | CHT_WC_CHGRCTRL0_CCSM_OFF;
 	val = enable ? mask : 0;
 	ret = regmap_update_bits(ext->regmap, CHT_WC_CHGRCTRL0, mask, val);
@@ -353,7 +382,10 @@ static int cht_wc_extcon_probe(struct platform_device *pdev)
 	/* Enable sw control */
 	ret = cht_wc_extcon_sw_control(ext, true);
 	if (ret)
-		return ret;
+		goto disable_sw_control;
+
+	/* Disable charging by external battery charger */
+	cht_wc_extcon_enable_charging(ext, false);
 
 	/* Register extcon device */
 	ret = devm_extcon_dev_register(ext->dev, ext->edev);
-- 
2.20.1

