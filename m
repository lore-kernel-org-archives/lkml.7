Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 102DCC10F00
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 14:57:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D65CF218D4
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 14:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553180270;
	bh=JWxj8nksQ6TJk06DnuIJpyiELHXjQgIu2lG938gJHBM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=rTaKIIYrFJQn4p0HanYNoHTqC3rR/XvU2bftJrdjvw9B+aZDcethhghegwjbDXalK
	 rUXxD/G1LZICMyOOVNNgCk9GU1tvg53qMV7WvojBTvwcLfah1GRJrwfFryCJsHLOk7
	 0v4TM1GNF/Hbg18WUKRmds3Xl+jfwdaZwv/t5efc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728386AbfCUO5t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 10:57:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:53126 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727922AbfCUO5t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 10:57:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CD105ABDC;
        Thu, 21 Mar 2019 14:57:46 +0000 (UTC)
Date:   Thu, 21 Mar 2019 15:57:45 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Yang Shi <yang.shi@linux.alibaba.com>
Cc:     mgorman@techsingularity.net, vbabka@suse.cz,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] mm: mempolicy: remove MPOL_MF_LAZY
Message-ID: <20190321145745.GS8696@dhcp22.suse.cz>
References: <1553041659-46787-1-git-send-email-yang.shi@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1553041659-46787-1-git-send-email-yang.shi@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 20-03-19 08:27:39, Yang Shi wrote:
> MPOL_MF_LAZY was added by commit b24f53a0bea3 ("mm: mempolicy: Add
> MPOL_MF_LAZY"), then it was disabled by commit a720094ded8c ("mm:
> mempolicy: Hide MPOL_NOOP and MPOL_MF_LAZY from userspace for now")
> right away in 2012.  So, it is never ever exported to userspace.
> 
> And, it looks nobody is interested in revisiting it since it was
> disabled 7 years ago.  So, it sounds pointless to still keep it around.

The above changelog owes us a lot of explanation about why this is
safe and backward compatible. I am also not sure you can change
MPOL_MF_INTERNAL because somebody still might use the flag from
userspace and we want to guarantee it will have the exact same semantic.

> Cc: Mel Gorman <mgorman@techsingularity.net>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
> ---
> Hi folks,
> I'm not sure if you still would like to revisit it later. And, I may be
> not the first one to try to remvoe it. IMHO, it sounds pointless to still
> keep it around if nobody is interested in it.
> 
>  include/uapi/linux/mempolicy.h |  3 +--
>  mm/mempolicy.c                 | 13 -------------
>  2 files changed, 1 insertion(+), 15 deletions(-)
> 
> diff --git a/include/uapi/linux/mempolicy.h b/include/uapi/linux/mempolicy.h
> index 3354774..eb52a7a 100644
> --- a/include/uapi/linux/mempolicy.h
> +++ b/include/uapi/linux/mempolicy.h
> @@ -45,8 +45,7 @@ enum {
>  #define MPOL_MF_MOVE	 (1<<1)	/* Move pages owned by this process to conform
>  				   to policy */
>  #define MPOL_MF_MOVE_ALL (1<<2)	/* Move every page to conform to policy */
> -#define MPOL_MF_LAZY	 (1<<3)	/* Modifies '_MOVE:  lazy migrate on fault */
> -#define MPOL_MF_INTERNAL (1<<4)	/* Internal flags start here */
> +#define MPOL_MF_INTERNAL (1<<3)	/* Internal flags start here */
>  
>  #define MPOL_MF_VALID	(MPOL_MF_STRICT   | 	\
>  			 MPOL_MF_MOVE     | 	\
> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index af171cc..67886f4 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -593,15 +593,6 @@ static int queue_pages_test_walk(unsigned long start, unsigned long end,
>  
>  	qp->prev = vma;
>  
> -	if (flags & MPOL_MF_LAZY) {
> -		/* Similar to task_numa_work, skip inaccessible VMAs */
> -		if (!is_vm_hugetlb_page(vma) &&
> -			(vma->vm_flags & (VM_READ | VM_EXEC | VM_WRITE)) &&
> -			!(vma->vm_flags & VM_MIXEDMAP))
> -			change_prot_numa(vma, start, endvma);
> -		return 1;
> -	}
> -
>  	/* queue pages from current vma */
>  	if (flags & (MPOL_MF_MOVE | MPOL_MF_MOVE_ALL))
>  		return 0;
> @@ -1181,9 +1172,6 @@ static long do_mbind(unsigned long start, unsigned long len,
>  	if (IS_ERR(new))
>  		return PTR_ERR(new);
>  
> -	if (flags & MPOL_MF_LAZY)
> -		new->flags |= MPOL_F_MOF;
> -
>  	/*
>  	 * If we are using the default policy then operation
>  	 * on discontinuous address spaces is okay after all
> @@ -1226,7 +1214,6 @@ static long do_mbind(unsigned long start, unsigned long len,
>  		int nr_failed = 0;
>  
>  		if (!list_empty(&pagelist)) {
> -			WARN_ON_ONCE(flags & MPOL_MF_LAZY);
>  			nr_failed = migrate_pages(&pagelist, new_page, NULL,
>  				start, MIGRATE_SYNC, MR_MEMPOLICY_MBIND);
>  			if (nr_failed)
> -- 
> 1.8.3.1
> 

-- 
Michal Hocko
SUSE Labs
