Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 759B7C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 20:05:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4250B216F4
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 20:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566331513;
	bh=wPpvb7w4ZKK6Za329CALdlZ/QeVsFqPOrpteemAh5kU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=aPWlkCAh4IgXDwz5jNcGD0cOz6vAFn5DXz93uxw/0lbaH6dAFUjtGc0aXBJZuVXnm
	 wWGU9B19U5eYny+6bv7kj4QD404/wpNkn+KBHdyhqKCT1ka7kboN6Ur5H8OAKhdMfl
	 qz+DFwgsk5vz+dXqImD0fYy3rdyZHQDlOMaTVWLA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730756AbfHTUFM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 16:05:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:54940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729950AbfHTUFM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 16:05:12 -0400
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A505022DD3;
        Tue, 20 Aug 2019 20:05:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566331510;
        bh=wPpvb7w4ZKK6Za329CALdlZ/QeVsFqPOrpteemAh5kU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=pDduHfGNGtlYNON8kaipkj6CjpJTHzUl4j/Z8xrp47pWhQUJEAiq4JiwKgWXRLadR
         /DG87Exz4v3At1yOpMtqkAnAASL7WI+QyVfW0/qZkkPO8jK06bjkJavInnGpQYCTY2
         bxijbHo3Vt5y68ol8NpyW7FobeIhWKBpEOhxcHlo=
Received: by mail-qk1-f169.google.com with SMTP id s145so5602209qke.7;
        Tue, 20 Aug 2019 13:05:10 -0700 (PDT)
X-Gm-Message-State: APjAAAXN1MnHNLEqZQJQTMw7V/qWBPT4/fWoyblMzLPDnNZHXa5nimnG
        KaGdfMRDhOGZuRO8Nvh2rIBE2FZqI3B5BzWxOw==
X-Google-Smtp-Source: APXvYqwpre99OTn6TP/Lj9LeoHcq3KGHlCF+SFWyD+78wdOZa/nObGtCvRvNm/ywPu1TCCL4dplsSFSV0hb534aL8dE=
X-Received: by 2002:a37:a44a:: with SMTP id n71mr27280264qke.393.1566331509857;
 Tue, 20 Aug 2019 13:05:09 -0700 (PDT)
MIME-Version: 1.0
References: <1566315318-30320-1-git-send-email-krzk@kernel.org>
 <1566315318-30320-3-git-send-email-krzk@kernel.org> <CAL_JsqJLSZ50tdFcdPFc2ifcDoFZFuw=SoKsunzjtAhZ-11fBg@mail.gmail.com>
 <CAJKOXPfkNcWw9sunwXGRz42jOL0cdRC-iiHLtWCYvo5oxCMwFQ@mail.gmail.com>
In-Reply-To: <CAJKOXPfkNcWw9sunwXGRz42jOL0cdRC-iiHLtWCYvo5oxCMwFQ@mail.gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 20 Aug 2019 15:04:57 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKAH6n1sMoWOhfiHKxgREr-EN1tw0QtC1H8Fm=a7PNzOA@mail.gmail.com>
Message-ID: <CAL_JsqKAH6n1sMoWOhfiHKxgREr-EN1tw0QtC1H8Fm=a7PNzOA@mail.gmail.com>
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

On Tue, Aug 20, 2019 at 1:36 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On Tue, 20 Aug 2019 at 18:59, Rob Herring <robh+dt@kernel.org> wrote:
> >
> > On Tue, Aug 20, 2019 at 10:35 AM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> > >
> > > Add the compatibles for Kontron i.MX6UL N6310 SoM and boards.
> > >
> > > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> > >
> > > ---
> > >
> > > Changes since v5:
> > > New patch
> > > ---
> > >  Documentation/devicetree/bindings/arm/fsl.yaml | 3 +++
> > >  1 file changed, 3 insertions(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
> > > index 7294ac36f4c0..d07b3c06d7cf 100644
> > > --- a/Documentation/devicetree/bindings/arm/fsl.yaml
> > > +++ b/Documentation/devicetree/bindings/arm/fsl.yaml
> > > @@ -161,6 +161,9 @@ properties:
> > >          items:
> > >            - enum:
> > >                - fsl,imx6ul-14x14-evk      # i.MX6 UltraLite 14x14 EVK Board
> > > +              - kontron,imx6ul-n6310-som  # Kontron N6310 SOM
> > > +              - kontron,imx6ul-n6310-s    # Kontron N6310 S Board
> > > +              - kontron,imx6ul-n6310-s-43 # Kontron N6310 S 43 Board
> >
> > This doesn't match what is in your dts files. Run 'make dtbs_check' and see.
>
> You mean the name does not match? I thought that '#' is a comment in YAML...

No, the number of compatible strings is the problem.

> The dtbs_check fail on missing dt-mk-schema. Any reason why it is not
> in the scripts?

Because it is not just that script, but the whole project of scripts,
schemas and meta-schemas. Read the instructions in
Documentation/devicetree/writing-schema.md(.rst in next).

Rob
