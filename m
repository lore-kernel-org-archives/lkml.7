Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17AA4CA9ECF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 15:01:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB5D321734
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 15:01:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728021AbfKAPBq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 11:01:46 -0400
Received: from shell.v3.sk ([90.176.6.54]:53018 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727365AbfKAPBp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 11:01:45 -0400
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id E7C2C400B5;
        Fri,  1 Nov 2019 16:01:40 +0100 (CET)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 4EMX4ZocWg0t; Fri,  1 Nov 2019 16:01:35 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id B7EB4400BD;
        Fri,  1 Nov 2019 16:01:34 +0100 (CET)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id GPjCwwEgtuTK; Fri,  1 Nov 2019 16:01:34 +0100 (CET)
Received: from belphegor (nat-pool-brq-t.redhat.com [213.175.37.10])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 91BAE400B5;
        Fri,  1 Nov 2019 16:01:33 +0100 (CET)
Message-ID: <a57dec8fca7b42d6a4f4fb29cb4b9f87435fca74.camel@v3.sk>
Subject: Re: [PATCH v2 0/9] Simplify MFD Core
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Barry Song <baohua@kernel.org>, stephan@gerhold.net,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Daniel Drake <drake@endlessm.com>,
        James Cameron <quozl@laptop.org>
Date:   Fri, 01 Nov 2019 16:01:32 +0100
In-Reply-To: <20191101090751.GH5700@dell>
References: <20191021105822.20271-1-lee.jones@linaro.org>
         <CAK8P3a10w9Xg6U8EgUqPLbucP3A0wc9xO_WNG06LxHrsZkZc1g@mail.gmail.com>
         <e5e7695cc82b4370752f45082be007dbe410c74c.camel@v3.sk>
         <20191021115339.GF4365@dell>
         <ba31d7cb894cb44eacee630e56fae647922f3dc2.camel@v3.sk>
         <20191101090751.GH5700@dell>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.1 (3.34.1-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-11-01 at 09:07 +0000, Lee Jones wrote:
> On Mon, 21 Oct 2019, Lubomir Rintel wrote:
> > On Mon, 2019-10-21 at 12:53 +0100, Lee Jones wrote:
> > > On Mon, 21 Oct 2019, Lubomir Rintel wrote:
> > > 
> > > > On Mon, 2019-10-21 at 13:29 +0200, Arnd Bergmann wrote:
> > > > > On Mon, Oct 21, 2019 at 12:58 PM Lee Jones <lee.jones@linaro.org> wrote:
> > > > > > MFD currently has one over-complicated user.  CS5535 uses a mixture of
> > > > > > cell cloning, reference counting and subsystem-level call-backs to
> > > > > > achieve its goal of requesting an IO memory region only once across 3
> > > > > > consumers.  The same can be achieved by handling the region centrally
> > > > > > during the parent device's .probe() sequence.  Releasing can be handed
> > > > > > in a similar way during .remove().
> > > > > > 
> > > > > > While we're here, take the opportunity to provide some clean-ups and
> > > > > > error checking to issues noticed along the way.
> > > > > > 
> > > > > > This also paves the way for clean cell disabling via Device Tree being
> > > > > > discussed at [0]
> > > > > > 
> > > > > > [0] https://lkml.org/lkml/2019/10/18/612.
> > > > > 
> > > > > As the CS5535 is primarily used on the OLPC XO1, it would be
> > > > > good to have someone test the series on such a machine.
> > > > > 
> > > > > I've added a few people to Cc that may be able to help test it, or
> > > > > know someone who can.
> > > > > 
> > > > > For the actual patches, see
> > > > > https://lore.kernel.org/lkml/20191021105822.20271-1-lee.jones@linaro.org/T/#t
> > > > 
> > > > Thanks for the pointer. I'd by happy to test this.
> > > > 
> > > > Which tree do the patches apply to?
> > > > Or, better, is there a tree with the patches applied that I could use?
> > > 
> > > Ideal.  Thank you.
> > > 
> > > http://git.linaro.org/people/lee.jones/linux.git/log/?h=topic/mfd-remove-clone-cs5535-mfd
> > 
> > Thanks. My boot attempt ends up in a panic [1]:
> 
> New patches have been drafted, reviewed and pushed to the same branch.
> 
> Would you be kind enough to boot test them for me please Lubo?

The branch

Tested-by: Lubomir Rintel <lkundrak@v3.sk> (OLPC XO-1)

Here's a dmesg and partial sysfs listing indicating that the driver
indeed bound correctly: https://paste.centos.org/view/3aa89258

> 
> TIA.

Take care
Lubo

