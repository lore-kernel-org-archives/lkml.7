Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A15CCC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 17:29:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 747482063F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 17:29:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727891AbfCKR3k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 13:29:40 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:39400 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727019AbfCKR3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 13:29:40 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 9EF4614C4E3D2;
        Mon, 11 Mar 2019 10:29:39 -0700 (PDT)
Date:   Mon, 11 Mar 2019 10:29:37 -0700 (PDT)
Message-Id: <20190311.102937.1716496269975009682.davem@davemloft.net>
To:     linmiaohe@huawei.com
Cc:     kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingfangsen@huawei.com
Subject: Re: [PATCH net] net: sit: fix UBSAN Undefined behaviour in
 check_6rd
From:   David Miller <davem@davemloft.net>
In-Reply-To: <694fb074-53a3-af60-6561-57c022445a48@huawei.com>
References: <694fb074-53a3-af60-6561-57c022445a48@huawei.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 11 Mar 2019 10:29:39 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: linmiaohe <linmiaohe@huawei.com>
Date: Mon, 11 Mar 2019 16:29:32 +0800

> @@ -778,8 +778,9 @@ static bool check_6rd(struct ip_tunnel *tunnel, const struct in6_addr *v6dst,
>  		pbw0 = tunnel->ip6rd.prefixlen >> 5;
>  		pbi0 = tunnel->ip6rd.prefixlen & 0x1f;
> 
> -		d = (ntohl(v6dst->s6_addr32[pbw0]) << pbi0) >>
> -		    tunnel->ip6rd.relay_prefixlen;
> +		d = tunnel->ip6rd.relay_prefixlen < 32 ?
> +			(ntohl(v6dst->s6_addr32[pbw0]) << pbi0) >>
> +		    tunnel->ip6rd.relay_prefixlen : 0;
> 

I hate the fact that we have to guard against something which the rest
of the code makes sure NEVER EVER happens.

Every assignment of ->relay_prefixlen is guarded by a check against 32.

I don't like this at all, and I have to put my foot down somehow.

So I'm not applying this, sorry.
