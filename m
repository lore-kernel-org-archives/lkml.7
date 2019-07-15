Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_SBL,URIBL_SBL_A,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 533BDC7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 12:19:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 086222080A
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 12:19:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="t/eIwVl0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730067AbfGOMTK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 08:19:10 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:40577 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729936AbfGOMTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 08:19:10 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190715121908euoutp0201a216d6590ed57e210c6367083012b1~xk_L3cj_g2457424574euoutp02F
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2019 12:19:08 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190715121908euoutp0201a216d6590ed57e210c6367083012b1~xk_L3cj_g2457424574euoutp02F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1563193148;
        bh=57h9RzxUQv6VOartLAt/iuIjEW9/L2uQK5HWDPGO77M=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=t/eIwVl0S5uKAPeKp6WZJqs/M2uuW5Vt1aBZ93RObtuKE+mZT0a3pO7mQzw9Vd/lF
         ZR8shISKgmbMPMz3Razg5bjY37ScA5kLKKDhFAFiUzu+ZcF6IaMcHyhHlWRGynzr20
         re7Xm3ccWbYUeg05vy1yCrGKW8+ZHeQi4c9Yp8SY=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190715121907eucas1p101134a12c6af0754d6eda423fe10a0b1~xk_LHN8s02974929749eucas1p1s;
        Mon, 15 Jul 2019 12:19:07 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 99.D1.04298.B3F6C2D5; Mon, 15
        Jul 2019 13:19:07 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190715121907eucas1p20469fd9deb997dd965ca3cf9de5de6f7~xk_KT-WFH2764427644eucas1p2z;
        Mon, 15 Jul 2019 12:19:07 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190715121906eusmtrp25ec778df45a1970a4c449da8a7d1613e~xk_KF4Max1138611386eusmtrp2K;
        Mon, 15 Jul 2019 12:19:06 +0000 (GMT)
X-AuditID: cbfec7f2-f2dff700000010ca-91-5d2c6f3bb066
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 0A.C3.04140.A3F6C2D5; Mon, 15
        Jul 2019 13:19:06 +0100 (BST)
