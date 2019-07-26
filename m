Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F169C7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 11:45:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E850D229F9
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 11:45:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eJy4qywY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726393AbfGZLph (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 07:45:37 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:38985 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726298AbfGZLpd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 07:45:33 -0400
Received: by mail-yb1-f195.google.com with SMTP id z128so16092831yba.6
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2019 04:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2LG0AzeYCrP2HPh4ReaU07gb34Xc8BwShnIuQhHSCaA=;
        b=eJy4qywY76PYX6Wq+0zlTbLlEE+um6eGdLbCQ4a9LkeyyavV0kCo1CzQ1MfPBYJRHx
         mKRuwgeGGdIj0sI0lJuhlCTGJhzBlwxAw8ouHd+LhwuTOL66GBFLIypxORhqhGAhgFwJ
         yIvoLtiCqbodpU3TEp26OSbXbBawiJr76Ul80QWH/Jlx8mbbIE2AwyLn4CzxpOiInTx4
         rMDYMjB8Mw7yi7UqypknsRP35NtBUQHseHV4y43s931zqUwIPBQbX+UQblxDYV3xivMA
         /lnWdjX2Wc0qBe9HTFcYuqET4O4jPnwNLYf3tMUBBNUmkmUOibQ3JMvBCaBkoIWtY5iI
         OVjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2LG0AzeYCrP2HPh4ReaU07gb34Xc8BwShnIuQhHSCaA=;
        b=aSYJTOsOST8tOspc9KMC5mrz3+tLw371r4hqryi5Ya7xW4rzCB+lsDsPNClnZWCwmb
         ULQjTYZOoF37cugML85jhunJVxV2fqoEJKktDFSI0JYAmTG90g8K8Y4Ai2okkixMierM
         v5y3mXQazEKZV9yiwFqGAorTkJEtQOR8r0D2g5RestPhZCRXMbp6KBrBFB6g2aRDuigu
         aZo2EjFIX4O8ZXDAUdFjyh4EEPnwpo6eHAO06wVkkuxEKqFsIALh+8JubJDsWvd2PRbT
         5/r8Lv7ZV0lcLYCky01OGeo8p66lOfZNbQeE8DxzQgLxzchdo5g+D8HtKpjYnMY5d7Ba
         10PA==
X-Gm-Message-State: APjAAAVxrPaNe+uA667EHLLEd1L/kz3XDVNftrZMJDPV+0gyERx21myg
        xd4IEolloGY1BZJQHWm9k8N1SNFT
X-Google-Smtp-Source: APXvYqwUSmv1XDUd9+WpEG48JCFSHgo/pwzjHbwEwbVPga0swHQcKgwZ6t8wDuaRkGD3u0oXQM9ARQ==
X-Received: by 2002:a25:324b:: with SMTP id y72mr51809197yby.146.1564141532194;
        Fri, 26 Jul 2019 04:45:32 -0700 (PDT)
Received: from mail-yw1-f53.google.com (mail-yw1-f53.google.com. [209.85.161.53])
        by smtp.gmail.com with ESMTPSA id q83sm12796555ywq.88.2019.07.26.04.45.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Jul 2019 04:45:31 -0700 (PDT)
Received: by mail-yw1-f53.google.com with SMTP id i138so20253200ywg.8
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2019 04:45:30 -0700 (PDT)
X-Received: by 2002:a0d:c301:: with SMTP id f1mr53998273ywd.494.1564141530408;
 Fri, 26 Jul 2019 04:45:30 -0700 (PDT)
MIME-Version: 1.0
References: <20190726080307.4414-1-baijiaju1990@gmail.com>
In-Reply-To: <20190726080307.4414-1-baijiaju1990@gmail.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Fri, 26 Jul 2019 07:44:54 -0400
X-Gmail-Original-Message-ID: <CA+FuTSenOG7Y_RK7TTLKjXzQbX35YR_TyM5QGrf17ue5+JesXA@mail.gmail.com>
Message-ID: <CA+FuTSenOG7Y_RK7TTLKjXzQbX35YR_TyM5QGrf17ue5+JesXA@mail.gmail.com>
Subject: Re: [PATCH 1/2] net: ipv6: Fix a possible null-pointer dereference in ip6_xmit()
To:     Jia-Ju Bai <baijiaju1990@gmail.com>
Cc:     David Miller <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Network Development <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 26, 2019 at 4:03 AM Jia-Ju Bai <baijiaju1990@gmail.com> wrote:
>
> In ip6_xmit(), there is an if statement on line 245 to check whether
> np is NULL:
>     if (np)
>
> When np is NULL, it is used on line 251:
>     ip6_autoflowlabel(net, np)
>         if (!np->autoflowlabel_set)
>
> Thus, a possible null-pointer dereference may occur.
>
> To fix this bug, np is checked before calling
> ip6_autoflowlabel(net,np).
>
> This bug is found by a static analysis tool STCheck written by us.
>
> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
> ---
>  net/ipv6/ip6_output.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
> index 8e49fd62eea9..07db5ab6e970 100644
> --- a/net/ipv6/ip6_output.c
> +++ b/net/ipv6/ip6_output.c
> @@ -247,8 +247,10 @@ int ip6_xmit(const struct sock *sk, struct sk_buff *skb, struct flowi6 *fl6,
>         if (hlimit < 0)
>                 hlimit = ip6_dst_hoplimit(dst);
>
> -       ip6_flow_hdr(hdr, tclass, ip6_make_flowlabel(net, skb, fl6->flowlabel,
> -                               ip6_autoflowlabel(net, np), fl6));
> +       if (np) {
> +               ip6_flow_hdr(hdr, tclass, ip6_make_flowlabel(net, skb, fl6->flowlabel,
> +                                       ip6_autoflowlabel(net, np), fl6));
> +       }

I don't know when np can be NULL in ip6_xmit. But if so, must still
setup the ipv6 header.

A more narrow change would be in ip6_autoflowlabel

-        if (!np->autoflowlabel_set)
+       if (!np || !np->autoflowlabel_set)
