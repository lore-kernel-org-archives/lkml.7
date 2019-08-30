Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF7DFC3A5A4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 08:07:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CC9621897
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 08:07:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="n0aPpAgu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mzkzZvd0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728395AbfH3IHO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 04:07:14 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:51249 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727242AbfH3IHO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 04:07:14 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id D576521F85;
        Fri, 30 Aug 2019 04:07:13 -0400 (EDT)
Received: from imap2 ([10.202.2.52])
  by compute4.internal (MEProxy); Fri, 30 Aug 2019 04:07:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type; s=fm3; bh=mo3FGA/ipO1SkoDh6reUgvlvk0/ODyc
        GbN5cHOI6jnw=; b=n0aPpAguaYco15CyvLywybHNtVAc7mwuO0pzWP7wvOL4Fmd
        OHnEHaQlsdNU43xwYceWhMfk0QCz/vRpljxyPR10myZhHJVk1Gr7/KPCeBw5+CB4
        rsIfQB2bGMlSGIbOzvzO7vyDNrcKKDaPmgLmiH7MG+t/IxiusWysKBHZ029vMFcN
        S0Krms1cHcWwhachZ/SpXZzfkmlkZF79rP4Qr8E27Q3n/Z1j98vaCGU6p79BPDR9
        YW4gOcuI7qdImGvS8MxiEbUtER2pPj407Y70L9vm7zalsX0X89TSMuUzW3duN31X
        Xfw1iYF40TOZLCIUFXCq+eaK5gC5HLZOeg/97eQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=mo3FGA
        /ipO1SkoDh6reUgvlvk0/ODycGbN5cHOI6jnw=; b=mzkzZvd0ilqrs1ghrHg095
        4/hgqzJqavdRgmvLYcfAaOMtjE21M6bmrY8A/BqbnnO7QQL9hvuA5TecsbcOfe/V
        YZKBAdep8xDUafpohYs2i9/D5XRepasXcqyTCbd0K/eAQLBxjxzkIJknsY7GW5O2
        0N0mDb965foTBJlGEkAl+iOuj2rCcHh8y6StPCCCHky2JP0vrae2plX8QDxSElVz
        253LLLn8I4cVWNb2iXN6ynFFrVDF6I6sfTLAMjVhM+qft/OTohxwxCer6uRxOygk
        UOdiBZIc+QqdHxumWzsNMRE1Fu2ZFSPpZEpAo+kxlAOkC/Jp0kLg1ofv9vb4XplQ
        ==
X-ME-Sender: <xms:MNloXTYaESaR0JSN118H7OZG185uey1gsSKEmiVHTMutfzqTQg_J9A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrudeifedguddvhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvufgtsehttdertderreejnecuhfhrohhmpedftehn
    ughrvgifucflvghffhgvrhihfdcuoegrnhgurhgvfiesrghjrdhiugdrrghuqeenucfrrg
    hrrghmpehmrghilhhfrhhomheprghnughrvgifsegrjhdrihgurdgruhenucevlhhushht
    vghrufhiiigvpedt
X-ME-Proxy: <xmx:MNloXT-po1mRFzcl375CIW70RgDLvtoMWD7LT-XdpGLI1cV0WAUcCw>
    <xmx:MNloXcSQnVT8SQGscGN27QMrZG3RRnEyPrYhFmMEP1bc10tTn7cExg>
    <xmx:MNloXVf0fHcgZhm7rUT-VcyoCr5kRV23qDXo6iioTUw0zOrr7TyHAw>
    <xmx:MdloXXgLtRc6wEEsmbh66N09Tq0Y2R7LAtKNg-C-z3TQJ0m21n2U6A>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id B2443E00A3; Fri, 30 Aug 2019 04:07:12 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.1.7-154-gfa7592a-fmstable-20190829v1
Mime-Version: 1.0
Message-Id: <6feca359-34ce-445e-87bf-62fa063d785f@www.fastmail.com>
In-Reply-To: <CAPDyKFrKXfB1F2dh63KrkCiKGbmbBWaAM16vJqtQncnF4YctQw@mail.gmail.com>
References: <20190830074644.10936-1-andrew@aj.id.au>
 <20190830074644.10936-2-andrew@aj.id.au>
 <CAPDyKFrKXfB1F2dh63KrkCiKGbmbBWaAM16vJqtQncnF4YctQw@mail.gmail.com>
Date:   Fri, 30 Aug 2019 17:37:34 +0930
From:   "Andrew Jeffery" <andrew@aj.id.au>
To:     "Ulf Hansson" <ulf.hansson@linaro.org>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>,
        "Adrian Hunter" <adrian.hunter@intel.com>,
        "Joel Stanley" <joel@jms.id.au>,
        "Ryan Chen" <ryanchen.aspeed@gmail.com>, openbmc@lists.ozlabs.org,
        "Linux ARM" <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?Q?Re:_[PATCH_1/2]_mmc:_sdhci-of-aspeed:_Uphold_clocks-on_post-co?=
 =?UTF-8?Q?ndition_of_set=5Fclock()?=
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 30 Aug 2019, at 17:31, Ulf Hansson wrote:
> On Fri, 30 Aug 2019 at 09:46, Andrew Jeffery <andrew@aj.id.au> wrote:
> >
> > The early-exit didn't seem to matter on the AST2500, but on the AST2600
> > the SD clock genuinely may not be running on entry to
> > aspeed_sdhci_set_clock(). Remove the early exit to ensure we always run
> > sdhci_enable_clk().
> >
> > Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> > ---
> >  drivers/mmc/host/sdhci-of-aspeed.c | 3 ---
> >  1 file changed, 3 deletions(-)
> >
> > diff --git a/drivers/mmc/host/sdhci-of-aspeed.c b/drivers/mmc/host/sdhci-of-aspeed.c
> > index d5acb5afc50f..a9175ca85696 100644
> > --- a/drivers/mmc/host/sdhci-of-aspeed.c
> > +++ b/drivers/mmc/host/sdhci-of-aspeed.c
> > @@ -55,9 +55,6 @@ static void aspeed_sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
> >         int div;
> >         u16 clk;
> >
> > -       if (clock == host->clock)
> > -               return;
> > -
> >         sdhci_writew(host, 0, SDHCI_CLOCK_CONTROL);
> >
> >         if (clock == 0)
> > --
> > 2.20.1
> >
> 
> Further down in aspeed_sdhci_set_clock() you should probably also
> remove the assignment of host->clock = clock, as that is already
> managed by sdhci_set_ios().

Ah, I'll fix that in a v2 once I have your thoughts on patch 2/2.

Thanks for the lightning quick feedback!

Andrew
