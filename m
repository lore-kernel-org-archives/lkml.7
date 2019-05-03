Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64AE3C43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 08:06:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E41220675
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 08:06:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbfECIG1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 04:06:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:57470 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725775AbfECIG1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 04:06:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 690BDAC4F;
        Fri,  3 May 2019 08:06:26 +0000 (UTC)
Date:   Fri, 3 May 2019 10:06:23 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     akpm@linux-foundation.org, Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-nvdimm@lists.01.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 02/12] mm/sparsemem: Introduce common definitions for
 the size and mask of a section
Message-ID: <20190503080622.GD15740@linux>
References: <155677652226.2336373.8700273400832001094.stgit@dwillia2-desk3.amr.corp.intel.com>
 <155677653274.2336373.11220321059915670288.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <155677653274.2336373.11220321059915670288.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 01, 2019 at 10:55:32PM -0700, Dan Williams wrote:
> Up-level the local section size and mask from kernel/memremap.c to
> global definitions.  These will be used by the new sub-section hotplug
> support.
> 
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Jérôme Glisse <jglisse@redhat.com>
> Cc: Logan Gunthorpe <logang@deltatee.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  include/linux/mmzone.h |    2 ++
>  kernel/memremap.c      |   10 ++++------
>  mm/hmm.c               |    2 --
>  3 files changed, 6 insertions(+), 8 deletions(-)
> 
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index f0bbd85dc19a..6726fc175b51 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -1134,6 +1134,8 @@ static inline unsigned long early_pfn_to_nid(unsigned long pfn)
>   * PFN_SECTION_SHIFT		pfn to/from section number
>   */
>  #define PA_SECTION_SHIFT	(SECTION_SIZE_BITS)
> +#define PA_SECTION_SIZE		(1UL << PA_SECTION_SHIFT)
> +#define PA_SECTION_MASK		(~(PA_SECTION_SIZE-1))

As discussed here [1], we do not need the new PA_SECTION_MASK if we work with
pfns/pages directly, so I'd drop it if you go that way.

Besides that:

Reviewed-by: Oscar Salvador <osalvador@suse.de>

[1] https://patchwork.kernel.org/patch/10926047/

-- 
Oscar Salvador
SUSE L3
