Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B610C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 06:55:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 167042070B
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 06:55:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="b2A5PWNJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731203AbfCZGzX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 02:55:23 -0400
Received: from conssluserg-03.nifty.com ([210.131.2.82]:26635 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726171AbfCZGzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 02:55:22 -0400
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id x2Q6tFam024077;
        Tue, 26 Mar 2019 15:55:15 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com x2Q6tFam024077
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1553583316;
        bh=ZTLgSM1mO1pr23hIFYrx8hyiWl+7jjWpTd6XoqBsTAM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=b2A5PWNJb5mx62hIvCfJRb6f1wvs546TOTCDoDCASDQo71xomR3bBF8n+xEZLBNuT
         a6QG3YZ4xiaITCxMg9EU9eQO+KwoIsjv29HoBKPYPJslHRa6IcWcYky+/zxHLC2V1p
         VhhXdb8Yg7vCb5a7vFQN4lO8hfgeQGJiDhm6KSsPVsXvrmOyFKngpeSUsqH005OBHx
         an5qda5jpU2ixvs25aBW+u5ObaP7AvbWz3jqsm1b4M+8Qt+utNf33+zGd4S0SYkM8J
         315GFUdJz09MxK2d7Poqmo3fll1BZXW1Qg7K4lLFzmmjFq4boz/EXX7BRODpXbE36I
         zKTHwluzf5ouw==
X-Nifty-SrcIP: [209.85.217.42]
Received: by mail-vs1-f42.google.com with SMTP id e1so7003509vsp.2;
        Mon, 25 Mar 2019 23:55:15 -0700 (PDT)
X-Gm-Message-State: APjAAAVHerZO25V6b6cK91IUON3sVSi54qwnStBQdlrm0SaiVR4JnR11
        53XTtXWXAyWW2R0v/QpQKirs4ymVW8oncMLJDpI=
X-Google-Smtp-Source: APXvYqzV9OprKdvHU63DVjLcAFetIJS3ZLs1hjqNUeM8DGDu+7OA+RlaT637zUo8SuAR/q6K0ukwOj1IIaTs1ZocwpI=
X-Received: by 2002:a67:f105:: with SMTP id n5mr17824787vsk.181.1553583314850;
 Mon, 25 Mar 2019 23:55:14 -0700 (PDT)
MIME-Version: 1.0
References: <1550217319-40418-1-git-send-email-wen.yang99@zte.com.cn>
 <CAK7LNASzd=bL1H34w-E_UD9x6w2=ObyS+EPDZ_jrvfV+ncw-yA@mail.gmail.com> <1691b160-5558-d4c3-afed-5773e115c5aa@web.de>
In-Reply-To: <1691b160-5558-d4c3-afed-5773e115c5aa@web.de>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Tue, 26 Mar 2019 15:54:38 +0900
X-Gmail-Original-Message-ID: <CAK7LNASVRbroW9_j1Kda3azHb6PzD3WyVAsKe0HfD1ri0RFPOQ@mail.gmail.com>
Message-ID: <CAK7LNASVRbroW9_j1Kda3azHb6PzD3WyVAsKe0HfD1ri0RFPOQ@mail.gmail.com>
Subject: Re: [v5] coccinelle: semantic code search for missing put_device()
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     Wen Yang <wen.yang99@zte.com.cn>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Michal Marek <michal.lkml@markovi.net>,
        Yi Wang <wang.yi59@zte.com.cn>,
        Wen Yang <yellowriver2010@hotmail.com>,
        Cheng Shengyu <cheng.shengyu@zte.com.cn>,
        cocci@systeme.lip6.fr, kernel-janitors@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 24, 2019 at 1:19 AM Markus Elfring <Markus.Elfring@web.de> wrote:
>
> > Applied to linux-kbuild.
>
> A questionable development version was integrated for this SmPL script.


Sorry for my bad job.

I usually use LKML patchwork to find patches.

When I searched "Wen Yang", v6 did not show up for some reasons.
https://lore.kernel.org/patchwork/project/lkml/list/?series=&submitter=22638&state=*&q=&archive=&delegate=

So, I just thought v5 was the latest one
and I was completely missing the context.


Apology.

Masahiro



> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/scripts/coccinelle/free/put_device.cocci?id=da9cfb87a44da61f2403c4312916befcb6b6d7e8
>
> https://lore.kernel.org/cocci/201902191014156680299@zte.com.cn/
>
>
> Now I am curious on how such a source code analysis approach will be
> improved further.
> Which changes will get the desired acceptance?
>
> https://lore.kernel.org/patchwork/patch/1053979/
> https://lore.kernel.org/lkml/1553321671-27749-1-git-send-email-wen.yang99@zte.com.cn/
> https://systeme.lip6.fr/pipermail/cocci/2019-March/005679.html
>
> Regards,
> Markus
--
Best Regards
Masahiro Yamada
