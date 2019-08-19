Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2BC5C3A59B
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 08:46:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BE4C2082C
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 08:46:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727090AbfHSIqM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 04:46:12 -0400
Received: from xavier.telenet-ops.be ([195.130.132.52]:45730 "EHLO
        xavier.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726211AbfHSIqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 04:46:12 -0400
Received: from ramsan ([84.194.98.4])
        by xavier.telenet-ops.be with bizsmtp
        id qwm82000M05gfCL01wm8Xc; Mon, 19 Aug 2019 10:46:10 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1hzdIm-0004GM-5V; Mon, 19 Aug 2019 10:46:08 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1hzcad-0003fi-Cb; Mon, 19 Aug 2019 10:00:31 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Linus Walleij <linusw@kernel.org>, Imre Kaloz <kaloz@openwrt.org>,
        Krzysztof Halasa <khalasa@piap.pl>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] soc: ixp4xx: Protect IXP4xx SoC drivers by ARCH_IXP4XX || COMPILE_TEST
Date:   Mon, 19 Aug 2019 10:00:28 +0200
Message-Id: <20190819080028.13091-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The move of the IXP4xx SoC drivers exposed their config options on all
platforms.

Fix this by wrapping them inside an ARCH_IXP4XX or COMPILE_TEST block.

Fixes: fcf2d8978cd538a5 ("ARM: ixp4xx: Move NPE and QMGR to drivers/soc")
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
v2:
  - Rebased on top of commit ec8f24b7faaf3d47 ("treewide: Add SPDX
    license identifier - Makefile/Kconfig").
---
 drivers/soc/ixp4xx/Kconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/soc/ixp4xx/Kconfig b/drivers/soc/ixp4xx/Kconfig
index de2e62c3310a37d0..e3eb19b85fa4b358 100644
--- a/drivers/soc/ixp4xx/Kconfig
+++ b/drivers/soc/ixp4xx/Kconfig
@@ -1,4 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-only
+if ARCH_IXP4XX || COMPILE_TEST
+
 menu "IXP4xx SoC drivers"
 
 config IXP4XX_QMGR
@@ -15,3 +17,5 @@ config IXP4XX_NPE
 	  and is automatically selected by Ethernet and HSS drivers.
 
 endmenu
+
+endif
-- 
2.17.1

