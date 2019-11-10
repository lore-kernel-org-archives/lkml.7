Return-Path: <SRS0=U1ji=ZC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E24A5C43331
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 19:21:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B533F20854
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 19:21:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573413680;
	bh=fsQV/vIJseysmHIBSbuAF5psHRmutlyROOzFy00FGtU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ZaIi5mzoc320k5260wHO9T/E2ONgvHULhKZ3D5JF3p76+dwdQ6LRHhBRfIVR1NMCr
	 wgQfcjquC8nv1GfhXfVUBvvSXD+5RZjJp3LHQVXb44XAq0pt4f7Z3ku4BzGOCjPQAf
	 wPuQr7fOE26UbO0nxGw3UPZZwj4DRkQlHbQjalEs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbfKJTVP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Nov 2019 14:21:15 -0500
Received: from mail-lj1-f173.google.com ([209.85.208.173]:39966 "EHLO
        mail-lj1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726835AbfKJTVO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Nov 2019 14:21:14 -0500
Received: by mail-lj1-f173.google.com with SMTP id q2so11438072ljg.7
        for <linux-kernel@vger.kernel.org>; Sun, 10 Nov 2019 11:21:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vps6XmCw9WRkAtYxpnFwWu+xV4X8ojukCSN0qo58N6c=;
        b=cIj419uq1cCoNo/Cqt9dnkfZ/zoLO/cAgHHpjyVkn/Tj0px/QPbQk8+nmQiG4RBzYX
         /DhDmmagDbgLBwtfJUZexOqqGEfiZJNMQDyi3dPKp2PfVpw/BsJT01SEfki1eU0+DTUe
         IuZxYN2U4SUb4pI+OIgnz5/kkESeGNQ+VYBVY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vps6XmCw9WRkAtYxpnFwWu+xV4X8ojukCSN0qo58N6c=;
        b=ZKtA1puf3xSQglqfdzvZlCjlLXgt4JEKKKVlFONalJt75pFX8pyhvYzZnpbHLP5tP/
         hrrwxifLxYWhb9DVhw2Aeli0duxfoP2MNpnSGK89xm8tAlPKt+FvPof/1iEzS2opxp1S
         wwmDJJS3KV1DcJF2NDwk/PhV7jK36zdfdRid/v6TvDdlEnoRtnfTO4CPdpTxyyewSvW1
         mLhsA/lX9s/+B6DzD2VhWDtGb+TTKc7fD2xUXJqKgwkzDs0nzewDKiKQcH4t58zF5Hdo
         c/iHO5uP6ieMiOgZhiky04IcwrQ75ucGujSW3DqMnKaaFNykdrnVdkwFawzHpOMnBkGH
         wZoA==
X-Gm-Message-State: APjAAAXTeGlcScxy7N4C500DPXGYgHU3fpdcCAefxFdWClidgfCCRIHt
        LmoRf3g3Tm5zpymWH8lrRNjgzlK5FZI=
X-Google-Smtp-Source: APXvYqwno7GZIls6BHnqTz1AjkZDp3YvpYXRxx29fQJm3sGfQ3+k6+trXJ6PyrlJ/CfZ9p7oZwML1w==
X-Received: by 2002:a2e:7016:: with SMTP id l22mr13745072ljc.227.1573413671496;
        Sun, 10 Nov 2019 11:21:11 -0800 (PST)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id r12sm6010310ljh.102.2019.11.10.11.21.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Nov 2019 11:21:10 -0800 (PST)
Received: by mail-lf1-f43.google.com with SMTP id z188so966512lfa.11
        for <linux-kernel@vger.kernel.org>; Sun, 10 Nov 2019 11:21:09 -0800 (PST)
X-Received: by 2002:ac2:498a:: with SMTP id f10mr1217684lfl.170.1573413669634;
 Sun, 10 Nov 2019 11:21:09 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=wjB61GNmqpX0BLA5tpL4tsjWV7akaTc2Roth7uGgax+mw@mail.gmail.com>
 <Pine.LNX.4.44L0.1911101034180.29192-100000@netrider.rowland.org> <CAHk-=wjErHCwkcgO-=NReU0KR4TFozrFktbhh2rzJ=mPgRO0-g@mail.gmail.com>
In-Reply-To: <CAHk-=wjErHCwkcgO-=NReU0KR4TFozrFktbhh2rzJ=mPgRO0-g@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 10 Nov 2019 11:20:53 -0800
X-Gmail-Original-Message-ID: <CAHk-=wghq7rmtskFj7EbngpXUTJfc4H9sDcx10E6kMHoH2EsKA@mail.gmail.com>
Message-ID: <CAHk-=wghq7rmtskFj7EbngpXUTJfc4H9sDcx10E6kMHoH2EsKA@mail.gmail.com>
Subject: Re: KCSAN: data-race in __alloc_file / __alloc_file
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Marco Elver <elver@google.com>, Eric Dumazet <edumazet@google.com>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        syzbot <syzbot+3ef049d50587836c0606@syzkaller.appspotmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrea Parri <parri.andrea@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 10, 2019 at 11:12 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> And this is where WRITE_IDEMPOTENT would make a possible difference.
> In particular, if we make the optimization to do the "read and only
> write if changed"

It might be useful for checking too. IOW, something like KCSAN could
actually check that if a field has an idempotent write to it, all
writes always have the same value.

Again, there's the issue with lifetime.

Part of that is "initialization is different". Those writes would not
be marked idempotent, of course, and they'd write another value.

There's also the issue of lifetime at the _end_ of the use, of course.
There _are_ interesting data races at the end of the lifetime, both
reads and writes.

In particular, if it's a sticky flag, in order for there to not be any
races, all the writes have to happen with a refcount held, and the
final read has to happen after the final refcount is dropped (and the
refcounts have to have atomicity and ordering, of course). I'm not
sure how easy something like that is model in KSAN. Maybe it already
does things like that for all the other refcount stuff we do.

But the lifetime can be problematic for other reasons too - in this
particular case we have a union for that sticky flag (which is used
under the refcount), and then when the final refcount is released we
read that value (thus no data race) but because of the union we will
now start using that field with *different* data. It becomes that RCU
list head instead.

That kind of "it used to be a sticky flag, but now the lifetime of the
flag is over, and it's something entirely different" might be a
nightmare for something like KCSAN. It sounds complicated to check
for, but I have no idea what KCSAN really considers complicated or
not.

                  Linus
