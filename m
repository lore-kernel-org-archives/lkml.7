Return-Path: <SRS0=X3/1=2E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2605CC43603
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Dec 2019 20:03:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC4372067C
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Dec 2019 20:03:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="NkHnbRqS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbfLNUDb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Dec 2019 15:03:31 -0500
Received: from mo4-p02-ob.smtp.rzone.de ([85.215.255.83]:14265 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726541AbfLNUDa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Dec 2019 15:03:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1576353806;
        s=strato-dkim-0002; d=goldelico.com;
        h=Message-Id:Date:Subject:Cc:To:From:X-RZG-CLASS-ID:X-RZG-AUTH:From:
        Subject:Sender;
        bh=joFOFRbAFN+4MtzlHvSp/yYX5kaJ6NjTa7iHBiYZKec=;
        b=NkHnbRqSK0x4OP5y/zDVG/mxNV/CJkydT1wTmXCeNNTWb5ebqlgt9VJTD8MzqQXX/R
        6/mq04l6ZzRphwuyZWjEx0+XsOMe1+tVEW6Y5Kf6p8FqvuZcGmtw5YfBZKeGyDKBXW9A
        qrYfJ0Fj9rwKuqmdp3XngX0tAHKPgNdcLhUqVZ8GjzL3Sjbcb79FfuZs1BNqCr4Qwjic
        B9kOrCm12CBR73L2AMhTnbQk2tuQFGFFGaiFSX8EmAXXwM2G80Xnc/g0fj4SFii9swsZ
        d49Afk4YOIjsJ3kCJybLKUzhhcxjfQjlghsvRt/1vk3vJxx8O+7mXTe9EHf4rayMaG8s
        rH2A==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9o1OAA2UNf2AyOEF/Q6ay"
X-RZG-CLASS-ID: mo00
Received: from iMac.fritz.box
        by smtp.strato.de (RZmta 46.0.7 DYNA|AUTH)
        with ESMTPSA id i03ca8vBEK36CBj
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Sat, 14 Dec 2019 21:03:06 +0100 (CET)
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
To:     Stefan Wahren <wahrenst@gmx.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     linux@armlinux.org.uk,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-rpi-kernel@lists.infradead.org,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        Linux-OMAP <linux-omap@vger.kernel.org>,
        Tony Lindgren <tony@atomide.com>, letux-kernel@openphoenux.org,
        kernel@pyra-handheld.com,
        "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH] ARM: bcm: Fix support for BCM2711 SoC which breaks other ARM platforms
Date:   Sat, 14 Dec 2019 21:03:05 +0100
Message-Id: <33662723d61a80669390abc1e592eb006d8709f1.1576353784.git.hns@goldelico.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 781fa0a95424 ("ARM: bcm: Add support for BCM2711 SoC")

breaks boot of many other platforms (e.g. OMAP or i.MX6) if
CONFIG_ARCH_BCM2835 is enabled in addition to some multiplatform
config (e.g. omap2plus_defconfig). The symptom is that the OMAP
based board does not show any activity beyond "Starting Kernel ..."
even with earlycon.

Reverting the mentioned commit makes it work again.

The real fix is to add the missing NULL sentinel to the
bcm2711_compat[] variable-length array.

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 arch/arm/mach-bcm/bcm2711.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-bcm/bcm2711.c b/arch/arm/mach-bcm/bcm2711.c
index dbe296798647..fa0300d8c79d 100644
--- a/arch/arm/mach-bcm/bcm2711.c
+++ b/arch/arm/mach-bcm/bcm2711.c
@@ -13,6 +13,7 @@ static const char * const bcm2711_compat[] = {
 #ifdef CONFIG_ARCH_MULTI_V7
 	"brcm,bcm2711",
 #endif
+	NULL
 };
 
 DT_MACHINE_START(BCM2711, "BCM2711")
-- 
2.23.0

