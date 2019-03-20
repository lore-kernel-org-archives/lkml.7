Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CED6C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 18:35:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA8BF20850
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 18:35:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qr46/XFG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727521AbfCTSfn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 14:35:43 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39214 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727271AbfCTSfn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 14:35:43 -0400
Received: by mail-pf1-f195.google.com with SMTP id i17so2534786pfo.6;
        Wed, 20 Mar 2019 11:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lR6T4LxC8Ut+pruCXD5qzI/XSt9fav7mXEUWyJO1+HI=;
        b=qr46/XFGjT+BtEbuWaAOkag94Ys0UXrt3F+cqYpiEgm87xa+GcTytnA2deS6l2zcY3
         QtKbY0mLkd8uwOH2dAvMlTcABT+v7n4lRmxCzFIDNSzO1iYesP89boljgzv9597SrAmX
         Y4F2lfvtIZFedSJVKaoOqfGX0eUscafzh9GVVi9yzQevGvbSyEXbOq3FszhdJ3ADeL23
         iG/7JyJpBAReLs+xL2mHa+AIy4rXH4rDFrdvL0VCop/Z+OhqOZmWVSreFj2Krjwv7QdY
         GE+MqCgboIk8ugi278v2H/bs4voGX5VgqOD5zxqX1mDIiUvTWy5J7sMKrGQR9pRqlhCo
         y5EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lR6T4LxC8Ut+pruCXD5qzI/XSt9fav7mXEUWyJO1+HI=;
        b=HnPnb1h/H4ngLFaiXCRO84rrv2mTrMXtbMTUW5PDcvaJyjF8yLHef1FnfFP5hma51A
         VCQgf5UGHs0K4V8BcrNWe0bq4ZFRY7p/EJBY2F7LR9IYsR7FY5Q832hCtc/hipUQjwHL
         rcMrZLRUxhF6lk0TKVVBVIPfDoD2p/BHqdsscz6hSYjKCudrjEvcVtOJaW6zirBjb3S6
         3ZTWd9/VIYOl7VnVEvqEBzHolUfip9hce415bAdvoRsyppm7uPfFiJUbW3OsXQsuS+qr
         hUKwT3eJzI7P8hKQNr899ur257MldVJ+bT6+QCukDhuD833NeX+/49zHcZY5NMiDG/3L
         qL3g==
X-Gm-Message-State: APjAAAVdiedHdi7fLIjVjze0AM5JcQMqcjCxFdv7b6SgdbkTd8xj+0mZ
        +n9+/ZflZpB69ISW7mfaoPb1C/xlEkFS4AYyjtI=
X-Google-Smtp-Source: APXvYqyf+SjaOJl2oE41lR3+Kxg/Y/qBx7hW0S8SGNquAgEEMgXUYMuZHImksmJD4zTcaH4D5IkNnPtaSi00fHPL2dw=
X-Received: by 2002:a17:902:2989:: with SMTP id h9mr33168914plb.26.1553106942063;
 Wed, 20 Mar 2019 11:35:42 -0700 (PDT)
MIME-Version: 1.0
References: <20170324164902.15226.48358.stgit@localhost.localdomain> <20170324170812.15226.97497.stgit@localhost.localdomain>
In-Reply-To: <20170324170812.15226.97497.stgit@localhost.localdomain>
From:   Christoph Paasch <christoph.paasch@gmail.com>
Date:   Wed, 20 Mar 2019 11:35:31 -0700
Message-ID: <CALMXkpb3MfLbNoBgLJc0rgMDbPg9yOevKOiq9N8pzVw-aeNb3g@mail.gmail.com>
Subject: Re: [net-next PATCH v3 4/8] net: Change return type of sk_busy_loop
 from bool to void
