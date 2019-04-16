Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2E4BC282DA
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 04:15:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B568D20870
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 04:15:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726320AbfDPEPQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 00:15:16 -0400
Received: from www.osadl.org ([62.245.132.105]:49326 "EHLO www.osadl.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725770AbfDPEPQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 00:15:16 -0400
Received: from debian01.hofrr.at (178.115.242.59.static.drei.at [178.115.242.59])
        by www.osadl.org (8.13.8/8.13.8/OSADL-2007092901) with ESMTP id x3G48kX0003254;
        Tue, 16 Apr 2019 06:08:46 +0200
From:   Nicholas Mc Guire <hofrat@osadl.org>
To:     Russell King <linux@armlinux.org.uk>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Mark Brown <broonie@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Nicholas Mc Guire <hofrat@osadl.org>
Subject: [PATCH V2] ARM: imx legacy: warn on failed allocation
Date:   Tue, 16 Apr 2019 06:03:29 +0200
Message-Id: <1555387409-9018-1-git-send-email-hofrat@osadl.org>
X-Mailer: git-send-email 2.1.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Even in init the allocation can fail and thus should report by 
pr_err() so that the cause can be easily identified.

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
Link: https://lkml.org/lkml/2019/4/14/152
---

Problem located with an experimental coccinelle script

V2: Russell King <linux@armlinux.org.uk> pointed out that the use of
    WARN_ON() would result in a stack trace followed by the oops due
    to dereferencing of the NULL pointer and so make it even less
    likely that users would uncover the actual cause - so drop the 
    WARN_ON() and use a short pr_err() message that points to the 
    oops cause directly.

Note that this will trigger a checkpatch WARNING:
     "WARNING: Possible unnecessary 'out of memory' message"
but comparing the oops with an without the one-line pr_err I would argue
that it makes sense to include it (first line here is from pr_err()):
<snip>
[ 8061.514840] shared page allocation failure in hello_init()
[ 8113.563239] BUG: unable to handle kernel NULL pointer dereference at 0000000000000000
[ 8113.563250] #PF error: [WRITE]
[ 8113.563255] PGD 8000000129993067 P4D 8000000129993067 PUD 129992067 PMD 0
[ 8113.563267] Oops: 0002 [#1] SMP PTI
[ 8113.563276] CPU: 2 PID: 2656 Comm: bash Tainted: G        W  O      5.0.0-rc3livepatchtest-next-20190123+ #4
[ 8113.563280] Hardware name: Quanta TWH/TWH, BIOS QU221 10/14/2011
[ 8113.563292] RIP: 0010:foo_store+0x3a/0x90 [hello_chardev]
...
<snip>

Patch was compile-tested with: imx_v4_v5_defconfig (implies
CONFIG_MACH_MX27ADS=y)
(with some unrelated sparse warnings about unimplemented syscalls)

Patch is against 5.1-rc4 (localversion-next is 20190415)

 arch/arm/mach-imx/mach-mx27ads.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/mach-imx/mach-mx27ads.c b/arch/arm/mach-imx/mach-mx27ads.c
index 6dd7f57..cba6876 100644
--- a/arch/arm/mach-imx/mach-mx27ads.c
+++ b/arch/arm/mach-imx/mach-mx27ads.c
@@ -247,6 +247,10 @@ static void __init mx27ads_regulator_init(void)
 	struct gpio_chip *vchip;
 
 	vchip = kzalloc(sizeof(*vchip), GFP_KERNEL);
+	if (!vchip)
+		pr_err("vchip allocation failure in %s()\n",
+			__func__);
+
 	vchip->owner		= THIS_MODULE;
 	vchip->label		= "LCD";
 	vchip->base		= MX27ADS_LCD_GPIO;
-- 
2.1.4

