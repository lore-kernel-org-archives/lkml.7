Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF3C7C433EF
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 09:53:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4175218AC
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 09:53:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568022833;
	bh=mfW3P6BM6CBGA1YX46u5V3xopt1sEe7eeb7Ur0aYW/E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=UioXk1natBzTIzdC0lNQLrri04ix7L5XoqGvqKyQMoGyK4C9RepP5yJ6euIZ/SuAu
	 EIfgsAHu1pAseLEI6eDvzJ4sScENNewcmSUEws/6RzdkOX8hQPOmQwIrmIFVH/bLbV
	 +UpK825ViydVXW7Cj8wl0ibTA4Fa3RpW0HRaMWpI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390033AbfIIJxw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 05:53:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:35362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728824AbfIIJxw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 05:53:52 -0400
Received: from localhost (110.8.30.213.rev.vodafone.pt [213.30.8.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D81BD2086D;
        Mon,  9 Sep 2019 09:53:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568022831;
        bh=mfW3P6BM6CBGA1YX46u5V3xopt1sEe7eeb7Ur0aYW/E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FgKUzvgE5HNfDIvO9Qi3YA1Zd9md6gM0IBsMl0CISOLizY2LyeEv2AdWh63DKwtTC
         k5py76lfpUGigj+4JdUcjWEP2yVzOMhFFqYW1H81jBscvvyNyktIXyRcX204k4jCms
         W+gFgfHpIRZjwcb4FnP8ycLFlkeomRC2kkgrcJ/k=
Date:   Mon, 9 Sep 2019 10:53:47 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Yunsheng Lin <linyunsheng@huawei.com>
Cc:     rafael@kernel.org, linux-kernel@vger.kernel.org,
        peterz@infradead.org, mingo@kernel.org, mhocko@kernel.org,
        linuxarm@huawei.com
Subject: Re: [PATCH] driver core: ensure a device has valid node id in
 device_add()
Message-ID: <20190909095347.GB6314@kroah.com>
References: <1568009063-77714-1-git-send-email-linyunsheng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1568009063-77714-1-git-send-email-linyunsheng@huawei.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 09, 2019 at 02:04:23PM +0800, Yunsheng Lin wrote:
> Currently a device does not belong to any of the numa nodes
> (dev->numa_node is NUMA_NO_NODE) when the node id is neither
> specified by fw nor by virtual device layer and the device has
> no parent device.

Is this really a problem?

> According to discussion in [1]:
> Even if a device's numa node is not specified, the device really
> does belong to a node.

But as we do not know the node, can we cause more harm by randomly
picking one (i.e. putting it all in node 0)?

> This patch sets the device node to node 0 in device_add() if the
> device's node id is not specified and it either has no parent
> device, or the parent device also does not have a valid node id.
> 
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

Again, is this going to cause more harm than good?  What happens if we
leave it as "unknown", isn't that better than thinking we "know" it is
in node 0?

thanks,

greg k-h
