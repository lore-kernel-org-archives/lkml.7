Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E39F6C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 20:24:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A984D26E5D
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 20:24:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559593494;
	bh=qXfG/kRlOg9AJn5KW8vA80huXci7pB2VYlmD2Or08MU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=FhrGElN5uf99yHf9u9aMrkxRuLUOI+nNvYfpOUWeZH/9PuN6/aKxvZk3e77XAJrLD
	 hu51a7TA2xiV2X+x0pk30ZPk9xBaPys+5FesSAcCfrocigngwD/57GwVnN3yCSpqTO
	 /JGXNRYZ1+8ZXkBiXzAZUF4oLKcST9YHD87itSY0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726874AbfFCUYx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 16:24:53 -0400
Received: from mail-lj1-f180.google.com ([209.85.208.180]:39881 "EHLO
        mail-lj1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbfFCUYw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 16:24:52 -0400
Received: by mail-lj1-f180.google.com with SMTP id a10so14278941ljf.6
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2019 13:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u0bj5eMak8sMBiIk5v+RdqesL6i06Wpjl4vzJ82RYKU=;
        b=bGsk3ApGDZofDzGKFHvgiBN2+VdwbPx2ArHRIU4LNh7QQIwKy63JvZxImcCbDKyk8G
         kc4WjI69EAIRouwHENLzyO0GCNo2pwNo6/G88NTI5GZj89b/vNeksbJhCNhCr38YYv3C
         uPimuKUBbplSefi7zlDLj8BRg9cyvXFjvK5Lg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u0bj5eMak8sMBiIk5v+RdqesL6i06Wpjl4vzJ82RYKU=;
        b=eITw3Smc8METUi8ZHnxTr2WnrAxXp1JZ+/pCyjlVOKF8S/Qj6TwfvkabTt7bZPjuP9
         VVnPvDzsWsTWFXSZgY10W7baQN920pf2V/rs8wygyeYnsod3p1C0qt/RhKDvyLkKlvNl
         1b87Rl7Xs9gnczx7aTLq7QfjXCRi+oT67IZp6wYlB9MxRvTtzbgrQRKGEP+Kv7ATIbcd
         sUwInq0+5xMqMi8LCX4mumffOZ1pe8XmXfnA/32bOW1bq+6SnXkx1u3eG1f3/2Y9/p/B
         z3l7xTTdl2RgaPG6lKhDkLZPGcHeP76FoL4Io/UcGzuzpc7PwdI2m6pZZ7n1MwtpVwLl
         bzjQ==
X-Gm-Message-State: APjAAAWzZQX+Q+8v9vCxBKvi/H7kqdzEJP5DdQ4JtE32Z8DLiraOdonm
        0wAiWpMFSCCXj/985RS1jtDM/0ldd1U=
X-Google-Smtp-Source: APXvYqyfFLYJzJsw5yS4SZHNpNcBX+8/ldoKMNxddZERbAybjS4RlP7HJ2e08l7b3Qs2RX/hRxzMGQ==
X-Received: by 2002:a2e:9f41:: with SMTP id v1mr8434141ljk.66.1559593489647;
        Mon, 03 Jun 2019 13:24:49 -0700 (PDT)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id a4sm3342214lfj.31.2019.06.03.13.24.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Jun 2019 13:24:48 -0700 (PDT)
Received: by mail-lj1-f171.google.com with SMTP id j24so17548603ljg.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2019 13:24:48 -0700 (PDT)
X-Received: by 2002:a2e:85d1:: with SMTP id h17mr14759938ljj.1.1559593488055;
 Mon, 03 Jun 2019 13:24:48 -0700 (PDT)
MIME-Version: 1.0
References: <20150910102513.GA1677@fixme-laptop.cn.ibm.com>
 <20150910171649.GE4029@linux.vnet.ibm.com> <20150911021933.GA1521@fixme-laptop.cn.ibm.com>
 <20150921193045.GA13674@lerouge> <20150921204327.GH4029@linux.vnet.ibm.com>
 <20190602055607.bk5vgmwjvvt4wejd@gondor.apana.org.au> <20190603000617.GD28207@linux.ibm.com>
 <20190603030324.kl3bckqmebzis2vw@gondor.apana.org.au> <CAHk-=wj2t+GK+DGQ7Xy6U7zMf72e7Jkxn4_-kGyfH3WFEoH+YQ@mail.gmail.com>
 <CAHk-=wgZcrb_vQi5rwpv+=wwG+68SRDY16HcqcMtgPFL_kdfyQ@mail.gmail.com> <20190603195304.GK28207@linux.ibm.com>
In-Reply-To: <20190603195304.GK28207@linux.ibm.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 3 Jun 2019 13:24:32 -0700
X-Gmail-Original-Message-ID: <CAHk-=whXb-QGZqOZ7S9YdjvQf7FNymzceinzJegvRALqXm3=FQ@mail.gmail.com>
Message-ID: <CAHk-=whXb-QGZqOZ7S9YdjvQf7FNymzceinzJegvRALqXm3=FQ@mail.gmail.com>
Subject: Re: rcu_read_lock lost its compiler barrier
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
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

On Mon, Jun 3, 2019 at 12:53 PM Paul E. McKenney <paulmck@linux.ibm.com> wrote:
>
> I agree that !PREEMPT rcu_read_lock() would not affect compiler code
> generation, but given that get_user() is a volatile asm, isn't the
> compiler already forbidden from reordering it with the volatile-casted
> WRITE_ONCE() access, even if there was nothing at all between them?
> Or are asms an exception to the rule that volatile executions cannot
> be reordered?

Paul, you MAKE NO SENSE.

What is wrong with you?

I just showed you an example of where rcu_read_lock() needs to be a
compiler barrier, and then you make incoherent noises about
WRITE_ONCE() that do not even exist in that example.

Forget about your READ_ONCE/WRITE_ONCE theories. Herbert already
showed code that doesn't have those accessors, so reality doesn't
match your fevered imagination.

And sometimes it's not even possible, since you can't do a bitfield
access, for exmaple, with READ_ONCE().

> We can of course put them back in,

Stop the craziness. It's not "we can". It is a "we will".

So I will add that barrier, and you need to stop arguing against it
based on specious theoretical arguments that do not match reality. And
we will not ever remove that barrier again. Herbert already pointed to
me having to do this once before in commit 386afc91144b ("spinlocks
and preemption points need to be at least compiler barriers"), and
rcu_read_lock() clearly has at a minimum that same preemption point
issue.

                     Linus
