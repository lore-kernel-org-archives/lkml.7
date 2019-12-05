Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_ADSP_ALL,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99189C43603
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 20:44:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D448020659
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 20:44:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=valentin-vidic.from.hr header.i=@valentin-vidic.from.hr header.b="KgvTGrNy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729812AbfLEUoB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 15:44:01 -0500
Received: from valentin-vidic.from.hr ([94.229.67.141]:36647 "EHLO
        valentin-vidic.from.hr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726589AbfLEUoA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 15:44:00 -0500
X-Virus-Scanned: Debian amavisd-new at valentin-vidic.from.hr
Received: by valentin-vidic.from.hr (Postfix, from userid 1000)
        id 83FEC2F9; Thu,  5 Dec 2019 21:43:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
        d=valentin-vidic.from.hr; s=2017; t=1575578623;
        bh=DqUf2vyv6BAo12cNj1yPPzKcz18c85WTgVrTNJ9a45U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KgvTGrNyA11asBxob0rBk3N92nCIImPx+JcZv1HTtfv3ZbPGXsvbnw/8U8J8kfaTt
         DFJFpYwKY9SERjtXCHa47AZHKgAGBlWal/wkJBVz9KjLzfxRzFDw/bXf6aBm7Qggel
         FCJZeDhTSovgTluB3cvniv1ZsjYlhzZmwUqvoW+LH2DPEAG1UGfoOj0sRUcGb0PwU8
         YPawI/WraUWa5hOhKcy6ds/AbE1tN28AX0YxnF9H0PyJCO7EPZgo3P/VFc3SF1Avp/
         ky76J98WpIoCzQAaphW6IAGETuJjSHlYVXVwmbNhRKFaeGQgJLaleVv2rX5yn6JSRP
         mJ7mP6AjyP/yw==
Date:   Thu, 5 Dec 2019 21:43:43 +0100
From:   Valentin =?utf-8?B?VmlkacSH?= <vvidic@valentin-vidic.from.hr>
To:     Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc:     Jakub Kicinski <jakub.kicinski@netronome.com>,
        Boris Pismenny <borisp@mellanox.com>,
        Aviad Yehezkel <aviadye@mellanox.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S. Miller" <davem@davemloft.net>,
        Network Development <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] net/tls: Fix return values to avoid ENOTSUPP
Message-ID: <20191205204343.GA20116@valentin-vidic.from.hr>
References: <20191204.165528.1483577978366613524.davem@davemloft.net>
 <20191205064118.8299-1-vvidic@valentin-vidic.from.hr>
 <20191205113411.5e672807@cakuba.netronome.com>
 <CA+FuTSe=GSP41GG+QYKEmQ0eDUEoFeQ+oGAsgGJEZTe=hJq4Tw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+FuTSe=GSP41GG+QYKEmQ0eDUEoFeQ+oGAsgGJEZTe=hJq4Tw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 05, 2019 at 03:06:55PM -0500, Willem de Bruijn wrote:
> On Thu, Dec 5, 2019 at 2:34 PM Jakub Kicinski
> <jakub.kicinski@netronome.com> wrote:
> >
> > On Thu,  5 Dec 2019 07:41:18 +0100, Valentin Vidic wrote:
> > > ENOTSUPP is not available in userspace, for example:
> > >
> > >   setsockopt failed, 524, Unknown error 524
> > >
> > > Signed-off-by: Valentin Vidic <vvidic@valentin-vidic.from.hr>
> >
> > > diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c
> > > index 0683788bbef0..cd91ad812291 100644
> > > --- a/net/tls/tls_device.c
> > > +++ b/net/tls/tls_device.c
> > > @@ -429,7 +429,7 @@ static int tls_push_data(struct sock *sk,
> > >
> > >       if (flags &
> > >           ~(MSG_MORE | MSG_DONTWAIT | MSG_NOSIGNAL | MSG_SENDPAGE_NOTLAST))
> > > -             return -ENOTSUPP;
> > > +             return -EOPNOTSUPP;
> > >
> > >       if (unlikely(sk->sk_err))
> > >               return -sk->sk_err;
> > > @@ -571,7 +571,7 @@ int tls_device_sendpage(struct sock *sk, struct page *page,
> > >       lock_sock(sk);
> > >
> > >       if (flags & MSG_OOB) {
> > > -             rc = -ENOTSUPP;
> > > +             rc = -EOPNOTSUPP;
> >
> > Perhaps the flag checks should return EINVAL? Willem any opinions?
> 
> No strong opinion. Judging from do_tcp_sendpages MSG_OOB is a
> supported flag in general for sendpage, so signaling that the TLS
> variant cannot support that otherwise valid request sounds fine to me.

I based these on the description from the sendmsg manpage, but you decide:

EOPNOTSUPP
    Some bit in the flags argument is inappropriate for the socket type.

> > > diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
> > > index bdca31ffe6da..5830b8e02a36 100644
> > > --- a/net/tls/tls_main.c
> > > +++ b/net/tls/tls_main.c
> > > @@ -496,7 +496,7 @@ static int do_tls_setsockopt_conf(struct sock *sk, char __user *optval,
> > >       /* check version */
> > >       if (crypto_info->version != TLS_1_2_VERSION &&
> > >           crypto_info->version != TLS_1_3_VERSION) {
> > > -             rc = -ENOTSUPP;
> > > +             rc = -EINVAL;
> >
> > This one I think Willem asked to be EOPNOTSUPP OTOH.
> 
> Indeed (assuming no one disagrees). Based on the same rationale: the
> request may be valid, it just cannot be accommodated (yet).

In this case other checks in the same function like crypto_info->cipher_type
return EINVAL, so I used the same here.

-- 
Valentin
