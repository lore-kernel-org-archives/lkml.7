Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B28CEC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 16:41:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8766820851
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 16:41:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbfCGQlK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 11:41:10 -0500
Received: from mx2.suse.de ([195.135.220.15]:35302 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726172AbfCGQlJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 11:41:09 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A209DAC9A;
        Thu,  7 Mar 2019 16:41:07 +0000 (UTC)
Received: by unicorn.suse.cz (Postfix, from userid 1000)
        id BB5ECE1175; Thu,  7 Mar 2019 17:41:06 +0100 (CET)
Date:   Thu, 7 Mar 2019 17:41:06 +0100
From:   Michal Kubecek <mkubecek@suse.cz>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Jiri Pirko <jiri@mellanox.com>, Wenwen Wang <wang6495@umn.edu>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [v2] ethtool: reduce stack usage with clang
Message-ID: <20190307164106.GD20309@unicorn.suse.cz>
References: <20190307160017.3120362-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190307160017.3120362-1-arnd@arndb.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 07, 2019 at 04:58:35PM +0100, Arnd Bergmann wrote:
> clang inlines the dev_ethtool() more aggressively than gcc does, leading
> to a larger amount of used stack space:
> 
> net/core/ethtool.c:2536:24: error: stack frame size of 1216 bytes in function 'dev_ethtool' [-Werror,-Wframe-larger-than=]
> 
> Marking the sub-functions that require the most stack space as
> noinline_for_stack gives us reasonable behavior on all compilers.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> v2: don't annotate dev_ethtool itself, as pointed out by Michal Kubecek
> ---
>  net/core/ethtool.c | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
> 

Reviewed-by: Michal Kubecek <mkubecek@suse.cz>

In the long term, these three functions would IMHO deserve some rework.
While marking them as noinline_for_stack prevents one big stack frame in
dev_ethtool(), we still allocate rather big structures on the stack,
only it won't be in one stack frame. When we take the

  dev_ethtool
    ethtool_set_perqueue
      ethtool_[gs]et_per_queue_coalesce

path, there will still be two 512-byte arrays on the stack, one inside
struct ethtool_per_queue_op in ethtool_set_per_queue() and one as the
queue_mask bitmap in ethtool_[gs]et_per_queue_coalesce() (MAX_NUM_QUEUE
is 4096 now). In other words, actual stack consumption might be
approximately the same after this change as it was before, only divided
into three stack frames.

Michal Kubecek

> diff --git a/net/core/ethtool.c b/net/core/ethtool.c
> index d4918ffddda8..b1eb32419732 100644
> --- a/net/core/ethtool.c
> +++ b/net/core/ethtool.c
> @@ -2319,9 +2319,10 @@ static int ethtool_set_tunable(struct net_device *dev, void __user *useraddr)
>  	return ret;
>  }
>  
> -static int ethtool_get_per_queue_coalesce(struct net_device *dev,
> -					  void __user *useraddr,
> -					  struct ethtool_per_queue_op *per_queue_opt)
> +static noinline_for_stack int
> +ethtool_get_per_queue_coalesce(struct net_device *dev,
> +			       void __user *useraddr,
> +			       struct ethtool_per_queue_op *per_queue_opt)
>  {
>  	u32 bit;
>  	int ret;
> @@ -2349,9 +2350,10 @@ static int ethtool_get_per_queue_coalesce(struct net_device *dev,
>  	return 0;
>  }
>  
> -static int ethtool_set_per_queue_coalesce(struct net_device *dev,
> -					  void __user *useraddr,
> -					  struct ethtool_per_queue_op *per_queue_opt)
> +static noinline_for_stack int
> +ethtool_set_per_queue_coalesce(struct net_device *dev,
> +			       void __user *useraddr,
> +			       struct ethtool_per_queue_op *per_queue_opt)
>  {
>  	u32 bit;
>  	int i, ret = 0;
> @@ -2405,7 +2407,7 @@ static int ethtool_set_per_queue_coalesce(struct net_device *dev,
>  	return ret;
>  }
>  
> -static int ethtool_set_per_queue(struct net_device *dev,
> +static int noinline_for_stack ethtool_set_per_queue(struct net_device *dev,
>  				 void __user *useraddr, u32 sub_cmd)
>  {
>  	struct ethtool_per_queue_op per_queue_opt;
