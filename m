Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91AF8C4646B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 06:38:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6156A208CB
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 06:38:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UHOfHR/y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbfFZGiP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 02:38:15 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:38986 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbfFZGiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 02:38:14 -0400
Received: by mail-yb1-f193.google.com with SMTP id k4so752715ybo.6
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 23:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z4FZnEaViYUU/TWmZUmNfIjzU53EGW1PnwT6ZSxC/SA=;
        b=UHOfHR/yyYIeMiULopgaiCu/bXxHSR2ChCuN98T0SpjOqVQPSkulXcRjWJKQaNFGHA
         g9iKxPFpYy9czx9tqXirKOwZNgmqaCNYdP0fb0J3SraKhnlslaVtjMru8bcp+FP1XUh+
         z2vZzejtafGJH8CAzl0+WM5+KNovJpX59nKKwmdXb7cP33VEJGrMWuHNh7sunRBjva8/
         JVia+3TheMRcalXsDIdCCZqm9jF9STPbhJek6V3pBUp1zh1fJWD7j67UVb0ieDhuGmCY
         v1bWvNb9Kt2G81eab+K4i4Nuw0RmCeqJiw2b6G6j/mG6rjNQyuqzyj80SGSW7nAsqN9y
         TpzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z4FZnEaViYUU/TWmZUmNfIjzU53EGW1PnwT6ZSxC/SA=;
        b=r+f0sXflo4DiXVBiqmraU2KAcDQIA1IGlV6XaYHe5y/L8NLp9rpHzSr3QabKanLYAW
         gGrxEmWj/5tojvGWaclhr/LQy+G1Ecik2XMGvNziNfNZNmiFKuGfGZK+vT1iLINllDK8
         IBUWk8v2abyvt+bcVfy9snYWTuUmuQ2thDCOVW24xh5hxLfPuq6ZL4EoU+/I0Phn2YWo
         7pDNNS76OjQpXM3RMgY3mAvSk2jlbgTy65glipqHaMAXdk0Gi5TzcB43dhmVb+HHZGIF
         ZqLqGyeRTMn3RuNzHfc4yvPLML1z3YdQ/L4v0YJn6LoCIqiokMVuNjkF+CrNmsM3EGEG
         PykQ==
X-Gm-Message-State: APjAAAUaTBOLUAFmaFSaBtw/yhXAZGOrXmMN00XR7Qg3Ru0P6DhLsHdJ
        gX6Xin/q86qbgp316n98KaG66qye81aOmbfwQH27mhnw8ITdr99m
X-Google-Smtp-Source: APXvYqz4zmwA01AmVihAstNVCh1LpjJSIDPFE1TU78RlCPvYW6yvpbgOJwAWfqHUCxWsRE74XeIiCOUNCFhMPihdiEI=
X-Received: by 2002:a25:7057:: with SMTP id l84mr1589239ybc.518.1561531093008;
 Tue, 25 Jun 2019 23:38:13 -0700 (PDT)
MIME-Version: 1.0
References: <CANn89iL5+x3n9H9v4O6y39W=jvQs=uuXbzOvN5mBbcj0t+wdeg@mail.gmail.com>
 <CAHk-=wjZ=8VSjWuqeG6JJv4dQfK6M0Jgckq5-6=SJa25aku-vQ@mail.gmail.com>
 <CANn89iLU+NNy7QDPNLYPxNWMx5cXuhziOT7TX2uYt42uUJcNVg@mail.gmail.com>
 <b72599d1-b5d5-1c23-15fc-8e2f9454af05@valvesoftware.com> <CAHk-=wjZ1grLwJsGD+Fjz1_U_W47AFodBiwBX84HECUHt-guuw@mail.gmail.com>
 <20190622073753.GA10516@kroah.com> <20190626020220.GA22548@roeck-us.net>
 <20190626022923.GA14595@kroah.com> <53b23451-f45b-932d-a2f8-15f74f07a849@roeck-us.net>
 <CANn89iL69qDuHDPPk7gksoQvCyVEmBRRs-Kc_EVDkpxZe7DwMw@mail.gmail.com> <20190626051720.GA575@kroah.com>
