Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5ED0C3A5A6
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 09:22:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4C0220882
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 09:22:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="upNinS9k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407056AbfIWJWf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 05:22:35 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:58952 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725816AbfIWJWe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 05:22:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=dnzMY/Kge/UqptUtdwz/i11aQpS5XjfF6hS+xZmxJYs=; b=upNinS9kGBDN5G+UzVvaq1JQx
        Qb3+aczpeSOMsOcMyy9el/f/5/oWOCAoXZc1VWfeDA5+wvAFeSXiZOb2BKFJTD5ppwjC52sNPwJAW
        +EJlMyoHbtYOFMHJzFIGwD39XpiP1BLyHp6QCueEi3eo0otFsh/J7gL+Kfmhgr7G3X9ZuKpox376q
        v1t2ymVjU5CRlTrKwIIlhLaGlk3hC+lM03n+LbVbcEjb7ZZEelAQQ6rFhBbA5zz24ZwxmE60hl34m
        CZZag9EV5zz3ZEaAOcMOK7c3r05nyu8NmIM1WT+fRj38mZe7SHXiNBiK1ErxpWeMe+0Ts65uqjo7n
        +p6aAzIlQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iCKYD-0004q1-IQ; Mon, 23 Sep 2019 09:22:33 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 91418301A7A;
        Mon, 23 Sep 2019 11:21:46 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A333F20C3E177; Mon, 23 Sep 2019 11:22:31 +0200 (CEST)
Date:   Mon, 23 Sep 2019 11:22:31 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Wei Yang <richardw.yang@linux.intel.com>
Cc:     dave.hansen@linux.intel.com, luto@kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] x86/mm: replace a goto by merging two if clause
Message-ID: <20190923092231.GJ2349@hirez.programming.kicks-ass.net>
References: <20190919020844.27461-1-richardw.yang@linux.intel.com>
 <20190919020844.27461-2-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190919020844.27461-2-richardw.yang@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 19, 2019 at 10:08:44AM +0800, Wei Yang wrote:
> There is only one place to use good_area jump, which could be reduced by
> merging the following two if clause.
> 
> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
> ---
>  arch/x86/mm/fault.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
> index 9d18b73b5f77..72ce6c69e195 100644
> --- a/arch/x86/mm/fault.c
> +++ b/arch/x86/mm/fault.c
> @@ -1390,18 +1390,17 @@ void do_user_addr_fault(struct pt_regs *regs,
>  	vma = find_vma(mm, address);
>  	if (unlikely(!vma))
>  		goto bad_area;
> -	if (likely(vma->vm_start <= address))
> -		goto good_area;
> -	if (unlikely(!(vma->vm_flags & VM_GROWSDOWN)))
> -		goto bad_area;
> -	if (unlikely(expand_stack(vma, address)))
> +	if (likely(vma->vm_start <= address)) {
> +		/* good area, do nothing */
> +	} else if (unlikely(!(vma->vm_flags & VM_GROWSDOWN)) ||
> +		   unlikely(expand_stack(vma, address))) {
>  		goto bad_area;
> +	}
>  
>  	/*
>  	 * Ok, we have a good vm_area for this memory access, so
>  	 * we can handle it..
>  	 */
> -good_area:
>  	if (unlikely(access_error(hw_error_code, vma))) {
>  		bad_area_access_error(regs, hw_error_code, address, vma);
>  		return;

I find the old code far easier to read... is there any actual reason to
do this?
