Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49C0FC48BD7
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 07:17:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06AC52085A
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 07:17:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ECH6SNWj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726511AbfF0HRq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 03:17:46 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:54067 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbfF0HRp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 03:17:45 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190627071743euoutp01767c799760e6176670aefb2c6776a6bf~r-P3sEGhW0194001940euoutp01I;
        Thu, 27 Jun 2019 07:17:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190627071743euoutp01767c799760e6176670aefb2c6776a6bf~r-P3sEGhW0194001940euoutp01I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1561619863;
        bh=woNvy7Ycl8cbbe+akgfSqQo82Q1t5lHP+Qm81s+Tx3U=;
        h=From:To:Cc:Subject:Date:References:From;
        b=ECH6SNWjfGO/EqJBX6Nt5V52zwLzc6ouCRjy7coIFuoBk578D36tfXzp9mPAvXRzO
         bNZewskx/96d6SYJXUcnubDGRD/whT8jLcd4FJJnl/gsXEvroxg/7gms+T+lsedA7Q
         wAnWEnOT58ekoTsROOxs6jHTKt0PPo/n3waL6j/Y=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190627071742eucas1p2a0a028bf8693fc8f0ab94f4587a68ea4~r-P3I1j-O0427404274eucas1p2d;
        Thu, 27 Jun 2019 07:17:42 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 82.96.04377.69D641D5; Thu, 27
        Jun 2019 08:17:42 +0100 (BST)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190627071741eucas1p1af1430c91f636c5766a76f7ef93019da~r-P2ZbuEE1386213862eucas1p1y;
        Thu, 27 Jun 2019 07:17:41 +0000 (GMT)
X-AuditID: cbfec7f4-113ff70000001119-ae-5d146d960f0a
Received: from eusync4.samsung.com ( [203.254.199.214]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id A7.F3.04140.59D641D5; Thu, 27
        Jun 2019 08:17:41 +0100 (BST)
Received: from AMDC2765.DIGITAL.local ([106.120.51.73]) by
        eusync4.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0 64bit
        (built May  5 2014)) with ESMTPA id <0PTQ00HYSXLCML00@eusync4.samsung.com>;
        Thu, 27 Jun 2019 08:17:41 +0100 (BST)
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     linux-usb@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Felipe Balbi <balbi@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Jochen Sprickerhof <jochen@sprickerhof.de>,
        Anand Moon <linux.amoon@gmail.com>
Subject: [PATCH 0/3] Fix USB3.0 DRD PHY calibration issues (DWC3/XHCI) on
 Exynos542x SoCs
Date:   Thu, 27 Jun 2019 09:17:23 +0200
Message-id: <20190627071726.30467-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrHIsWRmVeSWpSXmKPExsWy7djPc7rTckViDVreSlhsnLGe1eJY2xN2
        i+bF69kslv69x2hx/vwGdovLu+awWcw4v4/JYtGyVmaLdRtvsVusPXIXqG7TFFYHbo+ds+6y
        eyze85LJY9OqTjaP/XPXsHv0bVnF6LFhyz8Wj8+b5ALYo7hsUlJzMstSi/TtErgybly9yVLQ
        lVixcVcLYwPjfL8uRk4OCQETiYNPFjF2MXJxCAmsYJRYvOIYG4TzmVHi94pdQA4HWNWyzniI
        +DJGic51N9khnP+MEpfmrGQCGcUmYCjR9baLDcQWEXCQWLL0DtgkZoH/TBLTb5xgBUkIC0RL
        9Bz5ygJiswioShx9dZARZAOvgK3EvUZOiJPkJVZvOMAM0ishMIdN4uCJViaIK1wkvh2DOltG
        4vLkbhaImmZGiYfn1rJDOD2MEpebZjBCVFlLHD5+EWwxswCfxKRt05khBvFKdLQJQZR4SOxv
        mQJWIiQQK9F/7xPbBEbxBYwMqxjFU0uLc9NTi43yUsv1ihNzi0vz0vWS83M3MQJj8fS/4192
        MO76k3SIUYCDUYmHl2GPcKwQa2JZcWXuIUYJDmYlEd78MJFYId6UxMqq1KL8+KLSnNTiQ4zS
        HCxK4rzVDA+ihQTSE0tSs1NTC1KLYLJMHJxSDYwsFjnK//V1N/FtrpvXubl+oTfrx7h8udV3
        RbbPOnLW9F83Z5baU7XPGxgfRT4PjrqWHWzQaSt67JTU7LdSgXc4BaNTmRQ07uyRU93GcJNT
        sOhv/K930wKvqzYJTSiYcGj3zaPhNUoL7vvIrTib4dfqEr1vS///W9PtX3zx2HD9Ufhxqx2X
        9mQqsRRnJBpqMRcVJwIAcb9fZ8ECAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuphluLIzCtJLcpLzFFi42I5/e/4Nd2puSKxBjcWq1psnLGe1eJY2xN2
        i+bF69kslv69x2hx/vwGdovLu+awWcw4v4/JYtGyVmaLdRtvsVusPXIXqG7TFFYHbo+ds+6y
        eyze85LJY9OqTjaP/XPXsHv0bVnF6LFhyz8Wj8+b5ALYo7hsUlJzMstSi/TtErgybly9yVLQ
        lVixcVcLYwPjfL8uRg4OCQETiWWd8V2MXBxCAksYJZ7vmc0E4TQySfzvOM7axcjJwSZgKNH1
        tosNxBYRcJBYsvQOG0gRs0Ajs8TvHWfBioQFoiV6jnxlAbFZBFQljr46yAiygVfAVuJeIydI
        WEJAXmL1hgPMExi5FjAyrGIUSS0tzk3PLTbSK07MLS7NS9dLzs/dxAgMo23Hfm7Zwdj1LvgQ
        owAHoxIP74qdwrFCrIllxZW5hxglOJiVRHjzw0RihXhTEiurUovy44tKc1KLDzFKc7AoifN2
        CByMERJITyxJzU5NLUgtgskycXBKNTC27ig+eXLihicqnY4Ri47+SHgv4ymg07j94aE7Jfzs
        58rn8Lgcvr77Z2LR3ePrK373FJqFCnHP25TXN4s7+7fxsVtOi6bGrbyn8r3h4htNXYaW+9Mn
        1ye1nDm4h899zoXrcjNvX674lPLJNOHm5fo8988djgFRB95mBd5bLXX46xbdvkcvpsYzKrEU
        ZyQaajEXFScCAIfy3D0fAgAA
