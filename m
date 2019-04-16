Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00F65C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 17:09:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83FFC2087C
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 17:09:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uTtJRSJv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730101AbfDPRJx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 13:09:53 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:33662 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727180AbfDPRJx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 13:09:53 -0400
Received: by mail-pl1-f195.google.com with SMTP id t16so10653480plo.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 10:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=wWHrbBhVey+0zvWIEWk02uJQJpFE1yPT12EuKeF13Co=;
        b=uTtJRSJvW9y2F4+ZjkEq83SQjPbglR8hNwGEJtTgPKJI2A5dT+Vpzbo+p43Tem8Fmt
         /MoGtgi4r55Mw/dZ9OQo/GhQ+hRsAWTS712xVMk3Wi7g0pYIdKw0WuJ+CVwpsXxholLu
         GKfv7nLoKwVFCZWn/rQEpwM+neOr0O2DFjR2wqgQWy5NBhQJx0HjOrZZF948fpGWcmaw
         /EiRvKWQVJs2RaWcZVVqtEUHCD5hlUxWOIOj7uR6QZlUHeHheVMJTqBo3BSGebo8rz1y
         djiJn/bmAdgfvAbsX3lzLDjbH2sIttz3sNkGW1pWw1tpCOSFKi7btJC2pPq5kWvnyPNF
         7bIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=wWHrbBhVey+0zvWIEWk02uJQJpFE1yPT12EuKeF13Co=;
        b=ot4JOFDyQIowNuS+UvLJzWatAhrV7S8qk+jhzOZalAKtRr6WX8xC+feZ5MhHur0QFy
         p+XEk+lbx9YNhxOk/jmYvKZY+KyxBoI4Xz9URWALbyKHUMjVGfu2rVgNw0Hj0D4N5m55
         MZ4lluOS300SstrFWFr+j9Sp4uosOekRX4rdo5YZ0QCoHQ2LMCN94WpKU9j/wSSt6tyx
         GNxuu8tZ+U3rfYXdzp0xUXJc7Cvu058rwgTMHb5FvlithMuYTo2eHo7EVLHZEzx/v1U6
         3gsqQOJqvcFkp4qxTRBVN3p21x8l1H3z/DUSNy0Hc2LKGOveirRNCrIzQvGsQZHCIboh
         /bCQ==
X-Gm-Message-State: APjAAAVLmbMXa54evBBD5jF+jCqZvMRh2s5kl6qO+dWqek18MjPDnbUs
        vJHl1frNzEiITbAehUkLnSQ=
X-Google-Smtp-Source: APXvYqy7M4ufuFr+vZAAzyycutFVQu1lOr9HFRvydU6pGXRa6exRPtixcnezpRkjpBIVCvKN4DEYsg==
X-Received: by 2002:a17:902:2dc3:: with SMTP id p61mr46417018plb.308.1555434591647;
        Tue, 16 Apr 2019 10:09:51 -0700 (PDT)
Received: from localhost.localdomain ([103.227.96.90])
        by smtp.googlemail.com with ESMTPSA id b15sm72236926pgg.90.2019.04.16.10.09.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2019 10:09:50 -0700 (PDT)
From:   Moses Christopher <moseschristopherb@gmail.com>
Cc:     moseschristopherb@gmail.com, Ian Abbott <abbotti@mev.co.uk>,
        H Hartley Sweeten <hsweeten@visionengravers.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Spencer E. Olson" <olsonse@umich.edu>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] staging: comedi: use help instead of ---help--- in Kconfig
Date:   Tue, 16 Apr 2019 22:38:58 +0530
Message-Id: <20190416170900.6613-1-moseschristopherb@gmail.com>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  - Resolve the following warning from the Kconfig,
    "WARNING: prefer 'help' over '---help---' for new help texts"

Signed-off-by: Moses Christopher <moseschristopherb@gmail.com>
---
 drivers/staging/comedi/Kconfig | 254 ++++++++++++++++-----------------
 1 file changed, 127 insertions(+), 127 deletions(-)

diff --git a/drivers/staging/comedi/Kconfig b/drivers/staging/comedi/Kconfig
index 9ab1ee7d36bf..0f63870adc04 100644
--- a/drivers/staging/comedi/Kconfig
+++ b/drivers/staging/comedi/Kconfig
@@ -1,6 +1,6 @@
 config COMEDI
 	tristate "Data acquisition support (comedi)"
-	---help---
+	help
 	  Enable support for a wide range of data acquisition devices
 	  for Linux.
 
@@ -8,14 +8,14 @@ if COMEDI
 
 config COMEDI_DEBUG
 	bool "Comedi debugging"
-	---help---
+	help
 	  This is an option for use by developers; most people should
 	  say N here. This enables comedi core and driver debugging.
 
 config COMEDI_DEFAULT_BUF_SIZE_KB
 	int "Comedi default initial asynchronous buffer size in KiB"
 	default "2048"
-	---help---
+	help
 	  This is the default asynchronous buffer size which is used for
 	  commands running in the background in kernel space.  This
 	  defaults to 2048 KiB of memory so that a 16 channel card
@@ -24,7 +24,7 @@ config COMEDI_DEFAULT_BUF_SIZE_KB
 config COMEDI_DEFAULT_BUF_MAXSIZE_KB
 	int "Comedi default maximum asynchronous buffer size in KiB"
 	default "20480"
-	---help---
+	help
 	  This is the default maximum asynchronous buffer size which can
 	  be requested by a userspace program without root privileges.
 	  This is set to 20480 KiB so that a fast I/O card with 16
@@ -32,7 +32,7 @@ config COMEDI_DEFAULT_BUF_MAXSIZE_KB
 
 menuconfig COMEDI_MISC_DRIVERS
 	bool "Comedi misc drivers"
-	---help---
+	help
 	  Enable comedi misc drivers to be built
 
 	  Note that the answer to this question won't directly affect the
@@ -44,7 +44,7 @@ if COMEDI_MISC_DRIVERS
 config COMEDI_BOND
 	tristate "Comedi device bonding support"
 	select COMEDI_KCOMEDILIB
-	---help---
+	help
 	  Enable support for a driver to 'bond' (merge) multiple subdevices
 	  from multiple devices together as one.
 
@@ -55,7 +55,7 @@ config COMEDI_BOND
 
 config COMEDI_TEST
 	tristate "Fake waveform generator support"
-	---help---
+	help
 	  Enable support for the fake waveform generator.
 	  This driver is mainly for testing purposes, but can also be used to
 	  generate sample waveforms on systems that don't have data acquisition
