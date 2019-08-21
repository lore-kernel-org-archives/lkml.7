Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11835C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 21:57:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C79D1206DD
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 21:57:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OT3JCb4N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731052AbfHUV5M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 17:57:12 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:36289 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728801AbfHUV5M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 17:57:12 -0400
Received: by mail-pl1-f194.google.com with SMTP id f19so2091990plr.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2019 14:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/I4kKN9KvNGTvX2nHzB5sQZYtJle1Kd5XUvJ2SC4AE4=;
        b=OT3JCb4NJoQmdkYSzeFZ2BSWnfhT06HtnCQ9dGbj22FW8HTVgRpHAzRTyxRJyHyD7f
         q3xbFaX82d7Tzw6NsBsqt9FoYsaSfnImYUSPeGMnQlANod+QEsPMwGIBzP930+dJRC+b
         w/HVZ8sYi9x9xqLosn9Kshhqc0NHU6eAqoZan7EF9wwoN2DYRgk8mhQmNgvTIKC4po8v
         8qlbHEg/hPM+hve5xPO6NuKy7lwuXuhZItFkVv2pZYPKGT9BOk1Qe1u+jK2M+3jPDJBe
         SmvyXRmUoOcFGXRJsj72BLqkNsofEge7sltDDPIkyETNYqJP+XiNue8JVXZTklpukVz1
         M8xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/I4kKN9KvNGTvX2nHzB5sQZYtJle1Kd5XUvJ2SC4AE4=;
        b=ZZy8QPPWRw19zN9+z16FRlL5+4osg2U1zz/bFMe6rcNBANSyqr+5GdTACPcAaodiBI
         EdyVwMXm/FUumixjYzuCvMRYNqz+Ng0Ezj8G8CteEUca/p/gF74mJVhyjLv/1uQsmszv
         fGdABrxRA4khdQf4xDyi8wt3/Tz93tHrDqqTOqk//6k8psAt0C1TbY+I8KxucP+9h+I6
         W+oKW8WjDefvEETwaOHir5IDZTEV070ce8cbunpoCqg2Rudf9RFWL09Jw3noJczhklhA
         /tZJFxqe+FbuXEomv3NDgdKpEXJehEM06OAcfsObXe+M/UjUBKZIb5bilWAh8u0nIZWW
         o7fw==
X-Gm-Message-State: APjAAAWIIIujyKA38a3bIshFKX4pFxwzbn6ckUi5HsROLDtJszb2KJRW
        MGgMkcO8Vz/0IlotmcW+cLn4TA==
X-Google-Smtp-Source: APXvYqwhKQ/GF9wmZkWGW+UYOzj/0ObVkh1aND25g4i3zSEouTR/4B/x9OKSuqykHA79VMlMHGNdgg==
X-Received: by 2002:a17:902:29e6:: with SMTP id h93mr14591651plb.39.1566424630412;
        Wed, 21 Aug 2019 14:57:10 -0700 (PDT)
Received: from google.com ([2620:15c:2cd:202:668d:6035:b425:3a3a])
        by smtp.gmail.com with ESMTPSA id u26sm31631624pgl.79.2019.08.21.14.57.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2019 14:57:09 -0700 (PDT)
Date:   Wed, 21 Aug 2019 14:57:07 -0700
From:   Michel Lespinasse <walken@google.com>
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     mingo@kernel.org, tglx@linutronix.de, peterz@infradead.org,
        akpm@linux-foundation.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, Davidlohr Bueso <dbueso@suse.de>
Subject: Re: [PATCH 1/3] x86,mm/pat: Use generic interval trees
Message-ID: <20190821215707.GA99147@google.com>
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
> o The border cases for overlapping differ -- interval trees are closed,
> while memtype intervals are open. We need to maintain semantics such
> that conflict detection and getting the lowest match does not change.

Agree on the need to maintain semantics.

As I had commented some time ago, I wish the interval trees used [start,end)
intervals instead of [start,last] - it would be a better fit for basically
all of the current interval tree users.

I'm not sure where to go with this - would it make sense to add a new
interval tree header file that uses [start,end) intervals (with the
thought of eventually converting all current interval tree users to it)
instead of adding one more use of the less-natural [start,last]
interval trees ?

> diff --git a/arch/x86/mm/pat_rbtree.c b/arch/x86/mm/pat_rbtree.c
> index fa16036fa592..1be4d1856a9b 100644
> --- a/arch/x86/mm/pat_rbtree.c
> +++ b/arch/x86/mm/pat_rbtree.c
> @@ -12,7 +12,7 @@
>  #include <linux/seq_file.h>
>  #include <linux/debugfs.h>
>  #include <linux/kernel.h>
> -#include <linux/rbtree_augmented.h>
> +#include <linux/interval_tree_generic.h>
>  #include <linux/sched.h>
>  #include <linux/gfp.h>
>  
> @@ -34,68 +34,41 @@
>   * memtype_lock protects the rbtree.
>   */
>  
> -static struct rb_root memtype_rbroot = RB_ROOT;
> +static struct rb_root_cached memtype_rbroot = RB_ROOT_CACHED;
> +
> +#define START(node) ((node)->start)
> +#define END(node)  ((node)->end)
> +INTERVAL_TREE_DEFINE(struct memtype, rb, u64, subtree_max_end,
> +		     START, END, static, memtype_interval)
>  
>  static int is_node_overlap(struct memtype *node, u64 start, u64 end)
>  {
> -	if (node->start >= end || node->end <= start)
> +	/*
> +	 * Unlike generic interval trees, the memtype nodes are ]a, b[

I think the memtype nodes are [a, b)  (which one could also write as [a, b[
depending on their local customs - but either way, closed on the start side
and open on the end side) ?

> +	 * therefore we need to adjust the ranges accordingly. Missing
> +	 * an overlap can lead to incorrectly detecting conflicts,
> +	 * for example.
> +	 */
> +	if (node->start + 1 >= end || node->end - 1 <= start)
>  		return 0;
>  
>  	return 1;
>  }

All right, now I am *really* confused.

My understanding is as follows:
* the PAT code wants to use [start, end( intervals
* interval trees are defined to use [start, last] intervals with last == end-1

At first, I thought that you were handling that by removing 1 from the
end of the interval, to adjust between the PAT and interval tree
definitions. But, I don't see you doing that anywhere.

Then, I thought that you were using [start, end( intervals everywhere,
and the interval tree functions memtype_interval_iter_first and
memtype_interval_iter_next would just return too many candidate
matches as as you are passing "end" instead of "last" == end-1 as the
interval endpoint, but then you would filter out the extra intervals
using is_node_overlap(). But, if that is the case, then I don't
understand why you need to redefine is_node_overlap() here.

Could you help me out by defining if the intervals are open or closed,
both when stored in the node->start and node->end values, and when
passed as start and end arguments to the functions in this file ?



Generally, I think using the interval tree code in this file is a good idea,
but 1- I do not understand how you are handling the differences in interval
definitions in this change, and 2- I wonder if it'd be better to just have
a version of the interval tree code that handles [start,end( half-open
intervals like we do everywhere else in the kernel.

-- 
Michel "Walken" Lespinasse
A program is never fully debugged until the last user dies.
