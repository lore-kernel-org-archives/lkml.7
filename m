Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58E1BC76188
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 08:12:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19EDB2084D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 08:12:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="MijJo1Nc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727280AbfGSIMb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 04:12:31 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:51722 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726320AbfGSIMa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 04:12:30 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190719081225euoutp024cf4d5bf67471a2b3af9e6d331aa430f~ywL6il7Z31997519975euoutp02r
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2019 08:12:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190719081225euoutp024cf4d5bf67471a2b3af9e6d331aa430f~ywL6il7Z31997519975euoutp02r
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1563523945;
        bh=QdzD2D/8X3POmjUmu+eveZ9u/3haxVg0w4O7YBx4NPU=;
        h=From:To:Cc:Subject:Date:References:From;
        b=MijJo1NcJwU7KzuyT992/vMAF1cElCLjYaDIDazkpLQLA6xcrmlzsVhs62D3vaSzk
         5i/74R5lnVK7rldEmV7I46m5MUpAtybXRIRQSiH/0KgQeVtBsycSEiDGzf5/31A3sE
         Y1TtSWJb56GR0v56kmbwgLhs2ASLt//60H75qSiw=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190719081224eucas1p2d49a6dce6f6b383787eaf9bb7cb4dbd8~ywL51zJ-j3107931079eucas1p2n;
        Fri, 19 Jul 2019 08:12:24 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 87.78.04377.86B713D5; Fri, 19
        Jul 2019 09:12:24 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190719081224eucas1p1729ccaba8affe5a7ff65296519bcfe95~ywL5CXHsC3149831498eucas1p17;
        Fri, 19 Jul 2019 08:12:24 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190719081223eusmtrp15501431774c25ec7b14c8e4504ce04bf~ywL43w2C40247902479eusmtrp1_;
        Fri, 19 Jul 2019 08:12:23 +0000 (GMT)
X-AuditID: cbfec7f4-12dff70000001119-29-5d317b68f5e5
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 31.CE.04146.76B713D5; Fri, 19
        Jul 2019 09:12:23 +0100 (BST)
