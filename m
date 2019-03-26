Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF051C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 09:53:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 420DA20857
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 09:53:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="tvq7Lpiu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731092AbfCZJxG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 05:53:06 -0400
Received: from conssluserg-02.nifty.com ([210.131.2.81]:45178 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726042AbfCZJxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 05:53:05 -0400
X-Greylist: delayed 10662 seconds by postgrey-1.27 at vger.kernel.org; Tue, 26 Mar 2019 05:53:03 EDT
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id x2Q9qtta014886;
        Tue, 26 Mar 2019 18:52:55 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com x2Q9qtta014886
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1553593976;
        bh=kV/gXSw40P1r8Zz10t0raRXOXkdEnLzy9iyAhmXGUCU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=tvq7Lpiujb9UqywGQaJO4lJhpxExRxHJTPxJYpmwIqpJbhLkT/K/KpKX1kaxUv4yR
         WPivnZxbLjpMOCctZ8m7bDOiK3LRzFBrX+N7G+m3V2SV/YWsvRD5xr8hN7iW15YDuy
         QJA7Kw6a+WV7+n0LktCqQcRJSWi3m2Q682FT5CJ+SmPczZTswhSx2E4Cg429Pv8IKw
         TBxbIIVVKqRwzut9L2CIDWHYdmDEMYsUqTZr9hi2K8ox1BmtI2nccaPTopFR/Sf1Q9
         Asi42RORHidl5meb6Yx/RnGrAua2dvdJ/ddTnLfKHhcEiATRIQcLu7TScPoLI5PJSE
         lLbpz8VgaNChw==
X-Nifty-SrcIP: [209.85.217.54]
Received: by mail-vs1-f54.google.com with SMTP id f22so3545080vso.7;
        Tue, 26 Mar 2019 02:52:55 -0700 (PDT)
X-Gm-Message-State: APjAAAVBOjMn0zv4pMYaMNZRLG+Pg7/c4mTO/V4tdg49PfBITkD2+U/U
        juFkY+mfFxRaAW6pDQx75ZLJafZiuVg7Re7MJng=
X-Google-Smtp-Source: APXvYqxCFkSOcsL/OLLWKAVqkTGAqwBhN3d41k2YdWK+pRBBHOqPfePC49qHbkEHEjQYuhmXK4EmdP7VovAQjl4YaYg=
X-Received: by 2002:a67:7c04:: with SMTP id x4mr18180939vsc.155.1553593974610;
 Tue, 26 Mar 2019 02:52:54 -0700 (PDT)
MIME-Version: 1.0
References: <1550217319-40418-1-git-send-email-wen.yang99@zte.com.cn>
 <CAK7LNASzd=bL1H34w-E_UD9x6w2=ObyS+EPDZ_jrvfV+ncw-yA@mail.gmail.com>
 <1691b160-5558-d4c3-afed-5773e115c5aa@web.de> <CAK7LNASVRbroW9_j1Kda3azHb6PzD3WyVAsKe0HfD1ri0RFPOQ@mail.gmail.com>
 <e2798cd9-1366-63a4-8638-037dc8a36618@web.de>
In-Reply-To: <e2798cd9-1366-63a4-8638-037dc8a36618@web.de>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Tue, 26 Mar 2019 18:52:18 +0900
X-Gmail-Original-Message-ID: <CAK7LNATjAsiSeZoTZ57zBHse0j5ZYY_12ZQ0gaF_oCziUWheOQ@mail.gmail.com>
Message-ID: <CAK7LNATjAsiSeZoTZ57zBHse0j5ZYY_12ZQ0gaF_oCziUWheOQ@mail.gmail.com>
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

On Tue, Mar 26, 2019 at 6:06 PM Markus Elfring <Markus.Elfring@web.de> wrote:
>
> > When I searched "Wen Yang", v6 did not show up for some reasons.
> > https://lore.kernel.org/patchwork/project/lkml/list/?series=&submitter=22638&state=*&q=&archive=&delegate=
>
> I find such a situation also interesting somehow.
> I assume that there was another temporary technical difficulty involved
> with the Linux mailing list (and related information systems).


I think v6 fell into a crack somehow.


Check the LKML archive:
https://lkml.org/lkml/2019/2/16


I see your reply:

Re: [v6] coccinelle: semantic code search for missing put_device()Markus Elfring


But, I cannot find the v6 patch itself.



>
> > So, I just thought v5 was the latest one
> > and I was completely missing the context.
>
> Did any messages for the sixth (and seventh) script version reach you?
>
> https://lore.kernel.org/cocci/201902191014156680299@zte.com.cn/


I use both my corporate email address and Gmail,
and play it by ear.


I see it in my corporate mail box now.
It reached me probably because I subscribe to cocci@systeme.lip6.fr
with my socionext email address.

However, this time I only checked my Gmail box,
which subscribes to linux-kernel ML, but not cocci ML.

I just skimmed over the thread, then
I missed the fact you were giving some comments about v6.



> https://lore.kernel.org/lkml/1553321671-27749-1-git-send-email-wen.yang99@zte.com.cn/


Yes. I see this one.

I will apply it to fixes branch
if nobody sees a problem in it.


>
> Regards,
> Markus



-- 
Best Regards
Masahiro Yamada
