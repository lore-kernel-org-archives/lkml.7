Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8463C432C2
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 10:25:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57D4620872
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 10:25:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="Vinczihn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726945AbfIZKZt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 06:25:49 -0400
Received: from conssluserg-01.nifty.com ([210.131.2.80]:53881 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726519AbfIZKZs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 06:25:48 -0400
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id x8QAPiZX026387;
        Thu, 26 Sep 2019 19:25:44 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com x8QAPiZX026387
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1569493544;
        bh=4gNfylHHZtdgndSad6PjJXSwxIOR9alrhtPtj8B7110=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=VinczihnWCDBrgvoLP2kh5fTytrGSEoNtQk40bdmi4GDG5IIpShIqMdnNlzt2kiFt
         2N65b4GeXMV6VQPXgYcU1CIGc8tXfRCQdgtgd2aOkFQa+01xE/x2GQUIUKR/SHNNre
         NCTiw3vbhHgYaFneTON8+Erl4Q78APXKXU+wGXaM3C6Ja31BIp+qqtkEn4FCTAhNVt
         hQQZSwgqopq9slaI9tSyg4TSxVwU5jACP3ZwJDUlaeeT357sqWaLKvsLq1c64N4RJ7
         Mv2TSeZsU6DA2+zpeWPIOuUIDAXJsoetGen8N6y7CzkhW1MCRhr8kQyc6ob7SW1fp5
         3SdgKiScRbF1g==
X-Nifty-SrcIP: [209.85.217.46]
Received: by mail-vs1-f46.google.com with SMTP id d3so1251842vsr.1;
        Thu, 26 Sep 2019 03:25:44 -0700 (PDT)
X-Gm-Message-State: APjAAAVaqQdyOaS/0nwjUNRk77rUoqQ7K1iu+MOtVnQwX9nQmJLJfAOK
        I9b+qzAXn69XMhHV8VqfR6tJWs5yKQx9Z9fS22M=
X-Google-Smtp-Source: APXvYqyeIspKm3xk+JKqX7PSS7gDWlcm9BZdyqAWf+X9fC0of2bjx1GwXyPr283EhOahiarlzOo3vv0bAZkcr7AOlSE=
X-Received: by 2002:a67:1a41:: with SMTP id a62mr1750823vsa.54.1569493543459;
 Thu, 26 Sep 2019 03:25:43 -0700 (PDT)
MIME-Version: 1.0
References: <20190926101312.32218-1-geert@linux-m68k.org>
In-Reply-To: <20190926101312.32218-1-geert@linux-m68k.org>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Thu, 26 Sep 2019 19:25:07 +0900
X-Gmail-Original-Message-ID: <CAK7LNARTk5yE1=WsxdYpEw6EYXMmq8cW5QBEse2WWhTJ0y=iMA@mail.gmail.com>
Message-ID: <CAK7LNARTk5yE1=WsxdYpEw6EYXMmq8cW5QBEse2WWhTJ0y=iMA@mail.gmail.com>
Subject: Re: [PATCH -next] fbdev: c2p: Fix link failure on non-inlining
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-fbdev@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 26, 2019 at 7:13 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> When the compiler decides not to inline the Chunky-to-Planar core
> functions, the build fails with:
>
>     c2p_planar.c:(.text+0xd6): undefined reference to `c2p_unsupported'
>     c2p_planar.c:(.text+0x1dc): undefined reference to `c2p_unsupported'
>     c2p_iplan2.c:(.text+0xc4): undefined reference to `c2p_unsupported'
>     c2p_iplan2.c:(.text+0x150): undefined reference to `c2p_unsupported'
>
> Fix this by marking the functions __always_inline.
>
> Reported-by: noreply@ellerman.id.au
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>


Reviewed-by: Masahiro Yamada <yamada.masahiro@socionext.com>




-- 
Best Regards
Masahiro Yamada
