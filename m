Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,TRACKER_ID,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C679CCA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 08:38:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CF2821D7F
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 08:38:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407211AbfJYIiH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 04:38:07 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:37354 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2404179AbfJYIiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 04:38:07 -0400
X-IronPort-AV: E=Sophos;i="5.68,228,1569276000"; 
   d="scan'208";a="408140288"
Received: from ip-121.net-89-2-166.rev.numericable.fr (HELO hadrien) ([89.2.166.121])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Oct 2019 10:38:00 +0200
Date:   Fri, 25 Oct 2019 10:38:00 +0200 (CEST)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Joe Perches <joe@perches.com>, Marc Zyngier <maz@kernel.org>,
        Markus Elfring <Markus.Elfring@web.de>,
        Himanshu Jha <himanshujha199640@gmail.com>,
        Julia Lawall <julia.lawall@lip6.fr>,
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
Subject: Re: coccinelle: api/devm_platform_ioremap_resource: remove useless
 script
In-Reply-To: <20191025080843.GG32742@smile.fi.intel.com>
Message-ID: <alpine.DEB.2.21.1910251028260.2787@hadrien>
References: <e895d04ef5a282b5b48fcb21cbc175d2@www.loen.fr> <693a3b68-a0f1-81fe-40ce-2b6ba189450c@web.de> <868spgzcti.wl-maz@kernel.org> <c8816d85b696cb96318e17b7010b84f09bc67bf7.camel@perches.com> <CAK7LNAQqSThGRM_wRGR2ou3B+Oqpr0nF9Fg4rhSR4Hvnxwnj3g@mail.gmail.com>
 <20191025080843.GG32742@smile.fi.intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 25 Oct 2019, Andy Shevchenko wrote:

> On Fri, Oct 25, 2019 at 12:40:52AM +0900, Masahiro Yamada wrote:
> > On Sun, Oct 20, 2019 at 7:13 AM Joe Perches <joe@perches.com> wrote:
> > > On Sat, 2019-10-19 at 21:43 +0100, Marc Zyngier wrote:
>
> > Alexandre Belloni used
> > https://lore.kernel.org/lkml/9bbcce19c777583815c92ce3c2ff2586@www.loen.fr/
> > as a reference, but this is not the output from coccicheck.
> > The patch author just created a wrong patch by hand.
>
> Exactly. Removal of the script is a mistake. Like I said before is a healing
> (incorrect by the way!) by symptoms.
>
> > The deleted semantic patch supports MODE=patch,
> > which creates a correct patch, and is useful.
>
> Right!

I ran it on the version of Linux that still has the script:

fe7d2c23d748e4206f4bef9330d0dff9abed7411

and managed to compile 341 of the generated files in the time I had
available, and all compiled successfully.  I can let it run again, and see
how it goes for the rest.  Perhaps it would be acceptable if there was no
report, and people would be forced to use the generated patch?

If someone is writing lots of patches on this issue by hand, then perhaps
they don't have make coccicheck to produce patches, and then would
overlook this case completely.

If it would be helpful, I could group the generated patches by maintainer
or by subdirectory and send them out, if it would be easier to review them
all at once.

Anyway, the rule is not in the kernel at the moment.  For it's future, I'm
open to whatever people find best.  Personally, I prefer when same things
are done in the same way - it makes the code easier to understand and
makes it simpler to address other issues when they arise.

julia
