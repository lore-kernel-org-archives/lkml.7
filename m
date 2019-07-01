Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7C11C5B578
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 07:31:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1ECE208C4
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 07:31:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="0Eixzljw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727889AbfGAHbx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 03:31:53 -0400
Received: from merlin.infradead.org ([205.233.59.134]:32814 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727875AbfGAHbw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 03:31:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=/s6BddWV40OunpkvgQIYOukJh4SbQqGq1MXW5rPpXYI=; b=0Eixzljwdho73z+KsUVS2xPTX
        12ON9TT81TA1RKigtW2g1qXVPm6wS++Zf6TDSnLtDgLsTSkqIu8NapJ4n4OK3SXn7wuWvNMVeLbe5
        DZAF2rpT7DGNSt8HULAG8gzoPPyK9Amz7z+gIL1BCloViHtzNVA4LDht5FbvHg3t02JgaqQ0fWot6
        7cnzRSSiRJFl8JJW5Kapcl1Zmk7Z4uHURNggpJikH48rv7/9Qn3YVNHIV5Hw3CHTr2QkgePAhbvCf
        gLuNSVa2liM180Mh3k7Q1r+pzGaLiThCfjsqLoZm2TyWD7fY5ZXo7fCousCeeAjmVAWPPf9LKS3k7
        +oVFJUFnA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hhqmq-0004LF-J8; Mon, 01 Jul 2019 07:31:41 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BA4D220A87D66; Mon,  1 Jul 2019 09:31:37 +0200 (CEST)
Date:   Mon, 1 Jul 2019 09:31:37 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Michel Lespinasse <walken@google.com>
Cc:     Davidlohr Bueso <dave@stgolabs.net>,
        David Howells <dhowells@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] augmented rbtree: rework the RB_DECLARE_CALLBACKS
 macro definition
Message-ID: <20190701073137.GL3402@hirez.programming.kicks-ass.net>
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
> --- a/tools/include/linux/rbtree_augmented.h
> +++ b/tools/include/linux/rbtree_augmented.h
> @@ -74,39 +74,48 @@ rb_insert_augmented_cached(struct rb_node *node,
>  			      newleft, &root->rb_leftmost, augment->rotate);
>  }
>  
> -#define RB_DECLARE_CALLBACKS(rbstatic, rbname, rbstruct, rbfield,	\
> -			     rbtype, rbaugmented, rbcompute)		\
> +/*
> + * Template for declaring augmented rbtree callbacks
> + *
> + * RBSTRUCT:    struct type of the tree nodes
> + * RBFIELD:     name of struct rb_node field within RBSTRUCT
> + * RBAUGMENTED: name of field within RBSTRUCT holding data for subtree
> + * RBCOMPUTE:   name of function that recomputes the RBAUGMENTED data
> + * RBSTATIC:    'static' or empty
> + * RBNAME:      name of the rb_augment_callbacks structure
> + */
> +
> +#define RB_DECLARE_CALLBACKS(RBSTRUCT, RBFIELD, RBAUGMENTED, RBCOMPUTE,	\
> +			     RBSTATIC, RBNAME)				\
>  static inline void							\
> -rbname ## _propagate(struct rb_node *rb, struct rb_node *stop)		\
> +RBNAME ## _propagate(struct rb_node *rb, struct rb_node *stop)		\
>  {									\
>  	while (rb != stop) {						\
> -		rbstruct *node = rb_entry(rb, rbstruct, rbfield);	\
> -		rbtype augmented = rbcompute(node);			\
> -		if (node->rbaugmented == augmented)			\
> +		RBSTRUCT *node = rb_entry(rb, RBSTRUCT, RBFIELD);	\
> +		if (RBCOMPUTE(node, true))				\
>  			break;						\
> -		node->rbaugmented = augmented;				\
> -		rb = rb_parent(&node->rbfield);				\
> +		rb = rb_parent(&node->RBFIELD);				\
>  	}								\
>  }									\
>  static inline void							\
> -rbname ## _copy(struct rb_node *rb_old, struct rb_node *rb_new)		\
> +RBNAME ## _copy(struct rb_node *rb_old, struct rb_node *rb_new)		\
>  {									\
> -	rbstruct *old = rb_entry(rb_old, rbstruct, rbfield);		\
> -	rbstruct *new = rb_entry(rb_new, rbstruct, rbfield);		\
> -	new->rbaugmented = old->rbaugmented;				\
> +	RBSTRUCT *old = rb_entry(rb_old, RBSTRUCT, RBFIELD);		\
> +	RBSTRUCT *new = rb_entry(rb_new, RBSTRUCT, RBFIELD);		\
> +	new->RBAUGMENTED = old->RBAUGMENTED;				\
>  }									\
>  static void								\
> -rbname ## _rotate(struct rb_node *rb_old, struct rb_node *rb_new)	\
> +RBNAME ## _rotate(struct rb_node *rb_old, struct rb_node *rb_new)	\
>  {									\
> -	rbstruct *old = rb_entry(rb_old, rbstruct, rbfield);		\
> -	rbstruct *new = rb_entry(rb_new, rbstruct, rbfield);		\
> -	new->rbaugmented = old->rbaugmented;				\
> -	old->rbaugmented = rbcompute(old);				\
> +	RBSTRUCT *old = rb_entry(rb_old, RBSTRUCT, RBFIELD);		\
> +	RBSTRUCT *new = rb_entry(rb_new, RBSTRUCT, RBFIELD);		\
> +	new->RBAUGMENTED = old->RBAUGMENTED;				\
> +	RBCOMPUTE(old, false);						\
>  }									\
> -rbstatic const struct rb_augment_callbacks rbname = {			\
> -	.propagate = rbname ## _propagate,				\
> -	.copy = rbname ## _copy,					\
> -	.rotate = rbname ## _rotate					\
> +RBSTATIC const struct rb_augment_callbacks RBNAME = {			\
> +	.propagate = RBNAME ## _propagate,				\
> +	.copy = RBNAME ## _copy,					\
> +	.rotate = RBNAME ## _rotate					\
>  };

I'm thinking that should've been in the previous patch.
