Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4754BC3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 16:03:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18FC422CF7
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 16:03:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Rvuoapxk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728507AbfHUQDz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 12:03:55 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:46572 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727480AbfHUQDz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 12:03:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Zq1a5uBxUQfhNMZnyTgJ8zIvvsyMgCBOUCJjgagGUx0=; b=RvuoapxkDacpXRLaU4LRAYH8Y
        yUIW1IsIhZhruBCvjfHhpBdOJPnBYeXmLkNQUUVQV5tidZ5vJtYsuvDmvP3s13LN+snNOp0q9zeGW
        NlmIE0CGD6rhQJTt+osCJaXzJKQvYJ+vefpYDPSzm0rkZ59MLdxzgz6EtwRZeF8p+tQLHW2OsdYoW
        fDkONFSNu0elt11zzctWeQ+V1F5QbxlV56k5HYx93rxKOr6ixpmp5db190Sf+92rEUpJYmOB4rmYf
        WKdlxS9GLrlHO7K5iCTCsYOcv5UQA/N6uNQES+foT9pVycHuBRwB/1eT6ihzhQrIjKE7GwLCTgWL2
        PaVG8//0Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i0T5S-0006P4-E5; Wed, 21 Aug 2019 16:03:50 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4F45D307456;
        Wed, 21 Aug 2019 18:03:16 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0187020A21FC5; Wed, 21 Aug 2019 18:03:47 +0200 (CEST)
Date:   Wed, 21 Aug 2019 18:03:47 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     mingo@kernel.org, tglx@linutronix.de, walken@google.com,
        akpm@linux-foundation.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, Davidlohr Bueso <dbueso@suse.de>
Subject: Re: [PATCH 1/3] x86,mm/pat: Use generic interval trees
Message-ID: <20190821160347.GB2332@hirez.programming.kicks-ass.net>
References: <20190813224620.31005-1-dave@stgolabs.net>
 <20190813224620.31005-2-dave@stgolabs.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190813224620.31005-2-dave@stgolabs.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 13, 2019 at 03:46:18PM -0700, Davidlohr Bueso wrote:

> diff --git a/arch/x86/mm/pat_rbtree.c b/arch/x86/mm/pat_rbtree.c
> index fa16036fa592..1be4d1856a9b 100644
> --- a/arch/x86/mm/pat_rbtree.c
> +++ b/arch/x86/mm/pat_rbtree.c

> @@ -34,68 +34,41 @@
>   * memtype_lock protects the rbtree.
>   */
>  
> +static struct rb_root_cached memtype_rbroot = RB_ROOT_CACHED;
> +
> +#define START(node) ((node)->start)
> +#define END(node)  ((node)->end)

Afaict these could actually be inlines, but I see other interval tree
users also use macros for them, albeit with END called LAST.

> +INTERVAL_TREE_DEFINE(struct memtype, rb, u64, subtree_max_end,
> +		     START, END, static, memtype_interval)
>  
>  static int is_node_overlap(struct memtype *node, u64 start, u64 end)
>  {
> +	/*
> +	 * Unlike generic interval trees, the memtype nodes are ]a, b[
> +	 * therefore we need to adjust the ranges accordingly. Missing
> +	 * an overlap can lead to incorrectly detecting conflicts,
> +	 * for example.
> +	 */
> +	if (node->start + 1 >= end || node->end - 1 <= start)
>  		return 0;
>  
>  	return 1;
>  }

I've not looked yet; but how horrible would it be to change that
weirdness?

> @@ -149,10 +116,8 @@ static int memtype_rb_check_conflict(struct rb_root *root,
>  	dprintk("Overlap at 0x%Lx-0x%Lx\n", match->start, match->end);
>  	found_type = match->type;
>  
> +        match = memtype_interval_iter_next(match, start, end);
> +	while (match) {

whilespace fail

>  		if (match->start >= end) /* Checked all possible matches */
>  			goto success;
>  

> @@ -176,43 +141,21 @@ static int memtype_rb_check_conflict(struct rb_root *root,
>  	return -EBUSY;
>  }
>  
>  int rbt_memtype_check_insert(struct memtype *new,
>  			     enum page_cache_mode *ret_type)
>  {
> +	int err;
>  
> +	err =  memtype_rb_check_conflict(&memtype_rbroot,
> +					 new->start, new->end,
> +					 new->type, ret_type);

whitespace fail

> +	if (err)
> +		return err;
>  
> +	if (ret_type)
> +		new->type = *ret_type;
>  
> +	memtype_interval_insert(new, &memtype_rbroot);
>  	return err;
>  }
>  
