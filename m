Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 941B3C4646B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 08:24:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65FB6208E3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 08:24:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561537455;
	bh=bMRTiDPGMP8fxo+3ckAdavBqCq0bsYHPyLNJZLN2WzQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ncjWvRPWWA7ttIcJT09Pibg3pHSU4HzXD2kwYoTAcmiw4y/K90ftAm8ynoAlkH3mS
	 WZrbtSKH+ZbCOfBv9XqjRyKqiEfcbGxAArxvaaLViipQ+4T5SgP/aJGbTEZGgLK2/Z
	 sfuXWYZAQFTcbqOq8GWzG23scIlR+359iQkaqjuU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726932AbfFZIYO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 04:24:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:56854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725379AbfFZIYO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 04:24:14 -0400
Received: from localhost (unknown [116.247.127.123])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2520120B7C;
        Wed, 26 Jun 2019 08:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561537452;
        bh=bMRTiDPGMP8fxo+3ckAdavBqCq0bsYHPyLNJZLN2WzQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gL4Q2EbNYmmurqssvE7tqFn8IOmKUjd4O/Q83vVHRSMBhyncHWG9ky60BEx4kqvN4
         lXKhOORnoESfU93qBETnxhge7qLvx5bdTmp2ozLqbwFf8DIRFTpW+f+5BqHPel7n2o
         3KRQ5ZqVt38e1eTjyA4qVFDcyo1VincEHKh7TVes=
Date:   Wed, 26 Jun 2019 16:23:43 +0800
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Eric Dumazet <edumazet@google.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Pierre-Loup A. Griffais" <pgriffais@valvesoftware.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Steam is broken on new kernels
Message-ID: <20190626082343.GB4605@kroah.com>
References: <CANn89iLU+NNy7QDPNLYPxNWMx5cXuhziOT7TX2uYt42uUJcNVg@mail.gmail.com>
 <b72599d1-b5d5-1c23-15fc-8e2f9454af05@valvesoftware.com>
 <CAHk-=wjZ1grLwJsGD+Fjz1_U_W47AFodBiwBX84HECUHt-guuw@mail.gmail.com>
 <20190622073753.GA10516@kroah.com>
 <20190626020220.GA22548@roeck-us.net>
 <20190626022923.GA14595@kroah.com>
 <53b23451-f45b-932d-a2f8-15f74f07a849@roeck-us.net>
 <CANn89iL69qDuHDPPk7gksoQvCyVEmBRRs-Kc_EVDkpxZe7DwMw@mail.gmail.com>
 <20190626051720.GA575@kroah.com>
 <CANn89iJPcD9cOrFUHR_sSVyjxzqYGwB2mG-Crf5vhxc7L+LgsA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANn89iJPcD9cOrFUHR_sSVyjxzqYGwB2mG-Crf5vhxc7L+LgsA@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 26, 2019 at 08:38:01AM +0200, Eric Dumazet wrote:
