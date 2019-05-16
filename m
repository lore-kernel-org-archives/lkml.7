Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78B91C04AB4
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 14:15:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56AD22082E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 14:15:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727800AbfEPOPG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 10:15:06 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:47196 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726736AbfEPOPE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 10:15:04 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ABACE1A25;
        Thu, 16 May 2019 07:15:04 -0700 (PDT)
Received: from [10.1.196.129] (ostrya.cambridge.arm.com [10.1.196.129])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E34573F7A6;
        Thu, 16 May 2019 07:15:02 -0700 (PDT)
From:   Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Subject: Re: [PATCH v3 09/16] iommu: Introduce guest PASID bind function
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Eric Auger <eric.auger@redhat.com>,
        Alex Williamson <alex.williamson@redhat.com>
Cc:     "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Andriy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <1556922737-76313-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1556922737-76313-10-git-send-email-jacob.jun.pan@linux.intel.com>
Message-ID: <d652546a-c6ca-1cc6-1924-b016bd81a792@arm.com>
Date:   Thu, 16 May 2019 15:14:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1556922737-76313-10-git-send-email-jacob.jun.pan@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacob,

On 03/05/2019 23:32, Jacob Pan wrote:
> +/**
> + * struct gpasid_bind_data - Information about device and guest PASID binding
> + * @gcr3:	Guest CR3 value from guest mm
> + * @pasid:	Process address space ID used for the guest mm
> + * @addr_width:	Guest address width. Paging mode can also be derived.
> + */
> +struct gpasid_bind_data {
> +	__u64 gcr3;
> +	__u32 pasid;
> +	__u32 addr_width;
> +	__u32 flags;
> +#define	IOMMU_SVA_GPASID_SRE	BIT(0) /* supervisor request */
> +	__u8 padding[4];
> +};

Could you wrap this structure into a generic one like we now do for
bind_pasid_table? It would make the API easier to extend, because if we
ever add individual PASID bind on Arm (something I'd like to do for
virtio-iommu, eventually) it will have different parameters, as our
PASID table entry has a lot of fields describing the page table format.

Maybe something like the following would do?

struct gpasid_bind_data {
#define IOMMU_GPASID_BIND_VERSION_1 1
	__u32 version;
#define IOMMU_GPASID_BIND_FORMAT_INTEL_VTD	1
	__u32 format;
	union {
		// the current gpasid_bind_data:
		struct gpasid_bind_intel_vtd vtd;
	};
};

Thanks,
Jean
