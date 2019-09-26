Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3DD2C4360D
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 01:28:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC63E21655
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 01:28:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="MT974R0a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389020AbfIZB2v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 21:28:51 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42845 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726707AbfIZB2u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 21:28:50 -0400
Received: by mail-pg1-f195.google.com with SMTP id z12so453256pgp.9
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2019 18:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=j12YR8Sz7lqAWk3kVJllB0GpgeIbUZ8LPBlsVactf4o=;
        b=MT974R0a+7BOZEwbuehQtp8dBN4m9x82wscvv6hWcyd5Vz/4vnx3Wk+7Gs6qtKLzBC
         CxDEIKCBB+/MvaFjA0jVW2eWjbtY7fL5u0P6FfbLWSdG8HQUewhfMsft18SOo7RaGsL6
         hJYxUcpEB1qLwaWv3s6Vir6AWd0Zx+k7VzGS49BPb+XV7EovyKrWxgtyvkM0HyHmskuP
         swRXdYKd2XVAlvN+psnPqQuZh5c0n5ukyzBQnyy1opB0bBXw6LyKDrJXuJQvEAKYHLGB
         t8y0EaKcQULXzpOZZ1FnfzhF0kRunBD6phEhpTKgWoIHSMxw6iREXSFyRvpJ8B4Gw3QL
         WHvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=j12YR8Sz7lqAWk3kVJllB0GpgeIbUZ8LPBlsVactf4o=;
        b=aq4RH2dbD9GY9t7xzxuV4p1Lp4d2LKjZfWVqYpzGdXfo5/bsWUaJei3ypbPMWiYzc/
         IoQaykd2l6eQgR5oHHoMt0lH3UlJWQEfY939HVk9L3Gq4KY+faBNfSogIPmW+MhoAsbL
         LyUl5uEI2BTRamDd/b0S0XwJPyiGTpzd3prSVQscejWEqzilQQ9RF/g/Q8lVglQ5Q6y+
         SRVkfBArF5A4t15e/hJOj/HRh/OeLUfBUjXdJHD8xsArC7DitxDs/XAav47nI1+ncDbt
         fEOVdBE+I/mxdgX41kQZGU4N8LSFxY7jWolg+p+WKNanMjO+UhZomE25QAZ162BU5IwA
         rUcw==
X-Gm-Message-State: APjAAAXvKP+tzRS3seJ46FpdNMwAxlEC8kA3X+RKLy9LFP/7KSl4dj85
        5ngDSY7he9PSB7yDps2GmFPCXQ==
X-Google-Smtp-Source: APXvYqxQITLNcTLpSM0rs0YOxV402EPnexB569vCYoV1pb+klZRhrOQFOyV97JvHUqc6+fXJsVTpTg==
X-Received: by 2002:a62:1e82:: with SMTP id e124mr789701pfe.136.1569461330070;
        Wed, 25 Sep 2019 18:28:50 -0700 (PDT)
Received: from cakuba.netronome.com (c-73-202-202-92.hsd1.ca.comcast.net. [73.202.202.92])
        by smtp.gmail.com with ESMTPSA id h4sm256255pfg.159.2019.09.25.18.28.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2019 18:28:49 -0700 (PDT)
Date:   Wed, 25 Sep 2019 18:28:46 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Navid Emamdoost <navid.emamdoost@gmail.com>
Cc:     emamd001@umn.edu, smccaman@umn.edu, kjlu@umn.edu,
        "David S. Miller" <davem@davemloft.net>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Colin Ian King <colin.king@canonical.com>,
        oss-drivers@netronome.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: flow_offload: fix memory leak in
 nfp_abm_u32_knode_replace
Message-ID: <20190925182846.69a261e8@cakuba.netronome.com>
In-Reply-To: <20190925183457.32695-1-navid.emamdoost@gmail.com>
References: <20190925183457.32695-1-navid.emamdoost@gmail.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Sep 2019 13:34:46 -0500, Navid Emamdoost wrote:
> In nfp_abm_u32_knode_replace if the allocation for match fails it should
> go to the error handling instead of returning.
> 
> Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
> ---
>  drivers/net/ethernet/netronome/nfp/abm/cls.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/netronome/nfp/abm/cls.c b/drivers/net/ethernet/netronome/nfp/abm/cls.c
> index 23ebddfb9532..32eaab99d96c 100644
> --- a/drivers/net/ethernet/netronome/nfp/abm/cls.c
> +++ b/drivers/net/ethernet/netronome/nfp/abm/cls.c
> @@ -174,7 +174,7 @@ nfp_abm_u32_knode_replace(struct nfp_abm_link *alink,
>  	struct nfp_abm_u32_match *match = NULL, *iter;
>  	unsigned int tos_off;
>  	u8 mask, val;
> -	int err;
> +	int err, ret = -EOPNOTSUPP;

You can use the err variable for the return. Please don't break the
reverse christmas tree ordering. Please initialize the err variable 
in the branch where failure occurred, not at the start of the function.

>  	if (!nfp_abm_u32_check_knode(alink->abm, knode, proto, extack))
>  		goto err_delete;
> @@ -204,8 +204,11 @@ nfp_abm_u32_knode_replace(struct nfp_abm_link *alink,
>  
>  	if (!match) {
>  		match = kzalloc(sizeof(*match), GFP_KERNEL);
> -		if (!match)
> -			return -ENOMEM;
> +		if (!match) {
> +			ret = -ENOMEM;
> +			goto err_delete;
> +		}
> +
>  		list_add(&match->list, &alink->dscp_map);
>  	}
>  	match->handle = knode->handle;
> @@ -221,7 +224,7 @@ nfp_abm_u32_knode_replace(struct nfp_abm_link *alink,
>  
>  err_delete:
>  	nfp_abm_u32_knode_delete(alink, knode);
> -	return -EOPNOTSUPP;
> +	return ret;
>  }
>  
>  static int nfp_abm_setup_tc_block_cb(enum tc_setup_type type,

