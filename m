Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CAB0C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 18:29:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B764205ED
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 18:29:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G8e2t3GU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729699AbfGOS3k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 14:29:40 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:42226 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729413AbfGOS3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 14:29:39 -0400
Received: by mail-ed1-f66.google.com with SMTP id v15so16443761eds.9;
        Mon, 15 Jul 2019 11:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0X1xWUDisNrQkHHS+wT5XXw2/LuKVAjvvac2sZ0xEs4=;
        b=G8e2t3GUyh4I/ptj2KFL+QUj+yO2aSKfbM/hyToU+aKZv0FfCThy0d6iDf8dnwe38x
         ue7OxrOy7/4tQZ//abWY75uFWXeStsqHJeV4tT1NOh4JSDeNEMx0pS7fMUFtQKuVu9qb
         41xkyKf4NYdpKFVfFMVavWcJowFEXPUr6k9MKGrrtyTalbAv05gl/bf/ycyhEPPnBssb
         vcWvt/G9WjmPUwfYrXwkvxj0WGVFfQVd95ijnGaGSDfqqLGGNd7g8Gtw12RROjbS4LFp
         NY3xh6Ogg8HCHefeeMcLBDR7FyzdANmMKBncOVjufDUgKukDJL0TxKQjAVSfO5xu4MU7
         qgPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0X1xWUDisNrQkHHS+wT5XXw2/LuKVAjvvac2sZ0xEs4=;
        b=gFy+7eOYBZaImknjKH6jWrmHPaRxi/kvoIrjVzeMij7vvJXjDOf3FjhIEAufQDTJDI
         xNUTyISQ3cNNUSweHwKUc5LbgBzfCijoNAUmI6ZR5gJYO0Zl/amnxngl1mDtRE6fKO3F
         uS388OvTZ9qx7LcMP94NqEQmwcPnMgqDnWdtCxjrz/MEMizeGlNqjnwLzCPsJ1sryGP0
         1Ph65tot1WnkN7qzYmDPnafU7me86joYKNer3ywCuxQTjUsZ4G7iZ2O+NbPcyGyl/GYQ
         tfIFBzwCwPBwHJRlyI7NPdNDL1uHx/ERnkbpHsvLtTWX6ehw5mot/x37Ek6btu9USafA
         EMWA==
X-Gm-Message-State: APjAAAW7W9R7/32oDU/8wIUuJWLQDuw06mnnfAsk4GNnUJGlSRdCMLf4
        XIjKuG1/+5bdxChG2sPXt14qCczAQjPCDDs+eGs=
X-Google-Smtp-Source: APXvYqzO5JOzxMM32oyapsqOmZUhzdJk/hRN6qw1zV7PZnN7U/H+4ATH7jnMWnTxif4P200cgUnj78ctrbtYj2/cobM=
X-Received: by 2002:a05:6402:145a:: with SMTP id d26mr24860170edx.10.1563215376896;
 Mon, 15 Jul 2019 11:29:36 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20190627071741eucas1p1af1430c91f636c5766a76f7ef93019da@eucas1p1.samsung.com>
 <20190627071726.30467-1-m.szyprowski@samsung.com> <CANAwSgS2fQ_TvABeFzZ23GaeweKDEcAoKWJDMZ=p8vTd7BSp_A@mail.gmail.com>
 <7b9700b5-fe8b-8a15-e136-9a2afd1619ab@samsung.com>
In-Reply-To: <7b9700b5-fe8b-8a15-e136-9a2afd1619ab@samsung.com>
From:   Anand Moon <linux.amoon@gmail.com>
Date:   Mon, 15 Jul 2019 23:59:26 +0530
Message-ID: <CANAwSgQuBVYPBHT0yhBMsK_1y8qKno81yDGq6rm4Q7SVhkw=8A@mail.gmail.com>
Subject: Re: [PATCH 0/3] Fix USB3.0 DRD PHY calibration issues (DWC3/XHCI) on
 Exynos542x SoCs
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Linux USB Mailing List <linux-usb@vger.kernel.org>,
        linux-samsung-soc@vger.kernel.org,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Felipe Balbi <balbi@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Jochen Sprickerhof <jochen@sprickerhof.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marek,

