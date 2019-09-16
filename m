Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 906F2C49ED7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 23:14:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F39D214D9
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 23:14:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568675645;
	bh=RFV8tAN00Kz44FNU9hmqQHgEoIVUG1TxC7m3LsBAClQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=iSeRWRbKX3dJXbqCg//JwyIlex9tRRjxFHZIOKWx2uorQS9kTxWTMu2uKJWPU4WjR
	 dAhXyxDyIbY6tBOgrsLqe3XlKVHXCAC+0IrU+OaZPkNYJ77ntUJ4y/M8BN1AHc/KuN
	 FsUiwaT2C1OuBV6wlX6OOyc2ZNevwEFfiSSfLdvY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732811AbfIPXOE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 19:14:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:44518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726649AbfIPXOE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 19:14:04 -0400
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 83A6D2171F
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2019 23:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568675642;
        bh=RFV8tAN00Kz44FNU9hmqQHgEoIVUG1TxC7m3LsBAClQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=LUFE8WENCVCj7dkzHa+oPoSR3tQFO1vbc8SAtKMLlJD9DPlmGpjKycm5HMO8PcPmd
         cvbosdNVbWjMqfv/gEAHvXv4kpIOOvRGFwab1nNlFnP/VSQQPD9MF7APa3A1yzwlyl
         vMrPOBRjVnNiyU78NVieafQ9o+KkYoxNGXCu2eGQ=
Received: by mail-wr1-f41.google.com with SMTP id i18so1066382wru.11
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2019 16:14:02 -0700 (PDT)
X-Gm-Message-State: APjAAAUDk79r/+05cyh3zYdaoadEkJUdBqFGJRzn+IKX8z8hmIID69cD
        i9OjrzZ1iCoKEZP5YicY5lMc8NmbFry5YpCQYpCPiQ==
X-Google-Smtp-Source: APXvYqwmT/FpPN87wsFrhr/UWZWsfxx0IDOd2ews787smlqkbpm3BpUzKDIXEMwesZ9ZfKkyvmn7TegvDdndyPOE/zE=
X-Received: by 2002:adf:fe0f:: with SMTP id n15mr559686wrr.343.1568675641000;
 Mon, 16 Sep 2019 16:14:01 -0700 (PDT)
MIME-Version: 1.0
References: <20190913072237.GA12381@zn.tnic> <CAHk-=wismo3SQvvKXg8j0W-eC+5Q-ctcYfr1QV3K-i90w5caBA@mail.gmail.com>
 <9dc9f1e6-5d19-167c-793d-2f4a5ebee097@rasmusvillemoes.dk> <20190913104232.GA4190@zn.tnic>
 <20190913163645.GC4190@zn.tnic> <3fc31917-9452-3a10-d11d-056bf2d8b97d@rasmusvillemoes.dk>
 <CAHk-=wjdpJ+VapXfoZE8JRUfvMb8JrVTZe0=TDFYZ-ke+uqBOA@mail.gmail.com>
 <CALCETrX8sR8ELEvUpdHug498dU6+MWSy_SagaRbuZZ9fkztmfw@mail.gmail.com> <CAHk-=whZJhU3c-djPcwCPyYh0y1YXKeyBuJZjq3CzW3v_YHgeg@mail.gmail.com>
In-Reply-To: <CAHk-=whZJhU3c-djPcwCPyYh0y1YXKeyBuJZjq3CzW3v_YHgeg@mail.gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 16 Sep 2019 16:13:48 -0700
X-Gmail-Original-Message-ID: <CALCETrUkBCh8h66pJCJtDGNtvhmVaNuppddsBLkQiHFoNrW-xg@mail.gmail.com>
Message-ID: <CALCETrUkBCh8h66pJCJtDGNtvhmVaNuppddsBLkQiHFoNrW-xg@mail.gmail.com>
Subject: Re: [RFC] Improve memset
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Borislav Petkov <bp@alien8.de>,
        Rasmus Villemoes <mail@rasmusvillemoes.dk>,
        x86-ml <x86@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 16, 2019 at 2:30 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Mon, Sep 16, 2019 at 10:41 AM Andy Lutomirski <luto@kernel.org> wrote:
> >
> > After some experimentation, I think y'all are just doing it wrong.
> > GCC is very clever about this as long as it's given the chance.  This
> > test, for example, generates excellent code:
> >
> > #include <string.h>
> >
> > __THROW __nonnull ((1)) __attribute__((always_inline)) void
> > *memset(void *s, int c, size_t n)
> > {
> >     asm volatile ("nop");
> >     return s;
> > }
> >
> > /* generates 'nop' */
> > void zero(void *dest, size_t size)
> > {
> >     __builtin_memset(dest, 0, size);
> > }
>
> I think the point was that we'd like to get the default memset (for
> when __builtin_memset() doesn't generate inline code) also inlined
> into just "rep stosb", instead of that tail-call "jmp memset".

Well, when I wrote this email, I *thought* it was inlining the
'memset' function, but maybe I just can't read gcc's output today.

It seems like gcc is maybe smart enough to occasionally optimize
memset just because it's called 'memset'.  This generates good code:

#include <stddef.h>

inline void *memset(void *dest, int c, size_t n)
{
    /* Boris' implementation */
    void *ret, *dummy;

    asm volatile("push %%rdi\n\t"
                     "mov %%rax, %%rsi\n\t"
                     "mov %%rcx, %%rdx\n\t"
                     "andl $7,%%edx\n\t"
                     "shrq $3,%%rcx\n\t"
                     "movzbl %%sil,%%esi\n\t"
                     "movabs $0x0101010101010101,%%rax\n\t"
                     "imulq %%rsi,%%rax\n\t"
                     "rep stosq\n\t"
                     "movl %%edx,%%ecx\n\t"
                     "rep stosb\n\t"
                     "pop %%rax\n\t"
                     : "=&D" (ret), "=c" (dummy)
                     : "0" (dest), "a" (c), "c" (n)
                     : "rsi", "rdx", "memory");

    return ret;
}

int one_word(void)
{
    int x;
    memset(&x, 0, sizeof(x));
    return x;
}

So maybe Boris' patch is good after all.
