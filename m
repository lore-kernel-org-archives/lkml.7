Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B573FC10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 23:09:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8339020674
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 23:09:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DgmgGSxm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728585AbfDWXJV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 19:09:21 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:42560 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726339AbfDWXJU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 19:09:20 -0400
Received: by mail-ua1-f66.google.com with SMTP id h4so5368456uaj.9
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 16:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IiKDqG7msKFJ8+FEDkvRj7+3/awlR2j/mKLsb7NA8C8=;
        b=DgmgGSxmK0K6BTKDzWv4l6hC0tp0klvsPSgi3Xd35V0OBwL2G04gvXaluVqLlfeHMB
         ImZAAUyM/eTe+ApvyqCJUMJOKhtYantilOsu/zrkLSOGv3VcOCgoXvDcKkDSmemY6aaL
         8BIBF8N+rd7ZxAgCf7XvX3rA7izpW7bwJ55Xo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IiKDqG7msKFJ8+FEDkvRj7+3/awlR2j/mKLsb7NA8C8=;
        b=pOLxH0CpR5GJ1t5q3WSQebJvcfbysXPErYALtond2zpAG8afDosgQOZ7y5XusAm5Hb
         Lb/Qhicbob+a+L/lw9SxHGPEnExG6/aUqfDqi6nQFXiVZPLfQejYJYlWYomliPw+AISv
         jeHKO6xSLwZcxCG60JuVfdICFOyHkOaStQD2i+/m58LM5ZTPFUgCGBo1doJK9ahhz+hD
         HSfqPYJeNbTZG9tsqxc9BuOpZPUDyJHvd6yhhA3ju/TehvPg3Kfswq6OFtq4QQ7EYXgK
         CCfQ/lhT9np8ukyDc7dVj9jbRF5WO4pwCKMvdDrATIsDWj5aRNcw2C11CHhSqgagv/Av
         /xyw==
X-Gm-Message-State: APjAAAUzqgzeFKx6uP0bKbjEtd+hOC4fdeAW1N5PPW3MeuC183TJXmES
        u9XFHC6racSWEydcwTzHHIHoC4S4oqU=
X-Google-Smtp-Source: APXvYqy49ssS+13X//ENe+t/PrGlgjaaX/eRejxr597AM/KPhDz4wp61VAwCHNgqIXpCy2YQW2oXBg==
X-Received: by 2002:ab0:2248:: with SMTP id z8mr14523049uan.12.1556060959216;
        Tue, 23 Apr 2019 16:09:19 -0700 (PDT)
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com. [209.85.217.54])
        by smtp.gmail.com with ESMTPSA id k65sm4970661vkk.40.2019.04.23.16.09.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Apr 2019 16:09:18 -0700 (PDT)
Received: by mail-vs1-f54.google.com with SMTP id w13so9303645vsc.4
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 16:09:18 -0700 (PDT)
X-Received: by 2002:a67:eecb:: with SMTP id o11mr15373188vsp.66.1556060957745;
 Tue, 23 Apr 2019 16:09:17 -0700 (PDT)
MIME-Version: 1.0
References: <20190415143821.GA46880@beast> <CAGXu5jJmJLc41XDyaO3vSt=fPXLpph3m3TEtxAtdBiFMKqSrcA@mail.gmail.com>
 <CAKv+Gu-ZxvK7L90Xkf=U=GEeucGg9qJ+TDabuguFCxeUbn_GeQ@mail.gmail.com> <CAKwvOdn3DA9HbtQ7ZAXeamdmoRn+_kYn2DdQXX9oxt+nruz0kw@mail.gmail.com>
In-Reply-To: <CAKwvOdn3DA9HbtQ7ZAXeamdmoRn+_kYn2DdQXX9oxt+nruz0kw@mail.gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 23 Apr 2019 16:09:05 -0700
X-Gmail-Original-Message-ID: <CAGXu5j+9FFV-qoeXczhkTYiwuXcX+urmAU2eazk26XCdN476KA@mail.gmail.com>
Message-ID: <CAGXu5j+9FFV-qoeXczhkTYiwuXcX+urmAU2eazk26XCdN476KA@mail.gmail.com>
Subject: Re: [PATCH v3] arm64: sysreg: make mrs_s and msr_s macros work with
 Clang and LTO
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Alex Matveev <alxmtvv@gmail.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Yury Norov <ynorov@caviumnetworks.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 23, 2019 at 4:00 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Tue, Apr 23, 2019 at 3:57 PM Ard Biesheuvel
> <ard.biesheuvel@linaro.org> wrote:
> >
> > On Wed, 24 Apr 2019 at 00:55, Kees Cook <keescook@chromium.org> wrote:
> > >
> > > On Mon, Apr 15, 2019 at 7:38 AM Kees Cook <keescook@chromium.org> wrote:
> > > > +#define __msr_s(r, v)                                          \
> > > > +       DEFINE_MSR_S                                            \
> > > > +"      msr_s " __stringify(r) ", %x0\n"                        \
> > > > +       UNDEFINE_MSR_S : : "rZ" (v)
> > >
> > > BTW ... is "%x0" a typo here? Shouldn't this just be "%0"?
> > >
> >
> > No, iirc, that is required to force clang to choose a x# encoding
> > (which is the only one supported by msr/mrs instructions). Otherwise,
> > it will infer from the operand size which encoding to use, and attempt
> > to use w# for 32-bit system registers.
>
> Yes: https://github.com/llvm/llvm-project/blob/80b578c7325352187d0aff7bd2bdb5a76b51cf37/llvm/lib/Target/AArch64/AArch64AsmPrinter.cpp#L466

Cool, yeah, I see now. Thanks!

-- 
Kees Cook
