Return-Path: <SRS0=E2Zf=ZP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD51FC432C0
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 06:41:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 933732077B
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 06:41:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="qINkBkJ2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726634AbfKWGlO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Nov 2019 01:41:14 -0500
Received: from conssluserg-01.nifty.com ([210.131.2.80]:35264 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725800AbfKWGlO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Nov 2019 01:41:14 -0500
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id xAN6f2IS007406;
        Sat, 23 Nov 2019 15:41:03 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com xAN6f2IS007406
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1574491263;
        bh=vN50Gdum6xdlN2ZBfve3DiyX2BSz6gAGvfttTfq4jEw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=qINkBkJ2EF/GIIO3gARVfNl0bSOFycoxqCXm8gkCj/HQv5+OSiLZE8c/j4557r9/e
         Jqe+3lXgnpfvtyjFWKIl30lHwFihK++V3PvXE+a2dElppm8gqtAQKfUcCJ/ywBF0MQ
         O3auaaNHJKC1I4Cj8qhg5OIMNmVo/4Dli00oam6LXqkFLIr2OIOrR08rYQE6qPFLGj
         k566NZ8+ESB0lyJkThqzQBltuvB7FDriKCQ/e5Rm/+UcymlbpmzYqwDo1EPZthByQL
         Iw1EfkkWN2mCRLJrBDQOdPDpEi7QauLP2BHbSWnXxPpJcryqCDYXK1BSfYHw/eAfNt
         7gbAfoX3rERIg==
X-Nifty-SrcIP: [209.85.217.47]
Received: by mail-vs1-f47.google.com with SMTP id b16so6414715vso.10;
        Fri, 22 Nov 2019 22:41:03 -0800 (PST)
X-Gm-Message-State: APjAAAVRl43XzXiitqOkAIVqiUjcbqjWEu/l+fic7WiRgusyVeWCOOCi
        /THVOAZNqc/Y1lsZiuxvumrO4Gs/36NgJ5rBnTw=
X-Google-Smtp-Source: APXvYqwCzdm40Gq6CsfRCo2bRpzoGsLsQ2VEhcQ9FguSBgt/9ADgEwAt3pC3LvuuB6eZdbnVfLasA5t20Qi5ubBx9zs=
X-Received: by 2002:a67:e241:: with SMTP id w1mr1916378vse.155.1574491262013;
 Fri, 22 Nov 2019 22:41:02 -0800 (PST)
MIME-Version: 1.0
References: <20191118045247.14082-1-yamada.masahiro@socionext.com> <2b1ab1b1-dd20-31f7-c787-921cbd66a828@kernel.dk>
In-Reply-To: <2b1ab1b1-dd20-31f7-c787-921cbd66a828@kernel.dk>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Sat, 23 Nov 2019 15:40:25 +0900
X-Gmail-Original-Message-ID: <CAK7LNASmC_1vwo9vhJGMZNng1dvkJmMzCQi7NEgh3V+JGu_QsA@mail.gmail.com>
Message-ID: <CAK7LNASmC_1vwo9vhJGMZNng1dvkJmMzCQi7NEgh3V+JGu_QsA@mail.gmail.com>
Subject: Re: [PATCH] kbuild: make single target builds even faster
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 18, 2019 at 11:26 PM Jens Axboe <axboe@kernel.dk> wrote:
>
> On 11/17/19 9:52 PM, Masahiro Yamada wrote:
> > Commit 2dffd23f81a3 ("kbuild: make single target builds much faster")
> > made the situation much better.
> >
> > To improve it even more, apply the similar idea to the top Makefile.
> > Trim unrelated directories from build-dirs.
> >
> > The single build code must be moved above the 'descend' target.
>
> I tested linux-next, which does improve things a bit, and this one on
> top further improves it. We're now not THAT far off the situation
> before these changes, that's a huge win. Thanks for working on this!
>
> You can add:
>
> Tested-by: Jens Axboe <axboe@kernel.dk>
>
> to the commit, if you wish.
>


Applied to linux-kbuild with Jens' Tested-by.


-- 
Best Regards
Masahiro Yamada
