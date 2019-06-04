Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_MED,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 668FFC282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 15:25:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3796C2146F
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 15:25:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RoBwZxUd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728115AbfFDPZH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 11:25:07 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:46586 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727953AbfFDPZG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 11:25:06 -0400
Received: by mail-yw1-f65.google.com with SMTP id x144so9108937ywd.13
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2019 08:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8Dtq6s34f/EEPTJjI8bt32p5N5sr2kVgZ6rratqLn1s=;
        b=RoBwZxUd9jm4Ew2r42DQ/Al0LsebSoX83OCQQ/OVY9TYgpzOcEGzILyWZgmJAtXYQv
         kwYt6d761Pk8odVagi3IEW4dfAZBh4mw0we0C+RxsY7EPFL9lVYGsrTEBMHmfYYvbT54
         8BzREr+tvPgEM2xomwiL0FwNjbIcakk8S4P6vvYmCbKdHXt00hsBWxVJ50P444H63AyM
         s06GQOjk6Nt9bT+2uriEEET3V/A/n6MCbsrYqhrkcQoN8LL1wCa3cU2RKKcc8rXbyZcY
         PYOmUeEIJjbOlyye4ng3JuNX2zEypA1OInSQ7oyLRJ6Mbxrt5OXAOLwIdrQAPBEnfxCV
         /hgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8Dtq6s34f/EEPTJjI8bt32p5N5sr2kVgZ6rratqLn1s=;
        b=MEENB8S0AIkD3woFTAWmtAyDFBiYiGy+Kdjpw8uEP/wkxdHGEuZoISc8Akt6wr+0sw
         s+pSUZd2Dd2YuDVwqeiZG9xNEtFuy/09y84jU83PRgrVwBbvacPxhUY8epQVoZFJgd0/
         qEQLD+R/rj+9xIhXnAehQ6u/I6r5jimEYSrgddHDZJHpIXxerDXiqTIkFW34IVIZ3nJ8
         Ys2cyTohKJFCMwdXgrqCyKHIj+ZWcnqCtK6W3tLwYgpLXldEkL57K9wJhfEPuaZvfWCU
         pGwg13mVPXt3Al60looj4/ZWPa0C7ZssiPx6w9LEXeSdzksp0e912yugKGdceFlSYa6G
         jHxw==
X-Gm-Message-State: APjAAAWrOgEkcZjvzgdYZtMA5O+F+uj4sOvT2ZVj2Etgwk7yTu062f1N
        LZqsl+7WXIPwGsdDXspWwU3XElLjQoo8MCOt6ATVFA==
X-Google-Smtp-Source: APXvYqyIoMgFiWcnbNSKFs5E6LfHTEVX3WywEFYE4bBfgycPk68vT1M5l9FzgYVO05MbJHn7uSuOATsPxc4O1c6OyGA=
X-Received: by 2002:a81:83d7:: with SMTP id t206mr16485392ywf.146.1559661905376;
 Tue, 04 Jun 2019 08:25:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190604145543.61624-1-maowenan@huawei.com>
In-Reply-To: <20190604145543.61624-1-maowenan@huawei.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Tue, 4 Jun 2019 08:24:54 -0700
Message-ID: <CANn89iK+4QC7bbku5MUczzKnWgL6HG9JAT6+03Q2paxBKhC4Xw@mail.gmail.com>
Subject: Re: [PATCH net] tcp: avoid creating multiple req socks with the same tuples
To:     Mao Wenan <maowenan@huawei.com>
Cc:     David Miller <davem@davemloft.net>,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 4, 2019 at 7:47 AM Mao Wenan <maowenan@huawei.com> wrote:
>
> There is one issue about bonding mode BOND_MODE_BROADCAST, and
> two slaves with diffierent affinity, so packets will be handled
> by different cpu. These are two pre-conditions in this case.
>
> When two slaves receive the same syn packets at the same time,
> two request sock(reqsk) will be created if below situation happens:
> 1. syn1 arrived tcp_conn_request, create reqsk1 and have not yet called
> inet_csk_reqsk_queue_hash_add.
> 2. syn2 arrived tcp_v4_rcv, it goes to tcp_conn_request and create reqsk2
> because it can't find reqsk1 in the __inet_lookup_skb.
>
> Then reqsk1 and reqsk2 are added to establish hash table, and two synack with different
> seq(seq1 and seq2) are sent to client, then tcp ack arrived and will be
> processed in tcp_v4_rcv and tcp_check_req, if __inet_lookup_skb find the reqsk2, and
> tcp ack packet is ack_seq is seq1, it will be failed after checking:
> TCP_SKB_CB(skb)->ack_seq != tcp_rsk(req)->snt_isn + 1)
> and then tcp rst will be sent to client and close the connection.
>
> To fix this, do lookup before calling inet_csk_reqsk_queue_hash_add
> to add reqsk2 to hash table, if it finds the existed reqsk1 with the same five tuples,
> it removes reqsk2 and does not send synack to client.
>
> Signed-off-by: Mao Wenan <maowenan@huawei.com>
> ---
>  net/ipv4/tcp_input.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> index 08a477e74cf3..c75eeb1fe098 100644
> --- a/net/ipv4/tcp_input.c
> +++ b/net/ipv4/tcp_input.c
> @@ -6569,6 +6569,15 @@ int tcp_conn_request(struct request_sock_ops *rsk_ops,
>                 bh_unlock_sock(fastopen_sk);
>                 sock_put(fastopen_sk);
>         } else {
> +               struct sock *sk1 = req_to_sk(req);
> +               struct sock *sk2 = NULL;
> +               sk2 = __inet_lookup_established(sock_net(sk1), &tcp_hashinfo,
> +                                                                       sk1->sk_daddr, sk1->sk_dport,
> +                                                                       sk1->sk_rcv_saddr, sk1->sk_num,
> +                                                                       inet_iif(skb),inet_sdif(skb));
> +               if (sk2 != NULL)
> +                       goto drop_and_release;
> +
>                 tcp_rsk(req)->tfo_listener = false;
>                 if (!want_cookie)
>                         inet_csk_reqsk_queue_hash_add(sk, req,

This issue has been discussed last year.

I am afraid your patch does not solve all races.

The lookup you add is lockless, so this is racy.

Really the only way to solve this is to make sure that _when_ the
bucket lock is held,
we do not insert a request socket if the 4-tuple is already in the
chain (probably in inet_ehash_insert())

This needs more tricky changes than your patch.
