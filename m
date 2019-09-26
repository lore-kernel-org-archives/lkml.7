Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8D40C432C2
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 01:16:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70D46222C0
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 01:16:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pIgSEOcv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730111AbfIZBQa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 21:16:30 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:37044 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbfIZBQa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 21:16:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Date:Message-ID:Subject:From:To:Sender:Reply-To:Cc:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=g7hM0r0bMD0BgN+JATGrsCucBwjqorf/LYLvbK/kUDw=; b=pIgSEOcvzxCabotRna08r9quI
        LzPp+RtjR+natbGl1bXi8bjHXcDHysbqHAsEOsETf9vt3fLnuV5MTiMUrEbrbEVPmGYzaJluxxgJm
        li6n8JyROVQs68dJFuem0fjmEn/LVuc1EJ3VWpMCc73emF5u8SYmqZ11Dw2mRFdTSqHptF9vugHLX
        2Ik/p8cnjkGkoyOz53ojRi2Ovr5lndrz2F6j02gPk+J6+xlr3/fTCCPWyPlnxrAttsHVsk0CVzP0o
        5XwpOzkV4Rmhc8W7nOi8Ptj6pNNOMHwLKaigUqu6Mu0Iy0ESuosbr+oGIORQuM/l8TuQrSoBGLn3T
        UMY+WJlNQ==;
Received: from [2601:1c0:6280:3f0::9a1f]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iDIOT-0006bH-B7; Thu, 26 Sep 2019 01:16:29 +0000
To:     LKML <linux-kernel@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] serial: move Non-standard serial drivers menu to the Serial
 drivers menu
Message-ID: <8e583967-4453-368b-6be5-a24df9b2b5dc@infradead.org>
Date:   Wed, 25 Sep 2019 18:16:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Since Non-standard serial port drivers are also Serial drivers,
move the "Non-standard serial port support" menu to be under/in
the "Serial drivers" menu. With this move, the "Serial drivers"
menu contains (a) 8250/16550 support, (b) non-8250 support, and
(c) non-standard serial port support.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
 drivers/tty/Kconfig        |  119 -----------------------------------
 drivers/tty/serial/Kconfig |  119 +++++++++++++++++++++++++++++++++++
 2 files changed, 119 insertions(+), 119 deletions(-)

--- lnx-53.orig/drivers/tty/Kconfig
+++ lnx-53/drivers/tty/Kconfig
@@ -151,125 +151,6 @@ config LEGACY_PTY_COUNT
 	  When not in use, each legacy PTY occupies 12 bytes on 32-bit
 	  architectures and 24 bytes on 64-bit architectures.
 
