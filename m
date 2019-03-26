Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4192C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 19:46:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFCAB20823
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 19:46:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732319AbfCZTqw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 15:46:52 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:49680 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726278AbfCZTqw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 15:46:52 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 2570514C652C3;
        Tue, 26 Mar 2019 12:46:51 -0700 (PDT)
Date:   Tue, 26 Mar 2019 12:46:46 -0700 (PDT)
Message-Id: <20190326.124646.505432518345625779.davem@davemloft.net>
To:     mkubecek@suse.cz
Cc:     netdev@vger.kernel.org, jakub.kicinski@netronome.com,
        jiri@resnulli.us, andrew@lunn.ch, f.fainelli@gmail.com,
        linville@tuxdriver.com, stephen@networkplumber.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 01/22] rtnetlink: provide permanent
 hardware address in RTM_NEWLINK
From:   David Miller <davem@davemloft.net>
In-Reply-To: <16ffb1fbfa8f54de587ac52f4ff95e5034c590b4.1553532199.git.mkubecek@suse.cz>
References: <cover.1553532199.git.mkubecek@suse.cz>
        <16ffb1fbfa8f54de587ac52f4ff95e5034c590b4.1553532199.git.mkubecek@suse.cz>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 26 Mar 2019 12:46:51 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michal Kubecek <mkubecek@suse.cz>
Date: Mon, 25 Mar 2019 18:07:57 +0100 (CET)

> @@ -1683,6 +1684,8 @@ static int rtnl_fill_ifinfo(struct sk_buff *skb,
>  	    nla_put_s32(skb, IFLA_NEW_IFINDEX, new_ifindex) < 0)
>  		goto nla_put_failure;
>  
> +	if (nla_put(skb, IFLA_PERM_ADDRESS, dev->addr_len, dev->perm_addr))
> +		goto nla_put_failure;
>  
>  	rcu_read_lock();
>  	if (rtnl_fill_link_af(skb, dev, ext_filter_mask))

I guess, as Jiri says, we really do have to check if the driver
actually set this before pushing the attribute out to userspace.

But seriously, you chould just check for dev_addr_len zeros.

All zeros is not a valid link address on any link type.
