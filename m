Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F2DFCA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 18:33:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6835E20869
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 18:33:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O7PltKw1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505831AbfJRSdH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 14:33:07 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:42253 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502579AbfJRSdG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 14:33:06 -0400
Received: by mail-lf1-f65.google.com with SMTP id z12so5420003lfj.9
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 11:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GbeDXmo9y5jCjWaekiMahqEUs5l1VadqHf+/T7BBGBs=;
        b=O7PltKw1VMi2RMM6PRtWFNe7pkAjXUVERibQ18qTBqg7hBcss0b4ODK8OPurRIOyua
         XPNO9lzWQL2sUCEhn5yIUWxen7VKw9wyTrwnHMKPZjCRfIiXPFfWEAVvv4QRuiFlh5t+
         pDRldcEsIeZnSgRVmFGygqa8PjlBtiqr3OTvL/LcpFDouIoV77L0apIZSU2+TZrDMUpN
         J+BIMIzJe4Gnl2MdVigjlwfITa9bcZsVYbInVJd7VmqoxFJ+R1oQWwmYYSQ+CRxNdp2b
         XI5aTFXOgs9ze9UHzbxQYe24jao6bo43OiCrhgGontQOfGlZavqZSXXnyWO9GEdwqm9A
         B7LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GbeDXmo9y5jCjWaekiMahqEUs5l1VadqHf+/T7BBGBs=;
        b=ewtgxWtwu4WzUkSgK9JBnIlD7GS/OWV4Cb1k9p4aGjSWzm2nN2s2Zjr/vGi5UOtOm8
         n+0/2vX6fiD9tmo2/BohaEYJB4o+9aGGWsiXAxZMnl83oAMQcj+yCtX5JDof8p5elWCw
         kleHZKYK4aFoOV7u+KLMGzfx0jSXJKHFirfhZviAjIe3S7S2x9B4oqXhgvcaVHNntK/9
         kWWnJFfbu3QK6mg96qel+IravZSzZw7xDir3Cv/OFtAxqbVw+f+PezK/0YEx+n5kiAHO
         M1Ewb7EZO/VSrBU9G1s6uSwjpotVRH0onI96/KNQV+AZY1qiHHbgWENTt/jhgfOn1+LD
         TjUg==
X-Gm-Message-State: APjAAAWW7S3PS73xa1fwgUNUy6bFL62FCPwDawIeMCffDz/wnBiWbrpc
        GzrKzV6O+Rj4PVRzaZJDe3+GwJclAb7jjkmTzf0=
X-Google-Smtp-Source: APXvYqwxRkqeBTGe2ipFXhHWevOzmHfCv3O5pvZN9gCYzK7L+ln0quOJ8iSVEtAb24QIwyqCIFqfSWgnDz92fMJhPwc=
X-Received: by 2002:ac2:55b4:: with SMTP id y20mr6942077lfg.173.1571423584708;
 Fri, 18 Oct 2019 11:33:04 -0700 (PDT)
MIME-Version: 1.0
References: <20191018161033.261971-1-samitolvanen@google.com>
 <20191018161033.261971-7-samitolvanen@google.com> <CAKwvOd=z3RxvJeNV1sBE=Y1b6HgXdnT4M9bwMrUNZcvcSOqwTw@mail.gmail.com>
 <CABCJKud6+F=yhTo6xTXkHhtLWcSE99K=NcfKW_5E4swS4seKMw@mail.gmail.com>
In-Reply-To: <CABCJKud6+F=yhTo6xTXkHhtLWcSE99K=NcfKW_5E4swS4seKMw@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Fri, 18 Oct 2019 20:32:53 +0200
Message-ID: <CANiq72=PSzufQkW+2fikdDfZ5ZR1sw2epvxv--mytWZkTZQ9sg@mail.gmail.com>
Subject: Re: [PATCH 06/18] add support for Clang's Shadow Call Stack (SCS)
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Dave Martin <Dave.Martin@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Laura Abbott <labbott@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 18, 2019 at 7:11 PM Sami Tolvanen <samitolvanen@google.com> wrote:
>
> On Fri, Oct 18, 2019 at 10:08 AM 'Nick Desaulniers' via Clang Built
> Linux <clang-built-linux@googlegroups.com> wrote:
> > > diff --git a/include/linux/compiler-clang.h b/include/linux/compiler-clang.h
> > > index 333a6695a918..9af08391f205 100644
> > > --- a/include/linux/compiler-clang.h
> > > +++ b/include/linux/compiler-clang.h
> > > @@ -42,3 +42,5 @@
> > >   * compilers, like ICC.
> > >   */
> > >  #define barrier() __asm__ __volatile__("" : : : "memory")
> > > +
> > > +#define __noscs                __attribute__((no_sanitize("shadow-call-stack")))
> >
> > It looks like this attribute, (and thus a requirement to use this
> > feature), didn't exist until Clang 7.0: https://godbolt.org/z/p9u1we
> > (as noted above)
> >
> > I think it's better to put __noscs behind a __has_attribute guard in
> > include/linux/compiler_attributes.h.  Otherwise, what will happen when
> > Clang 6.0 sees __noscs, for example? (-Wunknown-sanitizers will
> > happen).
>
> Good point, I'll fix this in v2. Thanks.

+1, please CC whenever you send it!

Cheers,
Miguel
