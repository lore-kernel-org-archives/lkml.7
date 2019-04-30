Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7D77C43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 17:58:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B146F21670
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 17:58:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbfD3R6Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 13:58:24 -0400
Received: from mga07.intel.com ([134.134.136.100]:46177 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726073AbfD3R6Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 13:58:24 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Apr 2019 10:58:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,414,1549958400"; 
   d="scan'208";a="166347217"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by fmsmga002.fm.intel.com with ESMTP; 30 Apr 2019 10:58:22 -0700
Date:   Tue, 30 Apr 2019 11:01:08 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Eric Auger <eric.auger@redhat.com>
Cc:     eric.auger.pro@gmail.com, joro@8bytes.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        dwmw2@infradead.org, jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH] iommu/vt-d: Fix intel_pasid_max_id
Message-ID: <20190430110108.7c751195@jacob-builder>
In-Reply-To: <20190430072940.10467-1-eric.auger@redhat.com>
References: <20190430072940.10467-1-eric.auger@redhat.com>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Apr 2019 09:29:40 +0200
Eric Auger <eric.auger@redhat.com> wrote:

> Extended Capability Register PSS field (PASID Size Supported)
> corresponds to the PASID bit size -1.
> 
> "A value of N in this field indicates hardware supports PASID
> field of N+1 bits (For example, value of 7 in this field,
> indicates 8-bit PASIDs are supported)".
> 
> Fix the computation of intel_pasid_max_id accordingly.
> 
> Fixes: 562831747f62 ("iommu/vt-d: Global PASID name space")
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> ---
>  drivers/iommu/intel-iommu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> index 28cb713d728c..c3f1bfc81d2e 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -3331,7 +3331,7 @@ static int __init init_dmars(void)
>  		 * than the smallest supported.
>  		 */
>  		if (pasid_supported(iommu)) {
> -			u32 temp = 2 << ecap_pss(iommu->ecap);
> +			u32 temp = 2 << (ecap_pss(iommu->ecap) + 1);
here it is "2 << bits" not "1 << bits", so the original code is correct.

But I agree it would be more clear to the spec. if we do:
1 << (ecap_pss(iommu->ecap) + 1);
>  
>  			intel_pasid_max_id = min_t(u32, temp,
>  						   intel_pasid_max_id);

