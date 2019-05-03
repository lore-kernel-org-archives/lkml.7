Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C1DBC43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 15:44:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E1132081C
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 15:44:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728122AbfECPoM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 11:44:12 -0400
Received: from smtp-out.xnet.cz ([178.217.244.18]:33044 "EHLO smtp-out.xnet.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727460AbfECPoM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 11:44:12 -0400
Received: from meh.true.cz (meh.true.cz [108.61.167.218])
        (Authenticated sender: petr@true.cz)
        by smtp-out.xnet.cz (Postfix) with ESMTPSA id 202474CF3;
        Fri,  3 May 2019 17:44:09 +0200 (CEST)
Received: from localhost (meh.true.cz [local])
        by meh.true.cz (OpenSMTPD) with ESMTPA id 24f09925;
        Fri, 3 May 2019 17:44:07 +0200 (CEST)
Date:   Fri, 3 May 2019 17:44:07 +0200
From:   Petr =?utf-8?Q?=C5=A0tetiar?= <ynezz@true.cz>
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Alban Bedel <albeu@free.fr>, Felix Fietkau <nbd@nbd.name>,
        John Crispin <john@phrozen.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 01/10] of_net: add NVMEM support to of_get_mac_address
Message-ID: <20190503154407.GE71477@meh.true.cz>
Reply-To: Petr =?utf-8?Q?=C5=A0tetiar?= <ynezz@true.cz>
References: <1556893635-18549-1-git-send-email-ynezz@true.cz>
 <1556893635-18549-2-git-send-email-ynezz@true.cz>
 <20190503143643.hhfamnptcuriav4k@flea>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190503143643.hhfamnptcuriav4k@flea>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Maxime Ripard <maxime.ripard@bootlin.com> [2019-05-03 16:36:43]:

Hi,

...

> > +	pp = devm_kzalloc(&pdev->dev, sizeof(*pp), GFP_KERNEL);
> > +	if (!pp)
> > +		return ERR_PTR(-ENOMEM);
> > +
> > +	pp->name = "nvmem-mac-address";
> > +	pp->length = ETH_ALEN;
> > +	pp->value = devm_kmemdup(&pdev->dev, mac, ETH_ALEN, GFP_KERNEL);
> > +	if (!pp->value) {
> > +		ret = -ENOMEM;
> > +		goto free;
> > +	}
> > +
> > +	ret = of_add_property(np, pp);
> > +	if (ret)
> > +		goto free;
> > +
> > +	return pp->value;
> 
> I'm not sure why you need to do that allocation here, and why you need
> to modify the DT?

I was asked about that in v2[0] already, so just copy&pasting relevant part of
my response here:

 I've just carried it over from v1 ("of_net: add mtd-mac-address support to
 of_get_mac_address()")[1] as nobody objected about this so far.

 Honestly I don't know if it's necessary to have it, but so far address,
 mac-address and local-mac-address properties provide this DT nodes, so I've
 simply thought, that it would be good to have it for MAC address from NVMEM as
 well in order to stay consistent.

 [...]

0. https://patchwork.ozlabs.org/patch/1092248/#2164089
1. https://patchwork.ozlabs.org/patch/1086628/

> can't you just return the mac address directly since it's what the
> of_get_mac_address caller will expect anyway?

I don't need this stuff, I can remove it, please just tell me what is
appropriate and I'm going to do that.

-- ynezz
