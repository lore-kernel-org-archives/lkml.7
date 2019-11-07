Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81159C5DF60
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 14:14:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 544412178F
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 14:14:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gS289DGL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389246AbfKGOOd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 09:14:33 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40247 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726924AbfKGOOc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 09:14:32 -0500
Received: by mail-wm1-f68.google.com with SMTP id f3so2591084wmc.5;
        Thu, 07 Nov 2019 06:14:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=z4v4wVl3s1hArrGKDQlCf3SAy+2jZtyPSY8RHpRjW/c=;
        b=gS289DGLAlmjTsIrrI+HnfOBs+MFe6Z+dMKRM77pwCmaqmab3zS/UDr4LGAIccnnoj
         PYrHQNF5s4/Ih6zl2gbemqnAbWBI5KZ1/la/tOIjs7Z1mEm6RUTlmwSd10j4EvE1y6dW
         RsyplNNZnac1XgHliHIM29YvJlXckXAD80h4vAYw1R7utQbpsjeMZK5CO5C5q42vjLcZ
         ElJ16ZMLWl3a4pFdrMUJk8C0/A/Og+Td8uC0OmSWoVCviiPxMrNZhrK2IkPaxbaf/raj
         MgVpm6kSFTyXyj34AndF/Vv5M8JU1kxfeuPS6cD5OLrLD9yTmp2GcVmknxjmj+xqTnIP
         Msog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=z4v4wVl3s1hArrGKDQlCf3SAy+2jZtyPSY8RHpRjW/c=;
        b=Z9ERVUttt9SoDXNE4/W42qBoOggMf+PiT/zY19JoMOODyCaTZ0VMeHXD2B1auPB4Ac
         TpF51AEaiOcpFub7Sy/cmZDRXxSG9572n46MNiEg8NTWdat2cnIsoi1YLCYa9S+6FCWN
         gMmJFdqn21Ek1YIgDRoYTcRbFkCOaqz0iN2EfQxhZpa+2Uugo165nUKkCn7SLkj9042C
         kDrSndoSC8GZwiYcM8uC+zaiFK2yjm/3AFgrYFgPlyHoOvPvIsdpS9JWS6VDM1SDWXFt
         9IEbJY1rR7z+3ZbIeIbAgjPOfH34nbJSObAOk7dbpM7FwljsMPLp9r8qVIUFyj+RzOlr
         98qg==
X-Gm-Message-State: APjAAAW+1z2nxJ6jYoVqIMMnhTU7aUeBkXDtNGrZPHiLBdH0tBO57yXd
        M+c2gs3mj2bv0kpCgAIVJ1oRfvlhgJI=
X-Google-Smtp-Source: APXvYqwYVZfRRrimnVJdMUO6UWxwQXvnQ3zdZ6Jzu5hsncWSH8RirMg9CVbBRICD2N/Qud6kBs4XGw==
X-Received: by 2002:a05:600c:20c9:: with SMTP id y9mr3019835wmm.72.1573136069870;
        Thu, 07 Nov 2019 06:14:29 -0800 (PST)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id b1sm2453888wrw.77.2019.11.07.06.14.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2019 06:14:28 -0800 (PST)
From:   Al Cooper <alcooperx@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Al Cooper <alcooperx@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-kernel@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Srinath Mannam <srinath.mannam@broadcom.com>
Subject: [PATCH 01/13] phy: usb: EHCI DMA may lose a burst of DMA data for 7255xA0 family
Date:   Thu,  7 Nov 2019 09:13:27 -0500
Message-Id: <20191107141339.6079-2-alcooperx@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191107141339.6079-1-alcooperx@gmail.com>
References: <20191107141339.6079-1-alcooperx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the EHCI controller received a 512 byte USB packet that
had to be broken into 2 256 byte bursts across the SCB bus AND
there was a following 512 byte USB packet, the second burst of
data from the first packet was sometimes being lost. If the
burst size was changed to 128 bytes via the EBR_SCB_SIZE field
in the USB_CTRL_EBRIDGE register we'd see the 4th 128 byte burst
of the first packet being lost. This problem became much worse
if other threads were running that accessed memory, like a memcpy
test. Setting the EBR_SCB_SIZE to 512, which prevents breaking
the EHCI USB packet (max size of 512 bytes) into bursts, fixed
the problem.

Signed-off-by: Al Cooper <alcooperx@gmail.com>
---
 drivers/phy/broadcom/phy-brcm-usb-init.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/phy/broadcom/phy-brcm-usb-init.c b/drivers/phy/broadcom/phy-brcm-usb-init.c
index 3c53625f8bc2..56d9b314a8d0 100644
--- a/drivers/phy/broadcom/phy-brcm-usb-init.c
+++ b/drivers/phy/broadcom/phy-brcm-usb-init.c
@@ -42,6 +42,7 @@
 #define   USB_CTRL_PLL_CTL_PLL_IDDQ_PWRDN_MASK		0x80000000 /* option */
 #define USB_CTRL_EBRIDGE		0x0c
 #define   USB_CTRL_EBRIDGE_ESTOP_SCB_REQ_MASK		0x00020000 /* option */
+#define   USB_CTRL_EBRIDGE_EBR_SCB_SIZE_MASK		0x00000f80 /* option */
 #define USB_CTRL_OBRIDGE		0x10
 #define   USB_CTRL_OBRIDGE_LS_KEEP_ALIVE_MASK		0x08000000
 #define USB_CTRL_MDIO			0x14
@@ -176,6 +177,7 @@ static const struct id_to_type id_to_type_table[] = {
 	{ 0x33900000, BRCM_FAMILY_3390A0 },
 	{ 0x72500010, BRCM_FAMILY_7250B0 },
 	{ 0x72600000, BRCM_FAMILY_7260A0 },
+	{ 0x72550000, BRCM_FAMILY_7260A0 },
 	{ 0x72680000, BRCM_FAMILY_7271A0 },
 	{ 0x72710000, BRCM_FAMILY_7271A0 },
 	{ 0x73640000, BRCM_FAMILY_7364A0 },
@@ -948,6 +950,17 @@ void brcm_usb_init_eohci(struct brcm_usb_init_params *params)
 	if (params->selected_family == BRCM_FAMILY_7271A0)
 		/* Enable LS keep alive fix for certain keyboards */
 		USB_CTRL_SET(ctrl, OBRIDGE, LS_KEEP_ALIVE);
+
+	if (params->family_id == 0x72550000) {
+		/*
+		 * Make the burst size 512 bytes to fix a hardware bug
+		 * on the 7255a0. See HW7255-24.
+		 */
+		reg = brcmusb_readl(USB_CTRL_REG(ctrl, EBRIDGE));
+		reg &= ~USB_CTRL_MASK(EBRIDGE, EBR_SCB_SIZE);
+		reg |= 0x800;
+		brcmusb_writel(reg, USB_CTRL_REG(ctrl, EBRIDGE));
+	}
 }
 
 void brcm_usb_init_xhci(struct brcm_usb_init_params *params)
-- 
2.17.1

