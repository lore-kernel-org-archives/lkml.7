Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 633BAC04AAF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 14:14:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DD15214AE
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 14:14:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="dw/CaZmy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387495AbfETOOh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 10:14:37 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:39263 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732627AbfETOOg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 10:14:36 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190520141435euoutp02582be08355e6b137a037d1421cefcd8d~gaa-lVNYK2201422014euoutp026
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 14:14:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190520141435euoutp02582be08355e6b137a037d1421cefcd8d~gaa-lVNYK2201422014euoutp026
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1558361675;
        bh=a+67DmDkClFtpAgMeS+zXOJHhcsdo4J+1xpAUxugMTw=;
        h=To:Cc:From:Subject:Date:References:From;
        b=dw/CaZmy1Zvc9gtL80ybdfrBiiBUWc5CVbYr6onqBdgn0Vas/wlrHHomyNFtuH7oR
         x97lWdFE1f/gHD4UWomthRYvQKruE/CHtHcAVpj1XTRVkYCoGsinkp66CFZ6Ts5cPC
         j4vXs4zsmmMoX77F7ZpsnW4OwCLxyVNifKMFBeqc=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190520141434eucas1p1cd9e0023f5f7eff509adf981de18239d~gaa-GJZTc1461814618eucas1p1n;
        Mon, 20 May 2019 14:14:34 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 32.F3.04377.A46B2EC5; Mon, 20
        May 2019 15:14:34 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190520141434eucas1p266520a2ef8db42b3deee004e1cba3a1f~gaa_cKhPC1951819518eucas1p23;
        Mon, 20 May 2019 14:14:34 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190520141433eusmtrp1101749c9066f7835498fa085359cf24f~gaa_OIh581805218052eusmtrp1F;
        Mon, 20 May 2019 14:14:33 +0000 (GMT)
X-AuditID: cbfec7f4-5632c9c000001119-4a-5ce2b64a053c
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 70.24.04146.946B2EC5; Mon, 20
        May 2019 15:14:33 +0100 (BST)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190520141433eusmtip1ec047f15af34170449c0afaf8ab29ecf~gaa96gClh0462604626eusmtip1b;
        Mon, 20 May 2019 14:14:33 +0000 (GMT)
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Minas Harutyunyan <hminas@synopsys.com>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH] usb: remove redundant 'default n' from Kconfig-s
Message-ID: <79726177-d524-4f83-eeb2-18ae9b2e50cf@samsung.com>
Date:   Mon, 20 May 2019 16:14:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0hTYRju2zk757iaHKfhy4wuA6t10cyUpSWNAkdF9FN0WCtPajkvO97L
        Ms17NzdLmlpLY+qwlCGahgjzMszSIq2IwEsrzBwYGlSk5fFM8t/Dc/ne54GPwiRGoZSKT0xl
        dImaBBkhwtv6fw3vPto2qd7TNytV9Bc6SEV+XTOhuPq7i1S86awmFLXmAuyQUGW1lBCq7pom
        UtXaPYdUc9aNJ/FI0YEYJiE+ndH5h50WxZX36gXJFnlmYVlwLhrYXIrcKKD3wfSzFkEpElES
        ugHBq0+zAk6Q0PMIRuoyeGEOwf32crSSGJ1+7krUI7BYZ1wJJwJHYxSHvehAuPXSSHImjC5B
        YKhvWjYRdAiUF1mWX/KklTBUMIpzWEyHwcRC75KHonDaFxYbYjh6PR0BY/0tQt7iAQP3HMt2
        jPaGD44HAh5vgnZnNcbdArqIhJqZWZxvegSqjA8JHnvCtL2V5PEGGDRcx/nAEwQLxVOudDuC
        esOiKxEKPfbXQq4RRsuhudOfp5VgnviOOBpod3jv9OBLuIO+rRLjaTEUF0p491ZoMbcQK2dL
        OxoxHqvg5sgPdBttMa6aZlw1zbhqmvF/BxPCLcibSWO1sQy7N5HJ8GM1WjYtMdbvbJLWipZ+
        zOCiff4p6vxzxoZoCsnWieMqJtUSoSadzdLaEFCYzEscuG1MLRHHaLKyGV3SKV1aAsPakA+F
        y7zFF9eMR0noWE0qc4Fhkhndiiqg3KS5KDQ/m9wfdCmMuDLlXPs473BKSFmIHAJUlbV2ZUfK
        uO2cdPhz8ExfdCAVE3b5WsXQ8ZqcptxMAxkU51mlD4/0sZgEPhHhyp1/86K/ws989TEmZ5fp
        S9J2LLhWbzsxr7phfnHwziNMXvqusuv8vMlXYZtM/3h3IVcE33rsbzMIGc7GaQJ2YDpW8w+w
        0vAgLQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprCIsWRmVeSWpSXmKPExsVy+t/xu7qe2x7FGCx4rm1xrO0Ju0Xz4vVs
        Fo2/9rJbXN41h81i0bJWZgdWj02rOtk89s9dw+6xZf9nRo/Pm+QCWKL0bIryS0tSFTLyi0ts
        laINLYz0DC0t9IxMLPUMjc1jrYxMlfTtbFJSczLLUov07RL0MiYemcRUsEqzoq3brIHxpEIX
        IyeHhICJxNVXp5i6GLk4hASWMkqsX3CStYuRAyghI3F8fRlEjbDEn2tdbBA1rxkl/tw7ygiS
        EBEwlug/O4sdJMEs0M4ocfYnSDMnB5uAlcTE9lVgRcICjhLnWq+ygNi8AnYSD/8eYQJZwCKg
        KvFvRQpIWFQgQuLM+xVQJYISJ2c+AbOZBdQl/sy7xAxhi0vcejKfCcKWl9j+dg7zBEaBWUha
        ZiFpmYWkZRaSlgWMLKsYRVJLi3PTc4sN9YoTc4tL89L1kvNzNzECY2TbsZ+bdzBe2hh8iFGA
        g1GJhzdjyqMYIdbEsuLK3EOMEhzMSiK8xur3Y4R4UxIrq1KL8uOLSnNSiw8xmgL9M5FZSjQ5
        Hxi/eSXxhqaG5haWhubG5sZmFkrivB0CB2OEBNITS1KzU1MLUotg+pg4OKUaGO2Ys/N/L1w5
        ZeKkiKyzi34tMdef+j1m1g/jtPne/W7SexQXb5y13fRGyVmRCQVzZc8qH2Bdr3B1UWRp8bS1
        WT815n3SuPLdfbYF1/5Ppr6NPOeEee0ct6SplKnfmvD4W4HS5H+HD4Yw+3fYtsh4uyjO/9ib
        43Yq6ca2w9nCnGpHT0SZrg24V6vEUpyRaKjFXFScCACxKkxYpwIAAA==
