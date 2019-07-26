Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 648C5C76191
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 06:49:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 344DC218D4
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 06:49:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="jXDTHisi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="A/lTXR68"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726109AbfGZGtl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 02:49:41 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:37845 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725867AbfGZGtl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 02:49:41 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 2F89342BA;
        Fri, 26 Jul 2019 02:49:40 -0400 (EDT)
Received: from imap2 ([10.202.2.52])
  by compute4.internal (MEProxy); Fri, 26 Jul 2019 02:49:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type; s=fm3; bh=kokOQgzIABuKcOf13CmoUQh+Gn2cv69
        dV+LTjmU8rAk=; b=jXDTHisiOlQRsj/JEm7c0JiMRIHipx0N+6scM50gRBSdCwm
        MXdU6grcxma8/9ibQjvhXQGFQ/yKqYPP1C6km9DaNzuzVfojUiBtICogtZcK4tRK
        aPDqdXZfsrQ8Wzks7bmcskSnxEGrjFxRJpW9M89mo/p6YvkIQnnGR1Y49Q8aUJPy
        PxrxENHZfHf80gdUCZ/29i7IASp38NW6T5aBAhFVKItrPPRt5jUXMCLrgWYt2dzF
        FBJIGo9Rro1nsCdnGgrAXuQ4Il8fSeBgntVynmytaPco9iPle531hVK4wroVm8eY
        fRevtX684DvtQDS0zoerDdoNKvV0XETKPkxwKrA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=kokOQg
        zIABuKcOf13CmoUQh+Gn2cv69dV+LTjmU8rAk=; b=A/lTXR68tPAlyjt76lGNWv
        D6td6Cm4rdBWDvxB8Z3be9tUf+A+c7ltv+sjTLU5MmcUiKOKfTc9XFapQeFg13U5
        +GUWPBdq29YdoTJkoURl1/PyPHR0UYnPk7eOR4Af6xaGV9xSiupuB2mlK7+3xkvQ
        DdutVXz2D706AB4uDOsRPSP18SOkmGNiHi1KXhjFpNnwu7Qmg89sKmKj9wurDwBH
        txfrthKLxE+ETW3Ooc3S+D47Tnz+pWXh0GoMCjgooXvcigx2bdU7cZL3dJXb8jEk
        y5Bcb5MNoQlmBlFqcgY5S+P+U1bSz45PjGcohYHHtJSC8O0rw20JZxiW36P2xB8A
        ==
X-ME-Sender: <xms:gqI6Xd1eXtuKPIeCF7vKxebDRJaLOq4jc5OcyklJNCoJyMnOUbkE7Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrkeefgdduudefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdetnhgu
    rhgvficulfgvfhhfvghrhidfuceorghnughrvgifsegrjhdrihgurdgruheqnecurfgrrh
    grmhepmhgrihhlfhhrohhmpegrnhgurhgvfiesrghjrdhiugdrrghunecuvehluhhsthgv
    rhfuihiivgeptd
X-ME-Proxy: <xmx:gqI6XTLtjdjlhZAP8lYDylnGOoIU5_qwErskFxXawOBDdepaVpDIgQ>
    <xmx:gqI6XUGoLVGo134sbxvXj2ZXOiq-x4iSUONdHhGZ3jMmyqh_1acQaw>
    <xmx:gqI6XXUncIRQVtAYKxT9MV7Qrg7N7wAzOZGdG5qG8JsNMYavcpi3MQ>
    <xmx:hKI6XVMTy-7dFx0q_FrEmhKBR337Tk9zQ4hVoRgyf4f6uzv34pkImA>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id B948AE00A2; Fri, 26 Jul 2019 02:49:38 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.1.6-736-gdfb8e44-fmstable-20190718v2
Mime-Version: 1.0
Message-Id: <4c6c020d-5985-4c57-aaae-c2393f9cc2fc@www.fastmail.com>
In-Reply-To: <8a7bfe52-83ca-7601-7d75-e5615da7b5de@intel.com>
References: <20190712033214.24713-1-andrew@aj.id.au>
 <20190712033214.24713-3-andrew@aj.id.au>
 <d6f7fdf2-07ed-354a-ca29-f3175623679c@intel.com>
 <7cd30f3d-43fd-42da-9301-091eb2625c65@www.fastmail.com>
 <8a7bfe52-83ca-7601-7d75-e5615da7b5de@intel.com>
Date:   Fri, 26 Jul 2019 16:17:31 +0930
From:   "Andrew Jeffery" <andrew@aj.id.au>
To:     "Adrian Hunter" <adrian.hunter@intel.com>,
        linux-mmc <linux-mmc@vger.kernel.org>
Cc:     "Ulf Hansson" <ulf.hansson@linaro.org>,
        "Rob Herring" <robh+dt@kernel.org>, mark.rutland@arm.com,
        "Joel Stanley" <joel@jms.id.au>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        "Ryan Chen" <ryanchen.aspeed@gmail.com>
Subject: Re: [PATCH v2 2/2] mmc: Add support for the ASPEED SD controller
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 26 Jul 2019, at 15:27, Adrian Hunter wrote:
> On 26/07/19 3:52 AM, Andrew Jeffery wrote:
> > On Thu, 25 Jul 2019, at 22:49, Adrian Hunter wrote:
> >> On 12/07/19 6:32 AM, Andrew Jeffery wrote:
> >>> +static int aspeed_sdhci_probe(struct platform_device *pdev)
> >>> +{
> >>> +	struct sdhci_pltfm_host *pltfm_host;
> >>> +	struct aspeed_sdhci *dev;
> >>> +	struct sdhci_host *host;
> >>> +	struct resource *res;
> >>> +	int slot;
> >>> +	int ret;
> >>> +
> >>> +	host = sdhci_pltfm_init(pdev, &aspeed_sdc_pdata, sizeof(*dev));
> >>> +	if (IS_ERR(host))
> >>> +		return PTR_ERR(host);
> >>> +
> >>> +	pltfm_host = sdhci_priv(host);
> >>> +	dev = sdhci_pltfm_priv(pltfm_host);
> >>> +	dev->parent = dev_get_drvdata(pdev->dev.parent);
> >>> +
> >>> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> >>> +	slot = aspeed_sdhci_calculate_slot(dev, res);
> >>> +	if (slot < 0)
> >>> +		return slot;
> >>> +	dev_info(&pdev->dev, "Configuring for slot %d\n", slot);
> >>> +	dev->width_mask = !slot ? ASPEED_SDC_S0MMC8 : ASPEED_SDC_S1MMC8;
> >>
> >> That implies that you only support 2 slots which begs the question why
> >> you don't validate slot.
> > 
> > I'm not sure what you mean here, but I'll dig into it.
> 
> I just meant, if you only support 2 slots:
> 
> 	if (slot > 1)
> 		return -EINVAL;
>

Oh, sure.
