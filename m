Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E981C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:17:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F78120675
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:17:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404159AbfDRSQ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 14:16:58 -0400
Received: from gateway30.websitewelcome.com ([192.185.193.11]:45474 "EHLO
        gateway30.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2404039AbfDRSQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 14:16:57 -0400
Received: from cm12.websitewelcome.com (cm12.websitewelcome.com [100.42.49.8])
        by gateway30.websitewelcome.com (Postfix) with ESMTP id 1A533EC35
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2019 13:14:36 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id HBYShNAZViQerHBYSh5Hvv; Thu, 18 Apr 2019 13:14:36 -0500
X-Authority-Reason: nr=8
Received: from [189.250.104.103] (port=39810 helo=[192.168.1.76])
        by gator4166.hostgator.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1hHBYR-002a0i-Iw; Thu, 18 Apr 2019 13:14:35 -0500
Subject: Re: [PATCH 4.14 57/92] iommu/dmar: Fix buffer overflow during PCI bus
 notification
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org, Julia Cartwright <julia@ni.com>,
        Joerg Roedel <jroedel@suse.de>,
        Sasha Levin <sashal@kernel.org>,
        Kees Cook <keescook@chromium.org>
References: <20190418160430.325165109@linuxfoundation.org>
 <20190418160435.133945157@linuxfoundation.org>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Openpgp: preference=signencrypt
Autocrypt: addr=gustavo@embeddedor.com; keydata=
 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
 VtSixD1uOgytAP7RWS474w==
Message-ID: <60e14fb7-8596-e21c-f4be-546ce39e7bdb@embeddedor.com>
Date:   Thu, 18 Apr 2019 13:14:34 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190418160435.133945157@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.104.103
X-Source-L: No
X-Exim-ID: 1hHBYR-002a0i-Iw
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.76]) [189.250.104.103]:39810
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 2
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[+cc Kees]

On 4/18/19 12:57 PM, Greg Kroah-Hartman wrote:
> [ Upstream commit cffaaf0c816238c45cd2d06913476c83eb50f682 ]
> 
> Commit 57384592c433 ("iommu/vt-d: Store bus information in RMRR PCI
> device path") changed the type of the path data, however, the change in
> path type was not reflected in size calculations.  Update to use the
> correct type and prevent a buffer overflow.
> 
> This bug manifests in systems with deep PCI hierarchies, and can lead to
> an overflow of the static allocated buffer (dmar_pci_notify_info_buf),
> or can lead to overflow of slab-allocated data.
> 
>    BUG: KASAN: global-out-of-bounds in dmar_alloc_pci_notify_info+0x1d5/0x2e0
>    Write of size 1 at addr ffffffff90445d80 by task swapper/0/1
>    CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W       4.14.87-rt49-02406-gd0a0e96 #1
>    Call Trace:
>     ? dump_stack+0x46/0x59
>     ? print_address_description+0x1df/0x290
>     ? dmar_alloc_pci_notify_info+0x1d5/0x2e0
>     ? kasan_report+0x256/0x340
>     ? dmar_alloc_pci_notify_info+0x1d5/0x2e0
>     ? e820__memblock_setup+0xb0/0xb0
>     ? dmar_dev_scope_init+0x424/0x48f
>     ? __down_write_common+0x1ec/0x230
>     ? dmar_dev_scope_init+0x48f/0x48f
>     ? dmar_free_unused_resources+0x109/0x109
>     ? cpumask_next+0x16/0x20
>     ? __kmem_cache_create+0x392/0x430
>     ? kmem_cache_create+0x135/0x2f0
>     ? e820__memblock_setup+0xb0/0xb0
>     ? intel_iommu_init+0x170/0x1848
>     ? _raw_spin_unlock_irqrestore+0x32/0x60
>     ? migrate_enable+0x27a/0x5b0
>     ? sched_setattr+0x20/0x20
>     ? migrate_disable+0x1fc/0x380
>     ? task_rq_lock+0x170/0x170
>     ? try_to_run_init_process+0x40/0x40
>     ? locks_remove_file+0x85/0x2f0
>     ? dev_prepare_static_identity_mapping+0x78/0x78
>     ? rt_spin_unlock+0x39/0x50
>     ? lockref_put_or_lock+0x2a/0x40
>     ? dput+0x128/0x2f0
>     ? __rcu_read_unlock+0x66/0x80
>     ? __fput+0x250/0x300
>     ? __rcu_read_lock+0x1b/0x30
>     ? mntput_no_expire+0x38/0x290
>     ? e820__memblock_setup+0xb0/0xb0
>     ? pci_iommu_init+0x25/0x63
>     ? pci_iommu_init+0x25/0x63
>     ? do_one_initcall+0x7e/0x1c0
>     ? initcall_blacklisted+0x120/0x120
>     ? kernel_init_freeable+0x27b/0x307
>     ? rest_init+0xd0/0xd0
>     ? kernel_init+0xf/0x120
>     ? rest_init+0xd0/0xd0
>     ? ret_from_fork+0x1f/0x40
>    The buggy address belongs to the variable:
>     dmar_pci_notify_info_buf+0x40/0x60
> 
> Fixes: 57384592c433 ("iommu/vt-d: Store bus information in RMRR PCI device path")
> Signed-off-by: Julia Cartwright <julia@ni.com>
> Signed-off-by: Joerg Roedel <jroedel@suse.de>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  drivers/iommu/dmar.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/dmar.c b/drivers/iommu/dmar.c
> index c0d1c4db5794..38d0128b8135 100644
> --- a/drivers/iommu/dmar.c
> +++ b/drivers/iommu/dmar.c
> @@ -144,7 +144,7 @@ dmar_alloc_pci_notify_info(struct pci_dev *dev, unsigned long event)
>  		for (tmp = dev; tmp; tmp = tmp->bus->self)
>  			level++;
>  
> -	size = sizeof(*info) + level * sizeof(struct acpi_dmar_pci_path);
> +	size = sizeof(*info) + level * sizeof(info->path[0]);
>  	if (size <= sizeof(dmar_pci_notify_info_buf)) {
>  		info = (struct dmar_pci_notify_info *)dmar_pci_notify_info_buf;
>  	} else {
> 

This perfectly illustrates how the use of the new struct_size() helper
can prevent these sort of bugs. :)

diff --git a/drivers/iommu/dmar.c b/drivers/iommu/dmar.c
index 9c49300e9fb7..6d969a172fbb 100644
--- a/drivers/iommu/dmar.c
+++ b/drivers/iommu/dmar.c
@@ -145,7 +145,7 @@ dmar_alloc_pci_notify_info(struct pci_dev *dev, unsigned long event)
                for (tmp = dev; tmp; tmp = tmp->bus->self)
                        level++;

-       size = sizeof(*info) + level * sizeof(info->path[0]);
+       size = struct_size(info, path, level);
        if (size <= sizeof(dmar_pci_notify_info_buf)) {
                info = (struct dmar_pci_notify_info *)dmar_pci_notify_info_buf;
        } else {

--
Gustavo
