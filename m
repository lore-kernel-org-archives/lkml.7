Return-Path: <SRS0=x0+x=RM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89252C43381
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 07:21:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CF232081B
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 07:21:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbfCIHVP convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Mar 2019 02:21:15 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:2510 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725787AbfCIHVN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Mar 2019 02:21:13 -0500
Received: from DGGEML403-HUB.china.huawei.com (unknown [172.30.72.55])
        by Forcepoint Email with ESMTP id A07D98D568A4C2C417F5;
        Sat,  9 Mar 2019 15:21:11 +0800 (CST)
Received: from DGGEML531-MBS.china.huawei.com ([169.254.5.97]) by
 DGGEML403-HUB.china.huawei.com ([fe80::74d9:c659:fbec:21fa%31]) with mapi id
 14.03.0415.000; Sat, 9 Mar 2019 15:21:03 +0800
From:   "Gonglei (Arei)" <arei.gonglei@huawei.com>
To:     longpeng <longpeng2@huawei.com>, "mst@redhat.com" <mst@redhat.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>
CC:     "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] virtio_pci: fix a NULL pointer reference in vp_del_vqs
Thread-Topic: [PATCH] virtio_pci: fix a NULL pointer reference in vp_del_vqs
Thread-Index: AQHU1kg9AsziBYj2hk2nipAnPGHPf6YC5FZA
Date:   Sat, 9 Mar 2019 07:21:02 +0000
Message-ID: <33183CC9F5247A488A2544077AF19020DB286191@dggeml531-mbs.china.huawei.com>
References: <1552115860-328324-1-git-send-email-longpeng2@huawei.com>
In-Reply-To: <1552115860-328324-1-git-send-email-longpeng2@huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.177.18.62]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: longpeng
> Sent: Saturday, March 09, 2019 3:18 PM
> To: mst@redhat.com; jasowang@redhat.com
> Cc: virtualization@lists.linux-foundation.org; linux-kernel@vger.kernel.org;
> longpeng <longpeng2@huawei.com>; Gonglei (Arei)
> <arei.gonglei@huawei.com>
> Subject: [PATCH] virtio_pci: fix a NULL pointer reference in vp_del_vqs
> 
> From: Longpeng <longpeng2@huawei.com>
> 
> If the msix_affinity_masks is alloced failed, then we'll
> try to free some resources in vp_free_vectors() that may
> access it directly.
> 
> We met the following stack in our production:
> [   29.296767] BUG: unable to handle kernel NULL pointer dereference at
> (null)
> [   29.311151] IP: [<ffffffffc04fe35a>] vp_free_vectors+0x6a/0x150 [virtio_pci]
> [   29.324787] PGD 0
> [   29.333224] Oops: 0000 [#1] SMP
> [...]
> [   29.425175] RIP: 0010:[<ffffffffc04fe35a>]  [<ffffffffc04fe35a>]
> vp_free_vectors+0x6a/0x150 [virtio_pci]
> [   29.441405] RSP: 0018:ffff9a55c2dcfa10  EFLAGS: 00010206
> [   29.453491] RAX: 0000000000000000 RBX: ffff9a55c322c400 RCX:
> 0000000000000000
> [   29.467488] RDX: 0000000000000000 RSI: 0000000000000000 RDI:
> ffff9a55c322c400
> [   29.481461] RBP: ffff9a55c2dcfa20 R08: 0000000000000000 R09:
> ffffc1b6806ff020
> [   29.495427] R10: 0000000000000e95 R11: 0000000000aaaaaa R12:
> 0000000000000000
> [   29.509414] R13: 0000000000010000 R14: ffff9a55bd2d9e98 R15:
> ffff9a55c322c400
> [   29.523407] FS:  00007fdcba69f8c0(0000) GS:ffff9a55c2840000(0000)
> knlGS:0000000000000000
> [   29.538472] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   29.551621] CR2: 0000000000000000 CR3: 000000003ce52000 CR4:
> 00000000003607a0
> [   29.565886] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
> 0000000000000000
> [   29.580055] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
> 0000000000000400
> [   29.594122] Call Trace:
> [   29.603446]  [<ffffffffc04fe8a2>] vp_request_msix_vectors+0xe2/0x260
> [virtio_pci]
> [   29.618017]  [<ffffffffc04fedc5>] vp_try_to_find_vqs+0x95/0x3b0
> [virtio_pci]
> [   29.632152]  [<ffffffffc04ff117>] vp_find_vqs+0x37/0xb0 [virtio_pci]
> [   29.645582]  [<ffffffffc057bf63>] init_vq+0x153/0x260 [virtio_blk]
> [   29.658831]  [<ffffffffc057c1e8>] virtblk_probe+0xe8/0x87f [virtio_blk]
> [...]
> 
> Cc: Gonglei <arei.gonglei@huawei.com>
> Signed-off-by: Longpeng <longpeng2@huawei.com>
> ---
>  drivers/virtio/virtio_pci_common.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 

Reviewed-by: Gonglei <arei.gonglei@huawei.com>

Thanks,
-Gonglei

> diff --git a/drivers/virtio/virtio_pci_common.c
> b/drivers/virtio/virtio_pci_common.c
> index d0584c0..7a0398b 100644
> --- a/drivers/virtio/virtio_pci_common.c
> +++ b/drivers/virtio/virtio_pci_common.c
> @@ -255,9 +255,11 @@ void vp_del_vqs(struct virtio_device *vdev)
>  	for (i = 0; i < vp_dev->msix_used_vectors; ++i)
>  		free_irq(pci_irq_vector(vp_dev->pci_dev, i), vp_dev);
> 
> -	for (i = 0; i < vp_dev->msix_vectors; i++)
> -		if (vp_dev->msix_affinity_masks[i])
> -			free_cpumask_var(vp_dev->msix_affinity_masks[i]);
> +	if (vp_dev->msix_affinity_masks) {
> +		for (i = 0; i < vp_dev->msix_vectors; i++)
> +			if (vp_dev->msix_affinity_masks[i])
> +				free_cpumask_var(vp_dev->msix_affinity_masks[i]);
> +	}
> 
>  	if (vp_dev->msix_enabled) {
>  		/* Disable the vector used for configuration */
> --
> 1.8.3.1
> 

