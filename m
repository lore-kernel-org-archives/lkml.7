Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DECA3C49ED7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 23:26:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6E37214AF
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 23:26:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568676403;
	bh=rZVgg/YXviDNVIvFpf8K7wV6JByynpldVjnSC+Ik+cw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=G/hiUL4Vh1c9td6Dg55ho5sZedffgRrS01uJrIUNInYBN3Kr4bkvi7PKYuC5+kCvM
	 WcggumdS2s7kvqahq1ewRMd1BpEAeIXeE+CCXlGFF7omXwkbKt9fV/gGoCYfL9BOQ7
	 FeyiETS4FOeaxgyzmurONQlSNB5uX3psOiILoGO4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388225AbfIPX0m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 19:26:42 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:46699 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727296AbfIPX0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 19:26:42 -0400
Received: by mail-lj1-f193.google.com with SMTP id e17so1503435ljf.13
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2019 16:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E3AifJka0WH3TNUz39kekLnY0BYRUhm027YZs0bTau4=;
        b=Fcnexcbmqxc9hlTD8moElunKXU89PjAgpQ9ZjFZB+MQQXNo+0oCJPgdSHOeaO5CQ3N
         dBEY/GR7sF7b3qS1I9aU1hZqM5ixulnBbvLEP1vZuY7iTJWfaHLC0RBHLfX15XdtHaIx
         y865/wSwuU+yYbC0RxjKz2M5e0Dh5WkCre2sc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E3AifJka0WH3TNUz39kekLnY0BYRUhm027YZs0bTau4=;
        b=d6mXUZu/DcUAUw5AbUuYkq7ApyXwX0ttoFv1RwkOAOVzRIWf2UjVW3B6QtjocqlG5D
         FYyNaDD3oP8AorF0i0T6NsD4Ntd4w2ZHcW86rsp2qjZ5jB3DkO5zPvpUJc9R2UiqCobj
         7dFL+jLUuwpXMRGy6oCwmAbfFgT/j8tpeYXKqt5RUzWhZKJPHJ2jZempMYViafUCiv+6
         5kVu6ncxL8GHGDhqgPlD5DgHiLY2+udhcPuDu0u7py63+bhzQbbbg1Dlb9mQdLY4Px3l
         +GB4uE7yhfRDTYNcWeMYksLIyN7sS3S6gSmdGruw+BgKou28x8nCE5SNMBp1eix4oXwI
         WVkw==
X-Gm-Message-State: APjAAAVmM1BQ3l6fR6Aajhu0jWVmFe7JrlF3R/IAXxE5cgNkeJZgP5JI
        B6RISTOCdG2K1tHv+Cxsa/lS9Cbtqo8=
X-Google-Smtp-Source: APXvYqwLZxXZqXSAEmv1wlg/Jklo/Z+fYc+WCZcO2hCfUBlKV5LIgTu+5c5DI7LXN3X+0uzBd7UIqg==
X-Received: by 2002:a2e:9a18:: with SMTP id o24mr182800lji.123.1568676399518;
        Mon, 16 Sep 2019 16:26:39 -0700 (PDT)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id y204sm46400lfa.64.2019.09.16.16.26.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Sep 2019 16:26:38 -0700 (PDT)
Received: by mail-lj1-f175.google.com with SMTP id y23so1565750ljn.5
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2019 16:26:38 -0700 (PDT)
X-Received: by 2002:a2e:5b9a:: with SMTP id m26mr197851lje.90.1568676398001;
 Mon, 16 Sep 2019 16:26:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190913072237.GA12381@zn.tnic> <CAHk-=wismo3SQvvKXg8j0W-eC+5Q-ctcYfr1QV3K-i90w5caBA@mail.gmail.com>
 <9dc9f1e6-5d19-167c-793d-2f4a5ebee097@rasmusvillemoes.dk> <20190913104232.GA4190@zn.tnic>
 <20190913163645.GC4190@zn.tnic> <3fc31917-9452-3a10-d11d-056bf2d8b97d@rasmusvillemoes.dk>
 <CAHk-=wjdpJ+VapXfoZE8JRUfvMb8JrVTZe0=TDFYZ-ke+uqBOA@mail.gmail.com>
 <CALCETrX8sR8ELEvUpdHug498dU6+MWSy_SagaRbuZZ9fkztmfw@mail.gmail.com>
 <CAHk-=whZJhU3c-djPcwCPyYh0y1YXKeyBuJZjq3CzW3v_YHgeg@mail.gmail.com> <CALCETrUkBCh8h66pJCJtDGNtvhmVaNuppddsBLkQiHFoNrW-xg@mail.gmail.com>
In-Reply-To: <CALCETrUkBCh8h66pJCJtDGNtvhmVaNuppddsBLkQiHFoNrW-xg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 16 Sep 2019 16:26:20 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiw6q1hk7QHP+8M6H9zRDj-yJ8p-KyhQS9gTJA8NopYkA@mail.gmail.com>
Message-ID: <CAHk-=wiw6q1hk7QHP+8M6H9zRDj-yJ8p-KyhQS9gTJA8NopYkA@mail.gmail.com>
Subject: Re: [RFC] Improve memset
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Borislav Petkov <bp@alien8.de>,
        Rasmus Villemoes <mail@rasmusvillemoes.dk>,
        x86-ml <x86@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 16, 2019 at 4:14 PM Andy Lutomirski <luto@kernel.org> wrote:
>
> Well, when I wrote this email, I *thought* it was inlining the
> 'memset' function, but maybe I just can't read gcc's output today.

Not having your compiler, it's also possible that it works for you,
but just doesn't work for me.

> It seems like gcc is maybe smart enough to occasionally optimize
> memset just because it's called 'memset'.  This generates good code:

Yup, that does the rigth thing for me and ignores the definition of
memset() in favor of the built-in one.

However, at least part of this discussion started because of the
reverse problem (turning a couple of assignments into memset), and the
suggestion that we might be able to use -ffreestanding together with

  #define memset __builtin_memset

and then your nice code generation goes away, because the magical
treatment of memset goes away. I get

        one_word:
                xorl    %eax, %eax
                ret

        not_one_word:
                movq    %rsi, %rdx
                xorl    %esi, %esi
                jmp     memset

despite having that "inline void *memset()" definition.

             Linus
