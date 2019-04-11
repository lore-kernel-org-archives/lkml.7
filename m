Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C402C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 18:08:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCC0D2146F
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 18:08:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bFGRuUsJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbfDKSIp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 14:08:45 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41816 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726536AbfDKSIp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 14:08:45 -0400
Received: by mail-pg1-f193.google.com with SMTP id f6so3879968pgs.8
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 11:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D05VH0QEJsgcKa0zmQSeC39KlYyMQ70bI+B4qTcFcS4=;
        b=bFGRuUsJGAlQ/5urNzaXss8NHPejzmBjovyIp2O4eNzPBe6LT7qWaM/84YVsFe50o5
         TO8+bk0uKLyq8r73C+sksnABLw2uprmzKI63ib3HjkBkmuOzOAvxScJDVT0QguKlRm9b
         Wn6t0QODx6xy7e99PWt5xnh3BFAu8+cZ730em5aUlNVI3jtf5PxCyRg0ynKKEW0/qi7i
         HTfoYwD7/bbrHNahqv9A7o9wqKAGsie90nvEuQbPvboEe7eDViHu3rGvrzfBhX0iWmDE
         yLPZfAoxk/VOijkOJsrJ+BZC9v/WRd5NeLQ0fTMSaPRNvSkVBZGm1+lLUJjO+QCvlDra
         tvjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D05VH0QEJsgcKa0zmQSeC39KlYyMQ70bI+B4qTcFcS4=;
        b=kuC2B0sf/xIe2Z6gZDIkWAR65c6KOJfvdSxQ4oBr9uXL0ybhZswcgZzd0u9rE1jtaS
         xMYXsk8C5fPzLxaG2b1S4orHrPnkSOT+MkPh/hpfPI3NXFgRtWlUE30ib3kKq3pW91Eq
         o5+71UBmSb9TrkwOXOXJ/QPnHgcZIv7QMKaE4qU5iw0njkqdp0ikAFThgprdRJJAsW2b
         J4rfnpmy4+jz+G7+BI65vAZ70TBarnl2LXFvaqq450xxlKI012Na9AuzzQ1nGzY3moUb
         +oQFv0JmDsK7ugXmx/IuPEQKKPuiBaoSWRcGGH+OdmjXzRCDE42ewiOtrkSnG0Zx9Ki4
         Hrzw==
X-Gm-Message-State: APjAAAW1GEw6x/u5AGf7etFtPWfQyD8CeATEiczUf9mbfRuWCRURTW4G
        FVXAX3xnFRmhoI0FHT8qPbPcKc4VhQlUZqqrAD2iSQ==
X-Google-Smtp-Source: APXvYqz9h60FD+VvrzPqN0iHBbtKJFYHO2VGyRmgydIvsGpok1h8JU0JdVvt9UktLzgdoksK+UJm1T6+Wqqa/l82ITM=
X-Received: by 2002:a62:14d7:: with SMTP id 206mr50332231pfu.162.1555006123190;
 Thu, 11 Apr 2019 11:08:43 -0700 (PDT)
MIME-Version: 1.0
References: <20190410201300.3528984-1-arnd@arndb.de> <20190410201300.3528984-2-arnd@arndb.de>
 <CAKwvOdk-tfsZRVaOr8Suv5C146F-w3jUA-Rx0n2OxkVy+L8tCg@mail.gmail.com> <CAK8P3a0cdvxkoRPOF7moxZ1W2059OEJeOGAFPfSemMH1_g=YPg@mail.gmail.com>
In-Reply-To: <CAK8P3a0cdvxkoRPOF7moxZ1W2059OEJeOGAFPfSemMH1_g=YPg@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 11 Apr 2019 11:08:31 -0700
Message-ID: <CAKwvOdmdUv3pOGdsJCf5HG3KGPfq8TJHY0523jPD=etJwuES7g@mail.gmail.com>
Subject: Re: [PATCH 2/2] s390: boot, purgatory: pass $(CLANG_FLAGS) where needed
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        clang-built-linux@googlegroups.com,
        Nathan Chancellor <natechancellor@gmail.com>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Philipp Rudo <prudo@linux.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 11, 2019 at 1:52 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Thu, Apr 11, 2019 at 12:14 AM 'Nick Desaulniers' via Clang Built
