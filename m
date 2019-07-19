Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5768FC76188
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 04:34:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39DB22173B
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 04:34:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732614AbfGSEeo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 00:34:44 -0400
Received: from mga07.intel.com ([134.134.136.100]:22524 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731387AbfGSEem (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 00:34:42 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Jul 2019 21:34:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,280,1559545200"; 
   d="scan'208";a="168447576"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
  by fmsmga008.fm.intel.com with ESMTP; 18 Jul 2019 21:34:40 -0700
Date:   Thu, 18 Jul 2019 21:34:40 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     john.hubbard@gmail.com
Cc:     pavel@ucw.cz, SCheung@nvidia.com, akpm@linux-foundation.org,
        aneesh.kumar@linux.vnet.ibm.com, benh@kernel.crashing.org,
        bsingharora@gmail.com, dan.j.williams@intel.com,
        dnellans@nvidia.com, ebaskakov@nvidia.com, hannes@cmpxchg.org,
        jglisse@redhat.com, jhubbard@nvidia.com,
        kirill.shutemov@linux.intel.com, linux-kernel@vger.kernel.org,
        liubo95@huawei.com, mhairgrove@nvidia.com, mhocko@kernel.org,
        paulmck@linux.vnet.ibm.com, ross.zwisler@linux.intel.com,
        sgutti@nvidia.com, torvalds@linux-foundation.org,
        vdavydov.dev@gmail.com, Jason Gunthorpe <jgg@ziepe.ca>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] mm/Kconfig: additional help text for HMM_MIRROR option
Message-ID: <20190719043439.GA26230@iweiny-DESK2.sc.intel.com>
References: <20190717074124.GA21617@amd>
 <20190719013253.17642-1-jhubbard@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190719013253.17642-1-jhubbard@nvidia.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 18, 2019 at 06:32:53PM -0700, john.hubbard@gmail.com wrote:
> From: John Hubbard <jhubbard@nvidia.com>
> 
> The HMM_MIRROR option in Kconfig is a little underdocumented and
> mysterious, and leaves people wondering whether to enable it.
> 
> Add text explaining just a little bit more about HMM, and also
> mention which hardware would benefit from having HMM_MIRROR
> enabled.
> 
> Suggested-by: Pavel Machek <pavel@ucw.cz>
> Cc: Balbir Singh <bsingharora@gmail.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: Jerome Glisse <jglisse@redhat.com>
> Cc: Christoph Hellwig <hch@infradead.org>
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> ---
> 
> Hi Pavel and all, does this help? I've tried to capture the key missing bits
> of documentation, but still keep it small, for Kconfig.
> 
> thanks,
> John Hubbard
> NVIDIA
> 
>  mm/Kconfig | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)
> 
> diff --git a/mm/Kconfig b/mm/Kconfig
> index 56cec636a1fc..2fcb92e7f696 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -681,11 +681,18 @@ config HMM_MIRROR
>  	depends on MMU && 64BIT
>  	select MMU_NOTIFIER
>  	help
> -	  Select HMM_MIRROR if you want to mirror range of the CPU page table of a
> -	  process into a device page table. Here, mirror means "keep synchronized".
> -	  Prerequisites: the device must provide the ability to write-protect its
> -	  page tables (at PAGE_SIZE granularity), and must be able to recover from
> -	  the resulting potential page faults.
> +	  This is Heterogeneous Memory Management (HMM) process address space
> +	  mirroring.
> +
> +	  HMM_MIRROR provides a way to mirror ranges of the CPU page tables
> +	  of a process into a device page table. Here, mirror means "keep
> +	  synchronized". Prerequisites: the device must provide the ability
> +	  to write-protect its page tables (at PAGE_SIZE granularity), and
> +	  must be able to recover from the resulting potential page faults.
> +
> +	  Select HMM_MIRROR if you have hardware that meets the above
> +	  description. An early, partial list of such hardware is:
> +	  an NVIDIA GPU >= Pascal, Mellanox IB >= mlx5, or an AMD GPU.

I don't think we want to put device information here.  If we want that
information in Kconfig best to put it in the devices themselves.  Otherwise
this list will get stale.

Other than that, looks good.

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

Ira

>  
>  config DEVICE_PRIVATE
>  	bool "Unaddressable device memory (GPU memory, ...)"
> -- 
> 2.22.0
> 