-config SERIAL_NONSTANDARD
-	bool "Non-standard serial port support"
-	depends on HAS_IOMEM
-	---help---
-	  Say Y here if you have any non-standard serial boards -- boards
-	  which aren't supported using the standard "dumb" serial driver.
-	  This includes intelligent serial boards such as Cyclades,
-	  Digiboards, etc. These are usually used for systems that need many
-	  serial ports because they serve many terminals or dial-in
-	  connections.
-
-	  Note that the answer to this question won't directly affect the
-	  kernel: saying N will just cause the configurator to skip all
-	  the questions about non-standard serial boards.
-
-	  Most people can say N here.
-
-config ROCKETPORT
-	tristate "Comtrol RocketPort support"
-	depends on SERIAL_NONSTANDARD && (ISA || EISA || PCI)
-	help
-	  This driver supports Comtrol RocketPort and RocketModem PCI boards.   
-          These boards provide 2, 4, 8, 16, or 32 high-speed serial ports or
-          modems.  For information about the RocketPort/RocketModem  boards
-          and this driver read <file:Documentation/driver-api/serial/rocket.rst>.
-
-	  To compile this driver as a module, choose M here: the
-	  module will be called rocket.
-
-	  If you want to compile this driver into the kernel, say Y here.  If
-          you don't have a Comtrol RocketPort/RocketModem card installed, say N.
-
-config CYCLADES
-	tristate "Cyclades async mux support"
-	depends on SERIAL_NONSTANDARD && (PCI || ISA)
-	select FW_LOADER
-	---help---
-	  This driver supports Cyclades Z and Y multiserial boards.
-	  You would need something like this to connect more than two modems to
-	  your Linux box, for instance in order to become a dial-in server.
-
-	  For information about the Cyclades-Z card, read
-	  <file:Documentation/driver-api/serial/cyclades_z.rst>.
-
-	  To compile this driver as a module, choose M here: the
-	  module will be called cyclades.
-
-	  If you haven't heard about it, it's safe to say N.
-
-config CYZ_INTR
-	bool "Cyclades-Z interrupt mode operation"
-	depends on CYCLADES && PCI
-	help
-	  The Cyclades-Z family of multiport cards allows 2 (two) driver op
-	  modes: polling and interrupt. In polling mode, the driver will check
-	  the status of the Cyclades-Z ports every certain amount of time
-	  (which is called polling cycle and is configurable). In interrupt
-	  mode, it will use an interrupt line (IRQ) in order to check the
-	  status of the Cyclades-Z ports. The default op mode is polling. If
-	  unsure, say N.
-
-config MOXA_INTELLIO
-	tristate "Moxa Intellio support"
-	depends on SERIAL_NONSTANDARD && (ISA || EISA || PCI)
-	select FW_LOADER
-	help
-	  Say Y here if you have a Moxa Intellio multiport serial card.
-
-	  To compile this driver as a module, choose M here: the
-	  module will be called moxa.
-
-config MOXA_SMARTIO
-	tristate "Moxa SmartIO support v. 2.0"
-	depends on SERIAL_NONSTANDARD && (PCI || EISA || ISA)
-	help
-	  Say Y here if you have a Moxa SmartIO multiport serial card and/or
-	  want to help develop a new version of this driver.
-
-	  This is upgraded (1.9.1) driver from original Moxa drivers with
-	  changes finally resulting in PCI probing.
-
-	  This driver can also be built as a module. The module will be called
-	  mxser. If you want to do that, say M here.
-
-config SYNCLINK
-	tristate "Microgate SyncLink card support"
-	depends on SERIAL_NONSTANDARD && PCI && ISA_DMA_API
-	help
-	  Provides support for the SyncLink ISA and PCI multiprotocol serial
-	  adapters. These adapters support asynchronous and HDLC bit
-	  synchronous communication up to 10Mbps (PCI adapter).
-
-	  This driver can only be built as a module ( = code which can be
-	  inserted in and removed from the running kernel whenever you want).
-	  The module will be called synclink.  If you want to do that, say M
-	  here.
-
-config SYNCLINKMP
-	tristate "SyncLink Multiport support"
-	depends on SERIAL_NONSTANDARD && PCI
-	help
-	  Enable support for the SyncLink Multiport (2 or 4 ports)
-	  serial adapter, running asynchronous and HDLC communications up
-	  to 2.048Mbps. Each ports is independently selectable for
-	  RS-232, V.35, RS-449, RS-530, and X.21
-
-	  This driver may be built as a module ( = code which can be
-	  inserted in and removed from the running kernel whenever you want).
-	  The module will be called synclinkmp.  If you want to do that, say M
-	  here.
-
-config SYNCLINK_GT
-	tristate "SyncLink GT/AC support"
-	depends on SERIAL_NONSTANDARD && PCI
-	help
-	  Support for SyncLink GT and SyncLink AC families of
-	  synchronous and asynchronous serial adapters
-	  manufactured by Microgate Systems, Ltd. (www.microgate.com)
-
 config NOZOMI
 	tristate "HSDPA Broadband Wireless Data Card - Globe Trotter"
 	depends on PCI
--- lnx-53.orig/drivers/tty/serial/Kconfig
+++ lnx-53/drivers/tty/serial/Kconfig
@@ -1598,6 +1598,125 @@ config SERIAL_MILBEAUT_USIO_CONSOLE
 	  receives all kernel messages and warnings and which allows logins in
 	  single user mode).
 
