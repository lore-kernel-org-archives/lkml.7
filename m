Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9058C3A59B
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 04:12:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3889B2082C
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 04:12:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="vscWVlL9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbfHSEMF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 00:12:05 -0400
Received: from conssluserg-01.nifty.com ([210.131.2.80]:55541 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725790AbfHSEME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 00:12:04 -0400
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id x7J4BxvD001609
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 13:11:59 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com x7J4BxvD001609
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1566187920;
        bh=QrreVsZ01rsR4mFyhdi/pB0zBKcJfRD9LLGKPXbjbkw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=vscWVlL9L/ARVdIAmKnqKO/8/NhbMC2S0ZBFbGyNygvLj7iePTGcYBPY+Dfb0wxm6
         CI9ddD9OoBlrpABUhgcZad3PDf+oeolAcLqkJpX4uuwBEUiKfrV1OfMM4w6NnKx3S2
         HtAR26+ak12H5vHGad0MSsYLCVB9aMd5N6IgUTRvvLBe+2drdiu1eEWRoU+CXwlgEP
         cxxrfvovdVrp54gUzRjPOLILcZuRoUm1ofIMb0azJldgYDT0Dz2cECTjTqmjCEKP8X
         oUvcArvsLa0A0T0RBmI0cIJji+rL88t+Ia//HN+wPurxZCIwCMKUgi1fr7TcDTCSNf
         4Qa5Iw5uGiN0A==
X-Nifty-SrcIP: [209.85.221.176]
Received: by mail-vk1-f176.google.com with SMTP id w20so118509vkd.8
        for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2019 21:11:59 -0700 (PDT)
X-Gm-Message-State: APjAAAVn7BJu/UO6dI2aChOjruePcaGfYmN+A+LHImif70l44gkt+nn3
        IYNvu4G27oW2mNv30nKbkXIRS9pb4lldTxmhRmU=
X-Google-Smtp-Source: APXvYqyPhRFZBOxMlEiYwrFBqfucp8uDz/KObQOE8Oz67guaLP2XFQN+J5QM+ikR7mMGkw29dmD03ZtfPn9A90CXfAY=
X-Received: by 2002:a1f:7c0e:: with SMTP id x14mr7641286vkc.0.1566187918601;
 Sun, 18 Aug 2019 21:11:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190618030926.30616-1-yamada.masahiro@socionext.com>
 <1318390798.95477.1560838785550.JavaMail.zimbra@nod.at> <CAK7LNARA62uqi8rkDeJ=zjA6vnruTAH2VGOBd4=sQMhF+FHMLA@mail.gmail.com>
 <957967732.18164.1561621143523.JavaMail.zimbra@nod.at> <CAK7LNAQLheA3E0UrjirNHzpS2x+xmjc2YCupCBMNoHOwviz6GQ@mail.gmail.com>
 <1574230514.38485.1563091693340.JavaMail.zimbra@nod.at>
In-Reply-To: <1574230514.38485.1563091693340.JavaMail.zimbra@nod.at>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Mon, 19 Aug 2019 13:11:22 +0900
X-Gmail-Original-Message-ID: <CAK7LNATAmk1AxV0kmn6yTsJzSpqTivWHOZy9GjH7J-NL-oBmhQ@mail.gmail.com>
Message-ID: <CAK7LNATAmk1AxV0kmn6yTsJzSpqTivWHOZy9GjH7J-NL-oBmhQ@mail.gmail.com>
Subject: Re: [PATCH v2] jffs2: remove C++ style comments from uapi header
To:     Richard Weinberger <richard@nod.at>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 14, 2019 at 5:08 PM Richard Weinberger <richard@nod.at> wrote:
>
> ----- Urspr=C3=BCngliche Mail -----
> > Looks like this trivial patch missed the pull request.
> >
> >
> > My motivation is to make sure UAPI headers
> > are really compilable in user-space,
> > and now checked by the following commit:
> >
> > commit d6fc9fcbaa655cff2d2be05e16867d1918f78b85
> > Author: Masahiro Yamada <yamada.masahiro@socionext.com>
> > Date:   Mon Jul 1 09:58:40 2019 +0900
> >
> >    kbuild: compile-test exported headers to ensure they are self-contai=
ned
> >
> >
> >
> > Is there a chance for it being merged,
>
> Sure. I think it is okay to send it for -rc2.
>
> Thanks,
> //richard


This patch missed the fixes pull requests.
Which version is this targeting for?   v5.4-rc1 ?



--=20
Best Regards
Masahiro Yamada
