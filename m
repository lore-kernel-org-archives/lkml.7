Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12233C3A5A3
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 05:31:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C65C6206BB
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 05:31:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="rO2xntTD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727326AbfH2Fav (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 01:30:51 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:44668 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725847AbfH2Fau (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 01:30:50 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190829053049euoutp0270f1a308e06f53a65e4d8a2ae779d289~-TbhVFEtp3271032710euoutp021
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 05:30:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190829053049euoutp0270f1a308e06f53a65e4d8a2ae779d289~-TbhVFEtp3271032710euoutp021
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1567056649;
        bh=bnrH9YUc0dnZ/rNI/HcMp93A1tgt04jv17Ek7SrNyDA=;
        h=From:To:Cc:Subject:Date:References:From;
        b=rO2xntTDWogWNO8OSWT90V8JU43e4k8nmoZcSE8D/Qs9Y8fp6EY//eRLd/PkHVV+9
         9ulUSqkus8xbWvCmV3vLQczkQnRom42lKND1Fk/2KUgCCviM9/53jlQSA3MEpojinv
         FMZ7gs2AmiBAHWrOKJGGeyi8zndd13N/DHAygWoc=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190829053048eucas1p266a7afeafa2a1f1ed3bb5d0284a79067~-TbglLhaw1376713767eucas1p2O;
        Thu, 29 Aug 2019 05:30:48 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 26.E0.04309.803676D5; Thu, 29
        Aug 2019 06:30:48 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190829053047eucas1p14d29d6c351709e684427c465b1084426~-TbfmY2en0660206602eucas1p1k;
        Thu, 29 Aug 2019 05:30:47 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190829053047eusmtrp1b486790138e387f943d1e24447ba0ad2~-TbfX_T7N1101011010eusmtrp1D;
        Thu, 29 Aug 2019 05:30:47 +0000 (GMT)
X-AuditID: cbfec7f4-ae1ff700000010d5-14-5d676308e97f
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id E5.EC.04117.703676D5; Thu, 29
        Aug 2019 06:30:47 +0100 (BST)
