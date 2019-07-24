Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 207CDC76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 03:34:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4B9022387
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 03:34:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726329AbfGXDeS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 23:34:18 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:36722 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725837AbfGXDeR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 23:34:17 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id D835D938FA22A3FE94C0;
        Wed, 24 Jul 2019 11:34:12 +0800 (CST)
Received: from [127.0.0.1] (10.184.12.158) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.439.0; Wed, 24 Jul 2019
 11:34:04 +0800
Subject: Re: [RFC PATCH] fbcon: fix ypos over boundary issue
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
CC:     <dri-devel@lists.freedesktop.org>, <linux-fbdev@vger.kernel.org>,
        <daniel.vetter@ffwll.ch>, <maarten.lankhorst@linux.intel.com>,
        <sam@ravnborg.org>, <linux-kernel@vger.kernel.org>,
        <wanghaibin.wang@huawei.com>, <zhang.zhanghailiang@huawei.com>,
        <yezengruan@huawei.com>, Feng Tiantian <fengtiantian@huawei.com>
References: <CGME20190712031440epcas2p1bf80bc306291973284f44a8e8085c66f@epcas2p1.samsung.com>
 <1562901216-9916-1-git-send-email-yuzenghui@huawei.com>
 <21374295-251c-e101-eaac-b86fffdb93ec@samsung.com>
From:   Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <bb2c7692-eccc-c034-dfb6-b20712e273a1@huawei.com>
Date:   Wed, 24 Jul 2019 11:33:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:64.0) Gecko/20100101
 Thunderbird/64.0
MIME-Version: 1.0
In-Reply-To: <21374295-251c-e101-eaac-b86fffdb93ec@samsung.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.184.12.158]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bartlomiej,

