Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1723C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 16:08:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B58A206DD
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 16:08:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728760AbfCFQIx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 11:08:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57872 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728633AbfCFQIw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 11:08:52 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 64B02C0528D8;
        Wed,  6 Mar 2019 16:08:52 +0000 (UTC)
Received: from redhat.com (ovpn-125-142.rdu2.redhat.com [10.10.125.142])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6DE781001DCE;
        Wed,  6 Mar 2019 16:08:51 +0000 (UTC)
Date:   Wed, 6 Mar 2019 11:08:48 -0500
From:   Jerome Glisse <jglisse@redhat.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     John Hubbard <jhubbard@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/hmm: fix unused variable warning in hmm_vma_walk_pud
Message-ID: <20190306160847.GA4076@redhat.com>
References: <20190306110109.2386057-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190306110109.2386057-1-arnd@arndb.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Wed, 06 Mar 2019 16:08:52 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 06, 2019 at 12:00:55PM +0100, Arnd Bergmann wrote:
> Without CONFIG_HUGETLB_PAGE, the 'vma' variable is never referenced
> on x86, so we get this warning:
> 
> mm/hmm.c: In function 'hmm_vma_walk_pud':
> mm/hmm.c:764:25: error: unused variable 'vma' [-Werror=unused-variable]
> 
> Remove the local variable by open-coding walk-vma in the only
> place it is used.
> 
> Reported-by: John Hubbard <jhubbard@nvidia.com>
> Suggested-by: John Hubbard <jhubbard@nvidia.com>
> Fixes: 1bed8a07a556 ("mm/hmm: allow to mirror vma of a file on a DAX backed filesystem")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Jérôme Glisse <jglisse@redhat.com>

> ---
> Andrew, you already took a similar patch from me for a different
> warning in the same file. Feel free to fold both patches into
> one if you haven't already forwarded the first patch, or leave
> them separate. Note that the warnings were introduced by different
> patches from the same series originally.
> ---
>  mm/hmm.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/mm/hmm.c b/mm/hmm.c
> index c4beb1628cad..c1cbe82d12b5 100644
> --- a/mm/hmm.c
> +++ b/mm/hmm.c
> @@ -761,7 +761,6 @@ static int hmm_vma_walk_pud(pud_t *pudp,
>  {
>  	struct hmm_vma_walk *hmm_vma_walk = walk->private;
>  	struct hmm_range *range = hmm_vma_walk->range;
> -	struct vm_area_struct *vma = walk->vma;
>  	unsigned long addr = start, next;
>  	pmd_t *pmdp;
>  	pud_t pud;
> @@ -807,7 +806,7 @@ static int hmm_vma_walk_pud(pud_t *pudp,
>  		return 0;
>  	}
>  
> -	split_huge_pud(vma, pudp, addr);
> +	split_huge_pud(walk->vma, pudp, addr);
>  	if (pud_none(*pudp))
>  		goto again;
>  
> -- 
> 2.20.0
> 
