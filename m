Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F776C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 22:10:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EA7D20675
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 22:10:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="pRDB0JKv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726409AbfCGWK4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 17:10:56 -0500
Received: from mail-yw1-f66.google.com ([209.85.161.66]:40881 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726261AbfCGWK4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 17:10:56 -0500
Received: by mail-yw1-f66.google.com with SMTP id u70so220886ywf.7
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2019 14:10:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8fGHXDrETn6TabDK8suVxtfSni42P/yTtu2dStlmLK0=;
        b=pRDB0JKvv6tfCYaEfKCrtyA9qWFops5hSVOSCIKoMjRZ/2pUEGPrm43Yg8eHyZqGLo
         bDtAHEnXTR6S8mX6lw3KG6Cnnj3/hXrUgxK5rn8VAgOVF6jEb21BOQPG9cDo6XGau6s2
         EVGFn9Q5O3qkEyzwYodtWUgwjlUaESCsgNk9RUd8OCiD3901qrlmJAr4ejrkA9ewJBSK
         Hm2sLgFU94ViOLL6VelFwkO+AKCqBJSng3uZRY6Dh19x2k/6k7xXuB1ipPY9ZAH9MMYh
         xhqd1PIGWTdoOWjcTUAvTXHra8ML2DyEmQdZF3UtrMRo0NBpfPylt1DEpI56lQx2M0/G
         hPpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8fGHXDrETn6TabDK8suVxtfSni42P/yTtu2dStlmLK0=;
        b=gJImbO+9l5oFQr+hEB6CJj9U5dY0sUwDIcfyDztl0W15LBgktbSe2ZOiHjS9Lxu8Xi
         j2xX67WubKoUIxaC4gLogjn7MidlHsZStbXoi8tOLCG3HEy5SDqLzoCN61h9PeSNbA7G
         yaUviUKsSMK/Pkz3AMmY/UKT3zXsRiqtL1z+T07a8RTWEQoyeXu7ejwgOh7aMyi9SdSG
         EXvrJVcFmmhAq55Zbni419oQIpJKbmPuqrp8jUlpNSbKv3VFt2XhWpaM9WCloFb/PLSg
         S6u8tf64CtZLtnGR7oyZSU/8uWsdx61sm1DTDfy8aA/HQAKiTdCntBXmYJo4SqEAEIhv
         XcPw==
X-Gm-Message-State: APjAAAXMTILE3DX3Mf3eZtlhyHmAx7LhDig1hKF2GskdqIpkm9hsu0/8
        qXgcVfC9U2e0UXHkOMMa6jl+gw==
X-Google-Smtp-Source: APXvYqxlY6+6icUcEkNYdZXTYelR9T0cimRfsKU9w2fu3lPODj9S1XiDdChJgoV3OHlgLOn8mLi7Eg==
X-Received: by 2002:a81:a091:: with SMTP id x139mr12347457ywg.164.1551996655114;
        Thu, 07 Mar 2019 14:10:55 -0800 (PST)
Received: from localhost ([2620:10d:c091:180::be7f])
        by smtp.gmail.com with ESMTPSA id h131sm2126941ywa.81.2019.03.07.14.10.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Mar 2019 14:10:54 -0800 (PST)
Date:   Thu, 7 Mar 2019 17:10:53 -0500
From:   Josef Bacik <josef@toxicpanda.com>
To:     Andrea Righi <andrea.righi@canonical.com>
Cc:     Josef Bacik <josef@toxicpanda.com>, Tejun Heo <tj@kernel.org>,
        Li Zefan <lizefan@huawei.com>,
        Paolo Valente <paolo.valente@linaro.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jens Axboe <axboe@kernel.dk>, Vivek Goyal <vgoyal@redhat.com>,
        Dennis Zhou <dennis@kernel.org>, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] blkcg: prevent priority inversion problem during
 sync()
Message-ID: <20190307221051.ruhpp73q6ek2at3d@macbook-pro-91.dhcp.thefacebook.com>
References: <20190307180834.22008-1-andrea.righi@canonical.com>
 <20190307180834.22008-2-andrea.righi@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190307180834.22008-2-andrea.righi@canonical.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 07, 2019 at 07:08:32PM +0100, Andrea Righi wrote:
