Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF4B1C282CE
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 02:33:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6A5B217D4
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 02:33:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726708AbfDKCd6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 22:33:58 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:47368 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726181AbfDKCd5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 22:33:57 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hEPWk-0002SB-Qp; Thu, 11 Apr 2019 02:33:22 +0000
Date:   Thu, 11 Apr 2019 03:33:22 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     "Tobin C. Harding" <tobin@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>,
        Alexander Viro <viro@ftp.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Pekka Enberg <penberg@cs.helsinki.fi>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Christopher Lameter <cl@linux.com>,
        Matthew Wilcox <willy@infradead.org>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Andreas Dilger <adilger@dilger.ca>,
        Waiman Long <longman@redhat.com>,
        Tycho Andersen <tycho@tycho.ws>, Theodore Ts'o <tytso@mit.edu>,
        Andi Kleen <ak@linux.intel.com>,
        David Chinner <david@fromorbit.com>,
        Nick Piggin <npiggin@gmail.com>,
        Rik van Riel <riel@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v3 14/15] dcache: Implement partial shrink via Slab
 Movable Objects
Message-ID: <20190411023322.GD2217@ZenIV.linux.org.uk>
References: <20190411013441.5415-1-tobin@kernel.org>
 <20190411013441.5415-15-tobin@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190411013441.5415-15-tobin@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 11, 2019 at 11:34:40AM +1000, Tobin C. Harding wrote:
> +/*
> + * d_isolate() - Dentry isolation callback function.
> + * @s: The dentry cache.
> + * @v: Vector of pointers to the objects to isolate.
> + * @nr: Number of objects in @v.
> + *
> + * The slab allocator is holding off frees. We can safely examine
> + * the object without the danger of it vanishing from under us.
> + */
> +static void *d_isolate(struct kmem_cache *s, void **v, int nr)
> +{
> +	struct dentry *dentry;
> +	int i;
> +
> +	for (i = 0; i < nr; i++) {
> +		dentry = v[i];
> +		__dget(dentry);
> +	}
> +
> +	return NULL;		/* No need for private data */
> +}

Huh?  This is compeletely wrong; what you need is collecting the ones
with zero refcount (and not on shrink lists) into a private list.
*NOT* bumping the refcounts at all.  And do it in your isolate thing.

> +static void d_partial_shrink(struct kmem_cache *s, void **v, int nr,
> +		      int node, void *_unused)
> +{
> +	struct dentry *dentry;
> +	LIST_HEAD(dispose);
> +	int i;
> +
> +	for (i = 0; i < nr; i++) {
> +		dentry = v[i];
> +		spin_lock(&dentry->d_lock);
> +		dentry->d_lockref.count--;
> +
> +		if (dentry->d_lockref.count > 0 ||
> +		    dentry->d_flags & DCACHE_SHRINK_LIST) {
> +			spin_unlock(&dentry->d_lock);
> +			continue;
> +		}
> +
> +		if (dentry->d_flags & DCACHE_LRU_LIST)
> +			d_lru_del(dentry);
> +
> +		d_shrink_add(dentry, &dispose);
> +
> +		spin_unlock(&dentry->d_lock);
> +	}

Basically, that loop (sans jerking the refcount up and down) should
get moved into d_isolate().
> +
> +	if (!list_empty(&dispose))
> +		shrink_dentry_list(&dispose);
> +}

... with this left in d_partial_shrink().  And you obviously need some way
to pass the list from the former to the latter...
