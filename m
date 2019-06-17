Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F22F3C31E57
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 12:25:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB88F2084D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 12:25:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbfFQMZC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 08:25:02 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:40503 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725962AbfFQMZC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 08:25:02 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.129]) with ESMTPA (Nemesis) id
 1My2pz-1iYGtf3Fa3-00zX9v; Mon, 17 Jun 2019 14:24:52 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     arm@kernel.org, Linus Walleij <linusw@kernel.org>,
        Imre Kaloz <kaloz@openwrt.org>,
        Krzysztof Halasa <khalasa@piap.pl>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] ARM: ixp4xx: don't select SERIAL_OF_PLATFORM
Date:   Mon, 17 Jun 2019 14:24:30 +0200
Message-Id: <20190617122449.457744-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:izgkkqiYW3AxUHIzeLBlbI6TmUm8js3/ausmRdZTi/CUk41VLa9
 9uUs0EqvMRyhEz1jdbrH9qH6zS/8Pv0IwVKAIGPqTim15RwAqastjBBINHUBtpf6wRpDBxi
 zHlpMkLW2JLoBoUvgxkXY9brNtuux8UgfBUD697Lg7hwF3PomP3zhb6GmVPeN41pSlV3Urj
 2tZu7AQ/6U54PeHUDxzLg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:z6sxF1MZXgA=:hBHpgT3dNHS17k7G+0miEh
 5X1qSU25Zi9I3CfnGXHI7EKElzzgYmsLcU6gQ5sDSrd46KHOz2hiNOzxgxGPKDPiSv9+tL9Fb
 1mD8TTqBwbjAxrXxJUlcbeas8LZGS4n5CtoI4FoKrHzup3aAalavHvsGYrSWewu/zUvHx8LwP
 CWNIDnOHKgjQNb7xqXkTDyyXuNEiQ6RW08PI/p4gmPo16QixkrruddPAml7iebWL1iEEszmla
 N0GzFkPDc3iJrCXKGF9ttu4nE+NpwfaFzQK2iPR62rGqDUT5KdRiFMFzVbZK8AkNGpekv68T4
 DGpYRQv/cyvtkRhaNk2lSV+lJzq/abF6yvvxTF/l6+w2g1C+k8IQlxw11KbAOjtJkxmQlEh9J
 BPcm9SPKGiHEDRMst2B7ggYJt1g/Xgia/XihoNueRTx5N3ek8mxcZ3LHxbBj5mpGvmB2Nwfl1
 pJNQEn+428ZqhT3x0Gv5jGQk1vnRzPahdV+7CGlFMYwypb1iWdaKfVsietcY8jEoD5NEQBjci
 TeZakT3nauDqGyWFd6TVNcmbz+zL6nAZkHsbM11+sp0TN2gTqDM6T8Q5TAxRzwFLepkT9yqV3
 oc1RpOW779Drw4pScIlWNVG6mUkxyhp9QkbDxroEdmyyy4vvmQVsFmR9N647EMj/NEg61gT6Z
 MUKd8v4gYWTD28wszdMT/qH5IizeXpEwjlykTnPDAkyDt27PhYxPPfmLXQE9HSCdp28XP7Z5P
 6hteye4loSfIIqcazkMN7/3VUyK8rRTlFFL3nA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Platforms should not normally select all the device drivers, leave that
up to the user and the defconfig file.

In this case, we get a warning for randconfig builds:

WARNING: unmet direct dependencies detected for SERIAL_OF_PLATFORM
  Depends on [n]: TTY [=y] && HAS_IOMEM [=y] && SERIAL_8250 [=n] && OF [=y]
  Selected by [y]:
  - MACH_IXP4XX_OF [=y] && ARCH_IXP4XX [=y]

Fixes: 9540724ca29d ("ARM: ixp4xx: Add device tree boot support")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-ixp4xx/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-ixp4xx/Kconfig b/arch/arm/mach-ixp4xx/Kconfig
index 2f052c56cd9e..fc5378b00f3d 100644
--- a/arch/arm/mach-ixp4xx/Kconfig
+++ b/arch/arm/mach-ixp4xx/Kconfig
@@ -13,7 +13,6 @@ config MACH_IXP4XX_OF
 	select I2C
 	select I2C_IOP3XX
 	select PCI
-	select SERIAL_OF_PLATFORM
 	select TIMER_OF
 	select USE_OF
 	help
-- 
2.20.0

