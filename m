Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84349CA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 06:20:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56168206C2
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 06:20:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="h6kY1+sn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727106AbfJUGU6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 02:20:58 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39614 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbfJUGU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 02:20:57 -0400
Received: by mail-wr1-f65.google.com with SMTP id c6so165646wrm.6
        for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2019 23:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CdvcOGCYVL+T0dd/Qovdpy0EycQbYWDHOCHJnmgemls=;
        b=h6kY1+snCa9b1x7e/EgIjsAXXWChcSe7Uw0FjL6G+anKZpluVsnHZlfXHSt09rzA17
         7QEgstgPbNp7zGit5Kg6IcWlVJCjEQWPZhijlHGqzE9gZYmdrNfkbUvmJSjt7J9BNrVI
         iBrcqQELNZQolZpgXvm2krI6QCIE+5auETUijcAYUxxeV14FrPjKGIpTjQQ1uW5xGnK2
         rB//6di6mnksNQgm1xPuAgR98MBRjT/PtPVc/7XVHsjRva7gRDw9sCzJA2LXB2t3ypJ8
         2klWs/YFyTytVptXjN8BopBVvxJrkKyMYaLh0RglRJd0PZbT5T5vpgEG/gQbOEjzJNvh
         219Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CdvcOGCYVL+T0dd/Qovdpy0EycQbYWDHOCHJnmgemls=;
        b=mW4b84x3MCbhxr1hP0dL9EWCbWoGM/UFBSCbVH3lxXa4JAUbWuyh4wTCi5f8G7/Mb0
         2Vn19zW43iZj/bvVmUJqQ6Vc2oIkFHs4/uJJ8kqIQ7TH17SVj66MjpVsueuQHj9lNJzs
         MMYfxchz6RcObs3nPwfC+Lf1xVHW4EAQs22Ujd53j9q318gbAMWQTowxmcHz6fuCkQo1
         Vmd549WAeQkdnveBU0uiZ6u3QaK89mEvf0dRu1q4aHs+otbVYfo5KDVHswSrQtDA0s9Q
         KnqbLecYXsknQZ4ESpJ4gwuxTEQud4OKzvxl78S/Zuxog6DYWGjZqRaU3bSsuc70ul8Q
         SYcQ==
X-Gm-Message-State: APjAAAVnYCjlXTd8xjzt7vtYA4VJvEzKaG0MlQ6deTfmpY+ivUMKF6BD
        SjLI7PPI0foGiqm2GvJkRNfZaqjbqPs3NrFP4yGsWQ==
X-Google-Smtp-Source: APXvYqy24wsGU0Cj+4SmHZlaSf1uaZpL2g4+f87/+EJ/1iZO4TCaFGyxMrU8YBrf0ThCHUcVzuLjkwXTWadLECQwLMk=
X-Received: by 2002:a5d:43c9:: with SMTP id v9mr11140606wrr.200.1571638854218;
 Sun, 20 Oct 2019 23:20:54 -0700 (PDT)
MIME-Version: 1.0
References: <20191018161033.261971-1-samitolvanen@google.com> <20191018161033.261971-15-samitolvanen@google.com>
In-Reply-To: <20191018161033.261971-15-samitolvanen@google.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Mon, 21 Oct 2019 08:20:43 +0200
Message-ID: <CAKv+Gu-kMzsot5KSPSo_iMsuzcv8J1R5RLT9uGjuzJsxCVUPPg@mail.gmail.com>
Subject: Re: [PATCH 14/18] arm64: efi: restore x18 if it was corrupted
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
> If we detect a corrupted x18 and SCS is enabled, restore the register
> before jumping back to instrumented code.
>

You'll have to elaborate a bit here and explain that this is
sufficient, given that we run EFI runtime services with interrupts
enabled.

> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> ---
>  arch/arm64/kernel/efi-rt-wrapper.S | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm64/kernel/efi-rt-wrapper.S b/arch/arm64/kernel/efi-rt-wrapper.S
> index 3fc71106cb2b..945744f16086 100644
> --- a/arch/arm64/kernel/efi-rt-wrapper.S
> +++ b/arch/arm64/kernel/efi-rt-wrapper.S
> @@ -34,5 +34,10 @@ ENTRY(__efi_rt_asm_wrapper)
>         ldp     x29, x30, [sp], #32
>         b.ne    0f
>         ret
> -0:     b       efi_handle_corrupted_x18        // tail call
> +0:
> +#ifdef CONFIG_SHADOW_CALL_STACK
> +       /* Restore x18 before returning to instrumented code. */
> +       mov     x18, x2
> +#endif
> +       b       efi_handle_corrupted_x18        // tail call
>  ENDPROC(__efi_rt_asm_wrapper)
> --
> 2.23.0.866.gb869b98d4c-goog
>