X-CMS-MailID: 20190520141434eucas1p266520a2ef8db42b3deee004e1cba3a1f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190520141434eucas1p266520a2ef8db42b3deee004e1cba3a1f
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190520141434eucas1p266520a2ef8db42b3deee004e1cba3a1f
References: <CGME20190520141434eucas1p266520a2ef8db42b3deee004e1cba3a1f@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'default n' is the default value for any bool or tristate Kconfig
setting so there is no need to write it explicitly.

Also since commit f467c5640c29 ("kconfig: only write '# CONFIG_FOO
is not set' for visible symbols") the Kconfig behavior is the same
regardless of 'default n' being present or not:

    ...
    One side effect of (and the main motivation for) this change is making
    the following two definitions behave exactly the same:
    
        config FOO
                bool
    
        config FOO
                bool
                default n
    
    With this change, neither of these will generate a
    '# CONFIG_FOO is not set' line (assuming FOO isn't selected/implied).
    That might make it clearer to people that a bare 'default n' is
    redundant.
    ...

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/usb/atm/Kconfig           |    1 -
 drivers/usb/core/Kconfig          |    1 -
 drivers/usb/dwc2/Kconfig          |    1 -
 drivers/usb/gadget/legacy/Kconfig |    2 --
 drivers/usb/host/Kconfig          |    5 -----
 drivers/usb/renesas_usbhs/Kconfig |    1 -
 6 files changed, 11 deletions(-)

Index: b/drivers/usb/atm/Kconfig
===================================================================
--- a/drivers/usb/atm/Kconfig
+++ b/drivers/usb/atm/Kconfig
@@ -7,7 +7,6 @@ menuconfig USB_ATM
 	tristate "USB DSL modem support"
 	depends on ATM
 	select CRC32
-	default n
 	help
 	  Say Y here if you want to connect a USB Digital Subscriber Line (DSL)
 	  modem to your computer's USB port.  You will then need to choose your
Index: b/drivers/usb/core/Kconfig
===================================================================
--- a/drivers/usb/core/Kconfig
+++ b/drivers/usb/core/Kconfig
@@ -45,7 +45,6 @@ config USB_DYNAMIC_MINORS
 config USB_OTG
 	bool "OTG support"
 	depends on PM
-	default n
 	help
 	  The most notable feature of USB OTG is support for a
 	  "Dual-Role" device, which can act as either a device
Index: b/drivers/usb/dwc2/Kconfig
===================================================================
--- a/drivers/usb/dwc2/Kconfig
+++ b/drivers/usb/dwc2/Kconfig
@@ -58,7 +58,6 @@ config USB_DWC2_PCI
 	tristate "DWC2 PCI"
 	depends on USB_PCI
 	depends on USB_GADGET || !USB_GADGET
-	default n
 	select NOP_USB_XCEIV
 	help
 	  The Designware USB2.0 PCI interface module for controllers
Index: b/drivers/usb/gadget/legacy/Kconfig
===================================================================
--- a/drivers/usb/gadget/legacy/Kconfig
+++ b/drivers/usb/gadget/legacy/Kconfig
@@ -153,7 +153,6 @@ config USB_ETH_EEM
        depends on USB_ETH
 	select USB_LIBCOMPOSITE
 	select USB_F_EEM
-       default n
        help
          CDC EEM is a newer USB standard that is somewhat simpler than CDC ECM
          and therefore can be supported by more hardware.  Technically ECM and
@@ -419,7 +418,6 @@ config USB_G_MULTI_RNDIS
 config USB_G_MULTI_CDC
 	bool "CDC Ethernet + CDC Serial + Storage configuration"
 	depends on USB_G_MULTI
-	default n
 	select USB_F_ECM
 	help
 	  This option enables a configuration with CDC Ethernet (ECM), CDC
Index: b/drivers/usb/host/Kconfig
===================================================================
--- a/drivers/usb/host/Kconfig
+++ b/drivers/usb/host/Kconfig
@@ -161,7 +161,6 @@ config USB_EHCI_PCI
 config USB_EHCI_HCD_PMC_MSP
 	tristate "EHCI support for on-chip PMC MSP71xx USB controller"
 	depends on MSP_HAS_USB
-	default n
 	select USB_EHCI_BIG_ENDIAN_DESC
 	select USB_EHCI_BIG_ENDIAN_MMIO
 	---help---
@@ -308,7 +307,6 @@ config USB_CNS3XXX_EHCI
 
 config USB_EHCI_HCD_PLATFORM
 	tristate "Generic EHCI driver for a platform device"
-	default n
 	---help---
 	  Adds an EHCI host driver for a generic platform device, which
 	  provides a memory space and an irq.
@@ -318,7 +316,6 @@ config USB_EHCI_HCD_PLATFORM
 config USB_OCTEON_EHCI
 	bool "Octeon on-chip EHCI support (DEPRECATED)"
 	depends on CAVIUM_OCTEON_SOC
-	default n
 	select USB_EHCI_BIG_ENDIAN_MMIO if CPU_BIG_ENDIAN
 	select USB_EHCI_HCD_PLATFORM
 	help
@@ -526,7 +523,6 @@ config USB_OHCI_HCD_SSB
 	depends on (SSB = y || SSB = USB_OHCI_HCD)
 	select USB_HCD_SSB
 	select USB_OHCI_HCD_PLATFORM
-	default n
 	---help---
 	  This option is deprecated now and the driver was removed, use
 	  USB_HCD_SSB and USB_OHCI_HCD_PLATFORM instead.
@@ -569,7 +565,6 @@ config USB_CNS3XXX_OHCI
 
 config USB_OHCI_HCD_PLATFORM
 	tristate "Generic OHCI driver for a platform device"
-	default n
 	---help---
 	  Adds an OHCI host driver for a generic platform device, which
 	  provides a memory space and an irq.
Index: b/drivers/usb/renesas_usbhs/Kconfig
===================================================================
--- a/drivers/usb/renesas_usbhs/Kconfig
+++ b/drivers/usb/renesas_usbhs/Kconfig
@@ -8,7 +8,6 @@ config USB_RENESAS_USBHS
 	depends on USB_GADGET
 	depends on ARCH_RENESAS || SUPERH || COMPILE_TEST
 	depends on EXTCON || !EXTCON # if EXTCON=m, USBHS cannot be built-in
-	default n
 	help
 	  Renesas USBHS is a discrete USB host and peripheral controller chip
 	  that supports both full and high speed USB 2.0 data transfers.