X-CMS-MailID: 20190627071741eucas1p1af1430c91f636c5766a76f7ef93019da
CMS-TYPE: 201P
X-CMS-RootMailID: 20190627071741eucas1p1af1430c91f636c5766a76f7ef93019da
References: <CGME20190627071741eucas1p1af1430c91f636c5766a76f7ef93019da@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear All,

Commit d8c80bb3b55b ("phy: exynos5-usbdrd: Calibrate LOS levels for
exynos5420/5800") added support for Exynos5 USB3.0 DRD PHY calibration,
what enabled proper Super-Speed enumeration of USB3.0 devices connected
to various Exynos5 SoCs. After some time it turned out that the mentioned
patch worked a bit by pure luck and covered only one use case (fresh
boot with all drivers compiled into the kernel).

If drivers were compiled as modules, due to timing issue, it worked only
if XHCI-plat driver was loaded before the DWC3 driver:
https://patchwork.kernel.org/patch/10773947/

Also during the system suspend/resume cycle the calibration was not
performed at the proper time and resulted in switching USB 3.0 devices to
USB 2.0 high-speed compatibility mode.

This patch addresses all those issues. Exynos5 USB3.0 DRD PHY calibration
is moved to the Exynos5 specific variant of the XHCI-plat driver, which
takes care of proper PHY calibration after XHCI core reset. This fixes
all known use cases (XHCI driver compiled as module and loaded on demand
as well as during system suspend/resume cycle).

Here are the logs taken on Exynos5422-based Odroid HC1 board (with USB3.0
RTL8153 LAN and USB3.0 JMicron SATA-USB bridge):

Vanilla Linux next-20190620:
----->8-----------------------------------------------------------------
root@target:~# lsusb -t
/:  Bus 06.Port 1: Dev 1, Class=root_hub, Driver=xhci-hcd/1p, 5000M
    |__ Port 1: Dev 2, If 0, Class=Vendor Specific Class, Driver=r8152, 5000M
/:  Bus 05.Port 1: Dev 1, Class=root_hub, Driver=xhci-hcd/1p, 480M
/:  Bus 04.Port 1: Dev 1, Class=root_hub, Driver=xhci-hcd/1p, 5000M
    |__ Port 1: Dev 2, If 0, Class=Mass Storage, Driver=uas, 5000M
/:  Bus 03.Port 1: Dev 1, Class=root_hub, Driver=xhci-hcd/1p, 480M
/:  Bus 02.Port 1: Dev 1, Class=root_hub, Driver=exynos-ohci/3p, 12M
/:  Bus 01.Port 1: Dev 1, Class=root_hub, Driver=exynos-ehci/3p, 480M
root@target:~# time rtcwake -s 10 -m mem
rtcwake: wakeup from "mem" using /dev/rtc0 at Tue Jan  1 01:03:40 2019
[   31.372801] PM: suspend entry (deep)
[   31.376555] Filesystems sync: 0.001 seconds
[   31.396437] Freezing user space processes ... (elapsed 0.006 seconds) done.
[   31.408300] OOM killer disabled.
[   31.411329] Freezing remaining freezable tasks ... (elapsed 0.002 seconds) done.
[   31.419336] printk: Suspending console(s) (use no_console_suspend to debug)
[   31.508432] sd 0:0:0:0: [sda] Synchronizing SCSI cache
[   31.586243] wake enabled for irq 145
[   31.748908] samsung-pinctrl 13400000.pinctrl: Setting external wakeup interrupt mask: 0xffffffef
[   31.758671] Disabling non-boot CPUs ...
[   31.772117] IRQ 51: no longer affine to CPU1
[   31.782147] IRQ 52: no longer affine to CPU2
[   31.789290] IRQ 53: no longer affine to CPU3
[   31.792439] IRQ 54: no longer affine to CPU4
[   31.794942] IRQ 55: no longer affine to CPU5
[   31.797365] IRQ 56: no longer affine to CPU6
[   31.801387] IRQ 57: no longer affine to CPU7
[   31.811149] Enabling non-boot CPUs ...
[   31.815607] CPU1 is up
[   31.818790] CPU2 is up
[   31.821709] CPU3 is up
[   31.826095] CPU4 is up
[   31.828672] CPU5 is up
[   31.831215] CPU6 is up
[   31.834158] CPU7 is up
[   31.859900] s3c2410-wdt 101d0000.watchdog: watchdog disabled
[   31.860158] usb usb1: root hub lost power or was reset
[   31.931175] usb usb2: root hub lost power or was reset
[   31.940717] wake disabled for irq 145
[   31.949146] usb usb3: root hub lost power or was reset
[   31.949235] usb usb4: root hub lost power or was reset
[   31.949329] s3c-rtc 101e0000.rtc: rtc disabled, re-enabling
[   31.950751] usb usb5: root hub lost power or was reset
[   31.950773] usb usb6: root hub lost power or was reset
[   36.201351] OOM killer enabled.
[   36.204381] Restarting tasks ...
[   36.206110] usb 4-1: USB disconnect, device number 2
[   36.206529] usb 6-1: USB disconnect, device number 2
[   36.210588] done.
[   36.220679] PM: suspend exit

real    0m15.613s
user    0m0.000s
sys     0m0.329s
[   36.237525] sd 0:0:0:0: [sda] Synchronizing SCSI cache
[   36.254403] mmc_host mmc0: Bus speed (slot 0) = 50000000Hz (slot req 400000Hz, actual 396825HZ div = 63)
root@target:~# [   36.341609] mmc_host mmc0: Bus speed (slot 0) = 200000000Hz (slot req 200000000Hz, actual 200000000HZ div = 0)
[   36.597244] usb 5-1: new high-speed USB device number 3 using xhci-hcd
[   36.837573] sd 0:0:0:0: [sda] Synchronize Cache(10) failed: Result: hostbyte=0x07 driverbyte=0x00
[   37.099089] usb 5-1: New USB device found, idVendor=0bda, idProduct=8153, bcdDevice=30.00
[   37.105793] usb 5-1: New USB device strings: Mfr=1, Product=2, SerialNumber=6
[   37.112962] usb 5-1: Product: USB 10/100/1000 LAN
[   37.117629] usb 5-1: Manufacturer: Realtek
[   37.121645] usb 5-1: SerialNumber: 000001000000
[   37.373152] usb 5-1: reset high-speed USB device number 3 using xhci-hcd
[   37.407459] usb usb3-port1: Cannot enable. Maybe the USB cable is bad?
[   37.664128] r8152 5-1:1.0 eth0: v1.09.9
[   38.437326] usb 3-1: new high-speed USB device number 3 using xhci-hcd
[   38.628713] usb 3-1: New USB device found, idVendor=152d, idProduct=0578, bcdDevice= 1.05
[   38.635470] usb 3-1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[   38.642803] usb 3-1: Product: USB to SATA bridge
[   38.647321] usb 3-1: Manufacturer: JMicron
[   38.651232] usb 3-1: SerialNumber: DB00000000013B
[   38.678606] scsi host0: uas
[   38.687425] scsi 0:0:0:0: Direct-Access     JMicron                   0105 PQ: 0 ANSI: 6
[   38.704216] sd 0:0:0:0: Attached scsi generic sg0 type 0
[   38.710333] sd 0:0:0:0: [sda] 1953525168 512-byte logical blocks: (1.00 TB/932 GiB)
[   38.716641] sd 0:0:0:0: [sda] 4096-byte physical blocks
[   38.723383] sd 0:0:0:0: [sda] Write Protect is off
[   38.730019] sd 0:0:0:0: [sda] Disabling FUA
[   38.732737] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   38.743524] sd 0:0:0:0: [sda] Optimal transfer size 33553920 bytes not a multiple of physical block size (4096 bytes)
[   38.855590]  sda: sda1 sda2 sda3 sda4 < sda5 sda6 >
[   38.887585] sd 0:0:0:0: [sda] Attached SCSI disk
[   40.968358] usb usb6-port1: Cannot enable. Maybe the USB cable is bad?
[   45.288065] usb usb6-port1: Cannot enable. Maybe the USB cable is bad?

