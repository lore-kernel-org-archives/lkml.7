Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F3C1C3A5A3
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 11:55:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03ECC205ED
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 11:55:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="heb4RNlk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MEIM/3bH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733217AbfHVLzM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 07:55:12 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:41565 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727894AbfHVLzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 07:55:09 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 6C0AD1174;
        Thu, 22 Aug 2019 07:55:08 -0400 (EDT)
Received: from imap2 ([10.202.2.52])
  by compute4.internal (MEProxy); Thu, 22 Aug 2019 07:55:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type; s=fm3; bh=zSJauXLFTt8FQXHSlqnwC5NrdUuNC7V
        HRKBipmoRJdY=; b=heb4RNlkCmWc7wvfj7j8Rt9uoYjYOFLWgs0NIxIojr5kZMT
        D9Df7dJCG+Yab+3QD5oJKByXQ89US4AU3N8ekxbt4aWOzHvfST54N/qNAppAxQlh
        wkNiufu110JRd0I+yVa132Mum168IgXiEHMChstVTBSpWR9vhtwJWiUWidJsyTrd
        N8Rs6791JPsFq0im3wvOdIl8w5lLPaElZTkrXLrHbYsJhQeSn/tvcMIOuxCFpk/D
        oSXGZLOLOZv21cY9F8U80taZxrtxBCs4wsblTDej4BBaKywE1rkclqosnjpsx+8t
        EK8WC6YZqYFOLFzi+IeGUX2aTkJZu+9mmxuRbmA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=zSJauX
        LFTt8FQXHSlqnwC5NrdUuNC7VHRKBipmoRJdY=; b=MEIM/3bHWqZn7L00pCocy9
        IodbZoNJGAn9RRMErPLnplhfBcW3iVEISY/iFJyCfA9M0NybFkfsRfI4AiK/+mSJ
        ac05sSBMQMFcPC7JQtrGBx6byDbw+XjdkDrC6//7D1BsNxtXFRCfx/AE3flbwItF
        H0es8drXgSQ5upSzBxhrDvBEojIQ7FoECCHGMke5oMGJJpL0632oDLU6/YC8wDsK
        necKhXlgIHPZ+8arUzZ1LkgFmJyzSLDLdJT+bs5ZOvF2KPofLOb4i5o5L+rr4IOL
        cOrVgDiqk/2QLjbqqO6G8jLCDo7tlAMmr3qZB74FxDTYVxtDSjGgBSIDBPwCUs/A
        ==
X-ME-Sender: <xms:m4JeXT6I4UBQ0qr8jl0ELmtNTLNRx9CLFsUS7_jsTEVK8RhKDtt-ew>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrudegiedgtddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdetnhgu
    rhgvficulfgvfhhfvghrhidfuceorghnughrvgifsegrjhdrihgurdgruheqnecurfgrrh
    grmhepmhgrihhlfhhrohhmpegrnhgurhgvfiesrghjrdhiugdrrghunecuvehluhhsthgv
    rhfuihiivgeptd
X-ME-Proxy: <xmx:m4JeXf63ejuLicYWDghgGybdL-6oSIhCb_Nw6jkeYOQpf8azJxo8pA>
    <xmx:m4JeXV-sGWjJYX2i6u8iMn3yQC_g3L8hai70ELfkAqqmTouOFz-T1A>
    <xmx:m4JeXd_bIx8VxH6JTvHGVtif74ia7vPGAZmBFIU6miSPxSD2Bh-G3g>
    <xmx:nIJeXe1xfSUuGvdvoZeaP7FbUh4Hu97elHgqQwJfJoEtDsMHM4c1hg>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 633BCE00A4; Thu, 22 Aug 2019 07:55:07 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.1.6-916-g49fca03-fmstable-20190821v7
Mime-Version: 1.0
Message-Id: <c78d4c45-477b-4078-b269-aec72571c8cd@www.fastmail.com>
In-Reply-To: <CAPDyKFrDPxFMm710Z25i-euOT2rrgCNXVa4na-fye0xamMXq_A@mail.gmail.com>
References: <20190807003629.2974-1-andrew@aj.id.au>
 <20190807003629.2974-2-andrew@aj.id.au>
 <CACPK8Xe6Zp1uOqEffEc0b6oGa7portEAifGPRqb876HmA+oZeg@mail.gmail.com>
 <6c94aada-9c4a-4f55-9a43-349282ad12af@www.fastmail.com>
 <CAPDyKFrDPxFMm710Z25i-euOT2rrgCNXVa4na-fye0xamMXq_A@mail.gmail.com>
Date:   Thu, 22 Aug 2019 21:25:24 +0930
From:   "Andrew Jeffery" <andrew@aj.id.au>
To:     "Ulf Hansson" <ulf.hansson@linaro.org>
Cc:     "Joel Stanley" <joel@jms.id.au>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Mark Rutland" <mark.rutland@arm.com>,
        "Adrian Hunter" <adrian.hunter@intel.com>,
        devicetree <devicetree@vger.kernel.org>,
        "Linux ARM" <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        "Ryan Chen" <ryanchen.aspeed@gmail.com>
Subject: Re: [PATCH v5 1/2] dt-bindings: mmc: Document Aspeed SD controller
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 22 Aug 2019, at 21:15, Ulf Hansson wrote:
> On Thu, 15 Aug 2019 at 07:37, Andrew Jeffery <andrew@aj.id.au> wrote:
> >
> >
> >
> > On Thu, 15 Aug 2019, at 15:06, Joel Stanley wrote:
> > > On Wed, 7 Aug 2019 at 00:38, Andrew Jeffery <andrew@aj.id.au> wrote:
> > > >
> > > > The ASPEED SD/SDIO/MMC controller exposes two slots implementing the
> > > > SDIO Host Specification v2.00, with 1 or 4 bit data buses, or an 8 bit
> > > > data bus if only a single slot is enabled.
> > > >
> > > > Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> > >
> > > Reviewed-by: Joel Stanley <joel@jms.id.au>
> > >
> > > Two minor comments below.
> > >
> > > > +++ b/Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml
> > > > @@ -0,0 +1,105 @@
> > > > +# SPDX-License-Identifier: GPL-2.0-or-later
> > >
> > > No "Copyright IBM" ?
> >
> > I'm going rogue.
> >
> > That reminds me I should chase up where we got to with the binding
> > licensing.
> >
> > >
> > > > +%YAML 1.2
> > > > +---
> > >
> > > > +
> > > > +examples:
> > > > +  - |
> > > > +    #include <dt-bindings/clock/aspeed-clock.h>
> > > > +    sdc@1e740000 {
> > > > +            compatible = "aspeed,ast2500-sd-controller";
> > > > +            reg = <0x1e740000 0x100>;
> > > > +            #address-cells = <1>;
> > > > +            #size-cells = <1>;
> > > > +            ranges = <0 0x1e740000 0x10000>;
> > >
> > > According to the datasheet this could be 0x20000. It does not matter
> > > though, as there's nothing in it past 0x300.
> >
> > Good catch.
> >
> 
> Are you planning on sending a v6 or you want me to apply this and you
> can post a patch on top?

Yeah, sorry, I wasn't very clear there. I was hoping just to do a follow-up
patch with the cleanups if you're okay with that?

Andrew
