Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B655C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 18:43:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66D8C2072B
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 18:43:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oJyyZRy5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726985AbfKOSnh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 13:43:37 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46131 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726075AbfKOSnf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 13:43:35 -0500
Received: by mail-wr1-f68.google.com with SMTP id b3so12026802wrs.13;
        Fri, 15 Nov 2019 10:43:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=z4v4wVl3s1hArrGKDQlCf3SAy+2jZtyPSY8RHpRjW/c=;
        b=oJyyZRy5EXzkcQq3r2IC4zfXoQLCh1o4QQleaHojeFxcrNSrx3byV0e6gSDEZIYwe/
         MssPxJ+9G6DF44CaOrNyRZyjyN8Da73LyY8SEh9RGDSzOLKR4AkSKQQoDSVxgdYUxqBj
         3bnpa0wkNnYplEgViPNUKhpwwtZbpBgdV08n+oImk0a8q637fcLWaywnIoQrt/3EhRa3
         sItgCcV5Zqm5J9PydN/h5w4f03vZ52TVCdA0IriGrrmVa5gFXmp9e+teu0kVXRKi6pAH
         M0EJs6nMxRGdipijRvnmN0E5jJKyKd+SgoHAFbIu1aVKLOl/nBJ85flVsF+5uHzFARs0
         E4kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=z4v4wVl3s1hArrGKDQlCf3SAy+2jZtyPSY8RHpRjW/c=;
        b=c7amPQ5QUc7U5EMqjQlsxArei6r7oVC4VD6UGT5/N9VNKEboY8EzjIZh8GWQ77+YJK
         u8TOfXFP0r7IbQ1JK6K6UkGHvzDSnBoWho5Ec2s1mrxut6arzRawU+8p4aF3Zt9vDnY3
         KnHFGkjVM16WyhSwwspTtdvBn4SbbA0dgYzhw7MfzzOEUlrc1jEbcTMlEkjkEe6tWL0Q
         nv1yGYwojH/wV7LFr0DdkNuzZK0KPIP7tUm8fYNi54DyxGzNmYkAVZzZj2EIxY2HavSH
         28oHcz6/n92BaCxMGwhFNDmgEoyCsmehvB6v1wfGl69lOg72sISTvS8NN1Fjs1nFQvi5
         JOOg==
X-Gm-Message-State: APjAAAWLwecay06XfFhmeJbEXkMFeOmgRRtGbNzARS80xzIJA/jUbvpH
        Z8PirlE6FDKR2TaIuqT2hdGAawTsIR8=
X-Google-Smtp-Source: APXvYqypblj+WoRCfg8ok56bDPdDYClw6eGKjG7CX6ktYZwwTyMpcN2qvlPf5Eli0dUJmUmAifJA0w==
X-Received: by 2002:a5d:6412:: with SMTP id z18mr16823980wru.30.1573843412929;
        Fri, 15 Nov 2019 10:43:32 -0800 (PST)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id g138sm2620989wmg.11.2019.11.15.10.43.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2019 10:43:32 -0800 (PST)
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
Subject: [PATCH v2 01/13] phy: usb: EHCI DMA may lose a burst of DMA data for 7255xA0 family
Date:   Fri, 15 Nov 2019 13:42:11 -0500
Message-Id: <20191115184223.41504-2-alcooperx@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191115184223.41504-1-alcooperx@gmail.com>
References: <20191115184223.41504-1-alcooperx@gmail.com>
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