@@ -66,7 +66,7 @@ config COMEDI_TEST
 
 config COMEDI_PARPORT
 	tristate "Parallel port support"
-	---help---
+	help
 	  Enable support for the standard parallel port.
 	  A cheap and easy way to get a few more digital I/O lines. Steal
 	  additional parallel ports from old computers or your neighbors'
@@ -78,7 +78,7 @@ config COMEDI_PARPORT
 config COMEDI_SSV_DNP
 	tristate "SSV Embedded Systems DIL/Net-PC support"
 	depends on X86_32 || COMPILE_TEST
-	---help---
+	help
 	  Enable support for SSV Embedded Systems DIL/Net-PC
 
 	  To compile this driver as a module, choose M here: the module will be
@@ -88,7 +88,7 @@ endif # COMEDI_MISC_DRIVERS
 
 menuconfig COMEDI_ISA_DRIVERS
 	bool "Comedi ISA and PC/104 drivers"
-	---help---
+	help
 	  Enable comedi ISA and PC/104 drivers to be built
 
 	  Note that the answer to this question won't directly affect the
@@ -100,7 +100,7 @@ if COMEDI_ISA_DRIVERS
 config COMEDI_PCL711
 	tristate "Advantech PCL-711/711b and ADlink ACL-8112 ISA card support"
 	select COMEDI_8254
-	---help---
+	help
 	  Enable support for Advantech PCL-711 and 711b, ADlink ACL-8112
 
 	  To compile this driver as a module, choose M here: the module will be
@@ -109,7 +109,7 @@ config COMEDI_PCL711
 config COMEDI_PCL724
 	tristate "Advantech PCL-722/724/731 and ADlink ACL-7122/7124/PET-48DIO"
 	select COMEDI_8255
-	---help---
+	help
 	  Enable support for ISA and PC/104 based 8255 digital i/o boards. This
 	  driver provides a legacy comedi driver wrapper for the generic 8255
 	  support driver.
@@ -129,7 +129,7 @@ config COMEDI_PCL724
 
 config COMEDI_PCL726
 	tristate "Advantech PCL-726 and compatible ISA card support"
-	---help---
+	help
 	  Enable support for Advantech PCL-726 and compatible ISA cards.
 
 	  To compile this driver as a module, choose M here: the module will be
@@ -137,7 +137,7 @@ config COMEDI_PCL726
 
 config COMEDI_PCL730
 	tristate "Simple Digital I/O board support (8-bit ports)"
-	---help---
+	help
 	  Enable support for various simple ISA or PC/104 Digital I/O boards.
 	  These boards all use 8-bit I/O ports.
 
@@ -162,7 +162,7 @@ config COMEDI_PCL812
 	tristate "Advantech PCL-812/813 and ADlink ACL-8112/8113/8113/8216"
 	select COMEDI_ISADMA if ISA_DMA_API
 	select COMEDI_8254
-	---help---
+	help
 	  Enable support for Advantech PCL-812/PG, PCL-813/B, ADLink
 	  ACL-8112DG/HG/PG, ACL-8113, ACL-8216, ICP DAS A-821PGH/PGL/PGL-NDA,
 	  A-822PGH/PGL, A-823PGH/PGL, A-826PG and ICP DAS ISO-813 ISA cards
@@ -174,7 +174,7 @@ config COMEDI_PCL816
 	tristate "Advantech PCL-814 and PCL-816 ISA card support"
 	select COMEDI_ISADMA if ISA_DMA_API
 	select COMEDI_8254
-	---help---
+	help
 	  Enable support for Advantech PCL-814 and PCL-816 ISA cards
 
 	  To compile this driver as a module, choose M here: the module will be
@@ -184,7 +184,7 @@ config COMEDI_PCL818
 	tristate "Advantech PCL-718 and PCL-818 ISA card support"
 	select COMEDI_ISADMA if ISA_DMA_API
 	select COMEDI_8254
-	---help---
+	help
 	  Enable support for Advantech PCL-818 ISA cards
 	  PCL-818L, PCL-818H, PCL-818HD, PCL-818HG, PCL-818 and PCL-718
 
@@ -194,7 +194,7 @@ config COMEDI_PCL818
 config COMEDI_PCM3724
 	tristate "Advantech PCM-3724 PC/104 card support"
 	select COMEDI_8255
-	---help---
+	help
 	  Enable support for Advantech PCM-3724 PC/104 cards.
 
 	  To compile this driver as a module, choose M here: the module will be
@@ -203,7 +203,7 @@ config COMEDI_PCM3724
 config COMEDI_AMPLC_DIO200_ISA
 	tristate "Amplicon PC212E/PC214E/PC215E/PC218E/PC272E"
 	select COMEDI_AMPLC_DIO200
-	---help---
+	help
 	  Enable support for Amplicon PC212E, PC214E, PC215E, PC218E and
 	  PC272E ISA DIO boards
 
@@ -213,7 +213,7 @@ config COMEDI_AMPLC_DIO200_ISA
 config COMEDI_AMPLC_PC236_ISA
 	tristate "Amplicon PC36AT DIO board support"
 	select COMEDI_AMPLC_PC236
-	---help---
+	help
 	  Enable support for Amplicon PC36AT ISA DIO board.
 
 	  To compile this driver as a module, choose M here: the module will be
@@ -221,7 +221,7 @@ config COMEDI_AMPLC_PC236_ISA
 
 config COMEDI_AMPLC_PC263_ISA
 	tristate "Amplicon PC263 relay board support"
-	---help---
+	help
 	  Enable support for Amplicon PC263 ISA relay board.  This board has
 	  16 reed relay output channels.
 
@@ -230,7 +230,7 @@ config COMEDI_AMPLC_PC263_ISA
 
 config COMEDI_RTI800
 	tristate "Analog Devices RTI-800/815 ISA card support"
-	---help---
+	help
 	  Enable support for Analog Devices RTI-800/815 ISA cards
 
 	  To compile this driver as a module, choose M here: the module will be
@@ -238,7 +238,7 @@ config COMEDI_RTI800
 
 config COMEDI_RTI802
 	tristate "Analog Devices RTI-802 ISA card support"
-	---help---
+	help
 	  Enable support for Analog Devices RTI-802 ISA cards
 
 	  To compile this driver as a module, choose M here: the module will be
@@ -246,7 +246,7 @@ config COMEDI_RTI802
 
 config COMEDI_DAC02
 	tristate "Keithley Metrabyte DAC02 compatible ISA card support"
-	---help---
+	help
 	  Enable support for Keithley Metrabyte DAC02 compatible ISA cards.
 
 	  To compile this driver as a module, choose M here: the module will be
