Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D781ECE58D
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 09:26:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 755DE21721
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 09:26:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Yp/ezDTo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730533AbfJIJ0O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 05:26:14 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:42521 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbfJIJ0N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 05:26:13 -0400
Received: by mail-lf1-f68.google.com with SMTP id c195so1085163lfg.9
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 02:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SD+HI02CKBBsUnBjBS8AONRJ3UqoWuFlv1/fGBB0L+4=;
        b=Yp/ezDTokXabk02kHZS4Q9Zcrip4udpQ7qThrEB8fA+oF5/YBaD2Q+THIO35uJ3kfM
         ijAdu971Sc0u1iXVcq8FmBzJx92WFKIL13rYfNLHAFEcAcABM/XNEWuxdcFUR630+oKt
         EhOBtNE8brRBt6vUfGQkuPeYH0wO5CD9zsgK8XTxtLlluYKde8xrN7DJnQGKvtMGqrQb
         301v9yPx51H2ueQoUMiDBqmPbWS6qbm39fIrpFjEigHHHzEF4FAtjiFlUyKtyHYy4pFZ
         eyTC9foJ37+QThE5FPa4048amnHh8m0WuErFx7J6r28IzNf5kcGpC7qLDNVSqenrhhXu
         UeXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SD+HI02CKBBsUnBjBS8AONRJ3UqoWuFlv1/fGBB0L+4=;
        b=DVX/EFf/AQtTqgXcFVmqm+7O/q/5btsx2RJR/NcLoZ25h8/beBruu+Pc1BVU/5q7aJ
         p1YeqM/W0c95Phg7dYprFHK7TWpcnSOf/mHcNrJLAwhMliIfj8b61VVrJUTK16vs8y0p
         rXnqL2eJZqHVBoQURWvWLaDA0ul7vLL3CUfqJsfwM3npjITCuIn6iLM6LXnKcay1He/I
         mhCW2GvWUe4hqPWyqET5xjFLozsrq3APk1wYE/xnAh7qUMS3T2cEOZ/5+fWffhXU5nDo
         sfxu92kmIIDaQhRG8YXFHo57hWEcT0p3OULRep81/b9xVEVoCBiiO4TI3Lu2JN5gDGzg
         HBrw==
X-Gm-Message-State: APjAAAW0NlqyGLwkCdR5I/fW9pGKtUW0+1wQOlf2YkYsbyjjZFsfJiez
        LcLeSyz3c7IaHRDT5NEcUiPlbzRD0WMMLknxCKUZAw==
X-Google-Smtp-Source: APXvYqzFG7lDdH9uA0MTciR+6xdQMm6jmgxkQ3KIBmF6lJi9ASjDpky3Ev/tMd6UZRmclpoRgOMzubjoi2Xc5yZYX5w=
X-Received: by 2002:a19:c505:: with SMTP id w5mr1439629lfe.115.1570613170790;
 Wed, 09 Oct 2019 02:26:10 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1570299719.git.vilhelm.gray@gmail.com> <be63fa49f036b9168f223152648307a63056f4ee.1570299719.git.vilhelm.gray@gmail.com>
In-Reply-To: <be63fa49f036b9168f223152648307a63056f4ee.1570299719.git.vilhelm.gray@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 9 Oct 2019 11:25:59 +0200
Message-ID: <CACRpkdbEszHr3zzVBTinVFQXU+sjOu9YbWC-554+7PYgupYJBA@mail.gmail.com>
Subject: Re: [PATCH v15 01/14] bitops: Introduce the for_each_set_clump8 macro
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arch@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Phil Reid <preid@electromag.com.au>,
        Lukas Wunner <lukas@wunner.de>,
        Sean Nyekjaer <sean.nyekjaer@prevas.dk>,
        morten.tiljeset@prevas.dk,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 5, 2019 at 8:37 PM William Breathitt Gray
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
> Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>

As usual I am happy to merge all this but I would need
Andrew Morton's ACK, as I don't feel like a maintainer for
the bitops.

Yours,
Linus Walleij