Received: from AMDC2765.DIGITAL.local (unknown [106.120.51.73]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190829053046eusmtip10abc1a74645d736534ba449c46a425fd~-TbevzICO1921619216eusmtip1F;
        Thu, 29 Aug 2019 05:30:46 +0000 (GMT)
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     linux-usb@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Felipe Balbi <balbi@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Jochen Sprickerhof <jochen@sprickerhof.de>,
        Anand Moon <linux.amoon@gmail.com>
Subject: [PATCH v2 0/2 2nd RESEND] Fix USB3.0 DRD PHY calibration issues
 (DWC3/XHCI) on Exynos542x SoCs
Date:   Thu, 29 Aug 2019 07:30:26 +0200
Message-Id: <20190829053028.32438-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprGKsWRmVeSWpSXmKPExsWy7djPc7ocyemxBs2tYhYbZ6xntTjW9oTd
        onnxejaLpX/vMVqcP7+B3eLyrjlsFjPO72OyWLSsldli3cZb7BZrj9xltzi26CSLRfOmKawO
        PB47Z91l93g6YTK7x+I9L5k8Nq3qZPPYP3cNu0ffllWMHhu2/GPx+LxJLoAjissmJTUnsyy1
        SN8ugStj1tu1LAX70ysOv1nH1sDYF9LFyMkhIWAise1XI2sXIxeHkMAKRokth84xQzhfGCVe
        HvrHDFIlJPCZUaKzKRCm4+uJw6wQ8eWMEn/PZMI1nL+0jQ0kwSZgKNH1tgvMFhFwkFiy9A4b
        SBGzwG5mib0/34ElhAUyJbr6HrKD2CwCqhLnFk9kArF5BWwlunb9YIPYJi+xesMBZgi7n11i
        yv9iCNtFom/ZNBYIW1ji1fEt7BC2jMTpyT0sIMskBJoZJR6eW8sO4fQwSlxumsEIUWUtcfj4
        RaAfOIBO0pRYv0sfIuwo8WP6GjaQsIQAn8SNt4IgYWYgc9K26cwQYV6JjjYhiGo1iVnH18Gt
        PXjhEtSZHhKdS9tZIAEUK3Hr6n+2CYxysxB2LWBkXMUonlpanJueWmyUl1quV5yYW1yal66X
        nJ+7iRGYWk7/O/5lB+OuP0mHGAU4GJV4eBOS02KFWBPLiitzDzFKcDArifA+UkmNFeJNSays
        Si3Kjy8qzUktPsQozcGiJM5bzfAgWkggPbEkNTs1tSC1CCbLxMEp1cA4UWqP9JXIG44y1d+2
        v2Jr/6JzzSvFI7nA5HikqlXrZH/H7zs7/l5boriL9c7URx+Vmkznrv6i0XM7fdGPOdXp8f33
        v/xf+/H/ZxZPQzmDC5t4ri+oqfq08O/2dWvOfZQN9fBo9fRfYc2hF92QNuu7fr/41RPLeBcH
        XZ9RwPRm+afnRTOWc0+PVmIpzkg01GIuKk4EAAs+ZfopAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrLLMWRmVeSWpSXmKPExsVy+t/xu7rsyemxBicaBCw2zljPanGs7Qm7
        RfPi9WwWS//eY7Q4f34Du8XlXXPYLGac38dksWhZK7PFuo232C3WHrnLbnFs0UkWi+ZNU1gd
        eDx2zrrL7vF0wmR2j8V7XjJ5bFrVyeaxf+4ado++LasYPTZs+cfi8XmTXABHlJ5NUX5pSapC
        Rn5xia1StKGFkZ6hpYWekYmlnqGxeayVkamSvp1NSmpOZllqkb5dgl7GrLdrWQr2p1ccfrOO
        rYGxL6SLkZNDQsBE4uuJw6wgtpDAUkaJJwdNIeIyEienNbBC2MISf651sXUxcgHVfGKU2D1v
        OyNIgk3AUKLrLUiCk0NEwEmic+1psCJmgYPMEhcv7mUHSQgLpEt8mLeaCcRmEVCVOLd4IpjN
        K2Ar0bXrBxvEBnmJ1RsOME9g5FnAyLCKUSS1tDg3PbfYSK84Mbe4NC9dLzk/dxMjMKi3Hfu5
        ZQdj17vgQ4wCHIxKPLwJyWmxQqyJZcWVuYcYJTiYlUR4H6mkxgrxpiRWVqUW5ccXleakFh9i
        NAVaPpFZSjQ5HxhxeSXxhqaG5haWhubG5sZmFkrivB0CB2OEBNITS1KzU1MLUotg+pg4OKUa
        GKOLL35LSTvGYVPhXH/ZV26husZqH+e9zxyN3mbL6xt+2v9pSri4nlZxy5Z45ktlIRlpVk/e
        P5afaND3fLLcj3m9G7hvT/16Pfca3+M5D99X1KZ+/lSRGMdypOiNhdeEqTtLLuyZYJw3891M
        tpurMvmeeITLBBgync0JKypOz6/OPmET1LtZX4mlOCPRUIu5qDgRACslzbeAAgAA
X-CMS-MailID: 20190829053047eucas1p14d29d6c351709e684427c465b1084426
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190829053047eucas1p14d29d6c351709e684427c465b1084426
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190829053047eucas1p14d29d6c351709e684427c465b1084426
References: <CGME20190829053047eucas1p14d29d6c351709e684427c465b1084426@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear All,

Commit d8c80bb3b55b ("phy: exynos5-usbdrd: Calibrate LOS levels for
exynos5420/5800") added support for Exynos5 USB3.0 DRD PHY calibration,
what enabled proper Super-Speed enumeration of USB3.0 devices connected
to various Exynos5 SoCs. After some time it turned out that the mentioned
patch worked a bit by pure luck and covered only one use case: fresh
boot with all drivers compiled into the kernel.

If drivers were compiled as modules, due to timing issues, it worked only
if XHCI-plat driver was loaded before the DWC3 driver:
https://patchwork.kernel.org/patch/10773947/

Also during the system suspend/resume cycle the calibration was not
performed at the proper time, what resulted in switching USB 3.0 devices to
USB 2.0 high-speed compatibility mode.

This patch addresses all those issues. Exynos5 USB3.0 DRD PHY calibration
is moved to the generic USB HCD PHY handling code, which takes care of
proper PHY calibration after HCD (XHCI) core reset. This fixes all known
use cases (XHCI driver compiled as module and loaded on demand as well as
during system suspend/resume cycle).

The main change comparing to v1 is huge simplification of the code:
generic PHYs are already handled by HCD core code, so the calibration is
added there. No Exynos-specific XHCI driver variant is needed anymore.
There is also no need to change the way the DWC3 driver is instantiated,
what wasn't done right in v1 too (the code oopsed on module remove).

Here are the logs taken on Exynos5422-based Odroid HC1 board (with USB3.0
RTL8153 LAN and USB3.0 JMicron SATA-USB bridge):

Vanilla Linux next-20190716:
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
rtcwake: wakeup from "mem" using /dev/rtc0 at Fri Jul 19 07:08:29 2019
[   43.641914] PM: suspend entry (deep)
[   43.647758] Filesystems sync: 0.003 seconds
[   43.663038] Freezing user space processes ... (elapsed 0.006 seconds) done.
[   43.674858] OOM killer disabled.
[   43.677824] Freezing remaining freezable tasks ... (elapsed 0.001 seconds) done.
[   43.685644] printk: Suspending console(s) (use no_console_suspend to debug)
[   43.754198] sd 0:0:0:0: [sda] Synchronizing SCSI cache
[   43.831613] wake enabled for irq 145
[   43.994550] samsung-pinctrl 13400000.pinctrl: Setting external wakeup interrupt mask: 0xffffffef
[   44.004378] Disabling non-boot CPUs ...
[   44.014851] IRQ 51: no longer affine to CPU1
[   44.023293] IRQ 52: no longer affine to CPU2
[   44.028975] IRQ 53: no longer affine to CPU3
[   44.031818] IRQ 54: no longer affine to CPU4
[   44.034229] IRQ 55: no longer affine to CPU5
[   44.036648] IRQ 56: no longer affine to CPU6
[   44.040546] IRQ 57: no longer affine to CPU7
[   44.048237] Enabling non-boot CPUs ...
[   44.053004] CPU1 is up
[   44.056036] CPU2 is up
[   44.058860] CPU3 is up
[   44.059552] CPU4: detected I-Cache line size mismatch, workaround enabled
[   44.063502] CPU4 is up
[   44.064097] CPU5: detected I-Cache line size mismatch, workaround enabled
[   44.065997] CPU5 is up
[   44.066611] CPU6: detected I-Cache line size mismatch, workaround enabled
[   44.068640] CPU6 is up
[   44.069259] CPU7: detected I-Cache line size mismatch, workaround enabled
[   44.071689] CPU7 is up
[   44.096037] s3c2410-wdt 101d0000.watchdog: watchdog disabled
[   44.176142] wake disabled for irq 145
[   44.184616] usb usb3: root hub lost power or was reset
[   44.184705] usb usb4: root hub lost power or was reset
[   44.184804] s3c-rtc 101e0000.rtc: rtc disabled, re-enabling
[   44.184877] usb usb5: root hub lost power or was reset
[   44.184894] usb usb6: root hub lost power or was reset
[   48.467048] OOM killer enabled.
[   48.470075] Restarting tasks ...
[   48.471490] usb 4-1: USB disconnect, device number 2
[   48.473789] usb 6-1: USB disconnect, device number 2
[   48.474380] done.
[   48.487766] PM: suspend exit

real    0m15.098s
user    0m0.000s
sys     0m0.358s
[   48.519357] mmc_host mmc0: Bus speed (slot 0) = 50000000Hz (slot req 400000Hz, actual 396825HZ div = 63)
root@target:~# [   48.540888] sd 0:0:0:0: [sda] Synchronizing SCSI cache
[   48.624651] mmc_host mmc0: Bus speed (slot 0) = 200000000Hz (slot req 200000000Hz, actual 200000000HZ div = 0)
[   48.874422] usb 5-1: new high-speed USB device number 3 using xhci-hcd
[   49.154586] sd 0:0:0:0: [sda] Synchronize Cache(10) failed: Result: hostbyte=0x07 driverbyte=0x00
[   49.355211] usb 5-1: New USB device found, idVendor=0bda, idProduct=8153, bcdDevice=30.00
[   49.361906] usb 5-1: New USB device strings: Mfr=1, Product=2, SerialNumber=6
[   49.369288] usb 5-1: Product: USB 10/100/1000 LAN
[   49.373740] usb 5-1: Manufacturer: Realtek
[   49.377760] usb 5-1: SerialNumber: 000001000000
[   49.619366] usb 5-1: reset high-speed USB device number 3 using xhci-hcd
[   49.643116] usb usb3-port1: Cannot enable. Maybe the USB cable is bad?
[   49.903126] r8152 5-1:1.0 eth0: v1.09.10
[   50.673383] usb 3-1: new high-speed USB device number 3 using xhci-hcd
[   50.864851] usb 3-1: New USB device found, idVendor=152d, idProduct=0578, bcdDevice= 1.05
[   50.871612] usb 3-1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[   50.878953] usb 3-1: Product: USB to SATA bridge
[   50.883457] usb 3-1: Manufacturer: JMicron
[   50.887376] usb 3-1: SerialNumber: DB00000000013B
[   50.921771] scsi host0: uas
[   50.927573] scsi 0:0:0:0: Direct-Access     JMicron                   0105 PQ: 0 ANSI: 6
[   50.943500] sd 0:0:0:0: Attached scsi generic sg0 type 0
[   50.948997] sd 0:0:0:0: [sda] 117229295 512-byte logical blocks: (60.0 GB/55.9 GiB)
[   50.955537] sd 0:0:0:0: [sda] 4096-byte physical blocks
[   50.962062] sd 0:0:0:0: [sda] Write Protect is off
[   50.969062] sd 0:0:0:0: [sda] Disabling FUA
[   50.971787] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   50.984021] sd 0:0:0:0: [sda] Optimal transfer size 33553920 bytes not a multiple of physical block size (4096 bytes)
[   51.015373]  sda: sda1 sda2 sda3 sda4 < sda5 sda6 >
[   51.041092] sd 0:0:0:0: [sda] Attached SCSI disk
[   53.223864] usb usb6-port1: Cannot enable. Maybe the USB cable is bad?
[   57.544062] usb usb6-port1: Cannot enable. Maybe the USB cable is bad?
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


Linux next-20190716 with this patchset applied:
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
[  475.834797] Filesystems sync: 0.005 seconds
[  475.851002] Freezing user space processes ... (elapsed 0.001 seconds) done.
[  475.858621] OOM killer disabled.
[  475.861856] Freezing remaining freezable tasks ... (elapsed 0.001 seconds) done.
[  475.869783] printk: Suspending console(s) (use no_console_suspend to debug)
[  475.959486] sd 0:0:0:0: [sda] Synchronizing SCSI cache
[  476.036891] wake enabled for irq 145
[  476.189298] samsung-pinctrl 13400000.pinctrl: Setting external wakeup interrupt mask: 0xffffffef
[  476.198502] Disabling non-boot CPUs ...
[  476.205227] IRQ 51: no longer affine to CPU1
[  476.211776] IRQ 52: no longer affine to CPU2
[  476.215564] IRQ 53: no longer affine to CPU3
[  476.218025] IRQ 54: no longer affine to CPU4
[  476.220913] IRQ 55: no longer affine to CPU5
[  476.223242] IRQ 56: no longer affine to CPU6
[  476.226789] IRQ 57: no longer affine to CPU7
[  476.254284] Enabling non-boot CPUs ...
[  476.258860] CPU1 is up
[  476.261658] CPU2 is up
[  476.264471] CPU3 is up
[  476.265161] CPU4: detected I-Cache line size mismatch, workaround enabled
[  476.269026] CPU4 is up
[  476.269640] CPU5: detected I-Cache line size mismatch, workaround enabled
[  476.271481] CPU5 is up
[  476.272094] CPU6: detected I-Cache line size mismatch, workaround enabled
[  476.274056] CPU6 is up
[  476.274668] CPU7: detected I-Cache line size mismatch, workaround enabled
[  476.276976] CPU7 is up
[  476.302530] s3c2410-wdt 101d0000.watchdog: watchdog disabled
[  476.302801] usb usb1: root hub lost power or was reset
[  476.372443] usb usb2: root hub lost power or was reset
[  476.381291] wake disabled for irq 145
[  476.401548] usb usb3: root hub lost power or was reset
[  476.401636] usb usb4: root hub lost power or was reset
[  476.401728] s3c-rtc 101e0000.rtc: rtc disabled, re-enabling
[  476.410472] usb usb5: root hub lost power or was reset
[  476.410495] usb usb6: root hub lost power or was reset
[  478.920232] usb 4-1: reset SuperSpeed Gen 1 USB device number 2 using xhci-hcd
[  480.685206] OOM killer enabled.
[  480.688272] Restarting tasks ... done.
[  480.699751] usb 6-1: USB disconnect, device number 2
[  480.706698] PM: suspend exit

real    0m16.018s
user    0m0.000s
sys     0m0.342s
[  480.734080] mmc_host mmc0: Bus speed (slot 0) = 50000000Hz (slot req 400000Hz, actual 396825HZ div = 63)
root@target:~# [  480.843283] mmc_host mmc0: Bus speed (slot 0) = 200000000Hz (slot req 200000000Hz, actual 200000000HZ div = 0)
[  481.679454] usb 6-1: new SuperSpeed Gen 1 USB device number 3 using xhci-hcd
[  481.716309] usb 6-1: New USB device found, idVendor=0bda, idProduct=8153, bcdDevice=30.00
[  481.723359] usb 6-1: New USB device strings: Mfr=1, Product=2, SerialNumber=6
[  481.731394] usb 6-1: Product: USB 10/100/1000 LAN
[  481.734881] usb 6-1: Manufacturer: Realtek
[  481.739196] usb 6-1: SerialNumber: 000001000000
[  482.002327] usb 6-1: reset SuperSpeed Gen 1 USB device number 3 using xhci-hcd
[  482.141639] r8152 6-1:1.0 eth0: v1.09.10

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


Changelog:
v2 2nd resend:
- added acked-by tags

v2 resend: https://lkml.org/lkml/2019/8/8/258
- added tested-by tags

v2: https://lkml.org/lkml/2019/7/19/605
- found that generic phys are already handled by usb hcd core code, so
  phy_calibration has been moved to drivers/usb/core/{hcd,phy}.c
- dropped custom xhci-exynos driver variant, no longer needed
- dropped passing custom properties from dwc3-exynos to generic dwc3
  core driver, no longer needed and mixing custom driver properties
  with DT-properties didn't work well (generic cleanup path caused
  oops in such case)

v1: https://lkml.org/lkml/2019/6/27/123
 - initial version


Patch summary:

Marek Szyprowski (2):
  usb: core: phy: add support for PHY calibration
  usb: dwc3: remove generic PHY calibrate() calls

 drivers/usb/core/hcd.c  |  7 +++++++
 drivers/usb/core/phy.c  | 21 +++++++++++++++++++++
 drivers/usb/core/phy.h  |  1 +
 drivers/usb/dwc3/core.c |  2 --
 4 files changed, 29 insertions(+), 2 deletions(-)

-- 
2.17.1