@@ -256,7 +256,7 @@ config COMEDI_DAS16M1
 	tristate "MeasurementComputing CIO-DAS16/M1DAS-16 ISA card support"
 	select COMEDI_8254
 	select COMEDI_8255
-	---help---
+	help
 	  Enable support for Measurement Computing CIO-DAS16/M1 ISA cards.
 
 	  To compile this driver as a module, choose M here: the module will be
@@ -265,7 +265,7 @@ config COMEDI_DAS16M1
 config COMEDI_DAS08_ISA
 	tristate "DAS-08 compatible ISA and PC/104 card support"
 	select COMEDI_DAS08
-	---help---
+	help
 	  Enable support for Keithley Metrabyte/ComputerBoards DAS08
 	  and compatible ISA and PC/104 cards:
 	  Keithley Metrabyte/ComputerBoards DAS08, DAS08-PGM, DAS08-PGH,
@@ -280,7 +280,7 @@ config COMEDI_DAS16
 	select COMEDI_ISADMA if ISA_DMA_API
 	select COMEDI_8254
 	select COMEDI_8255
-	---help---
+	help
 	  Enable support for Keithley Metrabyte/ComputerBoards DAS16
 	  and compatible ISA and PC/104 cards:
 	  Keithley Metrabyte DAS-16, DAS-16G, DAS-16F, DAS-1201, DAS-1202,
@@ -296,7 +296,7 @@ config COMEDI_DAS16
 config COMEDI_DAS800
 	tristate "DAS800 and compatible ISA card support"
 	select COMEDI_8254
-	---help---
+	help
 	  Enable support for Keithley Metrabyte DAS800 and compatible ISA cards
 	  Keithley Metrabyte DAS-800, DAS-801, DAS-802
 	  Measurement Computing CIO-DAS800, CIO-DAS801, CIO-DAS802 and
@@ -309,7 +309,7 @@ config COMEDI_DAS1800
 	tristate "DAS1800 and compatible ISA card support"
 	select COMEDI_ISADMA if ISA_DMA_API
 	select COMEDI_8254
-	---help---
+	help
 	  Enable support for DAS1800 and compatible ISA cards
 	  Keithley Metrabyte DAS-1701ST, DAS-1701ST-DA, DAS-1701/AO,
 	  DAS-1702ST, DAS-1702ST-DA, DAS-1702HR, DAS-1702HR-DA, DAS-1702/AO,
@@ -323,7 +323,7 @@ config COMEDI_DAS1800
 config COMEDI_DAS6402
 	tristate "DAS6402 and compatible ISA card support"
 	select COMEDI_8254
-	---help---
+	help
 	  Enable support for DAS6402 and compatible ISA cards
 	  Computerboards, Keithley Metrabyte DAS6402 and compatibles
 
@@ -332,7 +332,7 @@ config COMEDI_DAS6402
 
 config COMEDI_DT2801
 	tristate "Data Translation DT2801 ISA card support"
-	---help---
+	help
 	  Enable support for Data Translation DT2801 ISA cards
 
 	  To compile this driver as a module, choose M here: the module will be
@@ -340,7 +340,7 @@ config COMEDI_DT2801
 
 config COMEDI_DT2811
 	tristate "Data Translation DT2811 ISA card support"
-	---help---
+	help
 	  Enable support for Data Translation DT2811 ISA cards
 
 	  To compile this driver as a module, choose M here: the module will be
@@ -348,7 +348,7 @@ config COMEDI_DT2811
 
 config COMEDI_DT2814
 	tristate "Data Translation DT2814 ISA card support"
-	---help---
+	help
 	  Enable support for Data Translation DT2814 ISA cards
 
 	  To compile this driver as a module, choose M here: the module will be
@@ -356,7 +356,7 @@ config COMEDI_DT2814
 
 config COMEDI_DT2815
 	tristate "Data Translation DT2815 ISA card support"
-	---help---
+	help
 	  Enable support for Data Translation DT2815 ISA cards
 
 	  To compile this driver as a module, choose M here: the module will be
@@ -364,7 +364,7 @@ config COMEDI_DT2815
 
 config COMEDI_DT2817
 	tristate "Data Translation DT2817 ISA card support"
-	---help---
+	help
 	  Enable support for Data Translation DT2817 ISA cards
 
 	  To compile this driver as a module, choose M here: the module will be
@@ -373,7 +373,7 @@ config COMEDI_DT2817
 config COMEDI_DT282X
 	tristate "Data Translation DT2821 series and DT-EZ ISA card support"
 	select COMEDI_ISADMA if ISA_DMA_API
-	---help---
+	help
 	  Enable support for Data Translation DT2821 series including DT-EZ
 	  DT2821, DT2821-F-16SE, DT2821-F-8DI, DT2821-G-16SE, DT2821-G-8DI,
 	  DT2823 (dt2823), DT2824-PGH, DT2824-PGL, DT2825, DT2827, DT2828,
@@ -385,7 +385,7 @@ config COMEDI_DT282X
 config COMEDI_DMM32AT
 	tristate "Diamond Systems MM-32-AT PC/104 board support"
 	select COMEDI_8255
-	---help---
+	help
 	  Enable support for Diamond Systems MM-32-AT PC/104 boards
 
 	  To compile this driver as a module, choose M here: the module will be
@@ -393,7 +393,7 @@ config COMEDI_DMM32AT
 
 config COMEDI_FL512
 	tristate "FL512 ISA card support"
-	---help---
+	help
 	  Enable support for FL512 ISA card
 
 	  To compile this driver as a module, choose M here: the module will be
@@ -403,7 +403,7 @@ config COMEDI_AIO_AIO12_8
 	tristate "I/O Products PC/104 AIO12-8 Analog I/O Board support"
 	select COMEDI_8254
 	select COMEDI_8255
-	---help---
+	help
 	  Enable support for I/O Products PC/104 AIO12-8 Analog I/O Board
 
 	  To compile this driver as a module, choose M here: the module will be
@@ -411,7 +411,7 @@ config COMEDI_AIO_AIO12_8
 
 config COMEDI_AIO_IIRO_16
 	tristate "I/O Products PC/104 IIRO16 Board support"
-	---help---
+	help
 	  Enable support for I/O Products PC/104 IIRO16 Relay And Isolated
 	  Input Board
 
@@ -421,7 +421,7 @@ config COMEDI_AIO_IIRO_16
 config COMEDI_II_PCI20KC
 	tristate "Intelligent Instruments PCI-20001C carrier support"
 	depends on HAS_IOMEM
