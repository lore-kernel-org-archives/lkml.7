Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29D49C4360C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 11:02:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F24B220867
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 11:02:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KPrEoUte"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730534AbfJDLCa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 07:02:30 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46956 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbfJDLC3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 07:02:29 -0400
Received: by mail-pf1-f193.google.com with SMTP id q5so3649385pfg.13
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2019 04:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ku4z59GegrGG+Xfk9fGT7bfSHa3f5Py2+RMuhy3okDg=;
        b=KPrEoUteCeYCa10uT2hn7fB1zM8Hfdoe38fSBpEFWdSxAeLJh80LvNzJLajpVpIDoX
         /iX2Pc4h0WUlJw74gUqIYTXsd3aS3JpzDEJN4AKPyJDVadMhQMAhQX65rEm880pH42Hj
         RDUPDWYlR7XhQrV5eNna2MGYLWZNX2T+y7fgeQXzM+Dxz/CZMJ4zE6dLWnRlkuz6PIRJ
         3FMGaXriotJwSR+ciw2d7MTCGmzZXmNvIox5y5m5J6eI2pmx/Wl3u/ZnGWFP2CReGuxW
         Si5R7xoklkhvvPqrnyQPM5XFBJBvVrldWYSS1IGnZHK7+jErRzs6Bi8Pzy9UgL1Nwh7H
         RCsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ku4z59GegrGG+Xfk9fGT7bfSHa3f5Py2+RMuhy3okDg=;
        b=YBkRE5sVhuhg1G3scw7Hwh1f6vAlgYrufz7IF51THMQExydI0LJ2dZTinFDkxcfWMk
         fonL4oKRpkF/wr79zXAWTchKTBe8UExZ6mI8VMR/BuZyWPYqNY6ex+O0+2mVCbpyUDOT
         RFrKEleRVZJYdp2ZO5KtxJEZyCdLl6WIGLpu/Rdfq4DyX4/NgUMFVGe/AyaaBKm6vg/z
         wPpbnTl4CsX8hm3A3c4eLP2Lf3EGfTb2FcU5wDpoxyMCGNzJlAJ9qGHd9jBzIQTjJIIb
         KJHAlWjvIqnBQ34EzE4ONTJQKNJkCUdkTtNzSVkJicQ6hftHIzB4yPVg5n8yMJYU7zw/
         d7ew==
X-Gm-Message-State: APjAAAXJkMzBxfLfRoNcaZnp2YjYBJGtKsGCQTg1fULdhorIN2mX6LWr
        ZcVCQIabAasNarTnoYgWCBN6+2L5A/c=
X-Google-Smtp-Source: APXvYqx4/60BB+JFHczOGrzL1Al0rm+OY0a+A9pZLRnWECaGlOjJLRWXCmf7DRnwimAuKwz5dG/Qgw==
X-Received: by 2002:a65:5804:: with SMTP id g4mr14680236pgr.362.1570186948359;
        Fri, 04 Oct 2019 04:02:28 -0700 (PDT)
Received: from google.com ([2620:15c:2cd:202:668d:6035:b425:3a3a])
        by smtp.gmail.com with ESMTPSA id v8sm8911794pje.6.2019.10.04.04.02.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2019 04:02:26 -0700 (PDT)
Date:   Fri, 4 Oct 2019 04:02:24 -0700
From:   Michel Lespinasse <walken@google.com>
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     akpm@linux-foundation.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        dri-devel@lists.freedesktop.org, linux-rdma@vger.kernel.org,
        Davidlohr Bueso <dbueso@suse.de>
Subject: Re: [PATCH 02/11] lib/interval-tree: add an equivalent tree with
 [a,b) intervals
Message-ID: <20191004110224.GA253758@google.com>
References: <20191003201858.11666-1-dave@stgolabs.net>
 <20191003201858.11666-3-dave@stgolabs.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191003201858.11666-3-dave@stgolabs.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 03, 2019 at 01:18:49PM -0700, Davidlohr Bueso wrote:
> +/*									      \
> + * Iterate over intervals intersecting [start;end)			      \
> + *									      \
> + * Note that a node's interval intersects [start;end) iff:		      \
> + *   Cond1: ITSTART(node) < end						      \
> + * and									      \
> + *   Cond2: start < ITEND(node)						      \
> + */									      \
> +									      \
> +static ITSTRUCT *							      \
> +ITPREFIX ## _subtree_search(ITSTRUCT *node, ITTYPE start, ITTYPE end)	      \
> +{									      \
> +	while (true) {							      \
> +		/*							      \
> +		 * Loop invariant: start <= node->ITSUBTREE		      \
Should be start < node->ITSUBTREE
> +		 * (Cond2 is satisfied by one of the subtree nodes)	      \
> +		 */							      \
> +		if (node->ITRB.rb_left) {				      \
> +			ITSTRUCT *left = rb_entry(node->ITRB.rb_left,	      \
> +						  ITSTRUCT, ITRB);	      \
> +			if (start < left->ITSUBTREE) {			      \
> +				/*					      \
> +				 * Some nodes in left subtree satisfy Cond2.  \
> +				 * Iterate to find the leftmost such node N.  \
> +				 * If it also satisfies Cond1, that's the     \
> +				 * match we are looking for. Otherwise, there \
> +				 * is no matching interval as nodes to the    \
> +				 * right of N can't satisfy Cond1 either.     \
> +				 */					      \
> +				node = left;				      \
> +				continue;				      \
> +			}						      \
> +		}							      \
> +		if (ITSTART(node) < end) {		/* Cond1 */	      \
> +			if (start < ITEND(node))	/* Cond2 */	      \
> +				return node;	/* node is leftmost match */  \
> +			if (node->ITRB.rb_right) {			      \
> +				node = rb_entry(node->ITRB.rb_right,	      \
> +						ITSTRUCT, ITRB);	      \
> +				if (start <= node->ITSUBTREE)		      \
Should be start < node->ITSUBTREE
> +					continue;			      \
> +			}						      \
> +		}							      \
> +		return NULL;	/* No match */				      \
> +	}								      \
> +}									      \

Other than that, the change looks good to me.

This is something I might use, regardless of the status of converting
other current users.

The name "interval_tree_gen.h" makes it ambiguous wether gen stands
for "generic" or "generator". This may sounds like a criticism,
but it's not - I think it really stands for both :)

Reviewed-by: Michel Lespinasse <walken@google.com>

-- 
Michel "Walken" Lespinasse
A program is never fully debugged until the last user dies.
