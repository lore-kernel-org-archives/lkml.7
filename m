Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BE01C4CECD
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 17:41:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05B97214D9
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 17:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568655676;
	bh=aCMrJ+i1U2L9ga3d7x3U6QFYk5paiZATYxfrjnjeDps=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=PlcuhoHiWznk+lyzrRaobPjvVUMHuzjjQf+vWf6buwNyCucEL0BBwZYnimeYyUv5L
	 blr32fyJt+cFOi88FhxVxinS2BwoVqm1cJVrxr6L2wdy6nBj4SbjGzz3dNqOmUS0S2
	 WM5FhOYFL7U+YjMKWX8JCh2kKe/vr7cfxzWAh2Ec=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387633AbfIPRlI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 13:41:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:56140 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732173AbfIPRlH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 13:41:07 -0400
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A23A921670
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2019 17:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568655666;
        bh=aCMrJ+i1U2L9ga3d7x3U6QFYk5paiZATYxfrjnjeDps=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=lYeEnjAP0gZnfmmr3tgouSlde/2/caoZVH7Zgmk5yheiZBOY9Xc9mTZLF/Ip7T1ll
         E3RqCVTQKs5JnkPagw9ksF83RdI3AKV38Nl+V96vAZxF9KTZ3K93k3Lckcb/XQ9avK
         iq/9+svsqUZsQl26bfVBGhjNrF992t3He8AmcRYs=
Received: by mail-wr1-f50.google.com with SMTP id o18so279048wrv.13
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2019 10:41:06 -0700 (PDT)
X-Gm-Message-State: APjAAAW1/4wTUKhhMRC6NWpUh4n9yf5E4ptVFtdnRDILu4nwI9kIJqVn
        amVgYTA4lc9OHprQmR6sTIw/fFYOKCZGOEqRfHGyvg==
X-Google-Smtp-Source: APXvYqwLYY3AA/DH8sjvLRitpW3XH+Jf4PKJQkFGReAyNyuF0qAj3gUEkbrpkr90bSCklWmsRNNkeTwp6iq7cg4rcHM=
X-Received: by 2002:a5d:424c:: with SMTP id s12mr718627wrr.221.1568655665105;
 Mon, 16 Sep 2019 10:41:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190913072237.GA12381@zn.tnic> <CAHk-=wismo3SQvvKXg8j0W-eC+5Q-ctcYfr1QV3K-i90w5caBA@mail.gmail.com>
 <9dc9f1e6-5d19-167c-793d-2f4a5ebee097@rasmusvillemoes.dk> <20190913104232.GA4190@zn.tnic>
 <20190913163645.GC4190@zn.tnic> <3fc31917-9452-3a10-d11d-056bf2d8b97d@rasmusvillemoes.dk>
 <CAHk-=wjdpJ+VapXfoZE8JRUfvMb8JrVTZe0=TDFYZ-ke+uqBOA@mail.gmail.com>
In-Reply-To: <CAHk-=wjdpJ+VapXfoZE8JRUfvMb8JrVTZe0=TDFYZ-ke+uqBOA@mail.gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 16 Sep 2019 10:40:53 -0700
X-Gmail-Original-Message-ID: <CALCETrX8sR8ELEvUpdHug498dU6+MWSy_SagaRbuZZ9fkztmfw@mail.gmail.com>
Message-ID: <CALCETrX8sR8ELEvUpdHug498dU6+MWSy_SagaRbuZZ9fkztmfw@mail.gmail.com>
Subject: Re: [RFC] Improve memset
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Borislav Petkov <bp@alien8.de>,
        Rasmus Villemoes <mail@rasmusvillemoes.dk>,
        x86-ml <x86@kernel.org>, Andy Lutomirski <luto@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 16, 2019 at 10:25 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Mon, Sep 16, 2019 at 2:18 AM Rasmus Villemoes
> <linux@rasmusvillemoes.dk> wrote:
> >
> > Eh, this benchmark doesn't seem to provide any hints on where to set the
> > cut-off for a compile-time constant n, i.e. the 32 in
>
> Yes, you'd need to use proper fixed-size memset's with
> __builtin_memset() to test that case. Probably easy enough with some
> preprocessor macros to expand to a lot of cases.
>
> But even then it will not show some of the advantages of inlining the
> memset (quite often you have a "memset structure to zero, then
> initialize a couple of fields" pattern, and gcc does much better for
> that when it just inlines the memset to stores - to the point of just
> removing all the memset entirely and just storing a couple of zeroes
> between the fields you initialized).

After some experimentation, I think y'all are just doing it wrong.
GCC is very clever about this as long as it's given the chance.  This
test, for example, generates excellent code:

#include <string.h>

__THROW __nonnull ((1)) __attribute__((always_inline)) void
*memset(void *s, int c, size_t n)
{
    asm volatile ("nop");
    return s;
}

/* generates 'nop' */
void zero(void *dest, size_t size)
{
    __builtin_memset(dest, 0, size);
}

/* xorl %eax, %eax */
int test(void)
{
    int x;
    __builtin_memset(&x, 0, sizeof(x));
    return x;
}

/* movl $0, (%rdi) */
void memset_a_bit(int *ptr)
{
    __builtin_memset(ptr, 0, sizeof(*ptr));
}

So I'm thinking maybe compiler.h should actually do something like:

#define memset __builtin_memset

and we should have some appropriate magic so that the memset inline is
exempt from the macro.  Or maybe there's some very clever way to put
all of this into the memset inline function.  FWIW, this obviously
wrong code:

__THROW __nonnull ((1)) __attribute__((always_inline)) void
*memset(void *s, int c, size_t n)
{
    __builtin_memset(s, c, n);
    return s;
}

generates 'jmp memset'.  It's not entirely clear to me exactly what's
happening here.

--Andy