-	---help---
+	help
 	  Enable support for Intelligent Instruments PCI-20001C carrier
 	  PCI-20001, PCI-20006 and PCI-20341
 
@@ -430,7 +430,7 @@ config COMEDI_II_PCI20KC
 
 config COMEDI_C6XDIGIO
 	tristate "Mechatronic Systems Inc. C6x_DIGIO DSP daughter card support"
-	---help---
+	help
 	  Enable support for Mechatronic Systems Inc. C6x_DIGIO DSP daughter
 	  card
 
@@ -439,7 +439,7 @@ config COMEDI_C6XDIGIO
 
 config COMEDI_MPC624
 	tristate "Micro/sys MPC-624 PC/104 board support"
-	---help---
+	help
 	  Enable support for Micro/sys MPC-624 PC/104 board
 
 	  To compile this driver as a module, choose M here: the module will be
@@ -447,7 +447,7 @@ config COMEDI_MPC624
 
 config COMEDI_ADQ12B
 	tristate "MicroAxial ADQ12-B data acquisition and control card support"
-	---help---
+	help
 	  Enable MicroAxial ADQ12-B daq and control card support.
 
 	  To compile this driver as a module, choose M here: the module will be
@@ -457,7 +457,7 @@ config COMEDI_NI_AT_A2150
 	tristate "NI AT-A2150 ISA card support"
 	select COMEDI_ISADMA if ISA_DMA_API
 	select COMEDI_8254
-	---help---
+	help
 	  Enable support for National Instruments AT-A2150 cards
 
 	  To compile this driver as a module, choose M here: the module will be
@@ -466,7 +466,7 @@ config COMEDI_NI_AT_A2150
 config COMEDI_NI_AT_AO
 	tristate "NI AT-AO-6/10 EISA card support"
 	select COMEDI_8254
-	---help---
+	help
 	  Enable support for National Instruments AT-AO-6/10 cards
 
 	  To compile this driver as a module, choose M here: the module will be
@@ -476,7 +476,7 @@ config COMEDI_NI_ATMIO
 	tristate "NI AT-MIO E series ISA-PNP card support"
 	select COMEDI_8255
 	select COMEDI_NI_TIO
-	---help---
+	help
 	  Enable support for National Instruments AT-MIO E series cards
 	  National Instruments AT-MIO-16E-1 (ni_atmio),
 	  AT-MIO-16E-2, AT-MIO-16E-10, AT-MIO-16DE-10, AT-MIO-64E-3,
@@ -488,7 +488,7 @@ config COMEDI_NI_ATMIO
 config COMEDI_NI_ATMIO16D
 	tristate "NI AT-MIO-16/AT-MIO-16D series ISA card support"
 	select COMEDI_8255
-	---help---
+	help
 	  Enable support for National Instruments AT-MIO-16/AT-MIO-16D cards.
 
 	  To compile this driver as a module, choose M here: the module will be
@@ -497,7 +497,7 @@ config COMEDI_NI_ATMIO16D
 config COMEDI_NI_LABPC_ISA
 	tristate "NI Lab-PC and compatibles ISA support"
 	select COMEDI_NI_LABPC
-	---help---
+	help
 	  Enable support for National Instruments Lab-PC and compatibles
 	  Lab-PC-1200, Lab-PC-1200AI, Lab-PC+.
 	  Kernel-level ISA plug-and-play support for the lab-pc-1200 boards has
@@ -508,7 +508,7 @@ config COMEDI_NI_LABPC_ISA
 
 config COMEDI_PCMAD
 	tristate "Winsystems PCM-A/D12 and PCM-A/D16 PC/104 board support"
-	---help---
+	help
 	  Enable support for Winsystems PCM-A/D12 and PCM-A/D16 PC/104 boards.
 
 	  To compile this driver as a module, choose M here: the module will be
@@ -516,7 +516,7 @@ config COMEDI_PCMAD
 
 config COMEDI_PCMDA12
 	tristate "Winsystems PCM-D/A-12 8-channel AO PC/104 board support"
-	---help---
+	help
 	  Enable support for Winsystems PCM-D/A-12 8-channel AO PC/104 boards.
 	  Note that the board is not ISA-PNP capable and thus needs the I/O
 	  port comedi_config parameter.
@@ -526,7 +526,7 @@ config COMEDI_PCMDA12
 
 config COMEDI_PCMMIO
 	tristate "Winsystems PCM-MIO PC/104 board support"
-	---help---
+	help
 	  Enable support for Winsystems PCM-MIO multifunction PC/104 boards.
 
 	  To compile this driver as a module, choose M here: the module will be
@@ -534,7 +534,7 @@ config COMEDI_PCMMIO
 
 config COMEDI_PCMUIO
 	tristate "Winsystems PCM-UIO48A and PCM-UIO96A PC/104 board support"
-	---help---
+	help
 	  Enable support for PCM-UIO48A and PCM-UIO96A PC/104 boards.
 
 	  To compile this driver as a module, choose M here: the module will be
@@ -542,7 +542,7 @@ config COMEDI_PCMUIO
 
 config COMEDI_MULTIQ3
 	tristate "Quanser Consulting MultiQ-3 ISA card support"
-	---help---
+	help
 	  Enable support for Quanser Consulting MultiQ-3 ISA cards
 
 	  To compile this driver as a module, choose M here: the module will be
@@ -550,7 +550,7 @@ config COMEDI_MULTIQ3
 
 config COMEDI_S526
 	tristate "Sensoray s526 support"
-	---help---
+	help
 	  Enable support for Sensoray s526
 
 	  To compile this driver as a module, choose M here: the module will be
@@ -561,7 +561,7 @@ endif # COMEDI_ISA_DRIVERS
 menuconfig COMEDI_PCI_DRIVERS
 	tristate "Comedi PCI drivers"
 	depends on PCI
-	---help---
+	help
 	  Enable support for comedi PCI drivers.
 
 	  To compile this support as a module, choose M here: the module will
@@ -572,7 +572,7 @@ if COMEDI_PCI_DRIVERS
 config COMEDI_8255_PCI
 	tristate "Generic PCI based 8255 digital i/o board support"
 	select COMEDI_8255
-	---help---
+	help
 	  Enable support for PCI based 8255 digital i/o boards. This driver
 	  provides a PCI wrapper around the generic 8255 driver.
 
@@ -588,14 +588,14 @@ config COMEDI_8255_PCI
 
 config COMEDI_ADDI_WATCHDOG
 	tristate
-	---help---
+	help
 	  Provides support for the watchdog subdevice found on many ADDI-DATA
 	  boards. This module will be automatically selected when needed. The
 	  module will be called addi_watchdog.
 
 config COMEDI_ADDI_APCI_1032
 	tristate "ADDI-DATA APCI_1032 support"