In-Reply-To: <20190626051720.GA575@kroah.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Wed, 26 Jun 2019 08:38:01 +0200
Message-ID: <CANn89iJPcD9cOrFUHR_sSVyjxzqYGwB2mG-Crf5vhxc7L+LgsA@mail.gmail.com>
Subject: Re: Steam is broken on new kernels
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Pierre-Loup A. Griffais" <pgriffais@valvesoftware.com>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 26, 2019 at 8:22 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Wed, Jun 26, 2019 at 06:20:17AM +0200, Eric Dumazet wrote:
> > On Wed, Jun 26, 2019 at 5:43 AM Guenter Roeck <linux@roeck-us.net> wrote:
> > >
> > > On 6/25/19 7:29 PM, Greg Kroah-Hartman wrote:
> > > > On Tue, Jun 25, 2019 at 07:02:20PM -0700, Guenter Roeck wrote:
> > > >> Hi Greg,
> > > >>
> > > >> On Sat, Jun 22, 2019 at 09:37:53AM +0200, Greg Kroah-Hartman wrote:
> > > >>> On Fri, Jun 21, 2019 at 10:28:21PM -0700, Linus Torvalds wrote:
> > > >>>> On Fri, Jun 21, 2019 at 6:03 PM Pierre-Loup A. Griffais
> > > >>>> <pgriffais@valvesoftware.com> wrote:
> > > >>>>>
> > > >>>>> I applied Eric's path to the tip of the branch and ran that kernel and
> > > >>>>> the bug didn't occur through several logout / login cycles, so things
> > > >>>>> look good at first glance. I'll keep running that kernel and report back
> > > >>>>> if anything crops up in the future, but I believe we're good, beyond
> > > >>>>> getting distros to ship this additional fix.
> > > >>>>
> > > >>>> Good. It's now in my tree, so we can get it quickly into stable and
> > > >>>> then quickly to distributions.
> > > >>>>
> > > >>>> Greg, it's commit b6653b3629e5 ("tcp: refine memory limit test in
> > > >>>> tcp_fragment()"), and I'm building it right now and I'll push it out
> > > >>>> in a couple of minutes assuming nothing odd is going on.
> > > >>>
> > > >>> This looks good for 4.19 and 5.1, so I'll push out new stable kernels in
> > > >>> a bit for them.
> > > >>>
> > > >>> But for 4.14 and older, we don't have the "hint" to know this is an
> > > >>> outbound going packet and not to apply these checks at that point in
> > > >>> time, so this patch doesn't work.
> > > >>>
> > > >>> I'll see if I can figure anything else later this afternoon for those
> > > >>> kernels...
> > > >>>
> > > >>
> > > >> I may have missed it, but I don't see a fix for the problem in
> > > >> older stable branches. Any news ?
> > > >>
> > > >> One possibility might be be to apply the part of 75c119afe14f7 which
> > > >> introduces TCP_FRAG_IN_WRITE_QUEUE and TCP_FRAG_IN_RTX_QUEUE, if that
> > > >> is acceptable.
> > > >
> > > > That's what people have already discussed on the stable mailing list a
> > > > few hours ago, hopefully a patch shows up soon as I'm traveling at the
> > > > moment and can't do it myself...
> > > >
> > >
> > > Sounds good. Let me know if nothing shows up; I'll be happy to do it
> > > if needed.
> >
> >
> > Without the rb-tree for rtx queues, old kernels are vulnerable to SACK
> > attacks if sk_sndbuf is too big,
> > so I would simply  add a cushion in the test, instead of trying to
> > backport an illusion of the rb-tree fixes.
> >
> >
> >
> > diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> > index a8772e11dc1cb42d4319b6fc072c625d284c7ad5..a554213afa4ac41120d781fe64b7cd18ff9b56e8
> > 100644
> > --- a/net/ipv4/tcp_output.c
> > +++ b/net/ipv4/tcp_output.c
> > @@ -1274,7 +1274,7 @@ int tcp_fragment(struct sock *sk, struct sk_buff
> > *skb, u32 len,
> >         if (nsize < 0)
> >                 nsize = 0;
> >
> > -       if (unlikely((sk->sk_wmem_queued >> 1) > sk->sk_sndbuf)) {
> > +       if (unlikely((sk->sk_wmem_queued >> 1) > sk->sk_sndbuf + 131072)) {
> >                 NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPWQUEUETOOBIG);
> >                 return -ENOMEM;
> >         }
>
> That's a funny magic number, can we document what it means?

This is because TCP can cook skb with about 64KB of payload in
tcp_sendmsg() before
checking if memory limits are exceeded. (This is mentioned in commit
b6653b3629e5b88202be3c9abc44713973f5c4b4
" tcp: refine memory limit test in tcp_fragment()" changelog)

Then, if this giant TSO skb needs to be split in ~45 smaller skbs of
one segment each,
the resulting truesize might be twice bigger.

You could use 2 * 65536 if that looks better, and possibly a macro,
 but I feel that adding a macro for this one particular spot and
stable kernels might be overkill ?

>
> And yes, it's a much simpler patch, I'd rather take this than the fake
> backport.
