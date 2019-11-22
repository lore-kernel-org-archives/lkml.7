Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D1E1C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 10:31:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B3EB20714
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 10:31:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574418690;
	bh=WvA7ooE23+rMcSXpkAwDLVyHFb12QEhAyN/XFwoVHjE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EogoRkxtcZge9nC+c9sj3sSIefcG5Z4FjC9Pp/cBRsiEX1lkqkCCo9URePrniaoyD
	 HneLUcqaTBacf7b21nyHbL3KkCZad9rC1KQ/Z1AJ6FK7Hs1iZin6qSSqJ1KVauOvhu
	 1jtPDYhiqwkVrh7ViozG1JCtiuh+I5rsBdYj4Sk4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727315AbfKVKb3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 05:31:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:51562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727289AbfKVKb0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 05:31:26 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 657F320717;
        Fri, 22 Nov 2019 10:31:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574418685;
        bh=WvA7ooE23+rMcSXpkAwDLVyHFb12QEhAyN/XFwoVHjE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zwwGbjGsgsq4hTflqtFnv3udpsk9THDX6SXOhe5kalq+an1TIKy7AoRomcO+L5lau
         iCic+Ih3YR6+udObEc/TQf91zcVBuGBG80aovYZaOFLyBXvEJ1juEkFNYLueRxCKjv
         1rlktd1iEvbiP2EV+cr9L8i9YRCJKyKSFidu2GA0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        Paul Burton <paul.burton@mips.com>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>,
        linux-mips@linux-mips.org, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 018/159] MIPS: BCM47XX: Enable USB power on Netgear WNDR3400v3
Date:   Fri, 22 Nov 2019 11:26:49 +0100
Message-Id: <20191122100720.475073737@linuxfoundation.org>
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

From: Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>

[ Upstream commit feef7918667b84f9d5653c501542dd8d84ae32af ]

Setting GPIO 21 high seems to be required to enable power to USB ports
on the WNDR3400v3. As there is already similar code for WNR3500L,
make the existing USB power GPIO code generic and use that.

Signed-off-by: Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>
Acked-by: Hauke Mehrtens <hauke@hauke-m.de>
Signed-off-by: Paul Burton <paul.burton@mips.com>
Patchwork: https://patchwork.linux-mips.org/patch/20259/
Cc: Rafał Miłecki <zajec5@gmail.com>
Cc: linux-mips@linux-mips.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/mips/bcm47xx/workarounds.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/mips/bcm47xx/workarounds.c b/arch/mips/bcm47xx/workarounds.c
index e81ce4623070e..06fb94370c7c9 100644
--- a/arch/mips/bcm47xx/workarounds.c
+++ b/arch/mips/bcm47xx/workarounds.c
@@ -4,9 +4,8 @@
 #include <bcm47xx_board.h>
 #include <bcm47xx.h>
 
-static void __init bcm47xx_workarounds_netgear_wnr3500l(void)
+static void __init bcm47xx_workarounds_enable_usb_power(int usb_power)
 {
-	const int usb_power = 12;
 	int err;
 
 	err = gpio_request_one(usb_power, GPIOF_OUT_INIT_HIGH, "usb_power");
@@ -22,7 +21,10 @@ void __init bcm47xx_workarounds(void)
 
 	switch (board) {
 	case BCM47XX_BOARD_NETGEAR_WNR3500L:
-		bcm47xx_workarounds_netgear_wnr3500l();
+		bcm47xx_workarounds_enable_usb_power(12);
+		break;
+	case BCM47XX_BOARD_NETGEAR_WNDR3400_V3:
+		bcm47xx_workarounds_enable_usb_power(21);
 		break;
 	default:
 		/* No workaround(s) needed */
-- 
2.20.1



