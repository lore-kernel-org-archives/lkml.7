Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D37EBC19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 05:45:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9E7C2089E
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 05:45:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="c3dr1lWk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JsKzzgmp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728854AbfHAFpY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 01:45:24 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:35431 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726157AbfHAFpY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 01:45:24 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id A69C0207E1;
        Thu,  1 Aug 2019 01:45:23 -0400 (EDT)
Received: from imap2 ([10.202.2.52])
  by compute4.internal (MEProxy); Thu, 01 Aug 2019 01:45:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type; s=fm3; bh=ikk9XWI/PaloHpfzYfJtJOTFwmWnC+0
        JCdYs26D7ubs=; b=c3dr1lWkMo5FSBT8lrLsCneT0ER9KaOWAen1lPJ/wlWkYD+
        F3Kmfml5a07j1yCb4s8Viy1CUWnpejg8CDu0KA5iTw0nSF3qC7NQqTV657E5hVap
        pSQR1Pf8Wgou7XoLYuZ4qudaorYvMy2xrptaEvXmVTht1kW1w+Mlojv60ywB12bb
        fG3Ty3Chl/dMWLtjwoB60usxxKlck9JuHYL/HAknm5ol2jNCRQ5QTYFofGMDSADH
        Ac94iEGVdzLwoG2YqlB6AaaGfl2OrzOspnvLtYBwBnn6hLF/M4ka+HvB4iDZ747J
        zM/CB4CEMMtecKqqIkfgoBojRQWHoJpIvIbgVzA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=ikk9XW
        I/PaloHpfzYfJtJOTFwmWnC+0JCdYs26D7ubs=; b=JsKzzgmpM0pAwDfOFWmIwy
        e/gkpP11y8xh4J5E+5Un3MJJvj6+kBcaPZP6NDENM20ed/dJYPGZFeLMRjC9jV9X
        Dqrzgn1S25oXgX+lx3hf9cO9axVEH4ivwRWfGifTyqdwomgpZaCAnnG4eYzh6scC
        WIpjXLemDL50BI5V42NeIsfdrFSHHHPKA0FMw9/q9JMWSnVRRIJDTq/vTUWsrFkc
        YV0dqm+NLi3r7DQRmDFYyBAl9XobaJM7ZdBMhEBMGsy7REetXwiVStDKkEooTKHq
        ChEcckQ+d2OGXGZEJoz//Q4vQqVL5ncl0+2LNP122XoQgPiLUHWgzSIMRn873jkw
        ==
X-ME-Sender: <xms:cnxCXZVcGZ-455p_bs-LgSCuUcxEUsQjAFwH5XFLyD8cPPPD-UFwCw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrleeigdeliecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvufgtsehttdertderredtnecuhfhrohhmpedftehnughr
    vgifucflvghffhgvrhihfdcuoegrnhgurhgvfiesrghjrdhiugdrrghuqeenucfrrghrrg
    hmpehmrghilhhfrhhomheprghnughrvgifsegrjhdrihgurdgruhenucevlhhushhtvghr
    ufhiiigvpedt
X-ME-Proxy: <xmx:cnxCXVQZ-SI3cyKIbEqkpWS00qvrgEQGxGZ91gMOKDy0EMzP2EVh8Q>
    <xmx:cnxCXQGaiX7f4V_3p0_o7VOwBTVPNBIzU41xNJjUBySxz-berHYqVQ>
    <xmx:cnxCXdS_CSb-UN8ZrY2Xcmzsmy8hJzu_ASfyRT9L9fSYSMOPNs8M3A>
    <xmx:c3xCXYeXDra6wsCCxx5QzKiSgLq2LCV_21ukNLHu4uHAyrtgDo0zLA>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 67318E00A1; Thu,  1 Aug 2019 01:45:22 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.1.6-799-g925e343-fmstable-20190729v1
Mime-Version: 1.0
Message-Id: <3691f6cb-2451-43f7-9f00-d5693071ba59@www.fastmail.com>
In-Reply-To: <9d0f2b20-e6f6-419c-a866-c4a0dd92aa63@www.fastmail.com>
References: <20190724081313.12934-1-andrew@aj.id.au>
 <CACRpkdapypySGPrLgSMSNy1fzkca2BfMUGzf3koFWQZ-M5VOvg@mail.gmail.com>
 <9d0f2b20-e6f6-419c-a866-c4a0dd92aa63@www.fastmail.com>
Date:   Thu, 01 Aug 2019 15:15:42 +0930
From:   "Andrew Jeffery" <andrew@aj.id.au>
To:     "Linus Walleij" <linus.walleij@linaro.org>
Cc:     linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        "Lee Jones" <lee.jones@linaro.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Mark Rutland" <mark.rutland@arm.com>,
        "Joel Stanley" <joel@jms.id.au>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "Linux ARM" <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Subject: Re: [PATCH 0/3] ARM: dts: aspeed: Deprecate g[45]-style compatibles
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 30 Jul 2019, at 10:27, Andrew Jeffery wrote:
> 
> 
> On Tue, 30 Jul 2019, at 07:23, Linus Walleij wrote:
> > On Wed, Jul 24, 2019 at 10:13 AM Andrew Jeffery <andrew@aj.id.au> wrote:
> > 
> > > It's probably best if we push the three patches all through one tree rather
> > > than fragmenting. Is everyone happy if Joel applies them to the aspeed tree?
> > 
> > If you are sure it will not collide with parallell work in the
> > pinctrl tree, yes.
> > Acked-by: Linus Walleij <linus.walleij@linaro.org>
> > 
> > (If it does collide I'd prefer to take the pinctrl patches and fix the
> > conflicts in my tree.)
> 
> Fair enough, I don't know the answer so I'll poke around. I don't 
> really mind
> where the series goes in, I just want to avoid landing only part of it 
> if I split it up.

Okay, it currently conflicts with my cleanup-devicetree-warnings series.

Joel, do you mind if Linus takes this series through the pinctrl tree, given
the fix to the devicetrees is patch 1/3?

Andrew