-	---help---
+	help
 	  Enable support for ADDI-DATA APCI_1032 cards
 
 	  To compile this driver as a module, choose M here: the module will be
@@ -603,7 +603,7 @@ config COMEDI_ADDI_APCI_1032
 
 config COMEDI_ADDI_APCI_1500
 	tristate "ADDI-DATA APCI_1500 support"
-	---help---
+	help
 	  Enable support for ADDI-DATA APCI_1500 cards
 
 	  To compile this driver as a module, choose M here: the module will be
@@ -612,7 +612,7 @@ config COMEDI_ADDI_APCI_1500
 config COMEDI_ADDI_APCI_1516
 	tristate "ADDI-DATA APCI-1016/1516/2016 support"
 	select COMEDI_ADDI_WATCHDOG
-	---help---
+	help
 	  Enable support for ADDI-DATA APCI-1016, APCI-1516 and APCI-2016 boards.
 	  These are 16 channel, optically isolated, digital I/O boards. The 1516
 	  and 2016 boards also have a watchdog for resetting the outputs to "0".
@@ -623,7 +623,7 @@ config COMEDI_ADDI_APCI_1516
 config COMEDI_ADDI_APCI_1564
 	tristate "ADDI-DATA APCI_1564 support"
 	select COMEDI_ADDI_WATCHDOG
-	---help---
+	help
 	  Enable support for ADDI-DATA APCI_1564 cards
 
 	  To compile this driver as a module, choose M here: the module will be
@@ -631,7 +631,7 @@ config COMEDI_ADDI_APCI_1564
 
 config COMEDI_ADDI_APCI_16XX
 	tristate "ADDI-DATA APCI_16xx support"
-	---help---
+	help
 	  Enable support for ADDI-DATA APCI_16xx cards
 
 	  To compile this driver as a module, choose M here: the module will be
@@ -640,7 +640,7 @@ config COMEDI_ADDI_APCI_16XX
 config COMEDI_ADDI_APCI_2032
 	tristate "ADDI-DATA APCI_2032 support"
 	select COMEDI_ADDI_WATCHDOG
-	---help---
+	help
 	  Enable support for ADDI-DATA APCI_2032 cards
 
 	  To compile this driver as a module, choose M here: the module will be
@@ -649,7 +649,7 @@ config COMEDI_ADDI_APCI_2032
 config COMEDI_ADDI_APCI_2200
 	tristate "ADDI-DATA APCI_2200 support"
 	select COMEDI_ADDI_WATCHDOG
-	---help---
+	help
 	  Enable support for ADDI-DATA APCI_2200 cards
 
 	  To compile this driver as a module, choose M here: the module will be
@@ -658,7 +658,7 @@ config COMEDI_ADDI_APCI_2200
 config COMEDI_ADDI_APCI_3120
 	tristate "ADDI-DATA APCI_3120/3001 support"
 	depends on HAS_DMA
-	---help---
+	help
 	  Enable support for ADDI-DATA APCI_3120/3001 cards
 
 	  To compile this driver as a module, choose M here: the module will be
@@ -666,7 +666,7 @@ config COMEDI_ADDI_APCI_3120
 
 config COMEDI_ADDI_APCI_3501
 	tristate "ADDI-DATA APCI_3501 support"
-	---help---
+	help
 	  Enable support for ADDI-DATA APCI_3501 cards
 
 	  To compile this driver as a module, choose M here: the module will be
@@ -674,7 +674,7 @@ config COMEDI_ADDI_APCI_3501
 
 config COMEDI_ADDI_APCI_3XXX
 	tristate "ADDI-DATA APCI_3xxx support"
-	---help---
+	help
 	  Enable support for ADDI-DATA APCI_3xxx cards
 
 	  To compile this driver as a module, choose M here: the module will be
@@ -682,7 +682,7 @@ config COMEDI_ADDI_APCI_3XXX
 
 config COMEDI_ADL_PCI6208
 	tristate "ADLink PCI-6208A support"
-	---help---
+	help
 	  Enable support for ADLink PCI-6208A cards
 
 	  To compile this driver as a module, choose M here: the module will be
@@ -690,7 +690,7 @@ config COMEDI_ADL_PCI6208
 
 config COMEDI_ADL_PCI7X3X
 	tristate "ADLink PCI-723X/743X isolated digital i/o board support"
-	---help---
+	help
 	  Enable support for ADlink PCI-723X/743X isolated digital i/o boards.
 	  Supported boards include the 32-channel PCI-7230 (16 in/16 out),
 	  PCI-7233 (32 in), and PCI-7234 (32 out) as well as the 64-channel
@@ -701,7 +701,7 @@ config COMEDI_ADL_PCI7X3X
 
 config COMEDI_ADL_PCI8164
 	tristate "ADLink PCI-8164 4 Axes Motion Control board support"
-	---help---
+	help
 	  Enable support for ADlink PCI-8164 4 Axes Motion Control board
 
 	  To compile this driver as a module, choose M here: the module will be
@@ -710,7 +710,7 @@ config COMEDI_ADL_PCI8164
 config COMEDI_ADL_PCI9111
 	tristate "ADLink PCI-9111HR support"
 	select COMEDI_8254
-	---help---
+	help
 	  Enable support for ADlink PCI9111 cards
 
 	  To compile this driver as a module, choose M here: the module will be
@@ -720,7 +720,7 @@ config COMEDI_ADL_PCI9118
 	tristate "ADLink PCI-9118DG, PCI-9118HG, PCI-9118HR support"
 	depends on HAS_DMA
 	select COMEDI_8254
-	---help---
+	help
 	  Enable support for ADlink PCI-9118DG, PCI-9118HG, PCI-9118HR cards
 
 	  To compile this driver as a module, choose M here: the module will be
@@ -729,7 +729,7 @@ config COMEDI_ADL_PCI9118
 config COMEDI_ADV_PCI1710
 	tristate "Advantech PCI-171x and PCI-1731 support"
 	select COMEDI_8254
-	---help---
+	help
 	  Enable support for Advantech PCI-1710, PCI-1710HG, PCI-1711,
 	  PCI-1713 and PCI-1731
 
@@ -738,7 +738,7 @@ config COMEDI_ADV_PCI1710
 
 config COMEDI_ADV_PCI1720
 	tristate "Advantech PCI-1720 support"
-	---help---
+	help
 	  Enable support for Advantech PCI-1720 Analog Output board.
 
 	  To compile this driver as a module, choose M here: the module will be
