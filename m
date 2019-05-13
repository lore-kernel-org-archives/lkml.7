Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAE0BC04A6B
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 02:24:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8466A208C0
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 02:24:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="J61WW24q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727369AbfEMCYD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 May 2019 22:24:03 -0400
Received: from conssluserg-06.nifty.com ([210.131.2.91]:28939 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727054AbfEMCYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 May 2019 22:24:02 -0400
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id x4D2NlT6026177;
        Mon, 13 May 2019 11:23:47 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com x4D2NlT6026177
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1557714227;
        bh=enLjO+YNO2YxhL0dGODfJWJqJYXkX6sundGe2vyhCvc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=J61WW24qmGW6ATE7tysBB8QHUX2CZBQ65niuwyWeK067unerdnAFM6guNwtK+4zzv
         8uPiFBLlGYUGAPjVbcdvYqK5ME6ek+/LfHM9QIF7T6/8Wctwjj2giUWkuI8bCuOc2D
         VOXZsW0wEwO1dB2dxc2RvVukJdFBf3HdGIij0XkgilbJ0VvZfuIBHWfL189Cn3QXq0
         +dAor1dw2oVprMmTkCRHyIjHWpsBwcmM7As6RQtGnACrr599OizjaBKuZjsaxXRMIb
         dJ7d6tYFaJkTPx/3VtAwNyjqOQAwGkgVCbDAahl/G1iJ0oC/A3k2P6oPdDphrqWHp+
         sxDOunOg/nVYA==
X-Nifty-SrcIP: [209.85.217.43]
Received: by mail-vs1-f43.google.com with SMTP id c24so7025138vsp.7;
        Sun, 12 May 2019 19:23:47 -0700 (PDT)
X-Gm-Message-State: APjAAAXS2ZwIkcnk5d+u67blCLlTzIfvfZY6fsa/N2Ao7Br6g/LUFtzd
        QtOxlEZ2MdQTiSaVqZzEtqK4bDPK1G6hXD4v91Y=
X-Google-Smtp-Source: APXvYqydlJVG6ACos6uVytV0lJXuVROwKaUlSpHGHtzzMIoKqcKIU0UDNiaw7iG1LNnBDzVg8n/EJPq1U72CdV5V7YY=
X-Received: by 2002:a67:fd89:: with SMTP id k9mr12709180vsq.54.1557714226559;
 Sun, 12 May 2019 19:23:46 -0700 (PDT)
MIME-Version: 1.0
References: <CAK7LNASpsid7_sh4rdRNSTwZ1YtW_+uH2eoarJNNUttntQZ-kg@mail.gmail.com>
 <20190509114824.25866-1-natechancellor@gmail.com>
In-Reply-To: <20190509114824.25866-1-natechancellor@gmail.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Mon, 13 May 2019 11:23:10 +0900
X-Gmail-Original-Message-ID: <CAK7LNASsm9wrL5JkpVpp0qm5jBd22sHukqYe_iJGJXe0RO8ECg@mail.gmail.com>
Message-ID: <CAK7LNASsm9wrL5JkpVpp0qm5jBd22sHukqYe_iJGJXe0RO8ECg@mail.gmail.com>
Subject: Re: [PATCH] Makefile: Don't try to add '-fcatch-undefined-behavior' flag
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Michal Marek <michal.lkml@markovi.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 9, 2019 at 8:49 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> This is no longer a valid option in clang, it was removed in 3.5, which
> we don't support.
>
> https://github.com/llvm/llvm-project/commit/cb3f812b6b9fab8f3b41414f24e90222170417b4
>
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>
> Let me know if you want this incremental to your patch. I figured it
> made more sense to remove this then do the cc-option/cc-disable-warning
> removal because it will simplify the commit message.

Applied to linux-kbuild.
Thanks.


>  Makefile | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/Makefile b/Makefile
> index d24f5a8009ee..e4788eb2c9b9 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -740,7 +740,6 @@ KBUILD_CFLAGS += $(call cc-disable-warning, tautological-compare)
>  # source of a reference will be _MergedGlobals and not on of the whitelisted names.
>  # See modpost pattern 2
>  KBUILD_CFLAGS += $(call cc-option, -mno-global-merge,)
> -KBUILD_CFLAGS += $(call cc-option, -fcatch-undefined-behavior)
>  else
>
>  # These warnings generated too much noise in a regular build.
> --
> 2.21.0
>


-- 
Best Regards
Masahiro Yamada
