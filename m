Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4845C2D0C0
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 05:04:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADE3724648
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 05:04:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="JifFXqXD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="J5C25oVY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725959AbfLEFEc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 00:04:32 -0500
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:51061 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725822AbfLEFEc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 00:04:32 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id C47EA6DB2;
        Thu,  5 Dec 2019 00:04:30 -0500 (EST)
Received: from imap2 ([10.202.2.52])
  by compute4.internal (MEProxy); Thu, 05 Dec 2019 00:04:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type; s=fm1; bh=EbdPnIUWiOwQ643br872/JZSTvD7a10
        RSKBmMulJSN8=; b=JifFXqXDmEe7Mvb1z3kyfynBxgaVc1qNJQasvCg1ibFlCOy
        VE7jmuIowcEXu3ZR/MojGGuHJt4fplfhdr+MOJ9sKG1TMirubBwYNmHskB118/x3
        7AFKTtSQOVPVUtTrOvhfjHrG6xFKmNpxjkQz33MzREsW1IRWkFrkW7aSn4wTUXjV
        19Z6BYa9OrxuzlHn+v3dbu7k0D2mgLUwwiMr7TewBsSKlQazVusvi7UCG2SY4lBK
        2+9z5L/6wSRriBHVburZ3BI4OXEU+W2hsi4FtqokaQF99FR4gwVGzldax0YRoxxD
        bMbMPZ91fU3ZPjAC3q6wmSO+f/2qmgk5BG19WzA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=EbdPnI
        UWiOwQ643br872/JZSTvD7a10RSKBmMulJSN8=; b=J5C25oVYL4Hrmcp/xn9EpQ
        Suiiuf+l37jl3j4UGAyk4y/IX0UqjmaaeFLw+mWvgl2dwvZD108oxUcMNmVtCZli
        4G2SRVqjWUuWHB+3fqsravRPfIjrvh+Dq13wQRBdCHAyaQhlzJXkFnM01uYeWz/9
        6/M/+zTbN/S3WpsWcrEJ34M5ATPjLMXxlkILwceIwzrym0pbDdkAQhFIFspMLEPI
        DDAsSGCQdVBEKngVbpncS1wKasq5QEKcF6qMUX70NSQRNjwGZkdSkOe1QBUT2LDj
        mGp3deJ8a0LboMnXCgt1EIal7nW0H2YIvyvZSF1MJytRbzKSjaHbXOK1DLwUOFTg
        ==
X-ME-Sender: <xms:3I_oXV4-n2xj8BTQ6IZdHWn4_HoQE0gb58DZXVp9DAFeo5cEODADPg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrudektddgjeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreerjeenucfhrhhomhepfdetnhgu
    rhgvficulfgvfhhfvghrhidfuceorghnughrvgifsegrjhdrihgurdgruheqnecurfgrrh
    grmhepmhgrihhlfhhrohhmpegrnhgurhgvfiesrghjrdhiugdrrghunecuvehluhhsthgv
    rhfuihiivgeptd
X-ME-Proxy: <xmx:3I_oXXL3ovWDg99Z4a_d3T4syyxV6SnZiclv0munN8sO7ez1w3by_Q>
    <xmx:3I_oXXe0drsxa0FcWgBtiEdXvXTtkDc4PQRt6RUyvMAcsV2rmyrxqg>
    <xmx:3I_oXSfKYBb7NbuitaJv2XGY46yQ4yPYWWyRI8hSb2mQohDCqu4eLA>
    <xmx:3o_oXVQr1kEaHUjP1AuwcUC_0MQAGlHW2-QA2434pVkhZKpJFKw4Rg>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 9CFE5E00A2; Thu,  5 Dec 2019 00:04:28 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.1.7-612-g13027cc-fmstable-20191203v1
Mime-Version: 1.0
Message-Id: <25487d30-d748-445b-aad2-03c4d9241631@www.fastmail.com>
In-Reply-To: <CAL_JsqJ8p-zs2F-mXkO_egoBtZ8WymM4O-2AaDJMZYeCFS3sLg@mail.gmail.com>
References: <cover.08e3a6c95159f017b753d0f240086d1a7923758b.1575369656.git-series.andrew@aj.id.au>
 <141f068d10b94413a6d0ca73fe07f8e961380e7b.1575369656.git-series.andrew@aj.id.au>
 <CAL_JsqJ8p-zs2F-mXkO_egoBtZ8WymM4O-2AaDJMZYeCFS3sLg@mail.gmail.com>
Date:   Thu, 05 Dec 2019 15:36:04 +1030
From:   "Andrew Jeffery" <andrew@aj.id.au>
To:     "Rob Herring" <robh+dt@kernel.org>
Cc:     linux-aspeed@lists.ozlabs.org, "Joel Stanley" <joel@jms.id.au>,
        "Mark Rutland" <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Adriana Kobylak" <anoo@us.ibm.com>,
        =?UTF-8?Q?YangBrianC=2EW_=E6=A5=8A=E5=98=89=E5=81=89_TAO?= 
        <yang.brianc.w@inventec.com>, "John Wang" <wangzqbj@inspur.com>,
        "Ken Chen" <chen.kenyy@inventec.com>, "Tao Ren" <taoren@fb.com>,
        "Xo Wang" <xow@google.com>,
        "(Exiting) Yao Yuan" <yao.yuan@linaro.org>
