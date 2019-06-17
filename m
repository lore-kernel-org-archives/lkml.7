Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBB6EC31E50
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 13:53:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B03C12080C
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 13:53:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728262AbfFQNxS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 09:53:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56884 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726028AbfFQNxS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 09:53:18 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3AADE821EF;
        Mon, 17 Jun 2019 13:53:08 +0000 (UTC)
Received: from [10.36.117.84] (ovpn-117-84.ams2.redhat.com [10.36.117.84])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C2C1C7E5CC;
        Mon, 17 Jun 2019 13:53:06 +0000 (UTC)
Subject: Re: [PATCH] iommu/intel: remove an unused variable "length"
To:     Qian Cai <cai@lca.pw>, jroedel@suse.de
Cc:     dwmw2@infradead.org, baolu.lu@linux.intel.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
References: <20190617132027.1960-1-cai@lca.pw>
From:   Auger Eric <eric.auger@redhat.com>
Message-ID: <ee4d4983-4297-a027-1844-a7648a0512ca@redhat.com>
Date:   Mon, 17 Jun 2019 15:53:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190617132027.1960-1-cai@lca.pw>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Mon, 17 Jun 2019 13:53:17 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Qian,

On 6/17/19 3:20 PM, Qian Cai wrote:
> The linux-next commit "iommu/vt-d: Duplicate iommu_resv_region objects
> per device list" [1] left out an unused variable,
> 
> drivers/iommu/intel-iommu.c: In function 'dmar_parse_one_rmrr':
> drivers/iommu/intel-iommu.c:4014:9: warning: variable 'length' set but
> not used [-Wunused-but-set-variable]
> 
> [1] https://lore.kernel.org/patchwork/patch/1083073/
> 
> Signed-off-by: Qian Cai <cai@lca.pw>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thank you for fixing this oversight

Best Regards

Eric

> ---
>  drivers/iommu/intel-iommu.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> index 478ac186570b..d86d4ee5cc78 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -4011,7 +4011,6 @@ int __init dmar_parse_one_rmrr(struct acpi_dmar_header *header, void *arg)
>  {
>  	struct acpi_dmar_reserved_memory *rmrr;
>  	struct dmar_rmrr_unit *rmrru;
> -	size_t length;
>  
>  	rmrru = kzalloc(sizeof(*rmrru), GFP_KERNEL);
>  	if (!rmrru)
> @@ -4022,8 +4021,6 @@ int __init dmar_parse_one_rmrr(struct acpi_dmar_header *header, void *arg)
>  	rmrru->base_address = rmrr->base_address;
>  	rmrru->end_address = rmrr->end_address;
>  
> -	length = rmrr->end_address - rmrr->base_address + 1;
> -
>  	rmrru->devices = dmar_alloc_dev_scope((void *)(rmrr + 1),
>  				((void *)rmrr) + rmrr->header.length,
>  				&rmrru->devices_cnt);
> 
