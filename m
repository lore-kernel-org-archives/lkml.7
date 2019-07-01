Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A897DC0650E
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 07:46:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 792C4208E4
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 07:46:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IrPAf6Us"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727982AbfGAHqi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 03:46:38 -0400
Received: from merlin.infradead.org ([205.233.59.134]:32906 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727168AbfGAHqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 03:46:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Sv+lOM3G9W8ujHeG85LNqWSEtkUcSIXP5XrnCYLCpII=; b=IrPAf6Us5K8xBmNUxANmYmyFm
        VAhMuKaLOaEstSWrx2p/G90fJL3zBQIK3EMX0pzUTq0lir0x92jt3FKUhvJtPtUntxYw9texBoYPD
        SvDINHFZRVNQvI4/SVuHR5r4gycA49SpnX2UTmS2nyRIzzjpwnJQrxfEn8CakQRi3+OZhp6fr4+FP
        GK1YK1CyT/A7NuGLJePWL6GSsLQJJfeO55/th6FoP1iUmr+XlW+qYX/rx2CgiJQGIrz5JEgQhebQ5
        z3uAyftsH8ZSwZ4fbmMB+VcEloY4dHlpoxKvezxLLoqIDPASLrZ6hioJlil10fw8X3cGwI3nWHgv7
        oQM2BYL1w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hhr1D-0004P8-W7; Mon, 01 Jul 2019 07:46:32 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A2AEC20A87D66; Mon,  1 Jul 2019 09:46:30 +0200 (CEST)
Date:   Mon, 1 Jul 2019 09:46:30 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Michel Lespinasse <walken@google.com>
Cc:     Davidlohr Bueso <dave@stgolabs.net>,
        David Howells <dhowells@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] augmented rbtree: rework the RB_DECLARE_CALLBACKS
 macro definition
Message-ID: <20190701074630.GM3402@hirez.programming.kicks-ass.net>
References: <20190629004952.6611-1-walken@google.com>
 <20190629004952.6611-3-walken@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190629004952.6611-3-walken@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 28, 2019 at 05:49:52PM -0700, Michel Lespinasse wrote:
> - Change the definition of the RBCOMPUTE function. The propagate
>   callback repeatedly calls RBCOMPUTE as it moves from leaf to root.
>   it wants to stop recomputing once the augmented subtree information
>   doesn't change. This was previously checked using the == operator,
>   but that only works when the augmented subtree information is a
>   scalar field. This commit modifies the RBCOMPUTE function so that
>   it now sets the augmented subtree information instead of returning it,
>   and returns a boolean value indicating if the propagate callback
>   should stop.
> 
> - Reorder the RB_DECLARE_CALLBACKS macro arguments, following the
>   style of the INTERVAL_TREE_DEFINE macro, so that RBSTATIC and RBNAME
>   are passed last.
> 
> The generated code should not change when the RBCOMPUTE function is inlined,
> which is the typical / intended case.

This seems something that shoud (:-) be easy to verify; no reason to be
uncertain about this. Either it does or does not change generated code.

> The motivation for this change is that I want to introduce augmented rbtree
> uses where the augmented data for the subtree is a struct instead of a scalar.
> 
> Signed-off-by: Michel Lespinasse <walken@google.com>

> @@ -66,11 +66,14 @@ static u64 compute_subtree_max_end(struct memtype *data)
>  	if (child_max_end > max_end)
>  		max_end = child_max_end;
>  
> -	return max_end;
> +	if (exit && data->subtree_max_end == max_end)
> +		return true;
> +	data->subtree_max_end = max_end;
> +	return false;
>  }

> @@ -35,11 +35,14 @@ compute_subtree_last(struct drbd_interval *node)
>  		if (right > max)
>  			max = right;
>  	}
> -	return max;
> +	if (exit && node->end == max)
> +		return true;
> +	node->end = max;
> +	return false;
>  }

> @@ -57,11 +58,15 @@ static inline ITTYPE ITPREFIX ## _compute_subtree_last(ITSTRUCT *node)	      \
>  		if (max < subtree_last)					      \
>  			max = subtree_last;				      \
>  	}								      \
> -	return max;							      \
> +	if (exit && node->ITSUBTREE == max)				      \
> +		return true;						      \
> +	node->ITSUBTREE = max;						      \
> +	return false;							      \
>  }									      \

> @@ -91,11 +91,14 @@ static inline u32 augment_recompute(struct test_node *node)
>  		if (max < child_augmented)
>  			max = child_augmented;
>  	}
> -	return max;
> +	if (exit && node->augmented == max)
> +		return true;
> +	node->augmented = max;
> +	return false;
>  }

> @@ -318,7 +318,10 @@ static long vma_compute_subtree_gap(struct vm_area_struct *vma)
>  		if (subtree_gap > max)
>  			max = subtree_gap;
>  	}
> -	return max;
> +	if (exit && vma->rb_subtree_gap == max)
> +		return true;
> +	vma->rb_subtree_gap = max;
> +	return false;
>  }

And that is _really_ unfortunate, as in 5 copies of exactly the same
logic sucks.

Can't we have a helper macro that converts an old (scalar) style compute
into a new style compute and avoid this unfortunate and error prone
copy/pasta ?

Something like:

#define RBCOMPUTE_SCALAR(_comp, _rb _exit)
({
	RBSTRUCT *node = rb_entry((_rb), RBSTRUCT, RBFIELD);
	RBTYPE augmented = _comp(node);
	bool ret = true;
	if (!((_exit) && node->RBAUGMENTED == augmented)) {
		node->RBAUGMENTED = augmented;
		ret = false;
	}
	ret;
})