@@ -746,7 +746,7 @@ config COMEDI_ADV_PCI1720
 
 config COMEDI_ADV_PCI1723
 	tristate "Advantech PCI-1723 support"
-	---help---
+	help
 	  Enable support for Advantech PCI-1723 cards
 
 	  To compile this driver as a module, choose M here: the module will be
@@ -754,7 +754,7 @@ config COMEDI_ADV_PCI1723
 
 config COMEDI_ADV_PCI1724
 	tristate "Advantech PCI-1724U support"
-	---help---
+	help
 	  Enable support for Advantech PCI-1724U cards.  These are 32-channel
 	  analog output cards with voltage and current loop output ranges and
 	  14-bit resolution.
@@ -764,7 +764,7 @@ config COMEDI_ADV_PCI1724
 
 config COMEDI_ADV_PCI1760
 	tristate "Advantech PCI-1760 support"
-	---help---
+	help
 	  Enable support for Advantech PCI-1760 board.
 
 	  To compile this driver as a module, choose M here: the module will be
@@ -774,7 +774,7 @@ config COMEDI_ADV_PCI_DIO
 	tristate "Advantech PCI DIO card support"
 	select COMEDI_8254
 	select COMEDI_8255
-	---help---
+	help
 	  Enable support for Advantech PCI DIO cards
 	  PCI-1730, PCI-1733, PCI-1734, PCI-1735U, PCI-1736UP, PCI-1739U,
 	  PCI-1750, PCI-1751, PCI-1752, PCI-1753/E, PCI-1754, PCI-1756,
@@ -786,7 +786,7 @@ config COMEDI_ADV_PCI_DIO
 config COMEDI_AMPLC_DIO200_PCI
 	tristate "Amplicon PCI215/PCI272/PCIe215/PCIe236/PCIe296 DIO support"
 	select COMEDI_AMPLC_DIO200
-	---help---
+	help
 	  Enable support for Amplicon PCI215, PCI272, PCIe215, PCIe236
 	  and PCIe296 DIO boards.
 
@@ -796,7 +796,7 @@ config COMEDI_AMPLC_DIO200_PCI
 config COMEDI_AMPLC_PC236_PCI
 	tristate "Amplicon PCI236 DIO board support"
 	select COMEDI_AMPLC_PC236
-	---help---
+	help
 	  Enable support for Amplicon PCI236 DIO board.
 
 	  To compile this driver as a module, choose M here: the module will be
@@ -804,7 +804,7 @@ config COMEDI_AMPLC_PC236_PCI
 
 config COMEDI_AMPLC_PC263_PCI
 	tristate "Amplicon PCI263 relay board support"
-	---help---
+	help
 	  Enable support for Amplicon PCI263 relay board.  This is a PCI board
 	  with 16 reed relay output channels.
 
@@ -814,7 +814,7 @@ config COMEDI_AMPLC_PC263_PCI
 config COMEDI_AMPLC_PCI224
 	tristate "Amplicon PCI224 and PCI234 support"
 	select COMEDI_8254
-	---help---
+	help
 	  Enable support for Amplicon PCI224 and PCI234 AO boards
 
 	  To compile this driver as a module, choose M here: the module will be
@@ -824,7 +824,7 @@ config COMEDI_AMPLC_PCI230
 	tristate "Amplicon PCI230 and PCI260 support"
 	select COMEDI_8254
 	select COMEDI_8255
-	---help---
+	help
 	  Enable support for Amplicon PCI230 and PCI260 Multifunction I/O
 	  boards
 
@@ -833,7 +833,7 @@ config COMEDI_AMPLC_PCI230
 
 config COMEDI_CONTEC_PCI_DIO
 	tristate "Contec PIO1616L digital I/O board support"
-	---help---
+	help
 	  Enable support for the Contec PIO1616L digital I/O board
 
 	  To compile this driver as a module, choose M here: the module will be
@@ -842,7 +842,7 @@ config COMEDI_CONTEC_PCI_DIO
 config COMEDI_DAS08_PCI
 	tristate "DAS-08 PCI support"
 	select COMEDI_DAS08
-	---help---
+	help
 	  Enable support for PCI DAS-08 cards.
 
 	  To compile this driver as a module, choose M here: the module will be
@@ -850,7 +850,7 @@ config COMEDI_DAS08_PCI
 
 config COMEDI_DT3000
 	tristate "Data Translation DT3000 series support"
-	---help---
+	help
 	  Enable support for Data Translation DT3000 series
 	  DT3001, DT3001-PGL, DT3002, DT3003, DT3003-PGL, DT3004, DT3005 and
 	  DT3004-200
@@ -860,7 +860,7 @@ config COMEDI_DT3000
 
 config COMEDI_DYNA_PCI10XX
 	tristate "Dynalog PCI DAQ series support"
-	---help---
+	help
 	  Enable support for Dynalog PCI DAQ series
 	  PCI-1050
 
@@ -869,7 +869,7 @@ config COMEDI_DYNA_PCI10XX
 
 config COMEDI_GSC_HPDI
 	tristate "General Standards PCI-HPDI32 / PMC-HPDI32 support"
-	---help---
+	help
 	  Enable support for General Standards Corporation high speed parallel
 	  digital interface rs485 boards PCI-HPDI32 and PMC-HPDI32.
 	  Only receive mode works, transmit not supported.
@@ -879,13 +879,13 @@ config COMEDI_GSC_HPDI
 
 config COMEDI_MF6X4
 	tristate "Humusoft MF634 and MF624 DAQ Card support"
-	---help---
+	help
 	  This driver supports both Humusoft MF634 and MF624 Data acquisition
 	  cards. The legacy Humusoft MF614 card is not supported.
 
 config COMEDI_ICP_MULTI
 	tristate "Inova ICP_MULTI support"
-	---help---
+	help
 	  Enable support for Inova ICP_MULTI card
 
 	  To compile this driver as a module, choose M here: the module will be
@@ -894,7 +894,7 @@ config COMEDI_ICP_MULTI
 config COMEDI_DAQBOARD2000
 	tristate "IOtech DAQboard/2000 support"
 	select COMEDI_8255
-	---help---
+	help
 	  Enable support for the IOtech DAQboard/2000
 
 	  To compile this driver as a module, choose M here: the module will be
@@ -902,7 +902,7 @@ config COMEDI_DAQBOARD2000
 
 config COMEDI_JR3_PCI
 	tristate "JR3/PCI force sensor board support"
-	---help---
+	help
 	  Enable support for JR3/PCI force sensor boards
 
 	  To compile this driver as a module, choose M here: the module will be
