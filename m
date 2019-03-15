Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48B17C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 02:36:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2103921873
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 02:36:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728180AbfCOCg0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 22:36:26 -0400
Received: from mga03.intel.com ([134.134.136.65]:60245 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727103AbfCOCg0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 22:36:26 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Mar 2019 19:36:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,480,1544515200"; 
   d="scan'208";a="127110156"
Received: from allen-box.sh.intel.com (HELO [10.239.159.136]) ([10.239.159.136])
  by orsmga006.jf.intel.com with ESMTP; 14 Mar 2019 19:36:24 -0700
Cc:     baolu.lu@linux.intel.com, Tom Murphy <tmurphy@arista.com>,
        Dmitry Safonov <dima@arista.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/7] iommu/vt-d: Ignore domain parameter in
 attach_device if device requires identity map
To:     James Sewart <jamessewart@arista.com>,
        iommu@lists.linux-foundation.org
References: <0F0C82BE-86E5-4BAC-938C-6F7629E18D27@arista.com>
 <83B82113-8AE5-4B0C-A079-F389520525BD@arista.com>
 <D8A19A7A-91CB-4297-9445-47DB248B7817@arista.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <acf363ab-1e77-d4fc-e66c-95069e182c1a@linux.intel.com>
Date:   Fri, 15 Mar 2019 10:30:59 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <D8A19A7A-91CB-4297-9445-47DB248B7817@arista.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 3/14/19 7:58 PM, James Sewart wrote:
> If a device requires an identity map then it is not safe to attach a
> domain that can remap addresses. Warn the user if this occurs.
> 
> Signed-off-by: James Sewart <jamessewart@arista.com>
> ---
>   drivers/iommu/intel-iommu.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> index 2e00e8708f06..104d36f225a7 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -5101,6 +5101,11 @@ static int intel_iommu_attach_device(struct iommu_domain *domain,
>   		}
>   	}
>   
> +	if (iommu_no_mapping(dev)) {
> +		dmar_domain = si_domain;
> +		dev_warn(dev, "VT-d: Device is required to use identity IOMMU mapping, ignoring domain attached\n");
> +	}

This is awful. :-)

IOMMU generic layer allocated a @domain and tries to bind the @domain
with a device. This code replaces @domain with si_domain without
notifying the upper layer.

Best regards,
Lu Baolu
