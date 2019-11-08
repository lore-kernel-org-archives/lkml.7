Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82694C17440
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 23:48:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F7B020865
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 23:48:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728124AbfKHXs5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 18:48:57 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:42544 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726231AbfKHXs5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 18:48:57 -0500
Received: by mail-ot1-f66.google.com with SMTP id b16so6687474otk.9
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2019 15:48:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XMVjsfRFCMgyyIBo6SJuyhGa3vmCkYAAcBk1J2DsBuY=;
        b=YOypcbEulcKRFNEeo74kAHj0uxzm2uvzEGicVDq789QS7jwPDKYLe6iejRXiN5RS14
         AS3tmmfmlkd6JibhHlSHzABdbSZwptFAF8AkImt13JGhC20vzYaEs9NDCz4oZPvEHT3L
         fvTsomaJVL/+D9gigwM5OCTRykq4/j+Sb6J6aigwNxV7tRcq27L071+Cc3IBu1/LNIY6
         43+H29zQx7JbxXl7m12GLqF6XZDUxiiAvHZD6QFtm6PfaUwLkumW/O1IhFPxcAg0XDa8
         P/BCODwIeN5VyLN4SpXyNID83UQhDHO6+ISQ4lQHS8l64fltjYVX1yTRU+mGwMXVRmML
         NDFQ==
X-Gm-Message-State: APjAAAUVc3fLXcAqbH5bML+mSYOjSuuxxBdQoZB8Ye1NAXkp21etU3/4
        0GOID/cAD/pL4wNnW2dkafBbqgmW9CE=
X-Google-Smtp-Source: APXvYqzfLa/na2KkCHcTsUpnCUBcHYiWwMmVFytQYAe3IU0LMQuGz0c+e5thdD/3/Ex+jy3pSzCTaA==
X-Received: by 2002:a9d:458a:: with SMTP id x10mr10711707ote.365.1573256935749;
        Fri, 08 Nov 2019 15:48:55 -0800 (PST)
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com. [209.85.210.46])
        by smtp.gmail.com with ESMTPSA id y14sm2342622otk.20.2019.11.08.15.48.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Nov 2019 15:48:55 -0800 (PST)
Received: by mail-ot1-f46.google.com with SMTP id 94so6677695oty.8
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2019 15:48:54 -0800 (PST)
X-Received: by 2002:a05:6830:17c2:: with SMTP id p2mr11400428ota.74.1573256934498;
 Fri, 08 Nov 2019 15:48:54 -0800 (PST)
MIME-Version: 1.0
References: <20191108130123.6839-1-linux@rasmusvillemoes.dk> <20191108130123.6839-48-linux@rasmusvillemoes.dk>
In-Reply-To: <20191108130123.6839-48-linux@rasmusvillemoes.dk>
From:   Li Yang <leoyang.li@nxp.com>
Date:   Fri, 8 Nov 2019 17:48:43 -0600
X-Gmail-Original-Message-ID: <CADRPPNQwnmPCh8nzQ5vBTLoieO-r2u0huh17mwcinhfhNgo04A@mail.gmail.com>
Message-ID: <CADRPPNQwnmPCh8nzQ5vBTLoieO-r2u0huh17mwcinhfhNgo04A@mail.gmail.com>
Subject: Re: [PATCH v4 47/47] soc: fsl: qe: remove PPC32 dependency from CONFIG_QUICC_ENGINE
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Qiang Zhao <qiang.zhao@nxp.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Scott Wood <oss@buserror.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 8, 2019 at 7:05 AM Rasmus Villemoes
<linux@rasmusvillemoes.dk> wrote:
>
> There are also ARM and ARM64 based SOCs with a QUICC Engine, and the
> core QE code as well as net/wan/fsl_ucc_hdlc and tty/serial/ucc_uart
> has now been modified to not rely on ppcisms.
>
> So extend the architectures that can select QUICC_ENGINE, and add the
> rather modest requirements of OF && HAS_IOMEM.
>
> The core code as well as the ucc_uart driver has been tested on an
> LS1021A (arm), and it has also been tested that the QE code still
> works on an mpc8309 (ppc).
>
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> ---
>  drivers/soc/fsl/qe/Kconfig | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/soc/fsl/qe/Kconfig b/drivers/soc/fsl/qe/Kconfig
> index cfa4b2939992..f1974f811572 100644
> --- a/drivers/soc/fsl/qe/Kconfig
> +++ b/drivers/soc/fsl/qe/Kconfig
> @@ -5,7 +5,8 @@
>
>  config QUICC_ENGINE
>         bool "QUICC Engine (QE) framework support"
> -       depends on FSL_SOC && PPC32
> +       depends on OF && HAS_IOMEM
> +       depends on PPC32 || ARM || ARM64 || COMPILE_TEST

Can you also add PPC64?  It is also used on some PPC64 platforms
(QorIQ T series).

>         select GENERIC_ALLOCATOR
>         select CRC32
>         help
> --
> 2.23.0
>
