Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5071BC7618B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 10:09:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30C14206B8
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 10:09:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728151AbfG2KJM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 06:09:12 -0400
Received: from mail-lj1-f181.google.com ([209.85.208.181]:34763 "EHLO
        mail-lj1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726358AbfG2KJL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 06:09:11 -0400
Received: by mail-lj1-f181.google.com with SMTP id p17so58023684ljg.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 03:09:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TmRNe2WlgP9BihNacdzEDG1yBP4Iz6xmtdUZLVFf71I=;
        b=D+lUWc7k+y5g2qNiw04rRlstoryCFFRfts8tNKdv848iSEnr14Z4Jnpoa1MEf1Nwyd
         CMeZaeMp/mtD3zTZD7qkfKGhf2/cEGOdrMfQ9j7dYb/PIt5NnbA8SkKhqKYjLAFsknyC
         xKKhAo2gozLtbqh1JlaPa2SKDyztjeCFiug8tunB/g7brYtO7nFiXqwCx0Jl2MTsDLF/
         4IdsyU1f+LMIuqH/MXzFjZgBjCJbA8HzXGTuDnWuCMNXOy7hiSdloHGiA26KJPWFYAnz
         uuY56S5xjMLLLPIUPKuK4PXmDAdownzqUe9Z4Ycc/RwFC1cNOmX3DUNjP+AMEG269RF7
         /EVw==
X-Gm-Message-State: APjAAAXdUwCeXs0YFt5lu9Ia93IYUtN+z0r1TfC8Au38HeLaFzHQ9YjZ
        j/iztJp+5RU+hrAUsDJVAzvcXdnfhdAdTN4QRjIoBQ==
X-Google-Smtp-Source: APXvYqyJogBxwRYEc/+cX8TKZoaJa4kfDQRuctJRlXgAgVNuUdUHypsAiDNy9ssolywjDFLqmsIVycSaE6UWbanOI+E=
X-Received: by 2002:a2e:89ca:: with SMTP id c10mr41781869ljk.106.1564394949672;
 Mon, 29 Jul 2019 03:09:09 -0700 (PDT)
MIME-Version: 1.0
References: <CAGnkfhySwXY7YwuQezyx6cEpemZW4Hox1_4fQJm3-5hvM3G6gw@mail.gmail.com>
 <20190729095047.k45isr7etq3xkyvr@willie-the-truck>
In-Reply-To: <20190729095047.k45isr7etq3xkyvr@willie-the-truck>
From:   Matteo Croce <mcroce@redhat.com>
Date:   Mon, 29 Jul 2019 12:08:33 +0200
Message-ID: <CAGnkfhxWsaDpxsE5Asj1dUxXGJvQr4_oq4ZDWtbn-zsbh_jkMQ@mail.gmail.com>
Subject: Re: build error
To:     Will Deacon <will@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 29, 2019 at 11:50 AM Will Deacon <will@kernel.org> wrote:
>
> Hi Matteo,
>
> On Sun, Jul 28, 2019 at 10:08:06PM +0200, Matteo Croce wrote:
> > I get this build error with 5.3-rc2"
> >
> > # make
> > arch/arm64/Makefile:58: gcc not found, check CROSS_COMPILE_COMPAT.  Stop.
> >
> > I didn't bisect the tree, but I guess that this kconfig can be related
> >
> > # grep CROSS_COMPILE_COMPAT .config
> > CONFIG_CROSS_COMPILE_COMPAT_VDSO=""
> >
> > Does someone have any idea? Am I missing something?
>
> Can you try something like the below?
>
> Will
>
> --->8
>
> diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
> index bb1f1dbb34e8..d35ca0aee295 100644
> --- a/arch/arm64/Makefile
> +++ b/arch/arm64/Makefile
> @@ -52,7 +52,7 @@ ifeq ($(CONFIG_GENERIC_COMPAT_VDSO), y)
>
>    ifeq ($(CONFIG_CC_IS_CLANG), y)
>      $(warning CROSS_COMPILE_COMPAT is clang, the compat vDSO will not be built)
> -  else ifeq ($(CROSS_COMPILE_COMPAT),)
> +  else ifeq ("$(CROSS_COMPILE_COMPAT)","")
>      $(warning CROSS_COMPILE_COMPAT not defined or empty, the compat vDSO will not be built)
>    else ifeq ($(shell which $(CROSS_COMPILE_COMPAT)gcc 2> /dev/null),)
>      $(error $(CROSS_COMPILE_COMPAT)gcc not found, check CROSS_COMPILE_COMPAT)

Hi, it doesn't fix. I've tried to print CROSS_COMPILE_COMPAT and it
seemed empty, but hexdump shows that it contains a new line:

# make 2>&1 |hexdump -C
00000000  61 72 63 68 2f 61 72 6d  36 34 2f 4d 61 6b 65 66  |arch/arm64/Makef|
00000010  69 6c 65 3a 35 39 3a 20  2a 2a 2a 20 43 52 4f 53  |ile:59: *** CROS|
00000020  53 5f 43 4f 4d 50 49 4c  45 5f 43 4f 4d 50 41 54  |S_COMPILE_COMPAT|
00000030  3d 27 13 27 2e 20 20 53  74 6f 70 2e 0a           |='.'.  Stop..|
0000003d

-- 
Matteo Croce
per aspera ad upstream