+config SERIAL_NONSTANDARD
+	bool "Non-standard serial port support"
+	depends on HAS_IOMEM
+	---help---
+	  Say Y here if you have any non-standard serial boards -- boards
+	  which aren't supported using the standard "dumb" serial driver.
+	  This includes intelligent serial boards such as Cyclades,
+	  Digiboards, etc. These are usually used for systems that need many
+	  serial ports because they serve many terminals or dial-in
+	  connections.
+
+	  Note that the answer to this question won't directly affect the
+	  kernel: saying N will just cause the configurator to skip all
+	  the questions about non-standard serial boards.
+
+	  Most people can say N here.
+
+config ROCKETPORT
+	tristate "Comtrol RocketPort support"
+	depends on SERIAL_NONSTANDARD && (ISA || EISA || PCI)
+	help
+	  This driver supports Comtrol RocketPort and RocketModem PCI boards.   
+          These boards provide 2, 4, 8, 16, or 32 high-speed serial ports or
+          modems.  For information about the RocketPort/RocketModem  boards
+          and this driver read <file:Documentation/driver-api/serial/rocket.rst>.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called rocket.
+
+	  If you want to compile this driver into the kernel, say Y here.  If
+          you don't have a Comtrol RocketPort/RocketModem card installed, say N.
+
+config CYCLADES
+	tristate "Cyclades async mux support"
+	depends on SERIAL_NONSTANDARD && (PCI || ISA)
+	select FW_LOADER
+	---help---
+	  This driver supports Cyclades Z and Y multiserial boards.
+	  You would need something like this to connect more than two modems to
+	  your Linux box, for instance in order to become a dial-in server.
+
+	  For information about the Cyclades-Z card, read
+	  <file:Documentation/driver-api/serial/cyclades_z.rst>.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called cyclades.
+
+	  If you haven't heard about it, it's safe to say N.
+
+config CYZ_INTR
+	bool "Cyclades-Z interrupt mode operation"
+	depends on CYCLADES && PCI
+	help
+	  The Cyclades-Z family of multiport cards allows 2 (two) driver op
+	  modes: polling and interrupt. In polling mode, the driver will check
+	  the status of the Cyclades-Z ports every certain amount of time
+	  (which is called polling cycle and is configurable). In interrupt
+	  mode, it will use an interrupt line (IRQ) in order to check the
+	  status of the Cyclades-Z ports. The default op mode is polling. If
+	  unsure, say N.
+
+config MOXA_INTELLIO
+	tristate "Moxa Intellio support"
+	depends on SERIAL_NONSTANDARD && (ISA || EISA || PCI)
+	select FW_LOADER
+	help
+	  Say Y here if you have a Moxa Intellio multiport serial card.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called moxa.
+
+config MOXA_SMARTIO
+	tristate "Moxa SmartIO support v. 2.0"
+	depends on SERIAL_NONSTANDARD && (PCI || EISA || ISA)
+	help
+	  Say Y here if you have a Moxa SmartIO multiport serial card and/or
+	  want to help develop a new version of this driver.
+
+	  This is upgraded (1.9.1) driver from original Moxa drivers with
+	  changes finally resulting in PCI probing.
+
+	  This driver can also be built as a module. The module will be called
+	  mxser. If you want to do that, say M here.
+
+config SYNCLINK
+	tristate "Microgate SyncLink card support"
+	depends on SERIAL_NONSTANDARD && PCI && ISA_DMA_API
+	help
+	  Provides support for the SyncLink ISA and PCI multiprotocol serial
+	  adapters. These adapters support asynchronous and HDLC bit
+	  synchronous communication up to 10Mbps (PCI adapter).
+
+	  This driver can only be built as a module ( = code which can be
+	  inserted in and removed from the running kernel whenever you want).
+	  The module will be called synclink.  If you want to do that, say M
+	  here.
+
+config SYNCLINKMP
+	tristate "SyncLink Multiport support"
+	depends on SERIAL_NONSTANDARD && PCI
+	help
+	  Enable support for the SyncLink Multiport (2 or 4 ports)
+	  serial adapter, running asynchronous and HDLC communications up
+	  to 2.048Mbps. Each ports is independently selectable for
+	  RS-232, V.35, RS-449, RS-530, and X.21
+
+	  This driver may be built as a module ( = code which can be
+	  inserted in and removed from the running kernel whenever you want).
+	  The module will be called synclinkmp.  If you want to do that, say M
+	  here.
+
+config SYNCLINK_GT
+	tristate "SyncLink GT/AC support"
+	depends on SERIAL_NONSTANDARD && PCI
+	help
+	  Support for SyncLink GT and SyncLink AC families of
+	  synchronous and asynchronous serial adapters
+	  manufactured by Microgate Systems, Ltd. (www.microgate.com)
+
 endmenu
 
 config SERIAL_MCTRL_GPIO

