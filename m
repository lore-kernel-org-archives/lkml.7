Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4419EC7618B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 15:59:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7F3B223BA
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 15:59:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="rrky1imv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387887AbfGWP7O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 11:59:14 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:56116 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728293AbfGWP7O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 11:59:14 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190723155912euoutp012cd26aafc1469ba98a98e2b1d479cff7~0FImvI44w2604826048euoutp01W
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2019 15:59:12 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190723155912euoutp012cd26aafc1469ba98a98e2b1d479cff7~0FImvI44w2604826048euoutp01W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1563897552;
        bh=/RWb8j+kzrGd+Dnxye4CalD0zW2FJ5pGNubfhwNuHuM=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=rrky1imvcBaJjYJGIRsWRo380a6GyBKis+SVuws93ZZ8g2QxU/UA4S8qH8IeFiPsp
         ikZL6Wn9vq4ROjOp20OpNadEh2oM3bGM4gLOI5rmVQtx2o8+4WQViH8sa8pWTt51K/
         Zdw6Hn9UB6nmE6qJHEkJD1bQf6HUIFYpugzx5GIg=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190723155911eucas1p165e60c205c3c1af0b7595f746b1b0d2c~0FImGHUPK0482204822eucas1p1G;
        Tue, 23 Jul 2019 15:59:11 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 0D.40.04325.FCE273D5; Tue, 23
        Jul 2019 16:59:11 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190723155910eucas1p1b1d2e88907910c0536bf34d64813c391~0FIlTtR1Q0467804678eucas1p1O;
        Tue, 23 Jul 2019 15:59:10 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190723155910eusmtrp181f6c761f4d004e75239974c7ea66a8a~0FIlSl1TW0429004290eusmtrp1i;
        Tue, 23 Jul 2019 15:59:10 +0000 (GMT)
X-AuditID: cbfec7f5-b75ff700000010e5-e4-5d372ecf60e2
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 08.BB.04146.ECE273D5; Tue, 23
        Jul 2019 16:59:10 +0100 (BST)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190723155910eusmtip1166e02c886a3b80a32f878b6798761c5~0FIkxcjAO2581325813eusmtip1U;
        Tue, 23 Jul 2019 15:59:10 +0000 (GMT)
