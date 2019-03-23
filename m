Return-Path: <SRS0=q9dy=R2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC48BC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 06:06:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B60D218E2
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 06:06:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="YIBkx3NH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726430AbfCWGFx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Mar 2019 02:05:53 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:2974 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725838AbfCWGFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Mar 2019 02:05:52 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c95ccc10000>; Fri, 22 Mar 2019 23:05:53 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 22 Mar 2019 23:05:50 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 22 Mar 2019 23:05:50 -0700
Received: from [10.2.160.106] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sat, 23 Mar
 2019 06:05:50 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Yang Shi <yang.shi@linux.alibaba.com>
CC:     <mhocko@suse.com>, <mgorman@techsingularity.net>,
        <riel@surriel.com>, <hannes@cmpxchg.org>,
        <akpm@linux-foundation.org>, <dave.hansen@intel.com>,
        <keith.busch@intel.com>, <dan.j.williams@intel.com>,
        <fengguang.wu@intel.com>, <fan.du@intel.com>,
        <ying.huang@intel.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 06/10] mm: vmscan: demote anon DRAM pages to PMEM node
Date:   Fri, 22 Mar 2019 23:03:13 -0700
X-Mailer: MailMate (1.12.4r5614)
Message-ID: <B4EB750E-482B-4E4D-A679-4821E57C172E@nvidia.com>
In-Reply-To: <1553316275-21985-7-git-send-email-yang.shi@linux.alibaba.com>
References: <1553316275-21985-1-git-send-email-yang.shi@linux.alibaba.com>
 <1553316275-21985-7-git-send-email-yang.shi@linux.alibaba.com>
MIME-Version: 1.0
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL108.nvidia.com (172.18.146.13) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: multipart/signed;
        boundary="=_MailMate_05B36A0E-F195-4C84-A85B-41F79D06720F_=";
        micalg=pgp-sha1; protocol="application/pgp-signature"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1553321153; bh=hKQ8kZEdSmog1++4ymlzwB1elhI7efPVvOFvmYPwcMA=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:X-Mailer:Message-ID:
         In-Reply-To:References:MIME-Version:X-Originating-IP:
         X-ClientProxiedBy:Content-Type;
        b=YIBkx3NHxrN3JTF4Qe+FxQPpwHMCUpdy12HqzkmIj8UgIfFu8oO3bX+1DB4yOd+5U
         tgU9ImjesCIbrJH9O471bUF7DGVrJZX0PHGIl2wf3egz3INTB7HT38DOpNUFA+DcBY
         qsF5pqptWkDVlc/n4D91eFRx627L3Kszz17QP6PE4PHjRb6Bwsq4rHSPQx7OhbdBV+
         r8PeZDHBbONL5eHTZirUfdj1/5+xThDwgj1p1XwV6Ia3B55MMKbXgfTBlC1FCpomjs
         T6RLK65gBwg3vN+VZr7n30MpOrz3eEis8/sheEFDTNlGaVLP7U1GUU+zioohe6ev0k
         xfL6EISCS+PWQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_05B36A0E-F195-4C84-A85B-41F79D06720F_=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 22 Mar 2019, at 21:44, Yang Shi wrote:

> Since PMEM provides larger capacity than DRAM and has much lower
> access latency than disk, so it is a good choice to use as a middle
> tier between DRAM and disk in page reclaim path.
>
> With PMEM nodes, the demotion path of anonymous pages could be:
>
> DRAM -> PMEM -> swap device
>
> This patch demotes anonymous pages only for the time being and demote
> THP to PMEM in a whole.  However this may cause expensive page reclaim
> and/or compaction on PMEM node if there is memory pressure on it.  But,=

