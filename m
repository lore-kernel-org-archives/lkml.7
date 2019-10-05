Return-Path: <SRS0=6Pxm=X6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B7B5C4360C
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Oct 2019 03:13:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A573720873
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Oct 2019 03:13:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="aSv4GDJ1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726837AbfJEDNf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 23:13:35 -0400
Received: from conssluserg-02.nifty.com ([210.131.2.81]:37193 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725907AbfJEDNf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 23:13:35 -0400
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id x953DTuJ008258
        for <linux-kernel@vger.kernel.org>; Sat, 5 Oct 2019 12:13:30 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com x953DTuJ008258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1570245210;
        bh=irSWPoT/oWBLM2zzUBWK1kr91+umlfLuE+7KXkQtGto=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=aSv4GDJ1bi/8PeA8xNTpO2Akp2jk+/N7M42UPW7WiK1jt4hEl5d1jr3alvFw9h3Q+
         lnXDuc/iUeKWNl1eFlEHRw1b049zHw3HnplT306pO7ZzQKERU0Chy3pgoJaExV4Jpv
         YnZsis1jHq2t+48SyFfIlThQLmcLsv34iqL0e1W9HRiMyxf7DSCzLvAESvSqxxw/Ga
         40YHtSQYCRPc/IkOG/Lx2/Hj72VyQTcn0cJEoyJc680HZs7WwdUSV6uJE+l+5IMgfj
         vM4ZFZqi82XiNGAKgk8BdM1aHDk4TpEl4mJcMYfXVN9b5SkZE2f5FuQVq0fQrHZCCq
         wdL8oQB9yVt1Q==
X-Nifty-SrcIP: [209.85.222.43]
Received: by mail-ua1-f43.google.com with SMTP id q11so2639891uao.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2019 20:13:30 -0700 (PDT)
X-Gm-Message-State: APjAAAWEu9vL/pmcFyrLpcNFFsqEB8VOixw3Zj+8f1AoTz6Xhsae8usF
        Ed9UhxMzaEW/6FmCv3I46YxHYlW24DAvCs46FS8=
X-Google-Smtp-Source: APXvYqx+lvkdS6HNfxywSNsDGQWBuNJowDP39uM/ilT7XUJn2Jt3qfWL4I89dt8KBZRoK+2SKfJwgH8ma8+GoIPN4Fc=
X-Received: by 2002:ab0:6355:: with SMTP id f21mr9727685uap.40.1570245208863;
 Fri, 04 Oct 2019 20:13:28 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.DEB.2.21.9999.1910041037590.15827@viisi.sifive.com>
In-Reply-To: <alpine.DEB.2.21.9999.1910041037590.15827@viisi.sifive.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Sat, 5 Oct 2019 12:12:52 +0900
X-Gmail-Original-Message-ID: <CAK7LNASZG1T4wQFTcaZyHx=hpKNG3d269=7uWBmdvxOt4s02Gw@mail.gmail.com>
Message-ID: <CAK7LNASZG1T4wQFTcaZyHx=hpKNG3d269=7uWBmdvxOt4s02Gw@mail.gmail.com>
Subject: Re: kbuild change breaks HiFive-U boot here
To:     Paul Walmsley <paul.walmsley@sifive.com>
Cc:     linux-riscv@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

On Sat, Oct 5, 2019 at 2:48 AM Paul Walmsley <paul.walmsley@sifive.com> wrote:
>
>
> Commit 858805b336be1cabb3d9033adaa3676574d12e37 ("kbuild: add $(BASH) to
> run scripts with bash-extension") breaks my kernel test flow that targets
> the HiFive Unleashed board.  The boot traps during BBL early boot and
> stops.  QEMU is unaffected.  Reverting 858805b336be fixes the issue.

The reason is because
a shell script using bash-extension is run by 'sh' instead of 'bash'.

Run 'git grep CONFIG_SHELL', then can you find a suspicious script?
Is there a warning/error message in the build log?



> I haven't yet had the opportunity to root-cause the issue.  The issue may
> be related to idiosyncracies in my local boot testing process, rather
> than this commit.
>
>
> - Paul



-- 
Best Regards
Masahiro Yamada