On 2019/7/23 23:59, Bartlomiej Zolnierkiewicz wrote:
> 
> On 7/12/19 5:13 AM, Zenghui Yu wrote:
>> From: Feng Tiantian <fengtiantian@huawei.com>
>>
>> While using "top" on a CentOS guest's VNC-client, then continuously press
>> "Shift+PgUp", the guest kernel will get panic! Backtrace is attached below.
>> We tested it on 5.2.0, and the issue remains.
>>
>> [   66.946362] Unable to handle kernel paging request at virtual address ffff00000e240840
>> [   66.946363] Mem abort info:
>> [   66.946364]   Exception class = DABT (current EL), IL = 32 bits
>> [   66.946365]   SET = 0, FnV = 0
>> [   66.946366]   EA = 0, S1PTW = 0
>> [   66.946367] Data abort info:
>> [   66.946368]   ISV = 0, ISS = 0x00000047
>> [   66.946368]   CM = 0, WnR = 1
>> [   66.946370] swapper pgtable: 64k pages, 48-bit VAs, pgd = ffff000009660000
>> [   66.946372] [ffff00000e240840] *pgd=000000023ffe0003, *pud=000000023ffe0003, *pmd=000000023ffd0003, *pte=0000000000000000
>> [   66.946378] Internal error: Oops: 96000047 [#1] SMP
>> [   66.946379] Modules linked in: vfat fat crc32_ce ghash_ce sg sha2_ce sha256_arm64 virtio_balloon virtio_net sha1_ce ip_tables ext4 mbcache jbd2 virtio_gpu drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops ttm drm i2c_core virtio_scsi virtio_pci virtio_mmio virtio_ring virtio
>> [   66.946403] CPU: 0 PID: 1035 Comm: top Not tainted 4.14.0-49.el7a.aarch64 #1
>> [   66.946404] Hardware name: QEMU KVM Virtual Machine, BIOS 0.0.0 02/06/2015
>> [   66.946405] task: ffff8001c18fdc00 task.stack: ffff00000d4e0000
>> [   66.946409] PC is at sys_imageblit+0x40c/0x10000 [sysimgblt]
>> [   66.946431] LR is at drm_fb_helper_sys_imageblit+0x28/0x4c [drm_kms_helper]
>> [   66.946433] pc : [<ffff0000020a040c>] lr : [<ffff000002202e74>] pstate: 00000005
>> [   66.946433] sp : ffff00000d4ef7f0
>> [   66.946434] x29: ffff00000d4ef7f0 x28: 00000000000001ff
>> [   66.946436] x27: ffff8001c1c88100 x26: 0000000000000001
>> [   66.946438] x25: 00000000000001f0 x24: 0000000000000018
>> [   66.946440] x23: 0000000000000000 x22: ffff00000d4ef978
>> [   66.946442] x21: ffff00000e240840 x20: 0000000000000000
>> [   66.946444] x19: ffff8001c98c9000 x18: 0000fffff9d56670
>> [   66.946445] x17: 0000000000000000 x16: 0000000000000000
>> [   66.946447] x15: 0000000000000008 x14: 1b20202020202020
>> [   66.946449] x13: 00000000000001f0 x12: 000000000000003e
>> [   66.946450] x11: 000000000000000f x10: ffff8001c8400000
>> [   66.946452] x9 : 0000000000aaaaaa x8 : 0000000000000001
>> [   66.946454] x7 : ffff0000020b0090 x6 : 0000000000000001
>> [   66.946456] x5 : 0000000000000000 x4 : 0000000000000000
>> [   66.946457] x3 : ffff8001c8400000 x2 : ffff00000e240840
>> [   66.946459] x1 : 00000000000001ef x0 : 0000000000000007
>> [   66.946461] Process top (pid: 1035, stack limit = 0xffff00000d4e0000)
>> [   66.946462] Call trace:
>> [   66.946464] Exception stack(0xffff00000d4ef6b0 to 0xffff00000d4ef7f0)
>> [   66.946465] f6a0:                                   0000000000000007 00000000000001ef
>> [   66.946467] f6c0: ffff00000e240840 ffff8001c8400000 0000000000000000 0000000000000000
>> [   66.946468] f6e0: 0000000000000001 ffff0000020b0090 0000000000000001 0000000000aaaaaa
>> [   66.946470] f700: ffff8001c8400000 000000000000000f 000000000000003e 00000000000001f0
>> [   66.946471] f720: 1b20202020202020 0000000000000008 0000000000000000 0000000000000000
>> [   66.946472] f740: 0000fffff9d56670 ffff8001c98c9000 0000000000000000 ffff00000e240840
>> [   66.946474] f760: ffff00000d4ef978 0000000000000000 0000000000000018 00000000000001f0
>> [   66.946475] f780: 0000000000000001 ffff8001c1c88100 00000000000001ff ffff00000d4ef7f0
>> [   66.946476] f7a0: ffff000002202e74 ffff00000d4ef7f0 ffff0000020a040c 0000000000000005
>> [   66.946478] f7c0: ffff00000d4ef7e0 ffff0000080ea614 0001000000000000 ffff000008152f08
>> [   66.946479] f7e0: ffff00000d4ef7f0 ffff0000020a040c
>> [   66.946481] [<ffff0000020a040c>] sys_imageblit+0x40c/0x10000 [sysimgblt]
>> [   66.946501] [<ffff000002202e74>] drm_fb_helper_sys_imageblit+0x28/0x4c [drm_kms_helper]
>> [   66.946510] [<ffff0000022a12dc>] virtio_gpu_3d_imageblit+0x2c/0x78 [virtio_gpu]
>> [   66.946515] [<ffff00000847f458>] bit_putcs+0x288/0x49c
>> [   66.946517] [<ffff00000847ad24>] fbcon_putcs+0x114/0x148
>> [   66.946519] [<ffff0000084fe92c>] do_update_region+0x118/0x19c
>> [   66.946521] [<ffff00000850413c>] do_con_trol+0x114c/0x1314
>> [   66.946523] [<ffff0000085044dc>] do_con_write.part.22+0x1d8/0x890
>> [   66.946525] [<ffff000008504c88>] con_write+0x84/0x8c
>> [   66.946527] [<ffff0000084ec7f0>] n_tty_write+0x19c/0x408
>> [   66.946529] [<ffff0000084e9120>] tty_write+0x150/0x270
>> [   66.946532] [<ffff00000829d558>] __vfs_write+0x58/0x180
>> [   66.946534] [<ffff00000829d880>] vfs_write+0xa8/0x1a0
>> [   66.946536] [<ffff00000829db40>] SyS_write+0x60/0xc0
>> [   66.946537] Exception stack(0xffff00000d4efec0 to 0xffff00000d4f0000)
>> [   66.946539] fec0: 0000000000000001 0000000000457958 0000000000000800 0000000000000000
>> [   66.946540] fee0: 00000000fbad2885 0000000000000bd0 0000ffff8556add4 0000000000000000
>> [   66.946541] ff00: 0000000000000040 0000000000000000 0000000000434a88 0000000000000012
>> [   66.946543] ff20: 0000000100000000 0000fffff9d564f0 0000fffff9d564a0 0000000000000008
>> [   66.946544] ff40: 0000000000000000 0000ffff85593b1c 0000fffff9d56670 0000000000000800
>> [   66.946546] ff60: 0000000000457958 0000ffff856a1158 0000000000000800 0000ffff85720000
>> [   66.946547] ff80: 0000000000000000 0000ffff856f604c 0000000000000000 0000000000436000
>> [   66.946548] ffa0: 000000001c90a160 0000fffff9d56f20 0000ffff855965f4 0000fffff9d56f20
>> [   66.946549] ffc0: 0000ffff855f12c8 0000000020000000 0000000000000001 0000000000000040
>> [   66.946551] ffe0: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
>> [   66.946554] [<ffff00000808359c>] __sys_trace_return+0x0/0x4
>> [   66.946556] Code: 0a080084 b86478e4 0a040124 4a050084 (b9000044)
>> [   66.946561] ---[ end trace 32d49c68b19c4796 ]---
>> [   66.946562] Kernel panic - not syncing: Fatal exception
>> [   66.946564] SMP: stopping secondary CPUs
>> [   66.946596] Kernel Offset: disabled
>> [   66.946598] CPU features: 0x1802008
>> [   66.946598] Memory Limit: none
>> [   67.092353] ---[ end Kernel panic - not syncing: Fatal exception
>>
>> >From our non-expert analysis, fbcon ypos will sometimes over boundary and
>> then fbcon_putcs() access invalid VGA framebuffer address. We modify the
>> real_y() to make sure fbcon ypos is always less than rows.
>>
>> Reported-by: Zengruan Ye <yezengruan@huawei.com>
>> Signed-off-by: Feng Tiantian <fengtiantian@huawei.com>
>> Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
>> ---
>>
>> Hi Bartlomiej,
> 
> Hi Zenghui,
> 
>> Zengruan had reported this issue [1] but received no reply. Does it make
> 
> Sorry about that (at that time it seemed like a workaround for DRM issue
> so I have not followed it further).
> 
>> sense to fix this issue? Could you please take a look into this patch?
> 
> It looks fine to me. I'll queue it for v5.4 on Friday (if there are
> no issues raised by reviewers by then).

Thanks for your reviewing!

>>
>> [1] https://lkml.org/lkml/2018/11/27/639
>>
>>   drivers/video/fbdev/core/fbcon.h | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/video/fbdev/core/fbcon.h b/drivers/video/fbdev/core/fbcon.h
>> index 20dea85..b1aa00e 100644
>> --- a/drivers/video/fbdev/core/fbcon.h
>> +++ b/drivers/video/fbdev/core/fbcon.h
>> @@ -230,7 +230,10 @@ static inline int real_y(struct fbcon_display *p, int ypos)
>>   	int rows = p->vrows;
>>   
>>   	ypos += p->yscroll;
>> -	return ypos < rows ? ypos : ypos - rows;
>> +	if (rows == 0)
>> +		return ypos;
>> +	else
>> +		return ypos < rows ? ypos : ypos % rows;
>>   }

This diff might equal to:
	return rows ? ypos % rows : ypos;

If you're also happy with this simplification, could you please help to
update this patch while applying? (Or we can send a v2. Please let us
know which way do you prefer.)


Thanks,
zenghui

