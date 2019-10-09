Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CC2AECE58D
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 14:11:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1411721848
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 14:11:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rXBWxnxt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731317AbfJIOLU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 10:11:20 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54058 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729644AbfJIOLT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 10:11:19 -0400
Received: by mail-wm1-f65.google.com with SMTP id i16so2796594wmd.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 07:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IfzmZhp36WpTVFDJFrKg1q1OTVja9xjnVrTlka/Jkoc=;
        b=rXBWxnxtuK+619VAVXoKS+DxsBa9UqJ7nfRNBcS2Sz4XI5ZQ6Hw8QwSDlqpW05k9eA
         u9gld6jlBbewvfS51nf5OFVC/a+LQIB6CuaaXNjWixic5MnQZvut2Bv+qWHX2LVAC4k0
         fHt9MT4y8YaPU1k2ecpQ1spQAjEqNJ9n8x8fx1LKnzmuemvO+UXUJv1/TouqPyZwO+KG
         nERyMqKdNVU2hHZLDMJ/Ehy9tnUAF0umDOwh8zb8aITfSgaY8toVe4iwMQx9PSwQHa4D
         6arjQMc6CsuR3/NeKO1u3tNpuCCorVcoglK8+XO7sO2mad/ddObthg86fus9JfH2XK94
         qxGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IfzmZhp36WpTVFDJFrKg1q1OTVja9xjnVrTlka/Jkoc=;
        b=kXo2e0y/LY6hD6ZWzRm1g144VUHgDl4aNExmEvTyZaT/Bk/435PMr/+Hk5zi8/2x64
         ZnzH9mND5wHmvCijQn6XRyxZzdXNSALDq9dUTNhRzDbQ6uQR5nPPwZhsJ7Z/S8CfbTI9
         W4MyWIoE9vxdfCDa95XFRJl3f7h3x54TUpKeSpASgmNO1Y7eNQFRP4sAUuIB+8H+usq2
         zrXmUcVU/7nqVMnVZ+XRZDX20RgshXwdwyonnK9KthAam/wDBE81h7EWVQ/i8y/WM29F
         sV27Q7LEJ7EJT5vosKRGy5etWlxdUeAjXNwIyrJUcG8azx88/ulugzVrbGCfEuiNZ+Jw
         8YtQ==
X-Gm-Message-State: APjAAAUKWAdMiqDnXM599ltIYf/m+r2HYfxRz43b1TrSes0p0qkKT54j
        1d+oTflfXyDHPx0LnYtJUesUQmgldvk5t0SVjFjfmw==
X-Google-Smtp-Source: APXvYqwDjV9Fg1lr9K+PEMuIeJ8FN7Fcu2NkkOGfxXp13qEHX+6TJYJ7EfF6XxgXCEW3E2563Mm8g5LqtpMA35qiQg0=
X-Received: by 2002:a05:600c:2214:: with SMTP id z20mr2945175wml.10.1570630276021;
 Wed, 09 Oct 2019 07:11:16 -0700 (PDT)
MIME-Version: 1.0
References: <20191002194346.GA3792@localhost.localdomain>
In-Reply-To: <20191002194346.GA3792@localhost.localdomain>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Wed, 9 Oct 2019 16:11:04 +0200
Message-ID: <CAKv+Gu9_xX3RgDNGB=T83vhg_snMKe0F2YPKp1S2o2toNHHZZQ@mail.gmail.com>
Subject: Re: [PATCH] Ask user input only when CONFIG_X86 or
 CONFIG_COMPILE_TEST is set to y
To:     Narendra K <Narendra.K@dell.com>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Mario Limonciello <Mario.Limonciello@dell.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        James Morse <james.morse@arm.com>,
        Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Narendra,

On Wed, 2 Oct 2019 at 21:44, <Narendra.K@dell.com> wrote:
>
> From: Narendra K <Narendra.K@dell.com>
>
> For the EFI_RCI2_TABLE kconfig option, 'make oldconfig' asks the user
> for input as it is a new kconfig option in kernel version 5.4. This patch
> modifies the kconfig option to ask the user for input only when CONFIG_X86
> or CONFIG_COMPILE_TEST is set to y.
>
> The patch also makes EFI_RCI2_TABLE kconfig option depend on CONFIG_EFI.
>
> Signed-off-by: Narendra K <Narendra.K@dell.com>
> ---
> The patch is created on kernel version 5.4-rc1.
>
> Hi Ard, I have made following changes -
>
> - changed the prompt string from "EFI Runtime Configuration
> Interface Table Version 2 Support" to "EFI RCI Table Version 2 Support"
> as the string crossed 80 char limit.
>
> - added "depends on EFI" so that code builds only when CONFIG_EFI is
> set to y.
>
> - added 'default n' for ease of understanding though default is set to n.
>

None of these changes are necessary, tbh. 'depends on EFI' is implied
by the placement of the option, and default n is indeed the default.


>  drivers/firmware/efi/Kconfig | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/firmware/efi/Kconfig b/drivers/firmware/efi/Kconfig
> index 178ee8106828..6e4c46e8a954 100644
> --- a/drivers/firmware/efi/Kconfig
> +++ b/drivers/firmware/efi/Kconfig
> @@ -181,7 +181,10 @@ config RESET_ATTACK_MITIGATION
>           reboots.
>
>  config EFI_RCI2_TABLE
> -       bool "EFI Runtime Configuration Interface Table Version 2 Support"
> +       bool
> +       prompt "EFI RCI Table Version 2 Support" if X86 || COMPILE_TEST

You can drop the || COMPILE_TEST as well.
> +       depends on EFI
> +       default n
>         help
>           Displays the content of the Runtime Configuration Interface
>           Table version 2 on Dell EMC PowerEdge systems as a binary
> --
> 2.18.1
>
> --
> With regards,
> Narendra K
