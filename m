Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 470A1C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 18:36:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2227F22DD3
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 18:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566326192;
	bh=UTdkO2l4tPFINQmlJSerTiL5tNVb9F4/4iYSa397hmI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=aI9hj2XOofzANqwMXP0+WOIj2IrBImalpCq4FWHbmqKk5zyOIMcm8/NustCSmyay6
	 wHCaOmeLc++8PJEJMI9+ZIgOT/Kow9ZC4knn/6GMA7lMUjDP2QJIVKY4NzfuiOKXef
	 p5dLNzyBcScxuJXlMnPwNs6yBm0gZWyLkxXW/iyQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730552AbfHTSgb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 14:36:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:57584 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727358AbfHTSgb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 14:36:31 -0400
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C5E4F2332B;
        Tue, 20 Aug 2019 18:36:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566326190;
        bh=UTdkO2l4tPFINQmlJSerTiL5tNVb9F4/4iYSa397hmI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=qOaiEb7IB0HufL7/7QaAGGU/xcEbqY5IamuzeEMhK4WNkpqk7cdPk4FYtd3wC7dRA
         77JL7E45B6juyKSDFgD1Ofr/ruYobSSUzuXeZpTgUj6B/q73QVwWukfYJbCd8StauF
         ziPTt475wmy6pYAcGdtkUvc7auSWBTar4Ey1Wl/k=
Received: by mail-lf1-f47.google.com with SMTP id b17so4888172lff.7;
        Tue, 20 Aug 2019 11:36:29 -0700 (PDT)
X-Gm-Message-State: APjAAAVS5Yh72gLYw6KrIRxmpn8VIeCsD8049yIm54RZFBqiYi7E8smu
        A46HI2C9YJ9eZL59Va536/cja93NUVHoGNkxkLo=
X-Google-Smtp-Source: APXvYqzvVamLIjWXUxlWADgmMIlUpyP1fbFcul5EmSzOfEWv7O1u03JIq8m2JVq3MtS953n2z6XOXFeqqqNRUXqkRAg=
X-Received: by 2002:a19:f007:: with SMTP id p7mr1105313lfc.24.1566326187939;
 Tue, 20 Aug 2019 11:36:27 -0700 (PDT)
MIME-Version: 1.0
References: <1566315318-30320-1-git-send-email-krzk@kernel.org>
 <1566315318-30320-3-git-send-email-krzk@kernel.org> <CAL_JsqJLSZ50tdFcdPFc2ifcDoFZFuw=SoKsunzjtAhZ-11fBg@mail.gmail.com>
In-Reply-To: <CAL_JsqJLSZ50tdFcdPFc2ifcDoFZFuw=SoKsunzjtAhZ-11fBg@mail.gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Tue, 20 Aug 2019 20:36:16 +0200
X-Gmail-Original-Message-ID: <CAJKOXPfkNcWw9sunwXGRz42jOL0cdRC-iiHLtWCYvo5oxCMwFQ@mail.gmail.com>
Message-ID: <CAJKOXPfkNcWw9sunwXGRz42jOL0cdRC-iiHLtWCYvo5oxCMwFQ@mail.gmail.com>
Subject: Re: [PATCH v6 3/4] dt-bindings: arm: fsl: Add Kontron i.MX6UL N6310 compatibles
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Schrempf Frieder <frieder.schrempf@kontron.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Aug 2019 at 18:59, Rob Herring <robh+dt@kernel.org> wrote:
>
> On Tue, Aug 20, 2019 at 10:35 AM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> >
> > Add the compatibles for Kontron i.MX6UL N6310 SoM and boards.
> >
> > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> >
> > ---
> >
> > Changes since v5:
> > New patch
> > ---
> >  Documentation/devicetree/bindings/arm/fsl.yaml | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
> > index 7294ac36f4c0..d07b3c06d7cf 100644
> > --- a/Documentation/devicetree/bindings/arm/fsl.yaml
> > +++ b/Documentation/devicetree/bindings/arm/fsl.yaml
> > @@ -161,6 +161,9 @@ properties:
> >          items:
> >            - enum:
> >                - fsl,imx6ul-14x14-evk      # i.MX6 UltraLite 14x14 EVK Board
> > +              - kontron,imx6ul-n6310-som  # Kontron N6310 SOM
> > +              - kontron,imx6ul-n6310-s    # Kontron N6310 S Board
> > +              - kontron,imx6ul-n6310-s-43 # Kontron N6310 S 43 Board
>
> This doesn't match what is in your dts files. Run 'make dtbs_check' and see.

You mean the name does not match? I thought that '#' is a comment in YAML...

The dtbs_check fail on missing dt-mk-schema. Any reason why it is not
in the scripts?

Best regards,
Krzysztof
