Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 623FCCA9ED0
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 05:01:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3150A21897
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 05:01:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="19h/jLrd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409545AbfJRFBH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 01:01:07 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40361 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407184AbfJRFBG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 01:01:06 -0400
Received: by mail-wr1-f68.google.com with SMTP id o28so4690518wro.7
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 22:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9yj5eEKEUBkc8EGiDNUkG6uoCF1b8NJEVMhQxadJQgw=;
        b=19h/jLrdlN0B0n8LD8ZZQQHpidcoIaOwMafQQWuaDBcFghw3DpbmISFkIZf6JbOeJY
         HflrdbPbT0Y81K+zDisvGr/7nGSCcI9+c9LxtNdnjeIkrttEwlV1gof5CXb5NKRTszqE
         Gyimc1zuhUD2XrxIxEEdFgjEOAytYe1Uwlp5zfRwNYYj/1mggw4xcTogycK4uDNiDS9C
         3W9IIft16YhFIpE8CT0RvgU241dSnGZXG8JbhxF/st0rCeuLPktc9JG9eztKFdQG0GHb
         ONC4dNvNaHRIjqrAFPo6W5osvgrgdl5IM29T796hQ5L6voXRWbbApWvz8iMsuN1R8Vmz
         xPYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9yj5eEKEUBkc8EGiDNUkG6uoCF1b8NJEVMhQxadJQgw=;
        b=Mkum6Xs20hT95fDB9wMc9/j1vMJaR13kQWVvXFY6fdRuzNyg8rJwFyzyMI+JbbxH+q
         0iSefpYYGgKg64yHW3tIKYnAqErDQZNApI6agm0DNkrsk1Kg4hsg0uMR0xfETzE0xiVn
         NPKGaYfRfN0WMMlQp5Sjxa7uV00pWjcFaH8mo0XMcjG/GOvAzbZMhGbj+DUBTzTysxYK
         YOyV4cb4NUdg8d19aeVGFBtzANNeaV8/K37/38pOpyIeTY3SK+eccSp8UP1fpXqrhPoA
         07DoRonSnts1I4JtVZG8gwGIX4Aq/kr6q1fotCCgh7UsUP/fEbkLLa8BL0dId6bQg7nb
         cJ1Q==
X-Gm-Message-State: APjAAAU9ojBLOqCYlo9ClPSGtkzfrWGovrDQ5svAn4uY0l42yNxIDO/t
        ezkRVyMvD+B2HKd6O00jbWbnueX1CcEJZ3sZizyPnv2ALqk=
X-Google-Smtp-Source: APXvYqxzFrI5UMyMA5aJQHly/DUWh4eyoWG75O+lClRwzR/dl8s+0ZTRewFo4nozKJArAmHorKplmEuTajXS2YvtoMg=
X-Received: by 2002:a5d:42c2:: with SMTP id t2mr5364797wrr.251.1571368004794;
 Thu, 17 Oct 2019 20:06:44 -0700 (PDT)
