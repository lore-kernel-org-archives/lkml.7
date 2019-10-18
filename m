Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84DCACA9ECB
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 05:27:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58746222BD
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 05:27:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="XOKhHh0n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391330AbfJRF1f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 01:27:35 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35202 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726458AbfJRF1e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 01:27:34 -0400
Received: by mail-wm1-f67.google.com with SMTP id n124so1047857wmf.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 22:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I5uiLwmoQ+UosJLYhlwMFvtZSM4kU7jPQZOvk7J0zfE=;
        b=XOKhHh0naS5QNQVOxy3d8B/YfNidBHYJz3f1c7FjVlmosH5Qz36FN+IV9Ca20+vpCk
         Zkq22eYC6P2UKvSostC7Y69bl9ecqj9HwulutQKBKivrHtMd4ZiWIPxTs39U/rNghF+p
         cFdAI2F43Bl0FH9rkUx14qGaH0MAK05tdg2lPLn6M3DhWVk+V1QD23LVJoJpwuOyBbYZ
         VgAfmi08rDRpjl9Wz48HrY7fVRXd4LK3/8qbFc5kHWRu0vusRAoLBreiVNvBOQfUHdkC
         7JrRzXfe7Qz1CiONoX7vuUMOGtPSKvWW4/QQNEujMAnhDy68QKy2RtBCpm7av87tRvy8
         sVDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I5uiLwmoQ+UosJLYhlwMFvtZSM4kU7jPQZOvk7J0zfE=;
        b=ZrrU4kRNbQxBQlMZJ+t5NYxLrqNME/ScaEyLEYhmqYzLrOVFBC7DUgrusslCaWKxXa
         lqJbEaPkrz/FmzEH8x4stF2Vq7fzaWI2Mn4m702Scow9621SOxxBnyK/bozK7legyb0K
         +tCewwsmocnxTlfDoN6mpbzQkKfRnl//Yu6cTvx681g64r4EByXI/6hTCfATle602m8f
         6/IPTMTgloAj3DG7+7zIDrBM1zEmEos6FwGlR8yGtX7WcB51fPJXWPyNUmgbeemgoONF
         LN50J2UcFCRsHJ1/+J7tCPvEqqR7nwpBgNKdZDIgPdLyrvRWUqgEQ9g5nWhVcVIX1yb2
         kFfQ==
X-Gm-Message-State: APjAAAUd5SVWNJR2VkR3SkYRLJZ5bVkDkIMj2MlMyauPQ7pI6DGh0pOG
        4iiCOWvlHL26oYPjnqYVPp8HB7ZQ7xvyfkWlSQ24l2ba4ms=
X-Google-Smtp-Source: APXvYqwC5hCKaaCeEYsTe212j8USkNkltAjC/8925IVABeGi2fd2K3HeULgMknEhDTcF08C2TR11ZJ5PE+DAjdDdEPY=
X-Received: by 2002:a05:600c:214f:: with SMTP id v15mr5241260wml.177.1571367162336;
 Thu, 17 Oct 2019 19:52:42 -0700 (PDT)
MIME-Version: 1.0
References: <20191017173743.5430-1-hch@lst.de> <20191017173743.5430-5-hch@lst.de>
In-Reply-To: <20191017173743.5430-5-hch@lst.de>
From:   Anup Patel <anup@brainfault.org>
Date:   Fri, 18 Oct 2019 08:22:31 +0530
Message-ID: <CAAhSdy1VcrYNXW1b1QmA377i8aa1kQ=3pLPoVwuTv-gRYLHB1w@mail.gmail.com>
Subject: Re: [PATCH 04/15] riscv: don't allow selecting SBI based drivers for M-mode
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

On Thu, Oct 17, 2019 at 11:07 PM Christoph Hellwig <hch@lst.de> wrote:
>
> From: Damien Le Moal <damien.lemoal@wdc.com>
>
> When running in M-mode we can't use SBI based drivers.  Add a new
> CONFIG_RISCV_SBI that drivers that do SBI calls can depend on
> instead.
>
> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/riscv/Kconfig         | 6 ++++++
>  drivers/tty/hvc/Kconfig    | 2 +-
>  drivers/tty/serial/Kconfig | 2 +-
>  3 files changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 86b7e8b0471c..b85492c42ccb 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -76,6 +76,12 @@ config ARCH_MMAP_RND_BITS_MAX
>  config RISCV_M_MODE
>         bool
>
> +# set if we are running in S-mode and can use SBI calls
> +config RISCV_SBI
> +       bool
> +       depends on !RISCV_M_MODE
> +       default y
> +
>  config MMU
>         def_bool y
>
> diff --git a/drivers/tty/hvc/Kconfig b/drivers/tty/hvc/Kconfig
> index 4d22b911111f..4487a6b9acc8 100644
> --- a/drivers/tty/hvc/Kconfig
> +++ b/drivers/tty/hvc/Kconfig
> @@ -89,7 +89,7 @@ config HVC_DCC
>
>  config HVC_RISCV_SBI
>         bool "RISC-V SBI console support"
> -       depends on RISCV
> +       depends on RISCV_SBI
>         select HVC_DRIVER
>         help
>           This enables support for console output via RISC-V SBI calls, which
> diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
> index 67a9eb3f94ce..540142c5b7b3 100644
> --- a/drivers/tty/serial/Kconfig
> +++ b/drivers/tty/serial/Kconfig
> @@ -88,7 +88,7 @@ config SERIAL_EARLYCON_ARM_SEMIHOST
>
>  config SERIAL_EARLYCON_RISCV_SBI
>         bool "Early console using RISC-V SBI"
> -       depends on RISCV
> +       depends on RISCV_SBI
>         select SERIAL_CORE
>         select SERIAL_CORE_CONSOLE
>         select SERIAL_EARLYCON
> --
> 2.20.1
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup
