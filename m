Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD220C433FF
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 02:22:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98C832086D
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 02:22:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731377AbfHFCWZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 22:22:25 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:42976 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729921AbfHFCWZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 22:22:25 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 8527884A5492A4EC936D;
        Tue,  6 Aug 2019 10:22:23 +0800 (CST)
Received: from [127.0.0.1] (10.184.52.56) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.439.0; Tue, 6 Aug 2019
 10:22:14 +0800
Subject: Re: [PATCH] iommu/iova: wait 'fq_timer' handler to finish before
 destroying 'fq'
To:     <joro@8bytes.org>, <robin.murphy@arm.com>,
        <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>
CC:     <yaohongbo@huawei.com>, <huawei.libin@huawei.com>,
        <thunder.leizhen@huawei.com>
References: <1564219269-14346-1-git-send-email-wangxiongfeng2@huawei.com>
From:   Xiongfeng Wang <wangxiongfeng2@huawei.com>
Message-ID: <5ca9b2c9-11e8-1af0-2e15-a78086343c48@huawei.com>
Date:   Tue, 6 Aug 2019 10:22:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1564219269-14346-1-git-send-email-wangxiongfeng2@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.184.52.56]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ (Robin)

Hi Robin,

Sorry to ping you...

What's your suggestion for this patch? I'm looking forward to your reply.

Thanks,
Xiongfeng.


On 2019/7/27 17:21, Xiongfeng Wang wrote:
> Fix following crash that occurs when 'fq_flush_timeout()' access
> 'fq->lock' while 'iovad->fq' has been cleared. This happens when the
> 'fq_timer' handler is being executed and we call
> 'free_iova_flush_queue()'. When the timer handler is being executed,
> its pending state is cleared and it is detached. This patch use
> 'del_timer_sync()' to wait for the timer handler 'fq_flush_timeout()' to
> finish before destroying the flush queue.
> 
> [ 9052.361840] Unable to handle kernel paging request at virtual address 0000a02fd6c66008
> [ 9052.361843] Mem abort info:
> [ 9052.361845]   ESR = 0x96000004
> [ 9052.361847]   Exception class = DABT (current EL), IL = 32 bits
> [ 9052.361849]   SET = 0, FnV = 0
> [ 9052.361850]   EA = 0, S1PTW = 0
> [ 9052.361852] Data abort info:
> [ 9052.361853]   ISV = 0, ISS = 0x00000004
> [ 9052.361855]   CM = 0, WnR = 0
> [ 9052.361860] user pgtable: 4k pages, 48-bit VAs, pgdp = 000000009b665b91
> [ 9052.361863] [0000a02fd6c66008] pgd=0000000000000000
> [ 9052.361870] Internal error: Oops: 96000004 [#1] SMP
> [ 9052.361873] Process rmmod (pid: 51122, stack limit = 0x000000003f5524f7)
> [ 9052.361881] CPU: 69 PID: 51122 Comm: rmmod Kdump: loaded Tainted: G           OE     4.19.36-vhulk1906.3.0.h356.eulerosv2r8.aarch64 #1
> [ 9052.361882] Hardware name: Huawei TaiShan 2280 V2/BC82AMDC, BIOS 0.81 07/10/2019
> [ 9052.361885] pstate: 80400089 (Nzcv daIf +PAN -UAO)
> [ 9052.361902] pc : fq_flush_timeout+0x9c/0x110
> [ 9052.361904] lr :           (null)
> [ 9052.361906] sp : ffff00000965bd80
> [ 9052.361907] x29: ffff00000965bd80 x28: 0000000000000202
> [ 9052.361912] x27: 0000000000000000 x26: 0000000000000053
> [ 9052.361915] x25: ffffa026ed805008 x24: ffff000009119810
> [ 9052.361919] x23: ffff00000911b938 x22: ffff00000911bc04
> [ 9052.361922] x21: ffffa026ed804f28 x20: 0000a02fd6c66008
> [ 9052.361926] x19: 0000a02fd6c64000 x18: ffff000009117000
> [ 9052.361929] x17: 0000000000000008 x16: 0000000000000000
> [ 9052.361933] x15: ffff000009119708 x14: 0000000000000115
> [ 9052.361936] x13: ffff0000092f09d7 x12: 0000000000000000
> [ 9052.361940] x11: 0000000000000001 x10: ffff00000965be98
> [ 9052.361943] x9 : 0000000000000000 x8 : 0000000000000007
> [ 9052.361947] x7 : 0000000000000010 x6 : 000000d658b784ef
> [ 9052.361950] x5 : 00ffffffffffffff x4 : 00000000ffffffff
> [ 9052.361954] x3 : 0000000000000013 x2 : 0000000000000001
> [ 9052.361957] x1 : 0000000000000000 x0 : 0000a02fd6c66008
> [ 9052.361961] Call trace:
> [ 9052.361967]  fq_flush_timeout+0x9c/0x110
> [ 9052.361976]  call_timer_fn+0x34/0x178
> [ 9052.361980]  expire_timers+0xec/0x158
> [ 9052.361983]  run_timer_softirq+0xc0/0x1f8
> [ 9052.361987]  __do_softirq+0x120/0x324
> [ 9052.361995]  irq_exit+0x11c/0x140
> [ 9052.362003]  __handle_domain_irq+0x6c/0xc0
> [ 9052.362005]  gic_handle_irq+0x6c/0x150
> [ 9052.362008]  el1_irq+0xb8/0x140
> [ 9052.362010]  vprintk_emit+0x2b4/0x320
> [ 9052.362013]  vprintk_default+0x54/0x90
> [ 9052.362016]  vprintk_func+0xa0/0x150
> [ 9052.362019]  printk+0x74/0x94
> [ 9052.362034]  nvme_get_smart+0x200/0x220 [nvme]
> [ 9052.362041]  nvme_remove+0x38/0x250 [nvme]
> [ 9052.362051]  pci_device_remove+0x48/0xd8
> [ 9052.362065]  device_release_driver_internal+0x1b4/0x250
> [ 9052.362068]  driver_detach+0x64/0xe8
> [ 9052.362072]  bus_remove_driver+0x64/0x118
> [ 9052.362074]  driver_unregister+0x34/0x60
> [ 9052.362077]  pci_unregister_driver+0x24/0xd8
> [ 9052.362083]  nvme_exit+0x24/0x1754 [nvme]
> [ 9052.362094]  __arm64_sys_delete_module+0x19c/0x2a0
> [ 9052.362102]  el0_svc_common+0x78/0x130
> [ 9052.362106]  el0_svc_handler+0x38/0x78
> [ 9052.362108]  el0_svc+0x8/0xc
> 
> Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
> ---
>  drivers/iommu/iova.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
> index 3e1a8a6..90e8035 100644
> --- a/drivers/iommu/iova.c
> +++ b/drivers/iommu/iova.c
> @@ -64,8 +64,7 @@ static void free_iova_flush_queue(struct iova_domain *iovad)
>  	if (!has_iova_flush_queue(iovad))
>  		return;
>  
> -	if (timer_pending(&iovad->fq_timer))
> -		del_timer(&iovad->fq_timer);
> +	del_timer_sync(&iovad->fq_timer);
>  
>  	fq_destroy_all_entries(iovad);
>  
> 

