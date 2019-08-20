Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B5CAC3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 21:23:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E131622DD3
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 21:23:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730839AbfHTVXH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 17:23:07 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:42203 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728283AbfHTVXG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 17:23:06 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1i0Bap-0003EB-OR; Tue, 20 Aug 2019 23:23:03 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1i0Bap-0001UJ-3l; Tue, 20 Aug 2019 23:23:03 +0200
Date:   Tue, 20 Aug 2019 23:23:03 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH RFC] dt-bindings: regulator: define a mux regulator
Message-ID: <20190820212303.dhdo7g7kvisgeb3h@pengutronix.de>
References: <20190820152511.15307-1-u.kleine-koenig@pengutronix.de>
 <CAL_JsqLg19883syn66P6zUkLPpQ8FYpeFj2QYvSp1UsWOhVKyQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL_JsqLg19883syn66P6zUkLPpQ8FYpeFj2QYvSp1UsWOhVKyQ@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Rob,

On Tue, Aug 20, 2019 at 11:39:27AM -0500, Rob Herring wrote:
> On Tue, Aug 20, 2019 at 10:25 AM Uwe Kleine-König
> <u.kleine-koenig@pengutronix.de> wrote:
> >
> > A mux regulator is used to provide current on one of several outputs. It
> > might look as follows:
> >
> >       ,------------.
> >     --<OUT0     A0 <--
> >     --<OUT1     A1 <--
> >     --<OUT2     A2 <--
> >     --<OUT3        |
> >     --<OUT4     EN <--
> >     --<OUT5        |
> >     --<OUT6     IN <--
> >     --<OUT7        |
> >       `------------'
> >
> > Depending on which address is encoded on the three address inputs A0, A1
> > and A2 the current provided on IN is provided on one of the eight
> > outputs.
> >
> > What is new here is that the binding makes use of a #regulator-cells
> > property. This uses the approach known from other bindings (e.g. gpio)
> > to allow referencing all eight outputs with phandle arguments. This
> > requires an extention in of_get_regulator to use a new variant of
> > of_parse_phandle_with_args that has a cell_count_default parameter that
> > is used in absence of a $cell_name property. Even if we'd choose to
> > update all regulator-bindings to add #regulator-cells = <0>; we still
> > needed something to implement compatibility to the currently defined
> > bindings.
> >
> > Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> > ---
> > Hello,
> >
> > the obvious alternative is to add (here) eight subnodes to represent the
> > eight outputs. This is IMHO less pretty, but wouldn't need to introduce
> > #regulator-cells.
> 
> I'm okay with #regulator-cells approach.

OK, then I will look into that in more detail; unless the regulator guys
don't agree with this approach of course.

> > Apart from reg = <..> and a phandle there is (I think) nothing that
> > needs to be specified in the subnodes because all properties of an
> > output (apart from the address) apply to all outputs.
> >
> > What do you think?
> >
> > Best regards
> > Uwe
> >
> >  .../bindings/regulator/mux-regulator.yaml     | 52 +++++++++++++++++++
> >  1 file changed, 52 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/regulator/mux-regulator.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/regulator/mux-regulator.yaml b/Documentation/devicetree/bindings/regulator/mux-regulator.yaml
> > new file mode 100644
> > index 000000000000..f06dbb969090
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/regulator/mux-regulator.yaml
> > @@ -0,0 +1,52 @@
> > +# SPDX-License-Identifier: GPL-2.0
> 
> (GPL-2.0-only OR BSD-2-Clause) is preferred.

OK.

> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/regulator/mux-regulator.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: MUX regulators
> > +
> > +properties:
> > +  compatible:
> > +    const: XXX,adb708
> 
> ? I assume you will split this into a common and specific schemas. I
> suppose there could be differing ways to control the mux just like all
> other muxes.

Not sure if a specific schema is necessary. I wrote XXX because I was
offline while I authored the binding and so couldn't determine the right
vendor to use.

> > +  enable-gpios:
> > +    maxItems: 1
> > +
> > +  address-gpios:
> > +    description: Array of typically three GPIO pins used to select the
> > +      regulator's output. The least significant address GPIO must be listed
> > +      first. The others follow in order of significance.
> > +    minItems: 1
> > +
> > +  "#regulator-cells":
> 
> How is this not required?

It should. For the RFC patch I didn't took the time to iron all the
details. My main concern was/is how the binding should look like and if
an #regulator-cells with a default would be acceptable.
 
Best regards and thanks for your feedback,
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
