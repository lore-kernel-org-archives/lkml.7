Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D43E9C28CC6
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 00:40:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB17124DC6
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 00:40:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="CL9pfdqd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbfFDAkR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 20:40:17 -0400
Received: from conssluserg-01.nifty.com ([210.131.2.80]:56104 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbfFDAkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 20:40:17 -0400
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id x540eAQO013092
        for <linux-kernel@vger.kernel.org>; Tue, 4 Jun 2019 09:40:11 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com x540eAQO013092
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1559608811;
        bh=wkUOXkAQWjCghhrEfa+xujqIJm2LCnnnL46/x2l8/hA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=CL9pfdqd8hpJEyyDFVV1XWbcHHiLN3CeVW+bdooQOZg1pB3H2i3NuEA0O5vM1/oJx
         YtpoBCohFa48uypYjVP9FljMVLriI/UIeXYQTrviDQNCKuEE0hNRAG4I66As9G2XSV
         POakiSCF8+2lT0Tr1+5uzhCNwbmekX+sCGMK3EERVzAinFo8oDq04bXPuUDeGssoRG
         EkG7tV5+k9FdldF1aUzfPeTW0Jkntlwjit18QLzr/1c4C3GDqMbdYPMPCmQ4eXBzx4
         qdpJ6rhRmlC8Ps7sKihZljmk72YhWkBZBj8KjoQiAnfgoUXllNQ4Ff+qYi3AmrWBrY
         3kPW9iYhguMng==
X-Nifty-SrcIP: [209.85.217.43]
Received: by mail-vs1-f43.google.com with SMTP id l125so12396782vsl.13
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2019 17:40:11 -0700 (PDT)
X-Gm-Message-State: APjAAAWiU894ZGzlzoyppICSVMa8oUsSsOYH7YAKM9+XmVh/iyNCcOrg
        xKr1h20hCEczVtz1a9KHyunoB0W1cuIDnPojmVI=
X-Google-Smtp-Source: APXvYqxeEyV+OfJJFSJ8jk4Q9esZ5B4cQMMUpgD9fpKCsAkW5SX/fyXI4m16lQU3Igtzntt2Mz0t/qtPX9l3BnslmRw=
X-Received: by 2002:a67:1842:: with SMTP id 63mr3659752vsy.179.1559608810313;
 Mon, 03 Jun 2019 17:40:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190603063119.36544-1-abrodkin@synopsys.com> <C2D7FE5348E1B147BCA15975FBA2307501A2522AB4@us01wembx1.internal.synopsys.com>
In-Reply-To: <C2D7FE5348E1B147BCA15975FBA2307501A2522AB4@us01wembx1.internal.synopsys.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Tue, 4 Jun 2019 09:39:34 +0900
X-Gmail-Original-Message-ID: <CAK7LNARNGdQ16+vDBg1M=FsLqSpL1ONd44V8JV+_6Amofn75rQ@mail.gmail.com>
Message-ID: <CAK7LNARNGdQ16+vDBg1M=FsLqSpL1ONd44V8JV+_6Amofn75rQ@mail.gmail.com>
Subject: Re: [PATCH] ARC: build: Try to guess CROSS_COMPILE with cc-cross-prefix
To:     Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc:     Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 4, 2019 at 1:27 AM Vineet Gupta <Vineet.Gupta1@synopsys.com> wrote:
>
> On 6/2/19 11:31 PM, Alexey Brodkin wrote:
> > For a long time we used to hard-code CROSS_COMPILE prefix
> > for ARC until it started to cause problems, so we decided to
> > solely rely on CROSS_COMPILE externally set by a user:
> > commit 40660f1fcee8 ("ARC: build: Don't set CROSS_COMPILE in arch's Makefile").
> >
> > While it works perfectly fine for build-systems where the prefix
> > gets defined anyways for us human beings it's quite an annoying
> > requirement especially given most of time the same one prefix
> > "arc-linux-" is all what we need.
> >
> > It looks like finally we're getting the best of both worlds:
> >  1. W/o cross-toolchain we still may install headers, build .dtb etc
> >  2. W/ cross-toolchain get the kerne built with only ARCH=arc
> >
> > Inspired by [1] & [2].
> >
> > [1] http://lists.infradead.org/pipermail/linux-snps-arc/2019-May/005788.html
> > [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=fc2b47b55f17
> >
> > A side note: even though "cc-cross-prefix" does its job it pollutes
> > console with output of "which" for all the prefixes it didn't manage to find
> > a matching cross-compiler for like that:
> > | # ARCH=arc make defconfig
> > | which: no arceb-linux-gcc in (~/.local/bin:~/bin:/usr/bin:/usr/sbin)
> > | *** Default configuration is based on 'nsim_hs_defconfig'
> >
> > Signed-off-by: Alexey Brodkin <abrodkin@synopsys.com>
> > Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
> > Cc: Vineet Gupta <vgupta@synopsys.com>
>
> Not a big deal but I'd propose we add "Suggested-by: vgupta" since that is where
> it came from.
>
> @Masahiro san I suppose you are OK with this, so perhaps an Ack etc would be nice
> to have.

FWIW,
Reviewed-by: Masahiro Yamada <yamada.masahiro@socionext.com>



-- 
Best Regards
Masahiro Yamada
