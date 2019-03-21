Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CB09C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 15:47:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B001218A5
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 15:47:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20150623.gappssmtp.com header.i=@networkplumber-org.20150623.gappssmtp.com header.b="fdFlzN8X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728589AbfCUPr5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 11:47:57 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33332 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728071AbfCUPrz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 11:47:55 -0400
Received: by mail-pg1-f194.google.com with SMTP id b12so4498135pgk.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 08:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Oa8Hy682AOTw3cZhIzfwg/gonochXK6afvm30E7q5Hs=;
        b=fdFlzN8X/KGNhcd3BXKFKQX+yBymQbGedLB3nLOrYN9hmhmh3dEoKitgVMCK3YkR1k
         QbgSAEevhW8kx6C0WKp+lBfuPHYAaMaURx7aCEoKlQ+ApwczXt8DYI6rPltNe/7a0baI
         1AOcZXQyWkbL9LFzcVHAgilYCrQ1aWr9/VRH0Ak0koNOVhGLG+DNwQVptAnxR6RWsXRG
         Bdpo0PzDBZG2MlZE26c+6eNlkf36hANK2khGqvMJjLEw3UGvTWXsT01dQYyKTuhqCdNU
         y5OzPjW3BDwTxuRd+/1sS0H2izH/5N1Jsn4PjT0hTcUjJ1+x6MCaGIonXnib4CFZdXCc
         UQiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Oa8Hy682AOTw3cZhIzfwg/gonochXK6afvm30E7q5Hs=;
        b=QBK+hiXHKSwReIG6PgnoUfdsUf6VXs1F/wq5p5y2VicOvGQnpm6wFlEk32ipqWhGrp
         Z/4xcOqrUeoyHQW7d02zT2mK5MDlg5i22YlmbExhqPbQ2pMSYjUK1JuUlweMUdITB8C2
         rdXh7RhOfTfDAeM0zNJC0sLgD6z1dEMz2y2xVRaCiHmUVVq+1ODQt7Q1UiOmotizRI6N
         uH0ORkfSOahRgBhRr9ROJzctzoU9hv0dN4UHL2SiNBKZR4kRMQFXxHf3Q4iVxp0tHPxZ
         CYwqHC5eDH9IoPpaXZMngw8GNoJI61RrldGvOyXWpK+zsNvWEOHNVy56Gs5TCYOmWY64
         4yOQ==
X-Gm-Message-State: APjAAAUhUSkVh8NInQuBVnnOoexBdBwP0gLvSbOfPlm0yHeuYXZtU0C3
        rDOlTK+FIYmE0Uj6n/d9V5nlXg==
X-Google-Smtp-Source: APXvYqwkjmbKAbaRc3A+quugLw+4ukFpE0zirFUlQVfsLA5Z8qqxfPdfX1KgEtdqVlJ5JIKMtz0nWQ==
X-Received: by 2002:a17:902:b216:: with SMTP id t22mr4245655plr.39.1553183274700;
        Thu, 21 Mar 2019 08:47:54 -0700 (PDT)
Received: from shemminger-XPS-13-9360 (204-195-22-127.wavecable.com. [204.195.22.127])
        by smtp.gmail.com with ESMTPSA id p5sm2995422pga.40.2019.03.21.08.47.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Mar 2019 08:47:54 -0700 (PDT)
Date:   Thu, 21 Mar 2019 08:47:51 -0700
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     Michal Kubecek <mkubecek@suse.cz>
Cc:     David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Jiri Pirko <jiri@resnulli.us>, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        John Linville <linville@tuxdriver.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4 01/22] rtnetlink: provide permanent hardware
 address in RTM_NEWLINK
Message-ID: <20190321084751.334c9f31@shemminger-XPS-13-9360>
In-Reply-To: <c46e29b557e54652cce569e3348ed0385eac1469.1553170807.git.mkubecek@suse.cz>
References: <cover.1553170807.git.mkubecek@suse.cz>
        <c46e29b557e54652cce569e3348ed0385eac1469.1553170807.git.mkubecek@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Mar 2019 14:40:21 +0100 (CET)
Michal Kubecek <mkubecek@suse.cz> wrote:

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


+1 this looks good, please also send iproute2 patch to display it.
