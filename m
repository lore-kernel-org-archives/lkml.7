Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A309C04AB4
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 11:50:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F06982089E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 11:50:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="axwfrku8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727611AbfEPLul (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 07:50:41 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:44998 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726736AbfEPLuk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 07:50:40 -0400
Received: by mail-lj1-f193.google.com with SMTP id e13so2776909ljl.11
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2019 04:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZfZWKHa7k32vSF2Rgion0TnHTAjuA1aCE2qsRonqXP0=;
        b=axwfrku8av26C74Qcnj8NMFl8LQW3ytVsyxJwHyHrABKFSul4eTIQRAgniBSpRNR2T
         SUCKllbRVUhjH9a5M8vQ2ZctPU2aRCPW2zzHfrExJfmGQGGJKj+UZ8gMQKIIKMCg8q+W
         d71EwYTR3Nq/rACyFL4CAxYsp4QgSeBRv2U7Q+fNBUsAFO7pdw4soy6W9pOYAyCeXSbD
         CqdAcuzevt6wp/8joMtEkxOTMm36jy27fYgJD0kUVC1x24NqeVW7JvAfFlnUf7AVqtb0
         wSTH5rhMPlygfwvgCPaK4TGfEgwd4+eSNjsCqRVenL0HNST+g99Optp097VsBxKhX9Dm
         4j2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZfZWKHa7k32vSF2Rgion0TnHTAjuA1aCE2qsRonqXP0=;
        b=qwfm5GkHBIUQPS6NPEeHYSyt850neH38+1e7fRlIoYRxl+OfoSHJm5Z5611YuKGPfi
         S1VJhw58QQxXBTE2eFShwSqKP3C1ewxQ9c877cgVdS9OSV7VxTLP8hzAmBS5cLAOJgyX
         qf6/3HD5qLvfNTNyrkun40FNmvVvphDYgSea4MZf++ZfJi8CmteuZ1eJ0izi7clhL+gY
         /D/qq3NnmXy+24TT6Vii2lqVfpCxlptgtP5Fp4ZvtyIDPmvskznjkkERlN/O28joYFxO
         bDqmgDzymOHvX/p9wsmrN62VOayZTUxeWTXZAV49D41WQ8YZ4Hp9gRVK5PxfTqmzFmeI
         plGQ==
X-Gm-Message-State: APjAAAUY0ddMPKxDNvbj2ZgGdWyAiit9nrzwRPXs0PAE77XS6gT2AQHD
        rCWyewK77q8hXMB8jLo9uxcjNdgBhf4UiN5JHsBm6g==
X-Google-Smtp-Source: APXvYqwaxRjeq7pjR9npAXmwgyhZKdqhC73PwgIVTdnHjqNpDaNtDJResi7MGSU8C3U2sKn8oJY/87TKdcHLFfT0UHI=
X-Received: by 2002:a2e:60a:: with SMTP id 10mr3127929ljg.126.1558007438447;
 Thu, 16 May 2019 04:50:38 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1553828158.git.vilhelm.gray@gmail.com> <1cc8b30bb3954ca2a0961ffb0a2eed8a005ed670.1553828158.git.vilhelm.gray@gmail.com>
In-Reply-To: <1cc8b30bb3954ca2a0961ffb0a2eed8a005ed670.1553828158.git.vilhelm.gray@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 16 May 2019 13:50:26 +0200
Message-ID: <CACRpkdbCt1PAJ1rBvKvZ2ydLgJmKXuLN4mRtSU8CaW=U7EcFbQ@mail.gmail.com>
Subject: Re: [PATCH v14 01/11] bitops: Introduce the for_each_set_clump8 macro
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-arch@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Phil Reid <preid@electromag.com.au>,
        Lukas Wunner <lukas@wunner.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 29, 2019 at 4:03 AM William Breathitt Gray
<vilhelm.gray@gmail.com> wrote:

> This macro iterates for each 8-bit group of bits (clump) with set bits,
> within a bitmap memory region. For each iteration, "start" is set to the
> bit offset of the found clump, while the respective clump value is
> stored to the location pointed by "clump". Additionally, the
> bitmap_get_value8 and bitmap_set_value8 functions are introduced to
> respectively get and set an 8-bit value in a bitmap memory region.
>
> Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Suggested-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> Suggested-by: Lukas Wunner <lukas@wunner.de>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Acked-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
