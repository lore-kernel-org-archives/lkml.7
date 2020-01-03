Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98EE1C2D0C2
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 18:19:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7106B227BF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 18:19:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lvn8VQQP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728341AbgACST0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 13:19:26 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45162 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728186AbgACSTY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 13:19:24 -0500
Received: by mail-pg1-f196.google.com with SMTP id b9so23745600pgk.12;
        Fri, 03 Jan 2020 10:19:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tYlVqZ98Bu0+Zyby+yVvjjOxtu1K1h5EceYqcDfe5rc=;
        b=lvn8VQQPryslAlAHQl3hUtYuJXvZ9Y1WILN0Zz+1vsgCXscv5EucXwDjK8aaqf6Ypo
         WklVZ/WY2JlhyF+W1raJUzIGT84DRNJHQWiywq6zzdr7LYNThIIk8o/4NU/38gIllC6S
         /H2fGrY2rqDbMow1oe9kF+WghEViQBDvEGAS3Kf1Vd9hBfj4JSjpHKeJT4yA5+S1uWe3
         3Kzh84p4KLeE6gObffByyJLZ+mZkeddWvOHgZ3FQZnhxEfPODedMbnbe1JhEoPo58KuC
         kg8hQowUYQj38KhtDFZc3/48d7fbiZ8OG5fIfnbDF86fXS3fb5yHr4rpLsCSHY6XBD2P
         PAhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tYlVqZ98Bu0+Zyby+yVvjjOxtu1K1h5EceYqcDfe5rc=;
        b=WTZKkf9SheTVUfL3ggh44z88bpaAsPA5glNuvka62N7M8NREdhpLvW9PqFDklWnwCP
         BGl5gTuJWfDoUJ4/HJHPhvc5+3UNngb+xTrTmgwpzVnEtBL0MocFWbC8DYJj6iyGtwiq
         NGgOaoM5pGSu6kQyoqudwIAzG/1G+W/FveXGREfc7Jtg1IQVvji2GlqhrZPc+ir8dWvW
         FubqoESVGcdRWs9rsSr3abmWp417XmSc6S6Lmu7yG0W9/tx5dxOvVej5w5B99Uwx7pQo
         5Ej22pfnF7LvMhUWy/knVnLraxUE4tVrI//XtAyvApvXC+KNyshW28Hfa7BCNolDHe5S
         1uxg==
X-Gm-Message-State: APjAAAVd6DpuhX9olDOmiQaj+5CdlKT/Nz5FhKZaTfSyZ38QfCUV1NnT
        Xxr0X8DjoknJhG6JcB+fGJWkhn2BkL4=
X-Google-Smtp-Source: APXvYqziYoHS89wTJewUzgzZaqX8iJKL/Zjafxp+UgLnpYBcRz0TG/9E6onzqbJFwBDyQss9P38a4w==
X-Received: by 2002:a63:b64a:: with SMTP id v10mr99872698pgt.145.1578075564094;
        Fri, 03 Jan 2020 10:19:24 -0800 (PST)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id j8sm41783602pfe.182.2020.01.03.10.19.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jan 2020 10:19:23 -0800 (PST)
From:   Al Cooper <alcooperx@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Al Cooper <alcooperx@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com (maintainer:BROADCOM BCM7XXX ARM
        ARCHITECTURE), Srinath Mannam <srinath.mannam@broadcom.com>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM BCM7XXX
        ARM ARCHITECTURE)
Subject: [PATCH v4 01/13] phy: usb: EHCI DMA may lose a burst of DMA data for 7255xA0 family
Date:   Fri,  3 Jan 2020 13:17:59 -0500
Message-Id: <20200103181811.22939-2-alcooperx@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200103181811.22939-1-alcooperx@gmail.com>
References: <20200103181811.22939-1-alcooperx@gmail.com>
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
index 91b5b09589d6..bd473d12ab28 100644
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