> On Wed, Jun 26, 2019 at 8:22 AM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Wed, Jun 26, 2019 at 06:20:17AM +0200, Eric Dumazet wrote:
> > > On Wed, Jun 26, 2019 at 5:43 AM Guenter Roeck <linux@roeck-us.net> wrote:
> > > >
> > > > On 6/25/19 7:29 PM, Greg Kroah-Hartman wrote:
> > > > > On Tue, Jun 25, 2019 at 07:02:20PM -0700, Guenter Roeck wrote:
> > > > >> Hi Greg,
> > > > >>
> > > > >> On Sat, Jun 22, 2019 at 09:37:53AM +0200, Greg Kroah-Hartman wrote:
> > > > >>> On Fri, Jun 21, 2019 at 10:28:21PM -0700, Linus Torvalds wrote:
> > > > >>>> On Fri, Jun 21, 2019 at 6:03 PM Pierre-Loup A. Griffais
> > > > >>>> <pgriffais@valvesoftware.com> wrote:
> > > > >>>>>
> > > > >>>>> I applied Eric's path to the tip of the branch and ran that kernel and
> > > > >>>>> the bug didn't occur through several logout / login cycles, so things
> > > > >>>>> look good at first glance. I'll keep running that kernel and report back
> > > > >>>>> if anything crops up in the future, but I believe we're good, beyond
> > > > >>>>> getting distros to ship this additional fix.
> > > > >>>>
> > > > >>>> Good. It's now in my tree, so we can get it quickly into stable and
> > > > >>>> then quickly to distributions.
> > > > >>>>
> > > > >>>> Greg, it's commit b6653b3629e5 ("tcp: refine memory limit test in
> > > > >>>> tcp_fragment()"), and I'm building it right now and I'll push it out
> > > > >>>> in a couple of minutes assuming nothing odd is going on.
> > > > >>>
> > > > >>> This looks good for 4.19 and 5.1, so I'll push out new stable kernels in
> > > > >>> a bit for them.
> > > > >>>
> > > > >>> But for 4.14 and older, we don't have the "hint" to know this is an
> > > > >>> outbound going packet and not to apply these checks at that point in
> > > > >>> time, so this patch doesn't work.
> > > > >>>
> > > > >>> I'll see if I can figure anything else later this afternoon for those
> > > > >>> kernels...
> > > > >>>
> > > > >>
> > > > >> I may have missed it, but I don't see a fix for the problem in
> > > > >> older stable branches. Any news ?
> > > > >>
> > > > >> One possibility might be be to apply the part of 75c119afe14f7 which
> > > > >> introduces TCP_FRAG_IN_WRITE_QUEUE and TCP_FRAG_IN_RTX_QUEUE, if that
> > > > >> is acceptable.
> > > > >
> > > > > That's what people have already discussed on the stable mailing list a
> > > > > few hours ago, hopefully a patch shows up soon as I'm traveling at the
> > > > > moment and can't do it myself...
> > > > >
> > > >
> > > > Sounds good. Let me know if nothing shows up; I'll be happy to do it
> > > > if needed.
> > >
> > >
> > > Without the rb-tree for rtx queues, old kernels are vulnerable to SACK
> > > attacks if sk_sndbuf is too big,
> > > so I would simply  add a cushion in the test, instead of trying to
> > > backport an illusion of the rb-tree fixes.
> > >
> > >
> > >
> > > diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> > > index a8772e11dc1cb42d4319b6fc072c625d284c7ad5..a554213afa4ac41120d781fe64b7cd18ff9b56e8
> > > 100644
> > > --- a/net/ipv4/tcp_output.c
> > > +++ b/net/ipv4/tcp_output.c
> > > @@ -1274,7 +1274,7 @@ int tcp_fragment(struct sock *sk, struct sk_buff
> > > *skb, u32 len,
> > >         if (nsize < 0)
> > >                 nsize = 0;
> > >
> > > -       if (unlikely((sk->sk_wmem_queued >> 1) > sk->sk_sndbuf)) {
> > > +       if (unlikely((sk->sk_wmem_queued >> 1) > sk->sk_sndbuf + 131072)) {
> > >                 NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPWQUEUETOOBIG);
> > >                 return -ENOMEM;
> > >         }
> >
> > That's a funny magic number, can we document what it means?
> 
> This is because TCP can cook skb with about 64KB of payload in
> tcp_sendmsg() before
> checking if memory limits are exceeded. (This is mentioned in commit
> b6653b3629e5b88202be3c9abc44713973f5c4b4
> " tcp: refine memory limit test in tcp_fragment()" changelog)
> 
> Then, if this giant TSO skb needs to be split in ~45 smaller skbs of
> one segment each,
> the resulting truesize might be twice bigger.
> 
> You could use 2 * 65536 if that looks better, and possibly a macro,
>  but I feel that adding a macro for this one particular spot and
> stable kernels might be overkill ?

Ah, yeah, 2*65536 makes more sense to me, seeing 131072 didn't trigger
the same "power of 2" thing in my brain :)

I'll fix this up and queue it up now, thanks!

greg k-h