> considering the capacity of PMEM and allocation only happens on PMEM
> when PMEM is specified explicity, such cases should be not that often.
> So, it sounds worth keeping THP in a whole instead of splitting it.
>
> Demote pages to the cloest non-DRAM node even though the system is
> swapless.  The current logic of page reclaim just scan anon LRU when
> swap is on and swappiness is set properly.  Demoting to PMEM doesn't
> need care whether swap is available or not.  But, reclaiming from PMEM
> still skip anon LRU is swap is not available.
>
> The demotion just happens between DRAM node and its cloest PMEM node.
> Demoting to a remote PMEM node is not allowed for now.
>
> And, define a new migration reason for demotion, called MR_DEMOTE.
> Demote page via async migration to avoid blocking.
>
> Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
> ---
>  include/linux/migrate.h        |  1 +
>  include/trace/events/migrate.h |  3 +-
>  mm/debug.c                     |  1 +
>  mm/internal.h                  | 22 ++++++++++
>  mm/vmscan.c                    | 99 ++++++++++++++++++++++++++++++++++=
--------
>  5 files changed, 107 insertions(+), 19 deletions(-)
>
> diff --git a/include/linux/migrate.h b/include/linux/migrate.h
> index e13d9bf..78c8dda 100644
> --- a/include/linux/migrate.h
> +++ b/include/linux/migrate.h
> @@ -25,6 +25,7 @@ enum migrate_reason {
>  	MR_MEMPOLICY_MBIND,
>  	MR_NUMA_MISPLACED,
>  	MR_CONTIG_RANGE,
> +	MR_DEMOTE,
>  	MR_TYPES
>  };
>
> diff --git a/include/trace/events/migrate.h b/include/trace/events/migr=
ate.h
> index 705b33d..c1d5b36 100644
> --- a/include/trace/events/migrate.h
> +++ b/include/trace/events/migrate.h
> @@ -20,7 +20,8 @@
>  	EM( MR_SYSCALL,		"syscall_or_cpuset")		\
>  	EM( MR_MEMPOLICY_MBIND,	"mempolicy_mbind")		\
>  	EM( MR_NUMA_MISPLACED,	"numa_misplaced")		\
> -	EMe(MR_CONTIG_RANGE,	"contig_range")
> +	EM( MR_CONTIG_RANGE,	"contig_range")			\
> +	EMe(MR_DEMOTE,		"demote")
>
>  /*
>   * First define the enums in the above macros to be exported to usersp=
ace
> diff --git a/mm/debug.c b/mm/debug.c
> index c0b31b6..cc0d7df 100644
> --- a/mm/debug.c
> +++ b/mm/debug.c
> @@ -25,6 +25,7 @@
>  	"mempolicy_mbind",
>  	"numa_misplaced",
>  	"cma",
> +	"demote",
>  };
>
>  const struct trace_print_flags pageflag_names[] =3D {
> diff --git a/mm/internal.h b/mm/internal.h
> index 46ad0d8..0152300 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -303,6 +303,19 @@ static inline int find_next_best_node(int node, no=
demask_t *used_node_mask,
>  }
>  #endif
>
> +static inline bool has_nonram_online(void)
> +{
> +	int i =3D 0;
> +
> +	for_each_online_node(i) {
> +		/* Have PMEM node online? */
> +		if (!node_isset(i, def_alloc_nodemask))
> +			return true;
> +	}
> +
> +	return false;
> +}
> +
>  /* mm/util.c */
>  void __vma_link_list(struct mm_struct *mm, struct vm_area_struct *vma,=

>  		struct vm_area_struct *prev, struct rb_node *rb_parent);
> @@ -565,5 +578,14 @@ static inline bool is_migrate_highatomic_page(stru=
ct page *page)
>  }
>
>  void setup_zone_pageset(struct zone *zone);
> +
> +#ifdef CONFIG_NUMA
>  extern struct page *alloc_new_node_page(struct page *page, unsigned lo=
ng node);
> +#else
> +static inline struct page *alloc_new_node_page(struct page *page,
> +					       unsigned long node)
> +{
> +	return NULL;
> +}
> +#endif
>  #endif	/* __MM_INTERNAL_H */
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index a5ad0b3..bdcab6b 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -1094,6 +1094,19 @@ static void page_check_dirty_writeback(struct pa=
ge *page,
>  		mapping->a_ops->is_dirty_writeback(page, dirty, writeback);
>  }
>
> +static inline bool is_demote_ok(struct pglist_data *pgdat)
> +{
> +	/* Current node is not DRAM node */
> +	if (!node_isset(pgdat->node_id, def_alloc_nodemask))
> +		return false;
> +
> +	/* No online PMEM node */
> +	if (!has_nonram_online())
> +		return false;
> +
> +	return true;
> +}
> +
>  /*
>   * shrink_page_list() returns the number of reclaimed pages
>   */
> @@ -1106,6 +1119,7 @@ static unsigned long shrink_page_list(struct list=
_head *page_list,
>  {
>  	LIST_HEAD(ret_pages);
>  	LIST_HEAD(free_pages);
> +	LIST_HEAD(demote_pages);
>  	unsigned nr_reclaimed =3D 0;
>
>  	memset(stat, 0, sizeof(*stat));
> @@ -1262,6 +1276,22 @@ static unsigned long shrink_page_list(struct lis=
t_head *page_list,
>  		}
>
>  		/*
> +		 * Demote DRAM pages regardless the mempolicy.
> +		 * Demot anonymous pages only for now and skip MADV_FREE

s/Demot/Demote

> +		 * pages.
> +		 */
> +		if (PageAnon(page) && !PageSwapCache(page) &&
> +		    (node_isset(page_to_nid(page), def_alloc_nodemask)) &&
> +		    PageSwapBacked(page)) {
> +
> +			if (has_nonram_online()) {
> +				list_add(&page->lru, &demote_pages);
> +				unlock_page(page);
> +				continue;
> +			}
> +		}
> +
> +		/*
>  		 * Anonymous process memory has backing store?
>  		 * Try to allocate it some swap space here.
>  		 * Lazyfree page could be freed directly
> @@ -1477,6 +1507,25 @@ static unsigned long shrink_page_list(struct lis=
t_head *page_list,
>  		VM_BUG_ON_PAGE(PageLRU(page) || PageUnevictable(page), page);
>  	}
>
> +	/* Demote pages to PMEM */
> +	if (!list_empty(&demote_pages)) {
> +		int err, target_nid;
> +		nodemask_t used_mask;
> +
> +		nodes_clear(used_mask);
> +		target_nid =3D find_next_best_node(pgdat->node_id, &used_mask,
> +						 true);
> +
> +		err =3D migrate_pages(&demote_pages, alloc_new_node_page, NULL,
> +				    target_nid, MIGRATE_ASYNC, MR_DEMOTE);
> +
> +		if (err) {
> +			putback_movable_pages(&demote_pages);
> +
> +			list_splice(&ret_pages, &demote_pages);
> +		}
> +	}
> +

I like your approach here. It reuses the existing migrate_pages() interfa=
ce without
adding extra code. I also would like to be CC=E2=80=99d in your future ve=
rsions.

Thank you.

--
Best Regards,
Yan Zi

--=_MailMate_05B36A0E-F195-4C84-A85B-41F79D06720F_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBAgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAlyVzCEPHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqKzIQP/Rs4EavZA7quvdXZxp6jlABmAeeSw3BiYEwL
98gsh5fjHXDNos3fvyvlLRtMIKuES8ob7F96aApHFPYonfrLWTMuvsHjvE4gZBkK
nCKJMUq7+PzhBRGhr6nIBcvD6/3sctoF8J0RboTCtAcSdpUhUFT6jVe4Z6brwql4
eJtKpWDCeXduiMJKaLEEjkIfvr7blzjPRJiPvn60ySCxbZaEYaXT3fmVoUSLvoMh
bf7po9Gfjbx+hf8WuvlHGDjv8bQ1C0krN4xreerPecso7vI1AGCyJ0I4HxMw8iat
yKsUZlz/ee+edM3uJ3U7AnWlHV/Z2bP2D/xoTlwFodLgDHvf9V7X8/Mqkmj3H1Tz
PgUeywfzjMe6f0ihqj/fufTbG1Cx5ZRF8C9OJJ4Ix2g9Nz/ptD3gLlOywYUACWbI
Q/9E4zh50sliNP0tPAUjGsiRumawxjeRoHM/f5kkDA/ab5+F7yV9XoEjmoc3UNLg
omcDHDIMIeva0/7Nnj7+jtgzRegJE6lUT8vKDmBLPCRLPa3fC3b7INfmSHo5VBQK
an6GJmibx0WW82eIyLPTI9oChQ00g18x+MtGivqWTOI5BeN0gFaXJrEdBMT5z2BY
5v9eCo7kibDdygYvmJtepplUursw9UJNt7QkDsME1aRZOfqTy1k39C8gooShIPPz
xmuI8jmc
=VPuK
-----END PGP SIGNATURE-----

--=_MailMate_05B36A0E-F195-4C84-A85B-41F79D06720F_=--
