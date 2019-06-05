Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86A4AC28CC5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 11:32:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 666E920717
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 11:32:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727483AbfFELcv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 07:32:51 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:37007 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727289AbfFELcv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 07:32:51 -0400
Received: by mail-ot1-f65.google.com with SMTP id r10so389266otd.4
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2019 04:32:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gKIrzdoUs9Q5HqSQ9aF++SWQgmsoIMMP53yLp9JAEhA=;
        b=ASxSrmtV8oqK/ZrUUrLAnKBya9OZ/o3Il8yH+huWIb/QH7zeWh9Rh+cP7EZqXIdRAU
         NoQaXqlZQ9TKgmWJ3UJZvdJvtMQUYSNuPhvMiywhK8dGUKKppclgHcW+/G5IpEXUVOMk
         MZMS+sW3UQ3ys/GwXXHqpqgtDs0pUF0Pw4CBMQ6BW5/6jhE1/9cjNhTvFCQP92Roq/LC
         uENooC2Xd0TKfxdYypMkLzuU8WeHW+E3sdf8QKYZWwfMoDczuKyxBwq8Gb+cNXI+936B
         JIM6Gm3irK0Zoose0QBWX7SK0GbDrT3AfOOOc6OhVCfwwEzNCa2tlI065qrrivns56f3
         MfwQ==
X-Gm-Message-State: APjAAAWnDH04ikYPRZr9w3DNJ/9n94O8BrCVxeb06U7RSEzPSgXIXTfc
        d/o8DNh4o5tUIt7JlDqIUpvos/s1ShnGxokGHPVQVPeW
X-Google-Smtp-Source: APXvYqz+JZW2+VQCD6Erxe5NqzDpmFjd4VjgArIo0C0WgsuCGX5oKZ7QMpJqVs3/r9yA8gOMHCxJc6awbkEujZVMQjU=
X-Received: by 2002:a9d:7987:: with SMTP id h7mr9178825otm.284.1559734370049;
 Wed, 05 Jun 2019 04:32:50 -0700 (PDT)
MIME-Version: 1.0
References: <90d30adb0943a11ab127808c03229ba657478df4.1559566521.git.christophe.leroy@c-s.fr>
In-Reply-To: <90d30adb0943a11ab127808c03229ba657478df4.1559566521.git.christophe.leroy@c-s.fr>
From:   Mathieu Malaterre <malat@debian.org>
Date:   Wed, 5 Jun 2019 13:32:39 +0200
Message-ID: <CA+7wUswvw3JJ2dLCn877tNbTd==O5c9LxHGezOm+y5otQZnS2w@mail.gmail.com>
Subject: Re: [PATCH] powerpc/32s: fix booting with CONFIG_PPC_EARLY_DEBUG_BOOTX
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        LKML <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 3, 2019 at 3:00 PM Christophe Leroy <christophe.leroy@c-s.fr> wrote:
>
> When booting through OF, setup_disp_bat() does nothing because
> disp_BAT are not set. By change, it used to work because BOOTX
> buffer is mapped 1:1 at address 0x81000000 by the bootloader, and
> btext_setup_display() sets virt addr same as phys addr.
>
> But since commit 215b823707ce ("powerpc/32s: set up an early static
> hash table for KASAN."), a temporary page table overrides the
> bootloader mapping.
>
> This 0x81000000 is also problematic with the newly implemented
> Kernel Userspace Access Protection (KUAP) because it is within user
> address space.
>
> This patch fixes those issues by properly setting disp_BAT through
> a call to btext_prepare_BAT(), allowing setup_disp_bat() to
> properly setup BAT3 for early bootx screen buffer access.
>
> Reported-by: Mathieu Malaterre <malat@debian.org>
> Fixes: 215b823707ce ("powerpc/32s: set up an early static hash table for KASAN.")
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

The patch below does fix the symptoms I reported. Tested with CONFIG_KASAN=n :

Tested-by: Mathieu Malaterre <malat@debian.org>

Thanks !

> ---
>  arch/powerpc/include/asm/btext.h       | 4 ++++
>  arch/powerpc/kernel/prom_init.c        | 1 +
>  arch/powerpc/kernel/prom_init_check.sh | 2 +-
>  3 files changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/include/asm/btext.h b/arch/powerpc/include/asm/btext.h
> index 3ffad030393c..461b0f193864 100644
> --- a/arch/powerpc/include/asm/btext.h
> +++ b/arch/powerpc/include/asm/btext.h
> @@ -13,7 +13,11 @@ extern void btext_update_display(unsigned long phys, int width, int height,
>                                  int depth, int pitch);
>  extern void btext_setup_display(int width, int height, int depth, int pitch,
>                                 unsigned long address);
> +#ifdef CONFIG_PPC32
>  extern void btext_prepare_BAT(void);
> +#else
> +static inline void btext_prepare_BAT(void) { }
> +#endif
>  extern void btext_map(void);
>  extern void btext_unmap(void);
>
> diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
> index 3555cad7bdde..ed446b7ea164 100644
> --- a/arch/powerpc/kernel/prom_init.c
> +++ b/arch/powerpc/kernel/prom_init.c
> @@ -2336,6 +2336,7 @@ static void __init prom_check_displays(void)
>                         prom_printf("W=%d H=%d LB=%d addr=0x%x\n",
>                                     width, height, pitch, addr);
>                         btext_setup_display(width, height, 8, pitch, addr);
> +                       btext_prepare_BAT();
>                 }
>  #endif /* CONFIG_PPC_EARLY_DEBUG_BOOTX */
>         }
> diff --git a/arch/powerpc/kernel/prom_init_check.sh b/arch/powerpc/kernel/prom_init_check.sh
> index 518d416971c1..160bef0d553d 100644
> --- a/arch/powerpc/kernel/prom_init_check.sh
> +++ b/arch/powerpc/kernel/prom_init_check.sh
> @@ -24,7 +24,7 @@ fi
>  WHITELIST="add_reloc_offset __bss_start __bss_stop copy_and_flush
>  _end enter_prom $MEM_FUNCS reloc_offset __secondary_hold
>  __secondary_hold_acknowledge __secondary_hold_spinloop __start
> -logo_linux_clut224
> +logo_linux_clut224 btext_prepare_BAT
>  reloc_got2 kernstart_addr memstart_addr linux_banner _stext
>  __prom_init_toc_start __prom_init_toc_end btext_setup_display TOC."
>
> --
> 2.13.3
>