Subject: Re: [RFC PATCH] fbcon: fix ypos over boundary issue
To:     Zenghui Yu <yuzenghui@huawei.com>
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        daniel.vetter@ffwll.ch, maarten.lankhorst@linux.intel.com,
        sam@ravnborg.org, linux-kernel@vger.kernel.org,
        wanghaibin.wang@huawei.com, zhang.zhanghailiang@huawei.com,
        yezengruan@huawei.com, Feng Tiantian <fengtiantian@huawei.com>
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <21374295-251c-e101-eaac-b86fffdb93ec@samsung.com>
Date:   Tue, 23 Jul 2019 17:59:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1562901216-9916-1-git-send-email-yuzenghui@huawei.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrMKsWRmVeSWpSXmKPExsWy7djPc7rn9cxjDQ7+5bNY+PAus8WVr+/Z
        LPasPsxkcaLvA6vF5V1z2CwWftzKYrHi51ZGi2U9v5gtXjWcZ7W4uXQDu8Xss49ZHLg99n5b
        wOLRcuQtq8e8k4Ee97uPM3ksmXaVzePzJrkAtigum5TUnMyy1CJ9uwSujGcfbzIX7LSteDN9
        KmMD42TjLkZODgkBE4mrs08zdTFycQgJrGCUaD82gRUkISTwhVGidZUBROIzo8ShaWeZuxg5
        wDruXfKBiC9nlLi2qpsZwnnLKPFl3SxmkG5hARuJf5vWg9kiAqoSt+/NZQUpYhZYzyTxZvUT
        NpAEm4CVxMT2VYwgNq+AncTPL33sIDYLUMOyexBniApESNw/toEVokZQ4uTMJywgNqeAi8SJ
        9q1gc5gFxCVuPZnPBGHLS2x/OwfsIgmBW+wSn1d9ZoV41EXi3Oo7ULawxKvjW9ghbBmJ05N7
        WCAa1jFK/O14AdW9nVFi+eR/bBBV1hKHj19kBQUAs4CmxPpd+hBhR4m3c86zQ8KFT+LGW0GI
        I/gkJm2bDg0uXomONiGIajWJDcs2sMGs7dq5knkCo9IsJK/NQvLOLCTvzELYu4CRZRWjeGpp
        cW56arFxXmq5XnFibnFpXrpecn7uJkZg0jr97/jXHYz7/iQdYhTgYFTi4a1gMo8VYk0sK67M
        PcQowcGsJMIb2GAWK8SbklhZlVqUH19UmpNafIhRmoNFSZy3muFBtJBAemJJanZqakFqEUyW
        iYNTqoFR+Nf0Je+2MfUmiuw+81j8SrXjhynZf09svFxy2nfynQb/UynBx46qpa+4klB3Ns10
        +cS/ygv/dL1WknfkVzrCtbvLYO3X/WvOsW3bxV379otCyoajKryeZYfkL+6obmCQbst10WFy
        CEorknx0zD769iW5Rlnxzf/Mp3zev/pRit38bW/32macVGIpzkg01GIuKk4EACz9kP5WAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrMIsWRmVeSWpSXmKPExsVy+t/xu7rn9MxjDZ4dVrBY+PAus8WVr+/Z
        LPasPsxkcaLvA6vF5V1z2CwWftzKYrHi51ZGi2U9v5gtXjWcZ7W4uXQDu8Xss49ZHLg99n5b
        wOLRcuQtq8e8k4Ee97uPM3ksmXaVzePzJrkAtig9m6L80pJUhYz84hJbpWhDCyM9Q0sLPSMT
        Sz1DY/NYKyNTJX07m5TUnMyy1CJ9uwS9jGcfbzIX7LSteDN9KmMD42TjLkYODgkBE4l7l3y6
        GLk4hASWMkqsWbmICSIuI3F8fVkXIyeQKSzx51oXG0hYSOA1o8QiAZCwsICNxL9N65lBbBEB
        VYnb9+aygoxhFljPJPF61klGiJnTGSWezX3MClLFJmAlMbF9FSOIzStgJ/HzSx87iM0C1L3s
        3gSwGlGBCIkz71ewQNQISpyc+QTM5hRwkTjRvpUNxGYWUJf4M+8SM4QtLnHryXwmCFteYvvb
        OcwTGIVmIWmfhaRlFpKWWUhaFjCyrGIUSS0tzk3PLTbUK07MLS7NS9dLzs/dxAiM0G3Hfm7e
        wXhpY/AhRgEORiUe3gom81gh1sSy4srcQ4wSHMxKIryBDWaxQrwpiZVVqUX58UWlOanFhxhN
        gZ6byCwlmpwPTB55JfGGpobmFpaG5sbmxmYWSuK8HQIHY4QE0hNLUrNTUwtSi2D6mDg4pRoY
        JQ+9PDhN8MC9dX3R8wLNlOI4RWYw/0zOcqy15t+XXOc75eT+14+LXOz5p115wMgR+TaHp/3z
        qo1c5YExe0rm+XUazXpufXK5TmjGJYObMSlnjjMdD7oiO1v3UXbXi4TDHWzlPXzz72uI9suy
        /qqtYe2YMeHryu0MG7+ssvLitD7+QbhWuaRciaU4I9FQi7moOBEAaFqVHeYCAAA=
X-CMS-MailID: 20190723155910eucas1p1b1d2e88907910c0536bf34d64813c391
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190712031440epcas2p1bf80bc306291973284f44a8e8085c66f
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190712031440epcas2p1bf80bc306291973284f44a8e8085c66f
References: <CGME20190712031440epcas2p1bf80bc306291973284f44a8e8085c66f@epcas2p1.samsung.com>
        <1562901216-9916-1-git-send-email-yuzenghui@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/12/19 5:13 AM, Zenghui Yu wrote:
