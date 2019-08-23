Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFEFAC3A5A1
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 01:52:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A574A233A0
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 01:52:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388289AbfHWBwY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 21:52:24 -0400
Received: from mga05.intel.com ([192.55.52.43]:25107 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733139AbfHWBwY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 21:52:24 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Aug 2019 18:52:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,419,1559545200"; 
   d="scan'208";a="173330337"
Received: from allen-box.sh.intel.com (HELO [10.239.159.136]) ([10.239.159.136])
  by orsmga008.jf.intel.com with ESMTP; 22 Aug 2019 18:52:21 -0700
Cc:     baolu.lu@linux.intel.com, iommu@lists.linux-foundation.org,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Micha=c5=82_Wajdeczko?= <michal.wajdeczko@intel.com>
Subject: Re: [RFC PATCH] iommu/vt-d: Fix IOMMU field not populated on device
 hot re-plug
To:     Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>
References: <20190822142922.31526-1-janusz.krzysztofik@linux.intel.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <00f1a3a7-7ff6-e9a0-d9de-a177af6fd64b@linux.intel.com>
Date:   Fri, 23 Aug 2019 09:51:11 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190822142922.31526-1-janusz.krzysztofik@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 8/22/19 10:29 PM, Janusz Krzysztofik wrote:
> When a perfectly working i915 device is hot unplugged (via sysfs) and
> hot re-plugged again, its dev->archdata.iommu field is not populated
> again with an IOMMU pointer.  As a result, the device probe fails on
> DMA mapping error during scratch page setup.
> 
> It looks like that happens because devices are not detached from their
> MMUIO bus before they are removed on device unplug.  Then, when an
> already registered device/IOMMU association is identified by the
> reinstantiated device's bus and function IDs on IOMMU bus re-attach
> attempt, the device's archdata is not populated with IOMMU information
> and the bad happens.
> 
> I'm not sure if this is a proper fix but it works for me so at least it
> confirms correctness of my analysis results, I believe.  So far I
> haven't been able to identify a good place where the possibly missing
> IOMMU bus detach on device unplug operation could be added.

Which kernel version are you testing with? Does it contain below commit?

commit 458b7c8e0dde12d140e3472b80919cbb9ae793f4
Author: Lu Baolu <baolu.lu@linux.intel.com>
Date:   Thu Aug 1 11:14:58 2019 +0800

     iommu/vt-d: Detach domain when move device out of group

     When removing a device from an iommu group, the domain should
     be detached from the device. Otherwise, the stale domain info
     will still be cached by the driver and the driver will refuse
     to attach any domain to the device again.

     Cc: Ashok Raj <ashok.raj@intel.com>
     Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
     Cc: Kevin Tian <kevin.tian@intel.com>
     Fixes: b7297783c2bb6 ("iommu/vt-d: Remove duplicated code for 
device hotplug")
     Reported-and-tested-by: Vlad Buslov <vladbu@mellanox.com>
     Suggested-by: Robin Murphy <robin.murphy@arm.com>
     Link: https://lkml.org/lkml/2019/7/26/1133
     Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
     Signed-off-by: Joerg Roedel <jroedel@suse.de>

Best regards,
Lu Baolu

> 
> Signed-off-by: Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
> ---
>   drivers/iommu/intel-iommu.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> index 12d094d08c0a..7cdcd0595408 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -2477,6 +2477,9 @@ static struct dmar_domain *dmar_insert_one_dev_info(struct intel_iommu *iommu,
>   		if (info2) {
>   			found      = info2->domain;
>   			info2->dev = dev;
> +
> +			if (dev && !dev->archdata.iommu)
> +				dev->archdata.iommu = info2;
>   		}
>   	}
>   
> 
