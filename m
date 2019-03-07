Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21AC7C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 14:58:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFD522081B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 14:58:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726351AbfCGO6v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 09:58:51 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:39178 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726170AbfCGO6u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 09:58:50 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id B6D194D8C1793213A8CF;
        Thu,  7 Mar 2019 22:58:47 +0800 (CST)
Received: from [127.0.0.1] (10.202.227.238) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.408.0; Thu, 7 Mar 2019
 22:58:42 +0800
Subject: Re: [PATCH/RFC] driver core: Postpone DMA tear-down until after
 devres release
To:     Robin Murphy <robin.murphy@arm.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
References: <20190207193653.18221-1-geert+renesas@glider.be>
 <20190208164019.GY32526@8bytes.org>
 <fa781547-7fa8-cb1a-50bd-d18351c02afd@arm.com>
 <CAMuHMdV6T8EsLZaiM-=M=fRPuDXt05aXg6egmMBr6Sc9V39iKA@mail.gmail.com>
 <6e64e564-aa6c-4193-1f57-ebf88d6932d5@arm.com>
 <1b24a2dc-e9a3-f293-8dd1-360896a554e6@huawei.com>
 <ebc665cc-31c5-4ecd-6c48-6d14962b1f0c@arm.com>
CC:     Geert Uytterhoeven <geert+renesas@glider.be>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Joerg Roedel" <joro@8bytes.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux IOMMU <iommu@lists.linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <3915df7f-1028-6caf-c99c-6b787e0d1060@huawei.com>
Date:   Thu, 7 Mar 2019 14:58:35 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <ebc665cc-31c5-4ecd-6c48-6d14962b1f0c@arm.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.238]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/03/2019 14:52, Robin Murphy wrote:
> Hi John,

Hi Robin,

ok, fine.

It's a pain bisecting another rmmod issue with it...

Cheers,

