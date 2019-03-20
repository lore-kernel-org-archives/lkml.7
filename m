Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8EA1C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 13:29:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 397B0213F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 13:29:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="mFtDMmFO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727862AbfCTN3h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 09:29:37 -0400
Received: from conssluserg-01.nifty.com ([210.131.2.80]:42104 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725905AbfCTN3e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 09:29:34 -0400
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id x2KDTJHu029375;
        Wed, 20 Mar 2019 22:29:20 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com x2KDTJHu029375
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1553088560;
        bh=J3I0WRysBKxZTanhBUXEyZbaQHMnn1tkHS81meSjYfA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=mFtDMmFOERz3kLq4QsYxXpOJiDrEatzJOu4Y8j6VaI9UKsteLMDGmwy5RvZZfXzPv
         fDNnCfkvDschdeWpGO6OikoJWTvEIRo+GPi9EnJZvOx+TUg2cQCcEths7AO8xwqCpB
         Q5fWGsi4x0d+s7ZIdFAElyXVv0dpDOnvEH3nYiQcN1dVlv8p5foRi4G4HTH/25MhQ4
         XzAWxndV1MzXoUqAwoeTUr5LTvhuU/L/RYNvZFjCrLn5PlvPE/0SRRh5iknbVLfeqY
         3nh9QFloW8lo6M8pX8/2qR3Gtw4wrzz3Fe3lyN2tqluHRzhgrzWa6UZO4+zXMVobdE
         lwRmDFF/3Rn5g==
X-Nifty-SrcIP: [209.85.217.48]
Received: by mail-vs1-f48.google.com with SMTP id w13so1467500vsc.4;
        Wed, 20 Mar 2019 06:29:20 -0700 (PDT)
X-Gm-Message-State: APjAAAWmp1uStq5/dvfCRMtdRNwqE1GZ/7IkHkF4AIPclbEgWKB8IGCF
        UJmJIHkLvqY7kZhsfh3UTz5TLvyVLS/RipTMzdg=
X-Google-Smtp-Source: APXvYqzynuO5wFvKvdc2hDj2kkxFFLy89AfeVQybGkVKM48ZI5ErdqKZ2eMRkl9o5z/VEFP4Xd9NtyRei0KPIWGfrR0=
X-Received: by 2002:a67:f105:: with SMTP id n5mr4963786vsk.181.1553088559207;
 Wed, 20 Mar 2019 06:29:19 -0700 (PDT)
MIME-Version: 1.0
References: <CAG5bF+RvumzKK0E-GAT223jnBvkRe1RN_0J9cGpfPOqCBvfWyw@mail.gmail.com>
In-Reply-To: <CAG5bF+RvumzKK0E-GAT223jnBvkRe1RN_0J9cGpfPOqCBvfWyw@mail.gmail.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Wed, 20 Mar 2019 22:28:43 +0900
X-Gmail-Original-Message-ID: <CAK7LNAT3_YA4+cdcJGzgpZ_QcL-LxfFNOpuL7tibGvuLo4CHfA@mail.gmail.com>
Message-ID: <CAK7LNAT3_YA4+cdcJGzgpZ_QcL-LxfFNOpuL7tibGvuLo4CHfA@mail.gmail.com>
Subject: Re: [PATCH] Revert "kbuild: use -Oz instead of -Os when using clang"
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Michal Marek <michal.lkml@markovi.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Behan Webster <behanw@converseincode.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Manoj Gupta <manojgupta@chromium.org>,
        Tiancong Wang <tcwang@chromium.org>,
        Stephen Hines <srhines@google.com>,
        clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 19, 2019 at 6:10 AM Matthias Kaehlcke <mka@chromium.org> wrote:
>
> The clang option -Oz enables *aggressive* optimization for size,
> which doesn't necessarily result in smaller images, but can have
> negative impact on performance. Switch back to the less aggressive
> -Os.
>
> This reverts commit 6748cb3c299de1ffbe56733647b01dbcc398c419.
>
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>


Applied to linux-kbuild/fixes.  Thanks.


> ---
>  Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Makefile b/Makefile
> index 9ef547fc7ffe..191f3ce3cb5e 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -667,7 +667,7 @@ KBUILD_CFLAGS       += $(call cc-disable-warning, format-overflow)
>  KBUILD_CFLAGS  += $(call cc-disable-warning, int-in-bool-context)
>
>  ifdef CONFIG_CC_OPTIMIZE_FOR_SIZE
> -KBUILD_CFLAGS  += $(call cc-option,-Oz,-Os)
> +KBUILD_CFLAGS  += -Os
>  else
>  KBUILD_CFLAGS   += -O2
>  endif
> --
> 2.21.0.225.g810b269d1ac-goog



-- 
Best Regards
Masahiro Yamada
