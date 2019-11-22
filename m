Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74A39C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 11:26:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4841320674
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 11:26:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574422012;
	bh=CaV5LegZwnaBQuppS0tYmH+zIr4VngiSBqdszVVVcOg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lBz7/POcarhyQNT6SqfPBU1uQyvImD1Xz/EYci8G7nRtlXQ35cmLTuZcq4VAfaDp5
	 5h6/75vcXyiFqaCEFC0KmaXIrtm5lF9P3VRZJlVpxtLreklkwPPL3wDVxGdUZxvEUC
	 KLhx59SSxby2+Mpniz8Ze+gJ+M2RTuB6GsOAAi98=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728742AbfKVL0v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 06:26:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:57158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727200AbfKVKds (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 05:33:48 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C0ECE20714;
        Fri, 22 Nov 2019 10:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574418827;
        bh=CaV5LegZwnaBQuppS0tYmH+zIr4VngiSBqdszVVVcOg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GXFJHb8CqSjwx12yAtk4MK74hQI0N3WSVKL/sBADXSLEDVDHCjBm3kbgYjFf+PLxG
         +rIPsswXAa3vuI7SAQbo6j6LDv3lmnQWc+reNkHE/OcdNeT8JY8jVl5cLzT9mubGzs
         H65kmd+DQ9Vz9KD7WC7uzl3Wmn1HEJQ6zFZ9Gkcc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andreas Kemnade <andreas@kemnade.info>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 064/159] power: supply: twl4030_charger: disable eoc interrupt on linear charge
Date:   Fri, 22 Nov 2019 11:27:35 +0100
Message-Id: <20191122100754.419956366@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191122100704.194776704@linuxfoundation.org>
References: <20191122100704.194776704@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andreas Kemnade <andreas@kemnade.info>

[ Upstream commit 079cdff3d0a09c5da10ae1be35def7a116776328 ]

This avoids getting woken up from suspend after power interruptions
when the bci wrongly thinks the battery is full just because
of input current going low because of low input power

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/power/twl4030_charger.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/drivers/power/twl4030_charger.c b/drivers/power/twl4030_charger.c
index 14fed11e8f6e3..5b1f147b11cb0 100644
--- a/drivers/power/twl4030_charger.c
+++ b/drivers/power/twl4030_charger.c
@@ -469,6 +469,7 @@ static void twl4030_current_worker(struct work_struct *data)
 static int twl4030_charger_enable_usb(struct twl4030_bci *bci, bool enable)
 {
 	int ret;
+	u32 reg;
 
 	if (bci->usb_mode == CHARGE_OFF)
 		enable = false;
@@ -482,14 +483,38 @@ static int twl4030_charger_enable_usb(struct twl4030_bci *bci, bool enable)
 			bci->usb_enabled = 1;
 		}
 
-		if (bci->usb_mode == CHARGE_AUTO)
+		if (bci->usb_mode == CHARGE_AUTO) {
+			/* Enable interrupts now. */
+			reg = ~(u32)(TWL4030_ICHGLOW | TWL4030_ICHGEOC |
+					TWL4030_TBATOR2 | TWL4030_TBATOR1 |
+					TWL4030_BATSTS);
+			ret = twl_i2c_write_u8(TWL4030_MODULE_INTERRUPTS, reg,
+				       TWL4030_INTERRUPTS_BCIIMR1A);
+			if (ret < 0) {
+				dev_err(bci->dev,
+					"failed to unmask interrupts: %d\n",
+					ret);
+				return ret;
+			}
 			/* forcing the field BCIAUTOUSB (BOOT_BCI[1]) to 1 */
 			ret = twl4030_clear_set_boot_bci(0, TWL4030_BCIAUTOUSB);
+		}
 
 		/* forcing USBFASTMCHG(BCIMFSTS4[2]) to 1 */
 		ret = twl4030_clear_set(TWL_MODULE_MAIN_CHARGE, 0,
 			TWL4030_USBFASTMCHG, TWL4030_BCIMFSTS4);
 		if (bci->usb_mode == CHARGE_LINEAR) {
+			/* Enable interrupts now. */
+			reg = ~(u32)(TWL4030_ICHGLOW | TWL4030_TBATOR2 |
+					TWL4030_TBATOR1 | TWL4030_BATSTS);
+			ret = twl_i2c_write_u8(TWL4030_MODULE_INTERRUPTS, reg,
+				       TWL4030_INTERRUPTS_BCIIMR1A);
+			if (ret < 0) {
+				dev_err(bci->dev,
+					"failed to unmask interrupts: %d\n",
+					ret);
+				return ret;
+			}
 			twl4030_clear_set_boot_bci(TWL4030_BCIAUTOAC|TWL4030_CVENAC, 0);
 			/* Watch dog key: WOVF acknowledge */
 			ret = twl_i2c_write_u8(TWL_MODULE_MAIN_CHARGE, 0x33,
-- 
2.20.1



