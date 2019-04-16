Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58AEBC10F0E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 03:23:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 278AD20868
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 03:23:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EIDu9VBM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726684AbfDPDXo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 23:23:44 -0400
Received: from mail-vk1-f195.google.com ([209.85.221.195]:34589 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726214AbfDPDXn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 23:23:43 -0400
Received: by mail-vk1-f195.google.com with SMTP id x84so4117883vkd.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2019 20:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gEc6RSrTv8OkG4Xv9qNrDhE3A/ZV8wCYsiS9vzqwUUU=;
        b=EIDu9VBMPmOoEa3D47obgN22EGFQcR/ZNUcE8oGSi1qWO67ppq1dsB7GtIZRLDCUuh
         yLonBkGUMZopRZP9/raMRZ0jTjMMDyVUfB8C0SvtSwKUT1g/35tlZGeCCwbDz34fVja7
         RfOj8EP31+zaNs0ZUd1Fuik/jgi2Fnx6VNfH4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gEc6RSrTv8OkG4Xv9qNrDhE3A/ZV8wCYsiS9vzqwUUU=;
        b=WNZqnhCV0leWYHv28rwiIMeahSU3zh/oTg9nAfF5CiTrkNPZY0kHf983o0ecHUMgDl
         xQoewuKWEtyCLEvgFWZI1xgooG5owTozAdaA4bimdcWNk9UFS3P1aeGptMLzN+9d0d1j
         Rr5BZ/LNG0ptqZz7u5AHP6XZ2SDjhS87vjfeisqy2oBwmnsImvBRu4LkRXJWXUMJ0hc4
         dfe2TQDat2UCrXxFcLyxkwLd8mk428ooRDt4B14aKuR9dXoiP9BYOaCfRl6a3feuHH98
         GGJU/p4wgMzZBsxaNF7ogS/xJw8TvFfuCICMUO/xTVF/gjtJ2J9UkCyFsR3xWu958eDE
         DtVg==
X-Gm-Message-State: APjAAAWttl2W/iWLQRtionzePRT+KvdhYhv4RuxLdbQpoZZF8SJ0RdJ4
        ZiedWACXm6Iva+i00USM0m7DDlPC810=
X-Google-Smtp-Source: APXvYqzH9hKA2y+rNVza2JjUdBtR4ROZ0cZU4HIWak8+hvCfNdc4jrne3+aGcZ97KaA/naP2qWkXrw==
X-Received: by 2002:a1f:8991:: with SMTP id l139mr39160173vkd.49.1555385021992;
        Mon, 15 Apr 2019 20:23:41 -0700 (PDT)
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com. [209.85.221.179])
        by smtp.gmail.com with ESMTPSA id 20sm10474128uas.15.2019.04.15.20.23.40
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Apr 2019 20:23:41 -0700 (PDT)
Received: by mail-vk1-f179.google.com with SMTP id h71so4119479vkf.5
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2019 20:23:40 -0700 (PDT)
X-Received: by 2002:a1f:7d4e:: with SMTP id y75mr42015570vkc.53.1555385020477;
 Mon, 15 Apr 2019 20:23:40 -0700 (PDT)
MIME-Version: 1.0
References: <20190415164956.124067-1-samitolvanen@google.com>
In-Reply-To: <20190415164956.124067-1-samitolvanen@google.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Mon, 15 Apr 2019 22:23:28 -0500
X-Gmail-Original-Message-ID: <CAGXu5jJ_UM3-9r+NHDmOWk1XxbO8c_=guzZEGrsGFWWv0z_bZA@mail.gmail.com>
Message-ID: <CAGXu5jJ_UM3-9r+NHDmOWk1XxbO8c_=guzZEGrsGFWWv0z_bZA@mail.gmail.com>
Subject: Re: [PATCH] x86: fix .bss with -fdata-sections
To:     Sami Tolvanen <samitolvanen@google.com>,
        Ingo Molnar <mingo@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Nicholas Piggin <npiggin@gmail.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 15, 2019 at 11:50 AM Sami Tolvanen <samitolvanen@google.com> wrote:
>
> With LD_DEAD_CODE_DATA_ELIMINATION, we compile the kernel with
> -fdata-sections, which also splits the .bss section. Use the
> common BSS_MAIN macro in the linker script to properly merge all
> the generated sections.
>
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

Nice work tracking this down! :)

Reviewed-by: Kees Cook <keescook@chromium.org>

Nit/tweak/clarification for commit title:
    x86/build: Fix truncated .bss with -fdata-sections

-Kees

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


-- 
Kees Cook
