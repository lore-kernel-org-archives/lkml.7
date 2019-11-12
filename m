Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1393AC17441
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 23:41:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DED1121925
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 23:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573602075;
	bh=TTHSlshsYeKxRTfQUJtxveXwbR1NuH1LpaDSGuZekbs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=rZLifllc2WNpfXhKE/Jb5mqJPjJD4rm1us8JFRI/7vYhACPu5ZTayKIGz31xz/brM
	 fBNbqa+Mot+cZeZvbZrPN+sZOJBb1Kz53bUvNClEtMK3s/YX3RiUy2DvfnvUNoAIL8
	 cf0OKryKFSD0qkui1NyRFee87oNSTE05xLToyav0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726995AbfKLXlO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 18:41:14 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:39989 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726958AbfKLXlO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 18:41:14 -0500
Received: by mail-lf1-f67.google.com with SMTP id j26so309398lfh.7
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 15:41:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EUXLb1uu1dcQwvM3XnfVOQS/u8rpUwxsukE0911wRv8=;
        b=BlxyQF/k0RbNlmXP5IB58F/0Xz3h4ttVpHaMWy/tA5ZBmhF0Hc9KKgINDE4bq+7VOV
         zqj7K+B23f5rkrn/XHC7xsbbzsc8AsUGEmABEH/wooLD/jCPv801/xBfUCp/v8T8n//8
         yAvsBxLJ7ZGLbzPhrSobnyjECGiABuvCmT8hg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EUXLb1uu1dcQwvM3XnfVOQS/u8rpUwxsukE0911wRv8=;
        b=Z9eS7sc30cv8J5bQkbaZbfATsS+EvKXJzP2uNjqyc88ULBEl0VbCGw2vrgOh1+5e4J
         9AJXrYc4H64Ab+5Kn9AsOumxK0A+dzhJvczTRmFwAiRNglF3sfzqHoXk8JyRjHSEFPUO
         k7zRIo/FpD7kfTZGLy8525DksxAlZrtUjz4cCXutU97V+uMiAHTrI1rq0ex5pg6vy+Uv
         rdkVb+3IItV6/GgC6lYrQXcNT4MsRcdmc9cdYFn7nRQzBahGdCL+4pQg+kBtr4/Z0rX/
         XbiEXli0WOUNe+PYESEeWpwsKjT/Miu+vkqyNuqh2MmUbZmLmGtbcgMtujYnhQAr6DMC
         QvrQ==
X-Gm-Message-State: APjAAAV7h00CCsgUOP22mXwBVl3BoyigR/GZux3AVaM5EcJ9MRPiJi6W
        76kAs1x2Ae231BEWyVR+Hjrtub1yJuo=
X-Google-Smtp-Source: APXvYqxTmCbOF8ZQAEwoaNe/n/SThwdCg36vEUGgta2TSUS+V6O76SlqlVxQkI7ZdqJs11m9JlnJoQ==
X-Received: by 2002:a19:8092:: with SMTP id b140mr302428lfd.13.1573602070403;
        Tue, 12 Nov 2019 15:41:10 -0800 (PST)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id y75sm119356lff.58.2019.11.12.15.41.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Nov 2019 15:41:09 -0800 (PST)
Received: by mail-lj1-f179.google.com with SMTP id g3so365141ljl.11
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 15:41:08 -0800 (PST)
X-Received: by 2002:a2e:22c1:: with SMTP id i184mr233777lji.1.1573602068124;
 Tue, 12 Nov 2019 15:41:08 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=wgnjMEvqHnu_iJcbr_kdFyBQLhYojwv5T7p9F+CHxA9pg@mail.gmail.com>
 <Pine.LNX.4.44L0.1911121639540.1567-100000@iolanthe.rowland.org>
 <CANn89iKjWH86kChzPiVtCgVpt3GookwGk2x1YCTMeBSPpKU+Ww@mail.gmail.com>
 <20191112224441.2kxmt727qy4l4ncb@ast-mbp.dhcp.thefacebook.com> <CANn89iKLy-5rnGmVt-nzf6as4MvXgZzSH+BSReXZKpSTjhoWAw@mail.gmail.com>
In-Reply-To: <CANn89iKLy-5rnGmVt-nzf6as4MvXgZzSH+BSReXZKpSTjhoWAw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 12 Nov 2019 15:40:51 -0800
X-Gmail-Original-Message-ID: <CAHk-=wj_rFOPF9Sw_-h-6J93tP9qO_UOEvd-e02z9+DEDs2kLQ@mail.gmail.com>
Message-ID: <CAHk-=wj_rFOPF9Sw_-h-6J93tP9qO_UOEvd-e02z9+DEDs2kLQ@mail.gmail.com>
Subject: Re: KCSAN: data-race in __alloc_file / __alloc_file
To:     Eric Dumazet <edumazet@google.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Marco Elver <elver@google.com>,
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

On Tue, Nov 12, 2019 at 3:18 PM Eric Dumazet <edumazet@google.com> wrote:
>
> Hmm we have the ' volatile'  attribute on jiffies, and it causes
> confusion already :p

The jiffies case is partly historical, but partly also because it's
one of the very very few data structures where 99% of all uses are
unlocked and for convenience reasons we really don't want to force
those legacy cases to do anything special about it.

"jiffies" really is very special for those kinds of legacy reasons.
Look at the kinds of games we play with it on 32-bit architectures:
the "real" storage is "jiffies_64", but nobody actually wants to use
that, and because of load tearing issues it's actually hard to use
too. So what everybody _uses_ is just the low 32 bits, and 'jiffies'
isn't a real variable, it's done with linker tricks in our
vmlinux.lds.S files. So, for example, on sparc32, you find this:

    jiffies = jiffies_64 + 4;

in the vmlinux.lds.S file, because it's big-endian, and the lower 32
bits are at offset 4 from the real 64-bit variable.

Note that to actually read the "true" full 64-bit value, you have to
then call a function that does the proper sequence counter stuff etc.
But nobody really wants it, since what everybody actually _uses_ is
the "time_after(x,jiffies+10)" kind of thing, which is only done in
the wrapping "unsigned long" time base. So the odd "linker tricks with
the atomic low bits marked as a volatile data structure" is actually
exactly what we want, but people should realize that this is not
normal.

So 'jiffies' is really really special.

And absolutely nothing else should use 'volatile' on data structures
and be that special.  In the case of jiffies, the rule ends up being
that nobody should ever write to it (you write to the real
jiffies_64), and the real jiffies_64 thing gets the real locking, and
'jiffies' is a read-only volatile thing.

So "READ_ONCE()" is indeed unnecessary with jiffies, but it won't
hurt. It's not really "confusion" - there's nothing _wrong_ with using
READ_ONCE() on volatile data, but we just normally don't do volatile
data in the kernel (because our normal model is that data is never
really volatile in general - there may be locked and unlocked accesses
to it, so it's stable or volatile depending on context, and thus the
'volatile' goes on the _code_, not on the data structure)

But while jiffies READ_ONCE() accesses isn't _wrong_, it is also not
really paired with any WRITE_ONCE(), because the real update is to
technically not even to the same full data structure.

So don't look to jiffies for how to do things. It's an odd one-off.

That said, for "this might be used racily", if there are annotations
for clang to just make it shut up about one particular field in a
structure, than I think that would be ok. As long as it doesn't then
imply special code generation (outside of the checking, of course).

                 Linus
