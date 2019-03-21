Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0502C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 16:43:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 664F82175B
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 16:43:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ndx06Er1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728673AbfCUQnf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 12:43:35 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:41602 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726787AbfCUQne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 12:43:34 -0400
Received: by mail-io1-f66.google.com with SMTP id v10so5779756iom.8;
        Thu, 21 Mar 2019 09:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WhUIibBwPuGZJJMXSp7g1HHM2FHSlDOq/daC95m5eTo=;
        b=ndx06Er1hOPA2N7tZqYIR/bARwta1/gJcfw4e6mtfF8nPowSEj+kfAv/QmeRbiQ2cU
         RDpWkRNp9meBYL0AM6873KmJFuQMqSnH3ZEEt/VrtaTihGaqqc02wiWrnc3cY+9hacpE
         pHXN2Om6tTXlliSDg3F/owCOcnIDGv23IAR9/f63D8jdhg+jHUuZAjFPCaS29qgaZYdm
         CLFQtXnc1yVWnywW5q2Fv2SeXi+mcRr5XEduCfyOmVew+kJjVY81LBMfV2AhWkPcOqhL
         ukWp2bcv6wUMgRmeFKgqiysN+2srjZKUbo6iaf+9C+7LrC5qQI6sCfOic4Hg3M/YUYhZ
         3GzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WhUIibBwPuGZJJMXSp7g1HHM2FHSlDOq/daC95m5eTo=;
        b=KgBT7SY4XUKJqFsFUksxQ/SINslMqXkJIeiHgzvR3A06u8eqGf8Yjd5btZVAyhiA1E
         ShmU4+XUjaxGaIfo964gUMcL/WNc/RS1eVwepcgBAfDd7SF0gEymZ7QWo3lc19yfX9pd
         6hAgjQcpqg+p6jaiqZXSLlApSjKWpB3p/64VQJK3ODiQSCAzXnvT3o0KXvF8y79rnZUF
         9aLijUUK5wPRvE2nRXaiwspxeYgVHA8k8wUw2YGf6Hn7fD580Da548924gV0m3vfd7q/
         7+aqvLoEPKsMpGEH9L692JhDJ3FgeKSTrS3uZ9eZj/7FFd2BNCIf0Osw8ARtUwn+Su36
         bvvw==
X-Gm-Message-State: APjAAAXPArlSH7QUJ9sy9S1o/yBREKNQwCimPdHwZ4hhIGxWUHK3GiAF
        y6U3rQqhDLemA1tVLvoRgxqOA7DOWkvxuXWcuT8=
X-Google-Smtp-Source: APXvYqxOJS5NstCrn81nR3Q0h4pv0vTWiSN1QkJUc4XQYgh/6Lqa06PB+nM1gVq6kZNIlmDevDPFkZtY93HeYU2/plc=
X-Received: by 2002:a5d:8757:: with SMTP id k23mr3716300iol.68.1553186613308;
 Thu, 21 Mar 2019 09:43:33 -0700 (PDT)
MIME-Version: 1.0
References: <20170324164902.15226.48358.stgit@localhost.localdomain>
 <20170324170812.15226.97497.stgit@localhost.localdomain> <CALMXkpb3MfLbNoBgLJc0rgMDbPg9yOevKOiq9N8pzVw-aeNb3g@mail.gmail.com>
 <e532fdb97e142eca2484e5abbeca4c30d11fbad6.camel@redhat.com>
In-Reply-To: <e532fdb97e142eca2484e5abbeca4c30d11fbad6.camel@redhat.com>
From:   Alexander Duyck <alexander.duyck@gmail.com>
Date:   Thu, 21 Mar 2019 09:43:22 -0700
Message-ID: <CAKgT0Uc68jsuPHKbxxFpeMCQAo2M69DhzA_XGw7Kvou4H3eHPg@mail.gmail.com>
Subject: Re: [net-next PATCH v3 4/8] net: Change return type of sk_busy_loop
 from bool to void
To:     Paolo Abeni <pabeni@redhat.com>
Cc:     Christoph Paasch <christoph.paasch@gmail.com>,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Samudrala, Sridhar" <sridhar.samudrala@intel.com>,
        Eric Dumazet <edumazet@google.com>,
        David Miller <davem@davemloft.net>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 21, 2019 at 2:45 AM Paolo Abeni <pabeni@redhat.com> wrote:
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
> >
> > I have the syzkaller-reproducer if needed.
>
> IIRC we can have 0 len UDP packet sitting on sk_receive_queue since:
>
> commit e6afc8ace6dd5cef5e812f26c72579da8806f5ac
> Author: samanthakumar <samanthakumar@google.com>
> Date:   Tue Apr 5 12:41:15 2016 -0400
>
>     udp: remove headers from UDP packets before queueing
>
> Both __skb_try_recv_datagram() and napi_busy_loop() assume that we
> received some packets if the queue is not empty. When peeking such
> assumption is not true, we should check if the last packet is changed,
> as __skb_recv_datagram() already does. So I *think* the root cause of
> this issue is older than Alex's patch.

I agree.

> The following - completely untested - should avoid the unbounded loop,
> but it's not a complete fix, I *think* we should also change
> sk_busy_loop_end() in a similar way, but that is a little more complex
> due to the additional indirections.

As far as sk_busy_loop_end we could look at just forking sk_busy_loop
and writing a separate implementation for datagram sockets that uses a
different loop_end function. It shouldn't take much to change since
all we would need to do is pass a structure containing the sk and last
pointers instead of just passing the sk directly as the loop_end
argument.

> Could you please test it?
>
> Any feedback welcome!

The change below looks good to me.

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