>
> On 07/03/2019 14:45, John Garry wrote:
> [...]
>> Hi guys,
>>
>> Any idea what happened to this fix?
>
> It's been in -next for a while (commit 376991db4b64) - I assume it will
> land shortly and hit stable thereafter, at which point somebody gets to
> sort out the manual backport past 4.20.
>
> Robin.
>
>> I have this on 5.0:
>>
>> [    0.000000] Linux version 5.0.0 (john@htsatcamb-server) (gcc
>> version 4.8.5 (Linaro GCC 4.8-2015.06)) #121 SMP PREEMPT Thu Mar 7
>> 14:28:39 GMT 2019
>> [    0.000000] Kernel command line: BOOT_IMAGE=/john/Image
>> rdinit=/init crashkernel=256M@32M earlycon console=ttyAMA0,115200
>> acpi=force pcie_aspm=off scsi_mod.use_blk_mq=y no_console_suspend
>> pcie-hisi.disable=1
>>
>> ...
>>
>> [   26.806856] pci_bus 000c:20: 2-byte config write to 000c:20:00.0
>> offset 0x44 may corrupt adjacent RW1C bits
>> [   26.817521] pcieport 0002:f8:00.0: can't derive routing for PCI INT B
>> [   26.837167] pci_bus 000c:20: 2-byte config write to 000c:20:00.0
>> offset 0x44 may corrupt adjacent RW1C bits
>> [   26.850091] serial 0002:f9:00.1: PCI INT B: no GSI
>> [   26.879364] serial 0002:f9:00.1: enabling device (0000 -> 0003)
>> [   26.913131] 0002:f9:00.1: ttyS3 at I/O 0x1008 (irq = 0, base_baud =
>> 115200) is a ST16650V2
>> [   26.992897] rtc-efi rtc-efi: setting system clock to
>> 2019-03-07T14:41:48 UTC (1551969708)
>> [   27.009380] ALSA device list:
>> [   27.015326]   No soundcards found.
>> [   27.022549] Freeing unused kernel memory: 1216K
>> [   27.055567] Run /init as init process
>> root@(none)$ cd /sys/devices/platform/HISI0162:01
>> root@(none)$ echo HISI0162:01 > driver/unbind
>> [   36.488040] hisi_sas_v2_hw HISI0162:01: dev[9:1] is gone
>> [   36.561077] hisi_sas_v2_hw HISI0162:01: dev[8:1] is gone
>> [   36.621061] hisi_sas_v2_hw HISI0162:01: dev[7:1] is gone
>> [   36.693074] hisi_sas_v2_hw HISI0162:01: dev[6:1] is gone
>> [   36.753066] hisi_sas_v2_hw HISI0162:01: dev[5:1] is gone
>> [   36.764276] sd 0:0:3:0: [sdd] Synchronizing SCSI cache
>> [   36.821106] hisi_sas_v2_hw HISI0162:01: dev[4:1] is gone
>> [   36.889048] hisi_sas_v2_hw HISI0162:01: dev[3:1] is gone
>> [   36.993002] hisi_sas_v2_hw HISI0162:01: dev[1:1] is gone
>> [   37.004276] sd 0:0:0:0: [sda] Synchronizing SCSI cache
>> [   37.014768] sd 0:0:0:0: [sda] Stopping disk
>> [   37.709094] hisi_sas_v2_hw HISI0162:01: dev[2:5] is gone
>> [   37.721231] hisi_sas_v2_hw HISI0162:01: dev[0:2] is gone
>> [   37.803774] BUG: Bad page state in process sh  pfn:11356
>> [   37.814444] page:ffff7e000044d580 count:1 mapcount:0
>> mapping:0000000000000000 index:0x0
>> [   37.830525] flags: 0xfffc00000001000(reserved)
>> [   37.839443] raw: 0fffc00000001000 ffff7e000044d588 ffff7e000044d588
>> 0000000000000000
>> [   37.854998] raw: 0000000000000000 0000000000000000 00000001ffffffff
>> 0000000000000000
>> [   37.870552] page dumped because: PAGE_FLAGS_CHECK_AT_FREE flag(s) set
>> [   37.883485] bad because of flags: 0x1000(reserved)
>> [   37.893098] Modules linked in:
>> [   37.899221] CPU: 5 PID: 2691 Comm: sh Not tainted 5.0.0 #121
>> [   37.910578] Hardware name: Huawei Taishan 2280 /D05, BIOS Hisilicon
>> D05 IT21 Nemo 2.0 RC0 04/18/2018
>> [   37.928924] Call trace:
>> [   37.933825]  dump_backtrace+0x0/0x150
>> [   37.941166]  show_stack+0x14/0x1c
>> [   37.947808]  dump_stack+0x8c/0xb0
>> [   37.954451]  bad_page+0xe4/0x144
>> [   37.960918]  free_pages_check_bad+0x7c/0x84
>> [   37.969307]  __free_pages_ok+0x284/0x290
>> [   37.977173]  __free_pages+0x30/0x44
>> [   37.984163]  __dma_direct_free_pages+0x68/0x6c
>> [   37.993076]  dma_direct_free+0x24/0x38
>> [   38.000591]  dma_free_attrs+0x84/0xc0
>> [   38.007930]  dmam_release+0x20/0x28
>> [   38.014924]  release_nodes+0x128/0x1f8
>> [   38.022439]  devres_release_all+0x34/0x4c
>> [   38.030478]  device_release_driver_internal+0x190/0x208
>> [   38.040963]  device_release_driver+0x14/0x1c
>> [   38.049526]  unbind_store+0xbc/0xf4
>> [   38.056517]  drv_attr_store+0x20/0x30
>> [   38.063859]  sysfs_kf_write+0x44/0x4c
>> [   38.071200]  kernfs_fop_write+0xd0/0x1c4
>> [   38.079065]  __vfs_write+0x2c/0x158
>> [   38.086055]  vfs_write+0xa8/0x19c
>> [   38.092696]  ksys_write+0x44/0xa0
>> [   38.099338]  __arm64_sys_write+0x1c/0x24
>> [   38.107203]  el0_svc_common+0xb0/0x100
>> [   38.114718]  el0_svc_handler+0x70/0x88
>> [   38.122232]  el0_svc+0x8/0x7c0
>> [   38.128356] Disabling lock debugging due to kernel taint
>> [   38.139019] BUG: Bad page state in process sh  pfn:11355
>> [   38.149682] page:ffff7e000044d540 count:0 mapcount:0
>> mapping:0000000000000000 index:0x0
>> [   38.165760] flags: 0xfffc00000001000(reserved)
>> [   38.174676] raw: 0fffc00000001000 ffff7e000044d548 ffff7e000044d548
>> 0000000000000000
>> [   38.190230] raw: 0000000000000000 0000000000000000 00000000ffffffff
>> 0000000000000000
>> [   38.205783] page dumped because: PAGE_FLAGS_CHECK_AT_FREE flag(s) set
>> [   38.218716] bad because of flags: 0x1000(reserved)
>> [   38.228329] Modules linked in:
>> [   38.234451] CPU: 5 PID: 2691 Comm: sh Tainted: G    B 5.0.0 #121
>> [   38.248604] Hardware name: Huawei Taishan 2280 /D05, BIOS Hisilicon
>> D05 IT21 Nemo 2.0 RC0 04/18/2018
>> [   38.266949] Call trace:
>> [   38.271844]  dump_backtrace+0x0/0x150
>> [   38.279185]  show_stack+0x14/0x1c
>> [   38.285826]  dump_stack+0x8c/0xb0
>> [   38.292468]  bad_page+0xe4/0x144
>> [   38.298936]  free_pages_check_bad+0x7c/0x84
>>
>> ...
>>
>> Thanks,
>> John
>>
>>> Thanks,
>>> Robin.
>>>
>>>>> There aren't many drivers using dmam_alloc_*(), let alone which would
>>>>> also find themselves behind an IOMMU on an Arm system, but it turns
>>>>> out
>>>>> I actually have another one which can reproduce the BUG() with 5.0-rc.
>>>>
>>>> SATA core uses dmam_alloc_*().
>>>>
>>>>> I've tried a 4.12 kernel with a bit of instrumentation[1] and sure
>>>>> enough the devres-managed buffer is freed with the wrong ops[2] even
>>>>> then. How it manages not to blow up more catastrophically I have no
>>>>> idea... I guess at best it just leaks the buffers and IOMMU mappings,
>>>>> and at worst quietly frees random other pages instead.
>>>>
>>>> May depend on the actual ops, and whether CMA is used or not.
>>>>
>>>> Gr{oetje,eeting}s,
>>>>
>>>>                          Geert
>>>>
>>>
>>> _______________________________________________
>>> linux-arm-kernel mailing list
>>> linux-arm-kernel@lists.infradead.org
>>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>>>
>>> .
>>>
>>
>>
>
> .
>


