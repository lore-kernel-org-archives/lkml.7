Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFCF4C04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 04:32:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B4DA20644
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 04:32:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="RwFsDZ8m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727090AbfEHEcq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 00:32:46 -0400
Received: from conssluserg-03.nifty.com ([210.131.2.82]:57959 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725825AbfEHEcp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 00:32:45 -0400
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id x484WGjd022829;
        Wed, 8 May 2019 13:32:17 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com x484WGjd022829
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1557289937;
        bh=Ps4nshk7Zk0dLbA3505OadTet8yPE5ONbU7K+n8ob/o=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=RwFsDZ8mZFGRpAvZrGOZlhrPoqAg4d566R4Pzb5WBlt/NeJjdonpqjmQucOaHCpZH
         Qoq+aYUTu7OSyES/qKLARdzxVQ2BbkDHiicqsX42JEQm4ZDhjgHWK9TkYemqeZhbWQ
         hsp7Q41668IV9NMHORlYjf3fzAHY1Ymfvr/OMY9ueNOKMDzbZoBZLZ3nSCYC3VY4yt
         kfccFLOv3acToYheAfdCLkDE/VIFZ6V7HtgHzcuFS5Znu+O+ybETdF0yJPl63gBNlP
         JagIlkL8hdUgTwOCt4o2UOkOMhnFPRTYTcAmP3bq6BqMHjh6Pln0yPgkUj4NlEezFl
         mut5LeoeCxygA==
X-Nifty-SrcIP: [209.85.222.46]
Received: by mail-ua1-f46.google.com with SMTP id f9so6898643ual.1;
        Tue, 07 May 2019 21:32:16 -0700 (PDT)
X-Gm-Message-State: APjAAAUtr1WDSy+TljhtQ5c9Rz3+FMLjYZC4V8GzhoNJs2Dih35fS644
        9mtMfZTqe6XKwkargkSKqhRjGHn+sYWcLA8JbnM=
X-Google-Smtp-Source: APXvYqyN7//sr1iQvDH6P2JrFGC8ks2rJ/Zq3PumOClZ6goClsxQSulHsCamCd7f1fV8zcCLccwkpNusygOCOU268Sc=
X-Received: by 2002:ab0:3058:: with SMTP id x24mr18605406ual.95.1557289935781;
 Tue, 07 May 2019 21:32:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190506094609.08e930f2@canb.auug.org.au> <CAK7LNASH4CuVBjfEJsT+aBx4aLrj9j2=aOD3B4f9+Tdcm=x2pg@mail.gmail.com>
 <20190506033151.GB2649@windriver.com> <CAK7LNAS=D96B_OgnRu-NK0-G+y8itvhe3qvwfYxZUCSqdC0gEA@mail.gmail.com>
 <20190506142010.GC2649@windriver.com>
In-Reply-To: <20190506142010.GC2649@windriver.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Wed, 8 May 2019 13:31:39 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQXg_3-ka8QHDJi=svnDz1rEA6Yx7Oy_=TXTFYXRBJaeQ@mail.gmail.com>
Message-ID: <CAK7LNAQXg_3-ka8QHDJi=svnDz1rEA6Yx7Oy_=TXTFYXRBJaeQ@mail.gmail.com>
Subject: Re: Fwd: linux-next: build failure after merge of the kbuild tree
To:     Paul Gortmaker <paul.gortmaker@windriver.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,


On Mon, May 6, 2019 at 11:23 PM Paul Gortmaker
<paul.gortmaker@windriver.com> wrote:
>
> [Re: Fwd: linux-next: build failure after merge of the kbuild tree] On 06/05/2019 (Mon 21:07) Masahiro Yamada wrote:
>
> > Hi Paul,
> >
> >
> > On Mon, May 6, 2019 at 12:34 PM Paul Gortmaker
> > <paul.gortmaker@windriver.com> wrote:
> > >
> > > [Fwd: linux-next: build failure after merge of the kbuild tree] On 06/05/2019 (Mon 11:19) Masahiro Yamada wrote:
> > >
> > > > Hi Paul,
> > > >
> > > > In today's linux-next build testing,
> > > > more "make ... explicitly non-modular"
> > > > candidates showed up.
> > > >
> > >
> > > Hi Masahiro,
> > >
> > > I am not 100% clear on what you are asking me.  There are lots and lots
> > > of these in the kernel.... many fixed, and many remain unfortunately.
> > >
> > > > arch/arm/plat-omap/dma.c
> > > > drivers/clocksource/timer-ti-dm.c
> > > > drivers/mfd/omap-usb-host.c
> > > > drivers/mfd/omap-usb-tll.c
> > >
> > > None of these are "new".  I just checked, and I have had patches for all
> > > these for a long time, in my personal queue, found by my audits.
> >
> >
> > OK, I saw many patches from you
> > addressing this issue,
> > so I just thought you might be motivated to
> > fix them.
> >
> > Anyway, I have a reason to fix them
> > because a patch in my tree is causing build errors.
>
> I understand now.  I missed the connection between these drivers and the
> Kbuild change when I read this last night.  Sorry about that.
>
> I can send the changes to those four files, but since I can't guarantee
> they will be merged quickly (or at all!) - that will leave the commit in
> the Kbuild tree causing build regressions for days or likely even weeks.
>
> > So, I will do something for them
> > if you do not have a plan to send patches soon.
>
> I will be happy to send them, but we just opened the two week merge
> window, and a lot of maintainers don't like getting sent new patches
> until the two week merge window has closed - so we should avoid that.
>
> I'm not sure how you would like to proceed - one way would be that we
> get the drivers above changed in 5.2 and you delay your kbuild change
> until we start v5.3 - to that end I'd be happy to add the Kbuild change
> to my internal build testing in the meantime, if you would like.
>
> Now that I understand the problem, let me know what you would like to
> do, and I'll do what I can to help out.


I decided to merge minimal changes to my kbuild tree
since I did not want to delay the kbuild patch.

I got some Ack tags, so I applied this patch:
https://patchwork.kernel.org/patch/10931673/

I appreciate if you could fix those files in a complete way,
but there is no more reason to rush.



> Thanks,
> Paul.




--
Best Regards
Masahiro Yamada
