Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1004BC432C2
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 11:52:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1B7321D56
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 11:52:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="J2oDXDPo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726215AbfIZLwx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 07:52:53 -0400
Received: from conssluserg-05.nifty.com ([210.131.2.90]:31598 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725877AbfIZLww (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 07:52:52 -0400
X-Greylist: delayed 5224 seconds by postgrey-1.27 at vger.kernel.org; Thu, 26 Sep 2019 07:52:51 EDT
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id x8QBqf8K015871;
        Thu, 26 Sep 2019 20:52:41 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com x8QBqf8K015871
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1569498762;
        bh=+62D9236cTgE1YamYRIBdf579l4q6GlpGs0F5mD3z3A=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=J2oDXDPoVVEXXHrxAHeI7IBq2Hmp24rzZqdMjsQspLnCh+NrDl4ezyl16DbDpadhd
         P/0P8LU/JkBmjYP/Xmy8uLgtc9mJRXJmUy/KXG2FjSK1voNaP1kRtv88tSXLdqbrH8
         YqgztBTupmXBCTjUZdJJr8OJKv/XX7Yzx9q8e48HDndhybVmTrStx1GD7N0DYWx7uH
         MiEFZoiPCeSXAHHiopInxiROzc+L0tzeEETRzsxJPFVDdMBI8q4lilgVp3cXEbYEVp
         ZJ+Uqq7VsqMRbq8+JpJmyX0xyey+3m/t157xs0BtmFCZOWnzr82KKjSJ4zZDcwldYq
         8UYSmFaJSyzig==
X-Nifty-SrcIP: [209.85.217.47]
Received: by mail-vs1-f47.google.com with SMTP id d204so1360590vsc.12;
        Thu, 26 Sep 2019 04:52:41 -0700 (PDT)
X-Gm-Message-State: APjAAAWoVXjgaNY7lxkY/3cQs7Fbsd6YlcJKxWk/HyQ0KlSvxgiRgS7i
        KhVUeDrs5iHKV9jO8TCVoXqfvVTYqWSUfwczNhs=
X-Google-Smtp-Source: APXvYqzl4Bl4cH3IQmKL+GgyuH5KFHMny1Q8PPwuMn/uW2v5G/87/SwlwldHycNcU6DS/BrJ+KjFTt6W/O79v4O1284=
X-Received: by 2002:a67:ec09:: with SMTP id d9mr1431105vso.215.1569498760483;
 Thu, 26 Sep 2019 04:52:40 -0700 (PDT)
MIME-Version: 1.0
References: <20190926101312.32218-1-geert@linux-m68k.org> <CAK7LNATN5QyC+-_VRZm_ZysYd8Z8aWU0Ys0cTpU2GUdEdrXvPg@mail.gmail.com>
 <CAMuHMdU3T83z1iZ7O2-5eRkawdGm50Auw5o0K9+J5Q7+oev62g@mail.gmail.com>
In-Reply-To: <CAMuHMdU3T83z1iZ7O2-5eRkawdGm50Auw5o0K9+J5Q7+oev62g@mail.gmail.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Thu, 26 Sep 2019 20:52:04 +0900
X-Gmail-Original-Message-ID: <CAK7LNAShZJw4K4kDURPyJ1_NGQt50cBA-aB2HZCzK7LOdNSaKA@mail.gmail.com>
Message-ID: <CAK7LNAShZJw4K4kDURPyJ1_NGQt50cBA-aB2HZCzK7LOdNSaKA@mail.gmail.com>
Subject: Re: [PATCH -next] fbdev: c2p: Fix link failure on non-inlining
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

On Thu, Sep 26, 2019 at 8:43 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:

>
> BTW, does randconfig randomize choices these days?
> I remember it didn't use to do that.

randconfig does randomize choices.


masahiro@pug:~/ref/linux$ make -s randconfig ; grep OPTIMIZE_FOR .config
KCONFIG_SEED=0x75F1F6C8
CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
masahiro@pug:~/ref/linux$ make -s randconfig ; grep OPTIMIZE_FOR .config
KCONFIG_SEED=0x8FDFC7FC
# CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE is not set
CONFIG_CC_OPTIMIZE_FOR_SIZE=y


all{yes,mod}config always takes the default in the choice.
So, you cannot enable CONFIG_CC_OPTIMIZE_FOR_SIZE by all{yes,mod}config.





> The Amiga and Atari frame buffer drivers need <asm/{amiga,atari}hw.h>,
> and the Atari driver contains inline asm.
>
> The C2P code could be put behind its own Kconfig symbol, I guess.

OK, then.


Thanks.




-- 
Best Regards
Masahiro Yamada
