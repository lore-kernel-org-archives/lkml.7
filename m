Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67127C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 10:19:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 238FF20856
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 10:19:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20150623.gappssmtp.com header.i=@resnulli-us.20150623.gappssmtp.com header.b="VIRmytdt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726042AbfCZKT0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 06:19:26 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33326 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726278AbfCZKT0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 06:19:26 -0400
Received: by mail-wr1-f68.google.com with SMTP id q1so13642184wrp.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 03:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nalx1nzr+fBfP7F8ULK+t2Evs+5aCa/1OuKEcltLpYE=;
        b=VIRmytdtW122+F1btrJA9NjpP+YIzv+INrXUXR1XRZF5+Dzc9u+JbPColK/MEkmP/L
         1hQEyBAVqHkyYrzc8koA5ahebSqfjOjmCDXXAC0l8inTrFgdwJp0vPXfvIUd8Q0zXOki
         9wsIs38lBcW3/lcufmb7zEsAGE0WYM5hS64jx7bFH0u5+Tc99ZR2oiXEKNwUvutteWdX
         iD8k0xaBKJYd0ko8PYGj0GSpqsJJf5FgJi+8rbLtw3QPB8O7XvxpWzrvQuKleL3d+YdC
         Ov50y1BEaClH6A57YXPxPtji4b5gQxT+vuWpIYaLwu0TiD20suMaPdfMApCnY/Gcjjm7
         OxCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nalx1nzr+fBfP7F8ULK+t2Evs+5aCa/1OuKEcltLpYE=;
        b=YoC2LYYHhqkD1Zec6ZgSnQAHfz2388nedP4QqpWnTt7o4qL2t3di9e80kxuSHa2iWf
         /xYWPv4MiEl+LGsQBPfj3UERMj4fwz+9G0GI6ncZjP7S5GmvpeltI9ttcMbyv60dWLjF
         46Qo5OQua8R93Ea/FUs5uyXPkxXb7XD1dfq4AVxKDoExj7kQoMG3ic9MXSpGb9rAeobu
         xnC2mYRXeEKg8pXvk4oo/9cyVmYsvwyjLb6Dh/Ut2iVoOKe2IHchWCeHAVtpOk/69S+V
         TUKBDZTCM2e1YCKDk0qaUTeWvOU8JhinWh23pGwcFzWVwan8pE/PqRUCcI0YedNUqD1f
         6ZWg==
X-Gm-Message-State: APjAAAU+VSZYIYl69Xu5TYkkw397TRlktcFIzZSN/K7IYd7gbjUBmSTh
        2qcmFYZnFppGkBTE/yrAOI+8X7zIIB0=
X-Google-Smtp-Source: APXvYqzUJW4QsJb4mHayihX9wD4bOHAZBfy2FQ37tI2GPNsBN78TxZjO/W9xpwx2WeCtE3lWUh4glw==
X-Received: by 2002:a5d:6050:: with SMTP id j16mr19365969wrt.253.1553595564736;
        Tue, 26 Mar 2019 03:19:24 -0700 (PDT)
Received: from localhost (mail.chocen-mesto.cz. [85.163.43.2])
        by smtp.gmail.com with ESMTPSA id e9sm14597477wrp.35.2019.03.26.03.19.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Mar 2019 03:19:23 -0700 (PDT)
Date:   Tue, 26 Mar 2019 11:08:36 +0100
From:   Jiri Pirko <jiri@resnulli.us>
To:     Michal Kubecek <mkubecek@suse.cz>
Cc:     David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        John Linville <linville@tuxdriver.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 01/22] rtnetlink: provide permanent hardware
 address in RTM_NEWLINK
Message-ID: <20190326100836.GA2230@nanopsycho>
References: <cover.1553532199.git.mkubecek@suse.cz>
 <16ffb1fbfa8f54de587ac52f4ff95e5034c590b4.1553532199.git.mkubecek@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16ffb1fbfa8f54de587ac52f4ff95e5034c590b4.1553532199.git.mkubecek@suse.cz>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mon, Mar 25, 2019 at 06:07:57PM CET, mkubecek@suse.cz wrote:
>Permanent hardware address of a network device was traditionally provided
>via ethtool ioctl interface but as Jiri Pirko pointed out in a review of
>ethtool netlink interface, rtnetlink is much more suitable for it so let's
>add it to the RTM_NEWLINK message.
>
>As permanent address is not modifiable, reject userspace requests
>containing IFLA_PERM_ADDRESS attribute.
>
>Note: we already provide permanent hardware address for bond slaves;
>unfortunately we cannot drop that attribute for backward compatibility
>reasons.
>
>Signed-off-by: Michal Kubecek <mkubecek@suse.cz>
>---
> include/uapi/linux/if_link.h | 1 +
> net/core/rtnetlink.c         | 4 ++++
> 2 files changed, 5 insertions(+)
>
>diff --git a/include/uapi/linux/if_link.h b/include/uapi/linux/if_link.h
>index 5b225ff63b48..351ef746b8b0 100644
>--- a/include/uapi/linux/if_link.h
>+++ b/include/uapi/linux/if_link.h
>@@ -167,6 +167,7 @@ enum {
> 	IFLA_NEW_IFINDEX,
> 	IFLA_MIN_MTU,
> 	IFLA_MAX_MTU,
>+	IFLA_PERM_ADDRESS,
> 	__IFLA_MAX
> };
> 
>diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
>index a51cab95ba64..a72e8f4d777b 100644
>--- a/net/core/rtnetlink.c
>+++ b/net/core/rtnetlink.c
>@@ -1026,6 +1026,7 @@ static noinline size_t if_nlmsg_size(const struct net_device *dev,
> 	       + nla_total_size(4)  /* IFLA_CARRIER_DOWN_COUNT */
> 	       + nla_total_size(4)  /* IFLA_MIN_MTU */
> 	       + nla_total_size(4)  /* IFLA_MAX_MTU */
>+	       + nla_total_size(MAX_ADDR_LEN) /* IFLA_PERM_ADDRESS */
> 	       + 0;
> }
> 
>@@ -1683,6 +1684,8 @@ static int rtnl_fill_ifinfo(struct sk_buff *skb,
> 	    nla_put_s32(skb, IFLA_NEW_IFINDEX, new_ifindex) < 0)
> 		goto nla_put_failure;
> 
>+	if (nla_put(skb, IFLA_PERM_ADDRESS, dev->addr_len, dev->perm_addr))
>+		goto nla_put_failure;

I don't think we should put permaddr if driver did not set it. 2
solutions:
1) provide a helper that driver will use to set the perm_addr. This
   helper sets a "valid bit". Then you only put IFLA_PERM_ADDRESS
   in case the "valid bit" is set.
2) Assuming that no driver would set permaddr to all zeroes,
   don't put IFLA_PERM_ADDRESS in case permadd is all zeroes.

> 
> 	rcu_read_lock();
> 	if (rtnl_fill_link_af(skb, dev, ext_filter_mask))
>@@ -1742,6 +1745,7 @@ static const struct nla_policy ifla_policy[IFLA_MAX+1] = {
> 	[IFLA_CARRIER_DOWN_COUNT] = { .type = NLA_U32 },
> 	[IFLA_MIN_MTU]		= { .type = NLA_U32 },
> 	[IFLA_MAX_MTU]		= { .type = NLA_U32 },
>+	[IFLA_PERM_ADDRESS]	= { .type = NLA_REJECT },
> };
> 
> static const struct nla_policy ifla_info_policy[IFLA_INFO_MAX+1] = {
>-- 
>2.21.0
>
