Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E88FC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 04:12:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D92E22186A
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 04:12:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730753AbfB1EMP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 23:12:15 -0500
Received: from orcrist.hmeau.com ([104.223.48.154]:59094 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730131AbfB1EMP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 23:12:15 -0500
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1gzD3H-0003wW-KM; Thu, 28 Feb 2019 12:12:07 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1gzD3B-0007XS-IZ; Thu, 28 Feb 2019 12:12:01 +0800
Date:   Thu, 28 Feb 2019 12:12:01 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Yue Haibing <yuehaibing@huawei.com>
Cc:     steffen.klassert@secunet.com, davem@davemloft.net,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Fan Du <fan.du@windriver.com>
Subject: Re: [PATCH] xfrm: policy: Fix possible user after free in
 __xfrm_policy_unlink
Message-ID: <20190228041201.op5qv6pfgu6guv4j@gondor.apana.org.au>
References: <20190228031623.22184-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190228031623.22184-1-yuehaibing@huawei.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 28, 2019 at 11:16:23AM +0800, Yue Haibing wrote:
> 
> diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
> index 8d1a898..b27eb742 100644
> --- a/net/xfrm/xfrm_policy.c
> +++ b/net/xfrm/xfrm_policy.c
> @@ -316,6 +316,8 @@ static void xfrm_policy_timer(struct timer_list *t)
>  		goto out;
>  
>  	dir = xfrm_policy_id2dir(xp->index);
> +	if (dir >= XFRM_POLICY_MAX * 2)
> +		dir = dir & XFRM_POLICY_MAX;

This is still wrong.  We shouldn't be allowing bogus policies
to be in the system at all.

I have digged deeper and the problem was introduced by:

commit e682adf021be796940be6cc10c07be7f7398c220
Author: Fan Du <fan.du@windriver.com>
Date:   Thu Nov 7 17:47:48 2013 +0800

    xfrm: Try to honor policy index if it's supplied by user

Where the check for the user-supplied index is simply wrong in
verify_newpolicy_info.  So please fix it there.

Thanks!
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
