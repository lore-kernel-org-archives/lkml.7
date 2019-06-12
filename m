Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6346AC31E44
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 02:29:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DB5720883
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 02:29:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408418AbfFLC3s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 22:29:48 -0400
Received: from mga09.intel.com ([134.134.136.24]:57842 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405046AbfFLC3s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 22:29:48 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Jun 2019 19:29:47 -0700
X-ExtLoop1: 1
Received: from allen-box.sh.intel.com (HELO [10.239.159.136]) ([10.239.159.136])
  by orsmga004.jf.intel.com with ESMTP; 11 Jun 2019 19:29:41 -0700
Cc:     baolu.lu@linux.intel.com, David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Christoph Hellwig <hch@lst.de>, ashok.raj@intel.com,
        jacob.jun.pan@intel.com, alan.cox@intel.com, kevin.tian@intel.com,
        mika.westerberg@linux.intel.com, Ingo Molnar <mingo@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        pengfei.xu@intel.com, Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH v4 6/9] iommu/vt-d: Check whether device requires bounce
 buffer
To:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
References: <20190603011620.31999-1-baolu.lu@linux.intel.com>
 <20190603011620.31999-7-baolu.lu@linux.intel.com>
 <20190610160802.GX28796@char.us.oracle.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <bf973966-d975-9100-475d-bf30dbb99bf6@linux.intel.com>
Date:   Wed, 12 Jun 2019 10:22:33 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190610160802.GX28796@char.us.oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 6/11/19 12:08 AM, Konrad Rzeszutek Wilk wrote:
> On Mon, Jun 03, 2019 at 09:16:17AM +0800, Lu Baolu wrote:
>> This adds a helper to check whether a device needs to use bounce
>> buffer. It also provides a boot time option to disable the bounce
>> buffer. Users can use this to prevent the iommu driver from using
>> the bounce buffer for performance gain.
>> 
>> Cc: Ashok Raj <ashok.raj@intel.com> Cc: Jacob Pan
>> <jacob.jun.pan@linux.intel.com> Cc: Kevin Tian
>> <kevin.tian@intel.com> Signed-off-by: Lu Baolu
>> <baolu.lu@linux.intel.com> Tested-by: Xu Pengfei
>> <pengfei.xu@intel.com> Tested-by: Mika Westerberg
>> <mika.westerberg@intel.com> --- 
>> Documentation/admin-guide/kernel-parameters.txt | 5 +++++ 
>> drivers/iommu/intel-iommu.c                     | 6 ++++++ 2 files
>> changed, 11 insertions(+)
>> 
>> diff --git a/Documentation/admin-guide/kernel-parameters.txt
>> b/Documentation/admin-guide/kernel-parameters.txt index
>> 138f6664b2e2..65685c6e53e4 100644 ---
>> a/Documentation/admin-guide/kernel-parameters.txt +++
>> b/Documentation/admin-guide/kernel-parameters.txt @@ -1728,6
>> +1728,11 @@ Note that using this option lowers the security 
>> provided by tboot because it makes the system vulnerable to DMA
>> attacks. +		nobounce [Default off] +			Do not use the bounce buffer
>> for untrusted devices like +			the Thunderbolt devices. This will
>> treat the untrusted
> 
> My brain has sometimes a hard time parsing 'Not' and 'un'. Could this
> be:
> 
> Disable bounce buffer for unstrusted devices ..?
> 

Fair enough.

> 
> And perhaps call it 'noswiotlb' ? Not everyone knows that SWIOTLB =
> bounce buffer.

As I said in previous thread, swiotlb is not only used for BOUNCE_PAGE
case, but also used by direct dma APIs. Will it cause confusion?

Anyway, I have no strong feeling to use 'nobounce' or 'noswiotlb'. It's
a driver specific switch for debugging purpose. People suggested that we
should move this switch into pci module, but I heard that it's more
helpful to implement per-device switch for "trusted' or "untrusted".
So I kept this untouched in this version.

> 
>> +			devices as the trusted ones, hence might expose security +
>> risks of DMA attacks.
>> 
>> intel_idle.max_cstate=	[KNL,HW,ACPI,X86] 0	disables intel_idle and
>> fall back on acpi_idle. diff --git a/drivers/iommu/intel-iommu.c
>> b/drivers/iommu/intel-iommu.c index 235837c50719..41439647f75d
>> 100644 --- a/drivers/iommu/intel-iommu.c +++
>> b/drivers/iommu/intel-iommu.c @@ -371,6 +371,7 @@ static int
>> dmar_forcedac; static int intel_iommu_strict; static int
>> intel_iommu_superpage = 1; static int iommu_identity_mapping; 
>> +static int intel_no_bounce;
> 
> intel_swiotlb_on = 1 ?
> 
>> 
>> #define IDENTMAP_ALL		1 #define IDENTMAP_GFX		2 @@ -384,6 +385,8 @@
>> EXPORT_SYMBOL_GPL(intel_iommu_gfx_mapped); static
>> DEFINE_SPINLOCK(device_domain_lock); static
>> LIST_HEAD(device_domain_list);
>> 
>> +#define device_needs_bounce(d) (!intel_no_bounce &&
>> dev_is_untrusted(d)) + /* * Iterate over elements in
>> device_domain_list and call the specified * callback @fn against
>> each element. @@ -466,6 +469,9 @@ static int __init
>> intel_iommu_setup(char *str) printk(KERN_INFO "Intel-IOMMU: not
>> forcing on after tboot. This could expose security risk for
>> tboot\n"); intel_iommu_tboot_noforce = 1; +		} else if
>> (!strncmp(str, "nobounce", 8)) { +			pr_info("Intel-IOMMU: No
>> bounce buffer. This could expose security risks of DMA
>> attacks\n");
> 
> Again, Intel-IOMMU: No SWIOTLB. T.. blah blah'
> 
> Asking for this as doing 'dmesg | grep SWIOTLB' will expose nicely
> all the SWIOTLB invocations..

Yes. Will refine this.

Best regards,
Baolu
