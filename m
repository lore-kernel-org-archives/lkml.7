Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21B5CC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 09:03:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECBC3218AC
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 09:03:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728572AbfCOJDG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 05:03:06 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:36989 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727282AbfCOJDG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 05:03:06 -0400
Received: from bootlin.com (aaubervilliers-681-1-80-102.w90-88.abo.wanadoo.fr [90.88.22.102])
        (Authenticated sender: maxime.chevallier@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 3046420001C;
        Fri, 15 Mar 2019 09:03:02 +0000 (UTC)
Date:   Fri, 15 Mar 2019 10:03:01 +0100
From:   Maxime Chevallier <maxime.chevallier@bootlin.com>
To:     Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Willem de Bruijn <willemb@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [RFC PATCH net] packets: Always register packet sk in the same
 order
Message-ID: <20190315100301.249cb671@bootlin.com>
In-Reply-To: <CAF=yD-+e3f1VED3+6J7rQYac9A3w=CDQhrLq+eRLA88+vLOzDA@mail.gmail.com>
References: <20190314122450.5242-1-maxime.chevallier@bootlin.com>
        <CAF=yD-+e3f1VED3+6J7rQYac9A3w=CDQhrLq+eRLA88+vLOzDA@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Willem,

On Thu, 14 Mar 2019 11:24:54 -0400
Willem de Bruijn <willemdebruijn.kernel@gmail.com> wrote:

>On Thu, Mar 14, 2019 at 8:27 AM Maxime Chevallier
><maxime.chevallier@bootlin.com> wrote:
>>
>> When using fanouts with AF_PACKET, the demux functions such as
>> fanout_demux_cpu will return an index in the fanout socket array, which
>> corresponds to the selected socket.
>>
>> The ordering of this array depends on the order the sockets were added
>> to a given fanout group, so for FANOUT_CPU this means sockets are bound
>> to cpus in the order they are configured, which is OK.
>>
>> However, when stopping then restarting the interface these sockets are
>> bound to, the sockets are reassigned to the fanout group in the reverse
>> order, due to the fact that they were inserted at the head of the
>> interface's AF_PACKET socket list.
>>
>> This means that traffic that was directed to the first socket in the
>> fanout group is now directed to the last one after an interface restart.
>>
>> In the case of FANOUT_CPU, traffic from CPU0 will be directed to the
>> socket that used to receive traffic from the last CPU after an interface
>> restart.  
>
>The above assumes that sockets are added to a fanout group in the
>order in which they are created. That is a reasonable assumption,
>though not strictly required. This can be worked around in userspace
>by inserting in the inverse order. Still, good to fix.
>
>It does change the order of output of proc and diag, which is an
>unfortunately side effect. But insertion order is less surprising and
>I don't see a simple option to only traverse the sklist in inverse
>order on packet_notifier NETDEV_UP (which would avoid this).

Thanks for the review ! Clearly the solution proposed by this patch has
side-effects, and as you said I don't see an easy way to do that in
another manner.

>> This commit introduces a helper to add a socket at the tail of a list,
>> then uses it to register AF_PACKET sockets.
>>
>> Fixes: 808f5114a920 ("packet: convert socket list to RCU (v3)")  
>
>Before this patch, insertion with sk_add_node is also at the head.
>This does not seem like the right commit? This behavior has probably
>existed as long as fanout.

Yes I agree, I'm not even sure if this patch should be targeted to -net
or -net-next. If this is OK after reviews, I can resend it without RFC
and without this misleading Fixes tag.

Thanks,

Maxime

>
>> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
>> ---
>>
>> Hi All,
>>
>> I stumbled upon this issue when using FANOUT_CPU and came-up with this
>> patch, but I'm not sure that (a) this is really a bug (although this
>> behaviour is at least misleading) and (b) this is the correct fix,
>> so any input on this is welcome.
>>
>> Also David, I'm not sure about the Fixes tag, from what I see, this
>> behaviour has always been there.
>>
>> Thanks,
>>
>> Maxime
>>
>>  include/net/sock.h     | 6 ++++++
>>  net/packet/af_packet.c | 2 +-
>>  2 files changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/net/sock.h b/include/net/sock.h
>> index 328cb7cb7b0b..8de5ee258b93 100644
>> --- a/include/net/sock.h
>> +++ b/include/net/sock.h
>> @@ -710,6 +710,12 @@ static inline void sk_add_node_rcu(struct sock *sk, struct hlist_head *list)
>>                 hlist_add_head_rcu(&sk->sk_node, list);
>>  }
>>
>> +static inline void sk_add_node_tail_rcu(struct sock *sk, struct hlist_head *list)
>> +{
>> +       sock_hold(sk);
>> +       hlist_add_tail_rcu(&sk->sk_node, list);
>> +}
>> +
>>  static inline void __sk_nulls_add_node_rcu(struct sock *sk, struct hlist_nulls_head *list)
>>  {
>>         hlist_nulls_add_head_rcu(&sk->sk_nulls_node, list);
>> diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
>> index 8376bc1c1508..8754d7c93b84 100644
>> --- a/net/packet/af_packet.c
>> +++ b/net/packet/af_packet.c
>> @@ -3243,7 +3243,7 @@ static int packet_create(struct net *net, struct socket *sock, int protocol,
>>         }
>>
>>         mutex_lock(&net->packet.sklist_lock);
>> -       sk_add_node_rcu(sk, &net->packet.sklist);
>> +       sk_add_node_tail_rcu(sk, &net->packet.sklist);
>>         mutex_unlock(&net->packet.sklist_lock);
>>
>>         preempt_disable();
>> --
>> 2.20.1
>>  



-- 
Maxime Chevallier, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com
