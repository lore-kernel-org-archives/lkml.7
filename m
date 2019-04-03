Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAB7FC10F06
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 17:08:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2909D20830
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 17:08:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbfDCRIo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 13:08:44 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:33670 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbfDCRIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 13:08:43 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hBjMx-0003uc-II; Wed, 03 Apr 2019 17:08:11 +0000
Date:   Wed, 3 Apr 2019 18:08:11 +0100
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
        Hugh Dickins <hughd@google.com>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC PATCH v2 14/14] dcache: Implement object migration
Message-ID: <20190403170811.GR2217@ZenIV.linux.org.uk>
References: <20190403042127.18755-1-tobin@kernel.org>
 <20190403042127.18755-15-tobin@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190403042127.18755-15-tobin@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 03, 2019 at 03:21:27PM +1100, Tobin C. Harding wrote:
> The dentry slab cache is susceptible to internal fragmentation.  Now
> that we have Slab Movable Objects we can defragment the dcache.  Object
> migration is only possible for dentry objects that are not currently
> referenced by anyone, i.e. we are using the object migration
> infrastructure to free unused dentries.
> 
> Implement isolate and migrate functions for the dentry slab cache.

> +		/*
> +		 * Three sorts of dentries cannot be reclaimed:
> +		 *
> +		 * 1. dentries that are in the process of being allocated
> +		 *    or being freed. In that case the dentry is neither
> +		 *    on the LRU nor hashed.
> +		 *
> +		 * 2. Fake hashed entries as used for anonymous dentries
> +		 *    and pipe I/O. The fake hashed entries have d_flags
> +		 *    set to indicate a hashed entry. However, the
> +		 *    d_hash field indicates that the entry is not hashed.
> +		 *
> +		 * 3. dentries that have a backing store that is not
> +		 *    writable. This is true for tmpsfs and other in
> +		 *    memory filesystems. Removing dentries from them
> +		 *    would loose dentries for good.
> +		 */
> +		if ((d_unhashed(dentry) && list_empty(&dentry->d_lru)) ||
> +		    (!d_unhashed(dentry) && hlist_bl_unhashed(&dentry->d_hash)) ||
> +		    (dentry->d_inode &&
> +		     !mapping_cap_writeback_dirty(dentry->d_inode->i_mapping))) {
> +			/* Ignore this dentry */
> +			v[i] = NULL;
> +		} else {
> +			__dget_dlock(dentry);
> +		}
> +		spin_unlock(&dentry->d_lock);
> +	}
> +	return NULL;		/* No need for private data */
> +}
> +
> +/*
> + * d_migrate() - Dentry migration callback function.
> + * @s: The dentry cache.
> + * @v: Vector of pointers to the objects to migrate.
> + * @nr: Number of objects in @v.
> + * @node: The NUMA node where new object should be allocated.
> + * @private: Returned by d_isolate() (currently %NULL).
> + *
> + * Slab has dropped all the locks. Get rid of the refcount obtained
> + * earlier and also free the object.
> + */
> +static void d_migrate(struct kmem_cache *s, void **v, int nr,
> +		      int node, void *_unused)
> +{
> +	struct dentry *dentry;
> +	int i;
> +
> +	for (i = 0; i < nr; i++) {
> +		dentry = v[i];
> +		if (dentry)
> +			d_invalidate(dentry);

Oh, *brilliant*

Let's do d_invalidate() on random dentries and hope they go away.
With convoluted and brittle logics for deciding which ones to
spare, which is actually wrong.  This will pick mountpoints
and tear them out, to start with.

NAKed-by: Al Viro <viro@zeniv.linux.org.uk>

And this is a NAK for the entire approach; if it has a positive refcount,
LEAVE IT ALONE.  Period.  Don't play this kind of games, they are wrong.
d_invalidate() is not something that can be done to an arbitrary dentry.
