Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2BD3C43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 23:43:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDDFD208CA
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 23:43:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fyJ+Y9O6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726155AbfFUXnN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 19:43:13 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:37758 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726045AbfFUXnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 19:43:13 -0400
Received: by mail-lj1-f193.google.com with SMTP id 131so7403132ljf.4
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2019 16:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tmluSxzqhi5CcpOX2qxUxSbj+sNH9VpLrhtNj2D7dDA=;
        b=fyJ+Y9O6DdqVwOvEIXKf+lqUkhC4gruGlisZaVRnzqyHIqi5oFgHSCD5hfU8u72tpW
         f+mk6x3zSl2n8uP2mhyfdTgkqj4i7cU4fz+Znwd29vPXmqkiTcB+QntH7Y1HXsq0dSSZ
         eQfxFK9WeS3rd02Y1pFGg+cWYHErg/jkpNjyRIVQmO38sitxEAX6umJpRTfvCRHZRbkW
         fVLPd2XI7Rypm3N9YxQNqrZNm5mbPwV37hTHexFGoZQJ6NddVdw3Kbb5REnykG0PpybD
         IyISp5bgLBoIAVPSnqfuFCld8xVkP+zdiB9ZWlkArAKFHU8tOpeCv5zRmfuIUkIxm/mg
         6VqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tmluSxzqhi5CcpOX2qxUxSbj+sNH9VpLrhtNj2D7dDA=;
        b=TTRVWfkO85IaR0KWHNMMBs1K2aQrX58RHeFPmdGeDMT3uHl9KbOmjI1vgynPkDYZ5R
         mqCw4u2+chjiV3EOorrdUvqE53+r319H7bUJMiCRJkUGZ2Vw7qY2HjkfTL5laKPYo8xa
         uguzsbt7vL/2ATHADWSdZV7PzuQbVZBuv7vT6YLhV7JFJDUk+5i+iUzTPX+S6uEE3eGh
         lETe20fMSEVrq8shQVMr+RCktMbOa1gpleOz4M+M2XXSlqcdcv2fsRrUIpQwdjaZHlj3
         QR3Btz2XArHL7zFyLVJ0Pqx4lOIU/Z/SClmXPSphNQxJfu1PgVARHSLN9sfhYmB1oaQF
         ebdw==
X-Gm-Message-State: APjAAAXJLjcxC43PMxh1pe3GJy7WKe3lFIyVJL0yxE+bpxzoYBHTZ1Kd
        W9hYbqiDL0z1u8tShMG7nLS19b8s+BJYJuh4unl66V3ZWg8=
X-Google-Smtp-Source: APXvYqzdPYm7WU7qAhvc5RWL+8KcjWjGuDl2TS7nSTziD2LJLQ2GqVpNdQ3oHKHZcFkHIqQxIHJH1Md3ER9KRM9SlEA=
X-Received: by 2002:a2e:890a:: with SMTP id d10mr31837859lji.145.1561160591228;
 Fri, 21 Jun 2019 16:43:11 -0700 (PDT)
MIME-Version: 1.0
References: <a624ec85-ea21-c72e-f997-06273d9b9f9e@valvesoftware.com>
 <20190621214139.GA31034@kroah.com> <CAHk-=wgXoBMWdBahuQR9e75ri6oeVBBjoVEnk0rN1QXfSKK2Eg@mail.gmail.com>
 <CANn89iL5+x3n9H9v4O6y39W=jvQs=uuXbzOvN5mBbcj0t+wdeg@mail.gmail.com> <5a012e7c-cbed-c3a9-8d84-851de34630d8@valvesoftware.com>
In-Reply-To: <5a012e7c-cbed-c3a9-8d84-851de34630d8@valvesoftware.com>
From:   Josh Hunt <joshhunt00@gmail.com>
Date:   Fri, 21 Jun 2019 16:42:59 -0700
Message-ID: <CAKA=qzaJETw4nzcmM0QJipcCjNJ51aNFSJiqA8tc++T3tP2_-g@mail.gmail.com>
Subject: Re: Steam is broken on new kernels
To:     "Pierre-Loup A. Griffais" <pgriffais@valvesoftware.com>
Cc:     Eric Dumazet <edumazet@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 21, 2019 at 4:07 PM Pierre-Loup A. Griffais
<pgriffais@valvesoftware.com> wrote:
>
>
>
> On 6/21/19 3:38 PM, Eric Dumazet wrote:
> > Please look at my recent patch.
> >   Sorry I am travelling....
> >
> > On Fri, Jun 21, 2019, 6:19 PM Linus Torvalds
> > <torvalds@linux-foundation.org <mailto:torvalds@linux-foundation.org>>
> > wrote:
> >
> >     On Fri, Jun 21, 2019 at 2:41 PM Greg Kroah-Hartman
> >     <gregkh@linuxfoundation.org <mailto:gregkh@linuxfoundation.org>> wrote:
> >      >
> >      > What specific commit caused the breakage?
> >
> >     Both on reddit and on github there seems to be confusion about whether
> >     it's a problem or not. Some people have it working with the exact same
> >     kernel that breaks for others.
> >
> >     And then some people seem to say it works intermittently for them,
> >     which seems to indicate a timing issue.
> >
> >     Looking at the SACK patches (assuming it's one of them), I'd suspect
> >     the "tcp: tcp_fragment() should apply sane memory limits".
> >
> >     Eric, that one does
> >
> >             if (unlikely((sk->sk_wmem_queued >> 1) > sk->sk_sndbuf)) {
> >                     NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPWQUEUETOOBIG);
> >                     return -ENOMEM;
> >             }
> >
> >     but I think it's *normal* for "sk_wmem_queued >> 1" to be around the
> >     same size as sk_sndbuf. So if there is some fragmentation, and we add
> >     more skb's to it, that would seem to trigger fairly easily.
> >     Particularly since this is all in "truesize" units, which can be a lot
> >     bigger than the packets themselves.
> >
> >     I don't know the code, so I may be out to lunch and barking up
> >     completely the wrong tree, but that particular check does seem like it
> >     might trigger much more easily than I think the code _intended_ it to
> >     trigger?
> >
> >     Pierre-Loup - do you guys have a test-case inside of valve? Or is this
> >     purely "we see some people with problems"?
>
> Definitely the latter, although the volume of complaints clearly points
> to a real problem from our experience. Reproducing locally, bisecting
> and testing possible fixes is just now starting on our end.
>
> I agree not all users seem affected; most affected people report success
> by using -tcp to launch Steam, which makes it use direct TCP instead of
> WebSockets, our current default connection method for Linux.
>
> Thanks,
>   - Pierre-Loup
>
> >
> >                     Linus
> >
>
I asked on the github thread if users seeing the problem could check
the new wqueue too big counter:
https://github.com/ValveSoftware/steam-for-linux/issues/6326

So far one person is seeing the counter increase when they see the
problem, and another that doesn't see the problem has the counter at
0. Obviously not a great sample size, but hopefully more will report.
If nothing else, someone is seeing the counter increase while trying
to connect to steam.
-- 
Josh
