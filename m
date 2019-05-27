Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDFA3C04AB3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 18:56:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C244520859
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 18:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558983396;
	bh=L5aI8i25E9hftYdByGBKgB27z5kbCClcb1unYttGWwQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=U9cu29649wZ4bPuMKLObjxqJxhouMNb+Aaot7iz0htydtnpqbIcagHKDfWGzxnTpu
	 PmuyeC/tB2XoVjeBcathrWq71l3njb60jnz2JEpBkZQn1iILsILiQZKx1nm9EsWetQ
	 r+XBfJkNMeC/AIwR6caAkWGUHkPL0IiBgpLNTjjA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727327AbfE0S4f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 14:56:35 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:40711 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726855AbfE0S4f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 14:56:35 -0400
Received: by mail-lj1-f194.google.com with SMTP id q62so15466010ljq.7
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2019 11:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0M9+CuFDRY6zmkTMsFyEFGMzc2pk/FXTc+geD/xhgG8=;
        b=IDb/hbyQgY21nuV2LBO2TNOaRE38NoV5Q4XHoHqiTOvqshvusynIuDSsYkw9iF2nFD
         P22g7ZqLtG4bPc/b2ghLW9uSs/wM+jeoVRHpYQ6vVG+QMJM/0QapWZU445OWqOUdACPp
         nxGsQsTufyxMtNW4p9qkFejvax39+NRHIkUz0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0M9+CuFDRY6zmkTMsFyEFGMzc2pk/FXTc+geD/xhgG8=;
        b=hCuLIlmdYdi5Ib4264KpNo1G70bzvYT7e6jQBSUBVbSaY9jqWF3vr6wQ/mnliAkiyw
         fA4SwwU+kXoQ9Yly31c7XTKxUeJd0xLJT+7WHz18r6Bh6EIb8vH85cjhSx1uDehuINjv
         M84m+ee11d9ff85XLPQnekFQIS3ekigL8f0VpX1ue9ISHa+JtbM/x786tWjrIXx9peMC
         CEvFuWZzJcliWiVcmgc83wbcLjmLz4H1cssoOeEoF8Cjtod8G35jl3EbQoNEWRGoRbO8
         CptJQv7I3BclN/WQiGSU0/yKN0FgwWy0OmddZg9j9tlbT9fnQ+VlcxEsqwF9R7bSy21Z
         XAeA==
X-Gm-Message-State: APjAAAX34ke6Z/DxhYUsioichZgiMzqOZPVaF6gQSKTLy5x21zZ7Voc4
        ZKdP2SmC7nh3Jg7XfpBnsbSrqPPKuWI=
X-Google-Smtp-Source: APXvYqzMjhd7wNT1DJcaz+zaGaD9kkgy0sqMDExqqnSAHN5mMnI0atyMJXVJ1xTSXsrGF0jdzy564A==
X-Received: by 2002:a2e:9897:: with SMTP id b23mr47775537ljj.157.1558983393116;
        Mon, 27 May 2019 11:56:33 -0700 (PDT)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id v12sm2451382ljv.49.2019.05.27.11.56.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 May 2019 11:56:32 -0700 (PDT)
Received: by mail-lf1-f42.google.com with SMTP id b11so6332812lfa.5
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2019 11:56:32 -0700 (PDT)
X-Received: by 2002:a19:ae01:: with SMTP id f1mr21133934lfc.29.1558982909294;
 Mon, 27 May 2019 11:48:29 -0700 (PDT)
MIME-Version: 1.0
References: <20190526102612.6970-1-christian@brauner.io> <20190526102612.6970-2-christian@brauner.io>
 <CAK8P3a1Ltsna_rtKxhMU7X0t=UOXDA75tKpph6s=OZ4itJe7VQ@mail.gmail.com>
 <20190527104528.cao7wamuj4vduh3u@brauner.io> <CAK8P3a3q=5Ca0xoMp+kyCvOqNDRzDTgu28f+U8J-buMVcZcVaw@mail.gmail.com>
 <20190527123414.rv2r6g6de6y3ay6w@brauner.io>
In-Reply-To: <20190527123414.rv2r6g6de6y3ay6w@brauner.io>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 27 May 2019 11:48:13 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgixXANa=2U0AeKud9zk9XvaV4mVRNNpkOWKpy+uuvtsg@mail.gmail.com>
Message-ID: <CAHk-=wgixXANa=2U0AeKud9zk9XvaV4mVRNNpkOWKpy+uuvtsg@mail.gmail.com>
Subject: Re: [PATCH 2/2] arch: wire-up clone6() syscall on x86
To:     Christian Brauner <christian@brauner.io>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-ia64@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jann Horn <jannh@google.com>,
        Florian Weimer <fweimer@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        David Howells <dhowells@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Adrian Reber <adrian@lisas.de>,
        Linux API <linux-api@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 27, 2019 at 5:34 AM Christian Brauner <christian@brauner.io> wrote:
>
> Afaict, stack_size is *only* used on ia64:

That's because ia64 "stacks" are an odd non-stack thing (like so much
of the architecture).

In computer science, a stack is a FIFO that grows/shrinks according to
use. In practical implementations, it also has a direction, but the
"size" is basically not relevant if you just allow it to grow
dynamically. The key word here being "dynamically": the stack size is
inherently a dynamic thing.

So you don't really need a "stack size". The whole concept doesn't
make sense, outside of the obvious maximum limit things (ie
RLIMIT_STACK) and simply just hitting other allocations.

But ia64 is "special".

The ia64 stack isn't actually a stack. It's *two* stacks, growing in
opposite directions. One for the hardware spilling of the register
state and call frame ("backing store"), and one for the traditional
software stack.

So on ia64, the stack size suddenly becomes a fixed thing, because
it's not a dynamically growing single stack that grows in one
direction, it's literally a fixed virtual area that has two different
stacks growing towards each other.

Btw, don't get me wrong. Two stacks can be a good thing, and a lot of
security people want to have two stacks - one for actual call frame
data, and a separate one for automatic stack variables that have their
address taken.

Having separate stacks avoids the whole traditional stack smash model
(well, it avoids the one that overwrites the return frame - you can
still possibly have security issues because one function smashes the
automatic stack of a caller and then cause the caller to be confused
and do something insecure).

And the ia64 double stack kind of works that way automatically. So
"double stack" very much isn't wrong per se, but doing it the way ia64
did was too inflexible and the register stack (and rotation) was and
is just a bad idea.

Two stacks without the hw register renaming and flushing can be
lovely, and can even merit some hw support (ie the whole "Shadow
stack" model).

              Linus