Received: from [106.120.50.63] (unknown [106.120.50.63]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190715121906eusmtip13dad837a9d0925adbadde6f54848b7f8~xk_Jf7Fjz2823528235eusmtip1y;
        Mon, 15 Jul 2019 12:19:06 +0000 (GMT)
Subject: Re: [PATCH 0/3] Fix USB3.0 DRD PHY calibration issues (DWC3/XHCI)
 on Exynos542x SoCs
To:     Anand Moon <linux.amoon@gmail.com>
Cc:     Linux USB Mailing List <linux-usb@vger.kernel.org>,
        linux-samsung-soc@vger.kernel.org,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Felipe Balbi <balbi@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Jochen Sprickerhof <jochen@sprickerhof.de>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <7b9700b5-fe8b-8a15-e136-9a2afd1619ab@samsung.com>
Date:   Mon, 15 Jul 2019 14:19:04 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CANAwSgS2fQ_TvABeFzZ23GaeweKDEcAoKWJDMZ=p8vTd7BSp_A@mail.gmail.com>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA01SfSxVYRzuveece447V69L+SXTdpNN+dyU05Tpw9xVf2Trn5Tpcs9QvnYv
        SrZm+Vhuvqbm406ElPl244ophdDHEFGRlsZWctdGahjlOJT/nt/ze573eX7byxCyTsqaCYuM
        4dSRynC5WEIauhf6nDyjHANcU0vkbEN+HcV2p07SbFJZnZgtX/6E2P7+epodai0Us/n9T0Rs
        6f0Ugq1tGF2V6G9T3hJFi26cVpS1fRMp9JVpYkX7nWpakdlYiRT1jSukYk5ve5r2lxxSceFh
        cZzaxeuCJDQ5z0BFN/hfeZjxmE5E/Se0yIQB7A7VhXdILZIwMlyBoD0pVcQvZPgngmzjKQHP
        IShu8t4wPF/MWjc8QNBc1ICEwYigt31FzKsscCD0jg5QPLbE9vB2qoLiRQTOJSD7h57mF2Ls
        Blqjds0gxV7woWp09VmGIfEeWF7w5+lt+Dy0zKQTgsQcXhRMkjw2wX4wmXMP8ZjAu6DZWEgI
        2ApGJ4tFfBbgERq6SrtoofZx+Jg2QwrYAqZ7Gtd5G/jTsmFIQjDRV0MLQzqCoev5SFB5QmfP
        G4pvR2AHqGt1EegjUDQ2slYasBm8N5oLJcwgx5BHCLQUbqTKBLU96Hpq/8U+GxgkspFct+k0
        3aZzdJvO0f3PvYvISmTFxWoiQjiNWyR32VmjjNDERoY4B0dF6NHq13q10jP7CM0PBnUgzCC5
        qdRbtS9ARinjNPERHQgYQm4pPTy/SklVyvirnDoqUB0bzmk60E6GlFtJE7Z8PifDIcoY7hLH
        RXPqja2IMbFORHkFOX61VFXGMuVwIKugNOhiie+QT7Kru7bGYrztZHLh99mJHQleZ3N1vsE+
        LU9NPVWMp+H3cHn111+W5dPWS0seReNnrm09Zqmz2+24mBmWPzVm2G9NpfhWOthZHB0WVx30
        aAoWb6dsVLdkVJ8tChpqf/fFF3XHvrxpcHqtHB6Rk5pQpdteQq1R/gViUZtaVgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrKIsWRmVeSWpSXmKPExsVy+t/xu7pW+TqxBgceallsnLGe1eJY2xN2
        i+bF69kslv69x2hx/vwGdovLu+awWcw4v4/JYtGyVmaLdRtvAZVsmsLqwOWxc9Zddo/Fe14y
        eWxa1cnmsX/uGnaPvi2rGD02bPnH4vF5k1wAe5SeTVF+aUmqQkZ+cYmtUrShhZGeoaWFnpGJ
        pZ6hsXmslZGpkr6dTUpqTmZZapG+XYJeRsv0bawFG6MqNvfuZW9gPO/VxcjJISFgInH0Vz9L
        FyMXh5DAUkaJdyums0AkZCROTmtghbCFJf5c62IDsYUEXjNK9C3362Lk4BAWiJd4dDgfJCwi
        oCZx5ekKVpA5zAIzmCWenLsCNfQGo8Tj5hXMIFVsAoYSXW8hBvEK2EncXH2LBWQQi4CqxN+f
        USBhUYEYiX1ntrNDlAhKnJz5BOweToFAiSeTljCC2MwCZhLzNj9khrDlJba/nQNli0vcejKf
        aQKj0Cwk7bOQtMxC0jILScsCRpZVjCKppcW56bnFRnrFibnFpXnpesn5uZsYgVG67djPLTsY
        u94FH2IU4GBU4uF1SNGOFWJNLCuuzD3EKMHBrCTCa/sVKMSbklhZlVqUH19UmpNafIjRFOi3
        icxSosn5wASSVxJvaGpobmFpaG5sbmxmoSTO2yFwMEZIID2xJDU7NbUgtQimj4mDU6qB8cTS
        uuUb7oY/m/yPLfGbs+imf++0rqnkxmz8pxKa0Hl46nRrXTbOO1XNfHZCvNucGONPmfVIuTQJ
        vv5aNHfTkYdXGpa/DH7P0vZxy4GkfReOJUq9WJl/aWblZsEvRj8iI602v/jIedM6TEf3RsG3
        J8klf8KT5sxqrus6FKg3NfR0ea31x7eaH5VYijMSDbWYi4oTAYsYxHDoAgAA
X-CMS-MailID: 20190715121907eucas1p20469fd9deb997dd965ca3cf9de5de6f7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190627071741eucas1p1af1430c91f636c5766a76f7ef93019da
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190627071741eucas1p1af1430c91f636c5766a76f7ef93019da
References: <CGME20190627071741eucas1p1af1430c91f636c5766a76f7ef93019da@eucas1p1.samsung.com>
        <20190627071726.30467-1-m.szyprowski@samsung.com>
        <CANAwSgS2fQ_TvABeFzZ23GaeweKDEcAoKWJDMZ=p8vTd7BSp_A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anand,

On 2019-06-28 17:32, Anand Moon wrote:
> Hi Marek,
>
> On Thu, 27 Jun 2019 at 12:47, Marek Szyprowski <m.szyprowski@samsung.com> wrote:
>> Dear All,
>>
>> Commit d8c80bb3b55b ("phy: exynos5-usbdrd: Calibrate LOS levels for
>> exynos5420/5800") added support for Exynos5 USB3.0 DRD PHY calibration,
>> what enabled proper Super-Speed enumeration of USB3.0 devices connected
>> to various Exynos5 SoCs. After some time it turned out that the mentioned
>> patch worked a bit by pure luck and covered only one use case (fresh
>> boot with all drivers compiled into the kernel).
>>
>> If drivers were compiled as modules, due to timing issue, it worked only
>> if XHCI-plat driver was loaded before the DWC3 driver:
>> https://patchwork.kernel.org/patch/10773947/
>>
>> Also during the system suspend/resume cycle the calibration was not
>> performed at the proper time and resulted in switching USB 3.0 devices to
>> USB 2.0 high-speed compatibility mode.
>>
>> This patch addresses all those issues. Exynos5 USB3.0 DRD PHY calibration
>> is moved to the Exynos5 specific variant of the XHCI-plat driver, which
>> takes care of proper PHY calibration after XHCI core reset. This fixes
>> all known use cases (XHCI driver compiled as module and loaded on demand
>> as well as during system suspend/resume cycle).
>>
>> Here are the logs taken on Exynos5422-based Odroid HC1 board (with USB3.0
>> RTL8153 LAN and USB3.0 JMicron SATA-USB bridge):
>>
> Thanks for these patch. I have tested on linux-next-20190626
>
> *But hotpluging of usb device is not working on usb ports.*

Well, this is a bit poor report. I've checked various USB 3.0 devices 
with my XU4 board and didn't observe any issue with hotplug or 
enumeration. Could you describe a bit more how to trigger the issue?

> These patches fix the suspend/resume for XU4.
> But their is two issue.
> 1> On warm boot fails to reset the usb hub
> ------------------------------------------------------------------
> [    7.019896] usb 4-1.1: new SuperSpeed Gen 1 USB device number 3
> using xhci-hcd
> [    7.063032] usb 4-1.1: New USB device found, idVendor=152d,
> idProduct=0578, bcdDevice=63.01
> [    7.070484] usb 4-1.1: New USB device strings: Mfr=1, Product=2,
> SerialNumber=3
> [    7.077438] usb 4-1.1: Product: JMS567
> [    7.081749] usb 4-1.1: Manufacturer: JMicron
> [    7.086028] usb 4-1.1: SerialNumber: DB12345678A3
> [    7.151572] scsi host0: uas
> [    7.162765] scsi 0:0:0:0: Direct-Access     KINGSTON  SA400S37120G
>    6301 PQ: 0 ANSI: 6
> [    7.176231] sd 0:0:0:0: [sda] 234441648 512-byte logical blocks:
> (120 GB/112 GiB)
> [    7.177550] sd 0:0:0:0: Attached scsi generic sg0 type 0
> [    7.183547] sd 0:0:0:0: [sda] 4096-byte physical blocks
> [    7.201150] sd 0:0:0:0: [sda] Write Protect is off
> [    7.204977] sd 0:0:0:0: [sda] Disabling FUA
> [    7.209476] sd 0:0:0:0: [sda] Write cache: enabled, read cache:
> enabled, doesn't support DPO or FUA
> [    7.219411] sd 0:0:0:0: [sda] Optimal transfer size 33553920 bytes
> not a multiple of physical block size (4096 bytes)
> [    7.713603]  sda: sda1
> [    7.736338] sd 0:0:0:0: [sda] Attached SCSI disk
> [   11.372630] xhci-hcd exynos5-dwc3-xhci.5.auto: Timeout while
> waiting for setup device command
> [   16.650624] xhci-hcd exynos5-dwc3-xhci.5.auto: Timeout while
> waiting for setup device command
> [   16.870255] usb 6-1: device not accepting address 2, error -62
> [   22.171093] xhci-hcd exynos5-dwc3-xhci.5.auto: Timeout while
> waiting for setup device command
> [   27.451021] xhci-hcd exynos5-dwc3-xhci.5.auto: Timeout while
> waiting for setup device command
> [   27.669956] usb 6-1: device not accepting address 3, error -62
> [   27.711656] usb usb6-port1: attempt power cycle
>
> some how 12500000.phy do not de-register when we perform reboot.

Sorry, but this is not related to PHY at all. If I get your log right, 
you have external USB3->SATA bridge which fails to enumerate in your 
case. Does it work right with other boards or vendor kernels? You 
connect it to the XU4 onboard USB3.0 hub, which cannot be programmed or 
controlled in any way, so I doubt we can do anything to fix your issue.


> [  120.260813] shutdown[1]: All loop devices detached.
> [  120.308592] sd 0:0:0:0: [sda] Synchronizing SCSI cache
> [  120.425890] usb 4-1.1: reset SuperSpeed Gen 1 USB device number 3
> using xhci-hcd
> [  120.500085] wake enabled for irq 155
> [  120.592335] reboot: Restartin
>
> Attach are the reboot logs.
> [0] https://pastebin.com/a3d712q4
>
> Second issue is the unbind on usb dwc3 fails.
>
> [root@archl-xu4m ~]# cd /sys/bus/platform/drivers/exynos5_usb3drd_phy/
> [root@archl-xu4m exynos5_usb3drd_phy]# ls -la
> total 0
> drwxr-xr-x   2 root root    0 Jun 28 14:08 .
> drwxr-xr-x 131 root root    0 Jun 28 14:08 ..
> lrwxrwxrwx   1 root root    0 Jun 28 14:11 12100000.phy ->
> ../../../../devices/platform/soc/12100000.phy
> lrwxrwxrwx   1 root root    0 Jun 28 14:11 12500000.phy ->
> ../../../../devices/platform/soc/12500000.phy
> --w-------   1 root root 4096 Jun 28 14:11 bind
> --w-------   1 root root 4096 Jun 28 14:08 uevent
> --w-------   1 root root 4096 Jun 28 14:11 unbind
> [root@archl-xu4m exynos5_usb3drd_phy]#
> [root@archl-xu4m exynos5_usb3drd_phy]#
> [root@archl-xu4m exynos5_usb3drd_phy]# echo 12500000.phy > unbind

This is not dwc3 unbind, but USB3.0 DRD PHY unbind. This is somehow 
expected as unbinding on fly a device, which provides resources to other 
driver (in this case USB phys) causes various issues due to the Linux 
kernel frameworks design. Please don't try such things, it won't work. 
Exynos DRD PHY driver should be marked with suppress_bind flag to hide 
bind/unbind attributes.


> [  194.138492] ------------[ cut here ]------------
> [  194.142104] WARNING: CPU: 6 PID: 292 at
> drivers/regulator/core.c:2036 _regulator_put.part.4+0x110/0x118
> [  194.156913] Modules linked in: s5p_mfc s5p_jpeg exynos_gsc
> v4l2_mem2mem v4l2_common videobuf2_dma_contig videobuf2_memops
> videobuf2_v4l2 videobuf2_common videodev mc s5p_cec
> [  194.171542] CPU: 6 PID: 292 Comm: bash Not tainted
> 5.2.0-rc6-next-20190626-xu4ml #21
> [  194.178963] Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
> [  194.184983] [<c0112794>] (unwind_backtrace) from [<c010dfec>]
> (show_stack+0x10/0x14)
> [  194.192732] [<c010dfec>] (show_stack) from [<c0ab30c0>]
> (dump_stack+0x98/0xc4)
> [  194.199887] [<c0ab30c0>] (dump_stack) from [<c0127b78>]
> (__warn.part.3+0xbc/0xec)
> [  194.207332] [<c0127b78>] (__warn.part.3) from [<c0127d10>]
> (warn_slowpath_null+0x44/0x4c)
> [  194.215491] [<c0127d10>] (warn_slowpath_null) from [<c04f8f3c>]
> (_regulator_put.part.4+0x110/0x118)
> [  194.224518] [<c04f8f3c>] (_regulator_put.part.4) from [<c04f8f70>]
> (regulator_put+0x2c/0x3c)
> [  194.232916] [<c04f8f70>] (regulator_put) from [<c05b8eb8>]
> (release_nodes+0x1c0/0x204)
> [  194.240791] [<c05b8eb8>] (release_nodes) from [<c05b4f20>]
> (device_release_driver_internal+0xec/0x1ac)
> [  194.250086] [<c05b4f20>] (device_release_driver_internal) from
> [<c05b2d38>] (unbind_store+0x60/0xd4)
> [  194.259189] [<c05b2d38>] (unbind_store) from [<c03332dc>]
> (kernfs_fop_write+0x100/0x1e0)
> [  194.267232] [<c03332dc>] (kernfs_fop_write) from [<c02a2f60>]
> (__vfs_write+0x30/0x1c4)
> [  194.275110] [<c02a2f60>] (__vfs_write) from [<c02a5a74>]
> (vfs_write+0xa4/0x184)
> [  194.282376] [<c02a5a74>] (vfs_write) from [<c02a5ccc>] (ksys_write+0x5c/0xd4)
> [  194.289472] [<c02a5ccc>] (ksys_write) from [<c0101000>]
> (ret_fast_syscall+0x0/0x28)
> [  194.297103] Exception stack(0xe50fbfa8 to 0xe50fbff0)
> [  194.302074] bfa0:                   0000000d 0054a958 00000001
> 0054a958 0000000d 00000000
> [  194.310284] bfc0: 0000000d 0054a958 b6e7ebc8 00000004 0054a958
> 0000000d 00000000 00000000
> [  194.318424] bfe0: 00000070 be9e1868 b6da3c80 b6dff784
> [  194.323614] irq event stamp: 20491
> [  194.326920] hardirqs last  enabled at (20515): [<c0199aac>]
> console_unlock+0x440/0x64c
> [  194.334720] hardirqs last disabled at (20522): [<c0199714>]
> console_unlock+0xa8/0x64c
> [  194.342690] softirqs last  enabled at (20540): [<c0102544>]
> __do_softirq+0x35c/0x654
> [  194.350403] softirqs last disabled at (20553): [<c012fd80>]
> irq_exit+0x158/0x16c
> [  194.357782] ---[ end trace 5ea20768939447c5 ]---
> [  194.363628] ------------[ cut here ]------------
> [  194.367095] WARNING: CPU: 6 PID: 292 at
> drivers/regulator/core.c:2036 _regulator_put.part.4+0x110/0x118
> [  194.376360] Modules linked in: s5p_mfc s5p_jpeg exynos_gsc
> v4l2_mem2mem v4l2_common videobuf2_dma_contig videobuf2_memops
> videobuf2_v4l2 videobuf2_common videodev mc s5p_cec
> [  194.392067] CPU: 6 PID: 292 Comm: bash Tainted: G        W
> 5.2.0-rc6-next-20190626-xu4ml #21
> [  194.400882] Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
> [  194.406902] [<c0112794>] (unwind_backtrace) from [<c010dfec>]
> (show_stack+0x10/0x14)
> [  194.414647] [<c010dfec>] (show_stack) from [<c0ab30c0>]
> (dump_stack+0x98/0xc4)
> [  194.421825] [<c0ab30c0>] (dump_stack) from [<c0127b78>]
> (__warn.part.3+0xbc/0xec)
> [  194.429284] [<c0127b78>] (__warn.part.3) from [<c0127d10>]
> (warn_slowpath_null+0x44/0x4c)
> [  194.437441] [<c0127d10>] (warn_slowpath_null) from [<c04f8f3c>]
> (_regulator_put.part.4+0x110/0x118)
> [  194.446469] [<c04f8f3c>] (_regulator_put.part.4) from [<c04f8f70>]
> (regulator_put+0x2c/0x3c)
> [  194.454868] [<c04f8f70>] (regulator_put) from [<c05b8eb8>]
> (release_nodes+0x1c0/0x204)
> [  194.462743] [<c05b8eb8>] (release_nodes) from [<c05b4f20>]
> (device_release_driver_internal+0xec/0x1ac)
> [  194.472038] [<c05b4f20>] (device_release_driver_internal) from
> [<c05b2d38>] (unbind_store+0x60/0xd4)
> [  194.481135] [<c05b2d38>] (unbind_store) from [<c03332dc>]
> (kernfs_fop_write+0x100/0x1e0)
> [  194.489175] [<c03332dc>] (kernfs_fop_write) from [<c02a2f60>]
> (__vfs_write+0x30/0x1c4)
> [  194.497056] [<c02a2f60>] (__vfs_write) from [<c02a5a74>]
> (vfs_write+0xa4/0x184)
> [  194.504323] [<c02a5a74>] (vfs_write) from [<c02a5ccc>] (ksys_write+0x5c/0xd4)
> [  194.511417] [<c02a5ccc>] (ksys_write) from [<c0101000>]
> (ret_fast_syscall+0x0/0x28)
> [  194.519050] Exception stack(0xe50fbfa8 to 0xe50fbff0)
> [  194.524020] bfa0:                   0000000d 0054a958 00000001
> 0054a958 0000000d 00000000
> [  194.532231] bfc0: 0000000d 0054a958 b6e7ebc8 00000004 0054a958
> 0000000d 00000000 00000000
> [  194.540372] bfe0: 00000070 be9e1868 b6da3c80 b6dff784
> [  194.545640] irq event stamp: 20765
> [  194.548824] hardirqs last  enabled at (20785): [<c0199aac>]
> console_unlock+0x440/0x64c
> [  194.556794] hardirqs last disabled at (20802): [<c0199714>]
> console_unlock+0xa8/0x64c
> [  194.564468] softirqs last  enabled at (20800): [<c0102544>]
> __do_softirq+0x35c/0x654
> [  194.572329] softirqs last disabled at (20819): [<c012fd80>]
> irq_exit+0x158/0x16c
> [  194.579679] ---[ end trace 5ea20768939447c6 ]---
> [root@archl-xu4m exynos5_usb3drd_phy]#
>
> I saw the peripherals get on/off during suspend resume but on no
> regulator disable/enable calls.

There is no such need and the regulators are shared during runtime, so 
they will be on anyway.

> Attach are the logs
> [2] https://pastebin.com/uQT2EYgX

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

