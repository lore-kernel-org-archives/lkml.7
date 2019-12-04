Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6497FC2D0B1
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 20:15:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 354FF207DD
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 20:15:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728171AbfLDUPD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 15:15:03 -0500
Received: from gloria.sntech.de ([185.11.138.130]:48418 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727033AbfLDUPD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 15:15:03 -0500
Received: from ip5f5a6266.dynamic.kabel-deutschland.de ([95.90.98.102] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1icb2t-0001Zb-KG; Wed, 04 Dec 2019 21:14:47 +0100
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Rob Herring <robh@kernel.org>
Cc:     Jagan Teki <jagan@amarulasolutions.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Akash Gajjar <akash@openedev.com>, Tom Cubie <tom@radxa.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-amarula@amarulasolutions.com
Subject: Re: [PATCH v2 1/5] dt-bindings: arm: rockchip: Add VMARC RK3399Pro SOM binding
Date:   Wed, 04 Dec 2019 21:14:46 +0100
Message-ID: <5408424.xnnVrITuBQ@diego>
In-Reply-To: <20191204193240.GA6772@bogus>
References: <20191121141445.28712-1-jagan@amarulasolutions.com> <20191121141445.28712-2-jagan@amarulasolutions.com> <20191204193240.GA6772@bogus>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 4. Dezember 2019, 20:32:40 CET schrieb Rob Herring:
> On Thu, Nov 21, 2019 at 07:44:41PM +0530, Jagan Teki wrote:
> > VMARC RK3399Pro SOM is a standard SMARC SOM design with
> > Rockchip RK3399Pro SoC, which is designed by Vamrs.
> > 
> > Since it is a standard SMARC design, it can be easily
> > mounted on the supporting Carrier board. Radxa has
> > suitable carrier board to mount and use it as a final
> > version board.
> > 
> > Add dt-bindings for it.
> > 
> > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > ---
> > Changes for v2:
> > - none
> > 
> >  Documentation/devicetree/bindings/arm/rockchip.yaml | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
> > index 45728fd22af8..51aa458833a9 100644
> > --- a/Documentation/devicetree/bindings/arm/rockchip.yaml
> > +++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
> > @@ -526,4 +526,9 @@ properties:
> >          items:
> >            - const: tronsmart,orion-r68-meta
> >            - const: rockchip,rk3368
> > +
> > +      - description: Vamrs VMARC RK3399Pro SOM
> > +        items:
> > +          - const: vamrs,rk3399pro-vmarc-som
> 
> Why do you need this? You just override it in your dts files, so it is 
> not really used. Perhaps the top-level should have all 3 compatibles? If 
> so, then the schemas are wrong.

In the past we had SOMs that _could_ function alone, but looking at the
announcement for this one [0] suggests that the SOM always needs a carrier
board, so I don't think the SOM actually needs a separate entry but instead
should be part of the carrier-board compatible list, as Rob suggested.

So I guess we should only have (from patch 3):
  - description: Radxa ROCK Pi N10
        items:
          - const: radxa,rockpi-n10
          - const: vamrs,rk3399pro-vmarc-som
          - const: rockchip,rk3399pro


Heiko

[0] https://www.96rocks.com/blog/2019/09/11/introduce-vamrc-rk3399pro-som-and-ficus2-carrier-board/


