Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BE32C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 06:43:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E893D2081B
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 06:43:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="HEAcg07G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbfCHGni (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 01:43:38 -0500
Received: from conssluserg-06.nifty.com ([210.131.2.91]:34865 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726399AbfCHGni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 01:43:38 -0500
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id x286hQ53014575;
        Fri, 8 Mar 2019 15:43:27 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com x286hQ53014575
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1552027407;
        bh=9w8/4CZThu55TWkHF/fXOlAZSSKyh3Iu1gpYCiWtUIU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=HEAcg07GZwLYnrEcarljRZiSLkwTQER99oio/V3B7LjJH2b/C4qVfcaiWlCqvwzqf
         IMw/z3SDlL6ZvXJjMyDZRZGdpFFEP0F69CEU4Hl6hYFqZqfLnL6feuJzvacG8f/ytV
         o2hA/iXJtszm0UT2DrXHa6+9prAeKONYDO0egpo541IVcarDZraj8gvBe5hwtM6eBn
         yGlUXAuh2fKKuB0s41Le5gSEUKcvX/6hB3IsrYhfpvuQXLIMNfC/ePM8UoYeE3p26W
         /7CGRTGzQRexXGHNmvqFEYDCa2e1ydBZBsK/mXEh9uBipw8HO7sf/I+O15qwoB9Pfl
         MofKmzffU6FkQ==
X-Nifty-SrcIP: [209.85.217.45]
Received: by mail-vs1-f45.google.com with SMTP id e81so6061443vsd.2;
        Thu, 07 Mar 2019 22:43:26 -0800 (PST)
X-Gm-Message-State: APjAAAWz9dpssjK/1QkEdvmbbp0mGwVDx5weEi6kj1BI3ttnabm/QOk8
        d6jp2a9cFVhJS6n2bJl1NNnnfslQE0Np87RA5DU=
X-Google-Smtp-Source: APXvYqzAQqvbcPMmPJ1SVIRdn8oVIxWJ1kaT1Eu7IzJtEr3XI+PysZE7H3svTnmEw0oz5PWvYCCCxodvW8AWLRmwU1g=
X-Received: by 2002:a67:7c04:: with SMTP id x4mr9085999vsc.155.1552027405759;
 Thu, 07 Mar 2019 22:43:25 -0800 (PST)
MIME-Version: 1.0
References: <1551888035-13329-1-git-send-email-yamada.masahiro@socionext.com>
 <5760e0a210c7c39b486aa932ccbe7f3f2c210d62.camel@decadent.org.uk>
 <CAK7LNAQFWWzki-MvmhDpAn46XkDAu4_EGCQotbi5qAk5oJrgUQ@mail.gmail.com>
 <788870e550cb3cecafd9db14c081ddb0225edfde.camel@decadent.org.uk>
 <CABkpOEUqJWn62VZoTA5UEnbDieiYR9y3diRQhZuOVe6hOoBNhA@mail.gmail.com> <c93a7273c89c649373761f2ba26a6ef05787d08d.camel@decadent.org.uk>
In-Reply-To: <c93a7273c89c649373761f2ba26a6ef05787d08d.camel@decadent.org.uk>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Fri, 8 Mar 2019 15:42:49 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQzfiZejYKKtFSineEwB5M_GcUktBmLgAGs2iC7i4Cbfw@mail.gmail.com>
Message-ID: <CAK7LNAQzfiZejYKKtFSineEwB5M_GcUktBmLgAGs2iC7i4Cbfw@mail.gmail.com>
Subject: Re: [PATCH] kbuild: add workaround for Debian make-kpkg
To:     Ben Hutchings <ben@decadent.org.uk>
Cc:     Manoj Srivastava <manoj.srivastava.1962@gmail.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Liz Zhang <lizzha@microsoft.com>,
        Lili Deng <v-lide@microsoft.com>,
        Riku Voipio <riku.voipio@linaro.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 8, 2019 at 6:56 AM Ben Hutchings <ben@decadent.org.uk> wrote:
>
> On Wed, 2019-03-06 at 22:48 -0800, Manoj Srivastava wrote:
> > Hi,
> >
> >   Does this have any users?

Recently, I received a regression report.
So, yes. There are users.


> > I can take a stand at making it work, but I am
> > unsure of there are enough people interested in make-kpkg anymore to make
> > it worthwhile.
> >
> >   There is a man pager that might be of minor interest, but that can be
> > taken over by the kernel team if they want

I do not want to maintain the dying package.



> [...]
>
> I assume you're referring to kernel-img.conf.  I would be happy to add
> that to linux-base, with some clarification of which settings are
> understood by which packages.
>
> I take it that you don't want kernel-package to be included in buster,
> so can you open an RC bug to say so?

Also, could you make sure it won't come back to bullseye or later ?

How about Ubuntu? Is it out of your control?



> Ben.
>
> --
> Ben Hutchings
> friends: People who know you well, but like you anyway.
>
>


-- 
Best Regards
Masahiro Yamada