> Linux <clang-built-linux@googlegroups.com> wrote:
> > On Wed, Apr 10, 2019 at 1:13 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > >
> > > The purgatory and boot Makefiles do not inherit the original cflags,
> > > so clang falls back to the default target architecture when building it,
> > > typically this would be x86 when cross-compiling.
> > >
> > > Add $(CLANG_FLAGS) everywhere so we pass the correct --target=s390x-linux
> > > option when cross-compiling.
> > >
> > > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > > ---
> > >  arch/s390/Makefile           | 5 +++--
> > >  arch/s390/purgatory/Makefile | 1 +
> > >  2 files changed, 4 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/arch/s390/Makefile b/arch/s390/Makefile
> > > index 9c079a506325..443990791099 100644
> > > --- a/arch/s390/Makefile
> > > +++ b/arch/s390/Makefile
> > > @@ -17,12 +17,13 @@ KBUILD_CFLAGS_MODULE += -fPIC
> > >  KBUILD_AFLAGS  += -m64
> > >  KBUILD_CFLAGS  += -m64
> > >  aflags_dwarf   := -Wa,-gdwarf-2
> > > -KBUILD_AFLAGS_DECOMPRESSOR := -m64 -D__ASSEMBLY__
> > > +KBUILD_AFLAGS_DECOMPRESSOR := $(CLANG_FLAGS) -m64 -D__ASSEMBLY__
> > >  KBUILD_AFLAGS_DECOMPRESSOR += $(if $(CONFIG_DEBUG_INFO),$(aflags_dwarf))
> > > -KBUILD_CFLAGS_DECOMPRESSOR := -m64 -O2
> > > +KBUILD_CFLAGS_DECOMPRESSOR := $(CLANG_FLAGS) -m64 -O2
> > >  KBUILD_CFLAGS_DECOMPRESSOR += -DDISABLE_BRANCH_PROFILING -D__NO_FORTIFY
> > >  KBUILD_CFLAGS_DECOMPRESSOR += -fno-delete-null-pointer-checks -msoft-float
> > >  KBUILD_CFLAGS_DECOMPRESSOR += -fno-asynchronous-unwind-tables
> >
> > Thanks for the respin with Nathan's suggestion.
> >
> > > +KBUILD_CFLAGS_DECOMPRESSOR += $(call cc-disable-warning,pointer-sign)
> >
> > What's up with this ^ ?  Seems like the top level sets it (without
> > cc-disable-warning :( ), but then KBUILD_CFLAGS_DECOMPRESSOR discards
> > it.  Does Clang actually flag code in this arch (that GCC doesn't)?
>
> Oops, that should have been a separate patch.
>
> I think what happens is that clang warns more aggressively about pointer sign
> bugs than gcc in some cases, and some of those cases happen in s390
> header files that are included by both the kernel and the decompressor.
>
> The full warning log without this change is rather long, see
> https://pastebin.com/KG9xaTNB

From this link, it looks like the definitions of:
__atomic64_or
__atomic64_and
__atomic64_xor
and their *_barrier variants are problematic.  I think converting
those to use unsigned long is the way to go.  Shouldn't you be doing
bitwise ops on unsigned types anyways?

The warnings with __atomic64_add are tougher to read/understand since
at that point the log lines look like they start to mix together.

>
> I also tried patching the code to avoid the warnings, but I'm not entirely
> happy with that result either, see
> https://pastebin.com/pSMz5eZA

That's no terrible, IMO, particularly with the change I suggest above.
-- 
Thanks,
~Nick Desaulniers
