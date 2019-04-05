Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D2F6C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 03:24:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4A38217D7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 03:24:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZhtaXoCh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729803AbfDEDYQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 23:24:16 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48636 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728735AbfDEDYQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 23:24:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=jRHLGjsSpnMNMqpwFJNevcBN06h08Z51JVnzqEP2O/c=; b=ZhtaXoChaqGEyYGJ+8LTG64Et
        w09ibo7DUWHZN6fWYEGKrJfkgdyFOPniXB0biEH02TLCNMa8t9Gdf/iXjhxbN7KDBLQX7OmgA3mrm
        kJlm3FtIi+rCOHX8Wz8OLrMXkE/lckB0UAkj5bI3bM46u3k/3WInFgqb8TshQnBIevkkJDDvbkJYo
        /aqvlxJI+Rg/ivvKVNea0RnUdFRln27s2pm3QRHUVUUiGks3U7gDPZbuqLTDM8xPPtDKmjqoa9wlL
        PyTINlGYH1t4e6e6fUQOUvIsYcFWaa9WP+atJn4qteq62LRcHHQAwcMM/vzUzaHUgxzQ8iXwScpsX
        9A02vccPA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hCFST-0002pE-Jf; Fri, 05 Apr 2019 03:24:01 +0000
Date:   Thu, 4 Apr 2019 20:24:01 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Zhaoyang Huang <huangzhaoyang@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        David Rientjes <rientjes@google.com>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
        Roman Gushchin <guro@fb.com>, Jeff Layton <jlayton@redhat.com>,
        Matthew Wilcox <mawilcox@microsoft.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm:workingset use real time to judge activity of the
 file page
Message-ID: <20190405032401.GN22763@bombadil.infradead.org>
References: <1554348617-12897-1-git-send-email-huangzhaoyang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1554348617-12897-1-git-send-email-huangzhaoyang@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 04, 2019 at 11:30:17AM +0800, Zhaoyang Huang wrote:
> +++ b/mm/workingset.c
> @@ -159,7 +159,7 @@
>  			 NODES_SHIFT +	\
>  			 MEM_CGROUP_ID_SHIFT)
>  #define EVICTION_MASK	(~0UL >> EVICTION_SHIFT)
> -
> +#define EVICTION_JIFFIES (BITS_PER_LONG >> 3)
>  /*
>   * Eviction timestamps need to be able to cover the full range of
>   * actionable refaults. However, bits are tight in the radix tree
> @@ -175,18 +175,22 @@ static void *pack_shadow(int memcgid, pg_data_t *pgdat, unsigned long eviction)
>  	eviction >>= bucket_order;
>  	eviction = (eviction << MEM_CGROUP_ID_SHIFT) | memcgid;
>  	eviction = (eviction << NODES_SHIFT) | pgdat->node_id;
> +	eviction = (eviction << EVICTION_JIFFIES) | (jiffies >> EVICTION_JIFFIES);
>  	eviction = (eviction << RADIX_TREE_EXCEPTIONAL_SHIFT);

... this isn't against current, or even 5.0.

>  	entry >>= RADIX_TREE_EXCEPTIONAL_SHIFT;
> +	entry >>= EVICTION_JIFFIES;
> +	prev_jiff = (entry & ((1UL << EVICTION_JIFFIES) - 1)) << EVICTION_JIFFIES;

These two lines are in the wrong order.  So you're getting (effectively) a
random answer in your 'prev_jiff', which means your testing isn't thorough
enough.  I suspect you're only testing cases you're expecting to improve,
and you aren't testing to make sure that other cases don't regress.

