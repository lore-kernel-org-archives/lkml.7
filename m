Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E483BC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 19:40:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3E4821873
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 19:40:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727267AbfCTTkN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 15:40:13 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:39382 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726067AbfCTTkN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 15:40:13 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 3D45E148B5CDD;
        Wed, 20 Mar 2019 12:40:12 -0700 (PDT)
Date:   Wed, 20 Mar 2019 12:40:11 -0700 (PDT)
Message-Id: <20190320.124011.1280345923671369921.davem@davemloft.net>
To:     christoph.paasch@gmail.com
Cc:     alexander.duyck@gmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, sridhar.samudrala@intel.com,
        edumazet@google.com, linux-api@vger.kernel.org
Subject: Re: [net-next PATCH v3 4/8] net: Change return type of
 sk_busy_loop from bool to void
From:   David Miller <davem@davemloft.net>
In-Reply-To: <CALMXkpb3MfLbNoBgLJc0rgMDbPg9yOevKOiq9N8pzVw-aeNb3g@mail.gmail.com>
References: <20170324164902.15226.48358.stgit@localhost.localdomain>
        <20170324170812.15226.97497.stgit@localhost.localdomain>
        <CALMXkpb3MfLbNoBgLJc0rgMDbPg9yOevKOiq9N8pzVw-aeNb3g@mail.gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 20 Mar 2019 12:40:12 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christoph Paasch <christoph.paasch@gmail.com>
Date: Wed, 20 Mar 2019 11:35:31 -0700

> On Fri, Mar 24, 2017 at 3:23 PM Alexander Duyck
> <alexander.duyck@gmail.com> wrote:
>> diff --git a/net/core/datagram.c b/net/core/datagram.c
>> index ea633342ab0d..4608aa245410 100644
>> --- a/net/core/datagram.c
>> +++ b/net/core/datagram.c
>> @@ -256,8 +256,12 @@ struct sk_buff *__skb_try_recv_datagram(struct sock *sk, unsigned int flags,
>>                 }
>>
>>                 spin_unlock_irqrestore(&queue->lock, cpu_flags);
>> -       } while (sk_can_busy_loop(sk) &&
>> -                sk_busy_loop(sk, flags & MSG_DONTWAIT));
>> +
>> +               if (!sk_can_busy_loop(sk))
>> +                       break;
>> +
>> +               sk_busy_loop(sk, flags & MSG_DONTWAIT);
>> +       } while (!skb_queue_empty(&sk->sk_receive_queue));
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

Just for the record, __skb_try_recv_datagram() and it's friend
__skb_try_recv_from_queue() are my least favorite functions in the
entire tree for the past year or so.

Their current design, and how they assume things about the
implementation of SKB queues, together result in all the weird
problems we keep fixing in them.

There has to be a much better way to do this.

