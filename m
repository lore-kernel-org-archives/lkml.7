Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B12F0CA9EC3
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 08:22:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68AD320862
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 08:22:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m/RX5686"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726902AbfJaIW2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 04:22:28 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36709 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726747AbfJaIW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 04:22:27 -0400
Received: by mail-wm1-f65.google.com with SMTP id c22so4898843wmd.1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2019 01:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NHloGbr4jAFWLdAnk+2+DFUSZWOZKFQGAFzAWZrNGgM=;
        b=m/RX5686FhSf9F2YD+rmGrhLFCxKln3s2pJh2U4FWxQA8/BW1XbaUS8p0fB8F3jYKO
         3Fi9esQCSS8aBQtQd2NqYmuIw7Eyhyu20dzSbvYipXPnkq8y+H8WPx0MAwsoGIEVfu9w
         V6Uac+9afzVIWifMOgeb/ihrYPynZ6PDfOt5Gp68tM4qASbSp4qzBO7FeMgl0s4DLVFy
         Ogl6s2coJ6S96T3NqayDkAdtNddzQjDTokY1+s++DTZr8lt2vkbwyX4iYaCiF5m6NJry
         R7MhTJGDaXS3b6bFIXIgl86KkGz2TbKdbtyl4Lz7ctB9xccTW5GM85TI7gQvh50jdtT6
         Lsig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NHloGbr4jAFWLdAnk+2+DFUSZWOZKFQGAFzAWZrNGgM=;
        b=mZZkjN2Jj7LGjSKY+/tRBsQCTzjC/T3EOLmzXXU1oenHFFLRiVpuydkDzybNGXvo0J
         x8+P8zswq5JKD84e8tN5Cy7fDI9jEiv6plpVhot/0omXqaM7R1NjmVwQodvIMHILDU/V
         tC2I5lFbbAfettUQGU+Iv1xusAotEG0Ix6eINcROCQOIVbBWSV8WPRnx0NCIng7Ecavh
         dBPkMKkoobF9qa3oQLedEGgxPVYQMcMK44ECi3aJm4xERx0m7Q+BPQJAzsnNMERTi7dx
         gVaJIdzdWRcOou6BgMD6xcpIhwrDOIwDeon1f7tsD0W2XtHA9Ez+FDjw1dslSzE5X2Zm
         x9Jw==
X-Gm-Message-State: APjAAAXW9dOxvM4BND00oQtDHBmBPxS9lrNta0QSViUlIGxmLKjFB3YC
        9jaaTd1ZIVYfDmcLHOJ82oms9QaVvIrnpjAPZ9VFgA==
X-Google-Smtp-Source: APXvYqwPu7hucBc0inOSN0T87RHKqwBDQwr/uRVvArgcOdY9NagVdmZnTnbat5TszKJy8pcCqtWflRWmY5w+GRp88bU=
X-Received: by 2002:a1c:3d08:: with SMTP id k8mr3617331wma.119.1572510143438;
 Thu, 31 Oct 2019 01:22:23 -0700 (PDT)
MIME-Version: 1.0
References: <20191030174429.248697-1-ndesaulniers@google.com>
In-Reply-To: <20191030174429.248697-1-ndesaulniers@google.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Thu, 31 Oct 2019 09:22:11 +0100
Message-ID: <CAKv+Gu8POt2gYO6fagnKr-EgsuxMEo9LwVXo1pgcJKAG3JG+Pw@mail.gmail.com>
Subject: Re: [PATCH] arm: replace Sun/Solaris style flag on section directive
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        Fangrui Song <maskray@google.com>,
        Jian Cai <jiancai@google.com>,
        Peter Smith <peter.smith@linaro.org>,
        Hans Ulli Kroll <ulli.kroll@googlemail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Pitre <nico@fluxnic.net>,
        Stefan Agner <stefan@agner.ch>,
        Enrico Weigelt <info@metux.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Roy Franz <rfranz@marvell.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Allison Randal <allison@lohutok.net>,
        Richard Fontana <rfontana@redhat.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Dave Martin <Dave.Martin@arm.com>,
        Sonny Rao <sonnyrao@chromium.org>,
        Doug Anderson <armlinux@m.disordat.com>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        afzal mohammed <afzal.mohd.ma@gmail.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Oct 2019 at 18:48, Nick Desaulniers <ndesaulniers@google.com> wrote:
>
> It looks like a section directive was using "Solaris style" to declare
> the section flags. Replace this with the GNU style so that Clang's
> integrated assembler can assemble this directive.
>
> The modified instances were identified via:
> $ ag \\.section | grep \#
>
> Link: https://ftp.gnu.org/old-gnu/Manuals/gas-2.9.1/html_chapter/as_7.html#SEC119
> Link: https://github.com/ClangBuiltLinux/linux/issues/744
> Link: https://bugs.llvm.org/show_bug.cgi?id=43759
> Link: https://reviews.llvm.org/D69296
> Suggested-by: Fangrui Song <maskray@google.com>
> Suggested-by: Jian Cai <jiancai@google.com>
> Suggested-by: Peter Smith <peter.smith@linaro.org>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>

Looks correct to me

Reviewed-by: Ard Biesheuvel <ardb@kernel.org>

> ---
>  arch/arm/boot/bootp/init.S            | 2 +-
>  arch/arm/boot/compressed/big-endian.S | 2 +-
>  arch/arm/boot/compressed/head.S       | 2 +-
>  arch/arm/boot/compressed/piggy.S      | 2 +-
>  arch/arm/mm/proc-arm1020.S            | 2 +-
>  arch/arm/mm/proc-arm1020e.S           | 2 +-
>  arch/arm/mm/proc-arm1022.S            | 2 +-
>  arch/arm/mm/proc-arm1026.S            | 2 +-
>  arch/arm/mm/proc-arm720.S             | 2 +-
>  arch/arm/mm/proc-arm740.S             | 2 +-
>  arch/arm/mm/proc-arm7tdmi.S           | 2 +-
>  arch/arm/mm/proc-arm920.S             | 2 +-
>  arch/arm/mm/proc-arm922.S             | 2 +-
>  arch/arm/mm/proc-arm925.S             | 2 +-
>  arch/arm/mm/proc-arm926.S             | 2 +-
>  arch/arm/mm/proc-arm940.S             | 2 +-
>  arch/arm/mm/proc-arm946.S             | 2 +-
>  arch/arm/mm/proc-arm9tdmi.S           | 2 +-
>  arch/arm/mm/proc-fa526.S              | 2 +-
>  arch/arm/mm/proc-feroceon.S           | 2 +-
>  arch/arm/mm/proc-mohawk.S             | 2 +-
>  arch/arm/mm/proc-sa110.S              | 2 +-
>  arch/arm/mm/proc-sa1100.S             | 2 +-
>  arch/arm/mm/proc-v6.S                 | 2 +-
>  arch/arm/mm/proc-v7.S                 | 2 +-
>  arch/arm/mm/proc-v7m.S                | 4 ++--
>  arch/arm/mm/proc-xsc3.S               | 2 +-
>  arch/arm/mm/proc-xscale.S             | 2 +-
>  28 files changed, 29 insertions(+), 29 deletions(-)
>
> diff --git a/arch/arm/boot/bootp/init.S b/arch/arm/boot/bootp/init.S
> index 5c476bd2b4ce..b562da2f7040 100644
> --- a/arch/arm/boot/bootp/init.S
> +++ b/arch/arm/boot/bootp/init.S
> @@ -13,7 +13,7 @@
>   *  size immediately following the kernel, we could build this into
>   *  a binary blob, and concatenate the zImage using the cat command.
>   */
> -               .section .start,#alloc,#execinstr
> +               .section .start, "ax"
>                 .type   _start, #function
>                 .globl  _start
>
> diff --git a/arch/arm/boot/compressed/big-endian.S b/arch/arm/boot/compressed/big-endian.S
> index 88e2a88d324b..0e092c36da2f 100644
> --- a/arch/arm/boot/compressed/big-endian.S
> +++ b/arch/arm/boot/compressed/big-endian.S
> @@ -6,7 +6,7 @@
>   *  Author: Nicolas Pitre
>   */
>
> -       .section ".start", #alloc, #execinstr
> +       .section ".start", "ax"
>
>         mrc     p15, 0, r0, c1, c0, 0   @ read control reg
>         orr     r0, r0, #(1 << 7)       @ enable big endian mode
> diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
> index 93dffed0ac6e..15ecad944847 100644
> --- a/arch/arm/boot/compressed/head.S
> +++ b/arch/arm/boot/compressed/head.S
> @@ -140,7 +140,7 @@
>  #endif
>                 .endm
>
> -               .section ".start", #alloc, #execinstr
> +               .section ".start", "ax"
>  /*
>   * sort out different calling conventions
>   */
> diff --git a/arch/arm/boot/compressed/piggy.S b/arch/arm/boot/compressed/piggy.S
> index 0284f84dcf38..27577644ee72 100644
> --- a/arch/arm/boot/compressed/piggy.S
> +++ b/arch/arm/boot/compressed/piggy.S
> @@ -1,5 +1,5 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
> -       .section .piggydata,#alloc
> +       .section .piggydata, "a"
>         .globl  input_data
>  input_data:
>         .incbin "arch/arm/boot/compressed/piggy_data"
> diff --git a/arch/arm/mm/proc-arm1020.S b/arch/arm/mm/proc-arm1020.S
> index 4fa5371bc662..2785da387c91 100644
> --- a/arch/arm/mm/proc-arm1020.S
> +++ b/arch/arm/mm/proc-arm1020.S
> @@ -491,7 +491,7 @@ cpu_arm1020_name:
>
>         .align
>
> -       .section ".proc.info.init", #alloc
> +       .section ".proc.info.init", "a"
>
>         .type   __arm1020_proc_info,#object
>  __arm1020_proc_info:
> diff --git a/arch/arm/mm/proc-arm1020e.S b/arch/arm/mm/proc-arm1020e.S
> index 5d8a8339e09a..e9ea237ed785 100644
> --- a/arch/arm/mm/proc-arm1020e.S
> +++ b/arch/arm/mm/proc-arm1020e.S
> @@ -449,7 +449,7 @@ arm1020e_crval:
>
>         .align
>
> -       .section ".proc.info.init", #alloc
> +       .section ".proc.info.init", "a"
>
>         .type   __arm1020e_proc_info,#object
>  __arm1020e_proc_info:
> diff --git a/arch/arm/mm/proc-arm1022.S b/arch/arm/mm/proc-arm1022.S
> index b3dd95c345e4..920c279e7879 100644
> --- a/arch/arm/mm/proc-arm1022.S
> +++ b/arch/arm/mm/proc-arm1022.S
> @@ -443,7 +443,7 @@ arm1022_crval:
>
>         .align
>
> -       .section ".proc.info.init", #alloc
> +       .section ".proc.info.init", "a"
>
>         .type   __arm1022_proc_info,#object
>  __arm1022_proc_info:
> diff --git a/arch/arm/mm/proc-arm1026.S b/arch/arm/mm/proc-arm1026.S
> index ac5afde12f35..10e21012380b 100644
> --- a/arch/arm/mm/proc-arm1026.S
> +++ b/arch/arm/mm/proc-arm1026.S
> @@ -437,7 +437,7 @@ arm1026_crval:
>         string  cpu_arm1026_name, "ARM1026EJ-S"
>         .align
>
> -       .section ".proc.info.init", #alloc
> +       .section ".proc.info.init", "a"
>
>         .type   __arm1026_proc_info,#object
>  __arm1026_proc_info:
> diff --git a/arch/arm/mm/proc-arm720.S b/arch/arm/mm/proc-arm720.S
> index c99d24363f32..39361e196d61 100644
> --- a/arch/arm/mm/proc-arm720.S
> +++ b/arch/arm/mm/proc-arm720.S
> @@ -172,7 +172,7 @@ arm720_crval:
>   * See <asm/procinfo.h> for a definition of this structure.
>   */
>
> -               .section ".proc.info.init", #alloc
> +               .section ".proc.info.init", "a"
>
>  .macro arm720_proc_info name:req, cpu_val:req, cpu_mask:req, cpu_name:req, cpu_flush:req
>                 .type   __\name\()_proc_info,#object
> diff --git a/arch/arm/mm/proc-arm740.S b/arch/arm/mm/proc-arm740.S
> index 1b4a3838393f..1a94bbf6e53f 100644
> --- a/arch/arm/mm/proc-arm740.S
> +++ b/arch/arm/mm/proc-arm740.S
> @@ -128,7 +128,7 @@ __arm740_setup:
>
>         .align
>
> -       .section ".proc.info.init", #alloc
> +       .section ".proc.info.init", "a"
>         .type   __arm740_proc_info,#object
>  __arm740_proc_info:
>         .long   0x41807400
> diff --git a/arch/arm/mm/proc-arm7tdmi.S b/arch/arm/mm/proc-arm7tdmi.S
> index 17a4687065c7..52b66cf0259e 100644
> --- a/arch/arm/mm/proc-arm7tdmi.S
> +++ b/arch/arm/mm/proc-arm7tdmi.S
> @@ -72,7 +72,7 @@ __arm7tdmi_setup:
>
>                 .align
>
> -               .section ".proc.info.init", #alloc
> +               .section ".proc.info.init", "a"
>
>  .macro arm7tdmi_proc_info name:req, cpu_val:req, cpu_mask:req, cpu_name:req, \
>         extra_hwcaps=0
> diff --git a/arch/arm/mm/proc-arm920.S b/arch/arm/mm/proc-arm920.S
> index 298c76b47749..31ac8acc34dc 100644
> --- a/arch/arm/mm/proc-arm920.S
> +++ b/arch/arm/mm/proc-arm920.S
> @@ -434,7 +434,7 @@ arm920_crval:
>
>         .align
>
> -       .section ".proc.info.init", #alloc
> +       .section ".proc.info.init", "a"
>
>         .type   __arm920_proc_info,#object
>  __arm920_proc_info:
> diff --git a/arch/arm/mm/proc-arm922.S b/arch/arm/mm/proc-arm922.S
> index 824be3a0bc23..ca2c7ca8af21 100644
> --- a/arch/arm/mm/proc-arm922.S
> +++ b/arch/arm/mm/proc-arm922.S
> @@ -412,7 +412,7 @@ arm922_crval:
>
>         .align
>
> -       .section ".proc.info.init", #alloc
> +       .section ".proc.info.init", "a"
>
>         .type   __arm922_proc_info,#object
>  __arm922_proc_info:
> diff --git a/arch/arm/mm/proc-arm925.S b/arch/arm/mm/proc-arm925.S
> index d40cff8f102c..a381a0c9f109 100644
> --- a/arch/arm/mm/proc-arm925.S
> +++ b/arch/arm/mm/proc-arm925.S
> @@ -477,7 +477,7 @@ arm925_crval:
>
>         .align
>
> -       .section ".proc.info.init", #alloc
> +       .section ".proc.info.init", "a"
>
>  .macro arm925_proc_info name:req, cpu_val:req, cpu_mask:req, cpu_name:req, cache
>         .type   __\name\()_proc_info,#object
> diff --git a/arch/arm/mm/proc-arm926.S b/arch/arm/mm/proc-arm926.S
> index f3cd08f353f0..3188ab2bac61 100644
> --- a/arch/arm/mm/proc-arm926.S
> +++ b/arch/arm/mm/proc-arm926.S
> @@ -460,7 +460,7 @@ arm926_crval:
>
>         .align
>
> -       .section ".proc.info.init", #alloc
> +       .section ".proc.info.init", "a"
>
>         .type   __arm926_proc_info,#object
>  __arm926_proc_info:
> diff --git a/arch/arm/mm/proc-arm940.S b/arch/arm/mm/proc-arm940.S
> index 1c26d991386d..4b8a00220cc9 100644
> --- a/arch/arm/mm/proc-arm940.S
> +++ b/arch/arm/mm/proc-arm940.S
> @@ -340,7 +340,7 @@ __arm940_setup:
>
>         .align
>
> -       .section ".proc.info.init", #alloc
> +       .section ".proc.info.init", "a"
>
>         .type   __arm940_proc_info,#object
>  __arm940_proc_info:
> diff --git a/arch/arm/mm/proc-arm946.S b/arch/arm/mm/proc-arm946.S
> index 2dc1c75a4fd4..555becf9c758 100644
> --- a/arch/arm/mm/proc-arm946.S
> +++ b/arch/arm/mm/proc-arm946.S
> @@ -395,7 +395,7 @@ __arm946_setup:
>
>         .align
>
> -       .section ".proc.info.init", #alloc
> +       .section ".proc.info.init", "a"
>         .type   __arm946_proc_info,#object
>  __arm946_proc_info:
>         .long   0x41009460
> diff --git a/arch/arm/mm/proc-arm9tdmi.S b/arch/arm/mm/proc-arm9tdmi.S
> index 913c06e590af..ef517530130b 100644
> --- a/arch/arm/mm/proc-arm9tdmi.S
> +++ b/arch/arm/mm/proc-arm9tdmi.S
> @@ -66,7 +66,7 @@ __arm9tdmi_setup:
>
>                 .align
>
> -               .section ".proc.info.init", #alloc
> +               .section ".proc.info.init", "a"
>
>  .macro arm9tdmi_proc_info name:req, cpu_val:req, cpu_mask:req, cpu_name:req
>                 .type   __\name\()_proc_info, #object
> diff --git a/arch/arm/mm/proc-fa526.S b/arch/arm/mm/proc-fa526.S
> index 8120b6f4dbb8..dddf833fe000 100644
> --- a/arch/arm/mm/proc-fa526.S
> +++ b/arch/arm/mm/proc-fa526.S
> @@ -185,7 +185,7 @@ fa526_cr1_set:
>
>         .align
>
> -       .section ".proc.info.init", #alloc
> +       .section ".proc.info.init", "a"
>
>         .type   __fa526_proc_info,#object
>  __fa526_proc_info:
> diff --git a/arch/arm/mm/proc-feroceon.S b/arch/arm/mm/proc-feroceon.S
> index bb6dc34d42a3..b12b76bc8d30 100644
> --- a/arch/arm/mm/proc-feroceon.S
> +++ b/arch/arm/mm/proc-feroceon.S
> @@ -571,7 +571,7 @@ feroceon_crval:
>
>         .align
>
> -       .section ".proc.info.init", #alloc
> +       .section ".proc.info.init", "a"
>
>  .macro feroceon_proc_info name:req, cpu_val:req, cpu_mask:req, cpu_name:req, cache:req
>         .type   __\name\()_proc_info,#object
> diff --git a/arch/arm/mm/proc-mohawk.S b/arch/arm/mm/proc-mohawk.S
> index f08308578885..d47d6c5cee63 100644
> --- a/arch/arm/mm/proc-mohawk.S
> +++ b/arch/arm/mm/proc-mohawk.S
> @@ -416,7 +416,7 @@ mohawk_crval:
>
>         .align
>
> -       .section ".proc.info.init", #alloc
> +       .section ".proc.info.init", "a"
>
>         .type   __88sv331x_proc_info,#object
>  __88sv331x_proc_info:
> diff --git a/arch/arm/mm/proc-sa110.S b/arch/arm/mm/proc-sa110.S
> index d5bc5d702563..baba503ba816 100644
> --- a/arch/arm/mm/proc-sa110.S
> +++ b/arch/arm/mm/proc-sa110.S
> @@ -196,7 +196,7 @@ sa110_crval:
>
>         .align
>
> -       .section ".proc.info.init", #alloc
> +       .section ".proc.info.init", "a"
>
>         .type   __sa110_proc_info,#object
>  __sa110_proc_info:
> diff --git a/arch/arm/mm/proc-sa1100.S b/arch/arm/mm/proc-sa1100.S
> index be7b611c76c7..75ebacc8e4e5 100644
> --- a/arch/arm/mm/proc-sa1100.S
> +++ b/arch/arm/mm/proc-sa1100.S
> @@ -239,7 +239,7 @@ sa1100_crval:
>
>         .align
>
> -       .section ".proc.info.init", #alloc
> +       .section ".proc.info.init", "a"
>
>  .macro sa1100_proc_info name:req, cpu_val:req, cpu_mask:req, cpu_name:req
>         .type   __\name\()_proc_info,#object
> diff --git a/arch/arm/mm/proc-v6.S b/arch/arm/mm/proc-v6.S
> index c1c85eb3484f..1dd0d5ca27da 100644
> --- a/arch/arm/mm/proc-v6.S
> +++ b/arch/arm/mm/proc-v6.S
> @@ -261,7 +261,7 @@ v6_crval:
>         string  cpu_elf_name, "v6"
>         .align
>
> -       .section ".proc.info.init", #alloc
> +       .section ".proc.info.init", "a"
>
>         /*
>          * Match any ARMv6 processor core.
> diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
> index c4e8006a1a8c..48e0ef6f0dcc 100644
> --- a/arch/arm/mm/proc-v7.S
> +++ b/arch/arm/mm/proc-v7.S
> @@ -644,7 +644,7 @@ __v7_setup_stack:
>         string  cpu_elf_name, "v7"
>         .align
>
> -       .section ".proc.info.init", #alloc
> +       .section ".proc.info.init", "a"
>
>         /*
>          * Standard v7 proc info content
> diff --git a/arch/arm/mm/proc-v7m.S b/arch/arm/mm/proc-v7m.S
> index 1a49d503eafc..84459c1d31b8 100644
> --- a/arch/arm/mm/proc-v7m.S
> +++ b/arch/arm/mm/proc-v7m.S
> @@ -93,7 +93,7 @@ ENTRY(cpu_cm7_proc_fin)
>         ret     lr
>  ENDPROC(cpu_cm7_proc_fin)
>
> -       .section ".init.text", #alloc, #execinstr
> +       .section ".init.text", "ax"
>
>  __v7m_cm7_setup:
>         mov     r8, #(V7M_SCB_CCR_DC | V7M_SCB_CCR_IC| V7M_SCB_CCR_BP)
> @@ -177,7 +177,7 @@ ENDPROC(__v7m_setup)
>         string cpu_elf_name "v7m"
>         string cpu_v7m_name "ARMv7-M"
>
> -       .section ".proc.info.init", #alloc
> +       .section ".proc.info.init", "a"
>
>  .macro __v7m_proc name, initfunc, cache_fns = nop_cache_fns, hwcaps = 0,  proc_fns = v7m_processor_functions
>         .long   0                       /* proc_info_list.__cpu_mm_mmu_flags */
> diff --git a/arch/arm/mm/proc-xsc3.S b/arch/arm/mm/proc-xsc3.S
> index 1ac0fbbe9f12..42eaecc43cfe 100644
> --- a/arch/arm/mm/proc-xsc3.S
> +++ b/arch/arm/mm/proc-xsc3.S
> @@ -496,7 +496,7 @@ xsc3_crval:
>
>         .align
>
> -       .section ".proc.info.init", #alloc
> +       .section ".proc.info.init", "a"
>
>  .macro xsc3_proc_info name:req, cpu_val:req, cpu_mask:req
>         .type   __\name\()_proc_info,#object
> diff --git a/arch/arm/mm/proc-xscale.S b/arch/arm/mm/proc-xscale.S
> index bdb2b7749b03..18ac5a1f8922 100644
> --- a/arch/arm/mm/proc-xscale.S
> +++ b/arch/arm/mm/proc-xscale.S
> @@ -610,7 +610,7 @@ xscale_crval:
>
>         .align
>
> -       .section ".proc.info.init", #alloc
> +       .section ".proc.info.init", "a"
>
>  .macro xscale_proc_info name:req, cpu_val:req, cpu_mask:req, cpu_name:req, cache
>         .type   __\name\()_proc_info,#object
> --
> 2.24.0.rc0.303.g954a862665-goog
>
