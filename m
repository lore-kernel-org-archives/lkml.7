Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1E31C00454
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 13:23:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8AEC20838
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 13:23:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jZzB5gqP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727426AbfLJNXc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 08:23:32 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34200 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727007AbfLJNXc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 08:23:32 -0500
Received: by mail-wr1-f67.google.com with SMTP id t2so20121166wrr.1;
        Tue, 10 Dec 2019 05:23:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tYlVqZ98Bu0+Zyby+yVvjjOxtu1K1h5EceYqcDfe5rc=;
        b=jZzB5gqPUI3Hj70GjZNHqyyRNK9JThh41oK5NzYRbAVSm2j+Dd6sheZHpPU/n3jCS5
         ZfUKfNC8F8C3S82L/y5j825tPX504MV8WMZbd6mL6UJzvXwsPllBSXBXT//9yc+qaT05
         imcx3vmWIlQ/YZyYqZwK5Oztyyebp+3d4tC6MgEYX1Ki5Uqc1+rrR3p6qEE0BbCZk2YS
         Ua+n+g87LCAwOqF95+/Y0u4hGFGmVYLt+7HUS07/UA9bXNlSPL7FkEoPKhudv0oj5HS7
         WR3ur9BLlE0fjKWJTBRMdJj/Vn9TL5HRTKfvLRFraqgoiMdlSCVGtgVrtWcIalyly6gs
         A6HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tYlVqZ98Bu0+Zyby+yVvjjOxtu1K1h5EceYqcDfe5rc=;
        b=HM0FfDxEHRNLDGI/QUOt0nvlp3Vv/BDAW92sSmuNeVb+1adjovliDH7uy6y2RZlxOX
         7HCQDO5arjMx49B4lIEly17LX+Co7cy463xnXF3n8qEu4Viv8gtpc7FnKRGju7c+5lWD
         Ul0eJXZc45smsuAv4WM1wywXOb6y9GEXXvkvstH2Rqv1dDVrSSwliwSYw64Z+xRIv7Ig
         ZsKvdx//W7I0UeVrMR8gCjkEX1DhLykOfI0mV65RjItqswJAEuwgEpAd0Nqfs5h7s07D
         F/PUZ7CJeyq6z9wWmIWXrTpcDHqJmanux3J5D24jh42ysPXGm/lm121W+kdkyj+86M71
         CPmA==
X-Gm-Message-State: APjAAAVOT23RMgXLvPJlnL49zGRI9QXQ6KxYvxZvXQadG53z5zAUlxmm
        ja0zSme/jNm/qH8PW9hpmYc+KW/8nvc=
X-Google-Smtp-Source: APXvYqzbQ8Wi3DrflQJbTS3u95A5D/ncezIkztrhiNUWCvQkJLQhSRJ0R34HfCtKe90L+9ShlzV4KA==
X-Received: by 2002:a5d:5491:: with SMTP id h17mr3409334wrv.374.1575984209868;
        Tue, 10 Dec 2019 05:23:29 -0800 (PST)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id s82sm3101680wms.28.2019.12.10.05.23.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2019 05:23:29 -0800 (PST)
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
Subject: [PATCH v3 01/13] phy: usb: EHCI DMA may lose a burst of DMA data for 7255xA0 family
Date:   Tue, 10 Dec 2019 08:21:20 -0500
Message-Id: <20191210132132.41509-2-alcooperx@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191210132132.41509-1-alcooperx@gmail.com>
References: <20191210132132.41509-1-alcooperx@gmail.com>
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

