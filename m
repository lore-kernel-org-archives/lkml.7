Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 631DFC433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 20:11:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31AD6216C8
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 20:11:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404556AbfHHUK7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 16:10:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54952 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404505AbfHHUK6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 16:10:58 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8DD7B309BF02;
        Thu,  8 Aug 2019 20:10:58 +0000 (UTC)
Received: from x1.home (ovpn-116-99.phx2.redhat.com [10.3.116.99])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E254D608A7;
        Thu,  8 Aug 2019 20:10:57 +0000 (UTC)
Date:   Thu, 8 Aug 2019 14:10:57 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>, ashok.raj@intel.com,
        jacob.jun.pan@intel.com, kevin.tian@intel.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH 2/2] iommu/vt-d: Fix possible use-after-free of private
 domain
Message-ID: <20190808141057.1bce8495@x1.home>
In-Reply-To: <20190806001409.3293-2-baolu.lu@linux.intel.com>
References: <20190806001409.3293-1-baolu.lu@linux.intel.com>
        <20190806001409.3293-2-baolu.lu@linux.intel.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Thu, 08 Aug 2019 20:10:58 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  6 Aug 2019 08:14:09 +0800
Lu Baolu <baolu.lu@linux.intel.com> wrote:

> Multiple devices might share a private domain. One real example
> is a pci bridge and all devices behind it. When remove a private
> domain, make sure that it has been detached from all devices to
> avoid use-after-free case.
> 
> Cc: Ashok Raj <ashok.raj@intel.com>
> Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Cc: Kevin Tian <kevin.tian@intel.com>
> Cc: Alex Williamson <alex.williamson@redhat.com>
> Fixes: 942067f1b6b97 ("iommu/vt-d: Identify default domains replaced with private")
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---

Tested-by: Alex Williamson <alex.williamson@redhat.com>

>  drivers/iommu/intel-iommu.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> index 37259b7f95a7..12d094d08c0a 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -4791,7 +4791,8 @@ static void __dmar_remove_one_dev_info(struct device_domain_info *info)
>  
>  	/* free the private domain */
>  	if (domain->flags & DOMAIN_FLAG_LOSE_CHILDREN &&
> -	    !(domain->flags & DOMAIN_FLAG_STATIC_IDENTITY))
> +	    !(domain->flags & DOMAIN_FLAG_STATIC_IDENTITY) &&
> +	    list_empty(&domain->devices))
>  		domain_exit(info->domain);
>  
>  	free_devinfo_mem(info);

