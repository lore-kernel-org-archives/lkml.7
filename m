Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51296C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 14:29:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11C23218E2
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 14:29:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QxHQ9dex"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728466AbfCUO30 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 10:29:26 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:46590 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727958AbfCUO3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 10:29:23 -0400
Received: by mail-ed1-f65.google.com with SMTP id d1so5139482edd.13;
        Thu, 21 Mar 2019 07:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4qFQyZDpAIuWe7V2bA6VFG63G9iCMVdOI5wtkeHaJRw=;
        b=QxHQ9dexD53MZqgNJUKdve/CUGqzrmpxZLLLpsoqEinOj5rhxbos8hCJmyEd1EAHky
         QT/HCwT9jeE7LFNo+DeuiLfjPp9WUxo04Lq+SOxOsUGuTS2hJnIXT5/K64BPTZyqKYHB
         1scSHVKc3AoPX+AjPYxtTxB2XIwfO4gug+bAosJTka95gXB7hqbb0VvtePkkR0cHP6qB
         Z7d4zroMpRlXkesRI2t8ZB7i6doQZJ7eA2gtahMGV9mI+7EyeYeof1Bi5AE/sP51A0p+
         7FkNg5rapugBYppcbwBNLgKyughR6Z2XroTOWODhsDsj7Tcs5GaGkS7xlQCWF9PlWjaz
         6MRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4qFQyZDpAIuWe7V2bA6VFG63G9iCMVdOI5wtkeHaJRw=;
        b=jATwqk5PKtRRaD3LoH0JuospY9fWDuDB1nWnnLdJuugmwBLlsF6N0lpufS9IftIblo
         0gzDGQgdSNDQYnU6sEPcZdh7eMyz+gi3YE/tUMyi88YK547rmNdjadbWDn8ZnZMonvxC
         BB5iNG/OO6xOXbeerFQCszTE1Mw6VsCrGTlvFiYeEblJa0YimwpfRjXB0n961EmEHkwM
         GXqx6kwi0MtVXpejXxKjDWHVBttJAa7N6okFZdBYsmnBCc0IGgW8KtxuBbM3woERF1uo
         KrnU/T427cSocIetFcZLtw59OVyn9CHWhuMj2BG8NK0mJahQcVZ79TkI49Spy4H7+DXZ
         2wwA==
X-Gm-Message-State: APjAAAXQORMQ6x60u587uaiPaQRRwZbG/hM6RHihAiyWo5zhl5Kz4zL/
        EgeeyyUmOD012a6ADEzK8lCTOIRYMSmLTZCC9Sw=
X-Google-Smtp-Source: APXvYqzJw8BpYBewnVzQTxrUEk0/z/1uOYUzEWzVwR98rPKj15VdWRkbOQN9rN0bh0fx4y9cKuxDm+b2sMxa7lKuTAY=
X-Received: by 2002:a17:906:c4f:: with SMTP id t15mr2553795ejf.132.1553178561657;
 Thu, 21 Mar 2019 07:29:21 -0700 (PDT)
MIME-Version: 1.0
References: <20170324164902.15226.48358.stgit@localhost.localdomain>
 <20170324170812.15226.97497.stgit@localhost.localdomain> <CALMXkpb3MfLbNoBgLJc0rgMDbPg9yOevKOiq9N8pzVw-aeNb3g@mail.gmail.com>
 <e532fdb97e142eca2484e5abbeca4c30d11fbad6.camel@redhat.com>
In-Reply-To: <e532fdb97e142eca2484e5abbeca4c30d11fbad6.camel@redhat.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Thu, 21 Mar 2019 10:28:45 -0400
Message-ID: <CAF=yD-JwetDu2NjHi=HX=2UHHFKE5i9arCOP7bcEFN-fxvR58Q@mail.gmail.com>
Subject: Re: [net-next PATCH v3 4/8] net: Change return type of sk_busy_loop
 from bool to void
To:     Paolo Abeni <pabeni@redhat.com>
Cc:     Christoph Paasch <christoph.paasch@gmail.com>,
        Alexander Duyck <alexander.duyck@gmail.com>,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Samudrala, Sridhar" <sridhar.samudrala@intel.com>,
        Eric Dumazet <edumazet@google.com>,
        David Miller <davem@davemloft.net>,
        Linux API <linux-api@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 21, 2019 at 5:46 AM Paolo Abeni <pabeni@redhat.com> wrote:
