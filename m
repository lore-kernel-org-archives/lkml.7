Return-Path: <SRS0=wu79=TZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4CB5C282E5
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 12:12:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6A882075E
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 12:12:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbfEYMMm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 May 2019 08:12:42 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:42733 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726585AbfEYMMm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 May 2019 08:12:42 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 52BEA80364; Sat, 25 May 2019 14:12:30 +0200 (CEST)
Date:   Sat, 25 May 2019 14:11:59 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Pieter Jansen van Vuuren 
        <pieter.jansenvanvuuren@netronome.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        John Hurley <john.hurley@netronome.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH 4.19 008/114] nfp: flower: add rcu locks when accessing
 netdev for tunnels
Message-ID: <20190525121159.GA1376@xo-6d-61-c0.localdomain>
References: <20190523181731.372074275@linuxfoundation.org>
 <20190523181732.329357922@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190523181732.329357922@linuxfoundation.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> From: Pieter Jansen van Vuuren <pieter.jansenvanvuuren@netronome.com>
> 
> [ Upstream commit cb07d915bf278a7a3938b983bbcb4921366b5eff ]
> 
> Add rcu locks when accessing netdev when processing route request
> and tunnel keep alive messages received from hardware.

>  	/* Get the neighbour entry for the lookup */
>  	n = dst_neigh_lookup(&rt->dst, &flow.daddr);
>  	ip_rt_put(rt);
>  	if (!n)
> -		goto route_fail_warning;
> -	nfp_tun_write_neigh(n->dev, app, &flow, n, GFP_KERNEL);
> +		goto fail_rcu_unlock;
> +	nfp_tun_write_neigh(n->dev, app, &flow, n, GFP_ATOMIC);
>  	neigh_release(n);
> +	rcu_read_unlock();
>  	return;


This will make allocations more likely to fail. I thought it is okay to sleep in
rcu lock critical sections...?
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
