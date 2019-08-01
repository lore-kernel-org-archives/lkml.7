Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCD91C32751
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 02:31:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D45520449
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 02:31:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="mobgdh1A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728748AbfHACbh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 22:31:37 -0400
Received: from conssluserg-06.nifty.com ([210.131.2.91]:34521 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726224AbfHACbg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 22:31:36 -0400
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id x712VLkp031078;
        Thu, 1 Aug 2019 11:31:22 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com x712VLkp031078
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1564626682;
        bh=v7tebXzVuIjpWij2FCnUZC9VfqyHCstSxtXYGo/JQaw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=mobgdh1A6L2xfO1H1LK+ttHQHvmieoWnB8xVVqAPVDnlPAoZOpuY41Jel/Z0kW2gA
         ZyhrSvTPOUVXvRe4x6ZRyz6fmJlF0xUw7wiSEtgG1LIysPezoH1XecZaD6XbHRPYQt
         HsIRY2/XDLW2XA+qwexWJD+03XctuWm8okpJrwx2k/xZ5foAmVeDnPhZdLmdjmknn/
         169Fld+e8p2+VQdV7KHzhetEFZbsZSLJm2X6/hPAi18OXQ8eSI6PmXTXFREf0QmjWh
         2AQBdP8jz7jWmI87kwaEUoe7AXZis0+RFc9+O87OwgIpf7QmVf9qOj2MbgFbZqhhu/
         /Mb2LlfAkskBQ==
X-Nifty-SrcIP: [209.85.222.43]
Received: by mail-ua1-f43.google.com with SMTP id a97so27793115uaa.9;
        Wed, 31 Jul 2019 19:31:21 -0700 (PDT)
X-Gm-Message-State: APjAAAXJqG5FEKYkEMSqnlmojUn5O/TZXnifu88NmlMv7GHAn/GGufmF
        vq8gFgUw+jHfRzs/86J+QEr6eW0fcpMAZkHAbvM=
X-Google-Smtp-Source: APXvYqye+xSiOZooqZfZiBZrjUaqPJGNZgygtAZnjxFm+XMhDELoSbERP2u2elHRRY+h2JYNWrxNWScvA7PtWnS+grw=
X-Received: by 2002:ab0:234e:: with SMTP id h14mr8749337uao.25.1564626680940;
 Wed, 31 Jul 2019 19:31:20 -0700 (PDT)
MIME-Version: 1.0
References: <20190617162123.24920-1-yamada.masahiro@socionext.com>
In-Reply-To: <20190617162123.24920-1-yamada.masahiro@socionext.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Thu, 1 Aug 2019 11:30:45 +0900
X-Gmail-Original-Message-ID: <CAK7LNATtqhxPcDneW0QOkw-5NyPNP06Qv0bYTe7A_gCiHMiU7A@mail.gmail.com>
Message-ID: <CAK7LNATtqhxPcDneW0QOkw-5NyPNP06Qv0bYTe7A_gCiHMiU7A@mail.gmail.com>
Subject: Re: [PATCH] libfdt: reduce the number of headers included from libfdt_env.h
To:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        DTML <devicetree@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 18, 2019 at 1:21 AM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> Currently, libfdt_env.h includes <linux/kernel.h> just for INT_MAX.
>
> <linux/kernel.h> pulls in a lots of broat.
>
> Thanks to commit 54d50897d544 ("linux/kernel.h: split *_MAX and *_MIN
> macros into <linux/limits.h>"), <linux/kernel.h> can be replaced with
> <linux/limits.h>.
>
> This saves including dozens of headers.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---

ping?


>  include/linux/libfdt_env.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/linux/libfdt_env.h b/include/linux/libfdt_env.h
> index edb0f0c30904..2231eb855e8f 100644
> --- a/include/linux/libfdt_env.h
> +++ b/include/linux/libfdt_env.h
> @@ -2,7 +2,7 @@
>  #ifndef LIBFDT_ENV_H
>  #define LIBFDT_ENV_H
>
> -#include <linux/kernel.h>      /* For INT_MAX */
> +#include <linux/limits.h>      /* For INT_MAX */
>  #include <linux/string.h>
>
>  #include <asm/byteorder.h>
> --
> 2.17.1
>


-- 
Best Regards
Masahiro Yamada
