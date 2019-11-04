Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30940CA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 17:55:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02C3620B7C
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 17:55:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ch8gLdyF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729535AbfKDRzA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 12:55:00 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36310 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728709AbfKDRzA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 12:55:00 -0500
Received: by mail-pg1-f196.google.com with SMTP id k13so503398pgh.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2019 09:55:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZmzRLDphDikcmJV+vVl7eKbcaiOYYnpVQWvquJPcMwA=;
        b=Ch8gLdyFcDbhU8epHj55Yp1QvqAYI7QKgnXEyW6w/Oo0Vt8G6EfyLW8Ov8x1KHScWX
         gH3OTBwtSsoUB2Bm1Yi5ig7Yd6eR36xFPE2opissLv3UDLjJxmwZRSR2+2U09TTNBzJo
         5GSNKHNijzjtvD7xoWJHPocCso1WfWPSIS60k5pvSiCuhYztC/FgEHDrekyhSPNybYAQ
         ic3EkBwRiaqQ13An287l0JE47ikw5wdm1pZva9Pr3qSEiAUg4XYKvmQX9i6U/qZF4VYF
         2QizvKajDBmswuA0NpJhdkvW3LJjhRP50gdYVq/MDNcriXmPlaaqVb3yrx/D2fveNAt1
         MrrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZmzRLDphDikcmJV+vVl7eKbcaiOYYnpVQWvquJPcMwA=;
        b=RqdJqf2x6WJMFpLYV5ZKC9TPVq/Izn6VvCO2K0oAeYCVT1T00F5T+hBfQ1drD1QhJY
         pO38VUbd9eErPwi2gZGC3NofvnZJ3EFlnNx9CNQZDVsqhkiUKMyRtwa8dYBMtQ4ZadiM
         sorMz0OmOTuuURkM62iKANcLDouz0/ONtUAZ/hbiMU7/Wm64CIVkSaoHllPFDVaZDIov
         zof06OLbczOB9jCXxUbs5Dbd131BI4UUblx/0emcPwqO86+M7nvyqQ9FTkhfV53qoeXr
         rBjqDTS/8DikUdUVx+gzRUm+DJYugRul/gnMrDkk4oUJdMtSImU+eWLBcU4UvFKSAOtR
         9Zeg==
X-Gm-Message-State: APjAAAX2xhIc4gz02N5cgUApK8CBGQiaGkpTR1K7SHwQztIJG2iqZOmZ
        eKlOPbveqlpSlACXRru8bnkT8b5AgQLGAdgiuo1GAg==
X-Google-Smtp-Source: APXvYqxlPV7fYh9/ditmuFRqH3qsTQXyOBaktBMQM8uwvcYXX9K+hqe+N/QY2CA+YUEROJ5hf6DVgsK1iDvuILjih8w=
X-Received: by 2002:a63:d70e:: with SMTP id d14mr30873946pgg.10.1572890099234;
 Mon, 04 Nov 2019 09:54:59 -0800 (PST)
MIME-Version: 1.0
References: <20191104090339.20941-1-ilie.halip@gmail.com>
In-Reply-To: <20191104090339.20941-1-ilie.halip@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 4 Nov 2019 09:54:48 -0800
Message-ID: <CAKwvOdmSo=BWGnaVeejez6K0Tukny2niWXrr52YvOPDYnXbOsg@mail.gmail.com>
Subject: Re: [PATCH] x86/boot: explicitly place .eh_frame after .rodata
To:     Ilie Halip <ilie.halip@gmail.com>
Cc:     "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Fangrui Song <maskray@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 4, 2019 at 1:03 AM Ilie Halip <ilie.halip@gmail.com> wrote:
>
> When using GCC as compiler and LLVM's lld as linker, linking
> setup.elf fails:
>       LD      arch/x86/boot/setup.elf
>     ld.lld: error: init sections too big!
>
> This happens because ld.lld has different rules for placing
> orphan sections (i.e. sections not mentioned in a linker script)
> compared to ld.bfd.
>
> Particularly, in this case, the merged .eh_frame section is
> placed before __end_init, which triggers an assert in the script.
>
> Explicitly place this section after .rodata, in accordance with
> ld.bfd's behavior.
>
> Signed-off-by: Ilie Halip <ilie.halip@gmail.com>
> Link: https://github.com/ClangBuiltLinux/linux/issues/760

Thanks for the patch Ilie! Quoting Fangrui:

"This is related to the orphan placement rule. An orphan section is a
section that is not described by the linker script. The orphan section
placement is not well documented and the rule used by ld.bfd is not
very clear. Being more explicit is the way to go."
https://github.com/ClangBuiltLinux/linux/issues/760#issuecomment-549064237

Looks like Clang doesn't even produce a .eh_frame section.


> ---
>  arch/x86/boot/setup.ld | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/x86/boot/setup.ld b/arch/x86/boot/setup.ld
> index 0149e41d42c2..4e02eab11b59 100644
> --- a/arch/x86/boot/setup.ld
> +++ b/arch/x86/boot/setup.ld
> @@ -25,6 +25,7 @@ SECTIONS
>
>         . = ALIGN(16);
>         .rodata         : { *(.rodata*) }
> +       .eh_frame       : { *(.eh_frame*) }

The wildcard on the end can be left off; we don't need to glob
different sections with the prefix `.eh_frame`.  Would you mind
sending a V2 with that removed? (I know .rodata and .data in this
linker script globs, but they may actually be putting data in separate
sections which we want to munge back together; certainly for
-fdata-sections).

>
>         .videocards     : {
>                 video_cards = .;
> --
> 2.17.1
>


-- 
Thanks,
~Nick Desaulniers