root@target:~# lsusb -t
/:  Bus 06.Port 1: Dev 1, Class=root_hub, Driver=xhci-hcd/1p, 5000M
/:  Bus 05.Port 1: Dev 1, Class=root_hub, Driver=xhci-hcd/1p, 480M
    |__ Port 1: Dev 3, If 0, Class=Vendor Specific Class, Driver=r8152, 480M
/:  Bus 04.Port 1: Dev 1, Class=root_hub, Driver=xhci-hcd/1p, 5000M
/:  Bus 03.Port 1: Dev 1, Class=root_hub, Driver=xhci-hcd/1p, 480M
    |__ Port 1: Dev 3, If 0, Class=Mass Storage, Driver=uas, 480M
/:  Bus 02.Port 1: Dev 1, Class=root_hub, Driver=exynos-ohci/3p, 12M
/:  Bus 01.Port 1: Dev 1, Class=root_hub, Driver=exynos-ehci/3p, 480M
root@target:~#
----->8-----------------------------------------------------------------


Linux next-20190620 with this patchset applied:
----->8-----------------------------------------------------------------
root@target:~# lsusb -t
/:  Bus 06.Port 1: Dev 1, Class=root_hub, Driver=xhci-hcd/1p, 5000M
    |__ Port 1: Dev 2, If 0, Class=Vendor Specific Class, Driver=r8152, 5000M
