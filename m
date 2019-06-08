Return-Path: <SRS0=LGpO=UH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D847AC28CC5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 17:51:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA246208E3
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 17:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560016272;
	bh=MPFW72+Jt2ISDQtRqkkwrKu0zPzHgIUoED5s7r+7dFs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Yng3gIqV6dw4FyolVktabEY8+NVWFKJxODs7g5WzPGUoUvMXc2sGYdAqbIOC+py5n
	 dGBFlKWEluXePK5Jn4XzONDZJlNpUZvhNy911eYPJAIRBiyiF1s1xSVCyGKnNaB+pa
	 IWfuZpep7pvIu1so6CqhZJyraxnWAuXn2iAr7F+E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727324AbfFHRvL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Jun 2019 13:51:11 -0400
Received: from mail-lf1-f44.google.com ([209.85.167.44]:37373 "EHLO
        mail-lf1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727234AbfFHRvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jun 2019 13:51:11 -0400
Received: by mail-lf1-f44.google.com with SMTP id m15so3911310lfh.4
        for <linux-kernel@vger.kernel.org>; Sat, 08 Jun 2019 10:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=W+9QCBgZ9J2LCx+rEhbyPEc2X/CUYFq2IbJFH8fkL3M=;
        b=OJ1oYvJZ6e6i4G7bdLCVhlcvwr0pHFtMP6ZQaim/xPyhSQUqj99YSqUAeVdG+dLmxk
         mLPivGpd5euSbx5fKXvsmlx732m9r2LNS2ieZcz/rui4qyxz+94OKMK8wzJDt6Ofhiud
         xnGO27CZ1iE+XuSlD7A1HP5aPnFLZs/BzWKsY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W+9QCBgZ9J2LCx+rEhbyPEc2X/CUYFq2IbJFH8fkL3M=;
        b=GR4zfyP869EAxcQSf75Whb32HTTyH02e3f/yYZWFUI1aaSrmh646yXT2D+9nqKqSJB
         fgIr2yHOiixxr3/6h1863J6SYI0aW6/EHp7MOIBF/i3VoMCdA9ZKIFulqiHHpjNBSdTt
         DTg6lkSULojXMOTRQBfThS6jKo4ZuH/zSXntUjXxyDBbaDT+HLOTgHOXS8IzJy0apton
         lDqXhIwwlIOhM3tCjlnUC2f0sGhbWZAdj371YlWSQmELOzcAoAVT0SlxkXLOqwrP772r
         /yTd6MlnwTlBnB3DKo0jwzGQ9WgqVZucTuPXlftLvk6UMbLvBWXGAfzSr8goYxf9qClE
         kqFQ==
X-Gm-Message-State: APjAAAWAB9M7Yi49i+jRm+TH90x8ZlZwjzfFqops6dE/n1NvdisQ+v2t
        RQG3PCYOILG8qAZyWefIGtt/f2jqxCE=
X-Google-Smtp-Source: APXvYqzWDHUr9wvQWbCQRtlBXZmUFSplmMjGNkkIZAxDoxDDva19gidyCIlfp15SNtshgStd9FxftQ==
X-Received: by 2002:ac2:4202:: with SMTP id y2mr12214293lfh.178.1560016269292;
        Sat, 08 Jun 2019 10:51:09 -0700 (PDT)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id a3sm963706ljd.51.2019.06.08.10.51.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Sat, 08 Jun 2019 10:51:07 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id o13so4438554lji.5
        for <linux-kernel@vger.kernel.org>; Sat, 08 Jun 2019 10:51:07 -0700 (PDT)
X-Received: by 2002:a2e:6109:: with SMTP id v9mr31679230ljb.205.1560016266935;
 Sat, 08 Jun 2019 10:51:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190603200301.GM28207@linux.ibm.com> <Pine.LNX.4.44L0.1906041026570.1731-100000@iolanthe.rowland.org>
 <CAHk-=wgGnCw==uY8radrB+Tg_CEmzOtwzyjfMkuh7JmqFh+jzQ@mail.gmail.com>
 <20190607140949.tzwyprrhmqdx33iu@gondor.apana.org.au> <da5eedfe-92f9-6c50-b9e7-68886047dd25@gmail.com>
 <CAHk-=wgtY1hNQX9TM=4ono-UJ-hsoFA0OT36ixFWBG2eeO011w@mail.gmail.com>
 <20190608152707.GF28207@linux.ibm.com> <CAHk-=wj1G9nXMzAu=Ldbd4_bbzVtWgNORDKMD4bKTO6dRrMPmQ@mail.gmail.com>
In-Reply-To: <CAHk-=wj1G9nXMzAu=Ldbd4_bbzVtWgNORDKMD4bKTO6dRrMPmQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 8 Jun 2019 10:50:51 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiRduKzoLpAwU7iFiOJ6DX7RE+PZ_wFi9Cvq=hDoaNsPA@mail.gmail.com>
Message-ID: <CAHk-=wiRduKzoLpAwU7iFiOJ6DX7RE+PZ_wFi9Cvq=hDoaNsPA@mail.gmail.com>
Subject: Re: inet: frags: Turn fqdir->dead into an int for old Alphas
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     Eric Dumazet <eric.dumazet@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Alan Stern <stern@rowland.harvard.edu>,
        Boqun Feng <boqun.feng@gmail.com>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Fengguang Wu <fengguang.wu@intel.com>, LKP <lkp@01.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Luc Maranget <luc.maranget@inria.fr>,
        Jade Alglave <j.alglave@ucl.ac.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 8, 2019 at 10:42 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> There are no atomic rmw sequences that have reasonable performance for
> the bitfield updates themselves.

Note that this is purely about the writing side. Reads of bitfield
values can be (and generally _should_ be) atomic, and hopefully C11
means that you wouldn't see intermediate values.

But I'm not convinced about that either: one natural way to update a
bitfield is to first do the masking, and then do the insertion of new
bits, so a bitfield assignment very easily exposes non-real values to
a concurrent read on another CPU.

What I think C11 is supposed to protect is from compilers doing
horribly bad things, and accessing bitfields with bigger types than
the field itself, ie when you have

   struct {
       char c;
       int field1:5;
   };

then a write to "field1" had better not touch "char c" as part of the
rmw operation, because that would indeed introduce a data-race with a
completely independent field that might have completely independent
locking rules.

But

   struct {
        int c:8;
        int field1:5;
   };

would not sanely have the same guarantees, even if the layout in
memory might be identical. Once you have bitfields next to each other,
and use a base type that means they can be combined together, they
can't be sanely modified without locking.

(And I don't know if C11 took up the "base type of the bitfield"
thing. Maybe you still need to use the ":0" thing to force alignment,
and maybe the C standards people still haven't made the underlying
type be meaningful other than for sign handling).

            Linus
