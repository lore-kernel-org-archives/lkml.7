Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F65CCA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 06:22:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D49E5206C2
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 06:22:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GjbUSEjv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbfJUGWB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 02:22:01 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55395 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbfJUGWB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 02:22:01 -0400
Received: by mail-wm1-f68.google.com with SMTP id g24so2590672wmh.5
        for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2019 23:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uyhVv4N2UiJ3EJxpaNQCWc5NdrhC/9AoAL7jZ85/7b8=;
        b=GjbUSEjvkAF47IsFWgAUnfSwZ9jZeOmpmmzg8L/6guVX38gCMZuouTdMO5Iji6ewM0
         ZcqaKKfluXkc0GCek0xGcyop4JHYb97Q/n3Eqc7ah2EKKHr0N7BGDs851PPpZHuHqzCj
         Az8WGOd2xhVAFxxTDg1R2UqIdUdRXgD25JY9oY8pXU6I6vVvsfZ0aFENdmAVqf4UnUr8
         lcQmqiLBmmkWCuTPfA0TxotJre4XtMv52V1BrM2hzvGfc4Miftl70l+50k9K9NVhoe2J
         xX9Fh2F8N7Dj2Pl0njY0mgUTPdAzdCBXsCb1ksBM0pvjzMtLDB5366phzKtAZjRMiTXL
         ANmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uyhVv4N2UiJ3EJxpaNQCWc5NdrhC/9AoAL7jZ85/7b8=;
        b=Jrt87ALWP9NYLCnx+UsBbnl2vKVpFYBV80CdFI6rM3EQpKCh8ORpfm70V5Yh5y0uTw
         4oaE0ZABgDNlNZecJS6l1fB4Yl3rnyf/VNWGQ3heHkJ9KxP/X7NB9XR9jhoScVHbctJV
         4Ppc3d8lD/tzGP8PahzcUB1+orj43tkEcCeaU59ucZEkLKKeoHd7gIDeWHIJWZquUzXR
         2oFiP0P1beQ6SrxWifevwoE2QVBaCt5TxS4dZXd7/P2NfcW9jnkwzgTS9aKCyZDZVk+V
         iLCT+8vfvXIcVYc6Cl8Nj5M34E7d3nUPYvlQYhlPe7F7btB1BPa6YL0jCF5znEHvk+bo
         5vRg==
X-Gm-Message-State: APjAAAUTBriTmDVlVbQTURUH7lycqIUbA0Ddt+WZSiuNJY8JEeCACU7v
        YS1N5NniQ5hdfajRyQBkyPtHAUGJ23IaRdLIGBkZfg==
X-Google-Smtp-Source: APXvYqx9wfbsml6zIZvtLXulYaMSgitt7ok8Qfrnv+GkD+c5R91Idi9S9ZV+WgZk06tMxv4wXfJaROot0zqVv9/hG5E=
X-Received: by 2002:a7b:c925:: with SMTP id h5mr1847720wml.61.1571638919306;
 Sun, 20 Oct 2019 23:21:59 -0700 (PDT)
MIME-Version: 1.0
References: <20191018161033.261971-1-samitolvanen@google.com> <20191018161033.261971-17-samitolvanen@google.com>
In-Reply-To: <20191018161033.261971-17-samitolvanen@google.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Mon, 21 Oct 2019 08:21:48 +0200
Message-ID: <CAKv+Gu-88USO+fbjBgj35B4fUQ7A_t9nHO_swyN=T1q1G2wViA@mail.gmail.com>
Subject: Re: [PATCH 16/18] arm64: kprobes: fix kprobes without CONFIG_KRETPROBES
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Dave Martin <Dave.Martin@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Laura Abbott <labbott@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Oct 2019 at 18:11, Sami Tolvanen <samitolvanen@google.com> wrote:
>
> This allows CONFIG_KRETPROBES to be disabled without disabling
> kprobes entirely.
>
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

Can we make kretprobes work with the shadow call stack instead?

> ---
>  arch/arm64/kernel/probes/kprobes.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/arm64/kernel/probes/kprobes.c b/arch/arm64/kernel/probes/kprobes.c
> index c4452827419b..98230ae979ca 100644
> --- a/arch/arm64/kernel/probes/kprobes.c
> +++ b/arch/arm64/kernel/probes/kprobes.c
> @@ -551,6 +551,7 @@ void __kprobes __used *trampoline_probe_handler(struct pt_regs *regs)
>         return (void *)orig_ret_address;
>  }
>
> +#ifdef CONFIG_KRETPROBES
>  void __kprobes arch_prepare_kretprobe(struct kretprobe_instance *ri,
>                                       struct pt_regs *regs)
>  {
> @@ -564,6 +565,7 @@ int __kprobes arch_trampoline_kprobe(struct kprobe *p)
>  {
>         return 0;
>  }
> +#endif
>
>  int __init arch_init_kprobes(void)
>  {
> --
> 2.23.0.866.gb869b98d4c-goog
>