/:  Bus 05.Port 1: Dev 1, Class=root_hub, Driver=xhci-hcd/1p, 480M
/:  Bus 04.Port 1: Dev 1, Class=root_hub, Driver=xhci-hcd/1p, 5000M
    |__ Port 1: Dev 2, If 0, Class=Mass Storage, Driver=uas, 5000M
/:  Bus 03.Port 1: Dev 1, Class=root_hub, Driver=xhci-hcd/1p, 480M
/:  Bus 02.Port 1: Dev 1, Class=root_hub, Driver=exynos-ohci/3p, 12M
/:  Bus 01.Port 1: Dev 1, Class=root_hub, Driver=exynos-ehci/3p, 480M
root@target:~# time rtcwake -s 10 -m mem
rtcwake: wakeup from "mem" using /dev/rtc0 at Tue Jan  1 01:08:06 2019
[   33.057518] PM: suspend entry (deep)
[   33.068116] Filesystems sync: 0.007 seconds
[   33.100867] Freezing user space processes ... (elapsed 0.004 seconds) done.
[   33.110697] OOM killer disabled.
[   33.113758] Freezing remaining freezable tasks ... (elapsed 0.001 seconds) done.
[   33.121699] printk: Suspending console(s) (use no_console_suspend to debug)
[   33.206799] sd 0:0:0:0: [sda] Synchronizing SCSI cache
[   33.284135] wake enabled for irq 145
[   33.447955] samsung-pinctrl 13400000.pinctrl: Setting external wakeup interrupt mask: 0xffffffef
[   33.459351] Disabling non-boot CPUs ...
[   33.469730] IRQ 51: no longer affine to CPU1
[   33.478596] IRQ 52: no longer affine to CPU2
[   33.484306] IRQ 53: no longer affine to CPU3
[   33.487255] IRQ 54: no longer affine to CPU4
[   33.490071] IRQ 55: no longer affine to CPU5
[   33.492706] IRQ 56: no longer affine to CPU6
[   33.496822] IRQ 57: no longer affine to CPU7
[   33.503482] Enabling non-boot CPUs ...
[   33.508159] CPU1 is up
[   33.511114] CPU2 is up
[   33.514131] CPU3 is up
[   33.518772] CPU4 is up
[   33.521219] CPU5 is up
[   33.523782] CPU6 is up
[   33.526860] CPU7 is up
[   33.551393] s3c2410-wdt 101d0000.watchdog: watchdog disabled
[   33.551651] usb usb1: root hub lost power or was reset
[   33.619193] usb usb2: root hub lost power or was reset
[   33.628517] wake disabled for irq 145
[   33.636675] usb usb3: root hub lost power or was reset
[   33.636768] usb usb4: root hub lost power or was reset
[   33.636883] s3c-rtc 101e0000.rtc: rtc disabled, re-enabling
[   33.636915] usb usb5: root hub lost power or was reset
[   33.636931] usb usb6: root hub lost power or was reset
[   37.556700] usb 4-1: reset SuperSpeed Gen 1 USB device number 2 using xhci-hcd
[   37.890524] OOM killer enabled.
[   37.893600] Restarting tasks ...
[   37.895049] usb 6-1: USB disconnect, device number 2
[   37.897862] done.
[   37.904761] PM: suspend exit