@@ -910,7 +910,7 @@ config COMEDI_JR3_PCI
 
 config COMEDI_KE_COUNTER
 	tristate "Kolter-Electronic PCI Counter 1 card support"
-	---help---
+	help
 	  Enable support for Kolter-Electronic PCI Counter 1 cards
 
 	  To compile this driver as a module, choose M here: the module will be
@@ -919,7 +919,7 @@ config COMEDI_KE_COUNTER
 config COMEDI_CB_PCIDAS64
 	tristate "MeasurementComputing PCI-DAS 64xx, 60xx, and 4020 support"
 	select COMEDI_8255
-	---help---
+	help
 	  Enable support for ComputerBoards/MeasurementComputing PCI-DAS 64xx,
 	  60xx, and 4020 series with the PLX 9080 PCI controller
 
@@ -930,7 +930,7 @@ config COMEDI_CB_PCIDAS
 	tristate "MeasurementComputing PCI-DAS support"
 	select COMEDI_8254
 	select COMEDI_8255
-	---help---
+	help
 	  Enable support for ComputerBoards/MeasurementComputing PCI-DAS with
 	  AMCC S5933 PCIcontroller: PCI-DAS1602/16, PCI-DAS1602/16jr,
 	  PCI-DAS1602/12, PCI-DAS1200, PCI-DAS1200jr, PCI-DAS1000, PCI-DAS1001
@@ -942,7 +942,7 @@ config COMEDI_CB_PCIDAS
 config COMEDI_CB_PCIDDA
 	tristate "MeasurementComputing PCI-DDA series support"
 	select COMEDI_8255
-	---help---
+	help
 	  Enable support for ComputerBoards/MeasurementComputing PCI-DDA
 	  series: PCI-DDA08/12, PCI-DDA04/12, PCI-DDA02/12, PCI-DDA08/16,
 	  PCI-DDA04/16 and PCI-DDA02/16
@@ -954,7 +954,7 @@ config COMEDI_CB_PCIMDAS
 	tristate "MeasurementComputing PCIM-DAS1602/16, PCIe-DAS1602/16 support"
 	select COMEDI_8254
 	select COMEDI_8255
-	---help---
+	help
 	  Enable support for ComputerBoards/MeasurementComputing PCI Migration
 	  series PCIM-DAS1602/16 and PCIe-DAS1602/16.
 
@@ -964,7 +964,7 @@ config COMEDI_CB_PCIMDAS
 config COMEDI_CB_PCIMDDA
 	tristate "MeasurementComputing PCIM-DDA06-16 support"
 	select COMEDI_8255
-	---help---
+	help
 	  Enable support for ComputerBoards/MeasurementComputing PCIM-DDA06-16
 
 	  To compile this driver as a module, choose M here: the module will be
@@ -973,7 +973,7 @@ config COMEDI_CB_PCIMDDA
 config COMEDI_ME4000
 	tristate "Meilhaus ME-4000 support"
 	select COMEDI_8254
-	---help---
+	help
 	  Enable support for Meilhaus PCI data acquisition cards
 	  ME-4650, ME-4670i, ME-4680, ME-4680i and ME-4680is
 
@@ -982,7 +982,7 @@ config COMEDI_ME4000
 
 config COMEDI_ME_DAQ
 	tristate "Meilhaus ME-2000i, ME-2600i, ME-3000vm1 support"
-	---help---
+	help
 	  Enable support for Meilhaus PCI data acquisition cards
 	  ME-2000i, ME-2600i and ME-3000vm1
 
@@ -991,7 +991,7 @@ config COMEDI_ME_DAQ
 
 config COMEDI_NI_6527
 	tristate "NI 6527 support"
-	---help---
+	help
 	  Enable support for the National Instruments 6527 PCI card
 
 	  To compile this driver as a module, choose M here: the module will be
@@ -999,7 +999,7 @@ config COMEDI_NI_6527
 
 config COMEDI_NI_65XX
 	tristate "NI 65xx static dio PCI card support"
-	---help---
+	help
 	  Enable support for National Instruments 65xx static dio boards.
 	  Supported devices: National Instruments PCI-6509 (ni_65xx),
 	  PXI-6509, PCI-6510, PCI-6511, PXI-6511, PCI-6512, PXI-6512, PCI-6513,
@@ -1013,7 +1013,7 @@ config COMEDI_NI_660X
 	tristate "NI 660x counter/timer PCI card support"
 	depends on HAS_DMA
 	select COMEDI_NI_TIOCMD
-	---help---
+	help
 	  Enable support for National Instruments PCI-6601 (ni_660x), PCI-6602,
 	  PXI-6602, PXI-6608, PCI-6624, and PXI-6624.
 
@@ -1022,7 +1022,7 @@ config COMEDI_NI_660X
 
 config COMEDI_NI_670X
 	tristate "NI 670x PCI card support"
-	---help---
+	help
 	  Enable support for National Instruments PCI-6703 and PCI-6704
 
 	  To compile this driver as a module, choose M here: the module will be
@@ -1031,7 +1031,7 @@ config COMEDI_NI_670X
 config COMEDI_NI_LABPC_PCI
 	tristate "NI Lab-PC PCI-1200 support"
 	select COMEDI_NI_LABPC
-	---help---
+	help
 	  Enable support for National Instruments Lab-PC PCI-1200.
 
 	  To compile this driver as a module, choose M here: the module will be
@@ -1042,7 +1042,7 @@ config COMEDI_NI_PCIDIO
 	depends on HAS_DMA
 	select COMEDI_MITE
 	select COMEDI_8255
-	---help---
+	help
 	  Enable support for National Instruments PCI-DIO-32HS, PXI-6533,
 	  PCI-6533 and PCI-6534
 
@@ -1054,7 +1054,7 @@ config COMEDI_NI_PCIMIO
 	depends on HAS_DMA
 	select COMEDI_NI_TIOCMD
 	select COMEDI_8255
-	---help---
+	help
 	  Enable support for National Instruments PCI-MIO-E series and M series
 	  (all boards): PCI-MIO-16XE-10, PXI-6030E, PCI-MIO-16E-1,
 	  PCI-MIO-16E-4, PCI-6014, PCI-6040E, PXI-6040E, PCI-6030E, PCI-6031E,
@@ -1074,7 +1074,7 @@ config COMEDI_NI_PCIMIO
 config COMEDI_RTD520
 	tristate "Real Time Devices PCI4520/DM7520 support"
 	select COMEDI_8254
-	---help---
+	help
 	  Enable support for Real Time Devices PCI4520/DM7520
 
 	  To compile this driver as a module, choose M here: the module will be
