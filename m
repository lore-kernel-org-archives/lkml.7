Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07614C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 14:34:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0BA92084F
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 14:34:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388663AbfCAOev (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 09:34:51 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:35377 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728336AbfCAOev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 09:34:51 -0500
Received: by mail-qt1-f193.google.com with SMTP id p48so27952904qtk.2;
        Fri, 01 Mar 2019 06:34:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Kr2iK0Z6/1Tz0QsjFgK/N3Hq6/jd9uhO1G2ZTUfj0LE=;
        b=RPKeNk+HLcZ/aRpTiFIml0i45NQwhP9p2pkSvs03FtAJOihWAVxODcIFrs2/zs2kMe
         UvXUtbf36422BIEQmc880nluLcRvYcvCzNb/YK45QPGE9nit5OCb38N1A1qwEaMyTgK/
         M+xQrTZ7WA47nt6KprRuw8Ab11CB+D1JypYkQuA7m0xbAviWLXC3o+Ys4Y8DlRqJtkri
         3YP5Y51FHtYAuF05UY1uInSpXPyMASCg2NbCo2m3oom2PLBJm2mJft/ruBTQDerRn3Le
         fapeUkY2l/p4sQx1I05Zdj0QAyzP8WrCNudvmDCXJzoMCjgtdyK0y3B+2IeK225emKjS
         Dyyw==
X-Gm-Message-State: APjAAAVbdenw9OKMIlX9DyehXRLYT1r6Qab5aoebjebJRz4KxOlpiqqo
        6KzZOCsuxG2aefsY5rBdyEliGnlm1cjnxr6nDVo=
X-Google-Smtp-Source: APXvYqwWWqvTdsX44+5p40uVKnelBgmU87iGjG24eLVoXZTUeKTDLppMmPdD5pwYlt9ncEQsMTA3Mlr/9H9cEfOgNM0=
X-Received: by 2002:a0c:81ee:: with SMTP id 43mr3923579qve.180.1551450890521;
 Fri, 01 Mar 2019 06:34:50 -0800 (PST)
MIME-Version: 1.0
References: <1551243056-10521-1-git-send-email-sugaya.taichi@socionext.com>
In-Reply-To: <1551243056-10521-1-git-send-email-sugaya.taichi@socionext.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 1 Mar 2019 15:34:34 +0100
Message-ID: <CAK8P3a2oLYWR7uXcg-aL5MR0U24yk0ftoBahVuVCoq5Z3NyoAA@mail.gmail.com>
Subject: Re: [PATCH v4 00/10] Add basic support for Socionext Milbeaut M10V SoC
To:     Sugaya Taichi <sugaya.taichi@socionext.com>
Cc:     DTML <devicetree@vger.kernel.org>, linux-serial@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        soc@kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Russell King <linux@armlinux.org.uk>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Takao Orito <orito.takao@socionext.com>,
        Kazuhiro Kasai <kasai.kazuhiro@socionext.com>,
        Shinji Kanematsu <kanematsu.shinji@socionext.com>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 27, 2019 at 5:51 AM Sugaya Taichi
<sugaya.taichi@socionext.com> wrote:
>
> Hi,
>
> Here is the series of patches the initial support for SC2000(M10V) of
> Milbeaut SoCs. "M10V" is the internal name of SC2000, so commonly used in
> source code.
>
> SC2000 is a SoC of the Milbeaut series. equipped with a DSP optimized for
> computer vision. It also features advanced functionalities such as 360-degree,
> real-time spherical stitching with multi cameras, image stabilization for
> without mechanical gimbals, and rolling shutter correction. More detail is
> below:
> https://www.socionext.com/en/products/assp/milbeaut/SC2000.html
>
> Specifications for developers are below:
>  - Quad-core 32bit Cortex-A7 on ARMv7-A architecture
>  - NEON support
>  - DSP
>  - GPU
>  - MAX 3GB DDR3
>  - Cortex-M0 for power control
>  - NAND Flash Interface
>  - SD UHS-I
>  - SD UHS-II
>  - SDIO
>  - USB2.0 HOST / Device
>  - USB3.0 HOST / Device
>  - PCI express Gen2
>  - Ethernet Engine
>  - I2C
>  - UART
>  - SPI
>  - PWM
>
> Support is quite minimal for now, since it only includes timer, clock,
> pictrl and serial controller drivers, so we can only boot to userspace
> through initramfs. Support for the other peripherals  will come eventually.

I've merged these all into the arm/newsoc branch now, with the
exception of the patch that Greg has already taken.

I'll do a little more build testing before that branch will be sent,
but I expect it will be fine.

     Arnd
