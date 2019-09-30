Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 126A4C4360C
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 07:57:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF9AB21D71
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 07:57:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729838AbfI3H53 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 03:57:29 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:37528 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726008AbfI3H52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 03:57:28 -0400
Received: by mail-qt1-f194.google.com with SMTP id l3so15864679qtr.4
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2019 00:57:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=obREgB2IxLWd73AGc89bpG+DaJ00hRckpEnTkEVRRp4=;
        b=m7ptt3mZ+wi8CgYVd8S7UVCMs9Q7wtkAHTjfj9VaWhcZHnC3GceOsFEK0ZJFIRYc4m
         oudZ5Y0JuldEUNDUGA9RvYb2ytWbAAt2nRGtIUXtZi13bs7KHiizPOLcMYXfrLTDXGN1
         L+nc4OqOfMR73uZqTzsnKT9+u7i0ZrwqCrsEsD5PAv4YAKacz5AeuO+1H9vk6S3W7qYV
         +YSwj8OVY7QInWjKE5SsHGwamvpUD4ABBh77tY1V0uZMFcuxcQYGIdML64x7i2PrjlPy
         +PwhBKtG3JBLfo02ezwvDTHHB+lkrHJElhN3S1TisRbP3PE/HVo3qNxHKTeqPzJiogTH
         lbHg==
X-Gm-Message-State: APjAAAXM9wBOxPivWlOdHy9GqY0CYGbsCY1iCDxoeo3/VVT5hwzr8l7S
        cLDe2fUYX4joRkrQl4Q29mGdy4MsXpy+tL5qbw8=
X-Google-Smtp-Source: APXvYqxe+308RnGnFTDf6YDh4zIjrz482dsYfqfOpNCcIGa1Ini75MV0GZEqOtcnrRpSYJZQW31YucfCkUx+pPAFbvQ=
X-Received: by 2002:a0c:d084:: with SMTP id z4mr19081207qvg.63.1569830247340;
 Mon, 30 Sep 2019 00:57:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190930055925.25842-1-yamada.masahiro@socionext.com>
In-Reply-To: <20190930055925.25842-1-yamada.masahiro@socionext.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 30 Sep 2019 09:57:11 +0200
Message-ID: <CAK8P3a24P7v41TZszjKzoJmhcss5WK-e9fHwUqEqre6FBPJWvw@mail.gmail.com>
Subject: Re: [PATCH] ARM: fix __get_user_check() in case uaccess_* calls are
 not inlined
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Russell King <linux@armlinux.org.uk>,
        Stefan Agner <stefan@agner.ch>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Olof Johansson <olof@lixom.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 30, 2019 at 8:01 AM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> KernelCI reports that bcm2835_defconfig is no longer booting since
> commit ac7c3e4ff401 ("compiler: enable CONFIG_OPTIMIZE_INLINING
> forcibly"):
>
>   https://lkml.org/lkml/2019/9/26/825
>
> I also received a regression report from Nicolas Saenz Julienne:
>
>   https://lkml.org/lkml/2019/9/27/263
>
> This problem has cropped up on arch/arm/config/bcm2835_defconfig
> because it enables CONFIG_CC_OPTIMIZE_FOR_SIZE. The compiler tends
> to prefer not inlining functions with -Os. I was able to reproduce
> it with other boards and defconfig files by manually enabling
> CONFIG_CC_OPTIMIZE_FOR_SIZE.
>
> The __get_user_check() specifically uses r0, r1, r2 registers.
> So, uaccess_save_and_enable() and uaccess_restore() must be inlined
> in order to avoid those registers being overwritten in the callees.
>
> Prior to commit 9012d011660e ("compiler: allow all arches to enable
> CONFIG_OPTIMIZE_INLINING"), the 'inline' marker was always enough for
> inlining functions, except on x86.
>
> Since that commit, all architectures can enable CONFIG_OPTIMIZE_INLINING.
> So, __always_inline is now the only guaranteed way of forcible inlining.
>
> I want to keep as much compiler's freedom as possible about the inlining
> decision. So, I changed the function call order instead of adding
> __always_inline around.
>
> Call uaccess_save_and_enable() before assigning the __p ("r0"), and
> uaccess_restore() after evacuating the __e ("r0").
>
> Fixes: 9012d011660e ("compiler: allow all arches to enable CONFIG_OPTIMIZE_INLINING")
> Reported-by: "kernelci.org bot" <bot@kernelci.org>
> Reported-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>

The patch looks reasonable to me, but I think we should also revert
commit ac7c3e4ff401 ("compiler: enable CONFIG_OPTIMIZE_INLINING
forcibly") in mainline for now, as it caused this to happen all the time rather
than only for users that expliticly select CONFIG_OPTIMIZE_INLINING.

We have had other bug reports starting with that commit that run into
similar issues, and I'm sure there are more of them. I don't mind having it
in linux-next for a while long, but I think it was premature to have it merged
into mainline.

        Arnd
