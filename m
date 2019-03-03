Return-Path: <SRS0=GAfv=RG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11F13C43381
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 20:16:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D514720835
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 20:16:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kvX6Y0cW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726673AbfCCUQu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 15:16:50 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:36112 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726537AbfCCUQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 15:16:43 -0500
Received: by mail-lf1-f68.google.com with SMTP id x206so2001940lff.3
        for <linux-kernel@vger.kernel.org>; Sun, 03 Mar 2019 12:16:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OVMATTTBe6mN2Dkxx3Jx1vC4Vraful6LpkudWtzDOno=;
        b=kvX6Y0cWzI7+9xPAgWcXfx9UEXlbGONJyFk3M5IT0SLJ9OQp3CjCCU0kM5IuFVghJ3
         rLL2kFYN5cWQALM6f9mbpJ3DvA4lx6NuIDTyzk6PDIyMdIvT9N9CEru0xkcRsofZEUIi
         9Ss/k1221YcTUBPpr1HpjY6qfg7g2r9tdPJnovqNpiD0kX7aKcozuqjTrOsc0K/Z1dAC
         ppGNKstyFUKbIJeBG6v+zBGfd9g7oOJXJOpxcGZzIBWeMZhkhH+rpJC/27AKo+g7kuoi
         Il1viGEnjSLisX3hYeNYzDLqokGFjqnGHj0zWNGLqmE8cVTCbwCa9R0c46bVrEPTfdpP
         vEAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OVMATTTBe6mN2Dkxx3Jx1vC4Vraful6LpkudWtzDOno=;
        b=T3TN357KDzZrFi3ZOZIKXb6M2ctInZqh6HStaLnfwKdgYCLSY5hyUBWQ8Rpd3NBgwr
         /LUoO2T75+4j61gsVN7KlZN5taKQfuMFPiaAHWkUtfOOP+Mn+ziLGm3Kghuqf4OnQ7EB
         0x6KU+A8Ea667fL4cYFA7n34CoJuNHoPjERkyKA7i3hZvuRIWHmXACrehYy4RGezo8iR
         1Qf8iAzJalP+Z7ZsYafoAF/Mwla5qg4euPJR19zRF3J87ZmxkRJZMMopFoS2mCIdTtro
         PP/m+r8r4zkh1ILq+BK3G75dfC33+WbJ6ShGhCdorwSThHcdtn4wTJUq5I7QfWOF9g4d
         lc1A==
X-Gm-Message-State: APjAAAWHhMcnoLni7cD/j8fgchRgcjk57+HwNGJ9Xjsy1+orncx60lyg
        /x4fWN88Z13sj1z7/mh4yYuBb4/v
X-Google-Smtp-Source: APXvYqz+Qr3Ji81PSuXfvYdpcwVu6+nEvWZxYlQuXqnqtIqbg0cPswLHAxoVYzUQU6IkVAjrTglqJw==
X-Received: by 2002:ac2:5316:: with SMTP id c22mr4912637lfh.113.1551644201058;
        Sun, 03 Mar 2019 12:16:41 -0800 (PST)
Received: from localhost.localdomain ([46.216.192.153])
        by smtp.gmail.com with ESMTPSA id y5sm1140517lfe.61.2019.03.03.12.16.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 03 Mar 2019 12:16:39 -0800 (PST)
Received: from jek by localhost.localdomain with local (Exim 4.92-RC4)
        (envelope-from <jekhor@gmail.com>)
        id 1h0XXK-0005Bi-6v; Sun, 03 Mar 2019 23:16:38 +0300
From:   Yauhen Kharuzhy <jekhor@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Yauhen Kharuzhy <jekhor@gmail.com>
Subject: [PATCH v3 1/2] extcon-intel-cht-wc: Make charger detection co-existed with OTG host mode
Date:   Sun,  3 Mar 2019 23:16:12 +0300
Message-Id: <20190303201613.19884-2-jekhor@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190303201613.19884-1-jekhor@gmail.com>
References: <20190303201613.19884-1-jekhor@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Whiskey Cove Cherry Trail PMIC requires disabling OTG host mode before
of charger detection procedure. Do this by manipulationg of CHGRCTRL1
register.

