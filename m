Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9A9AC10F14
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 03:29:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B83A2171F
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 03:29:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="RlAqRCrr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727234AbfDSD3I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 23:29:08 -0400
Received: from conssluserg-06.nifty.com ([210.131.2.91]:29216 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727149AbfDSD3I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 23:29:08 -0400
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id x3J3SutT023095
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2019 12:28:57 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com x3J3SutT023095
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1555644537;
        bh=xhhcWRdOrfUUHu7jrTassp00L06rdQMjbGj6+f2wt/w=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=RlAqRCrrGcFzEcn+4Y7ofB1iZhau4i2M50Jd73C16VbymNv+LikzanYRxR7SCg5R5
         W84IzfolWuhgZjk+24DFHxjs2hv88Ejh1V0zc9QE/zF5+EeE5ECG/evJtmswhjzC9V
         CSilGtFoogeIEUfZp2ARqlUhbwj1H/V3xpiDONZEanedxD6biKMTbv6GKRpdphaCRx
         wVX/apPGEBtK217o2stenTLr040V+gIdrWCSEOUziVBKXdk5iH8B9m/T53SCRPHSXN
         pt25VyWeZVakOHSqv9oG18p9azBxPZxfVnfOmr2ofOr8PIRrQuUa8Y7P8EwyM4e+Wu
         ne20Lj+7BGk5Q==
X-Nifty-SrcIP: [209.85.217.53]
Received: by mail-vs1-f53.google.com with SMTP id n4so2280584vsm.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2019 20:28:56 -0700 (PDT)
X-Gm-Message-State: APjAAAWwHUCFYGfBIWKgYDUMLS5yRCD6D1gPLl/Lk161sB86kGIUjdPP
        5Q3b5lOFREhEas9egZYdTmftmyMtl+lqN3YrPAI=
X-Google-Smtp-Source: APXvYqxE7/U5rOnSsQ6GM8ISHYVjwTl39E98m9iAVcQRXUgkmYjDM+Guc3ra2wSjZaVYhKdK/stl9sh35SXZ9VuF908=
X-Received: by 2002:a67:74cd:: with SMTP id p196mr809691vsc.215.1555644535983;
 Thu, 18 Apr 2019 20:28:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190323015227.245455-1-dianders@chromium.org>
 <CAK7LNARYMy2=viA1et9tZk409M=OSteD5D675oAKQEs6SG77HQ@mail.gmail.com>
 <20190416163034.3e642818ebf27ed6891c1981@linux-foundation.org>
 <CAK7LNAR4Ty8835sfo4HSvBsMCsV65mY2HOajFSY2TOYurmkFdw@mail.gmail.com> <20190418160651.40cb6a11186a6c6028e9d20d@linux-foundation.org>
In-Reply-To: <20190418160651.40cb6a11186a6c6028e9d20d@linux-foundation.org>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Fri, 19 Apr 2019 12:28:20 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQe2uaVfKee1F6R4siVvUSCMgSaYAnUQfz8MS5PeFqpGA@mail.gmail.com>
Message-ID: <CAK7LNAQe2uaVfKee1F6R4siVvUSCMgSaYAnUQfz8MS5PeFqpGA@mail.gmail.com>
Subject: Re: [PATCH] kdb: Get rid of broken attempt to print CCVERSION in kdb summary
To:     Joe Perches <joe@perches.com>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        kgdb-bugreport@lists.sourceforge.net,
        Johannes Weiner <hannes@cmpxchg.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Nicholas Mc Guire <hofrat@osadl.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joe,

Can you detect redundant Cc: by checkpatch?

Please see below in details.
Thanks.


On Fri, Apr 19, 2019 at 8:07 AM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Wed, 17 Apr 2019 15:37:49 +0900 Masahiro Yamada <yamada.masahiro@socionext.com> wrote:
>
> > > It's pretty benign: Doug will still only get a single email.
> > >
> > >
> > > checkpatch checks for duplicates cc's but I think it assumes that
> > > things like
> > >
> > > Reported-by: fred
> > > Tested-by: fred
> > >
> > > were intentional.
> > >
> > > It would perhaps be better for checkpatch to special-case the "Cc:
> > > fred" tag and report a duplicated Cc: if fred was also mentioned in any
> > > other tag.
> >
> > Sorry, I do not understand what you mean.
> >
> >
> > Douglas did not add any Cc: tag at all
> > in his original patch:
> > https://lore.kernel.org/patchwork/patch/1053953/
> >
> >
> > It's you who added the Cc: tags
> > (and I am guessing you did it by scripting.)
> >
> > Why is this topic related to checkpatch?
>
> Because I regularly check all patches with checkpatch but checkpatch
> failed to detect that I had
>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ...
> Cc: Douglas Anderson <dianders@chromium.org>
>
> and I believe that checkpatch could and should have warned about this
> situation.
>


-- 
Best Regards
Masahiro Yamada
