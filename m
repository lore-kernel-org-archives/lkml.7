Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88801C04AB3
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 06:59:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58DDA208CB
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 06:59:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q6RbDwFu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726489AbfE2G73 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 02:59:29 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46684 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725894AbfE2G73 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 02:59:29 -0400
Received: by mail-pf1-f193.google.com with SMTP id y11so967290pfm.13;
        Tue, 28 May 2019 23:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=E0bgQPgSMP42ZfwbXSuWmab92jZuGUt5fjUbtxPvUiM=;
        b=q6RbDwFuYeqmLObYFuGGv3IhcdW/xXwSAuFrYppBH6OO+8L3KNxSk+IKK4E5ymQFV3
         XhJbNHq6X7ey6lX8G0pV8nLJb+loJ/alNZktblCVwnT7ATMhZTPF0rahL4loLOQC3lKC
         BxMOT+4Dqr4qlc1+yRXKKXbMUkMbFj6JV5kI1wmp/zuMYu8i6W+P66kOxN2NY7ymNNBO
         qjLiEgCI92ckzR09fz9Et6YGDUki/35FRp4a+hZdwK7LlS+Ba8yFV+goftBnPhDiqH+u
         xnTJjYvEV9b4xEm57R3rjZFIzne99Wof9cDEatUwMMImPPcPDbdTNTiFf4ElRwOfmnpc
         PeZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=E0bgQPgSMP42ZfwbXSuWmab92jZuGUt5fjUbtxPvUiM=;
        b=DvS8Evkcb5vWJB5CcklEgz7U6jEuF0TygEModraJBLUslvcVn4RDPGDI5w27nw8Fxq
         sYDE14GBhHiWkUVr6+CgagtEFZDbzoPNR3e2UIdrbpqxnJd8ewUpvsZxibcoJAwyyp7n
         VzfMZlY/PU38GQBVuE/vS9ZMfC2yP4du6Ea3Yj/gwVkm+ZXS7k8C0aYg6TJCUr37chH0
         8aGu1agpwNspZT2cjY+POpnAM0HjJHQkI/Sm0RGgyYMGTqfB2yG0KIWWKqBC/DbckBpT
         HLPNGJIdwPH+LMDzK8h50jPhEeGOmPV85czZxQdQqs7Ri+eF8xpq6yaFKhuXtTi2fCJX
         8UHQ==
X-Gm-Message-State: APjAAAX0NxJCSi//Mhf+T9hGD5WcyGrkmqc7cWrZoHuEUuq7NTsbW8FG
        HFESueChxmr1Vzy1Y9xyJKg=
X-Google-Smtp-Source: APXvYqygMFesjpxG7whDDRrd9WqbksrEbmnXXra+/oJvA7nDyHOwRoOVRjJk7SUc3+UOQxSR30RXgw==
X-Received: by 2002:a63:5601:: with SMTP id k1mr6195259pgb.367.1559113168357;
        Tue, 28 May 2019 23:59:28 -0700 (PDT)
Received: from localhost.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id l20sm16207663pff.102.2019.05.28.23.59.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 May 2019 23:59:27 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Chris Healy <cphealy@gmail.com>,
        Felipe Balbi <balbi@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] usb: phy: mxs: Disable external charger detect in mxs_phy_hw_init()
Date:   Tue, 28 May 2019 23:59:04 -0700
Message-Id: <20190529065904.4548-1-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since this driver already handles changer detction state, copy the
workaround code currently residing in arch/arm/mach-imx/anatop.c into
this drier to consolidate the places modifying it.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Felipe Balbi <balbi@kernel.org>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: NXP Linux Team <linux-imx@nxp.com>
Cc: linux-usb@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
---

The intent of this patch is to consolidate all of the code maipulating
charge detection state to a signle place and if this patch is agreed
upon I plan to follow it up with this change:

https://github.com/ndreys/linux/commit/7248f2b85b4706760fd33d2ff970e2ea12d3bea7

Thanks,
Andrey Smirnov

 drivers/usb/phy/phy-mxs-usb.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/usb/phy/phy-mxs-usb.c b/drivers/usb/phy/phy-mxs-usb.c
index 1b1bb0ad40c3..6fa16ab31e2e 100644
--- a/drivers/usb/phy/phy-mxs-usb.c
+++ b/drivers/usb/phy/phy-mxs-usb.c
@@ -63,6 +63,7 @@
 
 #define ANADIG_USB1_CHRG_DETECT_SET		0x1b4
 #define ANADIG_USB1_CHRG_DETECT_CLR		0x1b8
+#define ANADIG_USB2_CHRG_DETECT_SET		0x214
 #define ANADIG_USB1_CHRG_DETECT_EN_B		BIT(20)
 #define ANADIG_USB1_CHRG_DETECT_CHK_CHRG_B	BIT(19)
 #define ANADIG_USB1_CHRG_DETECT_CHK_CONTACT	BIT(18)
@@ -250,6 +251,19 @@ static int mxs_phy_hw_init(struct mxs_phy *mxs_phy)
 	if (mxs_phy->data->flags & MXS_PHY_NEED_IP_FIX)
 		writel(BM_USBPHY_IP_FIX, base + HW_USBPHY_IP_SET);
 
+	if (mxs_phy->regmap_anatop) {
+		unsigned int reg = mxs_phy->port_id ?
+			ANADIG_USB1_CHRG_DETECT_SET :
+			ANADIG_USB2_CHRG_DETECT_SET;
+		/*
+		 * The external charger detector needs to be disabled,
+		 * or the signal at DP will be poor
+		 */
+		regmap_write(mxs_phy->regmap_anatop, reg,
+			     ANADIG_USB1_CHRG_DETECT_EN_B |
+			     ANADIG_USB1_CHRG_DETECT_CHK_CHRG_B);
+	}
+
 	mxs_phy_tx_init(mxs_phy);
 
 	return 0;
-- 
2.21.0

