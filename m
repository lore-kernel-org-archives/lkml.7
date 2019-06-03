Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 634B1C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 15:55:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 381D227A91
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 15:55:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559577335;
	bh=tw9wzc5QZbl5hfqLZwsubXlTWF5UlQsUNTAIIK+a4Ok=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=TTUZK/txTT5GMMW4cQa+6d0vIQrqJ4BYHK9Qa66dAWcku4M7BpecQt3H2Ry+7e76d
	 l+rzuOvRPRU9q5tD9gXMWkJgs0tA78tu6T+Gw4Zt/cfSEynRofEuE99A4yiycPPab5
	 FoFZPB76XLxwQ+MqyT0kXy1L9kkQgRKD0kqzPb3I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729285AbfFCPze (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 11:55:34 -0400
Received: from mail-lf1-f41.google.com ([209.85.167.41]:34358 "EHLO
        mail-lf1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727164AbfFCPze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 11:55:34 -0400
Received: by mail-lf1-f41.google.com with SMTP id y198so3525914lfa.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2019 08:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GEvt8pGQEbFr4DBC3ZactO5sklI3XbY8H2zkXOcjs2g=;
        b=T1/m84q35iHVOMXlWw9a8KqEj4GwEOwLm06PoeEgn4nWnDGiSSZJiqTH54Nkz4QWfQ
         Eai3tdr9Z6bLfZm3CrxIY8OH3lKIsIpqVEb9uhG2g1I7juYcrS7cchRhE83PYLM0QaLt
         JDimS+ZheOBnr5JA+kS1fzrufMArQn4GLQAp8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GEvt8pGQEbFr4DBC3ZactO5sklI3XbY8H2zkXOcjs2g=;
        b=U5CN3JLd7/a03sCakzpNRCgHKIS6MZOg88mSXvRVvD0Q7FvaV3Kt1j2jC1ALnc/sFo
         M2Wb+Zjmp0bqvr/wNssV1MSPHu5cmBu3P5z9eDA06qeuE1wBixV0cOH5NlLHD5SbEwsn
         A4wAyyR2yWOOdKnGukc4Q5xfYKu/wraIfUi6OG5Tr2m5+7+jntaMg60yZOmxcLfD/8aq
         DBOWlpZqttQnwas2S+wH590h9Mm+O0XGf8w8EB3+isrlN0ljQ3n7ZV9vv2WbYQ/kZjRc
         WGJpBeoUbQifXzKr/VtZZiRqTfwz/4ZMykJJGzCUhAb6D1ZQ4k0X7WpRzSCT+YUVF4H5
         zyPQ==
X-Gm-Message-State: APjAAAWRzW5MBtDbPkij7YX+/dW64nIhghDww6OS7+lciuMIAfuY0mrp
        dpYIs3/y+eZRY7Ld0qaJDJlm5tJAFko=
X-Google-Smtp-Source: APXvYqzxhy4P5M006q/X8P0J1DxJCVuNODetb/BobzCJ4kbFcXgAmUv+ckXkxoRDeXvcN/gsM02YNg==
X-Received: by 2002:ac2:419a:: with SMTP id z26mr13667676lfh.122.1559577330924;
        Mon, 03 Jun 2019 08:55:30 -0700 (PDT)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id h23sm3253445ljf.28.2019.06.03.08.55.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Jun 2019 08:55:30 -0700 (PDT)
Received: by mail-lj1-f173.google.com with SMTP id i21so2166760ljj.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2019 08:55:29 -0700 (PDT)
X-Received: by 2002:a2e:85d1:: with SMTP id h17mr14153700ljj.1.1559577329451;
 Mon, 03 Jun 2019 08:55:29 -0700 (PDT)
MIME-Version: 1.0
References: <20150910005708.GA23369@wfg-t540p.sh.intel.com>
 <20150910102513.GA1677@fixme-laptop.cn.ibm.com> <20150910171649.GE4029@linux.vnet.ibm.com>
 <20150911021933.GA1521@fixme-laptop.cn.ibm.com> <20150921193045.GA13674@lerouge>
 <20150921204327.GH4029@linux.vnet.ibm.com> <20190602055607.bk5vgmwjvvt4wejd@gondor.apana.org.au>
 <20190603000617.GD28207@linux.ibm.com> <20190603030324.kl3bckqmebzis2vw@gondor.apana.org.au>
In-Reply-To: <20190603030324.kl3bckqmebzis2vw@gondor.apana.org.au>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 3 Jun 2019 08:55:13 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj2t+GK+DGQ7Xy6U7zMf72e7Jkxn4_-kGyfH3WFEoH+YQ@mail.gmail.com>
Message-ID: <CAHk-=wj2t+GK+DGQ7Xy6U7zMf72e7Jkxn4_-kGyfH3WFEoH+YQ@mail.gmail.com>
Subject: Re: rcu_read_lock lost its compiler barrier
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Fengguang Wu <fengguang.wu@intel.com>, LKP <lkp@01.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 2, 2019 at 8:03 PM Herbert Xu <herbert@gondor.apana.org.au> wrote:
>
> In any case, I am now even more certain that compiler barriers are
> not needed in the code in question.  The reasoning is quite simple.
> If you need those compiler barriers then you surely need real memory
> barriers.

So the above statement is not necessarily correct.

Compiler barriers very much can have real effects even in the absense
of "real" memory barriers.

But those effects are obviously not about multiple CPU's - they are
about code generation and can be about ordering on _one_ CPU. Those
effects definitely happen, though.

So a compiler barrier without a memory barrier may make a difference if you

 (a) compile for UP (when a compiler barrier basically _is_ a memory barrier)

 (b) have deadlock or ordering avoidance with only the local CPU
taking interrupts.

 (c) need to re-load a value in a loop, but ordering isn't a concern

and possibly other situations.

In the above, (a) may be pointless and trivial, but (b) and (c) are
issues even on SMP. Some things only matter for the local CPU - an
interrupt or a code sequence that happens on another CPU can just
block, but if an interrupt comes in on the same CPU may dead-lock and
depend on particular access ordering. And (c) is for things like
cpu_relax() in loops that read stuff (although honestly, READ_ONCE()
is generally a much better pattern).

But it sounds like in this case at least, Herbert's and Paul's
disagreements aren't really all that fundamentally about the memory
barriers and locking, as just the fact that in general the only thing
that RCU protects against is single accesses, and thus any RCU region
technically should use something that guarantees that the compiler
might not do stupid things.

We do require a _minimum_ of compiler sanity, but the compiler turning
a non-marked read into two reads has definitely happened, and can be
very subtle. Even if on a C level it looks like a single access, and
correctness doesn't care about _what_ the value we read is, it might
be turned by the compiler into two separate accesses that get two
different values, and then the end result may be insane and
unreliable.

So on the whole, I do think that it's usually a good idea to show
_which_ access is protected by RCU. Perhaps with a
READ_ONCE/WRITE_ONCE pattern, although it can be other things.

I don't believe that it would necessarily help to turn a
rcu_read_lock() into a compiler barrier, because for the non-preempt
case rcu_read_lock() doesn't need to actually _do_ anything, and
anything that matters for the RCU read lock will already be a compiler
barrier for other reasons (ie a function call that can schedule).

Anyway, I suspect the code is correct in practice, but I do have some
sympathy for the "RCU protected accesses should be marked".

                    Linus
