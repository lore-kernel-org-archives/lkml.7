Return-Path: <SRS0=tJqY=VY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4324C76186
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 20:27:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81125208E4
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 20:27:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388349AbfG0U1Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jul 2019 16:27:25 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:39828 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387841AbfG0U1Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jul 2019 16:27:24 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 555C1153409C1;
        Sat, 27 Jul 2019 13:27:24 -0700 (PDT)
Date:   Sat, 27 Jul 2019 13:27:23 -0700 (PDT)
Message-Id: <20190727.132723.666166803498081831.davem@davemloft.net>
To:     baijiaju1990@gmail.com
Cc:     kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] net: ipv6: Fix a possible null-pointer dereference
 in vti6_link_config()
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190726080321.4466-1-baijiaju1990@gmail.com>
References: <20190726080321.4466-1-baijiaju1990@gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sat, 27 Jul 2019 13:27:24 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jia-Ju Bai <baijiaju1990@gmail.com>
Date: Fri, 26 Jul 2019 16:03:21 +0800

> @@ -646,9 +646,10 @@ static void vti6_link_config(struct ip6_tnl *t, bool keep_mtu)
>  						 &p->raddr, &p->laddr,
>  						 p->link, NULL, strict);
>  
> -		if (rt)
> +		if (rt) {
>  			tdev = rt->dst.dev;
> -		ip6_rt_put(rt);
> +			ip6_rt_put(rt);
> +		}

ip6_rt_put() can take a NULL argument without any problem.

I want to make it clear that because of mistakes of this nature, and
how frequently you make them, it is very tiring and exhausting to
review your changes...
