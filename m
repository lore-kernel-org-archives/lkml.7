Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DB67C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 17:36:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22B71208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 17:36:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="gkX79G8W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731304AbfG3Rg4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 13:36:56 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:46489 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726713AbfG3Rg4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 13:36:56 -0400
Received: by mail-io1-f65.google.com with SMTP id i10so16692048iol.13
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 10:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0rwxjGQ0F8+7/JgSl5zAGXkF4+sYHbKb6y6qDK+alhg=;
        b=gkX79G8WWxMhmbnVBy82sigtuXRk0mxE6VY3CsMNdf5hT4coRD9fU36W4Q45ae3vKn
         wWiCeYclztjJMcNPuwJtWCVG4w6TRVOiefRLI7sW7m+4X8Or3HAISRpS0F4oNbdy9oYQ
         AIqiKw111Uuzr4T+4G4vo3v1PwrqoUXL1mTzRgiEGcS6op7+kjA18WWMkn36Svh140cn
         Iw2AlgNooDknvK7v+YyuAuKw8zJvOjF0a7tS1crKGFwDMPNxyipry5MFiPZcbmYnwaOh
         az9phnFnGdZqn4tu1h4e+btID5+QINSV9vYgtYM4voOzIEjcPkWQk4l9IsX24ROaHtt0
         2R+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0rwxjGQ0F8+7/JgSl5zAGXkF4+sYHbKb6y6qDK+alhg=;
        b=bgQ8wOXZRwPdvSs5zLfZ4mPbg1h+QFJeN2gK433/XRW4CNil2WSpewgXOCg7RtJk9z
         pv9DAdzCayLvcBl8LwrUhcpvXZWZFbnwd0OhKZoP/zoFR6aRTa+Pxk7R39ANtqDic5m4
         QunB59c+ZU5ucA4DrOAG5UyhzC901PP0+TkFtvTpMZYZJsldZqQElEvhb3gB2XR97fuT
         aVajtlqP2+tronjzby/bm/aoWCQjraZuGECHGWWMYl3UMzZnbRp9p7GkRQHyv8OYaxh/
         QFkCECchP72sfok6eoh8NX5aZzehzDOSi7Hag1VEaRxFLJSdHef6boPsu2I3o+KWX0Ke
         cClA==
X-Gm-Message-State: APjAAAXKmGJo3ZviTe2DdlkLWmc641YL2xzHpXELFqTYrlvAZBmoJn6H
        enZBbGFEw4rQmgzbcQReVxnBc4AHGk/v9eAvRZo=
X-Google-Smtp-Source: APXvYqyXcQAC/AoZ3rJhI5Ac31OagN0p/mkM1JieiGm/GnkuFYYiAYIVYKqyvOPcCeHt0rAKPHGJW51Y1rGcRrDR2PE=
X-Received: by 2002:a5d:915a:: with SMTP id y26mr108937727ioq.207.1564508214873;
 Tue, 30 Jul 2019 10:36:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190729135505.15394-1-patrice.chotard@st.com>
In-Reply-To: <20190729135505.15394-1-patrice.chotard@st.com>
From:   Olof Johansson <olof@lixom.net>
Date:   Tue, 30 Jul 2019 19:36:43 +0200
Message-ID: <CAOesGMg-3xt2qjjZ569pUE+d6tn7nz264AN9ARkBT_Ej4TFC2A@mail.gmail.com>
Subject: Re: ARM: multi_v7_defconfig: Enable SPI_STM32_QSPI support
To:     Patrice CHOTARD <patrice.chotard@st.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Russell King <linux@armlinux.org.uk>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Patrice,

If you cc soc@kernel.org on patches you want us to apply, you'll get
them automatically tracked by patchwork.


-Olof

On Mon, Jul 29, 2019 at 3:55 PM <patrice.chotard@st.com> wrote:
>
> From: Patrice Chotard <patrice.chotard@st.com>
>
> Enable support for QSPI block on STM32 SoCs.
>
> Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
> ---
>  arch/arm/configs/multi_v7_defconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
> index 6a40bc2ef271..78d1d93298af 100644
> --- a/arch/arm/configs/multi_v7_defconfig
> +++ b/arch/arm/configs/multi_v7_defconfig
> @@ -403,6 +403,7 @@ CONFIG_SPI_SH_MSIOF=m
>  CONFIG_SPI_SH_HSPI=y
>  CONFIG_SPI_SIRF=y
>  CONFIG_SPI_STM32=m
> +CONFIG_SPI_STM32_QSPI=m
>  CONFIG_SPI_SUN4I=y
>  CONFIG_SPI_SUN6I=y
>  CONFIG_SPI_TEGRA114=y
> --
> 2.17.1
>
