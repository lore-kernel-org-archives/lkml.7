Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55BD2C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 13:54:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EDBE20830
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 13:54:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729273AbfCYNyw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 09:54:52 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:57297 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726136AbfCYNyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 09:54:52 -0400
Received: from wuerfel.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MEFnR-1hIcf10MWD-00AI1A; Mon, 25 Mar 2019 14:54:42 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] usb: mtu3: fix EXTCON dependency
Date:   Mon, 25 Mar 2019 14:54:30 +0100
Message-Id: <20190325135440.2166315-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Zbb7MMeGdeb863Dkkf0uRINDNXGjdVZvMW1rsAu4DzSl+dH8DM1
 7JmYSZTemXkBoWkf+P81jpmFEFmA76GMyZvvgd3MS70/0DNYHHT37c+I6jpjlrNQyfPSu0K
 SC800mUXVa4iTiHPWbm4va3Ul7XTkk44GlVwMJypx8yUgP0pm6eJKfPS4zVBeVu/e/fGzKn
 f/Gl9a9c09yPFKTZQaJyw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:t13HCCPBbyg=:sa7EMgEwsETT0X2DLSIpNq
 NaC7Gu7zoO+7XL9dnCo2Uj8/PaaV64CeXaGkSE6mzHXv+He0+bpWYC4+NUX2hwMIHJQdTOlOY
 3Zg81F8jeCi1UIgGNiS7NQiJ6En1Wg/GGksM0tw7dg++aBCjXZok8j0Ngt5gDAfxfOvLXmSwE
 yo5TEdqePTjmNHKo6c+0Bw94R7tIlLv4tprGzoDZERhoGMwGZRZZj3/4Kr/tV9BM2PVOJZDGk
 1Sja/l9WpLVgvpcxkF7TrlhWI6P7vjHe3dquYMI6w1EiunjJGjH83ex2UQ0zeWZzP+Y3Tz33G
 /Fj/rpFFbQ5W1n2jF99j1WF1IFmBk3q28MqgXkNCX5OXULQKV5AlIjVD+3HwTgEUme1NUoML0
 sVqg9zvlMxVM76QzOisk8HX3G98Qpeuav1FELap1lncpeGEk9ZsMHSomkdfiN2Q3Hy8CX+SNg
 KS6M0nQ4yY0p5Iv8lEhWfM3soR3Be1kQrb1w+D3b2adlFMVunquAtjMq95PEFj+aamaG6Yvf/
 Nj8IqTOe3CY5l/do59wG969fZCy2En7GlTHCfDW86kCu9aClR4GJx6fKAgvpZYx4mq+ZznZ2U
 eE2/EY26ylxTZlnMrQzw0rCSxIMN9Z52bLVlYolGVFnF4MJgxDOFvIoruQVYEimrdcRVmCgz7
 tAOMh5BYumhNfuIvRoUnk2MfdYVaEzyscp3UfRB2XZaP2bePFyvH/ffQH4UuiWZio7F6E27qT
 ZFEMAsSaHi/+lKg2vntF+t+rpGMwW5DpbDVRsg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When EXTCON is a loadable module, mtu3 fails to link as built-in:

drivers/usb/mtu3/mtu3_plat.o: In function `mtu3_probe':
mtu3_plat.c:(.text+0x690): undefined reference to `extcon_get_edev_by_phandle'

Add a Kconfig dependency to force mtu3 also to be a loadable module
if extconn is, but still allow it to be built without extcon.

Fixes: d0ed062a8b75 ("usb: mtu3: dual-role mode support")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/usb/mtu3/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/mtu3/Kconfig b/drivers/usb/mtu3/Kconfig
index bcc23486c4ed..928c2cd6fc00 100644
--- a/drivers/usb/mtu3/Kconfig
+++ b/drivers/usb/mtu3/Kconfig
@@ -6,6 +6,7 @@ config USB_MTU3
 	tristate "MediaTek USB3 Dual Role controller"
 	depends on USB || USB_GADGET
 	depends on ARCH_MEDIATEK || COMPILE_TEST
+	depends on EXTCON || !EXTCON
 	select USB_XHCI_MTK if USB_SUPPORT && USB_XHCI_HCD
 	help
 	  Say Y or M here if your system runs on MediaTek SoCs with
-- 
2.20.0

