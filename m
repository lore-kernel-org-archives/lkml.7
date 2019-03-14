Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 541C5C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 15:25:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DE7B2184C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 15:25:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DV01qAdU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727057AbfCNPZc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 11:25:32 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:46159 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726330AbfCNPZc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 11:25:32 -0400
Received: by mail-ed1-f68.google.com with SMTP id n17so4953983edt.13;
        Thu, 14 Mar 2019 08:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ajQWCCFVhOk6cZIn9Wuz9K+rzQYn18e17+wGvS8UH/Q=;
        b=DV01qAdUojn+MTOtAWgiDBDVkgWLm/kE2CZzUrL47fl9h4dwZQrQYkKJwEziimWY6Z
         CppiQCwYo7JmgtrcYDDsup9QGn5i3UjLX/2K6BZ3SN9FO3HN2bSCxlww9j2YHUahrqRT
         lyKlHiKBAq6roqdorM4uQ5LwhmVfvutV2fXtGdJTbLK7gt+I69G+7ni1NOfTM8fDATBL
         rQPoY5HsSJCJ/bZ3+OKz11JLtmabyNOmwk0j58eVZa8/A/M2ewwpD9JQhICKC8zAZPRQ
         wXCj9C1fQ5oVpmh5CIB/ztIilLIxqSuI4FiKcaGcLl64NMZtS4CKoHLgHlUHLa7cm1aP
         dNIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ajQWCCFVhOk6cZIn9Wuz9K+rzQYn18e17+wGvS8UH/Q=;
        b=T46Vo5sv6JeUL1D/wIfHvvxqK3lTKzs70J77uG+SBz659idyiGx0Z8Y9VN4/UUMMF0
         NA5eTjXAZSIGkOw1gYSJ/HLTDlqLunBB17UuJQlDMBc1mi8vG7KPV9WtUJazp2w5IXmK
         kMkCVJx8Ai9dz+GSyo/6pGj2YpAUL+dHcgHWQXX2XY01l44QuHSj94DSUFsfIVV+xWSR
         eRgvaTuBlXkqp7Ki9gD8ljAFVGq3BYSjVyhN3n4qJtT5W2Px42kUMwXZ9jvFQSMkc8pf
         NPqYTAgJohORq0lzYZq+PnrI02UZzxKHnSlFVgdDU76TyU3VBpYeVtYWlgo/+MOO3pQQ
         D+uQ==
X-Gm-Message-State: APjAAAWJXAYOUvXkedO8DMaTunz7wAYk0Qt5pQIqdytRFADcEVafEpea
        K3JTivlreqKbswC/ZINTyiRSI2eXgBWp2sEuV/M=
X-Google-Smtp-Source: APXvYqxIQcYa/9i2mUSLehvRzf9w6S0Qs1PixCtoe6XwhowlXI+mgGc/bcufZKB2Vck5d+dAnykcAXL2szDM0mcgSMA=
X-Received: by 2002:a50:b16d:: with SMTP id l42mr11749585edd.98.1552577130058;
 Thu, 14 Mar 2019 08:25:30 -0700 (PDT)
MIME-Version: 1.0
References: <20190314122450.5242-1-maxime.chevallier@bootlin.com>
In-Reply-To: <20190314122450.5242-1-maxime.chevallier@bootlin.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Thu, 14 Mar 2019 11:24:54 -0400
Message-ID: <CAF=yD-+e3f1VED3+6J7rQYac9A3w=CDQhrLq+eRLA88+vLOzDA@mail.gmail.com>
Subject: Re: [RFC PATCH net] packets: Always register packet sk in the same order
To:     Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Willem de Bruijn <willemb@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 14, 2019 at 8:27 AM Maxime Chevallier
<maxime.chevallier@bootlin.com> wrote:
>
> When using fanouts with AF_PACKET, the demux functions such as
> fanout_demux_cpu will return an index in the fanout socket array, which
> corresponds to the selected socket.
>
> The ordering of this array depends on the order the sockets were added
> to a given fanout group, so for FANOUT_CPU this means sockets are bound
> to cpus in the order they are configured, which is OK.
>
> However, when stopping then restarting the interface these sockets are
> bound to, the sockets are reassigned to the fanout group in the reverse
> order, due to the fact that they were inserted at the head of the
> interface's AF_PACKET socket list.
>
> This means that traffic that was directed to the first socket in the
> fanout group is now directed to the last one after an interface restart.
>
> In the case of FANOUT_CPU, traffic from CPU0 will be directed to the
> socket that used to receive traffic from the last CPU after an interface
> restart.

The above assumes that sockets are added to a fanout group in the
order in which they are created. That is a reasonable assumption,
though not strictly required. This can be worked around in userspace
by inserting in the inverse order. Still, good to fix.

It does change the order of output of proc and diag, which is an
unfortunately side effect. But insertion order is less surprising and
I don't see a simple option to only traverse the sklist in inverse
order on packet_notifier NETDEV_UP (which would avoid this).

> This commit introduces a helper to add a socket at the tail of a list,
> then uses it to register AF_PACKET sockets.
>
> Fixes: 808f5114a920 ("packet: convert socket list to RCU (v3)")

Before this patch, insertion with sk_add_node is also at the head.
This does not seem like the right commit? This behavior has probably
existed as long as fanout.


> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> ---
>
> Hi All,
>
> I stumbled upon this issue when using FANOUT_CPU and came-up with this
> patch, but I'm not sure that (a) this is really a bug (although this
> behaviour is at least misleading) and (b) this is the correct fix,
> so any input on this is welcome.
>
> Also David, I'm not sure about the Fixes tag, from what I see, this
> behaviour has always been there.
>
> Thanks,
>
> Maxime
>
>  include/net/sock.h     | 6 ++++++
>  net/packet/af_packet.c | 2 +-
>  2 files changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/include/net/sock.h b/include/net/sock.h
> index 328cb7cb7b0b..8de5ee258b93 100644
> --- a/include/net/sock.h
> +++ b/include/net/sock.h
> @@ -710,6 +710,12 @@ static inline void sk_add_node_rcu(struct sock *sk, struct hlist_head *list)
>                 hlist_add_head_rcu(&sk->sk_node, list);
>  }
>
> +static inline void sk_add_node_tail_rcu(struct sock *sk, struct hlist_head *list)
> +{
> +       sock_hold(sk);
> +       hlist_add_tail_rcu(&sk->sk_node, list);
> +}
> +
>  static inline void __sk_nulls_add_node_rcu(struct sock *sk, struct hlist_nulls_head *list)
>  {
>         hlist_nulls_add_head_rcu(&sk->sk_nulls_node, list);
> diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
> index 8376bc1c1508..8754d7c93b84 100644
> --- a/net/packet/af_packet.c
> +++ b/net/packet/af_packet.c
> @@ -3243,7 +3243,7 @@ static int packet_create(struct net *net, struct socket *sock, int protocol,
>         }
>
>         mutex_lock(&net->packet.sklist_lock);
> -       sk_add_node_rcu(sk, &net->packet.sklist);
> +       sk_add_node_tail_rcu(sk, &net->packet.sklist);
>         mutex_unlock(&net->packet.sklist_lock);
>
>         preempt_disable();
> --
> 2.20.1
>
