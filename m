Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CE67C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 18:33:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2324F2082C
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 18:33:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="XQL7xlmb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730792AbfC3SdO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Mar 2019 14:33:14 -0400
Received: from mail.andi.de1.cc ([85.214.239.24]:58928 "EHLO
        h2641619.stratoserver.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730542AbfC3SdN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Mar 2019 14:33:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=CoFePdD/oTHA0QTafImHUqZqC4nAQwaPcHCVCwE/0oc=; b=XQL7xlmbJ1V+xIOu9DE1e1xAGQ
        0NnxPuNkZEncnJpAjOKPzNnYAm7yVbO4R57H4vVwExi2Afk3r8XQyEQ6c+a/BHuLY0luCsUva0Tn1
        zFYjILnypvL8kNUO7jLQ2uVM+jW9b5LUpaZq6JWQkO64rcbIkgXdQT7cvSbWGLjq0jVU=;
Received: from pd9e2fa37.dip0.t-ipconnect.de ([217.226.250.55] helo=aktux)
        by h2641619.stratoserver.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1hAImw-0003Gg-Uw; Sat, 30 Mar 2019 19:33:07 +0100
Date:   Sat, 30 Mar 2019 19:33:06 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     Discussions about the Letux Kernel <letux-kernel@openphoenux.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        devicetree <devicetree@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Jan Kotas <jank@cadence.com>,
        kernel@pyra-handheld.com
Subject: Re: [Letux-kernel] [BUG] gpiolib: spi chip select legacy support
 breaks modern chip select and whitens the GTA04 LCD panel
Message-ID: <20190330193259.5054655e@aktux>
In-Reply-To: <2286C331-4AFC-46A9-B8C4-8A8BA9CD33C2@goldelico.com>
References: <7509BFB6-36E4-441A-9F16-7A4FEE7F7CF3@goldelico.com>
        <5488EF42-08DB-4273-95FF-49ED31E27472@goldelico.com>
        <CACRpkdb4URKcdZ-=3aG_np86Bp=1ahs+qztM-7yQkSP18ZkE6A@mail.gmail.com>
        <2286C331-4AFC-46A9-B8C4-8A8BA9CD33C2@goldelico.com>
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 24 Mar 2019 07:56:17 +0100
"H. Nikolaus Schaller" <hns@goldelico.com> wrote:

> Hi Linus,
> 
> > Am 24.03.2019 um 05:15 schrieb Linus Walleij <linus.walleij@linaro.org>:
> > 
> > On Sat, Mar 23, 2019 at 3:40 PM H. Nikolaus Schaller <hns@goldelico.com> wrote:
> >   
> >> (1) c1c04cea13dc gpio: of: Fix logic inversion
> >> 
> >> together with the basic patch
> >> 
> >> (2) 6953c57ab172 gpio: of: Handle SPI chipselect legacy bindings
> >> 
> >> leads to a severe regression for our GTA04 board.  
> > 
> > Sorry! :(
> > 
> > I found the same problem on my Nomadik board.
> > 
> > But I fixed it in that case by introducing a spi-cs-high into the DTS file:
> > https://marc.info/?l=linux-arm-kernel&m=155292310015309&w=2  
> 
> Yes, that of course works and is our temporary solution.
> 
> And I see that you also have it on the controller node and not the slave node.
> 
So if I get it right is a check added for undocumented properties
(nothing about  spi-cs-high  in controller node in the bindings
documentation, only in the slave node) in the two patches mentioned.

And then you add that undocumented property to a dts file in your "fix".

That all sounds strange to me.

> >   
> >> I learned that it tries to handle a legacy "spi-cs-high" property of SPI slaves, but was stopped
> >> from doing so by a bug (1). So only with both patches, the legacy handler becomes active which
> >> explains why it was not noticed earlier.
> >> 
> >> Now, our GTA04 device tree from 2014 (v3.16-rc1) was already written without any legacy spi properties
> >> in mind  
> > 
> > I'm sorry about that, however if you look at the DT binding document:
> > Documentation/devicetree/bindings/spi/spi-bus.txt  
> 
> Shouldn't it be a property of the slave node and not the controller node?
> 
> > 
> > You will see that spi-cs-high is mandatory. So these DTS files are
> > incorrect.  
> 
> How do you read that it is mandatory from
> 
> "All slave nodes can contain the following optional properties:
> - spi-cs-high     - Empty property indicating device requires chip select
> 		    active high."
> 
> I read it as optional and indicative. Equal priority to cs-gpios.
> 
Well, it is in the list of optional properties. So the question is how
that "optional" is interpreted. Is it optional because you only use it
if cs is active high or is it optional because you can either indicate
that fact here or via gpio definition.

But again that flags makes no sense in the controller node.

Regards,
Andreas
