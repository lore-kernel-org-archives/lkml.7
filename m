Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94805CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 21:40:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63B612084C
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 21:40:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nZwUQClY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726298AbfJYVkY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 17:40:24 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:33350 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725801AbfJYVkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 17:40:24 -0400
Received: by mail-ua1-f65.google.com with SMTP id c16so1036448uan.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2019 14:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eLRTvF39CVqCAmddGFaUsqwSoY4prNIEuh/o+NUz9p0=;
        b=nZwUQClYiXQ3Q52cTJI0jeh6bazrVJ+0UCwrx0+54WLkrX9dSlGV2PmY8y824qhqm+
         b+SsEDhWiXq1vyab8zOMbLt8DhbgT32DsHm0LjkkTaQ8wSdZ04Z068CQf10fi5T6mqZG
         zjUCFHf9Fcmio8uikM9+SHUQ1o4GuEZM1oAdAl++/ApeZP/iz2BcFl9JTY/GXVwKZTcB
         0IsWFCeBssn/P/ZcmLKkBkgsGKonf9IgvdUar6yKNQSkHanHTQbtP2n1EXdi45W9kU4m
         TVnPXm/1DG4WURnHnBCY0X642BPoq6T5AptAXxcLFsw7IIuU0b5f10JYnaHC0W3N00B3
         rHaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eLRTvF39CVqCAmddGFaUsqwSoY4prNIEuh/o+NUz9p0=;
        b=RJGSNEJAq6ce8CoJ1S67dr4xxG7yioSCy2KW5VSddWZn7n2etiop0aAK+W+eteosWn
         rtMAywSpzghqMxKQYIeajCAMvnsvWdYRpezym8ViWMVttVgsex2JVSVbU5iBd96+li5h
         h8bolfoTfPB68+nK76J7CmsPQXyLgkywSua7dwbmoFSmPuKvcV0NIRovu3LT4F6auyww
         /wj0UrOxmk7++ppCsdET9oIkCLXnLbxOUXJg0HdltCj1xlwJflxmTkX/f+MJspxpRLXQ
         biKR7Cdn7ysKt1jy68pFBwQeLVcnqGiUS9s1vp5jocOXQw36OwDVgHw1ojeJPQdF3r4e
         218Q==
X-Gm-Message-State: APjAAAXADsq3FJ5J5tV6FrlYax6WjRltIXrqRhpzcIbxYanv8LstYk+j
        AnF7Kgviap2h4JLLp1qO5zgUaLd+wpnvbjUknrCpsw==
X-Google-Smtp-Source: APXvYqzB/CyaeixcYXmheo+/rDDZ8UwTzUWhRNGhABApN6r+1HSU0y6CYCp+GyizuEe28jQkvtHrxlkE/Z+LErTCmf0=
X-Received: by 2002:ab0:6387:: with SMTP id y7mr2789274uao.110.1572039622492;
 Fri, 25 Oct 2019 14:40:22 -0700 (PDT)
MIME-Version: 1.0
References: <20191018161033.261971-1-samitolvanen@google.com>
 <20191024225132.13410-1-samitolvanen@google.com> <20191024225132.13410-3-samitolvanen@google.com>
 <20191025094137.GB40270@lakrids.cambridge.arm.com>
In-Reply-To: <20191025094137.GB40270@lakrids.cambridge.arm.com>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Fri, 25 Oct 2019 14:40:11 -0700
Message-ID: <CABCJKue5QAuHi4tzk+82=HD9ts2SLTqn1VZ4OmGfhu0LG8GHfQ@mail.gmail.com>
Subject: Re: [PATCH v2 02/17] arm64/lib: copy_page: avoid x18 register in
 assembler code
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Dave Martin <Dave.Martin@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Laura Abbott <labbott@redhat.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jann Horn <jannh@google.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 25, 2019 at 2:41 AM Mark Rutland <mark.rutland@arm.com> wrote:
> > diff --git a/arch/arm64/lib/copy_page.S b/arch/arm64/lib/copy_page.S
> > index bbb8562396af..8b562264c165 100644
> > --- a/arch/arm64/lib/copy_page.S
> > +++ b/arch/arm64/lib/copy_page.S
> > @@ -34,45 +34,45 @@ alternative_else_nop_endif
> >       ldp     x14, x15, [x1, #96]
> >       ldp     x16, x17, [x1, #112]
> >
> > -     mov     x18, #(PAGE_SIZE - 128)
> > +     add     x0, x0, #256
> >       add     x1, x1, #128
> >  1:
> > -     subs    x18, x18, #128
> > +     tst     x0, #(PAGE_SIZE - 1)
> >
> >  alternative_if ARM64_HAS_NO_HW_PREFETCH
> >       prfm    pldl1strm, [x1, #384]
> >  alternative_else_nop_endif
> >
> > -     stnp    x2, x3, [x0]
> > +     stnp    x2, x3, [x0, #-256]
> >       ldp     x2, x3, [x1]
> > -     stnp    x4, x5, [x0, #16]
> > +     stnp    x4, x5, [x0, #-240]
> >       ldp     x4, x5, [x1, #16]
>
> For legibility, could we make the offset and bias explicit in the STNPs
> so that these line up? e.g.
>
>         stnp    x4, x5, [x0, #16 - 256]
>         ldp     x4, x5, [x1, #16]
>
> ... that'd make it much easier to see by eye that this is sound, much as
> I trust my mental arithmetic. ;)

Sure, that makes sense. I'll change this in v3.

Sami
