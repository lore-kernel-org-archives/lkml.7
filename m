Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE7C1C4646B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 04:20:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9341920663
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 04:20:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AnUkRffO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726590AbfFZEUd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 00:20:33 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:44940 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726076AbfFZEUc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 00:20:32 -0400
Received: by mail-yb1-f196.google.com with SMTP id j15so574618ybh.11
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 21:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NgZO8AtV2C/NdSOXt6DcG38OSSlpRBV+WcyoIVx6KVA=;
        b=AnUkRffO0xVZ1SQ60UmB9V/hFuQN5WA/A2dS6gyKE/n6RAEjhMEwkPsDh0Lu+Sf57A
         /Iv0j/VW+EOgsh7CtC0NxcWXKJciRo+R4amdHaKfT6P7XPnrtjK4twjpZj8aeaSAO4Oe
         l4zYvoQ0MiiirQKXYyB4EeT8BZe9/A6bWgPSqxn3k+Fxib8H7lx5bUNkrV9hTcUguQJZ
         1c+2Ql1flEop7FgexVatImQvhm3AGRKuv6eA201fgocwbcatuhua+XJ0pygj/R3+xesi
         G7iP8TFskS26KvYsNqWcaySuWrgJyMbWzswuph5m5X485OoQ/UYVW5vURRpzJrJhfIaU
         ileQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NgZO8AtV2C/NdSOXt6DcG38OSSlpRBV+WcyoIVx6KVA=;
        b=UGZda1m6Z46ZLHTn6rCHGLzShD8OnPZXBln3aLTFBNrw+Zqg9I+0cggeepMgDBoYz5
         m96vBvkeK6NfwnIxeQjZEvYy+89EloZtTedNpHqjP1oROYSGtpXuLWG3kK6qOOcgGbef
         f6y+WrWdREQa1VUabM6p2nTO4rHpJO1sI3zFgiiBIRjaBlkDw7M+Xb+2/XM0jDfvAxpM
         +bp6I9KVZ5MtHipG/+VDKd4ooBGyjQReV7AwOyrdPr1bfWjudrGIsr7AKFJdRIH0ur6t
         GsPC7ByQ59VWAyU9qEzhh7dbTz+i8B8KyWdWNruJReqTBDPaOVHWtC9S48LM2QAZULqd
         izXw==
X-Gm-Message-State: APjAAAXwcQun7n+ekAthF9By6AUIz5ocrFjRnOXlO4jeweb5EoEI0R2R
        SiyyS9/kMc81VkutHz24Z77owdwOWgwnG5j5bqkMRA==
X-Google-Smtp-Source: APXvYqxl6FVdu+gYxZacTmTdplmDWXv5k9CmZ1yc6k7DWSdvTLwBWRzWH2fBYU/7eACqslcJMl3o1joGGM7ULUWAbmM=
X-Received: by 2002:a25:55d7:: with SMTP id j206mr1420987ybb.234.1561522831028;
 Tue, 25 Jun 2019 21:20:31 -0700 (PDT)
MIME-Version: 1.0
References: <a624ec85-ea21-c72e-f997-06273d9b9f9e@valvesoftware.com>
 <20190621214139.GA31034@kroah.com> <CAHk-=wgXoBMWdBahuQR9e75ri6oeVBBjoVEnk0rN1QXfSKK2Eg@mail.gmail.com>
 <CANn89iL5+x3n9H9v4O6y39W=jvQs=uuXbzOvN5mBbcj0t+wdeg@mail.gmail.com>
 <CAHk-=wjZ=8VSjWuqeG6JJv4dQfK6M0Jgckq5-6=SJa25aku-vQ@mail.gmail.com>
 <CANn89iLU+NNy7QDPNLYPxNWMx5cXuhziOT7TX2uYt42uUJcNVg@mail.gmail.com>
 <b72599d1-b5d5-1c23-15fc-8e2f9454af05@valvesoftware.com> <CAHk-=wjZ1grLwJsGD+Fjz1_U_W47AFodBiwBX84HECUHt-guuw@mail.gmail.com>
 <20190622073753.GA10516@kroah.com> <20190626020220.GA22548@roeck-us.net>
 <20190626022923.GA14595@kroah.com> <53b23451-f45b-932d-a2f8-15f74f07a849@roeck-us.net>
