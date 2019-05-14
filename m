Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 785FFC04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 18:11:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 422F220879
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 18:11:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GrQPMHMK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727506AbfENSLD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 14:11:03 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42120 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726201AbfENSLC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 14:11:02 -0400
Received: by mail-pf1-f194.google.com with SMTP id 13so9543566pfw.9
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2019 11:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6H01YXgOiqIMyUKGYfa0LiUjNdlZGjV/rCvCK49AoiM=;
        b=GrQPMHMKb7MFCp3vDuZVXzteuo88Eb0jVXJJ9FIWV07Vr+84zM5LlXl+wOEoyjLvKU
         vfE+QcA4oOxRg0Xp44O02NxZNT8yPfb6ppezuqV4srdA8rT4cAscR8vSSjmZ3qV4eAkO
         Jd1tZsXAn+5YoaEC/wqVS9+EYchQW9hplVEPo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6H01YXgOiqIMyUKGYfa0LiUjNdlZGjV/rCvCK49AoiM=;
        b=D4FjsbS8F4ICmlmAFdhRKu+EWC7IT8q/gSU15/GMWqL3yxa6xHC3kD+SV/c3aWWWy9
         3PluGHTBXt04b18DUCTRMox/sXpKFm4jZlgWqOIH5z7/bAbjYx9UBcshaHrznkbp3XeH
         +Kojt1qXYW2N+Jzx9Y+4mN4U1cUBduEGZQU5th6b8BJnUiAfj8/ius0SY+y8kITDKPM/
         VLwKx9djgK6a6wG/V34SlBIbpaBAr2ifUOphchNbGgALebrp3kULTSXM6pR2m/0i37j0
         InT2FA25jplWhvpsUPZgt/DB85RsUdwUSVpaom2u1Mm0GNXaZxr/wQwZwpjxnWZQWhfA
         y/Eg==
X-Gm-Message-State: APjAAAWwaT5a1DiKpaMeH8wD8BNtA/W8FFPkZVvIMrHROINoscR6KunP
        0iEx19rdfh7iAzT8FaiRm/EVgw==
X-Google-Smtp-Source: APXvYqykuj8lWIR9HTJ+GMExtr0P9DW+fgKHKIbfvBjFQ5P1WqKp09vEgO7vvNLSV8E82FJD/uAlZA==
X-Received: by 2002:aa7:9a8c:: with SMTP id w12mr41823058pfi.187.1557857459552;
        Tue, 14 May 2019 11:10:59 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id c76sm3762953pfc.43.2019.05.14.11.10.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 May 2019 11:10:58 -0700 (PDT)
Date:   Tue, 14 May 2019 11:10:57 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Nathan Chancellor <nathanchance@gmail.com>,
        Jordan Rupprect <rupprecht@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] lkdtm: support llvm-objcopy
Message-ID: <201905141041.C38DA1B305@keescook>
References: <20190513222109.110020-1-ndesaulniers@google.com>
 <20190513232910.GA30209@archlinux-i9>
 <CAKwvOd=W9nm04zvRQ3iu=AGHnitongZ7VQ9S32U9hBZKwNyeMw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOd=W9nm04zvRQ3iu=AGHnitongZ7VQ9S32U9hBZKwNyeMw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 13, 2019 at 04:50:05PM -0700, Nick Desaulniers wrote:
> On Mon, May 13, 2019 at 4:29 PM Nathan Chancellor
> <natechancellor@gmail.com> wrote:
> >
> > On Mon, May 13, 2019 at 03:21:09PM -0700, 'Nick Desaulniers' via Clang Built Linux wrote:
> > > With CONFIG_LKDTM=y and make OBJCOPY=llvm-objcopy, llvm-objcopy errors:
> > > llvm-objcopy: error: --set-section-flags=.text conflicts with
> > > --rename-section=.text=.rodata
> > >
> > > Rather than support setting flags then renaming sections vs renaming
> > > then setting flags, it's simpler to just change both at the same time
> > > via --rename-section.
> > >
> > > This can be verified with:
> > > $ readelf -S drivers/misc/lkdtm/rodata_objcopy.o
> > > ...
> > > Section Headers:
> > >   [Nr] Name              Type             Address           Offset
> > >        Size              EntSize          Flags  Link  Info  Align
> > > ...
> > >   [ 1] .rodata           PROGBITS         0000000000000000  00000040
> > >        0000000000000004  0000000000000000   A       0     0     4
> > > ...
> > >
> > > Which shows in the Flags field that .text is now renamed .rodata, the
> > > append flag A is set, and the section is not flagged as writeable W.
> > >
> > > Link: https://github.com/ClangBuiltLinux/linux/issues/448
> > > Reported-by: Nathan Chancellor <nathanchance@gmail.com>
> >
> > This should be natechancellor@gmail.com (although I think I do own that
> > email, just haven't been into it for 10+ years...)
> 
> Sorry, I should have looked it up.  I'll just fix this, my earlier
> mistake, and collect Kees's reviewed by tag in a v2 sent directly to
> GKH.

Sounds good.

> > I ran this script to see if there was any change for GNU objcopy and it
> > looks like .rodata's type gets changed, is this intentional? Otherwise,
> > this works for llvm-objcopy like you show.
> >
> > -----------
> >
> > 1c1
> > < There are 11 section headers, starting at offset 0x240:
> > ---
> > > There are 11 section headers, starting at offset 0x230:
> > 8c8
> > <   [ 1] .rodata           PROGBITS         0000000000000000  00000040
> > ---
> > >   [ 1] .rodata           NOBITS           0000000000000000  00000040
> > 10c10

Oh, very good catch; thank you!

> 
> Interesting find.  the .rodata of vmlinux itself is marked PROGBITS,
> so its curious that GNU binutils changes the "Type" after the rename.
> I doubt the code in question relies on NOBITS for this section.  Kees,
> can you clarify?  Jordan, do you know what the differences are between
> PROGBITS vs NOBITS?
> https://people.redhat.com/mpolacek/src/devconf2012.pdf seems to
> suggest NOBITS zero initializes data but I'm not sure that's what this
> code wants.

Yes, the linker treats this as a zeroed section. My testing only checked that the NX protection check kicked, but in looking at the memory, the failure mode wouldn't have returned, because it got zeroed instead of seeing a "ret":

Before the patch (with a two-byte target dump added):

	lkdtm: attempting bad execution at ffffffff986db2b0
	lkdtm: f3 c3

After the patch:

	lkdtm: attempting bad execution at ffffffff986db2b0
	lkdtm: 00 00

So, yes, this breaks the fall-back case and should not be used. It seems
that objcopy BFD breaks the PROGBITS in this case, but llvm-objcopy
does not...

$ objcopy --set-section-flags .text=alloc,readonly --rename-section .text=.rodata rodata.o rodata_objcopy.o
$ readelf -S rodata_objcopy.o | grep -A1 \.rodata
  [ 1] .rodata           PROGBITS         0000000000000000  00000040
       0000000000000002  0000000000000000   A       0     0     16

$ objcopy --rename-section .text=.rodata,alloc,readonly rodata.o rodata_objcopy.o
$ readelf -S rodata_objcopy.o | grep -A1 \.rodata
  [ 1] .rodata           NOBITS           0000000000000000  00000040
       0000000000000002  0000000000000000   A       0     0     16

$ llvm-objcopy --rename-section .text=.rodata,alloc,readonly rodata.o rodata_objcopy-llvm.o
$ readelf -S rodata_objcopy-llvm.o | grep -A1 \.rodata
  [ 1] .rodata           PROGBITS         0000000000000000  00000040
       0000000000000002  0000000000000000   A       0     0     16


llvm-objcopy doesn't like doing both arguments at the same time,
and BFD gets it wrong when using the appended flags. How about just a
two-stage copy, like this?

diff --git a/drivers/misc/lkdtm/Makefile b/drivers/misc/lkdtm/Makefile
index 951c984de61a..715832c844c8 100644
--- a/drivers/misc/lkdtm/Makefile
+++ b/drivers/misc/lkdtm/Makefile
@@ -14,9 +14,12 @@ KASAN_SANITIZE_stackleak.o	:= n
 KCOV_INSTRUMENT_rodata.o	:= n
 
 OBJCOPYFLAGS :=
+OBJCOPYFLAGS_rodata_flags.o	:= \
+			--set-section-flags .text=alloc,readonly
 OBJCOPYFLAGS_rodata_objcopy.o	:= \
-			--set-section-flags .text=alloc,readonly \
 			--rename-section .text=.rodata
-targets += rodata.o rodata_objcopy.o
-$(obj)/rodata_objcopy.o: $(obj)/rodata.o FORCE
+targets += rodata.o rodata_flags.o rodata_objcopy.o
+$(obj)/rodata_flags.o: $(obj)/rodata.o FORCE
+	$(call if_changed,objcopy)
+$(obj)/rodata_objcopy.o: $(obj)/rodata_flags.o FORCE
 	$(call if_changed,objcopy)


-- 
Kees Cook
