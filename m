Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ABE9C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 17:43:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E72F206BB
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 17:43:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cNd0enXk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727134AbfKLRnT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 12:43:19 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42089 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726960AbfKLRnS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 12:43:18 -0500
Received: by mail-pg1-f195.google.com with SMTP id q17so12302690pgt.9
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 09:43:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w7MsKAbnhTOI/PwrqDE4qAaT5Rd571pVr2jNCX1vMLU=;
        b=cNd0enXkHOlBT1RG/B0zjwD+dSmow8c5nRzzi8wByRqtyyGRqlP/90puPVUHT2bUvK
         mQbcgkMcKJEggwR6BNgwUe1k3iHRcU9Nv+09wp+5mSHD85bbCwFpPmC1Bq/N6KycgvLc
         ktBjH+xZqmnKF96hvkiWDDnKXCucxoU7OZ2iPuTzsZieGoXXvmVO8nkdSVmcKoQ0Sag5
         1wb5p1gG2njNuZjWDs23kq4PuD0d3VD2P6xrsZEftYQbFuKC9dq5RM4h98lnbR6yHj+6
         V3hTuXYKq51KvsQAjJmhlCEiu8IU0QIfTP+HvBkhjozUwwD6bX/8o2pKUCVaRPm4q9kZ
         e6Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w7MsKAbnhTOI/PwrqDE4qAaT5Rd571pVr2jNCX1vMLU=;
        b=A0ygOng5SveYuwvLcXdrtNK0szAH5VKADpjJ8/j6N21EHFYuAcY23UDCALbxD+h9Uj
         jTurzHydjbGpH2Pyg2VQWLQmOdyt+7SD/FjoZZJM4HN/sD+/d92wi+32fM1UNCa7H4hD
         Ns7iUIFuLzQNjw3ktGK3PGTfDhZvukJf9wlUaCTvZV5lMLuP+KMp5VRrMQNs76ZLdfUd
         96NBNawHKrhdf4qHeIdyh7sQ3cblBA5Fjdt5Z2/XsgJ/w2VOLdNf4om6jq6GfZ6Paj5i
         X5lCqkiuE6v09EK/Zz7clraPUFIvOSTtuL0yBejLzXYHHc38/kCndxmlMPZfeLyyLrmc
         +bOA==
X-Gm-Message-State: APjAAAU+LeN/CDmqMzXRpPXd2UgXn1g1svt+8CCxfvUcoEU4zXZ+Zpry
        N7FRjA9sskrJApTZXDHR7/z9aEi7jpmQr/etkM953g==
X-Google-Smtp-Source: APXvYqx+JS9StvmX4eZx5rKWcGRb9+ijR8E7BlPSw/fF4TuTW1nUyMaiKhwUBG/mh+SI5JEZV6dnXnwYygBOz5G6Css=
X-Received: by 2002:a63:5a03:: with SMTP id o3mr36165069pgb.381.1573580597463;
 Tue, 12 Nov 2019 09:43:17 -0800 (PST)
MIME-Version: 1.0
References: <20191110153043.111710-1-dima@golovin.in>
In-Reply-To: <20191110153043.111710-1-dima@golovin.in>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 12 Nov 2019 09:43:05 -0800
Message-ID: <CAKwvOdnwKP5gRVmvKou1UoqHn7Fi-uoGFeAMf2dWoaEy0fibzA@mail.gmail.com>
Subject: Re: [PATCH] ARM: kbuild: use correct nm executable
To:     Dmitry Golovin <dima@golovin.in>
Cc:     Matthias Maennich <maennich@google.com>,
        Russell King <linux@armlinux.org.uk>,
        Nicolas Pitre <nico@fluxnic.net>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Stefan Agner <stefan@agner.ch>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 10, 2019 at 7:31 AM Dmitry Golovin <dima@golovin.in> wrote:
>
> Since $(NM) variable can be easily overridden for the whole build, it's
> better to use it instead of $(CROSS_COMPILE)nm. The use of $(CROSS_COMPILE)
> prefixed variables where their calculated equivalents can be used is
> incorrect. This fixes issues with builds where $(NM) is set to llvm-nm.
>
> Link: https://github.com/ClangBuiltLinux/linux/issues/766
> Signed-off-by: Dmitry Golovin <dima@golovin.in>
> Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
> Cc: Matthias Maennich <maennich@google.com>

Thanks for the patch Dima.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
You should wait a week from when you first sent this patch, then
submit it to rmk's patch queue:
https://www.armlinux.org.uk/developer/patches/section.php?section=0
You should create an account there.  On
https://www.armlinux.org.uk/developer/patches/add.php,

Summary -> first line from commit
Kernel version -> base repo you wrote the patch against, see examples
https://www.armlinux.org.uk/developer/patches/section.php?section=0
Patch notes -> rest of commit body (with all these reviewed by tags added)

More info: https://www.armlinux.org.uk/developer/

> ---
>  arch/arm/boot/compressed/Makefile | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/boot/compressed/Makefile b/arch/arm/boot/compressed/Makefile
> index 9219389bbe61..a1e883c5e5c4 100644
> --- a/arch/arm/boot/compressed/Makefile
> +++ b/arch/arm/boot/compressed/Makefile
> @@ -121,7 +121,7 @@ ccflags-y := -fpic $(call cc-option,-mno-single-pic-base,) -fno-builtin -I$(obj)
>  asflags-y := -DZIMAGE
>
>  # Supply kernel BSS size to the decompressor via a linker symbol.
> -KBSS_SZ = $(shell echo $$(($$($(CROSS_COMPILE)nm $(obj)/../../../../vmlinux | \
> +KBSS_SZ = $(shell echo $$(($$($(NM) $(obj)/../../../../vmlinux | \
>                 sed -n -e 's/^\([^ ]*\) [AB] __bss_start$$/-0x\1/p' \
>                        -e 's/^\([^ ]*\) [AB] __bss_stop$$/+0x\1/p') )) )
>  LDFLAGS_vmlinux = --defsym _kernel_bss_size=$(KBSS_SZ)
> @@ -165,7 +165,7 @@ $(obj)/bswapsdi2.S: $(srctree)/arch/$(SRCARCH)/lib/bswapsdi2.S
>  # The .data section is already discarded by the linker script so no need
>  # to bother about it here.
>  check_for_bad_syms = \
> -bad_syms=$$($(CROSS_COMPILE)nm $@ | sed -n 's/^.\{8\} [bc] \(.*\)/\1/p') && \
> +bad_syms=$$($(NM) $@ | sed -n 's/^.\{8\} [bc] \(.*\)/\1/p') && \
>  [ -z "$$bad_syms" ] || \
>    ( echo "following symbols must have non local/private scope:" >&2; \
>      echo "$$bad_syms" >&2; false )
> --
> 2.23.0
>


-- 
Thanks,
~Nick Desaulniers