real    0m14.651s
user    0m0.000s
sys     0m0.360s
[   37.931922] mmc_host mmc0: Bus speed (slot 0) = 50000000Hz (slot req 400000Hz, actual 396825HZ div = 63)
root@target:~# [   38.025326] mmc_host mmc0: Bus speed (slot 0) = 200000000Hz (slot req 200000000Hz, actual 200000000HZ div = 0)
[   38.895675] usb 6-1: new SuperSpeed Gen 1 USB device number 3 using xhci-hcd
[   38.929327] usb 6-1: New USB device found, idVendor=0bda, idProduct=8153, bcdDevice=30.00
[   38.936156] usb 6-1: New USB device strings: Mfr=1, Product=2, SerialNumber=6
[   38.943157] usb 6-1: Product: USB 10/100/1000 LAN
[   38.947944] usb 6-1: Manufacturer: Realtek
[   38.951891] usb 6-1: SerialNumber: 000001000000
[   39.215806] usb 6-1: reset SuperSpeed Gen 1 USB device number 3 using xhci-hcd
[   39.351893] r8152 6-1:1.0 eth0: v1.09.9

root@target:~# lsusb -t
/:  Bus 06.Port 1: Dev 1, Class=root_hub, Driver=xhci-hcd/1p, 5000M
    |__ Port 1: Dev 3, If 0, Class=Vendor Specific Class, Driver=r8152, 5000M
/:  Bus 05.Port 1: Dev 1, Class=root_hub, Driver=xhci-hcd/1p, 480M
/:  Bus 04.Port 1: Dev 1, Class=root_hub, Driver=xhci-hcd/1p, 5000M
    |__ Port 1: Dev 2, If 0, Class=Mass Storage, Driver=uas, 5000M
/:  Bus 03.Port 1: Dev 1, Class=root_hub, Driver=xhci-hcd/1p, 480M
/:  Bus 02.Port 1: Dev 1, Class=root_hub, Driver=exynos-ohci/3p, 12M
/:  Bus 01.Port 1: Dev 1, Class=root_hub, Driver=exynos-ehci/3p, 480M
root@target:~#
----->8-----------------------------------------------------------------


Best regards
Marek Szyprowski
Samsung R&D Institute Poland


Patch summary:

Marek Szyprowski (3):
  usb: host: xhci-plat: Add support for Exynos5/DWC3 specific variant
  usb: dwc3: exynos: Use Exynos specific XHCI-plat driver variant
  usb: dwc3: Remove generic PHY calibrate() calls

 drivers/usb/dwc3/Kconfig       |  1 +
 drivers/usb/dwc3/core.c        |  3 +-
 drivers/usb/dwc3/core.h        |  1 +
 drivers/usb/dwc3/dwc3-exynos.c | 64 +++++++++++++++++++++++-----------
 drivers/usb/dwc3/host.c        |  2 +-
 drivers/usb/host/Kconfig       |  8 +++++
 drivers/usb/host/Makefile      |  3 ++
 drivers/usb/host/xhci-exynos.c | 51 +++++++++++++++++++++++++++
 drivers/usb/host/xhci-exynos.h | 26 ++++++++++++++
 drivers/usb/host/xhci-plat.c   | 38 +++++++++++++++++++-
 drivers/usb/host/xhci-plat.h   |  2 ++
 11 files changed, 174 insertions(+), 25 deletions(-)
 create mode 100644 drivers/usb/host/xhci-exynos.c
 create mode 100644 drivers/usb/host/xhci-exynos.h

-- 
2.17.1

