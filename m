Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC27FC432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 16:52:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE4AA20672
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 16:52:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YcLtVyut"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727444AbfKVQwS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 11:52:18 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:46632 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726620AbfKVQwS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 11:52:18 -0500
Received: by mail-pj1-f68.google.com with SMTP id a16so3260665pjs.13
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2019 08:52:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bIBZ/pDagkMXdQDKDvezMxRb4iRHYel+ahYnkHe//Mw=;
        b=YcLtVyutJTxK26Jq0OiYsnmEyoQyQFjeO7obWVSHlkjXGA69msCHJ1tBa8EQQRL9BJ
         jtOccOm7EWgUTRF7S9XJcsjIq0zkEfG/N3/29fz0xT/jA7K7rz5FtX7XAPEZ1CgnL2no
         9joKepTABeANY85Wb7q9PUBRCq6t16ZMupPEw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bIBZ/pDagkMXdQDKDvezMxRb4iRHYel+ahYnkHe//Mw=;
        b=H4Rw3xucKTn1t8o4vh3/DE52aQVyQ6LkPjGJUFwSg1Evz1QeFuUMVdEOkjXQwooT4a
         X86xyGal9XCLHhVqdtudafYu50IeofTwR3cLEJd3TuT043vPAQ18mB9Zyrh5Sr797cIy
         bsgCwuAQc+myhJCxxiXv+a0NnY3ucM/esmfkOMO9lVzafSQFmQUI/rkVbX4xNd0Tty0a
         oUdWmoq3YwpYMdleKvj5M7Cz7OFRwTetMX41yAljkzFrg/Z9dtK27unrHLsVbDEGjRkW
         6TIdku0Qk83lmnqJI0fvy4bGJxR3uekqa/WZ7dqju+DQni3MXR+86Cqbt26UEgngSAZ6
         pUww==
X-Gm-Message-State: APjAAAUqDt0rN/251OS1OjY6pU+cgZMsdsvVjulqYxZZMtiSf2VsyCg5
        N9hujsAPS5yHJNaRamuD9CFUDw==
X-Google-Smtp-Source: APXvYqzZwZG+BeFAjZyROOnizhpZkQHwGQ/kubJmglsdvzHe+7MOqzo4fPiO5n3oqh16frUICgp+OA==
X-Received: by 2002:a17:90a:de4:: with SMTP id 91mr20505683pjv.113.1574441537644;
        Fri, 22 Nov 2019 08:52:17 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u65sm8020297pfb.35.2019.11.22.08.52.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2019 08:52:16 -0800 (PST)
Date:   Fri, 22 Nov 2019 08:52:15 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Elena Petrova <lenaptr@google.com>,
        Alexander Potapenko <glider@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-hardening@lists.openwall.com,
        syzkaller <syzkaller@googlegroups.com>
Subject: Re: [PATCH v2 0/3] ubsan: Split out bounds checker
Message-ID: <201911220845.622FDC4@keescook>
References: <20191121181519.28637-1-keescook@chromium.org>
 <CACT4Y+b3JZM=TSvUPZRMiJEPNH69otidRCqq9gmKX53UHxYqLg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+b3JZM=TSvUPZRMiJEPNH69otidRCqq9gmKX53UHxYqLg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 22, 2019 at 10:07:29AM +0100, Dmitry Vyukov wrote:
> On Thu, Nov 21, 2019 at 7:15 PM Kees Cook <keescook@chromium.org> wrote:
> >
> > v2:
> >     - clarify Kconfig help text (aryabinin)
> >     - add reviewed-by
> >     - aim series at akpm, which seems to be where ubsan goes through?
> > v1: https://lore.kernel.org/lkml/20191120010636.27368-1-keescook@chromium.org
> >
> > This splits out the bounds checker so it can be individually used. This
> > is expected to be enabled in Android and hopefully for syzbot. Includes
> > LKDTM tests for behavioral corner-cases (beyond just the bounds checker).
> >
> > -Kees
> 
> +syzkaller mailing list
> 
> This is great!
> 
> I wanted to enable UBSAN on syzbot for a long time. And it's
> _probably_ not lots of work. But it was stuck on somebody actually
> dedicating some time specifically for it.
> Kees, or anybody else interested, could you provide relevant configs
> that (1) useful for kernel, (2) we want 100% cleanliness, (3) don't
> fire all the time even without fuzzing? Anything else required to
> enable UBSAN? I don't see anything. syzbot uses gcc 8.something, which
> I assume should be enough (but we can upgrade if necessary).

Nothing external should be needed; GCC and Clang support the ubsan
options. Once this series lands, it should be possible to just enable
this with:

CONFIG_UBSAN=y
CONFIG_UBSAN_BOUNDS=y
# CONFIG_UBSAN_MISC is not set

Based on initial testing, the bounds checker isn't very noisy, but I
haven't spun up a syzbot instance to really confirm this yet (that was
on the TODO list for today to let it run over the weekend).

-- 
Kees Cook
