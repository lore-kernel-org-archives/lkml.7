Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A1F4C04AB6
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 08:19:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B1DD25E7D
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 08:19:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="pnNjf5KD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727683AbfFCITA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 04:19:00 -0400
Received: from conssluserg-02.nifty.com ([210.131.2.81]:19448 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727613AbfFCITA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 04:19:00 -0400
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id x538IkUm010888
        for <linux-kernel@vger.kernel.org>; Mon, 3 Jun 2019 17:18:47 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com x538IkUm010888
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1559549927;
        bh=HPTf6oudyVJie6W4n2JC8Ehi4mmYu1RfWzsjHZSF1Nw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=pnNjf5KDT12l3ZioAUZ2TX56pm+GhyLm4r8TZ3ePCtvILwrK8w+ySNRu8F6sPQJhx
         5C9+YCVvfWUx3Z+P5eOIkQ9K+jStkglBiZk3YC1O68GOMxYIW21WXcR4Q0w9lvUW/6
         khsrFQpTMPb4rQsuRz+7gD2HENRD6bBPAhI1/ehQp7VvbrBsJK4uL8eqEVa07aNjRC
         6Ad9ia/h5eJNlnYOnVzHT4Nv+z4vXCOB78T4OqMVAhtdW14ebAlxIeFQf+8U1T4MgM
         C4sL184nxD97LwZgiFUKokfRRz4hQMkvrr1cxu/8gh4Temfy4lDZU2Az9YrsDJNENc
         2D0BXRdYG7qgg==
X-Nifty-SrcIP: [209.85.217.54]
Received: by mail-vs1-f54.google.com with SMTP id m8so1604441vsj.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2019 01:18:47 -0700 (PDT)
X-Gm-Message-State: APjAAAWq48oXOQwCI7miAC2X15VZYD8i95OHjAHIESWlSJWa/Ah4jlrF
        uhgoqFxCtuiCCuQGbkN9OcF7ZIQ137enkqjQSnA=
X-Google-Smtp-Source: APXvYqyPKWuyt+23UjOXvdttDyJvl0sGlo6qbrT65pEc7Udo2uhEMRoX+aTnLLn90dlw2btiXBIVCCU1zkZbNIFqAU4=
X-Received: by 2002:a67:b109:: with SMTP id w9mr1144657vsl.155.1559549926179;
 Mon, 03 Jun 2019 01:18:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190603063119.36544-1-abrodkin@synopsys.com>
In-Reply-To: <20190603063119.36544-1-abrodkin@synopsys.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Mon, 3 Jun 2019 17:18:10 +0900
X-Gmail-Original-Message-ID: <CAK7LNASiHzar3JmzGB1fgUYUC91F3FPsALj3iMhANTjGgnux5w@mail.gmail.com>
Message-ID: <CAK7LNASiHzar3JmzGB1fgUYUC91F3FPsALj3iMhANTjGgnux5w@mail.gmail.com>
Subject: Re: [PATCH] ARC: build: Try to guess CROSS_COMPILE with cc-cross-prefix
To:     Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Cc:     arcml <linux-snps-arc@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexey,

On Mon, Jun 3, 2019 at 3:42 PM Alexey Brodkin
<Alexey.Brodkin@synopsys.com> wrote:
>
> For a long time we used to hard-code CROSS_COMPILE prefix
> for ARC until it started to cause problems, so we decided to
> solely rely on CROSS_COMPILE externally set by a user:
> commit 40660f1fcee8 ("ARC: build: Don't set CROSS_COMPILE in arch's Makefile").
>
> While it works perfectly fine for build-systems where the prefix
> gets defined anyways for us human beings it's quite an annoying
> requirement especially given most of time the same one prefix
> "arc-linux-" is all what we need.
>
> It looks like finally we're getting the best of both worlds:
>  1. W/o cross-toolchain we still may install headers, build .dtb etc
>  2. W/ cross-toolchain get the kerne built with only ARCH=arc
>
> Inspired by [1] & [2].
>
> [1] http://lists.infradead.org/pipermail/linux-snps-arc/2019-May/005788.html
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=fc2b47b55f17
>
> A side note: even though "cc-cross-prefix" does its job it pollutes
> console with output of "which" for all the prefixes it didn't manage to find
> a matching cross-compiler for like that:
> | # ARCH=arc make defconfig
> | which: no arceb-linux-gcc in (~/.local/bin:~/bin:/usr/bin:/usr/sbin)
> | *** Default configuration is based on 'nsim_hs_defconfig'


Oh really?

masahiro@pug:~$ which arc-linux-gcc
/home/masahiro/tools/arc/bin/arc-linux-gcc
masahiro@pug:~$ which dummy-linux-gcc
masahiro@pug:~$ echo $?
1


When 'which' cannot find the given command,
it does not print anything to stderr.

Does it work differently on your machine?




-- 
Best Regards
Masahiro Yamada
