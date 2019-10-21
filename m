Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D164CA9EB0
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 11:44:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A57D20656
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 11:44:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728574AbfJULom (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 07:44:42 -0400
Received: from shell.v3.sk ([90.176.6.54]:32918 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728510AbfJULok (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 07:44:40 -0400
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id D288C508B6;
        Mon, 21 Oct 2019 13:44:34 +0200 (CEST)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 0BsA60h9gCPB; Mon, 21 Oct 2019 13:44:27 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id D974C508B7;
        Mon, 21 Oct 2019 13:44:26 +0200 (CEST)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id LzrHZ0-7O3AT; Mon, 21 Oct 2019 13:44:25 +0200 (CEST)
Received: from belphegor (nat-pool-brq-t.redhat.com [213.175.37.10])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 83982508B6;
        Mon, 21 Oct 2019 13:44:25 +0200 (CEST)
Message-ID: <e5e7695cc82b4370752f45082be007dbe410c74c.camel@v3.sk>
Subject: Re: [PATCH v2 0/9] Simplify MFD Core
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Arnd Bergmann <arnd@arndb.de>, Lee Jones <lee.jones@linaro.org>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Barry Song <baohua@kernel.org>, stephan@gerhold.net,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Daniel Drake <drake@endlessm.com>,
        James Cameron <quozl@laptop.org>
Date:   Mon, 21 Oct 2019 13:44:24 +0200
In-Reply-To: <CAK8P3a10w9Xg6U8EgUqPLbucP3A0wc9xO_WNG06LxHrsZkZc1g@mail.gmail.com>
References: <20191021105822.20271-1-lee.jones@linaro.org>
         <CAK8P3a10w9Xg6U8EgUqPLbucP3A0wc9xO_WNG06LxHrsZkZc1g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.1 (3.34.1-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-10-21 at 13:29 +0200, Arnd Bergmann wrote:
> On Mon, Oct 21, 2019 at 12:58 PM Lee Jones <lee.jones@linaro.org> wrote:
> > MFD currently has one over-complicated user.  CS5535 uses a mixture of
> > cell cloning, reference counting and subsystem-level call-backs to
> > achieve its goal of requesting an IO memory region only once across 3
> > consumers.  The same can be achieved by handling the region centrally
> > during the parent device's .probe() sequence.  Releasing can be handed
> > in a similar way during .remove().
> > 
> > While we're here, take the opportunity to provide some clean-ups and
> > error checking to issues noticed along the way.
> > 
> > This also paves the way for clean cell disabling via Device Tree being
> > discussed at [0]
> > 
> > [0] https://lkml.org/lkml/2019/10/18/612.
> 
> As the CS5535 is primarily used on the OLPC XO1, it would be
> good to have someone test the series on such a machine.
> 
> I've added a few people to Cc that may be able to help test it, or
> know someone who can.
> 
> For the actual patches, see
> https://lore.kernel.org/lkml/20191021105822.20271-1-lee.jones@linaro.org/T/#t

Thanks for the pointer. I'd by happy to test this.

Which tree do the patches apply to?
Or, better, is there a tree with the patches applied that I could use?

Thanks
Lubo

> 
>     Arnd
> 
> > Lee Jones (9):
> >   mfd: cs5535-mfd: Use PLATFORM_DEVID_* defines and tidy error message
> >   mfd: cs5535-mfd: Remove mfd_cell->id hack
> >   mfd: cs5535-mfd: Request shared IO regions centrally
> >   mfd: cs5535-mfd: Register clients using their own dedicated MFD cell
> >     entries
> >   mfd: mfd-core: Remove mfd_clone_cell()
> >   x86: olpc: Remove invocation of MFD's .enable()/.disable() call-backs
> >   mfd: mfd-core: Protect against NULL call-back function pointer
> >   mfd: mfd-core: Remove usage counting for .{en,dis}able() call-backs
> >   mfd: mfd-core: Move pdev->mfd_cell creation back into mfd_add_device()
> > 
> >  arch/x86/platform/olpc/olpc-xo1-pm.c |   6 --
> >  drivers/mfd/cs5535-mfd.c             | 124 +++++++++++++--------------
> >  drivers/mfd/mfd-core.c               | 113 ++++--------------------
> >  include/linux/mfd/core.h             |  20 -----
> >  4 files changed, 79 insertions(+), 184 deletions(-)
> > 
> > --
> > 2.17.1
> > 
> > 
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

