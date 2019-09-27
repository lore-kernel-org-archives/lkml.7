Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B43BC4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 13:52:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5354820872
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 13:52:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BWDIEsNT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727314AbfI0Nv7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 09:51:59 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:46521 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726540AbfI0Nv7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 09:51:59 -0400
Received: by mail-ed1-f66.google.com with SMTP id t3so2357680edw.13
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2019 06:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MYE8qdyxFm0ztb5uuaHx4J1GkCFYinNZTY4Kl0LQPJQ=;
        b=BWDIEsNTfybjsDuclGNqx21aWXtFvBBmIT7mfAfsNewSbILfAi3zAYiJtWF+Zu1p/Q
         cmyENcgbJa61q0M6toYfr8wX8kwVtb6KBB1jC/9txh3tz556EV/YUKI/GW6hCG/SQIyL
         w33Ca4CxcGQa/VvVk8Zco2/tvLw7nEXksqMtB2l3brNHr+JkfAr9GfKdwABbdouT9vQ5
         AkjlMUWgj3cGLBnSqFXu3k0hNj+fdjtC6HNoDsa+Cla71mkGPc1gAazzoVAEqueMQrqr
         vJSNvPQfKYDYVZxrGpBsG1VSNlnBZyUMsG0EAj5li7mkSFIjx/vjC/rXmAn53rbfXQt1
         T1/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MYE8qdyxFm0ztb5uuaHx4J1GkCFYinNZTY4Kl0LQPJQ=;
        b=jKgBNbQHH1t0Jzs/TgkpKplx4SHr5cxH8jambWBnxIvw5UnlRyliIkddRZIQzFCIZA
         oayCj0wEhLzq2rFRH040i1+W+qVWyQQVo7VDb+Y73oNWoPv+8ogT7ycKxecUMgnanKDq
         fSmnxju2t87REAwvEwLzUY32p8JubM+j/HcVsS5K9FpQ5OvH1KnYx4YnBvnkrtnq4qjN
         rI5tqxXVVV0R2lidX/GqCQ5svKcteyXOLmPdeLrG4lTSYYqGxCC2IhkyD0bIi27KHr/G
         x7xRZ1qQCH8M8c7NGEbwo8s2Ulv8PnMc3m/c1FaSFmaD62q+ZmqUj4GR0d6d2yqr+1RD
         S4Tg==
X-Gm-Message-State: APjAAAXf/sbkstr8gEUknrRM6I8KaW/r+a42UYVN/DBAwLAuzknch8Vz
        fS79VNfkcsHK3YiJfTxMK4RkLgpU1dB4pDt2XZ0=
X-Google-Smtp-Source: APXvYqxTh6F2mTH+sMfS5nE9IZzYKRDDa36nZNEP9qLcQ4guiE5X+LwTiyNuzVj8UJXdIhHVAq6vo8/EmzQOgiI8+QI=
X-Received: by 2002:a17:906:4e8f:: with SMTP id v15mr8223442eju.57.1569592315738;
 Fri, 27 Sep 2019 06:51:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190920164249.6935-1-ja.kaisrlik@gmail.com>
In-Reply-To: <20190920164249.6935-1-ja.kaisrlik@gmail.com>
From:   Jan Kaisrlik <ja.kaisrlik@gmail.com>
Date:   Fri, 27 Sep 2019 15:51:44 +0200
Message-ID: <CAPnxhu4=CZ+EH76uubVdRrE4MLpiRqfjyD-yFn3doSn_ymE1-A@mail.gmail.com>
Subject: Re: [PATCH] arm64: update Kconfig to better handle CMDLINE
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     catalin.marinas@arm.com, will@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ linux-kernel


On Fri, Sep 20, 2019 at 6:43 PM <ja.kaisrlik@gmail.com> wrote:
>
> From: Jan Kaisrlik <ja.kaisrlik@gmail.com>
>
> Added a menu to choose how to CMDLINE will be handled. Config strings
> were copied from arm32 port.
>
> Signed-off-by: Jan Kaisrlik <ja.kaisrlik@gmail.com>
> ---
>  arch/arm64/Kconfig | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 3adcec05b1f6..b1dd948f9665 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -1538,6 +1538,23 @@ config CMDLINE
>           entering them here. As a minimum, you should specify the the
>           root device (e.g. root=/dev/nfs).
>
> +choice
> +       prompt "Kernel command line type" if CMDLINE != ""
> +       default CMDLINE_FROM_BOOTLOADER
> +
> +config CMDLINE_FROM_BOOTLOADER
> +       bool "Use bootloader kernel arguments if available"
> +       help
> +         Uses the command-line options passed by the boot loader. If
> +         the boot loader doesn't provide any, the default kernel command
> +         string provided in CMDLINE will be used.
> +
> +config CMDLINE_EXTEND
> +       bool "Extend bootloader kernel arguments"
> +       help
> +         The command-line arguments provided by the boot loader will be
> +         appended to the default kernel command string.
> +
>  config CMDLINE_FORCE
>         bool "Always use the default kernel command string"
>         help
> @@ -1545,6 +1562,7 @@ config CMDLINE_FORCE
>           loader passes other arguments to the kernel.
>           This is useful if you cannot or don't want to change the
>           command-line options your boot loader passes to the kernel.
> +endchoice
>
>  config EFI_STUB
>         bool
> --
> 2.23.0
>
