Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E82CC10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 04:28:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3EA920811
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 04:28:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="vSS6o7W9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727611AbfDWE2n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 00:28:43 -0400
Received: from conssluserg-01.nifty.com ([210.131.2.80]:60518 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbfDWE2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 00:28:42 -0400
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id x3N4SThk022920;
        Tue, 23 Apr 2019 13:28:29 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com x3N4SThk022920
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1555993710;
        bh=A5WbuquZD8Z744dthAXZaZjRS+coKIXx0Ed/3x/NqYk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=vSS6o7W9oEQIKx1vPehRVKHXjluN/CtkJSkJB8KPCDodexhDwV/nyKl7QwUlDzyJ/
         qW5JjenFV3nVNMpQI2bEpfdw/8/jKWLbNZ+KB5J7uFXgRZpXdMifa31RdRUEhvWk1t
         wZaER1J+4V8SI+3sh0HRR3YaqwOeVsMMwWACFg0Mg+r/qBE2MM8J+wXVK/dmX8V2Ex
         50okTkIf8hyLSB/JI+VLTl+/vLDTsPZ1ovPx8R2aNxpOSkNk7ZoooyTlZ0PwpjZGWF
         t6GyU3955/jWIWlJTYDjWLiZQe//V4l19Te5blEQ0A0BneBj9QGQ1389CxUKQH8sdF
         uLSJGsmylcRfw==
X-Nifty-SrcIP: [209.85.217.42]
Received: by mail-vs1-f42.google.com with SMTP id s2so7486012vsi.5;
        Mon, 22 Apr 2019 21:28:29 -0700 (PDT)
X-Gm-Message-State: APjAAAXq4+ZQEhaVBvlCoJnaUVhPheBt4e6QrBeg84gi/rP8BM/qf1Tq
        sn8HS+WbBvu/mhTGYlYm1ENWTGHOYQLSiU7SosA=
X-Google-Smtp-Source: APXvYqxvYA35esIFIzQ+xyciI9an0CHLEVxTam/0z2vM1REtId53atRqLnnAMzLi9m1WXbZX5ENra3RRrTcoC5YYliQ=
X-Received: by 2002:a67:ee98:: with SMTP id n24mr12474513vsp.155.1555993708510;
 Mon, 22 Apr 2019 21:28:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190423084042.29fd9c03@canb.auug.org.au>
In-Reply-To: <20190423084042.29fd9c03@canb.auug.org.au>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Tue, 23 Apr 2019 13:27:52 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQWMVqbN9Bytz7WWrUvJ_fe8joUR+R4jmszV54pkucvyA@mail.gmail.com>
Message-ID: <CAK7LNAQWMVqbN9Bytz7WWrUvJ_fe8joUR+R4jmszV54pkucvyA@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the at91 tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Ludovic Desroches <ludovic.desroches@microchip.com>
Cc:     Nicolas Ferre <nicolas.ferre@atmel.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 23, 2019 at 10:33 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> After merging the at91 tree, today's linux-next build (arm
> multi_v7_defconfig) failed like this:
>
> arch/arm/mach-at91/pm_suspend.S:17:10: fatal error: pm_data-offsets.h: No such file or directory
>  #include "pm_data-offsets.h"
>           ^~~~~~~~~~~~~~~~~~~
>
> Caused by commit
>
>   ab690fa1eb4b ("ARM: at91: move platform-specific asm-offset.h to arch/arm/mach-at91")
>
> I used the version of the at91 tree from next-20190418 for today.


Sorry, I missed to test the out-of-tree build.

-I $(srctree)/$(src) is not added
when check-in assembly files include a generated header.
(I think this should be automatically cared by Kbuild, though.)


Ludovic,

Could you drop this patch for now?




-- 
Best Regards
Masahiro Yamada