>
> Hi,
>
> On Wed, 2019-03-20 at 11:35 -0700, Christoph Paasch wrote:
> > Hello,
> >
> > On Fri, Mar 24, 2017 at 3:23 PM Alexander Duyck
> > <alexander.duyck@gmail.com> wrote:
> > > From: Alexander Duyck <alexander.h.duyck@intel.com>
> > >
> > > > From what I can tell there is only a couple spots where we are actually
> > > checking the return value of sk_busy_loop. As there are only a few
> > > consumers of that data, and the data being checked for can be replaced
> > > with a check for !skb_queue_empty() we might as well just pull the code
> > > out of sk_busy_loop and place it in the spots that actually need it.
> > >
> > > Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
> > > Acked-by: Eric Dumazet <edumazet@google.com>
> > > ---
> > >  include/net/busy_poll.h |    5 ++---
> > >  net/core/datagram.c     |    8 ++++++--
> > >  net/core/dev.c          |   25 +++++++++++--------------
> > >  net/sctp/socket.c       |    9 ++++++---
> > >  4 files changed, 25 insertions(+), 22 deletions(-)
> > >
> > > diff --git a/include/net/busy_poll.h b/include/net/busy_poll.h
> > > index b82d6ba70a14..c55760f4820f 100644
> > > --- a/include/net/busy_poll.h
> > > +++ b/include/net/busy_poll.h
> > > @@ -74,7 +74,7 @@ static inline bool busy_loop_timeout(unsigned long end_time)
> > >         return time_after(now, end_time);
> > >  }
> > >
> > > -bool sk_busy_loop(struct sock *sk, int nonblock);
> > > +void sk_busy_loop(struct sock *sk, int nonblock);
> > >
> > >  #else /* CONFIG_NET_RX_BUSY_POLL */
> > >  static inline unsigned long net_busy_loop_on(void)
> > > @@ -97,9 +97,8 @@ static inline bool busy_loop_timeout(unsigned long end_time)
> > >         return true;
> > >  }
> > >
> > > -static inline bool sk_busy_loop(struct sock *sk, int nonblock)
> > > +static inline void sk_busy_loop(struct sock *sk, int nonblock)
> > >  {
> > > -       return false;
> > >  }
> > >
> > >  #endif /* CONFIG_NET_RX_BUSY_POLL */
> > > diff --git a/net/core/datagram.c b/net/core/datagram.c
> > > index ea633342ab0d..4608aa245410 100644
> > > --- a/net/core/datagram.c
> > > +++ b/net/core/datagram.c
> > > @@ -256,8 +256,12 @@ struct sk_buff *__skb_try_recv_datagram(struct
> > > sock *sk, unsigned int flags,
> > >                 }
> > >
> > >                 spin_unlock_irqrestore(&queue->lock, cpu_flags);
> > > -       } while (sk_can_busy_loop(sk) &&
> > > -                sk_busy_loop(sk, flags & MSG_DONTWAIT));
> > > +
> > > +               if (!sk_can_busy_loop(sk))
> > > +                       break;
> > > +
> > > +               sk_busy_loop(sk, flags & MSG_DONTWAIT);
> > > +       } while (!skb_queue_empty(&sk->sk_receive_queue));
> >
> > since this change I am hitting stalls where it's looping in this
> > while-loop with syzkaller.
> >
> > It worked prior to this change because sk->sk_napi_id was not set thus
> > sk_busy_loop would make us get out of the loop.
> >
> > Now, it keeps on looping because there is an skb in the queue with
> > skb->len == 0 and we are peeking with an offset, thus
> > __skb_try_recv_from_queue will return NULL and thus we have no way of
> > getting out of the loop.
> >
> > I'm not sure what would be the best way to fix it. I don't see why we
> > end up with an skb in the list with skb->len == 0. So, shooting a
> > quick e-mail, maybe somebody has an idea :-)
> > I have the syzkaller-reproducer if needed.
>
> IIRC we can have 0 len UDP packet sitting on sk_receive_queue since:

Yes, as of header before enqueue pulling zero byte datagrams may be
queued. And these need to be delivered, among other reason for their
cmsg metadata.

> commit e6afc8ace6dd5cef5e812f26c72579da8806f5ac
> Author: samanthakumar <samanthakumar@google.com>
> Date:   Tue Apr 5 12:41:15 2016 -0400
>
>     udp: remove headers from UDP packets before queueing
>
> Both __skb_try_recv_datagram() and napi_busy_loop() assume that we
> received some packets if the queue is not empty. When peeking such
> assumption is not true, we should check if the last packet is changed,
> as __skb_recv_datagram() already does.

Good catch. The condition in sk_busy_loop_end is not easy to address.
Since busy poll is an optimization and poll at offset rare, one way
out may be to amend the __sk_can_busy_loop test in __skb_recv_udp to
disallow busy polling together with peek at offset.

The difference in behavior betwee __skb_try_recv_datagram and
__skb_recv_datagram also reminds of Alexei's earlier report (without
busy polling, seemingly with a list corruption introduced elsewhere)
in

  [net-next,1/3] net/sock: factor out dequeue/peek with offset code
  https://patchwork.ozlabs.org/patch/762327/


> So I *think* the root cause of
> this issue is older than Alex's patch.
>
> The following - completely untested - should avoid the unbounded loop,
> but it's not a complete fix, I *think* we should also change
> sk_busy_loop_end() in a similar way, but that is a little more complex
> due to the additional indirections.
>
> Could you please test it?
>
> Any feedback welcome!
>
>
> Could you please test it?
>
> Paolo
> ---
> diff --git a/net/core/datagram.c b/net/core/datagram.c
> index b2651bb6d2a3..e657289db4ac 100644
> --- a/net/core/datagram.c
> +++ b/net/core/datagram.c
> @@ -279,7 +279,7 @@ struct sk_buff *__skb_try_recv_datagram(struct sock
> *sk, unsigned int flags,
>                         break;
>
>                 sk_busy_loop(sk, flags & MSG_DONTWAIT);
> -       } while (!skb_queue_empty(&sk->sk_receive_queue));
> +       } while (sk->sk_receive_queue.prev != *last);
>
>         error = -EAGAIN;
>
>