Source: APCI DSDT code of Lenovo Yoga Book YB1-X91L and open-sourced
Intel's drivers.

Signed-off-by: Yauhen Kharuzhy <jekhor@gmail.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/extcon/extcon-intel-cht-wc.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/drivers/extcon/extcon-intel-cht-wc.c b/drivers/extcon/extcon-intel-cht-wc.c
index 5ef215297101..8d20e913536f 100644
--- a/drivers/extcon/extcon-intel-cht-wc.c
+++ b/drivers/extcon/extcon-intel-cht-wc.c
@@ -29,7 +29,15 @@
 #define CHT_WC_CHGRCTRL0_DBPOFF		BIT(6)
 #define CHT_WC_CHGRCTRL0_CHR_WDT_NOKICK	BIT(7)
 
-#define CHT_WC_CHGRCTRL1		0x5e17
+#define CHT_WC_CHGRCTRL1			0x5e17
+#define CHT_WC_CHGRCTRL1_FUSB_INLMT_100		BIT(0)
+#define CHT_WC_CHGRCTRL1_FUSB_INLMT_150		BIT(1)
+#define CHT_WC_CHGRCTRL1_FUSB_INLMT_500		BIT(2)
+#define CHT_WC_CHGRCTRL1_FUSB_INLMT_900		BIT(3)
+#define CHT_WC_CHGRCTRL1_FUSB_INLMT_1500	BIT(4)
+#define CHT_WC_CHGRCTRL1_FTEMP_EVENT		BIT(5)
+#define CHT_WC_CHGRCTRL1_OTGMODE		BIT(6)
+#define CHT_WC_CHGRCTRL1_DBPEN			BIT(7)
 
 #define CHT_WC_USBSRC			0x5e29
 #define CHT_WC_USBSRC_STS_MASK		GENMASK(1, 0)
@@ -198,6 +206,18 @@ static void cht_wc_extcon_set_5v_boost(struct cht_wc_extcon_data *ext,
 		dev_err(ext->dev, "Error writing Vbus GPIO CTLO: %d\n", ret);
 }
 
+static void cht_wc_extcon_set_otgmode(struct cht_wc_extcon_data *ext,
+				      bool enable)
+{
+	unsigned int val = enable ? CHT_WC_CHGRCTRL1_OTGMODE : 0;
+	int ret;
+
+	ret = regmap_update_bits(ext->regmap, CHT_WC_CHGRCTRL1,
+				 CHT_WC_CHGRCTRL1_OTGMODE, val);
+	if (ret)
+		dev_err(ext->dev, "Error updating CHGRCTRL1 reg: %d\n", ret);
+}
+
 /* Small helper to sync EXTCON_CHG_USB_SDP and EXTCON_USB state */
 static void cht_wc_extcon_set_state(struct cht_wc_extcon_data *ext,
 				    unsigned int cable, bool state)
@@ -222,10 +242,14 @@ static void cht_wc_extcon_pwrsrc_event(struct cht_wc_extcon_data *ext)
 
 	id = cht_wc_extcon_get_id(ext, pwrsrc_sts);
 	if (id == USB_ID_GND) {
+		cht_wc_extcon_set_otgmode(ext, true);
+
 		/* The 5v boost causes a false VBUS / SDP detect, skip */
 		goto charger_det_done;
 	}
 
+	cht_wc_extcon_set_otgmode(ext, false);
+
 	/* Plugged into a host/charger or not connected? */
 	if (!(pwrsrc_sts & CHT_WC_PWRSRC_VBUS)) {
 		/* Route D+ and D- to PMIC for future charger detection */
-- 
2.20.1

