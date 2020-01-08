Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 020B8C282DD
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 15:48:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C80B520720
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 15:48:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="be/0HgRE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727415AbgAHPsF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 10:48:05 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38667 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726401AbgAHPsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 10:48:04 -0500
Received: by mail-wm1-f68.google.com with SMTP id u2so3011172wmc.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jan 2020 07:48:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KrHsQAP0a9eh1NM9sOVdFPeaeyaEh108A3v2h0i3x0E=;
        b=be/0HgREopOPW+2tP9ai/6DG9k194a1evqoodK9bIBc3vz7RTuMFmpvx7YvMURM5+j
         /WfI9/uYzboJbd4o0O0nLDJ9+DcfHOY4/XH6QArnNld2yqZas8y3GJqdqqy1reHM3uMs
         M0dIbzPeNLNZrbUYAHWfYJEsssmZPAGKUi0ggzMFLAxOg86ZjaZifHm0/KHB+isTebos
         bHnq13duf8YWMA+Zhg/OuOjEy86QXkuphb9cZXKwnkcQIuumgHLIPPjMQDnC9bD66Lox
         018PiSNZ1dXZhSEWycjVxWW7z+2AeT6M8LODMD+KI0/cY0Lz2dWIhYD3vFGVpuiqu7LO
         s4XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KrHsQAP0a9eh1NM9sOVdFPeaeyaEh108A3v2h0i3x0E=;
        b=uOBbQvwK7xvN7jHrKK2pyIWBn/uFTvbq7FgJ/g97VFLimlRB3TIFeS7/GH8hQ/QFgc
         WykdXymbQ3s0w9vfNUbQg7brair5WT2CbHjuTl9BSg1WNo9qwXep0IQxasy21mHRG4mZ
         IBbmo7q34xKX1xqwEPegRRcBYuLbETGekTq0bCmYKrqHZInfIJsQP33LTR6UjYXGbTw/
         GmlkJP1x1MsnHEphQsDoZoFmul5Cdeq94+sAfbyaxjcAl9/cuNtJ3XLSXYAz1v6ysI9+
         gYER+0J5PKfPWWuich20f/6PHujFvpq2xpmAchviXtkax9zhkAKz5d6jAGduf0GphYOc
         auqQ==
X-Gm-Message-State: APjAAAXVU57yjFpa7xG7NfXO+3dXNRq6QrJx/yMILqWF20npXLdMLAal
        sMfZVkQyrLPVfZCndKEuDtZuav7XZKVxezgLFhTWQg==
X-Google-Smtp-Source: APXvYqwKFiQyMCwL4AAPWd45y4MGjnhAiXJlP/5iP6Dw1GbxR2/pOuvKAU+O8dyrtdNHiAG2Ca7K6Fn60xTPEWb6G2A=
X-Received: by 2002:a1c:3dc3:: with SMTP id k186mr4477316wma.95.1578498482821;
 Wed, 08 Jan 2020 07:48:02 -0800 (PST)
MIME-Version: 1.0
References: <20200108102304.25800-1-ardb@kernel.org> <20200108102304.25800-3-ardb@kernel.org>
 <20200108154031.GA2512498@rani.riverdale.lan>
In-Reply-To: <20200108154031.GA2512498@rani.riverdale.lan>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Wed, 8 Jan 2020 16:47:51 +0100
Message-ID: <CAKv+Gu8AOukQL3qokt+Rz3PKBRWWnSULGUr=+yxg_HPM8-uodw@mail.gmail.com>
Subject: Re: [RFC PATCH 2/3] x86/boot/compressed: force hidden visibility for
 all symbol references
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Jan 2020 at 16:40, Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> On Wed, Jan 08, 2020 at 11:23:03AM +0100, Ard Biesheuvel wrote:
> > Eliminate all GOT entries in the decompressor binary, by forcing hidden
> > visibility for all symbol references, which informs the compiler that
> > such references will be resolved at link time without the need for
> > allocating GOT entries.
> >
> > To ensure that no GOT entries will creep back in, add an assertion to
> > the decompressor linker script that will fire if the .got section has
> > a non-zero size.
> >
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > ---
> >  arch/x86/boot/compressed/Makefile      |  1 +
> >  arch/x86/boot/compressed/hidden.h      | 19 +++++++++++++++++++
> >  arch/x86/boot/compressed/vmlinux.lds.S |  1 +
> >  3 files changed, 21 insertions(+)
> >
> > diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
> > index 56aa5fa0a66b..361df91b2288 100644
> > --- a/arch/x86/boot/compressed/Makefile
> > +++ b/arch/x86/boot/compressed/Makefile
> > @@ -39,6 +39,7 @@ KBUILD_CFLAGS += $(call cc-disable-warning, address-of-packed-member)
> >  KBUILD_CFLAGS += $(call cc-disable-warning, gnu)
> >  KBUILD_CFLAGS += -Wno-pointer-sign
> >  KBUILD_CFLAGS += $(call cc-option,-fmacro-prefix-map=$(srctree)/=)
> > +KBUILD_CFLAGS += -include hidden.h
> >
>
> This should be added to drivers/firmware/efi/libstub as well in case
> future code changes bring in global references there?

The EFI stub already sets the hidden visibility attribute for the few
external symbol references that it contains, so it is not needed in
the context of this series.

In the future, we can revisit this if we want to get rid of the
various __pure getter functions, but that requires thorough testing on
other architectures and toolchains, so I'd prefer to leave that for
later.
