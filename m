Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 471E5ECE588
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 07:51:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26A682082C
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 07:51:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391377AbfJPHvZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 03:51:25 -0400
Received: from 8bytes.org ([81.169.241.247]:47726 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726277AbfJPHvY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 03:51:24 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id BDA7845B; Wed, 16 Oct 2019 09:51:22 +0200 (CEST)
Date:   Wed, 16 Oct 2019 09:51:21 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Yian Chen <yian.chen@intel.com>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-ia64@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>,
        Ashok Raj <ashok.raj@intel.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        Tony Luck <tony.luck@intel.com>
Subject: Re: [PATCH] iommu/vt-d: Check VT-d RMRR region in BIOS is reported
 as reserved
Message-ID: <20191016075120.GB32232@8bytes.org>
References: <20191015164932.18185-1-yian.chen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191015164932.18185-1-yian.chen@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Oct 15, 2019 at 09:49:32AM -0700, Yian Chen wrote:
> VT-d RMRR (Reserved Memory Region Reporting) regions are reserved
> for device use only and should not be part of allocable memory pool of OS.
> 
> BIOS e820_table reports complete memory map to OS, including OS usable
> memory ranges and BIOS reserved memory ranges etc.
> 
> x86 BIOS may not be trusted to include RMRR regions as reserved type
> of memory in its e820 memory map, hence validate every RMRR entry
> with the e820 memory map to make sure the RMRR regions will not be
> used by OS for any other purposes.

Are there real systems in the wild where this is a problem?

> +static inline int __init
> +arch_rmrr_sanity_check(struct acpi_dmar_reserved_memory *rmrr)
> +{
> +	u64 start = rmrr->base_address;
> +	u64 end = rmrr->end_address + 1;
> +
> +	if (e820__mapped_all(start, end, E820_TYPE_RESERVED))
> +		return 0;
> +
> +	pr_err(FW_BUG "No firmware reserved region can cover this RMRR [%#018Lx-%#018Lx], contact BIOS vendor for fixes\n",
> +	       start, end - 1);
> +	return -EFAULT;
> +}

Why -EFAULT, there is no fault involved? Usibg -EINVAL seems to be a better choice.