> From: Feng Tiantian <fengtiantian@huawei.com>
> 
> While using "top" on a CentOS guest's VNC-client, then continuously press
> "Shift+PgUp", the guest kernel will get panic! Backtrace is attached below.
> We tested it on 5.2.0, and the issue remains.
> 
> [   66.946362] Unable to handle kernel paging request at virtual address ffff00000e240840
> [   66.946363] Mem abort info:
> [   66.946364]   Exception class = DABT (current EL), IL = 32 bits
> [   66.946365]   SET = 0, FnV = 0
> [   66.946366]   EA = 0, S1PTW = 0
> [   66.946367] Data abort info:
> [   66.946368]   ISV = 0, ISS = 0x00000047
> [   66.946368]   CM = 0, WnR = 1
> [   66.946370] swapper pgtable: 64k pages, 48-bit VAs, pgd = ffff000009660000
> [   66.946372] [ffff00000e240840] *pgd=000000023ffe0003, *pud=000000023ffe0003, *pmd=000000023ffd0003, *pte=0000000000000000
> [   66.946378] Internal error: Oops: 96000047 [#1] SMP
> [   66.946379] Modules linked in: vfat fat crc32_ce ghash_ce sg sha2_ce sha256_arm64 virtio_balloon virtio_net sha1_ce ip_tables ext4 mbcache jbd2 virtio_gpu drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops ttm drm i2c_core virtio_scsi virtio_pci virtio_mmio virtio_ring virtio
> [   66.946403] CPU: 0 PID: 1035 Comm: top Not tainted 4.14.0-49.el7a.aarch64 #1
> [   66.946404] Hardware name: QEMU KVM Virtual Machine, BIOS 0.0.0 02/06/2015
> [   66.946405] task: ffff8001c18fdc00 task.stack: ffff00000d4e0000
> [   66.946409] PC is at sys_imageblit+0x40c/0x10000 [sysimgblt]
> [   66.946431] LR is at drm_fb_helper_sys_imageblit+0x28/0x4c [drm_kms_helper]
> [   66.946433] pc : [<ffff0000020a040c>] lr : [<ffff000002202e74>] pstate: 00000005
> [   66.946433] sp : ffff00000d4ef7f0
> [   66.946434] x29: ffff00000d4ef7f0 x28: 00000000000001ff
> [   66.946436] x27: ffff8001c1c88100 x26: 0000000000000001
> [   66.946438] x25: 00000000000001f0 x24: 0000000000000018
> [   66.946440] x23: 0000000000000000 x22: ffff00000d4ef978
> [   66.946442] x21: ffff00000e240840 x20: 0000000000000000
> [   66.946444] x19: ffff8001c98c9000 x18: 0000fffff9d56670
> [   66.946445] x17: 0000000000000000 x16: 0000000000000000
> [   66.946447] x15: 0000000000000008 x14: 1b20202020202020
> [   66.946449] x13: 00000000000001f0 x12: 000000000000003e
> [   66.946450] x11: 000000000000000f x10: ffff8001c8400000
> [   66.946452] x9 : 0000000000aaaaaa x8 : 0000000000000001
> [   66.946454] x7 : ffff0000020b0090 x6 : 0000000000000001
> [   66.946456] x5 : 0000000000000000 x4 : 0000000000000000
> [   66.946457] x3 : ffff8001c8400000 x2 : ffff00000e240840
> [   66.946459] x1 : 00000000000001ef x0 : 0000000000000007
> [   66.946461] Process top (pid: 1035, stack limit = 0xffff00000d4e0000)
> [   66.946462] Call trace:
> [   66.946464] Exception stack(0xffff00000d4ef6b0 to 0xffff00000d4ef7f0)
> [   66.946465] f6a0:                                   0000000000000007 00000000000001ef
> [   66.946467] f6c0: ffff00000e240840 ffff8001c8400000 0000000000000000 0000000000000000
> [   66.946468] f6e0: 0000000000000001 ffff0000020b0090 0000000000000001 0000000000aaaaaa
> [   66.946470] f700: ffff8001c8400000 000000000000000f 000000000000003e 00000000000001f0
> [   66.946471] f720: 1b20202020202020 0000000000000008 0000000000000000 0000000000000000
> [   66.946472] f740: 0000fffff9d56670 ffff8001c98c9000 0000000000000000 ffff00000e240840
> [   66.946474] f760: ffff00000d4ef978 0000000000000000 0000000000000018 00000000000001f0
> [   66.946475] f780: 0000000000000001 ffff8001c1c88100 00000000000001ff ffff00000d4ef7f0
> [   66.946476] f7a0: ffff000002202e74 ffff00000d4ef7f0 ffff0000020a040c 0000000000000005
> [   66.946478] f7c0: ffff00000d4ef7e0 ffff0000080ea614 0001000000000000 ffff000008152f08
> [   66.946479] f7e0: ffff00000d4ef7f0 ffff0000020a040c
> [   66.946481] [<ffff0000020a040c>] sys_imageblit+0x40c/0x10000 [sysimgblt]
> [   66.946501] [<ffff000002202e74>] drm_fb_helper_sys_imageblit+0x28/0x4c [drm_kms_helper]
> [   66.946510] [<ffff0000022a12dc>] virtio_gpu_3d_imageblit+0x2c/0x78 [virtio_gpu]
> [   66.946515] [<ffff00000847f458>] bit_putcs+0x288/0x49c
> [   66.946517] [<ffff00000847ad24>] fbcon_putcs+0x114/0x148
> [   66.946519] [<ffff0000084fe92c>] do_update_region+0x118/0x19c
> [   66.946521] [<ffff00000850413c>] do_con_trol+0x114c/0x1314
> [   66.946523] [<ffff0000085044dc>] do_con_write.part.22+0x1d8/0x890
> [   66.946525] [<ffff000008504c88>] con_write+0x84/0x8c
> [   66.946527] [<ffff0000084ec7f0>] n_tty_write+0x19c/0x408
> [   66.946529] [<ffff0000084e9120>] tty_write+0x150/0x270
> [   66.946532] [<ffff00000829d558>] __vfs_write+0x58/0x180
> [   66.946534] [<ffff00000829d880>] vfs_write+0xa8/0x1a0
> [   66.946536] [<ffff00000829db40>] SyS_write+0x60/0xc0
> [   66.946537] Exception stack(0xffff00000d4efec0 to 0xffff00000d4f0000)
> [   66.946539] fec0: 0000000000000001 0000000000457958 0000000000000800 0000000000000000
> [   66.946540] fee0: 00000000fbad2885 0000000000000bd0 0000ffff8556add4 0000000000000000
> [   66.946541] ff00: 0000000000000040 0000000000000000 0000000000434a88 0000000000000012
> [   66.946543] ff20: 0000000100000000 0000fffff9d564f0 0000fffff9d564a0 0000000000000008
> [   66.946544] ff40: 0000000000000000 0000ffff85593b1c 0000fffff9d56670 0000000000000800
> [   66.946546] ff60: 0000000000457958 0000ffff856a1158 0000000000000800 0000ffff85720000
> [   66.946547] ff80: 0000000000000000 0000ffff856f604c 0000000000000000 0000000000436000
> [   66.946548] ffa0: 000000001c90a160 0000fffff9d56f20 0000ffff855965f4 0000fffff9d56f20
> [   66.946549] ffc0: 0000ffff855f12c8 0000000020000000 0000000000000001 0000000000000040
> [   66.946551] ffe0: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
> [   66.946554] [<ffff00000808359c>] __sys_trace_return+0x0/0x4
> [   66.946556] Code: 0a080084 b86478e4 0a040124 4a050084 (b9000044)
> [   66.946561] ---[ end trace 32d49c68b19c4796 ]---
> [   66.946562] Kernel panic - not syncing: Fatal exception
> [   66.946564] SMP: stopping secondary CPUs
> [   66.946596] Kernel Offset: disabled
> [   66.946598] CPU features: 0x1802008
> [   66.946598] Memory Limit: none
> [   67.092353] ---[ end Kernel panic - not syncing: Fatal exception
> 
>>From our non-expert analysis, fbcon ypos will sometimes over boundary and
> then fbcon_putcs() access invalid VGA framebuffer address. We modify the
> real_y() to make sure fbcon ypos is always less than rows.
> 
> Reported-by: Zengruan Ye <yezengruan@huawei.com>
> Signed-off-by: Feng Tiantian <fengtiantian@huawei.com>
> Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
> ---
> 
> Hi Bartlomiej,

Hi Zenghui,

> Zengruan had reported this issue [1] but received no reply. Does it make

Sorry about that (at that time it seemed like a workaround for DRM issue
so I have not followed it further).

> sense to fix this issue? Could you please take a look into this patch?

It looks fine to me. I'll queue it for v5.4 on Friday (if there are
no issues raised by reviewers by then).

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> Thanks,
> zenghui
> 
> [1] https://lkml.org/lkml/2018/11/27/639
> 
>  drivers/video/fbdev/core/fbcon.h | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/video/fbdev/core/fbcon.h b/drivers/video/fbdev/core/fbcon.h
> index 20dea85..b1aa00e 100644
> --- a/drivers/video/fbdev/core/fbcon.h
> +++ b/drivers/video/fbdev/core/fbcon.h
> @@ -230,7 +230,10 @@ static inline int real_y(struct fbcon_display *p, int ypos)
>  	int rows = p->vrows;
>  
>  	ypos += p->yscroll;
> -	return ypos < rows ? ypos : ypos - rows;
> +	if (rows == 0)
> +		return ypos;
> +	else
> +		return ypos < rows ? ypos : ypos % rows;
>  }