@@ -1082,7 +1082,7 @@ config COMEDI_RTD520
 
 config COMEDI_S626
 	tristate "Sensoray 626 support"
-	---help---
+	help
 	  Enable support for Sensoray 626
 
 	  To compile this driver as a module, choose M here: the module will be
@@ -1103,7 +1103,7 @@ endif # COMEDI_PCI_DRIVERS
 menuconfig COMEDI_PCMCIA_DRIVERS
 	tristate "Comedi PCMCIA drivers"
 	depends on PCMCIA
-	---help---
+	help
 	  Enable support for comedi PCMCIA drivers.
 
 	  To compile this support as a module, choose M here: the module will
@@ -1114,7 +1114,7 @@ if COMEDI_PCMCIA_DRIVERS
 config COMEDI_CB_DAS16_CS
 	tristate "CB DAS16 series PCMCIA support"
 	select COMEDI_8254
-	---help---
+	help
 	  Enable support for the ComputerBoards/MeasurementComputing PCMCIA
 	  cards DAS16/16, PCM-DAS16D/12 and PCM-DAS16s/16
 
@@ -1124,7 +1124,7 @@ config COMEDI_CB_DAS16_CS
 config COMEDI_DAS08_CS
 	tristate "CB DAS08 PCMCIA support"
 	select COMEDI_DAS08
-	---help---
+	help
 	  Enable support for the ComputerBoards/MeasurementComputing DAS-08
 	  PCMCIA card
 
@@ -1133,7 +1133,7 @@ config COMEDI_DAS08_CS
 
 config COMEDI_NI_DAQ_700_CS
 	tristate "NI DAQCard-700 PCMCIA support"
-	---help---
+	help
 	  Enable support for the National Instruments PCMCIA DAQCard-700 DIO
 
 	  To compile this driver as a module, choose M here: the module will be
@@ -1142,7 +1142,7 @@ config COMEDI_NI_DAQ_700_CS
 config COMEDI_NI_DAQ_DIO24_CS
 	tristate "NI DAQ-Card DIO-24 PCMCIA support"
 	select COMEDI_8255
-	---help---
+	help
 	  Enable support for the National Instruments PCMCIA DAQ-Card DIO-24
 
 	  To compile this driver as a module, choose M here: the module will be
@@ -1151,7 +1151,7 @@ config COMEDI_NI_DAQ_DIO24_CS
 config COMEDI_NI_LABPC_CS
 	tristate "NI DAQCard-1200 PCMCIA support"
 	select COMEDI_NI_LABPC
-	---help---
+	help
 	  Enable support for the National Instruments PCMCIA DAQCard-1200
 
 	  To compile this driver as a module, choose M here: the module will be
@@ -1161,7 +1161,7 @@ config COMEDI_NI_MIO_CS
 	tristate "NI DAQCard E series PCMCIA support"
 	select COMEDI_NI_TIO
 	select COMEDI_8255
-	---help---
+	help
 	  Enable support for the National Instruments PCMCIA DAQCard E series
 	  DAQCard-ai-16xe-50, DAQCard-ai-16e-4, DAQCard-6062E, DAQCard-6024E
 	  and DAQCard-6036E
@@ -1171,7 +1171,7 @@ config COMEDI_NI_MIO_CS
 
 config COMEDI_QUATECH_DAQP_CS
 	tristate "Quatech DAQP PCMCIA data capture card support"
-	---help---
+	help
 	  Enable support for the Quatech DAQP PCMCIA data capture cards
 	  DAQP-208 and DAQP-308
 
@@ -1183,7 +1183,7 @@ endif # COMEDI_PCMCIA_DRIVERS
 menuconfig COMEDI_USB_DRIVERS
 	tristate "Comedi USB drivers"
 	depends on USB
-	---help---
+	help
 	  Enable support for comedi USB drivers.
 
 	  To compile this support as a module, choose M here: the module will
@@ -1193,7 +1193,7 @@ if COMEDI_USB_DRIVERS
 
 config COMEDI_DT9812
 	tristate "DataTranslation DT9812 USB module support"
-	---help---
+	help
 	  Enable support for the Data Translation DT9812 USB module
 
 	  To compile this driver as a module, choose M here: the module will be
@@ -1201,7 +1201,7 @@ config COMEDI_DT9812
 
 config COMEDI_NI_USB6501
 	tristate "NI USB-6501 support"
-	---help---
+	help
 	  Enable support for the National Instruments USB-6501 module.
 
 	  The NI USB-6501 is a Full-Speed USB 2.0 (12 Mbit/s) device that
@@ -1212,7 +1212,7 @@ config COMEDI_NI_USB6501
 
 config COMEDI_USBDUX
 	tristate "ITL USB-DUX-D support"
-	---help---
+	help
 	  Enable support for the Incite Technology Ltd USB-DUX-D Board
 
 	  To compile this driver as a module, choose M here: the module will be
@@ -1220,7 +1220,7 @@ config COMEDI_USBDUX
 
 config COMEDI_USBDUXFAST
 	tristate "ITL USB-DUXfast support"
-	---help---
+	help
 	  Enable support for the Incite Technology Ltd USB-DUXfast Board
 
 	  To compile this driver as a module, choose M here: the module will be
@@ -1228,7 +1228,7 @@ config COMEDI_USBDUXFAST
 
 config COMEDI_USBDUXSIGMA
 	tristate "ITL USB-DUXsigma support"
-	---help---
+	help
 	  Enable support for the Incite Technology Ltd USB-DUXsigma Board
 
 	  To compile this driver as a module, choose M here: the module will be
@@ -1236,7 +1236,7 @@ config COMEDI_USBDUXSIGMA
 
 config COMEDI_VMK80XX
 	tristate "Velleman VM110/VM140 USB Board support"
-	---help---
+	help
 	  Build the Velleman USB Board Low-Level Driver supporting the
 	  K8055/K8061 aka VM110/VM140 devices
 
@@ -1254,7 +1254,7 @@ config COMEDI_8255
 config COMEDI_8255_SA
 	tristate "Standalone 8255 support"
 	select COMEDI_8255
-	---help---
+	help
 	  Enable support for 8255 digital I/O as a standalone driver.
 
 	  You should enable compilation this driver if you plan to use a board
@@ -1271,7 +1271,7 @@ config COMEDI_8255_SA
 
 config COMEDI_KCOMEDILIB
 	tristate "Comedi kcomedilib"
-	---help---
+	help
 	  Build the kcomedilib.
 
 	  This is a kernel module used to open and manipulate Comedi devices
-- 
2.17.1

