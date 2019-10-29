Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34A62CA9EC1
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 03:01:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0975920862
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 03:01:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="CGuSk+Rr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731106AbfJ2C74 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 22:59:56 -0400
Received: from conssluserg-05.nifty.com ([210.131.2.90]:51495 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730875AbfJ2C7z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 22:59:55 -0400
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id x9T2xTqj016926;
        Tue, 29 Oct 2019 11:59:30 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com x9T2xTqj016926
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1572317970;
        bh=KpON6jENOa78faqVFtQXeF/x8eRnLcnMvYpsLe7gtRw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=CGuSk+RrGXsd6J11mq5ZrwjADHBaJZvsVn59C82fYYpR482hK2PyTRr81P3Kx7lUk
         UhJtVotXaOdjmzKK553POUJVvKly/FeFCFk+AoPDRM/hOLVEnzXe72QLrVrB4J8PTg
         YMxq21bXABz1tdXgNfVO4edowruo4yW2z0Oszld0MdolcE9ibT6vKR1ZKGLO445xw1
         7aW5GZMpMe2lyg0GtzmMadtdpJkQpudIAseGGjaJgzLGdTlshpKMLBSYrNEoC90V8d
         7lqPBFEmYLFFxdGU1bmUhQqfQ/DtY9VeZ0Kobq6nlng0hc4H7LwvezeL54tfE17KZH
         1GsgPOSFw0Pdg==
X-Nifty-SrcIP: [209.85.222.54]
Received: by mail-ua1-f54.google.com with SMTP id q16so3381236uao.1;
        Mon, 28 Oct 2019 19:59:29 -0700 (PDT)
X-Gm-Message-State: APjAAAXqj9GGjXPkP2nJ5xGyO6JBP+d2x+NMacLtSq8MJLe/9Wzs9HNv
        +WXRFiOc4J37wKhQLkmhvOwQKXHav7/YuVHAaAc=
X-Google-Smtp-Source: APXvYqwlJlglJ2Tv5HFU5kMK6Futpi8Woza9I04Q0G6tTL+3kQyGTP068uTVZlTQ4bTSvxrQbrx/KcHFxtxvU5bkaNk=
X-Received: by 2002:ab0:658d:: with SMTP id v13mr3781878uam.40.1572317968542;
 Mon, 28 Oct 2019 19:59:28 -0700 (PDT)
MIME-Version: 1.0
References: <e895d04ef5a282b5b48fcb21cbc175d2@www.loen.fr> <693a3b68-a0f1-81fe-40ce-2b6ba189450c@web.de>
 <868spgzcti.wl-maz@kernel.org> <c8816d85b696cb96318e17b7010b84f09bc67bf7.camel@perches.com>
 <CAK7LNAQqSThGRM_wRGR2ou3B+Oqpr0nF9Fg4rhSR4Hvnxwnj3g@mail.gmail.com>
 <20191025080843.GG32742@smile.fi.intel.com> <alpine.DEB.2.21.1910251028260.2787@hadrien>
In-Reply-To: <alpine.DEB.2.21.1910251028260.2787@hadrien>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Tue, 29 Oct 2019 11:58:52 +0900
X-Gmail-Original-Message-ID: <CAK7LNATkXYNMbquhn=SV=Hj1kqbPke8x4_a7aZYhceRAam8MHQ@mail.gmail.com>
Message-ID: <CAK7LNATkXYNMbquhn=SV=Hj1kqbPke8x4_a7aZYhceRAam8MHQ@mail.gmail.com>
Subject: Re: coccinelle: api/devm_platform_ioremap_resource: remove useless script
To:     Julia Lawall <julia.lawall@lip6.fr>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Joe Perches <joe@perches.com>, Marc Zyngier <maz@kernel.org>,
        Markus Elfring <Markus.Elfring@web.de>,
        Himanshu Jha <himanshujha199640@gmail.com>,
        kernel-janitors@vger.kernel.org,
        Coccinelle <cocci@systeme.lip6.fr>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Thomas Gleixner <tglx@linutronix.de>,
        YueHaibing <yuehaibing@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Julia

On Fri, Oct 25, 2019 at 5:38 PM Julia Lawall <julia.lawall@lip6.fr> wrote:
>
>
>
> On Fri, 25 Oct 2019, Andy Shevchenko wrote:
>
> > On Fri, Oct 25, 2019 at 12:40:52AM +0900, Masahiro Yamada wrote:
> > > On Sun, Oct 20, 2019 at 7:13 AM Joe Perches <joe@perches.com> wrote:
> > > > On Sat, 2019-10-19 at 21:43 +0100, Marc Zyngier wrote:
> >
> > > Alexandre Belloni used
> > > https://lore.kernel.org/lkml/9bbcce19c777583815c92ce3c2ff2586@www.loen.fr/
> > > as a reference, but this is not the output from coccicheck.
> > > The patch author just created a wrong patch by hand.
> >
> > Exactly. Removal of the script is a mistake. Like I said before is a healing
> > (incorrect by the way!) by symptoms.
> >
> > > The deleted semantic patch supports MODE=patch,
> > > which creates a correct patch, and is useful.
> >
> > Right!
>
> I ran it on the version of Linux that still has the script:
>
> fe7d2c23d748e4206f4bef9330d0dff9abed7411
>
> and managed to compile 341 of the generated files in the time I had
> available, and all compiled successfully.

Yeah, this semantic patch did the correct conversion
as its header part showed the confidence.

// Confidence: High



>  I can let it run again, and see
> how it goes for the rest.  Perhaps it would be acceptable if there was no
> report, and people would be forced to use the generated patch?

I do not think this is the right thing.
MODE=report is the default, and it is fine.

>
> If someone is writing lots of patches on this issue by hand, then perhaps
> they don't have make coccicheck to produce patches, and then would
> overlook this case completely.
>
> If it would be helpful, I could group the generated patches by maintainer
> or by subdirectory and send them out, if it would be easier to review them
> all at once.

Yes, please.

Subsystem maintainers trust you,
so I think it will make things move smoothly.

After converting most of files,
I want 283ea345934d277e30c841c577e0e2142b4bfcae reverted.


>
> Anyway, the rule is not in the kernel at the moment.  For it's future, I'm
> open to whatever people find best.  Personally, I prefer when same things
> are done in the same way - it makes the code easier to understand and
> makes it simpler to address other issues when they arise.


We always did the same things in the same way
except commit 283ea345934d277e30c841c577e0e2142b4bfcae




-- 
Best Regards
Masahiro Yamada
