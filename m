Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 874A0C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 09:23:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51E0D2086C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 09:23:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gU90VgSh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726685AbfDAJXw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 05:23:52 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:43815 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725821AbfDAJXw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 05:23:52 -0400
Received: by mail-yb1-f193.google.com with SMTP id a123so1498505ybg.10
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2019 02:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G79lPwHlmGqFf9NxN0nb+7/V1m5OMopGzu30AXNNOBY=;
        b=gU90VgShcnQ+VldL4dMf9XTRHPmDzIkSIZvknFrF7cXy+vFjD54WDtBWILb+mocQOs
         H/iqjuptFyNFH/eJC+2kVVcVcHIFGHc3JQB+cmK09w/7QE4lEQh91JrRukj6VbI+yiNc
         Im/Ciz2G181hNbpXbjY+J99DVByWPnXiV42eZUoaIL3StihdvHtVcuE1Cn5gw86f+cRi
         vIGX3t2vAqgmOiI/jTFnb28TwFeLcOCQABBOG5AvKmRYqe3oiXkcYo4cddPYXvuT9jAK
         QE1KQynPsv63UOHublrcO/TCBoboJb00eQmAjB9K7CnZBmDEI77QaJx8QAhFQOX8bzFk
         Lr5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G79lPwHlmGqFf9NxN0nb+7/V1m5OMopGzu30AXNNOBY=;
        b=HF3RNMLhb/FpKDh7rY1b3wwwJ6z+rDd23x92K54kPI6pm6i9d1xFJMXV9hRv8RkvIa
         R0BTJm3p73n9LRBaUPvOA5h5AS2NXTz5WWu28gppyA1Rn4mTav3WyEg5xk/AYgHNFQgL
         QKOsXPOVqgnosjLKXPTGuFGhUCvuIQWQQDgIH4aexe0mB9NU8AAbl1b1VrHFp/9Q0PEe
         3ebpsnwgEUsMAjwjh0StjoR0M3vDZNFEQrToWcLRfR+9O2pCV6WU7RZWiPpfTMvVTDI1
         J9zRAA6fxrmQLCLDfwcsafQCy1gEqdTyYT9UVbObKXJyH7NojnMtGAiAz0VXykKIA1UX
         DEIw==
X-Gm-Message-State: APjAAAUwO6UtuNpjGf2Wm2LfCRBUOASiofuP1/8Vphf27CqIwgoHOiYd
        bjxOy64CedDWgFegeImI9gBJIE57VBgiUEt3roqwIQ==
X-Google-Smtp-Source: APXvYqzNB/9xZ6+LcNAC1IzFnFP76Ip9u6egUg9bPGcGHHHg61tQstrfwb8SVhu6lJAX78gXJDV36qiP3THEpjbaMeg=
X-Received: by 2002:a25:aae5:: with SMTP id t92mr4476279ybi.461.1554110631378;
 Mon, 01 Apr 2019 02:23:51 -0700 (PDT)
MIME-Version: 1.0
References: <20190401080453.87465-1-dust.li@linux.alibaba.com>
In-Reply-To: <20190401080453.87465-1-dust.li@linux.alibaba.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Mon, 1 Apr 2019 02:23:39 -0700
Message-ID: <CANn89iLAHD1Jkk4xeKUk89s7FPVaBdE5AHu3zNdBZNMn8w8mBw@mail.gmail.com>
Subject: Re: [PATCH] tcp: fix a potential NULL pointer dereference in tcp_sk_exit
To:     "dust.li" <dust.li@linux.alibaba.com>
Cc:     David Miller <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, caspar@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 1, 2019 at 1:05 AM dust.li <dust.li@linux.alibaba.com> wrote:
>
> From: Dust Li <dust.li@linux.alibaba.com>
>
>  When tcp_sk_init() failed in inet_ctl_sock_create(),
>  'net->ipv4.tcp_congestion_control' will be left
>  uninitialized, but tcp_sk_exit() hasn't check for
>  that.
>
>  This patch add checking on 'net->ipv4.tcp_congestion_control'
>  in tcp_sk_exit() to prevent NULL-ptr dereference.
>
> Signed-off-by: Dust Li <dust.li@linux.alibaba.com>

Fixes: 6670e1524477 ("tcp: Namespace-ify sysctl_tcp_default_congestion_control")
Signed-off-by: Eric Dumazet <edumazet@google.com>

Thanks.


> ---
>  net/ipv4/tcp_ipv4.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
> index 277d71239d75..2f8039a26b08 100644
> --- a/net/ipv4/tcp_ipv4.c
> +++ b/net/ipv4/tcp_ipv4.c
> @@ -2578,7 +2578,8 @@ static void __net_exit tcp_sk_exit(struct net *net)
>  {
>         int cpu;
>
> -       module_put(net->ipv4.tcp_congestion_control->owner);
> +       if (net->ipv4.tcp_congestion_control)
> +               module_put(net->ipv4.tcp_congestion_control->owner);
>
>         for_each_possible_cpu(cpu)
>                 inet_ctl_sock_destroy(*per_cpu_ptr(net->ipv4.tcp_sk, cpu));
> --
> 2.14.4.44.g2045bb6
>
