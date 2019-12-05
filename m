Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9589C43603
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 20:07:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0AFE206D9
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 20:07:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PmZHoUoc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729547AbfLEUHg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 15:07:36 -0500
Received: from mail-yb1-f194.google.com ([209.85.219.194]:36667 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729145AbfLEUHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 15:07:36 -0500
Received: by mail-yb1-f194.google.com with SMTP id v2so2010718ybo.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2019 12:07:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m1aI+cWn+pN+koI1rkc/tO0Oxhn3zWCujvYJiTDdw/U=;
        b=PmZHoUoc56jE+kMHXtSTDMLYKfmvaZbnf0wOkHA1zKpJEJIt1hDzJVNdQxS0YvopSB
         hpCZOER0sF/J1ONzolUPdg5WUkrvaWQHevLV2e0q8QlDtcGJgvCaFWfz2m8j5Oo7Xk8A
         3UTP5Db8KsGSJbOOzUE8cDeLmyk7i1LSbDxqoP7Ut2+Q1wiggZCISGCy2UtLAd2tsnFf
         /KUuPENslh6DuxthrE+T2nDhZsK78ZuqiZgAKTb1tNDziUYiixjhp+RIvOTJ20ggSD1i
         D9DRyb2XP0pGvT9A9UW9UwjJkRqukJcZvpjDJoVK5XJg6e0jFWqlwf19GWOYQ7q+vUSh
         M+eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m1aI+cWn+pN+koI1rkc/tO0Oxhn3zWCujvYJiTDdw/U=;
        b=TxwMsd8CJDeDHSicJ2N/JZijntLxInJVoHuQQ3J9t9ykBxuDab7LYM5W0YSHiqccyg
         SlKfYvzBSnZouaGKyxKmXFIV+YxxuQVjUULoxUtuP4vWVGUdrxI+lxi8FKQLZn9fGq8N
         ngvhe1jV7QqLZeM22jAhPrQdUklZ5SkFOyTlCAN8Xq1skpmGlsra48q+6riHjYOQGkuv
         dYWj0+v1AFucwtvHRN+bxJPgfBueGab9CxToW6OHYajuFW4zmnVFEr5/Cjo34THMd7Dm
         CipXyvRa7rQ2RZzIrKWeUOXrfDKGQ2IlQzN94cep8gQ4DokdyTCVyA/9xjd/qUGjmVd/
         ye1A==
X-Gm-Message-State: APjAAAW3atTdSBZaeUGSamAsh5QbRd21duhrpuN4cc2JUvUlBc9EpJVl
        lpRRdi9aesSYwqNBvOzg83fRMNeW
X-Google-Smtp-Source: APXvYqxF/5rAsXb9wjG3/SOF6Z6iMI1YpEm47BTRDFFTiCybzAX7kclMft56wIaH91yA8Htah5aS2Q==
X-Received: by 2002:a25:c791:: with SMTP id w139mr6594941ybe.300.1575576454577;
        Thu, 05 Dec 2019 12:07:34 -0800 (PST)
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com. [209.85.219.173])
        by smtp.gmail.com with ESMTPSA id v19sm5130094ywh.60.2019.12.05.12.07.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Dec 2019 12:07:33 -0800 (PST)
Received: by mail-yb1-f173.google.com with SMTP id h23so2016956ybg.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2019 12:07:32 -0800 (PST)
X-Received: by 2002:a25:bc0a:: with SMTP id i10mr7880662ybh.83.1575576452064;
 Thu, 05 Dec 2019 12:07:32 -0800 (PST)
MIME-Version: 1.0
References: <20191204.165528.1483577978366613524.davem@davemloft.net>
 <20191205064118.8299-1-vvidic@valentin-vidic.from.hr> <20191205113411.5e672807@cakuba.netronome.com>