To:     Alexander Duyck <alexander.duyck@gmail.com>
Cc:     netdev <netdev@vger.kernel.org>, linux-kernel@vger.kernel.org,
        sridhar.samudrala@intel.com, Eric Dumazet <edumazet@google.com>,
        David Miller <davem@davemloft.net>, linux-api@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Fri, Mar 24, 2017 at 3:23 PM Alexander Duyck
<alexander.duyck@gmail.com> wrote:
>
> From: Alexander Duyck <alexander.h.duyck@intel.com>
>
> >From what I can tell there is only a couple spots where we are actually
> checking the return value of sk_busy_loop. As there are only a few
> consumers of that data, and the data being checked for can be replaced
> with a check for !skb_queue_empty() we might as well just pull the code
> out of sk_busy_loop and place it in the spots that actually need it.
>
> Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
> Acked-by: Eric Dumazet <edumazet@google.com>
> ---
>  include/net/busy_poll.h |    5 ++---
>  net/core/datagram.c     |    8 ++++++--
>  net/core/dev.c          |   25 +++++++++++--------------
>  net/sctp/socket.c       |    9 ++++++---
>  4 files changed, 25 insertions(+), 22 deletions(-)
>
> diff --git a/include/net/busy_poll.h b/include/net/busy_poll.h
> index b82d6ba70a14..c55760f4820f 100644
> --- a/include/net/busy_poll.h
> +++ b/include/net/busy_poll.h
> @@ -74,7 +74,7 @@ static inline bool busy_loop_timeout(unsigned long end_time)
>         return time_after(now, end_time);
>  }
>
> -bool sk_busy_loop(struct sock *sk, int nonblock);
> +void sk_busy_loop(struct sock *sk, int nonblock);
>
>  #else /* CONFIG_NET_RX_BUSY_POLL */
>  static inline unsigned long net_busy_loop_on(void)
> @@ -97,9 +97,8 @@ static inline bool busy_loop_timeout(unsigned long end_time)
>         return true;
>  }
>
> -static inline bool sk_busy_loop(struct sock *sk, int nonblock)
> +static inline void sk_busy_loop(struct sock *sk, int nonblock)
>  {
> -       return false;
>  }
>
>  #endif /* CONFIG_NET_RX_BUSY_POLL */
> diff --git a/net/core/datagram.c b/net/core/datagram.c
> index ea633342ab0d..4608aa245410 100644
> --- a/net/core/datagram.c
> +++ b/net/core/datagram.c
> @@ -256,8 +256,12 @@ struct sk_buff *__skb_try_recv_datagram(struct sock *sk, unsigned int flags,
>                 }
>
>                 spin_unlock_irqrestore(&queue->lock, cpu_flags);
> -       } while (sk_can_busy_loop(sk) &&
> -                sk_busy_loop(sk, flags & MSG_DONTWAIT));
> +
> +               if (!sk_can_busy_loop(sk))
> +                       break;
> +
> +               sk_busy_loop(sk, flags & MSG_DONTWAIT);
> +       } while (!skb_queue_empty(&sk->sk_receive_queue));

since this change I am hitting stalls where it's looping in this
while-loop with syzkaller.

It worked prior to this change because sk->sk_napi_id was not set thus
sk_busy_loop would make us get out of the loop.

Now, it keeps on looping because there is an skb in the queue with
skb->len == 0 and we are peeking with an offset, thus
__skb_try_recv_from_queue will return NULL and thus we have no way of
getting out of the loop.

I'm not sure what would be the best way to fix it. I don't see why we
end up with an skb in the list with skb->len == 0. So, shooting a
quick e-mail, maybe somebody has an idea :-)

I have the syzkaller-reproducer if needed.

Thanks,
Christoph



