Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43499C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 21:01:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 155C6217D7
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 21:01:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389984AbfDRVB4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 17:01:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59228 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730374AbfDRVB4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 17:01:56 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 997CE301EA86;
        Thu, 18 Apr 2019 21:01:55 +0000 (UTC)
Received: from redhat.com (unknown [10.20.6.236])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D402060BFC;
        Thu, 18 Apr 2019 21:01:49 +0000 (UTC)
Date:   Thu, 18 Apr 2019 17:01:48 -0400
From:   Jerome Glisse <jglisse@redhat.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Maya Gokhale <gokhale2@llnl.gov>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Martin Cracauer <cracauer@cons.org>, Shaohua Li <shli@fb.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Denis Plotnikov <dplotnikov@virtuozzo.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Marty McFadden <mcfadden8@llnl.gov>,
        Mel Gorman <mgorman@suse.de>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH v3 25/28] userfaultfd: wp: fixup swap entries in
 change_pte_range
Message-ID: <20190418210147.GM3288@redhat.com>
References: <20190320020642.4000-1-peterx@redhat.com>
 <20190320020642.4000-26-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190320020642.4000-26-peterx@redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Thu, 18 Apr 2019 21:01:55 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 20, 2019 at 10:06:39AM +0800, Peter Xu wrote:
> In change_pte_range() we do nothing for uffd if the PTE is a swap
> entry.  That can lead to data mismatch if the page that we are going
> to write protect is swapped out when sending the UFFDIO_WRITEPROTECT.
> This patch applies/removes the uffd-wp bit even for the swap entries.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>

This one seems to address some of the comments i made on patch 17
not all thought. Maybe squash them together ?

> ---
> 
> I kept this patch a standalone one majorly to make review easier.  The
> patch can be considered as standalone or to squash into the patch
> "userfaultfd: wp: support swap and page migration".
> ---
>  mm/mprotect.c | 24 +++++++++++++-----------
>  1 file changed, 13 insertions(+), 11 deletions(-)
> 
> diff --git a/mm/mprotect.c b/mm/mprotect.c
> index 96c0f521099d..a23e03053787 100644
> --- a/mm/mprotect.c
> +++ b/mm/mprotect.c
> @@ -183,11 +183,11 @@ static unsigned long change_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
>  			}
>  			ptep_modify_prot_commit(mm, addr, pte, ptent);
>  			pages++;
> -		} else if (IS_ENABLED(CONFIG_MIGRATION)) {
> +		} else if (is_swap_pte(oldpte)) {
>  			swp_entry_t entry = pte_to_swp_entry(oldpte);
> +			pte_t newpte;
>  
>  			if (is_write_migration_entry(entry)) {
> -				pte_t newpte;
>  				/*
>  				 * A protection check is difficult so
>  				 * just be safe and disable write
> @@ -198,22 +198,24 @@ static unsigned long change_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
>  					newpte = pte_swp_mksoft_dirty(newpte);
>  				if (pte_swp_uffd_wp(oldpte))
>  					newpte = pte_swp_mkuffd_wp(newpte);
> -				set_pte_at(mm, addr, pte, newpte);
> -
> -				pages++;
> -			}
> -
> -			if (is_write_device_private_entry(entry)) {
> -				pte_t newpte;
> -
> +			} else if (is_write_device_private_entry(entry)) {
>  				/*
>  				 * We do not preserve soft-dirtiness. See
>  				 * copy_one_pte() for explanation.
>  				 */
>  				make_device_private_entry_read(&entry);
>  				newpte = swp_entry_to_pte(entry);
> -				set_pte_at(mm, addr, pte, newpte);
> +			} else {
> +				newpte = oldpte;
> +			}
>  
> +			if (uffd_wp)
> +				newpte = pte_swp_mkuffd_wp(newpte);
> +			else if (uffd_wp_resolve)
> +				newpte = pte_swp_clear_uffd_wp(newpte);
> +
> +			if (!pte_same(oldpte, newpte)) {
> +				set_pte_at(mm, addr, pte, newpte);
>  				pages++;
>  			}
>  		}
> -- 
> 2.17.1
> 
