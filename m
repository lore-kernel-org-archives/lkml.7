Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CB70C432C2
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 10:45:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7322C217F4
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 10:45:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="MGH/PDa0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726063AbfIZKp4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 06:45:56 -0400
Received: from conssluserg-02.nifty.com ([210.131.2.81]:61224 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725813AbfIZKp4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 06:45:56 -0400
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id x8QAjhr9003477;
        Thu, 26 Sep 2019 19:45:43 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com x8QAjhr9003477
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1569494744;
        bh=2bqFCD9HY4bOSAdbvQuBhAL+OdjKk61eDEgGU6Vtqck=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=MGH/PDa0fPS4hDwlv5O/+6Pv/I+M0Ihx7N+qCcjMpIu4hvGN7nL80VD8z6Re9ijAJ
         yMOj5tPD6gG17+vUCK+9uxHTUYzsGiaW5HrzHbHVGcNlzQEz/IIxU/LAn6MRFmgOiX
         sPx6wE4YMa6SgxQPoow1CA7QvEi/lmgNb+552BfSu2CyavfAsd8gf1KAD+giQxc6Z/
         y3vEjpc/AcJ5ICRI+cHesOhcmHkEtfe+hU2rbzlLhqA4GZZsaGcgdxRq0T2dJIUd+S
         y43pK4BH9uj6pfZoEIaymNW1eyoOdbIcsgpZgLamCn4iVKhKQSZkox/fmV/fg7N1H4
         TEjp/yp/Ct50Q==
X-Nifty-SrcIP: [209.85.221.179]
Received: by mail-vk1-f179.google.com with SMTP id d66so337950vka.2;
        Thu, 26 Sep 2019 03:45:43 -0700 (PDT)
X-Gm-Message-State: APjAAAVzIHx64jZ5aNo4tTjfLe72+XgiZN/u/Hzg6UBTVYSGBMgdWQEj
        Fx31NRgp8p0ngFpMjdr/BYLStDDXDyT6VvujWec=
X-Google-Smtp-Source: APXvYqxq9EI9rMORFaFNyb4BmeKb4WK6iS2aILn0tGeI53ICeWzEirtOjlv7ijdHOlZYtmjDCl7+cULA0UzUmkBvYiM=
X-Received: by 2002:a1f:60c2:: with SMTP id u185mr1298856vkb.0.1569494742579;
 Thu, 26 Sep 2019 03:45:42 -0700 (PDT)
MIME-Version: 1.0
References: <20190926101312.32218-1-geert@linux-m68k.org>
In-Reply-To: <20190926101312.32218-1-geert@linux-m68k.org>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Thu, 26 Sep 2019 19:45:06 +0900
X-Gmail-Original-Message-ID: <CAK7LNATN5QyC+-_VRZm_ZysYd8Z8aWU0Ys0cTpU2GUdEdrXvPg@mail.gmail.com>
Message-ID: <CAK7LNATN5QyC+-_VRZm_ZysYd8Z8aWU0Ys0cTpU2GUdEdrXvPg@mail.gmail.com>
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
> ---
> Fixes: 025f072e5823947c ("compiler: enable CONFIG_OPTIMIZE_INLINING forcibly")
>
> As this is a patch in akpm's tree, the commit ID in the Fixes tag is not
> stable.

BTW, that Fixes tag is incorrect.

Irrespective of 025f072e5823947c, you could manually enable
CONFIG_OPTIMIZE_INLINING from menuconfig etc.

So, this build error would have been found much earlier
if somebody had been running randconfig tests on m68k.

It is impossible to detect this error on other architectures
because the driver config options are guarded by
'depends on ATARI' or 'depends on AMIGA'.


The correct tag is:

Fixes: 9012d011660e ("compiler: allow all arches to enable
CONFIG_OPTIMIZE_INLINING")

The commit id is stable.



As an additional work,
depends on (AMIGA || COMPILE_TEST)
would be nice unless this driver contains m68k-specific code.


-- 
Best Regards
Masahiro Yamada
