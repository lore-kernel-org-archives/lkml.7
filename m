Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30CF8C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 21:47:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E49A208E4
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 21:47:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730454AbfIDVrD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 17:47:03 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:44462 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726495AbfIDVrD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 17:47:03 -0400
Received: by mail-qt1-f196.google.com with SMTP id u40so239722qth.11;
        Wed, 04 Sep 2019 14:47:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QM9AadYfJ62wO0eCEQsbjms/00BVZw1wT6ODRgunvt0=;
        b=IJGVGogadgpjZhWI0stEMQoXwmG8ARyqYeRsdoxsjBZxBihmMiKGhwma8IZq5cQ4MY
         q/jIGzQiCDTVEnDPdD3qIk0ruPUQAc5NVEuVbyOaHkTog4736SuB+ixkKLlJZ1aLZMFu
         pVhkb0bqT+9D1mA7p5qTO0CPWVTqaGMZHD+Kkfrlg0t1HbV5AeWYWRTZ49JZ3FquvYew
         a3p7r9LbT8PqduHuSvUu40yNd/p+vBQP/ikEBCPSSlBAi30AukzIsSqmipa87y/XuCez
         ETv2fTpAWHdxORjhaf+ssdFZUI4eoTT3yflmF2WaijHHS9xJmLlTMUztsa5LhgkKFMpF
         0xbw==
X-Gm-Message-State: APjAAAW2KOj7j9CDuFWgUPK9XTczWvFDbFOxt+Jm+sHikC6TiN2Wl/8E
        bbLgKvv2km7s/mSNgKYqnfsEU7+W1uIyYBlRRjw=
X-Google-Smtp-Source: APXvYqwhtylgK6LYEc4IYp3t2WachuRHIqyVwFzkqJX4+n3V/I3z/4iZJArTfRIAwTctFViScKf/ScQRuBBo56jArco=
X-Received: by 2002:aed:2842:: with SMTP id r60mr281706qtd.142.1567633621974;
 Wed, 04 Sep 2019 14:47:01 -0700 (PDT)
MIME-Version: 1.0
References: <20190831162555.31887-1-yamada.masahiro@socionext.com>
In-Reply-To: <20190831162555.31887-1-yamada.masahiro@socionext.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 4 Sep 2019 23:46:45 +0200
Message-ID: <CAK8P3a0kPFojqAWqXEAcitVMjBA5ABc=rRx=zHMxXat+gCz=gA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] kbuild: refactor scripts/Makefile.extrawarn
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Michal Marek <michal.lkml@markovi.net>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 31, 2019 at 6:26 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:

> +# Some diagnostics enabled by default are noisy.
> +# Suppress them by using -Wno... except for W=1.
> +
>  ifdef CONFIG_CC_IS_CLANG
>  KBUILD_CFLAGS += -Wno-initializer-overrides
>  KBUILD_CFLAGS += -Wno-format
>  KBUILD_CFLAGS += -Wno-sign-compare
>  KBUILD_CFLAGS += -Wno-format-zero-length
>  endif

FWIW, I just found out I missed a bug that clang failed to warn about
because of the  -Wno-format. Apparently gcc warns only about type
mismatches that result in incompatible calling conventions (e.g.
int vs int64_t) but not smaller types (int, short) that get converted to an
int anyway. Passing -Wno-format turns both off.

      Arnd
