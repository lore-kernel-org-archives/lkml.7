Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 450ACC3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 20:27:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1451720656
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 20:27:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566332874;
	bh=qJwFcNlR0CORyxzVUsDm0Ci04TIVsVpNhIrFLVzEDcM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Bzs6HrUkoku0jWsG3jIsRkw7XpHiGpAJF4umiWYcDP5OTvLCMTmQZNMuXLJl/d0I3
	 quR6IjANSlTR/P94OlGjk74lDZM4jMI3RbqaGv8IJcDNkgp151Sprxvjk9upazB4+z
	 A66UkwVq6ysc0rNjI7lpN1bh63L7kCQ7ut3tZRLg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730761AbfHTU1x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 16:27:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:34128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727358AbfHTU1w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 16:27:52 -0400
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 416CE20656;
        Tue, 20 Aug 2019 20:27:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566332871;
        bh=qJwFcNlR0CORyxzVUsDm0Ci04TIVsVpNhIrFLVzEDcM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=P+XAYW3Ntbk5srVJo06mwylxmGXmWveNUNPtEHiFu52vNanqZ2IcVzzhCn4Cx653m
         n/A5u9trXaP1jitd/8BCrObxjTIVjHF41lKkbBl0ynNccFx01gc3ff8Q4NMu402KJM
         u2Toi0UAyI6qHsK/gISdKkjtxnTsYs9mpH+aB5I8=
Received: by mail-qt1-f174.google.com with SMTP id v38so295074qtb.0;
        Tue, 20 Aug 2019 13:27:51 -0700 (PDT)
X-Gm-Message-State: APjAAAWFKySHV1cwGnxbil2K55vrd89wHGUsL6LB2Q7fhrJfNaw2SQ7G
        ct90yd9VeQFAIEpRWM7CS0rGOlP7wQbgIzK0Nw==
X-Google-Smtp-Source: APXvYqy+v7sXDaDQ1ZhwUR+S9/UtyTo0vgjYkzgBiAJPIdVDtx2luGfPrCOPLOwC6MdDz04cMAoAoOxTY8HbUCjg08s=
X-Received: by 2002:ac8:44c4:: with SMTP id b4mr27733762qto.224.1566332870459;
 Tue, 20 Aug 2019 13:27:50 -0700 (PDT)
MIME-Version: 1.0
References: <1566315318-30320-1-git-send-email-krzk@kernel.org>
 <1566315318-30320-3-git-send-email-krzk@kernel.org> <CAL_JsqJLSZ50tdFcdPFc2ifcDoFZFuw=SoKsunzjtAhZ-11fBg@mail.gmail.com>
 <CAJKOXPfkNcWw9sunwXGRz42jOL0cdRC-iiHLtWCYvo5oxCMwFQ@mail.gmail.com>
 <CAL_JsqKAH6n1sMoWOhfiHKxgREr-EN1tw0QtC1H8Fm=a7PNzOA@mail.gmail.com> <20190820202142.GA15866@kozik-lap>
In-Reply-To: <20190820202142.GA15866@kozik-lap>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 20 Aug 2019 15:27:39 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKBWB2FiVjYo9O7DPw1JYJvan7uRgbR0VBG=FfHDVYdZQ@mail.gmail.com>
Message-ID: <CAL_JsqKBWB2FiVjYo9O7DPw1JYJvan7uRgbR0VBG=FfHDVYdZQ@mail.gmail.com>
Subject: Re: [PATCH v6 3/4] dt-bindings: arm: fsl: Add Kontron i.MX6UL N6310 compatibles
To:     Krzysztof Kozlowski <krzk@kernel.org>
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

On Tue, Aug 20, 2019 at 3:21 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On Tue, Aug 20, 2019 at 03:04:57PM -0500, Rob Herring wrote:
> > On Tue, Aug 20, 2019 at 1:36 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> > >
> > > On Tue, 20 Aug 2019 at 18:59, Rob Herring <robh+dt@kernel.org> wrote:
> > > >
> > > > On Tue, Aug 20, 2019 at 10:35 AM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> > > > >
> > > > > Add the compatibles for Kontron i.MX6UL N6310 SoM and boards.
> > > > >
> > > > > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> > > > >
> > > > > ---
> > > > >
> > > > > Changes since v5:
> > > > > New patch
> > > > > ---
> > > > >  Documentation/devicetree/bindings/arm/fsl.yaml | 3 +++
> > > > >  1 file changed, 3 insertions(+)
> > > > >
> > > > > diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
> > > > > index 7294ac36f4c0..d07b3c06d7cf 100644
> > > > > --- a/Documentation/devicetree/bindings/arm/fsl.yaml
> > > > > +++ b/Documentation/devicetree/bindings/arm/fsl.yaml
> > > > > @@ -161,6 +161,9 @@ properties:
> > > > >          items:
> > > > >            - enum:
> > > > >                - fsl,imx6ul-14x14-evk      # i.MX6 UltraLite 14x14 EVK Board
> > > > > +              - kontron,imx6ul-n6310-som  # Kontron N6310 SOM
> > > > > +              - kontron,imx6ul-n6310-s    # Kontron N6310 S Board
> > > > > +              - kontron,imx6ul-n6310-s-43 # Kontron N6310 S 43 Board
> > > >
> > > > This doesn't match what is in your dts files. Run 'make dtbs_check' and see.
> > >
> > > You mean the name does not match? I thought that '#' is a comment in YAML...
> >
> > No, the number of compatible strings is the problem.
>
> I see. If I understand the schema correctly, this should look like:

Looks correct, but a couple of comments.

> diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
> index 7294ac36f4c0..eb263d1ccf13 100644
> --- a/Documentation/devicetree/bindings/arm/fsl.yaml
> +++ b/Documentation/devicetree/bindings/arm/fsl.yaml
> @@ -161,6 +161,22 @@ properties:
>          items:
>            - enum:
>                - fsl,imx6ul-14x14-evk      # i.MX6 UltraLite 14x14 EVK Board
> +              - kontron,imx6ul-n6310-som  # Kontron N6310 SOM

Is the SOM ever used alone? If not, then no point in listing this here.

> +          - const: fsl,imx6ul
> +
> +      - description: Kontron N6310 S Board
> +        items:
> +          - enum:
> +              - kontron,imx6ul-n6310-s

This could be a 'const' instead. It depends if you think there will
ever be more than one entry.

> +          - const: kontron,imx6ul-n6310-som
> +          - const: fsl,imx6ul
> +
> +      - description: Kontron N6310 S 43 Board
> +        items:
> +          - enum:
> +              - kontron,imx6ul-n6310-s-43
> +          - const: kontron,imx6ul-n6310-s
> +          - const: kontron,imx6ul-n6310-som
>            - const: fsl,imx6ul
>
>        - description: i.MX6ULL based Boards
>
>
> It passes the dtbs_check. Is it correct?
>
> Best regards,
> Krzysztof
>
