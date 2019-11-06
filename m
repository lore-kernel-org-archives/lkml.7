Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECEEAC5DF62
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 11:25:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3C9D206A3
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 11:25:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731414AbfKFLZv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 06:25:51 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:51945 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbfKFLZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 06:25:51 -0500
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1iSJRW-0001jd-TJ; Wed, 06 Nov 2019 12:25:42 +0100
Message-ID: <aaada00902c84b9f375555ee98946631b7de3280.camel@pengutronix.de>
Subject: Re: [PATCH v4 3/3] reset: npcm: add NPCM reset controller driver
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Tomer Maimon <tmaimon77@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nancy Yuen <yuenn@google.com>,
        Patrick Venture <venture@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Avi Fishman <avifishman70@gmail.com>,
        Joel Stanley <joel@jms.id.au>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>
Date:   Wed, 06 Nov 2019 12:25:42 +0100
In-Reply-To: <CAP6Zq1iYKKkcEKt-WW3sDRJ1ktWgQug9SQc2AF473fWnooUxeQ@mail.gmail.com>
References: <20191106095832.236766-1-tmaimon77@gmail.com>
         <20191106095832.236766-4-tmaimon77@gmail.com>
         <89250d485d05d4d671203ae615ebcf514b4d6705.camel@pengutronix.de>
         <CAP6Zq1iYKKkcEKt-WW3sDRJ1ktWgQug9SQc2AF473fWnooUxeQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tomer,

On Wed, 2019-11-06 at 13:14 +0200, Tomer Maimon wrote:
[...]
> On Wed, 6 Nov 2019 at 12:39, Philipp Zabel <p.zabel@pengutronix.de> wrote:
[...]
> > Is this npcm750 specific? If so, you could call it npcm750_usb_reset and
> > only call it if the compatible matches.
> 
> No, we will need it also in future BMC's

Ok, thank you for clarifying.

> > 
> > +{
> > > +     struct device_node *np = pdev->dev.of_node;
> > > +     u32 mdlr, iprst1, iprst2, iprst3;
> > > +     struct regmap *gcr_regmap = NULL;
> > > +     u32 ipsrst1_bits = 0;
> > > +     u32 ipsrst2_bits = NPCM_IPSRST2_USB_HOST;
> > > +     u32 ipsrst3_bits = 0;
> > > +
> > > +     if (of_device_is_compatible(np, "nuvoton,npcm750-reset")) {
> > 
> > Better use of_match_device(). Also see above, I think this check could
> > be done in probe() already?
> > 
> I will use  of_match_device. because the nuvoton,npcm750-reset used only at
> npcm_usb_reset and in the next BMC version we will need to get other
> reset device I prefer to leave it the  npcm_usb_reset function, is it O.K?

Yes, that is fine. I would store the GCR lookup compatible string in a
per-device const struct that is accessible through of_device_id->data.

> > > +             gcr_regmap =
> > syscon_regmap_lookup_by_compatible("nuvoton,npcm750-gcr");
> > > +             if (IS_ERR(gcr_regmap)) {
> > > +                     dev_err(&pdev->dev, "Failed to find
> > nuvoton,npcm750-gcr\n");
> > > +                     return PTR_ERR(gcr_regmap);
> > > +             }
> > > +     }
> > > +     if (!gcr_regmap)
> > > +             return -ENXIO;

^ This code could then be the same for all platforms.

regards
Philipp

