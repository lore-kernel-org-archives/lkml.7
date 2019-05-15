Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D909C04E87
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 12:10:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B8A320675
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 12:10:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729550AbfEOMKS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 08:10:18 -0400
Received: from foss.arm.com ([217.140.101.70]:43106 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728921AbfEOMKO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 08:10:14 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 178DA80D;
        Wed, 15 May 2019 05:10:14 -0700 (PDT)
Received: from [10.1.196.129] (ostrya.cambridge.arm.com [10.1.196.129])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3CD2A3F71E;
        Wed, 15 May 2019 05:10:11 -0700 (PDT)
Subject: Re: [PATCH v7 04/23] iommu: Introduce attach/detach_pasid_table API
To:     Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu, joro@8bytes.org,
        alex.williamson@redhat.com, jacob.jun.pan@linux.intel.com,
        yi.l.liu@intel.com, will.deacon@arm.com, robin.murphy@arm.com
Cc:     peter.maydell@linaro.org, kevin.tian@intel.com,
        vincent.stehle@arm.com, ashok.raj@intel.com, marc.zyngier@arm.com,
        christoffer.dall@arm.com
References: <20190408121911.24103-1-eric.auger@redhat.com>
 <20190408121911.24103-5-eric.auger@redhat.com>
From:   Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Message-ID: <21bfdab4-846c-1dc7-6dff-62a46cc9c829@arm.com>
Date:   Wed, 15 May 2019 13:09:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190408121911.24103-5-eric.auger@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/04/2019 13:18, Eric Auger wrote:
> diff --git a/include/uapi/linux/iommu.h b/include/uapi/linux/iommu.h
> index edcc0dda7993..532a64075f23 100644
> --- a/include/uapi/linux/iommu.h
> +++ b/include/uapi/linux/iommu.h
> @@ -112,4 +112,51 @@ struct iommu_fault {
>  		struct iommu_fault_page_request prm;
>  	};
>  };
> +
> +/**
> + * SMMUv3 Stream Table Entry stage 1 related information
> + * The PASID table is referred to as the context descriptor (CD) table.
> + *
> + * @s1fmt: STE s1fmt (format of the CD table: single CD, linear table
> +   or 2-level table)

Running "scripts/kernel-doc -v -none" on this header produces some
warnings. Not sure if we want to get rid of all of them, but we should
at least fix the coding style for this comment (line must start with
" * "). I'm fixing it up on my sva/api branch

Thanks,
Jean

> + * @s1dss: STE s1dss (specifies the behavior when pasid_bits != 0
> +   and no pasid is passed along with the incoming transaction)
> + * Please refer to the smmu 3.x spec (ARM IHI 0070A) for full details
> + */
> +struct iommu_pasid_smmuv3 {
> +#define PASID_TABLE_SMMUV3_CFG_VERSION_1 1
> +	__u32	version;
> +	__u8 s1fmt;
> +	__u8 s1dss;
> +	__u8 padding[2];
> +};
