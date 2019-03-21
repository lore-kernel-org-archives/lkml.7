Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4793C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 20:35:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7205F2183E
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 20:35:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="Do8pBrGP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728887AbfCUUfM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 16:35:12 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:33694 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728769AbfCUUfL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 16:35:11 -0400
Received: by mail-qk1-f194.google.com with SMTP id k189so11924111qkc.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 13:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=12wuSmb3sDVRuzc14WZtLjG7a8not1Iygm4PfdajXZY=;
        b=Do8pBrGPqum9dFCimbACAndt8FBCZJm5rjfvql6NB3CUO+NBR3F9RUeZMAt1GwZv9n
         KU4hVisgtUk4pFL9kjPlMIlK6FA6//DWdmp3hpmjHbUEAS5yUInjVI9j882nwDDWxFee
         x7hdY8B/UUE+jpkjnew3PHg0sltfbNY1k94s0tkJVX7iu2QiXOWrjdILMP/oruRVbnfN
         vMbN529/oBKtasF6igwhl8FhupKGJPosCveNNLZKDzqU5m+eHIBbecxHmnBIkkopwWmX
         nnnIXDgdjS1ZG7n5YcRDWujJ/mu1WAvvQ5rcr4pBym8ytu7VaptF65JCAJ6xIVWj3O/D
         8kfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=12wuSmb3sDVRuzc14WZtLjG7a8not1Iygm4PfdajXZY=;
        b=pXzxcQ2gjvqIXHZ+muVNvjYCNVyHSot5ITxarMJYvrhFWQHPVfb57k12yg5FpJja3y
         Zeyx8hCqJI5LL7fkYgQpPTVK2o4RKeTXV8/L44sOo2in5Wf355kPFjCHxI1vz/3H9oMO
         QAs08LeIuRkJ3SogFEnraTEI3yTS0ZF/M4iteQJVpRl9PhmtjqKSl720DEATN5f284je
         GPtqDxE6GO/wB/QGxwQ7VFczGGDvEYP3OG+xi+yDv651eieB/CuEjjna3WhXeWrTZrnr
         CVrwT2CfRjpRKRRa+vh7LDX08Wg4Cvretqb3sUs54cP6PnTFN5kc6Plr06Vw1LEa2U2K
         27aw==
X-Gm-Message-State: APjAAAXeNUEZIrYLTia8wxiZZwOiuiyFXmMI5eUYnqU6wErU3w2BWNk/
        zyT4eiKfqc1Dz2+DRU1RYeaeOQ==
X-Google-Smtp-Source: APXvYqwiQetv81Z6R4/hA08Z+rBrQOeTpFmGkuO93ARIV+P5vLxr21g5Vui70dfgtACtIMAOSztYtQ==
X-Received: by 2002:a05:620a:132b:: with SMTP id p11mr4598519qkj.279.1553200510507;
        Thu, 21 Mar 2019 13:35:10 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id v4sm1534386qkl.47.2019.03.21.13.35.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Mar 2019 13:35:10 -0700 (PDT)
Date:   Thu, 21 Mar 2019 13:35:05 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Michal Kubecek <mkubecek@suse.cz>
Cc:     David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
        Jiri Pirko <jiri@resnulli.us>, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        John Linville <linville@tuxdriver.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4 01/22] rtnetlink: provide permanent hardware
 address in RTM_NEWLINK
Message-ID: <20190321133505.7e186289@cakuba.netronome.com>
In-Reply-To: <c46e29b557e54652cce569e3348ed0385eac1469.1553170807.git.mkubecek@suse.cz>
References: <cover.1553170807.git.mkubecek@suse.cz>
        <c46e29b557e54652cce569e3348ed0385eac1469.1553170807.git.mkubecek@suse.cz>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Mar 2019 14:40:21 +0100 (CET), Michal Kubecek wrote:
> Permanent hardware address of a network device was traditionally provided
> via ethtool ioctl interface but as Jiri Pirko pointed out in a review of
> ethtool netlink interface, rtnetlink is much more suitable for it so let's
> add it to the RTM_NEWLINK message.
> 
> As permanent address is not modifiable, reject userspace requests
> containing IFLA_PERM_ADDRESS attribute.
> 
> Note: we already provide permanent hardware address for bond slaves;
> unfortunately we cannot drop that attribute for backward compatibility
> reasons.
> 
> Signed-off-by: Michal Kubecek <mkubecek@suse.cz>
> ---
>  include/uapi/linux/if_link.h | 1 +
>  net/core/rtnetlink.c         | 4 ++++
>  2 files changed, 5 insertions(+)
> 
> diff --git a/include/uapi/linux/if_link.h b/include/uapi/linux/if_link.h
> index 5b225ff63b48..351ef746b8b0 100644
> --- a/include/uapi/linux/if_link.h
> +++ b/include/uapi/linux/if_link.h
> @@ -167,6 +167,7 @@ enum {
>  	IFLA_NEW_IFINDEX,
>  	IFLA_MIN_MTU,
>  	IFLA_MAX_MTU,
> +	IFLA_PERM_ADDRESS,
>  	__IFLA_MAX
>  };
>  
> diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
> index a51cab95ba64..a72e8f4d777b 100644
> --- a/net/core/rtnetlink.c
> +++ b/net/core/rtnetlink.c
> @@ -1026,6 +1026,7 @@ static noinline size_t if_nlmsg_size(const struct net_device *dev,
>  	       + nla_total_size(4)  /* IFLA_CARRIER_DOWN_COUNT */
>  	       + nla_total_size(4)  /* IFLA_MIN_MTU */
>  	       + nla_total_size(4)  /* IFLA_MAX_MTU */
> +	       + nla_total_size(MAX_ADDR_LEN) /* IFLA_PERM_ADDRESS */
>  	       + 0;
>  }
>  
> @@ -1683,6 +1684,8 @@ static int rtnl_fill_ifinfo(struct sk_buff *skb,
>  	    nla_put_s32(skb, IFLA_NEW_IFINDEX, new_ifindex) < 0)
>  		goto nla_put_failure;
>  
> +	if (nla_put(skb, IFLA_PERM_ADDRESS, dev->addr_len, dev->perm_addr))

Should we check the perm_addr is non-zero, i.e. it has been filled in
by the driver?

> +		goto nla_put_failure;
>  
>  	rcu_read_lock();
>  	if (rtnl_fill_link_af(skb, dev, ext_filter_mask))
> @@ -1742,6 +1745,7 @@ static const struct nla_policy ifla_policy[IFLA_MAX+1] = {
>  	[IFLA_CARRIER_DOWN_COUNT] = { .type = NLA_U32 },
>  	[IFLA_MIN_MTU]		= { .type = NLA_U32 },
>  	[IFLA_MAX_MTU]		= { .type = NLA_U32 },
> +	[IFLA_PERM_ADDRESS]	= { .type = NLA_REJECT },
>  };
>  
>  static const struct nla_policy ifla_info_policy[IFLA_INFO_MAX+1] = {

