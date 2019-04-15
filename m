Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A6FDC10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 17:33:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EAE8206B6
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 17:33:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pPCIyA7x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727927AbfDORdq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 13:33:46 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38892 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726956AbfDORdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 13:33:45 -0400
Received: by mail-pg1-f195.google.com with SMTP id j26so8913261pgl.5
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2019 10:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1rLnkkecNajwW5lyTPKV/XOLxMWuUEA0pe+C9AUPzqY=;
        b=pPCIyA7xNkZnsePL5+Cqm3wLsoFRWlTwwEiM5RaUEPm/1cFDJrA+Aklc1Jnk9pzOil
         yc2YG8CdtT8rABcieGpAuU9OS4uIJYh//RGprmb5JhS9M/STWkfASpY/WrY/jWkggiw4
         iyhvR6eqdTeFA/y/8fUno43FZQjW+1G3N+jcpE4PnZnPA6imzUQJbb771bCUgBzQQk5H
         w6D/Zb3B2t/E9j/n/VTuU9cCOJmcHaMmuwCu0iMURnBoG6/t34R/65Eqk7n4PFpGyTQ4
         iwn8XLSlZelk7oUCskdOaoScv4GMozaPyPPQN30W+mCj8ZKxQlCu5v4emiHaEz1sPS2U
         dyfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1rLnkkecNajwW5lyTPKV/XOLxMWuUEA0pe+C9AUPzqY=;
        b=KcmgyXUtk8PEBfLArim1QUq6X0tEZZCcXetehjUJY82LvC4DOrx2wNOlouR7XmYvO6
         9FP8EkK0EDivgJM5eAkQXR7yjqtVCy2PXgebWi+PIllc68ut1pZC2PiTcmq7Q9xCav0w
         JF3HySl/PxapB4MgeDjA/uxl4ESmtZohMqFd/8bg3Mhvxl03M8S/vkZLBD+JI4tbyO72
         anPlYnY7JHX7eFaIH2GE9WNXXriWikAAy9zwBm+dw06dMyz6+3/4yfemVWVYYd/jufcB
         WhJDH+sHb8F3TrG6se3uFd7G3gKrTjDt23OP6vSdM2jX1rFDGIn/kOYVWhM4z244wPXM
         7mMw==
X-Gm-Message-State: APjAAAUtBhDU5ecs1V9Ezp1Bg4d5TnQleL/81UIVSPbG6CSZr21FzApG
        fgs5zCeNaqzm+Brhb2wGh3wMkmEGTtlonwVRVeWI2Q==
X-Google-Smtp-Source: APXvYqy5T0kFXqo6biJZQb0aLThl4ni7kXyk02WJzRMTj/UYwyU4Y+eMwKRbHgcKyQv6Y/zgADgGug/kNsK+UFStR+w=
X-Received: by 2002:a65:5304:: with SMTP id m4mr70495317pgq.281.1555349624322;
 Mon, 15 Apr 2019 10:33:44 -0700 (PDT)
MIME-Version: 1.0
References: <20190415164956.124067-1-samitolvanen@google.com>
In-Reply-To: <20190415164956.124067-1-samitolvanen@google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 15 Apr 2019 10:33:33 -0700
Message-ID: <CAKwvOdm=+jnvqeUOmSUY=OA9sWV53mvnEeWss2TVC+=GS2-AWw@mail.gmail.com>
Subject: Re: [PATCH] x86: fix .bss with -fdata-sections
To:     Sami Tolvanen <samitolvanen@google.com>,
        Nicholas Piggin <npiggin@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 15, 2019 at 9:50 AM Sami Tolvanen <samitolvanen@google.com> wrote:
>
> With LD_DEAD_CODE_DATA_ELIMINATION, we compile the kernel with
> -fdata-sections, which also splits the .bss section. Use the
> common BSS_MAIN macro in the linker script to properly merge all
> the generated sections.
>
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> ---
>  arch/x86/kernel/vmlinux.lds.S | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
> index bad8c51fee6e..a5127b2c195f 100644
> --- a/arch/x86/kernel/vmlinux.lds.S
> +++ b/arch/x86/kernel/vmlinux.lds.S
> @@ -362,7 +362,7 @@ SECTIONS
>         .bss : AT(ADDR(.bss) - LOAD_OFFSET) {
>                 __bss_start = .;
>                 *(.bss..page_aligned)
> -               *(.bss)
> +               *(BSS_MAIN)
>                 BSS_DECRYPTED
>                 . = ALIGN(PAGE_SIZE);
>                 __bss_stop = .;
> --
> 2.21.0.392.gf8f6787159e-goog
>

Thanks for the patch!  I checked as well that this issue doesn't exist
for .text, .data, .sdata, .rodata, and .sbss; just .bss had this
issue.  Looks like this is "no functional change" when
CONFIG_LD_DEAD_CODE_DATA_ELIMINATION is not set; it simply fixes the
case where CONFIG_LD_DEAD_CODE_DATA_ELIMINATION=y.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

Nicholas,
I don't understand the comment about RODATA_MAIN from commit
266ff2a8f51f ("kbuild: Fix asm-generic/vmlinux.lds.h for
LD_DEAD_CODE_DATA_ELIMINATION").  It seems that there are no uses of
RODATA_MAIN in the kernel.  Can we remove its definition and that
comment? (That's neither here nor there for this patch).
-- 
Thanks,
~Nick Desaulniers
