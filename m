Return-Path: <SRS0=kYop=UV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFD9EC43613
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 00:21:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB5122075E
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 00:21:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Z6SMPQ8R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726129AbfFVATT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 20:19:19 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:44825 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726052AbfFVATS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 20:19:18 -0400
Received: by mail-yw1-f65.google.com with SMTP id l79so3433858ywe.11
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2019 17:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w34v2JVJxopQHJuBlPs9SCtKuvVG0EhMCINJqC23axo=;
        b=Z6SMPQ8RxkX6nPIpSrK4aF90fK7d9gpVD39j40VVwgv7iSXY2n/aX3JQaS7cPwwcaG
         +8wPDt4yP4N+k85a/2F22SN1cYAs7zKmsBy/6ybxbrZhbQonRTwmv9KxDl1vyIBhbspr
         D/UAEy8Ln/LbijPW6LEfHvxGh2ek7EkoMT+YmJICLLxU2rN5pKq4jsh8NByuX4v3FAfI
         rLc0eIBSypPINN9kA68P01gaqgQ+62db1YKl1US2/6gxzb2Px5LQbmNlYs/GhGKZ0JNM
         ZkMllbH2pSlrt0MVmTg0er3fmWvx6gjb3ELfizAlA9798NGF9MfvhdErb3QFrm9sqo/p
         f8mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w34v2JVJxopQHJuBlPs9SCtKuvVG0EhMCINJqC23axo=;
        b=FNymw1TdppKEZpO+yaODn1d+dz0lNifPFPVzHKVDO+WGhBvCBoRl7zAUOGoWgfhKlX
         RN9NJPkZ+tc/iPQQsBPpijX6GeVw0/bUo1PDXDv/BE6Dr6/0LUEiYo1+OY9elYcYC22c
         8pCU9FeTBF09JX+fIUv762cdgaoVGKc+lqtkrZYsrGnl2n+DYbW/wdPQKjHRjpl6cs3p
         6nREa5bjc//SaxQQjZROyqrZgm3jrzOZpENYAKg9znBqPqEporhntoml7MHL1BdeMPDo
         tGThuJuF+Iqu5i6K1vEN5eEQniLIpXKLcZ9jRcyFtDKJqiPYrRg89pHJx+zAtieu2bmh
         4Gxw==
X-Gm-Message-State: APjAAAXCK/nZO8iIJJFbUVym1Lb21QNIPjg1VtN4tu2zGrSbh1/U8Kic
        Nq1fv0ZmIhAbQFSQmZ3HyzoUprQHOp4cQe/QkcaYCQ==
X-Google-Smtp-Source: APXvYqzxHs2Kr+YLb64zVuj2l1IQKGyuMFYyvrpDf7ZkA3ofAvxtsszdMd26BP+4Kit5js3rHDzvKfMqOIHgKhujwLM=
X-Received: by 2002:a81:6f84:: with SMTP id k126mr68080306ywc.496.1561162757421;
 Fri, 21 Jun 2019 17:19:17 -0700 (PDT)
MIME-Version: 1.0
References: <a624ec85-ea21-c72e-f997-06273d9b9f9e@valvesoftware.com>
 <20190621214139.GA31034@kroah.com> <CAHk-=wgXoBMWdBahuQR9e75ri6oeVBBjoVEnk0rN1QXfSKK2Eg@mail.gmail.com>
 <CANn89iL5+x3n9H9v4O6y39W=jvQs=uuXbzOvN5mBbcj0t+wdeg@mail.gmail.com> <CAHk-=wjZ=8VSjWuqeG6JJv4dQfK6M0Jgckq5-6=SJa25aku-vQ@mail.gmail.com>
In-Reply-To: <CAHk-=wjZ=8VSjWuqeG6JJv4dQfK6M0Jgckq5-6=SJa25aku-vQ@mail.gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Fri, 21 Jun 2019 20:19:04 -0400
Message-ID: <CANn89iLU+NNy7QDPNLYPxNWMx5cXuhziOT7TX2uYt42uUJcNVg@mail.gmail.com>
Subject: Re: Steam is broken on new kernels
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Pierre-Loup A. Griffais" <pgriffais@valvesoftware.com>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 21, 2019 at 7:54 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Eric is talking about this patch, I think:
>
>    https://patchwork.ozlabs.org/patch/1120222/
>

That  is correct.

I am about to take a flight from Boston to Paris, so I can not really
follow discussions/tests for the following hours.

Thanks.

> I guess I'll ask people on the github thread to test that too.
>
>                   Linus
>
> On Fri, Jun 21, 2019 at 3:38 PM Eric Dumazet <edumazet@google.com> wrote:
> >
> > Please look at my recent patch.
> >  Sorry I am travelling....
> >
> > On Fri, Jun 21, 2019, 6:19 PM Linus Torvalds <torvalds@linux-foundation.org> wrote:
> >>
> >> On Fri, Jun 21, 2019 at 2:41 PM Greg Kroah-Hartman
> >> <gregkh@linuxfoundation.org> wrote:
> >> >
> >> > What specific commit caused the breakage?
> >>
> >> Both on reddit and on github there seems to be confusion about whether
> >> it's a problem or not. Some people have it working with the exact same
> >> kernel that breaks for others.
> >>
> >> And then some people seem to say it works intermittently for them,
> >> which seems to indicate a timing issue.
> >>
> >> Looking at the SACK patches (assuming it's one of them), I'd suspect
> >> the "tcp: tcp_fragment() should apply sane memory limits".
> >>
> >> Eric, that one does
> >>
> >>        if (unlikely((sk->sk_wmem_queued >> 1) > sk->sk_sndbuf)) {
> >>                NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPWQUEUETOOBIG);
> >>                return -ENOMEM;
> >>        }
> >>
> >> but I think it's *normal* for "sk_wmem_queued >> 1" to be around the
> >> same size as sk_sndbuf. So if there is some fragmentation, and we add
> >> more skb's to it, that would seem to trigger fairly easily.
> >> Particularly since this is all in "truesize" units, which can be a lot
> >> bigger than the packets themselves.
> >>
> >> I don't know the code, so I may be out to lunch and barking up
> >> completely the wrong tree, but that particular check does seem like it
> >> might trigger much more easily than I think the code _intended_ it to
> >> trigger?
> >>
> >> Pierre-Loup - do you guys have a test-case inside of valve? Or is this
> >> purely "we see some people with problems"?
> >>
> >>                Linus