Subject: =?UTF-8?Q?Re:_[PATCH_05/14]_ARM:_dts:_aspeed-g5:_Fix_aspeed,external-nod?=
 =?UTF-8?Q?es_description?=
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 4 Dec 2019, at 01:13, Rob Herring wrote:
> On Tue, Dec 3, 2019 at 6:03 AM Andrew Jeffery <andrew@aj.id.au> wrote:
> >
> > The existing approach lead to an error from the dtbs_check:
> >
> >     pinctrl: aspeed,external-nodes: [[8, 9]] is too short
> 
> This one where we have list of phandles is fixed in dtc. I need to
> update the kernel's copy.

Ah, cool.

> 
> > Cc: Adriana Kobylak <anoo@us.ibm.com>
> > Cc: Brian Yang <yang.brianc.w@inventec.com>
> > Cc: Joel Stanley <joel@jms.id.au>
> > Cc: John Wang <wangzqbj@inspur.com>
> > Cc: Ken Chen <chen.kenyy@inventec.com>
> > Cc: Tao Ren <taoren@fb.com>
> > Cc: Xo Wang <xow@google.com>
> > Cc: Yuan Yao <yao.yuan@linaro.org>
> > Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> > Reviewed-by: Joel Stanley <joel@jms.id.au>
> > ---
> >  arch/arm/boot/dts/aspeed-bmc-arm-centriq2400-rep.dts     |  4 +----
> >  arch/arm/boot/dts/aspeed-bmc-arm-stardragon4800-rep2.dts |  4 +----
> >  arch/arm/boot/dts/aspeed-bmc-inspur-fp5280g2.dts         |  9 +++++++--
> >  arch/arm/boot/dts/aspeed-bmc-intel-s2600wf.dts           |  4 +----
> >  arch/arm/boot/dts/aspeed-bmc-opp-lanyang.dts             |  4 +----
> >  arch/arm/boot/dts/aspeed-bmc-opp-romulus.dts             |  4 +----
> >  arch/arm/boot/dts/aspeed-bmc-opp-swift.dts               |  4 +----
> >  arch/arm/boot/dts/aspeed-bmc-opp-witherspoon.dts         |  4 +----
> >  arch/arm/boot/dts/aspeed-bmc-opp-zaius.dts               |  2 +--
> >  arch/arm/boot/dts/aspeed-g5.dtsi                         |  3 +--
> >  10 files changed, 8 insertions(+), 34 deletions(-)
> >
> > diff --git a/arch/arm/boot/dts/aspeed-bmc-arm-centriq2400-rep.dts b/arch/arm/boot/dts/aspeed-bmc-arm-centriq2400-rep.dts
> > index c2ece0b91885..de9612e49c69 100644
> > --- a/arch/arm/boot/dts/aspeed-bmc-arm-centriq2400-rep.dts
> > +++ b/arch/arm/boot/dts/aspeed-bmc-arm-centriq2400-rep.dts
> > @@ -211,10 +211,6 @@
> >         status = "okay";
> >  };
> >
> > -&pinctrl {
> > -       aspeed,external-nodes = <&gfx &lhc>;
> > -};
> > -
> >  &gpio {
> >         pin_gpio_c7 {
> >                 gpio-hog;
> > diff --git a/arch/arm/boot/dts/aspeed-bmc-arm-stardragon4800-rep2.dts b/arch/arm/boot/dts/aspeed-bmc-arm-stardragon4800-rep2.dts
> > index 2c29ac037d32..022d0744d786 100644
> > --- a/arch/arm/boot/dts/aspeed-bmc-arm-stardragon4800-rep2.dts
> > +++ b/arch/arm/boot/dts/aspeed-bmc-arm-stardragon4800-rep2.dts
> > @@ -200,10 +200,6 @@
> >         status = "okay";
> >  };
> >
> > -&pinctrl {
> > -       aspeed,external-nodes = <&gfx &lhc>;
> > -};
> > -
> >  &gpio {
> >         pin_gpio_c7 {
> >                 gpio-hog;
> > diff --git a/arch/arm/boot/dts/aspeed-bmc-inspur-fp5280g2.dts b/arch/arm/boot/dts/aspeed-bmc-inspur-fp5280g2.dts
> > index c17bb7fce7ff..d69da58476fe 100644
> > --- a/arch/arm/boot/dts/aspeed-bmc-inspur-fp5280g2.dts
> > +++ b/arch/arm/boot/dts/aspeed-bmc-inspur-fp5280g2.dts
> > @@ -782,8 +782,13 @@
> >         memory-region = <&gfx_memory>;
> >  };
> >
> > -&pinctrl {
> > -       aspeed,external-nodes = <&gfx &lhc>;
> > +&gpio {
> > +       pin_gpio_b7 {
> > +               gpio-hog;
> > +               gpios = <ASPEED_GPIO(B,7) GPIO_ACTIVE_LOW>;
> > +               output-high;
> > +               line-name = "BMC_INIT_OK";
> > +       };
> 
> Seems like an unrelated change?

Yeah, that seems to be a bad rebase conflict resolution.

Thanks,

Andrew