>
>         error = -EAGAIN;
>
> diff --git a/net/core/dev.c b/net/core/dev.c
> index ab337bf5bbf4..af70eb6ba682 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -5060,21 +5060,19 @@ static void busy_poll_stop(struct napi_struct *napi, void *have_poll_lock)
>                 do_softirq();
>  }
>
> -bool sk_busy_loop(struct sock *sk, int nonblock)
> +void sk_busy_loop(struct sock *sk, int nonblock)
>  {
>         unsigned long end_time = !nonblock ? sk_busy_loop_end_time(sk) : 0;
>         int (*napi_poll)(struct napi_struct *napi, int budget);
>         void *have_poll_lock = NULL;
>         struct napi_struct *napi;
>         unsigned int napi_id;
> -       int rc;
>
>  restart:
>         napi_id = READ_ONCE(sk->sk_napi_id);
>         if (napi_id < MIN_NAPI_ID)
> -               return 0;
> +               return;
>
> -       rc = false;
>         napi_poll = NULL;
>
>         rcu_read_lock();
> @@ -5085,7 +5083,8 @@ bool sk_busy_loop(struct sock *sk, int nonblock)
>
>         preempt_disable();
>         for (;;) {
> -               rc = 0;
> +               int work = 0;
> +
>                 local_bh_disable();
>                 if (!napi_poll) {
>                         unsigned long val = READ_ONCE(napi->state);
> @@ -5103,12 +5102,12 @@ bool sk_busy_loop(struct sock *sk, int nonblock)
>                         have_poll_lock = netpoll_poll_lock(napi);
>                         napi_poll = napi->poll;
>                 }
> -               rc = napi_poll(napi, BUSY_POLL_BUDGET);
> -               trace_napi_poll(napi, rc, BUSY_POLL_BUDGET);
> +               work = napi_poll(napi, BUSY_POLL_BUDGET);
> +               trace_napi_poll(napi, work, BUSY_POLL_BUDGET);
>  count:
> -               if (rc > 0)
> +               if (work > 0)
>                         __NET_ADD_STATS(sock_net(sk),
> -                                       LINUX_MIB_BUSYPOLLRXPACKETS, rc);
> +                                       LINUX_MIB_BUSYPOLLRXPACKETS, work);
>                 local_bh_enable();
>
>                 if (nonblock || !skb_queue_empty(&sk->sk_receive_queue) ||
> @@ -5121,9 +5120,9 @@ bool sk_busy_loop(struct sock *sk, int nonblock)
>                         preempt_enable();
>                         rcu_read_unlock();
>                         cond_resched();
> -                       rc = !skb_queue_empty(&sk->sk_receive_queue);
> -                       if (rc || busy_loop_timeout(end_time))
> -                               return rc;
> +                       if (!skb_queue_empty(&sk->sk_receive_queue) ||
> +                           busy_loop_timeout(end_time))
> +                               return;
>                         goto restart;
>                 }
>                 cpu_relax();
> @@ -5131,10 +5130,8 @@ bool sk_busy_loop(struct sock *sk, int nonblock)
>         if (napi_poll)
>                 busy_poll_stop(napi, have_poll_lock);
>         preempt_enable();
> -       rc = !skb_queue_empty(&sk->sk_receive_queue);
>  out:
>         rcu_read_unlock();
> -       return rc;
>  }
>  EXPORT_SYMBOL(sk_busy_loop);
>
> diff --git a/net/sctp/socket.c b/net/sctp/socket.c
> index 72cc3ecf6516..ccc08fc39722 100644
> --- a/net/sctp/socket.c
> +++ b/net/sctp/socket.c
> @@ -7518,9 +7518,12 @@ struct sk_buff *sctp_skb_recv_datagram(struct sock *sk, int flags,
>                 if (sk->sk_shutdown & RCV_SHUTDOWN)
>                         break;
>
> -               if (sk_can_busy_loop(sk) &&
> -                   sk_busy_loop(sk, noblock))
> -                       continue;
> +               if (sk_can_busy_loop(sk)) {
> +                       sk_busy_loop(sk, noblock);
> +
> +                       if (!skb_queue_empty(&sk->sk_receive_queue))
> +                               continue;
> +               }
>
>                 /* User doesn't want to wait.  */
>                 error = -EAGAIN;
>