On Mon, 15 Jul 2019 at 17:49, Marek Szyprowski <m.szyprowski@samsung.com> wrote:
>
> Hi Anand,
>
> On 2019-06-28 17:32, Anand Moon wrote:
> > Hi Marek,
> >
> > On Thu, 27 Jun 2019 at 12:47, Marek Szyprowski <m.szyprowski@samsung.com> wrote:
> >> Dear All,
> >>
> >> Commit d8c80bb3b55b ("phy: exynos5-usbdrd: Calibrate LOS levels for
> >> exynos5420/5800") added support for Exynos5 USB3.0 DRD PHY calibration,
> >> what enabled proper Super-Speed enumeration of USB3.0 devices connected
> >> to various Exynos5 SoCs. After some time it turned out that the mentioned
> >> patch worked a bit by pure luck and covered only one use case (fresh
> >> boot with all drivers compiled into the kernel).
> >>
> >> If drivers were compiled as modules, due to timing issue, it worked only
> >> if XHCI-plat driver was loaded before the DWC3 driver:
> >> https://patchwork.kernel.org/patch/10773947/
> >>
> >> Also during the system suspend/resume cycle the calibration was not
> >> performed at the proper time and resulted in switching USB 3.0 devices to
> >> USB 2.0 high-speed compatibility mode.
> >>
> >> This patch addresses all those issues. Exynos5 USB3.0 DRD PHY calibration
> >> is moved to the Exynos5 specific variant of the XHCI-plat driver, which
> >> takes care of proper PHY calibration after XHCI core reset. This fixes
> >> all known use cases (XHCI driver compiled as module and loaded on demand
> >> as well as during system suspend/resume cycle).
> >>
> >> Here are the logs taken on Exynos5422-based Odroid HC1 board (with USB3.0
> >> RTL8153 LAN and USB3.0 JMicron SATA-USB bridge):
> >>
> > Thanks for these patch. I have tested on linux-next-20190626
> >
> > *But hotpluging of usb device is not working on usb ports.*
>
> Well, this is a bit poor report. I've checked various USB 3.0 devices
> with my XU4 board and didn't observe any issue with hotplug or
> enumeration. Could you describe a bit more how to trigger the issue?
>

Sorry for the noise one of my usb 3.0 port on XU4 is not working somehow.
I will re-test these patches again on current next and share my result.

> > These patches fix the suspend/resume for XU4.
> > But their is two issue.
> > 1> On warm boot fails to reset the usb hub
> > ------------------------------------------------------------------
> > [    7.019896] usb 4-1.1: new SuperSpeed Gen 1 USB device number 3
> > using xhci-hcd
> > [    7.063032] usb 4-1.1: New USB device found, idVendor=152d,
> > idProduct=0578, bcdDevice=63.01
> > [    7.070484] usb 4-1.1: New USB device strings: Mfr=1, Product=2,
> > SerialNumber=3
> > [    7.077438] usb 4-1.1: Product: JMS567
> > [    7.081749] usb 4-1.1: Manufacturer: JMicron
> > [    7.086028] usb 4-1.1: SerialNumber: DB12345678A3
> > [    7.151572] scsi host0: uas
> > [    7.162765] scsi 0:0:0:0: Direct-Access     KINGSTON  SA400S37120G
> >    6301 PQ: 0 ANSI: 6
> > [    7.176231] sd 0:0:0:0: [sda] 234441648 512-byte logical blocks:
> > (120 GB/112 GiB)
> > [    7.177550] sd 0:0:0:0: Attached scsi generic sg0 type 0
> > [    7.183547] sd 0:0:0:0: [sda] 4096-byte physical blocks
> > [    7.201150] sd 0:0:0:0: [sda] Write Protect is off
> > [    7.204977] sd 0:0:0:0: [sda] Disabling FUA
> > [    7.209476] sd 0:0:0:0: [sda] Write cache: enabled, read cache:
> > enabled, doesn't support DPO or FUA
> > [    7.219411] sd 0:0:0:0: [sda] Optimal transfer size 33553920 bytes
> > not a multiple of physical block size (4096 bytes)
> > [    7.713603]  sda: sda1
> > [    7.736338] sd 0:0:0:0: [sda] Attached SCSI disk
> > [   11.372630] xhci-hcd exynos5-dwc3-xhci.5.auto: Timeout while
> > waiting for setup device command
> > [   16.650624] xhci-hcd exynos5-dwc3-xhci.5.auto: Timeout while
> > waiting for setup device command
> > [   16.870255] usb 6-1: device not accepting address 2, error -62
> > [   22.171093] xhci-hcd exynos5-dwc3-xhci.5.auto: Timeout while
> > waiting for setup device command
> > [   27.451021] xhci-hcd exynos5-dwc3-xhci.5.auto: Timeout while
> > waiting for setup device command
> > [   27.669956] usb 6-1: device not accepting address 3, error -62
> > [   27.711656] usb usb6-port1: attempt power cycle
> >
> > some how 12500000.phy do not de-register when we perform reboot.
>
> Sorry, but this is not related to PHY at all. If I get your log right,
> you have external USB3->SATA bridge which fails to enumerate in your
> case. Does it work right with other boards or vendor kernels? You
> connect it to the XU4 onboard USB3.0 hub, which cannot be programmed or
> controlled in any way, so I doubt we can do anything to fix your issue.
>

Sorry this issue is related to realtek ethernet driver r-8153 failed
to register again
after reboot. It's a know issue for long time as far as I know,
I will double check this again.

>
> > [  120.260813] shutdown[1]: All loop devices detached.
> > [  120.308592] sd 0:0:0:0: [sda] Synchronizing SCSI cache
> > [  120.425890] usb 4-1.1: reset SuperSpeed Gen 1 USB device number 3
> > using xhci-hcd
> > [  120.500085] wake enabled for irq 155
> > [  120.592335] reboot: Restartin
> >
> > Attach are the reboot logs.
> > [0] https://pastebin.com/a3d712q4
> >
> > Second issue is the unbind on usb dwc3 fails.
> >
> > [root@archl-xu4m ~]# cd /sys/bus/platform/drivers/exynos5_usb3drd_phy/
> > [root@archl-xu4m exynos5_usb3drd_phy]# ls -la
> > total 0
> > drwxr-xr-x   2 root root    0 Jun 28 14:08 .
> > drwxr-xr-x 131 root root    0 Jun 28 14:08 ..
> > lrwxrwxrwx   1 root root    0 Jun 28 14:11 12100000.phy ->
> > ../../../../devices/platform/soc/12100000.phy
> > lrwxrwxrwx   1 root root    0 Jun 28 14:11 12500000.phy ->
> > ../../../../devices/platform/soc/12500000.phy
> > --w-------   1 root root 4096 Jun 28 14:11 bind
> > --w-------   1 root root 4096 Jun 28 14:08 uevent
> > --w-------   1 root root 4096 Jun 28 14:11 unbind
> > [root@archl-xu4m exynos5_usb3drd_phy]#
> > [root@archl-xu4m exynos5_usb3drd_phy]#
> > [root@archl-xu4m exynos5_usb3drd_phy]# echo 12500000.phy > unbind
>
> This is not dwc3 unbind, but USB3.0 DRD PHY unbind. This is somehow
> expected as unbinding on fly a device, which provides resources to other
> driver (in this case USB phys) causes various issues due to the Linux
> kernel frameworks design. Please don't try such things, it won't work.
> Exynos DRD PHY driver should be marked with suppress_bind flag to hide
> bind/unbind attributes.
>

Ok thanks for your inputs and suggestion.

> Best regards
> --
> Marek Szyprowski, PhD
> Samsung R&D Institute Poland
>

Best Regards


-Anand