In-Reply-To: <20191205113411.5e672807@cakuba.netronome.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Thu, 5 Dec 2019 15:06:55 -0500
X-Gmail-Original-Message-ID: <CA+FuTSe=GSP41GG+QYKEmQ0eDUEoFeQ+oGAsgGJEZTe=hJq4Tw@mail.gmail.com>
Message-ID: <CA+FuTSe=GSP41GG+QYKEmQ0eDUEoFeQ+oGAsgGJEZTe=hJq4Tw@mail.gmail.com>
Subject: Re: [PATCH v3] net/tls: Fix return values to avoid ENOTSUPP
To:     Jakub Kicinski <jakub.kicinski@netronome.com>
Cc:     Valentin Vidic <vvidic@valentin-vidic.from.hr>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Boris Pismenny <borisp@mellanox.com>,
        Aviad Yehezkel <aviadye@mellanox.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S. Miller" <davem@davemloft.net>,
        Network Development <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 5, 2019 at 2:34 PM Jakub Kicinski
<jakub.kicinski@netronome.com> wrote:
>
> On Thu,  5 Dec 2019 07:41:18 +0100, Valentin Vidic wrote:
> > ENOTSUPP is not available in userspace, for example:
> >
> >   setsockopt failed, 524, Unknown error 524
> >
> > Signed-off-by: Valentin Vidic <vvidic@valentin-vidic.from.hr>
>
> > diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c
> > index 0683788bbef0..cd91ad812291 100644
> > --- a/net/tls/tls_device.c
> > +++ b/net/tls/tls_device.c
> > @@ -429,7 +429,7 @@ static int tls_push_data(struct sock *sk,
> >
> >       if (flags &
> >           ~(MSG_MORE | MSG_DONTWAIT | MSG_NOSIGNAL | MSG_SENDPAGE_NOTLAST))
> > -             return -ENOTSUPP;
> > +             return -EOPNOTSUPP;
> >
> >       if (unlikely(sk->sk_err))
> >               return -sk->sk_err;
> > @@ -571,7 +571,7 @@ int tls_device_sendpage(struct sock *sk, struct page *page,
> >       lock_sock(sk);
> >
> >       if (flags & MSG_OOB) {
> > -             rc = -ENOTSUPP;
> > +             rc = -EOPNOTSUPP;
>
> Perhaps the flag checks should return EINVAL? Willem any opinions?

No strong opinion. Judging from do_tcp_sendpages MSG_OOB is a
supported flag in general for sendpage, so signaling that the TLS
variant cannot support that otherwise valid request sounds fine to me.

>
> >               goto out;
> >       }
> >
> > @@ -1023,7 +1023,7 @@ int tls_set_device_offload(struct sock *sk, struct tls_context *ctx)
> >       }
> >
> >       if (!(netdev->features & NETIF_F_HW_TLS_TX)) {
> > -             rc = -ENOTSUPP;
> > +             rc = -EOPNOTSUPP;
> >               goto release_netdev;
> >       }
> >
> > @@ -1098,7 +1098,7 @@ int tls_set_device_offload_rx(struct sock *sk, struct tls_context *ctx)
> >       }
> >
> >       if (!(netdev->features & NETIF_F_HW_TLS_RX)) {
> > -             rc = -ENOTSUPP;
> > +             rc = -EOPNOTSUPP;
> >               goto release_netdev;
> >       }
> >
> > diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
> > index bdca31ffe6da..5830b8e02a36 100644
> > --- a/net/tls/tls_main.c
> > +++ b/net/tls/tls_main.c
> > @@ -496,7 +496,7 @@ static int do_tls_setsockopt_conf(struct sock *sk, char __user *optval,
> >       /* check version */
> >       if (crypto_info->version != TLS_1_2_VERSION &&
> >           crypto_info->version != TLS_1_3_VERSION) {
> > -             rc = -ENOTSUPP;
> > +             rc = -EINVAL;
>
> This one I think Willem asked to be EOPNOTSUPP OTOH.

Indeed (assuming no one disagrees). Based on the same rationale: the
request may be valid, it just cannot be accommodated (yet).
