Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE13AC3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 08:08:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA7BB20872
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 08:08:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404717AbfIJII2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 04:08:28 -0400
Received: from 8bytes.org ([81.169.241.247]:53684 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393569AbfIJII2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 04:08:28 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 0ED8E386; Tue, 10 Sep 2019 10:08:26 +0200 (CEST)
Date:   Tue, 10 Sep 2019 10:08:23 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Kyung Min Park <kyung.min.park@intel.com>
Cc:     dwmw2@infradead.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, sohil.mehta@intel.com,
        ashok.raj@intel.com, jacob.jun.pan@linux.intel.com,
        baolu.lu@intel.com, andriy.shevchenko@intel.com
Subject: Re: [PATCH] iommu/vt-d: Add Scalable Mode fault information
Message-ID: <20190910080823.GA3247@8bytes.org>
References: <1567793642-17063-1-git-send-email-kyung.min.park@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1567793642-17063-1-git-send-email-kyung.min.park@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 06, 2019 at 11:14:02AM -0700, Kyung Min Park wrote:
> Intel VT-d specification revision 3 added support for Scalable Mode
> Translation for DMA remapping. Add the Scalable Mode fault reasons to
> show detailed fault reasons when the translation fault happens.
> 
> Link: https://software.intel.com/sites/default/files/managed/c5/15/vt-directed-io-spec.pdf
> 
> Reviewed-by: Sohil Mehta <sohil.mehta@intel.com>
> Signed-off-by: Kyung Min Park <kyung.min.park@intel.com>
> ---
>  drivers/iommu/dmar.c        | 77 ++++++++++++++++++++++++++++++++++++++++++---
>  include/linux/intel-iommu.h |  2 ++
>  2 files changed, 75 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iommu/dmar.c b/drivers/iommu/dmar.c
> index 1207e05..5cb63c5 100644
> --- a/drivers/iommu/dmar.c
> +++ b/drivers/iommu/dmar.c
> @@ -1532,6 +1532,64 @@ static const char *dma_remap_fault_reasons[] =
>  	"PCE for translation request specifies blocking",
>  };
>  
> +static const char * const dma_remap_sm_fault_reasons[] = {
> +	"SM: Invalid Root Table Address",
> +	"SM: TTM 0 for request with PASID",
> +	"SM: TTM 0 for page group request",
> +	"Unknown", "Unknown", "Unknown", "Unknown", "Unknown", /* 0x33-0x37 */
> +	"SM: Error attempting to access Root Entry",
> +	"SM: Present bit in Root Entry is clear",
> +	"SM: Non-zero reserved field set in Root Entry",
> +	"Unknown", "Unknown", "Unknown", "Unknown", "Unknown", /* 0x3B-0x3F */
> +	"SM: Error attempting to access Context Entry",
> +	"SM: Present bit in Context Entry is clear",
> +	"SM: Non-zero reserved field set in the Context Entry",
> +	"SM: Invalid Context Entry",
> +	"SM: DTE field in Context Entry is clear",
> +	"SM: PASID Enable field in Context Entry is clear",
> +	"SM: PASID is larger than the max in Context Entry",
> +	"SM: PRE field in Context-Entry is clear",
> +	"SM: RID_PASID field error in Context-Entry",
> +	"Unknown", "Unknown", "Unknown", "Unknown", "Unknown", "Unknown", "Unknown", /* 0x49-0x4F */

Maybe add the number (0x49-0x4f) to the respecting "Unknown" fields? If
we can't give a reason we should give the number for easier debugging in
the future. Same for the "Unknown" fields below.

Other than that, the patch looks good.

Regards,

	Joerg
