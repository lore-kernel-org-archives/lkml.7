Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 978DEC04AB6
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 02:19:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F25121019
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 02:19:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbfE2CTr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 22:19:47 -0400
Received: from mga05.intel.com ([192.55.52.43]:8010 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725828AbfE2CTr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 22:19:47 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 May 2019 19:19:46 -0700
X-ExtLoop1: 1
Received: from allen-box.sh.intel.com (HELO [10.239.159.136]) ([10.239.159.136])
  by orsmga004.jf.intel.com with ESMTP; 28 May 2019 19:19:43 -0700
Cc:     baolu.lu@linux.intel.com, alex.williamson@redhat.com,
        shameerali.kolothum.thodi@huawei.com, jean-philippe.brucker@arm.com
Subject: Re: [PATCH v5 4/7] iommu/vt-d: Handle RMRR with PCI bridge device
 scopes
To:     Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
        joro@8bytes.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, dwmw2@infradead.org,
        robin.murphy@arm.com
References: <20190528115025.17194-1-eric.auger@redhat.com>
 <20190528115025.17194-5-eric.auger@redhat.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <3f33a110-97a1-bd28-cacd-1df40a3922b0@linux.intel.com>
Date:   Wed, 29 May 2019 10:12:52 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190528115025.17194-5-eric.auger@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 5/28/19 7:50 PM, Eric Auger wrote:
> When reading the vtd specification and especially the
> Reserved Memory Region Reporting Structure chapter,
> it is not obvious a device scope element cannot be a
> PCI-PCI bridge, in which case all downstream ports are
> likely to access the reserved memory region. Let's handle
> this case in device_has_rmrr.


This looks good to me.

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
Baolu

> 
> Fixes: ea2447f700ca ("intel-iommu: Prevent devices with RMRRs from being placed into SI Domain")
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> 
> ---
> 
> v1 -> v2:
> - is_downstream_to_pci_bridge helper introduced in a separate patch
> ---
>   drivers/iommu/intel-iommu.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> index 879f11c82b05..35508687f178 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -2910,7 +2910,8 @@ static bool device_has_rmrr(struct device *dev)
>   		 */
>   		for_each_active_dev_scope(rmrr->devices,
>   					  rmrr->devices_cnt, i, tmp)
> -			if (tmp == dev) {
> +			if (tmp == dev ||
> +			    is_downstream_to_pci_bridge(dev, tmp)) {
>   				rcu_read_unlock();
>   				return true;
>   			}
> 
