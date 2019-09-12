Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A8A5C4CEC5
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 17:31:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5025C20830
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 17:31:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vFOuHT8q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387705AbfILRbK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Sep 2019 13:31:10 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43494 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726132AbfILRbK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 13:31:10 -0400
Received: by mail-pg1-f195.google.com with SMTP id u72so13822210pgb.10
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2019 10:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mOVlpD6BMnbKiv36TkrT6fFnE/GEkfURpkH4h7Nmx9A=;
        b=vFOuHT8q/eBPKZYTjetLEjaJe6yOUcZW5JGUf5OEuaCTw+ePR0nBx/f3HHUQTCUqQI
         uYEVVwDfqUnPrcGgKSPtyIog0m/i9gn62BCdJUEileXrg/ZTSjiDx2Dw/hL8T16b9Y2z
         0FN6cEQuRsDycs54vUgScb4QhncrgBaEBNq3q+p5H2XxkiGNy4DOPQeBGLB7P0MzTa74
         Ia81d7XZcCkQvsxt8p/jjS9gaBsnZxNDgj7JCztPVUzFz7K6h/sg7WeHsuBmxqLtDjwp
         gc5AdHdJRbIwx35Qv6FNrYeqD3KkACcMSRHgTN4HhTCWOg+6oEN4MQ9CT6EAuxZIXeCd
         eD8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mOVlpD6BMnbKiv36TkrT6fFnE/GEkfURpkH4h7Nmx9A=;
        b=uSLrkH9yf0huIuP8MCkDDHpsM6LIV3omQDYm8AQBSOyEA8ovcY9ResULg2eJOXWkGy
         YcLMHXMlHA8z8OxKIiGaQG9rAsID7OSKUiaWOyFNIQFCGf/2ljZGz4vrV3Yv9jozyT2m
         8y7Jbl4fsm0yQ1SIOO8a2FfZ9IxCLJIdnAEPVf9vCB5y9stsNnKHRNZTnLYAwdWJFkSC
         WPFjN4wk3TmSsEF9KriVt7dK7wVrvpe1H0EncBcxP2z4wILh/Y6me5F/2CeLlsVmfba3
         SCEgtsXiUc/NWVDNC8Fmpkt8rQIId1jZ5Coty4sBQuBQEIi5XEKc7ElGTJw1B4/Gzi1+
         LxpQ==
X-Gm-Message-State: APjAAAWJBjjrLzUsGaQaAgYL1eRIREci4w2gnrBOYcixhF6zFmEWxcZ5
        5/KaKQwDf/3VsWs0jwsiXnYCuXyRtD4OQCNsrqxM8Q==
X-Google-Smtp-Source: APXvYqyVEf0vry59fDuLYLixqQV/JiE2ffpPjCKBKhiAyDloxfQvSH0ffpD+0xZh3bmlSGzo28Pk/FqEMIBOISodWS0=
X-Received: by 2002:a63:7153:: with SMTP id b19mr3009136pgn.10.1568309468835;
 Thu, 12 Sep 2019 10:31:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190911182049.77853-1-natechancellor@gmail.com>
 <20190911182049.77853-4-natechancellor@gmail.com> <CAKwvOdnh+YoACaX4Oxk7ZiEQAQ2VgA6W=Dtbk7gzK5yJduFvGQ@mail.gmail.com>
 <20190912054304.GA103826@archlinux-threadripper>
In-Reply-To: <20190912054304.GA103826@archlinux-threadripper>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 12 Sep 2019 10:30:57 -0700
Message-ID: <CAKwvOdmc-1BrXG01d0PzjqhJsVbgwUMm6mxR4BcTqZ9WKtS6HA@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] powerpc/prom_init: Use -ffreestanding to avoid a
 reference to bcmp
To:     Nathan Chancellor <natechancellor@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 11, 2019 at 10:43 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> On Wed, Sep 11, 2019 at 02:01:59PM -0700, Nick Desaulniers wrote:
> > On Wed, Sep 11, 2019 at 11:21 AM Nathan Chancellor
> > <natechancellor@gmail.com> wrote:
> > >
> > > r370454 gives LLVM the ability to convert certain loops into a reference
> > > to bcmp as an optimization; this breaks prom_init_check.sh:
> > >
> > >   CALL    arch/powerpc/kernel/prom_init_check.sh
> > > Error: External symbol 'bcmp' referenced from prom_init.c
> > > make[2]: *** [arch/powerpc/kernel/Makefile:196: prom_init_check] Error 1
> > >
> > > bcmp is defined in lib/string.c as a wrapper for memcmp so this could be
> > > added to the whitelist. However, commit 450e7dd4001f ("powerpc/prom_init:
> > > don't use string functions from lib/") copied memcmp as prom_memcmp to
> > > avoid KASAN instrumentation so having bcmp be resolved to regular memcmp
> > > would break that assumption. Furthermore, because the compiler is the
> > > one that inserted bcmp, we cannot provide something like prom_bcmp.
> > >
> > > To prevent LLVM from being clever with optimizations like this, use
> > > -ffreestanding to tell LLVM we are not hosted so it is not free to make
> > > transformations like this.
> > >
> > > Link: https://github.com/ClangBuiltLinux/linux/issues/647
> > > Link: https://github.com/llvm/llvm-project/commit/5c9f3cfec78f9e9ae013de9a0d092a68e3e79e002
> >
> > The above link doesn't work for me (HTTP 404).  PEBKAC?
> > https://github.com/llvm/llvm-project/commit/5c9f3cfec78f9e9ae013de9a0d092a68e3e79e002
>
> Not really sure how an extra 2 got added on the end of that... Must have
> screwed up in vim somehow.
>
> Link: https://github.com/llvm/llvm-project/commit/5c9f3cfec78f9e9ae013de9a0d092a68e3e79e00

That looks better.  Assuming Michael doesn't mind amending the link
when applying:
Reviewed-by: Nick Desaulneris <ndesaulniers@google.com>

>
> I can resend unless the maintainer is able to fix that up when it gets
> applied.
>
> Cheers,
> Nathan



-- 
Thanks,
~Nick Desaulniers
