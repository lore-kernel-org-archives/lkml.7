Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5D57C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 16:13:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B155621855
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 16:13:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="I0uLkbPI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731444AbfDEQNk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 12:13:40 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:43899 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730668AbfDEQNj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 12:13:39 -0400
Received: by mail-ua1-f66.google.com with SMTP id n16so2229123uae.10
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2019 09:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BLdxSuTueDbCPAAivyNm0J5L3vpNvr9FiKHHtWFZ1mI=;
        b=I0uLkbPIH3EU8HqlfnKmm0Pg+NXGaT7Jv6WzdxInxRP4XFcFW3lRKIH4eyw8ULngX/
         DPfMOUXKaCyRcjByp0I+u7jo9a3dI/Vt/CtHgxnBlRfTx1DNEFDL05aE6g7VSaDfjxFb
         Psh5Wyxx9CQcniUVw3TmvRUl2CUY47qqtP+h4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BLdxSuTueDbCPAAivyNm0J5L3vpNvr9FiKHHtWFZ1mI=;
        b=BExfdT3410XibvUQb3ORGalu8prXn6bNrRNm0LfLEANI2wQR5cFpGWMRlmgj02mxMK
         k8JW9qmIcXC/NpZicdOTqJAJeA+qPI7MrCRLE8wwnUw/oQQgskbjIJy0LzE01Pr2U6lT
         6dkvZYccA9/qEpusLrue5G7kNqbYuahayEGQmNm99lzW2ImkLeO1GWYVZRiaM/D2o+gY
         kiW5mWqVz9E9lXmgewBDJ50K22AP3mDJ3+C7lc0NC8zi166pJ43yWQC7bsd/vewQPhtp
         ChqnGgGzg5JCmG2DaOVkkqqqocwu8PSX8Mif6KSd3VAJojHqPl2LWUW3phRb2jX+57Kn
         gj/Q==
X-Gm-Message-State: APjAAAV9kPl20Sed48IFoCkI0YDi0PbkEzrYelejPdXWlPjW3mBZJtDa
        Ptj2QkcsE6G3tHoOymRzmm3hMdELV58=
X-Google-Smtp-Source: APXvYqx6tHtHBOjzTq7nO/yziZevk5vs257N/XXNHe+0nF7N7OcUD7C/pcbp1kf2hdR00AK54nF4RQ==
X-Received: by 2002:ab0:7493:: with SMTP id n19mr8158168uap.121.1554480817841;
        Fri, 05 Apr 2019 09:13:37 -0700 (PDT)
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com. [209.85.222.49])
        by smtp.gmail.com with ESMTPSA id j71sm11187219vsd.0.2019.04.05.09.13.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Apr 2019 09:13:36 -0700 (PDT)
Received: by mail-ua1-f49.google.com with SMTP id a46so2253378uae.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2019 09:13:36 -0700 (PDT)
X-Received: by 2002:ab0:154e:: with SMTP id p14mr8005747uae.48.1554480815790;
 Fri, 05 Apr 2019 09:13:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190405045711.30339-1-bp@alien8.de> <d2e7ee85-50a7-7026-82f9-2169656bd4f9@rasmusvillemoes.dk>
 <20190405075251.GC23348@zn.tnic> <3fefb03d-3ea0-5a08-f00c-09a47b17f2a8@rasmusvillemoes.dk>
 <20190405082447.GD23348@zn.tnic>
In-Reply-To: <20190405082447.GD23348@zn.tnic>
From:   Kees Cook <keescook@chromium.org>
Date:   Fri, 5 Apr 2019 09:13:24 -0700
X-Gmail-Original-Message-ID: <CAGXu5jK6+ZcJQqchySsMicEy-Kd=TFRTE1M_JdhX4TaJDAPiaQ@mail.gmail.com>
Message-ID: <CAGXu5jK6+ZcJQqchySsMicEy-Kd=TFRTE1M_JdhX4TaJDAPiaQ@mail.gmail.com>
Subject: Re: [PATCH] overflow.h: Rename __ab_c_size() to __calc_size()
To:     Borislav Petkov <bp@alien8.de>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        LKML <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 5, 2019 at 1:24 AM Borislav Petkov <bp@alien8.de> wrote:
>
> On Fri, Apr 05, 2019 at 10:09:31AM +0200, Rasmus Villemoes wrote:
> > On 05/04/2019 09.52, Borislav Petkov wrote:
> > > On Fri, Apr 05, 2019 at 08:26:45AM +0200, Rasmus Villemoes wrote:
> >
> > >> It computes a*b+c with overflow checking at each step. calc_size
> > >> is way too generic and doesn't say anything at all about how the
> > >> calc(ulation) is done.
> > >
> > > Ok, whatever.
> > >
> > > Then it would need at least a comment above it to state what it does. I
> > > don't want to go and parse the macros each time.
> >
> > It's an internal helper, and struct_size is fully kernel-doc'ed. But
> > yeah, a comment wouldn't hurt, and let's rename the parameters so they
> > match the abc naming.
> >
> > diff --git a/include/linux/overflow.h b/include/linux/overflow.h
> > index 40b48e2133cb..6534a727cadb 100644
> > --- a/include/linux/overflow.h
> > +++ b/include/linux/overflow.h
> > @@ -278,11 +278,15 @@ static inline __must_check size_t
> > array3_size(size_t a, size_t b, size_t c)
> >         return bytes;
> >  }
> >
> > -static inline __must_check size_t __ab_c_size(size_t n, size_t size,
> > size_t c)
> > +/*
> > + * Compute a*b+c, returning SIZE_MAX on overflow. Internal helper for
> > + * struct_size() below.
> > + */

May as well make this kern-doc too?

> > +static inline __must_check size_t __ab_c_size(size_t a, size_t b, size_t c)
> >  {
> >         size_t bytes;
> >
> > -       if (check_mul_overflow(n, size, &bytes))
> > +       if (check_mul_overflow(a, b, &bytes))
> >                 return SIZE_MAX;
> >         if (check_add_overflow(bytes, c, &bytes))
> >                 return SIZE_MAX;
> >
> >
>
> Reported-by: Borislav Petkov <bp@suse.de>
> Acked-by: Borislav Petkov <bp@suse.de>

Acked-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