Received: from AMDC2765.DIGITAL.local (unknown [106.120.51.73]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190719081223eusmtip1c703a784322dbee7566bbb0d9e447ffe~ywL4TpsJh3260232602eusmtip1O;
        Fri, 19 Jul 2019 08:12:23 +0000 (GMT)
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
Subject: [PATCH v2 0/2] Fix USB3.0 DRD PHY calibration issues (DWC3/XHCI) on
 Exynos542x SoCs
Date:   Fri, 19 Jul 2019 10:12:12 +0200
Message-Id: <20190719081212.9249-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA0VSb0gTYRzu3d3tTm1xnoJvFloTA7WcRshFEiYKhzNYCX6olp15Tsmp7NRa
        Eoia2LQwDZSlIk5NVm66RGpI5ZRNcblKRKuZCWEpWYJGBqY5T+3b8/d94MdLIFQ1Fkhk5xZw
        mlw2Ryr2Rvvsf1zHsoqjlVE2eyjd02DGaHvFF5wuM5jFdPvfT4B2ubpxetzaKKYbXC9EdGvH
        bYQ29XzA6a6h6c2c5QEW58M810/jjKF/XsRYjHfEzMumJzhzr9cImO7edZRZtgQp8AvesRlc
        TnYRp5GdvuKdNTA3L8ovz7xRvjCKlYDv53XAi4DkCeh2/sB0wJugyE4Ap+xt22QFwNdOi1gg
        ywDqzWuinUrljE7swRT5CMCRdWq30VT1a8sQk9FQtyiE/Mk42Nbu3noJITdEsH5qGPMYfuRl
        aCnVozpAECgZCpu/JnpkCRkLB11DqDAWDB93v0I8XUhuiGFf1dK2kQBn7cO4gP3ggqN3Gx+E
        o3XVqFAoA3B2rAsXSDWA46UNQEidgoOOt5hnGSHDoNkqE+Qz8H1LC+6RIbkPTi36emRkE9b2
        1SOCLIGVFZSQPgL1DtPu7MCbd9sRBtY0Rgj3UcI2nRuvAUH6/1MtABhBAFfIq1UcfzyXux7J
        s2q+MFcVeTVPbQGbf2R03bHyDFjX0m2AJIB0r0ShjlJSGFvEa9U2AAlE6i/5OC9TUpIMVnuT
        0+SlaQpzON4GDhCoNEBSvOfzRYpUsQXcNY7L5zQ7rojwCiwBhwzN5lgpRUdo5T6Ss6xv6mSS
        0UlmrtZbJ0RFKcHabwvlIrorNDnHsD+mP30sfmJthFHNXXL/jj7aWiVjK1dDQn6es0XIA/iH
        5ozEcudyeK1cvkARydKT7GrvrZSlhMk60JFmizEpZpI6h1IT5w4zZNZdebAhzKSIf3pfivJZ
        bHQ4ouHZfw7XdHofAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrMLMWRmVeSWpSXmKPExsVy+t/xu7rp1YaxBmfe6FpsnLGe1eJY2xN2
        i+bF69kslv69x2hx/vwGdovLu+awWcw4v4/JYtGyVmaLdRtvsVusPXIXqG7TFFYHbo+ds+6y
        eyze85LJY9OqTjaP/XPXsHv0bVnF6LFhyz8Wj8+b5ALYo/RsivJLS1IVMvKLS2yVog0tjPQM
        LS30jEws9QyNzWOtjEyV9O1sUlJzMstSi/TtEvQyDj57yVTQklbR8uo0awPjm6AuRk4OCQET
        iY77XWxdjFwcQgJLGSX2PvrPDJGQkTg5rYEVwhaW+HMNpugTo8SVF3PYQBJsAoYSXW+7wGwR
        ASeJzrWnwYqYBVqZJbp33ACbJCwQI7HnxiLGLkYODhYBVYl5z11BwrwCNhKHzx9hgVggL7F6
        wwHmCYw8CxgZVjGKpJYW56bnFhvqFSfmFpfmpesl5+duYgQG8LZjPzfvYLy0MfgQowAHoxIP
        b0CuQawQa2JZcWXuIUYJDmYlEd7bL/VjhXhTEiurUovy44tKc1KLDzGaAu2eyCwlmpwPjK68
        knhDU0NzC0tDc2NzYzMLJXHeDoGDMUIC6YklqdmpqQWpRTB9TBycUg2Mes37TlXtY/7+J+lu
        7cXWz8ffpR6Y6pekHMf1YEblor31rZrXZ89/5D77yEzlqrqZzpknWqu3nzGbzsibblPlOkl3
        +akX7wRmX1/64K+e7auMvcHes59J5zefSWa5+4HJ0Gdq9qspj/612XbcfcLFME3S6qmV6s3I
        K/eKss+lCZt8/3R//w/hYCWW4oxEQy3mouJEANd6Lj12AgAA
X-CMS-MailID: 20190719081224eucas1p1729ccaba8affe5a7ff65296519bcfe95
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190719081224eucas1p1729ccaba8affe5a7ff65296519bcfe95
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190719081224eucas1p1729ccaba8affe5a7ff65296519bcfe95
References: <CGME20190719081224eucas1p1729ccaba8affe5a7ff65296519bcfe95@eucas1p1.samsung.com>
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
v2:
- found that generic phys are already handled by usb hcd core code, so
  phy_calibration has been moved to drivers/usb/core/{hcd,phy}.c
- dropped custom xhci-exynos driver variant, no longer needed
- dropped passing custom properties from dwc3-exynos to generic dwc3
  core driver, no longer needed and mixing custom driver properties
  with DT-properties didn't work well (generic cleanup path caused
  oops in such case)

v1: 
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

