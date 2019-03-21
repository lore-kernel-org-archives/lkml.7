Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4483FC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 09:45:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14C4520850
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 09:45:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728217AbfCUJpp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 05:45:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50920 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727829AbfCUJpo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 05:45:44 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 015DA81F18;
        Thu, 21 Mar 2019 09:45:44 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.32.181.117])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 48CF660857;
        Thu, 21 Mar 2019 09:45:42 +0000 (UTC)
Message-ID: <e532fdb97e142eca2484e5abbeca4c30d11fbad6.camel@redhat.com>
Subject: Re: [net-next PATCH v3 4/8] net: Change return type of sk_busy_loop
 from bool to void
From:   Paolo Abeni <pabeni@redhat.com>
To:     Christoph Paasch <christoph.paasch@gmail.com>,
        Alexander Duyck <alexander.duyck@gmail.com>
Cc:     netdev <netdev@vger.kernel.org>, linux-kernel@vger.kernel.org,
        sridhar.samudrala@intel.com, Eric Dumazet <edumazet@google.com>,
        David Miller <davem@davemloft.net>, linux-api@vger.kernel.org
Date:   Thu, 21 Mar 2019 10:45:41 +0100
In-Reply-To: <CALMXkpb3MfLbNoBgLJc0rgMDbPg9yOevKOiq9N8pzVw-aeNb3g@mail.gmail.com>
References: <20170324164902.15226.48358.stgit@localhost.localdomain>
         <20170324170812.15226.97497.stgit@localhost.localdomain>
         <CALMXkpb3MfLbNoBgLJc0rgMDbPg9yOevKOiq9N8pzVw-aeNb3g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Thu, 21 Mar 2019 09:45:44 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 2019-03-20 at 11:35 -0700, Christoph Paasch wrote:
> Hello,
> 
> On Fri, Mar 24, 2017 at 3:23 PM Alexander Duyck
> <alexander.duyck@gmail.com> wrote:
> > From: Alexander Duyck <alexander.h.duyck@intel.com>
> > 
> > > From what I can tell there is only a couple spots where we are actually
> > checking the return value of sk_busy_loop. As there are only a few
> > consumers of that data, and the data being checked for can be replaced
> > with a check for !skb_queue_empty() we might as well just pull the code
> > out of sk_busy_loop and place it in the spots that actually need it.
> > 
> > Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
> > Acked-by: Eric Dumazet <edumazet@google.com>
> > ---
> >  include/net/busy_poll.h |    5 ++---
> >  net/core/datagram.c     |    8 ++++++--
> >  net/core/dev.c          |   25 +++++++++++--------------
> >  net/sctp/socket.c       |    9 ++++++---
> >  4 files changed, 25 insertions(+), 22 deletions(-)
> > 
> > diff --git a/include/net/busy_poll.h b/include/net/busy_poll.h
> > index b82d6ba70a14..c55760f4820f 100644
> > --- a/include/net/busy_poll.h
> > +++ b/include/net/busy_poll.h
> > @@ -74,7 +74,7 @@ static inline bool busy_loop_timeout(unsigned long end_time)
> >         return time_after(now, end_time);
> >  }
> > 
> > -bool sk_busy_loop(struct sock *sk, int nonblock);
> > +void sk_busy_loop(struct sock *sk, int nonblock);
> > 
> >  #else /* CONFIG_NET_RX_BUSY_POLL */
> >  static inline unsigned long net_busy_loop_on(void)
> > @@ -97,9 +97,8 @@ static inline bool busy_loop_timeout(unsigned long end_time)
> >         return true;
> >  }
> > 
> > -static inline bool sk_busy_loop(struct sock *sk, int nonblock)
> > +static inline void sk_busy_loop(struct sock *sk, int nonblock)
> >  {
> > -       return false;
> >  }
> > 
> >  #endif /* CONFIG_NET_RX_BUSY_POLL */
> > diff --git a/net/core/datagram.c b/net/core/datagram.c
> > index ea633342ab0d..4608aa245410 100644
> > --- a/net/core/datagram.c
> > +++ b/net/core/datagram.c
> > @@ -256,8 +256,12 @@ struct sk_buff *__skb_try_recv_datagram(struct
> > sock *sk, unsigned int flags,
> >                 }
> > 
> >                 spin_unlock_irqrestore(&queue->lock, cpu_flags);
> > -       } while (sk_can_busy_loop(sk) &&
> > -                sk_busy_loop(sk, flags & MSG_DONTWAIT));
> > +
> > +               if (!sk_can_busy_loop(sk))
> > +                       break;
> > +
> > +               sk_busy_loop(sk, flags & MSG_DONTWAIT);
> > +       } while (!skb_queue_empty(&sk->sk_receive_queue));
> 
> since this change I am hitting stalls where it's looping in this
> while-loop with syzkaller.
> 
> It worked prior to this change because sk->sk_napi_id was not set thus
> sk_busy_loop would make us get out of the loop.
> 
> Now, it keeps on looping because there is an skb in the queue with
> skb->len == 0 and we are peeking with an offset, thus
> __skb_try_recv_from_queue will return NULL and thus we have no way of
> getting out of the loop.
> 
> I'm not sure what would be the best way to fix it. I don't see why we
> end up with an skb in the list with skb->len == 0. So, shooting a
> quick e-mail, maybe somebody has an idea :-)
> 
> I have the syzkaller-reproducer if needed.

IIRC we can have 0 len UDP packet sitting on sk_receive_queue since:

commit e6afc8ace6dd5cef5e812f26c72579da8806f5ac
Author: samanthakumar <samanthakumar@google.com>
Date:   Tue Apr 5 12:41:15 2016 -0400

    udp: remove headers from UDP packets before queueing

Both __skb_try_recv_datagram() and napi_busy_loop() assume that we
received some packets if the queue is not empty. When peeking such
assumption is not true, we should check if the last packet is changed,
as __skb_recv_datagram() already does. So I *think* the root cause of
this issue is older than Alex's patch.

The following - completely untested - should avoid the unbounded loop,
but it's not a complete fix, I *think* we should also change
sk_busy_loop_end() in a similar way, but that is a little more complex
due to the additional indirections.

Could you please test it?

Any feedback welcome!


Could you please test it?

Paolo
---
diff --git a/net/core/datagram.c b/net/core/datagram.c
index b2651bb6d2a3..e657289db4ac 100644
--- a/net/core/datagram.c
+++ b/net/core/datagram.c
@@ -279,7 +279,7 @@ struct sk_buff *__skb_try_recv_datagram(struct sock
*sk, unsigned int flags,
                        break;
 
                sk_busy_loop(sk, flags & MSG_DONTWAIT);
-       } while (!skb_queue_empty(&sk->sk_receive_queue));
+       } while (sk->sk_receive_queue.prev != *last);
 
        error = -EAGAIN;


