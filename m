Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5EDAC10F0B
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 17:23:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 822EC20693
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 17:23:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SzCa4MQH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726489AbfDCRXp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 13:23:45 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44240 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726097AbfDCRXp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 13:23:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=0JzrFPO7aOe+Az8le0qY0Q15I7o1B6VXCKgN/GjAWHI=; b=SzCa4MQHkoG8AMhwPjhlI9FFD
        CBq7iyWi+DgHYZoEnO/vvMW+dZm0VDmvM6NU1rOonmI+t5sI+/gunTjzzdp1ZLWKERtFdnDKDrVMf
        imWx/KUE9Ddk43bw8ecIhoQCRrcxfatW+XBBGPE1wpRru+MpQWD1wFobP3U4NLKaxOdhHElHwLxK0
        gOIgzY52s+2qaP4YgaDJowKLZI+sga77VoGx20BNd7/VqDt7E3ALtoRLsuHcC+Slcz7ZTCLBEtfDi
        AjfYcgbbvnep1jEVpoYnvcdEtP6V1h9hmXUYXijzAxijnqgB5QIYP1cdb+XD/RPso9W7AmVuN0VWq
        dojc7s4gA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hBjbi-000465-Iu; Wed, 03 Apr 2019 17:23:26 +0000
Date:   Wed, 3 Apr 2019 10:23:26 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     "Tobin C. Harding" <tobin@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>,
        Alexander Viro <viro@ftp.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Pekka Enberg <penberg@cs.helsinki.fi>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Christopher Lameter <cl@linux.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Andreas Dilger <adilger@dilger.ca>,
        Waiman Long <longman@redhat.com>,
        Tycho Andersen <tycho@tycho.ws>, Theodore Ts'o <tytso@mit.edu>,
        Andi Kleen <ak@linux.intel.com>,
        David Chinner <david@fromorbit.com>,
        Nick Piggin <npiggin@gmail.com>,
        Rik van Riel <riel@redhat.com>,
        Hugh Dickins <hughd@google.com>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 09/14] xarray: Implement migration function for
 objects
Message-ID: <20190403172326.GJ22763@bombadil.infradead.org>
References: <20190403042127.18755-1-tobin@kernel.org>
 <20190403042127.18755-10-tobin@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190403042127.18755-10-tobin@kernel.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 03, 2019 at 03:21:22PM +1100, Tobin C. Harding wrote:
> +void xa_object_migrate(struct xa_node *node, int numa_node)
> +{
> +	struct xarray *xa = READ_ONCE(node->array);
> +	void __rcu **slot;
> +	struct xa_node *new_node;
> +	int i;
> +
> +	/* Freed or not yet in tree then skip */
> +	if (!xa || xa == XA_RCU_FREE)
> +		return;
> +
> +	new_node = kmem_cache_alloc_node(radix_tree_node_cachep,
> +					 GFP_KERNEL, numa_node);
> +	if (!new_node)
> +		return;
> +
> +	xa_lock_irq(xa);
> +
> +	/* Check again..... */
> +	if (xa != node->array || !list_empty(&node->private_list)) {
> +		node = new_node;
> +		goto unlock;
> +	}
> +
> +	memcpy(new_node, node, sizeof(struct xa_node));
> +
> +	/* Move pointers to new node */
> +	INIT_LIST_HEAD(&new_node->private_list);

Surely we can do something more clever, like ...

	if (xa != node->array) {
...
	if (list_empty(&node->private_list))
		INIT_LIST_HEAD(&new_node->private_list);
	else
		list_replace(&node->private_list, &new_node->private_list);


BTW, the raidx tree nodes / xa_nodes share the same slab cache; we need
to finish converting all radix tree & IDR users to the XArray before
this series can go in.
