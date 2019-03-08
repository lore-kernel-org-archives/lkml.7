Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B50DDC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 08:31:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8041D20854
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 08:31:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Rm9BhiV+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726309AbfCHIbP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 03:31:15 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:45367 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726238AbfCHIbO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 03:31:14 -0500
Received: by mail-lf1-f68.google.com with SMTP id f16so13703503lfk.12
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2019 00:31:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OeGknBImCwDa6WrD4Xh0Jx61jsaPHf3owyqhxOIhbAU=;
        b=Rm9BhiV+WwauLBIh0Vylx3DsxkTOcwI3R1J28jrRVWvxIG3JQRnNE/aEQyvq0wGmOE
         YUGAkNFgHc3DsqnUWhRINWViY+Hu+0RbW5DS8DmehC+G61RVYWuVwXsviMrdYVadfVfx
         pmK1A5zrqN+afJonTDbUNpCyfjbN2UJbMQ1UZUeSbpYgWZ7hvQ+vQSuzNVMOKlskJ49K
         quuwFdvLrRwgAmD4kloq2avbfOi4vJYNJ/zfhFpQMy0A95oBYIw4xg8GB05AR0rcDRDK
         jp4BZKD6Dl/3NBw7irfJBF3sY+BOEuB2nf+YRNBOeOrSB0arNERdsrCpHvHlVfngA7Ej
         fXCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OeGknBImCwDa6WrD4Xh0Jx61jsaPHf3owyqhxOIhbAU=;
        b=IF00lnb5Repqs/8XR+Cpv9c7SRENFvSO7+LR50lmE9Tvl2GPncaXhapEjP74hsqdda
         149+WMu7gUkVlusWtFiuLF+w9o2J3ltRe5u3Fy+xTFnT8mdF7Ha4rJG2QvT5Du5XhO9h
         PufyK6LmfAj1+ybqm0L5ujbUVEmFDmpFiL1z7ufSmn2NwdDgsGVP42QKxMp5jf10ir98
         lyRgf7yF7ZqJSjGIDb+YGO9m1H1YcqYAXhEEhGXEwT8oq9tCm9uAfhcGNHcHeUG7rrpQ
         PqK+Gkq0IUyfbiD5ZwrkPrLgtX7KrJq1DvLxDCkV19apQ9vhohn9g4/7hkTjIC56gV2S
         dfyw==
X-Gm-Message-State: APjAAAWl3wh4S8Fur4b7zc3SVlbO4TVCT8tKQIg4oD3hIzESi64WOhae
        bcgPUqLNiauaqXGVviON4MpQ9SzFz7AiWCrVuKCIsQ==
X-Google-Smtp-Source: APXvYqykacLGBGxdHCYbRGw6jUybSWG730/UsLI5kLyXikbrsye0tz3lP08y9YRTEsIreqmAW3OVdZmgfZoaMEEmh9I=
X-Received: by 2002:a19:9e8b:: with SMTP id h133mr3524932lfe.167.1552033872019;
 Fri, 08 Mar 2019 00:31:12 -0800 (PST)
MIME-Version: 1.0
References: <cover.1551598603.git.vilhelm.gray@gmail.com> <12b3a364ac7fc32194fa6f55911dd800aca92a56.1551598603.git.vilhelm.gray@gmail.com>
In-Reply-To: <12b3a364ac7fc32194fa6f55911dd800aca92a56.1551598603.git.vilhelm.gray@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 8 Mar 2019 09:31:00 +0100
Message-ID: <CACRpkdbvCGRjB1sZWqN3wm660cP8S4-j0ub1j1iYpitDK_eXcQ@mail.gmail.com>
Subject: Re: [PATCH v9 1/9] bitops: Introduce the for_each_set_clump8 macro
To:     William Breathitt Gray <vilhelm.gray@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-arch@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 3, 2019 at 8:47 AM William Breathitt Gray
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
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>

Andrew: would you be OK with this being merged in v5.1?

If we need to move the code to drivers/gpio that's OK (though
I think it's generally useful) but I need to know to proceed with
the William's nice optimization of these drivers.

Yours,
Linus Walleij
