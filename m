Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5699BC4646B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 06:22:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AB46208E3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 06:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561530139;
	bh=Y0NLK/WD3YKZ7oNR9J2o22Bs0Rk1AeNO7mk2DXknmeM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=jPEtJOFG3KRnBOd6sGVx8CI1sc/hTBou49ql3jWVsdCsjXzdI9AfUHAwczwZ/24GV
	 /oc/k7DpFgmWs09Gqo/Pe4Wld/mmGrNrG5NXL2gP5WakcZ4AirWpD3GwatNVEW1Rdh
	 zV+TAFBUHz7ExfHRuZrRuwN38JeNCWOg289WgE5E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726723AbfFZGWR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 02:22:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:54932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725379AbfFZGWR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 02:22:17 -0400
Received: from localhost (unknown [116.247.127.123])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C46112085A;
        Wed, 26 Jun 2019 06:22:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561530136;
        bh=Y0NLK/WD3YKZ7oNR9J2o22Bs0Rk1AeNO7mk2DXknmeM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T2kFQQEEJjsom+H4Lf84ZwY6u2lH/3QWvauCz5iHaQgxd8jN79AZynBAmaUriA2LC
         KGVejn762EZfUbhHYTA1kvhjc/tqlOiMIveKXcM1YAi4Qg7KbTGF9s2ZoFAR3T9eFr
         ephw25fgakaNNPo6+pG8Rj0RHT40+Er3nODKolQI=
Date:   Wed, 26 Jun 2019 13:17:20 +0800
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Eric Dumazet <edumazet@google.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Pierre-Loup A. Griffais" <pgriffais@valvesoftware.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Steam is broken on new kernels
Message-ID: <20190626051720.GA575@kroah.com>
References: <CANn89iL5+x3n9H9v4O6y39W=jvQs=uuXbzOvN5mBbcj0t+wdeg@mail.gmail.com>
 <CAHk-=wjZ=8VSjWuqeG6JJv4dQfK6M0Jgckq5-6=SJa25aku-vQ@mail.gmail.com>
 <CANn89iLU+NNy7QDPNLYPxNWMx5cXuhziOT7TX2uYt42uUJcNVg@mail.gmail.com>
 <b72599d1-b5d5-1c23-15fc-8e2f9454af05@valvesoftware.com>
 <CAHk-=wjZ1grLwJsGD+Fjz1_U_W47AFodBiwBX84HECUHt-guuw@mail.gmail.com>
 <20190622073753.GA10516@kroah.com>
 <20190626020220.GA22548@roeck-us.net>
 <20190626022923.GA14595@kroah.com>
 <53b23451-f45b-932d-a2f8-15f74f07a849@roeck-us.net>
 <CANn89iL69qDuHDPPk7gksoQvCyVEmBRRs-Kc_EVDkpxZe7DwMw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANn89iL69qDuHDPPk7gksoQvCyVEmBRRs-Kc_EVDkpxZe7DwMw@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 26, 2019 at 06:20:17AM +0200, Eric Dumazet wrote:
> On Wed, Jun 26, 2019 at 5:43 AM Guenter Roeck <linux@roeck-us.net> wrote:
> >
> > On 6/25/19 7:29 PM, Greg Kroah-Hartman wrote:
> > > On Tue, Jun 25, 2019 at 07:02:20PM -0700, Guenter Roeck wrote:
> > >> Hi Greg,
> > >>
> > >> On Sat, Jun 22, 2019 at 09:37:53AM +0200, Greg Kroah-Hartman wrote:
> > >>> On Fri, Jun 21, 2019 at 10:28:21PM -0700, Linus Torvalds wrote:
> > >>>> On Fri, Jun 21, 2019 at 6:03 PM Pierre-Loup A. Griffais
> > >>>> <pgriffais@valvesoftware.com> wrote:
> > >>>>>
> > >>>>> I applied Eric's path to the tip of the branch and ran that kernel and
> > >>>>> the bug didn't occur through several logout / login cycles, so things
> > >>>>> look good at first glance. I'll keep running that kernel and report back
> > >>>>> if anything crops up in the future, but I believe we're good, beyond
> > >>>>> getting distros to ship this additional fix.
> > >>>>
> > >>>> Good. It's now in my tree, so we can get it quickly into stable and
> > >>>> then quickly to distributions.
> > >>>>
> > >>>> Greg, it's commit b6653b3629e5 ("tcp: refine memory limit test in
> > >>>> tcp_fragment()"), and I'm building it right now and I'll push it out
> > >>>> in a couple of minutes assuming nothing odd is going on.
> > >>>
> > >>> This looks good for 4.19 and 5.1, so I'll push out new stable kernels in
> > >>> a bit for them.
> > >>>
> > >>> But for 4.14 and older, we don't have the "hint" to know this is an
> > >>> outbound going packet and not to apply these checks at that point in
> > >>> time, so this patch doesn't work.
> > >>>
> > >>> I'll see if I can figure anything else later this afternoon for those
> > >>> kernels...
> > >>>
> > >>
> > >> I may have missed it, but I don't see a fix for the problem in
> > >> older stable branches. Any news ?
> > >>
> > >> One possibility might be be to apply the part of 75c119afe14f7 which
> > >> introduces TCP_FRAG_IN_WRITE_QUEUE and TCP_FRAG_IN_RTX_QUEUE, if that
> > >> is acceptable.
> > >
> > > That's what people have already discussed on the stable mailing list a
> > > few hours ago, hopefully a patch shows up soon as I'm traveling at the
> > > moment and can't do it myself...
> > >
> >
> > Sounds good. Let me know if nothing shows up; I'll be happy to do it
> > if needed.
> 
> 
> Without the rb-tree for rtx queues, old kernels are vulnerable to SACK
> attacks if sk_sndbuf is too big,
> so I would simply  add a cushion in the test, instead of trying to
> backport an illusion of the rb-tree fixes.
> 
> 
> 
> diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> index a8772e11dc1cb42d4319b6fc072c625d284c7ad5..a554213afa4ac41120d781fe64b7cd18ff9b56e8
> 100644
> --- a/net/ipv4/tcp_output.c
> +++ b/net/ipv4/tcp_output.c
> @@ -1274,7 +1274,7 @@ int tcp_fragment(struct sock *sk, struct sk_buff
> *skb, u32 len,
>         if (nsize < 0)
>                 nsize = 0;
> 
> -       if (unlikely((sk->sk_wmem_queued >> 1) > sk->sk_sndbuf)) {
> +       if (unlikely((sk->sk_wmem_queued >> 1) > sk->sk_sndbuf + 131072)) {
>                 NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPWQUEUETOOBIG);
>                 return -ENOMEM;
>         }

That's a funny magic number, can we document what it means?

And yes, it's a much simpler patch, I'd rather take this than the fake
backport.

thanks,

greg k-h
