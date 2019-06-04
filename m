Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B429C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 16:05:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60DA12053B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 16:05:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559664319;
	bh=Tas0LyiyZ5/HxvVNQA7D/Il3abjxQfVG8db4pLHRHTM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=OidQFgZBIF0IiBUcdpHaY2fT/5GUciLBu32Ava73Thx+oEw67c/NONlZrrX5ILQf1
	 VyPV69RnMRboiMol9CtXDcQ+MDMXifF4v57DINi8VyfzXtuhQdy02IpG53QLdpzAfW
	 QdPU/2FIoYqpPfHs7WETMRnrJOyUtdUvQlzoMozU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728241AbfFDQFS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 12:05:18 -0400
Received: from mail-lf1-f43.google.com ([209.85.167.43]:43935 "EHLO
        mail-lf1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728160AbfFDQFR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 12:05:17 -0400
Received: by mail-lf1-f43.google.com with SMTP id j29so2957366lfk.10
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2019 09:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yHKf0dBjWiln0w4ZthMmJnFg12c3Gmyiday/W+Ueeog=;
        b=P+lo3dX3Y853XVVu/NErjTHy0y3uTOH5/1fFj4/+SdG8xmL9Vhgu3H+7epySB5/DoQ
         dE44yz0S2d21n4MIUQWM/Dq2DDY7x8hX/s3oEWxiond0RMSTcyQ7l8X3Q+Qh7jsMktff
         GFarG1OFqhP44+4kIN0kRqLqWQzDquNP2iWEM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yHKf0dBjWiln0w4ZthMmJnFg12c3Gmyiday/W+Ueeog=;
        b=dmmzYcG2GyPFQB25NadWNLm/ExsBzm1H6LJ2QuC/7WdT1hSdxKHWeVWKbdRFCjAn0B
         dR/TEriaeXnfCMey41dlI9wg50RiK3oyO0bPSMcWndDWB/bj4cxmB4TUZgQkAmNunyHX
         UJYC1Om6JHIRx8Jb0rAsDX53YMHj0nXNVRrulfiAc3TyFPhYo+Nhy4cALbbAUWfGH2Cg
         zOcS3/2HXA7tONrui9qUCcYom9G0+apxH+MY7w7cAVT+Wl5A903yBLgyzNX+tHkb/aZD
         4M0TiQQ8pvgkjjcofJgAXNcfsEi+/yfj8tJGHRwJFtPvX1uig+jJHsHm1IlzQNODAvVZ
         1FgQ==
X-Gm-Message-State: APjAAAV45rxTkG8lp7W9ucWKSUkdQ7lOJBy98kWXIvQternhKWjkNHL9
        3OqqFxlj5uHjll3otHuQPkPI0vzPW9A=
X-Google-Smtp-Source: APXvYqx3ICsY+GsMxijw68T4KX80GnBNNnPK8OvCTx5avQrBt51YOccPrRDnUc3I5F4blLxnwcOfbQ==
X-Received: by 2002:ac2:419a:: with SMTP id z26mr16557625lfh.122.1559664313554;
        Tue, 04 Jun 2019 09:05:13 -0700 (PDT)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id m11sm3776406lfk.82.2019.06.04.09.05.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Jun 2019 09:05:12 -0700 (PDT)
Received: by mail-lj1-f181.google.com with SMTP id m23so1955978lje.12
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2019 09:05:11 -0700 (PDT)
X-Received: by 2002:a2e:9654:: with SMTP id z20mr4923630ljh.52.1559664311655;
 Tue, 04 Jun 2019 09:05:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190603200301.GM28207@linux.ibm.com> <Pine.LNX.4.44L0.1906041026570.1731-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.1906041026570.1731-100000@iolanthe.rowland.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 4 Jun 2019 09:04:55 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgGnCw==uY8radrB+Tg_CEmzOtwzyjfMkuh7JmqFh+jzQ@mail.gmail.com>
Message-ID: <CAHk-=wgGnCw==uY8radrB+Tg_CEmzOtwzyjfMkuh7JmqFh+jzQ@mail.gmail.com>
Subject: Re: rcu_read_lock lost its compiler barrier
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
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

On Tue, Jun 4, 2019 at 7:44 AM Alan Stern <stern@rowland.harvard.edu> wrote:
>
> Even if you don't think the compiler will ever do this, the C standard
> gives compilers the right to invent read accesses if a plain (i.e.,
> non-atomic and non-volatile) write is present.

Note that for the kernel, it's not like we go strictly by what the
standard says anyway.

The reason for the "read for write" thing is that obviously you
sometimes have broken architectures (*cough*alpha*cough*) that need to
do some common writes are read-maskmodify-write accesses, and for
bitfields you obviously *always* have that issue.

In general, a sane compiler (as opposed to "we just read the
standard") had better not add random reads, because people might have
some mappings be write-only when the hardware supports it.

And we do generally expect sanity from our compilers, and will add
compiler flags to disable bad behavior if required - even if said
behavior would be "technically allowed by the standard".

> (Incidentally, regardless of whether the compiler will ever do this, I
> have seen examples in the kernel where people did exactly this
> manually, in order to avoid dirtying a cache line unnecessarily.)

I really hope and expect that this is not something that the compiler ever does.

If a compiler turns "x = y" into if (x != y) x = y" (like we do
manually at times, as you say), that compiler is garbage that we
cannot use for the kernel. It would break things like "smp_wmb()"
ordering guarantees, I'm pretty sure.

And as always, if we're doing actively stupid things, and the compiler
then turns our stupid code into something we don't expect, the
corollary is that then it's on _us_. IOW, if we do

    if (x != 1) {
         ...
    }
    x = 1;

and the compiler goes "oh, we already checked that 'x == 1'" and moves
that "unconditional" 'x = 1' into the conditional section like

    if (x != 1) {
        ..
        x = 1;
    }

then that's not something we can then complain about.

So our expectation is that the compiler is _sane_, not that it's some
"C as assembler".  Adding spurious reads is not ok. But if we already
had reads in the code and the compiler combines them with other ops,
that's on us.

End result: in general, we do expect that the compiler turns a regular
assignment into a single plain write when that's what the code does,
and does not add extra logic over and beyond that.

In fact, the alpha port was always subtly buggy exactly because of the
"byte write turns into a read-and-masked-write", even if I don't think
anybody ever noticed (we did fix cases where people _did_ notice,
though, and we might still have some cases where we use 'int' for
booleans because of alpha issues.).

So I don't technically disagree with anything you say, I just wanted
to point out that as far as the kernel is concerned, we do have higher
quality expectations from the compiler than just "technically valid
according to the C standard".

                   Linus
