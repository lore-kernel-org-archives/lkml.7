Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29E46C31E5B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 18:39:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03709206E0
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 18:39:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=fomichev-me.20150623.gappssmtp.com header.i=@fomichev-me.20150623.gappssmtp.com header.b="vdkI1N4/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730268AbfFSSjl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 14:39:41 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44047 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730020AbfFSSjk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 14:39:40 -0400
Received: by mail-pg1-f196.google.com with SMTP id n2so134670pgp.11
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2019 11:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fomichev-me.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2eg4br78BE7sniibmlcPp7WU9L9JLWiPUtRy7S0TYHU=;
        b=vdkI1N4/oDT6rsvptjue2FvZMxnq/jJftIFnDu1zgYWIItl4sRVcUPVaoJA1QVldr1
         lZeVtX1SXzPi0dJBAZxWsczbko3/sX3t1LEVIMyWXGyz3zmD0i5hVXvO1WrJiEXFm985
         CF3goROxRPkSO4gPnt5aqJFiddpJgG2KYvtKw+dTjGhtcQjfTRgcohjC7ZkGBsUC8I+J
         O+RNCHFjD3TjK/yloGC/YQQD0EcDyzAjSrYrbrZ5k1oJKjLtUMrBBdrhiIjt5LdJnGXE
         Qjblpnvn5PWsYQq2fPt3Ma21sZP4AK4yxTMdkA9IXJ/iTYzF+fI7ri0DmlLngiUgiVAe
         YtqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2eg4br78BE7sniibmlcPp7WU9L9JLWiPUtRy7S0TYHU=;
        b=G2Y5+2xxB9dBuD8Ht4n42xoeZci06/v1t9RazbH0MrmvvZqlvkya20UzY+tUjL2nz5
         dm0zUIP/JXvQzcJXfOp2oE4opN0js77Jrj+qydbkh+381GrMK5U/sSTAOVom78RBDOdL
         meF3+h6Du6rnJOw2OgS7dQp4cQf/2sxXG5CPmldq/yLKJSZa5dfcPuW/pyN61lnxW0+C
         +psoDX4ZJASyk7TIcw8gxRlrmbA9ssy3SDCuKpKDZDLekbEA0UwNxWSdpLB66Nw9iUwh
         T7u/6HU8yR/Q9Udj8+57XvOq7o3OdzRNOyV1k1KPghmRzvwucfuNAT8EaYLZNhnvMGRr
         jbpQ==
X-Gm-Message-State: APjAAAV3GPiv01NXKWD6m1/whlFhjusZVhQZeg6OeJ5M9glUasKMQkEc
        0N//5m0ZZHK4sSg3qL2OzsTGzQ==
X-Google-Smtp-Source: APXvYqyLb9zSpfxUOvUWWv+GP6aDIg1UO/Yavib1Dk2GlV7pK//HSPrGzclmLiyFkJl9/b2m5EqSVA==
X-Received: by 2002:a17:90a:d3c3:: with SMTP id d3mr12895607pjw.17.1560969579828;
        Wed, 19 Jun 2019 11:39:39 -0700 (PDT)
Received: from localhost ([2601:646:8f00:18d9:d0fa:7a4b:764f:de48])
        by smtp.gmail.com with ESMTPSA id i126sm8792873pfb.32.2019.06.19.11.39.38
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 19 Jun 2019 11:39:39 -0700 (PDT)
Date:   Wed, 19 Jun 2019 11:39:38 -0700
From:   Stanislav Fomichev <sdf@fomichev.me>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     davem@davemloft.net, sdf@google.com, jianbol@mellanox.com,
        jiri@mellanox.com, mirq-linux@rere.qmqm.pl, willemb@google.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH] flow_dissector: Fix vlan header offset in
 __skb_flow_dissect
Message-ID: <20190619183938.GA19111@mini-arch>
References: <20190619160132.38416-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190619160132.38416-1-yuehaibing@huawei.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/20, YueHaibing wrote:
> We build vlan on top of bonding interface, which vlan offload
> is off, bond mode is 802.3ad (LACP) and xmit_hash_policy is
> BOND_XMIT_POLICY_ENCAP34.
> 
> __skb_flow_dissect() fails to get information from protocol headers
> encapsulated within vlan, because 'nhoff' is points to IP header,
> so bond hashing is based on layer 2 info, which fails to distribute
> packets across slaves.
> 
> Fixes: d5709f7ab776 ("flow_dissector: For stripped vlan, get vlan info from skb->vlan_tci")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  net/core/flow_dissector.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/net/core/flow_dissector.c b/net/core/flow_dissector.c
> index 415b95f..2a52abb 100644
> --- a/net/core/flow_dissector.c
> +++ b/net/core/flow_dissector.c
> @@ -785,6 +785,9 @@ bool __skb_flow_dissect(const struct sk_buff *skb,
>  		    skb && skb_vlan_tag_present(skb)) {
>  			proto = skb->protocol;
>  		} else {
> +			if (dissector_vlan == FLOW_DISSECTOR_KEY_MAX)
> +				nhoff -=  sizeof(*vlan);
> +
Should we instead fix the place where the skb is allocated to properly
pull vlan (skb_vlan_untag)? I'm not sure this particular place is
supposed to work with an skb. Having an skb with nhoff pointing to
IP header but missing skb_vlan_tag_present() when with
proto==ETH_P_8021xx seems weird.

>  			vlan = __skb_header_pointer(skb, nhoff, sizeof(_vlan),
>  						    data, hlen, &_vlan);
>  			if (!vlan) {
> -- 
> 2.7.0
> 
> 