> Prevent priority inversion problem when a high-priority blkcg issues a
> sync() and it is forced to wait the completion of all the writeback I/O
> generated by any other low-priority blkcg, causing massive latencies to
> processes that shouldn't be I/O-throttled at all.
> 
> The idea is to save a list of blkcg's that are waiting for writeback:
> every time a sync() is executed the current blkcg is added to the list.
> 
> Then, when I/O is throttled, if there's a blkcg waiting for writeback
> different than the current blkcg, no throttling is applied (we can
> probably refine this logic later, i.e., a better policy could be to
> adjust the throttling I/O rate using the blkcg with the highest speed
> from the list of waiters - priority inheritance, kinda).
> 
> Signed-off-by: Andrea Righi <andrea.righi@canonical.com>
> ---
>  block/blk-cgroup.c               | 131 +++++++++++++++++++++++++++++++
>  block/blk-throttle.c             |  11 ++-
>  fs/fs-writeback.c                |   5 ++
>  fs/sync.c                        |   8 +-
>  include/linux/backing-dev-defs.h |   2 +
>  include/linux/blk-cgroup.h       |  23 ++++++
>  mm/backing-dev.c                 |   2 +
>  7 files changed, 178 insertions(+), 4 deletions(-)
> 
> diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
> index 2bed5725aa03..4305e78d1bb2 100644
> --- a/block/blk-cgroup.c
> +++ b/block/blk-cgroup.c
> @@ -1351,6 +1351,137 @@ struct cgroup_subsys io_cgrp_subsys = {
>  };
>  EXPORT_SYMBOL_GPL(io_cgrp_subsys);
>  
> +#ifdef CONFIG_CGROUP_WRITEBACK
> +struct blkcg_wb_sleeper {
> +	struct backing_dev_info *bdi;
> +	struct blkcg *blkcg;
> +	refcount_t refcnt;
> +	struct list_head node;
> +};
> +
> +static DEFINE_SPINLOCK(blkcg_wb_sleeper_lock);
> +static LIST_HEAD(blkcg_wb_sleeper_list);
> +
> +static struct blkcg_wb_sleeper *
> +blkcg_wb_sleeper_find(struct blkcg *blkcg, struct backing_dev_info *bdi)
> +{
> +	struct blkcg_wb_sleeper *bws;
> +
> +	list_for_each_entry(bws, &blkcg_wb_sleeper_list, node)
> +		if (bws->blkcg == blkcg && bws->bdi == bdi)
> +			return bws;
> +	return NULL;
> +}
> +
> +static void blkcg_wb_sleeper_add(struct blkcg_wb_sleeper *bws)
> +{
> +	list_add(&bws->node, &blkcg_wb_sleeper_list);
> +}
> +
> +static void blkcg_wb_sleeper_del(struct blkcg_wb_sleeper *bws)
> +{
> +	list_del_init(&bws->node);
> +}
> +
> +/**
> + * blkcg_wb_waiters_on_bdi - check for writeback waiters on a block device
> + * @blkcg: current blkcg cgroup
> + * @bdi: block device to check
> + *
> + * Return true if any other blkcg different than the current one is waiting for
> + * writeback on the target block device, false otherwise.
> + */
> +bool blkcg_wb_waiters_on_bdi(struct blkcg *blkcg, struct backing_dev_info *bdi)
> +{
> +	struct blkcg_wb_sleeper *bws;
> +	bool ret = false;
> +
> +	spin_lock(&blkcg_wb_sleeper_lock);
> +	list_for_each_entry(bws, &blkcg_wb_sleeper_list, node)
> +		if (bws->bdi == bdi && bws->blkcg != blkcg) {
> +			ret = true;
> +			break;
> +		}
> +	spin_unlock(&blkcg_wb_sleeper_lock);
> +
> +	return ret;
> +}

No global lock please, add something to the bdi I think?  Also have a fast path
of

if (list_empty(blkcg_wb_sleeper_list))
   return false;

we don't need to be super accurate here.  Thanks,

Josef