MIME-Version: 1.0
References: <20191017173743.5430-1-hch@lst.de> <20191017173743.5430-15-hch@lst.de>
In-Reply-To: <20191017173743.5430-15-hch@lst.de>
From:   Anup Patel <anup@brainfault.org>
Date:   Fri, 18 Oct 2019 08:36:33 +0530
Message-ID: <CAAhSdy01FReApQOPY5B8jcZ34pyWaLpYok_+7G+hEvFKwhC4bQ@mail.gmail.com>
Subject: Re: [PATCH 14/15] riscv: provide a flat image loader
To:     Christoph Hellwig <hch@lst.de>
Cc:     Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 17, 2019 at 11:08 PM Christoph Hellwig <hch@lst.de> wrote:
>
> This allows just loading the kernel at a pre-set address without
> qemu going bonkers trying to map the ELF file.
>
> Contains a controbution from Aurabindo Jayamohanan to reuse the
> PAGE_OFFSET definition.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/riscv/Makefile          | 13 +++++++++----
>  arch/riscv/boot/Makefile     |  7 ++++++-
>  arch/riscv/boot/loader.S     |  8 ++++++++
>  arch/riscv/boot/loader.lds.S | 16 ++++++++++++++++
>  4 files changed, 39 insertions(+), 5 deletions(-)
>  create mode 100644 arch/riscv/boot/loader.S
>  create mode 100644 arch/riscv/boot/loader.lds.S
>
> diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
> index f5e914210245..b9009a2fbaf5 100644
> --- a/arch/riscv/Makefile
> +++ b/arch/riscv/Makefile
> @@ -83,13 +83,18 @@ PHONY += vdso_install
>  vdso_install:
>         $(Q)$(MAKE) $(build)=arch/riscv/kernel/vdso $@
>
> -all: Image.gz
> +ifeq ($(CONFIG_RISCV_M_MODE),y)
> +KBUILD_IMAGE := $(boot)/loader
> +else
> +KBUILD_IMAGE := $(boot)/Image.gz
> +endif
> +BOOT_TARGETS := Image Image.gz loader
>
> -Image: vmlinux
> -       $(Q)$(MAKE) $(build)=$(boot) $(boot)/$@
> +all:   $(notdir $(KBUILD_IMAGE))
>
> -Image.%: Image
> +$(BOOT_TARGETS): vmlinux
>         $(Q)$(MAKE) $(build)=$(boot) $(boot)/$@
> +       @$(kecho) '  Kernel: $(boot)/$@ is ready'
>
>  zinstall install:
>         $(Q)$(MAKE) $(build)=$(boot) $@
> diff --git a/arch/riscv/boot/Makefile b/arch/riscv/boot/Makefile
> index 0990a9fdbe5d..8639e0dd2cdf 100644
> --- a/arch/riscv/boot/Makefile
> +++ b/arch/riscv/boot/Makefile
> @@ -16,7 +16,7 @@
>
>  OBJCOPYFLAGS_Image :=-O binary -R .note -R .note.gnu.build-id -R .comment -S
>
> -targets := Image
> +targets := Image loader
>
>  $(obj)/Image: vmlinux FORCE
>         $(call if_changed,objcopy)
> @@ -24,6 +24,11 @@ $(obj)/Image: vmlinux FORCE
>  $(obj)/Image.gz: $(obj)/Image FORCE
>         $(call if_changed,gzip)
>
> +loader.o: $(src)/loader.S $(obj)/Image
> +
> +$(obj)/loader: $(obj)/loader.o $(obj)/Image $(obj)/loader.lds FORCE
> +       $(Q)$(LD) -T $(src)/loader.lds -o $@ $(obj)/loader.o
> +
>  install:
>         $(CONFIG_SHELL) $(srctree)/$(src)/install.sh $(KERNELRELEASE) \
>         $(obj)/Image System.map "$(INSTALL_PATH)"
> diff --git a/arch/riscv/boot/loader.S b/arch/riscv/boot/loader.S
> new file mode 100644
> index 000000000000..5586e2610dbb
> --- /dev/null
> +++ b/arch/riscv/boot/loader.S
> @@ -0,0 +1,8 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +       .align 4
> +       .section .payload, "ax", %progbits
> +       .globl _start
> +_start:
> +       .incbin "arch/riscv/boot/Image"
> +
> diff --git a/arch/riscv/boot/loader.lds.S b/arch/riscv/boot/loader.lds.S
> new file mode 100644
> index 000000000000..47a5003c2e28
> --- /dev/null
> +++ b/arch/riscv/boot/loader.lds.S
> @@ -0,0 +1,16 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#include <asm/page.h>
> +
> +OUTPUT_ARCH(riscv)
> +ENTRY(_start)
> +
> +SECTIONS
> +{
> +       . = PAGE_OFFSET;
> +
> +       .payload : {
> +               *(.payload)
> +               . = ALIGN(8);
> +       }
> +}
> --
> 2.20.1
>

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup
