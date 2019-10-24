Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D7A0CA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 14:39:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3904C20679
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 14:39:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="Wsq8rdKb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502786AbfJXOjH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 10:39:07 -0400
Received: from conssluserg-06.nifty.com ([210.131.2.91]:33840 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732293AbfJXOjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 10:39:07 -0400
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id x9OEcivT007337
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 23:38:45 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com x9OEcivT007337
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1571927925;
        bh=5VDOJqWr1P/8RpUKJUiUUgzqRYMuViQTbISV22/DfcM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Wsq8rdKbjufD8xDQo9TYn/vVPfLqU8CWHsul4oOcXL2+aXPYpencUJWWwSK3e35D2
         r1rM9S/WmrTYaz2BZmvK3Q++Ya6W+X/E7doaUDPGpJqtcrfyTmXmvYas9LC6dtz7c6
         +Wp7bga0LwmkjxC7bnK3lfeIWZErlsOVJtEDo2V3S2VPEdRk6duBPk4lRsrsWbDSL/
         STw5curdVNiU7mM8M4A4aCs4z+NHeoPxk0Ve0g/XI+teLFDGPSgtiQYnJpzl/UW1DT
         /q3CPziyC8B8u7V6ef2AEzLzPC2Ud+TpShsgQS4VnFZCerdl+NYBUp2z94XzY4M3Fp
         7AXuq/dNyMwFA==
X-Nifty-SrcIP: [209.85.217.46]
Received: by mail-vs1-f46.google.com with SMTP id q21so934695vsg.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 07:38:45 -0700 (PDT)
X-Gm-Message-State: APjAAAXWjnnYAfrRem5ZiGuhB4sFJKorKK5BEE1p2VYSXr5xrN75GMGH
        616MgmXexlvfYDTxngO4MvVKGJo0jFM/C3pJN34=
X-Google-Smtp-Source: APXvYqzTx9f4+sdDvCmM/G0tcS16/98SXXq+GzkLjkICnXwW7kaMiC+gdVtM0Mg1KgO8XJEVHwsWres9Ec0jaj70OCs=
X-Received: by 2002:a67:e290:: with SMTP id g16mr6201871vsf.54.1571927924100;
 Thu, 24 Oct 2019 07:38:44 -0700 (PDT)
MIME-Version: 1.0
References: <20191018161033.261971-1-samitolvanen@google.com>
 <20191018161033.261971-7-samitolvanen@google.com> <20191022162826.GC699@lakrids.cambridge.arm.com>
 <CABCJKudxvS9Eehr0dEFUR4H44K-PUULbjrh0i=pP_r5MGrKptA@mail.gmail.com> <20191024132832.GG4300@lakrids.cambridge.arm.com>
In-Reply-To: <20191024132832.GG4300@lakrids.cambridge.arm.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Thu, 24 Oct 2019 23:38:07 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQWjq0DoTD6LkQfRSMz6sS6_SFapd5YzKjz2U1ZmFEm9w@mail.gmail.com>
Message-ID: <CAK7LNAQWjq0DoTD6LkQfRSMz6sS6_SFapd5YzKjz2U1ZmFEm9w@mail.gmail.com>
Subject: Re: [PATCH 06/18] add support for Clang's Shadow Call Stack (SCS)
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Sami Tolvanen <samitolvanen@google.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Dave Martin <Dave.Martin@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Laura Abbott <labbott@redhat.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 24, 2019 at 10:28 PM Mark Rutland <mark.rutland@arm.com> wrote:
>
> On Tue, Oct 22, 2019 at 12:26:02PM -0700, Sami Tolvanen wrote:
> > On Tue, Oct 22, 2019 at 9:28 AM Mark Rutland <mark.rutland@arm.com> wrote:
>
> > > > +config SHADOW_CALL_STACK
> > > > +     bool "Clang Shadow Call Stack"
> > > > +     depends on ARCH_SUPPORTS_SHADOW_CALL_STACK
> > > > +     depends on CC_IS_CLANG && CLANG_VERSION >= 70000
> > >
> > > Is there a reason for an explicit version check rather than a
> > > CC_HAS_<feature> check? e.g. was this available but broken in prior
> > > versions of clang?
> >
> > No, this feature was added in Clang 7. However,
> > -fsanitize=shadow-call-stack might require architecture-specific
> > flags, so a simple $(cc-option, -fsanitize=shadow-call-stack) in
> > arch/Kconfig is not going to work. I could add something like this to
> > arch/arm64/Kconfig though:
> >
> > select ARCH_SUPPORTS_SHADOW_CALL_STACK if CC_HAVE_SHADOW_CALL_STACK
> > ...
> > config CC_HAVE_SHADOW_CALL_STACK
> >        def_bool $(cc-option, -fsanitize=shadow-call-stack -ffixed-x18)
> >
> > And then drop CC_IS_CLANG and version check entirely. Thoughts?
>
> That sounds good to me, yes!
>
> Thanks,
> Mark.


If you use cc-option, please add a comment like

    # supported by Clang 7 or later.


I do not know the minimal supported clang version.
When we bump the minimal version to clang 7,
we can drop the cc-option test entirely.





--
Best Regards
Masahiro Yamada
