Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BF9EC43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 19:07:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 034AB20CC7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 19:07:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbfLPTHR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 14:07:17 -0500
Received: from mga09.intel.com ([134.134.136.24]:23800 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726368AbfLPTHR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 14:07:17 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Dec 2019 11:07:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,322,1571727600"; 
   d="scan'208";a="212128531"
Received: from chenyian-desk1.amr.corp.intel.com (HELO [10.3.52.63]) ([10.3.52.63])
  by fmsmga007.fm.intel.com with ESMTP; 16 Dec 2019 11:07:16 -0800
Subject: Re: [PATCH 1/3] iommu/vt-d: skip RMRR entries that fail the sanity
 check
To:     Barret Rhoden <brho@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>,
        Sohil Mehta <sohil.mehta@intel.com>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        x86@kernel.org
References: <20191211194606.87940-1-brho@google.com>
 <20191211194606.87940-2-brho@google.com>
From:   "Chen, Yian" <yian.chen@intel.com>
Message-ID: <99a294a0-444e-81f9-19a2-216aef03f356@intel.com>
Date:   Mon, 16 Dec 2019 11:07:16 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191211194606.87940-2-brho@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/11/2019 11:46 AM, Barret Rhoden wrote:
> RMRR entries describe memory regions that are DMA targets for devices
> outside the kernel's control.
>
> RMRR entries that fail the sanity check are pointing to regions of
> memory that the firmware did not tell the kernel are reserved or
> otherwise should not be used.
>
> Instead of aborting DMAR processing, this commit skips these RMRR
> entries.  They will not be mapped into the IOMMU, but the IOMMU can
> still be utilized.  If anything, when the IOMMU is on, those devices
> will not be able to clobber RAM that the kernel has allocated from those
> regions.
>
> Signed-off-by: Barret Rhoden <brho@google.com>
> ---
>   drivers/iommu/intel-iommu.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> index f168cd8ee570..f7e09244c9e4 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -4316,7 +4316,7 @@ int __init dmar_parse_one_rmrr(struct acpi_dmar_header *header, void *arg)
>   	rmrr = (struct acpi_dmar_reserved_memory *)header;
>   	ret = arch_rmrr_sanity_check(rmrr);
>   	if (ret)
> -		return ret;
> +		return 0;
>   
>   	rmrru = kzalloc(sizeof(*rmrru), GFP_KERNEL);
>   	if (!rmrru)
Parsing rmrr function should report the error to caller. The behavior to 
response the error can be
chose  by the caller in the calling stack, for example, 
dmar_walk_remapping_entries().
A concern is that ignoring a detected firmware bug might have a 
potential side impact though
it seemed safe for your case.

Thanks,
Yian
