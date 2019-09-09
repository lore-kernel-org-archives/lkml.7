Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5237C4740A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 18:50:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77CFD21A4A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 18:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568055040;
	bh=8fdL+eBnW+jbpK82CyJ+IUy8PMnmuScQZjvnA9UNQnY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=KbqHHrGdGDYUvv5K6rioRr1tQ+rBfqwigFnuABWjaP49yzOz5hwXhhAmREoRzAezI
	 WVWVNXjK7jdz4r4VkDUz0ItfNx0adeW/NppGVgUwQ1HDMHS+/ulzALxkzZZAgYzkAv
	 U3+QO5Sd0R+wUqc1/+I3kPWjaxH5iGk5Re8O5jNc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732481AbfIISuj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 14:50:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:60300 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726814AbfIISuj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 14:50:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 60815AE1C;
        Mon,  9 Sep 2019 18:50:37 +0000 (UTC)
Date:   Mon, 9 Sep 2019 20:50:35 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Yunsheng Lin <linyunsheng@huawei.com>
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@kernel.org, linuxarm@huawei.com
Subject: Re: [PATCH] driver core: ensure a device has valid node id in
 device_add()
Message-ID: <20190909185035.GC2063@dhcp22.suse.cz>
References: <1568009063-77714-1-git-send-email-linyunsheng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1568009063-77714-1-git-send-email-linyunsheng@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 09-09-19 14:04:23, Yunsheng Lin wrote:
> Currently a device does not belong to any of the numa nodes
> (dev->numa_node is NUMA_NO_NODE) when the node id is neither
> specified by fw nor by virtual device layer and the device has
> no parent device.
> 
> According to discussion in [1]:

Please do not reference important parts of the justification via a link.
Just quote the relevant part to the changelog. It is just too easy that
external links die - not to mention lkml.org.

> Even if a device's numa node is not specified, the device really
> does belong to a node.

What does this mean?

> This patch sets the device node to node 0 in device_add() if the
> device's node id is not specified and it either has no parent
> device, or the parent device also does not have a valid node id.

Why is node 0 special? I have seen platforms with node 0 missing or
being memory less. The changelog also lacks an actual problem
descripton. Why do we even care about NUMA_NO_NODE? E.g. the page
allocator interprets NUMA_NO_NODE as the closest node with a memory.
And by closest it really means to the CPU which is performing the
allocation.
 
> [1] https://lkml.org/lkml/2019/9/2/466
> 
> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
> ---
> Changelog RFC -> v1:
> 1. Drop log error message and use a "if" instead of "? :".
> 2. Drop the RFC tag.
> ---
>  drivers/base/core.c  | 10 +++++++---
>  include/linux/numa.h |  2 ++
>  2 files changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 1669d41..f79ad20 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -2107,9 +2107,13 @@ int device_add(struct device *dev)
>  	if (kobj)
>  		dev->kobj.parent = kobj;
>  
> -	/* use parent numa_node */
> -	if (parent && (dev_to_node(dev) == NUMA_NO_NODE))
> -		set_dev_node(dev, dev_to_node(parent));
> +	/* use parent numa_node or default node 0 */
> +	if (!numa_node_valid(dev_to_node(dev))) {
> +		if (parent && numa_node_valid(dev_to_node(parent)))
> +			set_dev_node(dev, dev_to_node(parent));
> +		else
> +			set_dev_node(dev, 0);
> +	}
>  
>  	/* first, register with generic layer. */
>  	/* we require the name to be set before, and pass NULL */
> diff --git a/include/linux/numa.h b/include/linux/numa.h
> index 110b0e5..eccc757 100644
> --- a/include/linux/numa.h
> +++ b/include/linux/numa.h
> @@ -13,4 +13,6 @@
>  
>  #define	NUMA_NO_NODE	(-1)
>  
> +#define numa_node_valid(node)	((unsigned int)(node) < nr_node_ids)
> +
>  #endif /* _LINUX_NUMA_H */
> -- 
> 2.8.1

-- 
Michal Hocko
SUSE Labs
