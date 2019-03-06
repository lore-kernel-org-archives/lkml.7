Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 709F8C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 14:41:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F10320684
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 14:41:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G3eWUF9U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728689AbfCFOlE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 09:41:04 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:50195 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727002AbfCFOlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 09:41:04 -0500
Received: by mail-it1-f193.google.com with SMTP id m137so9832704ita.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2019 06:41:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2lV2u57T8FOZ+tpvKEJa7Mhcrj9ptx5lM3am8uKpk4U=;
        b=G3eWUF9U3OzBH24RPUo6iKJp7pG+Vd0aidROWqBXBWZA4l1weOjikI7wcFqertHhhC
         TBOjo5SUcsd75QES+zb6puSFTORgoqscm0BS3vt36A14M1pvEto9OtxvXsYZLyjDHv5X
         8Z2eqCBGy0AjM3MwTG6WKslSv62IEYcMjLVOCInDwQJpwL5PagTzYkPLe9ShiOxG80Ip
         t6qOazo8AAWnV+4CgykEyATlsUDvk+yUMZeS81NITcXDI0WttuGpX3EaW3jsS23qXF/w
         CAyWXYgXr3iwBNBjk+mtX5ipaR0peEmlEJk6TqZJfc3g4/w6V6dO7YM3jlBrsu8AGb8F
         /xqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2lV2u57T8FOZ+tpvKEJa7Mhcrj9ptx5lM3am8uKpk4U=;
        b=SHrZKS0tMc0dU71/XTl1mt1qcS/46JBgSgodGxN3Cad6FoDQR+sPYMc1tZ3Jh7S8rj
         cMB838E0q/gz7Y4ThvOa89NB8TJNeS5/klvHHr/x0U0dQpCze8/YSLxNyn8MZRpNnhsf
         o96YgzO/usoP/IS2B86u+npbrD8Sbz19QRFHay/EjCG+aFrl8u2twLyUa798W4vwlThq
         js/OBRyOBviloagPJciN0qTig3WBrIDyrdpPgtoY3klvJsbZz8BX2LoQxnDlz3lsDzW9
         uZKh6smfi3GDw1zolGMbXsNKLJ1RlmtdRvYnzdrhHd3ls2xHrm+TQ21AC5317FjjHL4K
         Vi6Q==
X-Gm-Message-State: APjAAAV3WDv72ekvyqc/s9p0ELZmlaSZEiKeUKAjTKYCGLGffqvIptzf
        PEZHwewxsVNTAzZW0/BdjJ9wo/Xm2b1k0pm+vmk4Tw==
X-Google-Smtp-Source: APXvYqznVigAZDVXFvgu61vBNM5uVkbsKQhiy7yE5EuTOzAccbtGtYonhIs3Bii2YSg+EWt89odt8j0WaV7FYxdEDcI=
X-Received: by 2002:a24:3b01:: with SMTP id c1mr1929623ita.144.1551883262584;
 Wed, 06 Mar 2019 06:41:02 -0800 (PST)
MIME-Version: 1.0
References: <20190228150152.078767622@infradead.org> <CACT4Y+b0WyE5En7BVipZiCMmMaj30kaEu3T68H7+-kVP8gqADA@mail.gmail.com>
 <20190301144556.GY32477@hirez.programming.kicks-ass.net> <CACT4Y+ZyXAJiKtzoWxY-u7e9HaL7iM9tnFXnFZd7Hdy4uHEOyA@mail.gmail.com>
 <20190301152305.GJ32494@hirez.programming.kicks-ass.net> <20190306131347.GX32534@hirez.programming.kicks-ass.net>
 <CACT4Y+YFkDRwTN1MKqLDePfuRis3Qas1kgEF7g5eVR0ijodtkw@mail.gmail.com>
 <20190306135728.GV32477@hirez.programming.kicks-ass.net> <CACT4Y+YP+Xn3TxVXrza_LBK8m7CCKBUYWpuGS0+MzFCXEE+Akg@mail.gmail.com>
 <20190306141237.GW32477@hirez.programming.kicks-ass.net> <20190306143439.GY32534@hirez.programming.kicks-ass.net>
In-Reply-To: <20190306143439.GY32534@hirez.programming.kicks-ass.net>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 6 Mar 2019 15:40:51 +0100
Message-ID: <CACT4Y+YmQBc67hU2exY5=tAVG1jWNUeZ7FAm+GGgqDvOH7cu1A@mail.gmail.com>
Subject: Re: [PATCH 1/8] kasan,x86: Frob kasan_report() in an exception
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Ingo Molnar <mingo@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>, valentin.schneider@arm.com,
        Brian Gerst <brgerst@gmail.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 6, 2019 at 3:34 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Wed, Mar 06, 2019 at 03:12:37PM +0100, Peter Zijlstra wrote:
> > On Wed, Mar 06, 2019 at 03:01:33PM +0100, Dmitry Vyukov wrote:
> > > On Wed, Mar 6, 2019 at 2:57 PM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > > > I've not found callers of __asan_report_load* with AC=1 in the kernel
> > > > yet. Under what condtions does GCC emit calls to these functions?
> > >
> > > CONFIG_KASAN_INLINE=y
> > > Then compiler inlines fast path into generated code and only calls
> > > into runtime to report errors (also, faster, this should be a default
> > > for anything other than tiny ROM controllers).
> >
> > *sigh*, clearly I've not build enough kernels yet... Lemme go try that.
>
> mm/kasan/generic_report.o: warning: objtool: __asan_report_load1_noabort()+0x0: call to __fentry__() with UACCESS enabled
>
> You want to do:
>
> CFLAGS_REMOVE_f= -pg
>
> like generic.o has?

This should not matter for KASAN itself.
KASAN will call into function tracer, and function tracer will call
into KASAN, but unless function tracer is badly broken and causes a
KASAN report on every invocation, the recursion will end (function
tracer will get to the _report_ function). So we only disabled -pg for
fast paths.
But if it makes things simpler for the objtool, then I think we can
disable function tracer for generic_report.c too.