In-Reply-To: <53b23451-f45b-932d-a2f8-15f74f07a849@roeck-us.net>
From:   Eric Dumazet <edumazet@google.com>
Date:   Wed, 26 Jun 2019 06:20:17 +0200
Message-ID: <CANn89iL69qDuHDPPk7gksoQvCyVEmBRRs-Kc_EVDkpxZe7DwMw@mail.gmail.com>
Subject: Re: Steam is broken on new kernels
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Pierre-Loup A. Griffais" <pgriffais@valvesoftware.com>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 26, 2019 at 5:43 AM Guenter Roeck <linux@roeck-us.net> wrote:
>
> On 6/25/19 7:29 PM, Greg Kroah-Hartman wrote:
> > On Tue, Jun 25, 2019 at 07:02:20PM -0700, Guenter Roeck wrote:
> >> Hi Greg,
> >>
> >> On Sat, Jun 22, 2019 at 09:37:53AM +0200, Greg Kroah-Hartman wrote:
> >>> On Fri, Jun 21, 2019 at 10:28:21PM -0700, Linus Torvalds wrote:
> >>>> On Fri, Jun 21, 2019 at 6:03 PM Pierre-Loup A. Griffais
> >>>> <pgriffais@valvesoftware.com> wrote:
> >>>>>
> >>>>> I applied Eric's path to the tip of the branch and ran that kernel and
> >>>>> the bug didn't occur through several logout / login cycles, so things
> >>>>> look good at first glance. I'll keep running that kernel and report back
> >>>>> if anything crops up in the future, but I believe we're good, beyond
> >>>>> getting distros to ship this additional fix.
> >>>>
> >>>> Good. It's now in my tree, so we can get it quickly into stable and
> >>>> then quickly to distributions.
> >>>>
> >>>> Greg, it's commit b6653b3629e5 ("tcp: refine memory limit test in
> >>>> tcp_fragment()"), and I'm building it right now and I'll push it out
> >>>> in a couple of minutes assuming nothing odd is going on.
> >>>
> >>> This looks good for 4.19 and 5.1, so I'll push out new stable kernels in
> >>> a bit for them.
> >>>
> >>> But for 4.14 and older, we don't have the "hint" to know this is an
> >>> outbound going packet and not to apply these checks at that point in
> >>> time, so this patch doesn't work.
> >>>
> >>> I'll see if I can figure anything else later this afternoon for those
> >>> kernels...
> >>>
> >>
> >> I may have missed it, but I don't see a fix for the problem in
> >> older stable branches. Any news ?
> >>
> >> One possibility might be be to apply the part of 75c119afe14f7 which
> >> introduces TCP_FRAG_IN_WRITE_QUEUE and TCP_FRAG_IN_RTX_QUEUE, if that
> >> is acceptable.
> >
> > That's what people have already discussed on the stable mailing list a
> > few hours ago, hopefully a patch shows up soon as I'm traveling at the
> > moment and can't do it myself...
> >
>
> Sounds good. Let me know if nothing shows up; I'll be happy to do it
> if needed.


Without the rb-tree for rtx queues, old kernels are vulnerable to SACK
attacks if sk_sndbuf is too big,
so I would simply  add a cushion in the test, instead of trying to
backport an illusion of the rb-tree fixes.



diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index a8772e11dc1cb42d4319b6fc072c625d284c7ad5..a554213afa4ac41120d781fe64b7cd18ff9b56e8
100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -1274,7 +1274,7 @@ int tcp_fragment(struct sock *sk, struct sk_buff
*skb, u32 len,
        if (nsize < 0)
                nsize = 0;

-       if (unlikely((sk->sk_wmem_queued >> 1) > sk->sk_sndbuf)) {
+       if (unlikely((sk->sk_wmem_queued >> 1) > sk->sk_sndbuf + 131072)) {
                NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPWQUEUETOOBIG);
                return -ENOMEM;
        }
