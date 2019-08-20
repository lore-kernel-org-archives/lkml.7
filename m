Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 896B3C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 20:21:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C19D22D6D
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 20:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566332509;
	bh=k3IX6GrfawQ+iRR0MAlRLvAXDxfqKY45TERMBueY7qU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=S4z6IuSBxFTcDS4DEwiprtcVfYk2xr3gqykfu5akS+EmPfzkVo8KUvLk9x6a9ftOX
	 cBTIOIBWiM135VvypE3YJGCt49iQwVVhYJo60ILnBnarIH4kBEG4p0eHxGenhNdTqM
	 cw05wZaOvwISOlfzT525VVOi78S/Wuy5/Z7NWUTU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730680AbfHTUVs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 16:21:48 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37325 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730092AbfHTUVs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 16:21:48 -0400
Received: by mail-wr1-f65.google.com with SMTP id z11so13697671wrt.4;
        Tue, 20 Aug 2019 13:21:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=r3oQd3uU78t7jol5OH8zsEKRAT1+YNvIt09DwZoiSlQ=;
        b=BXj6+jxYGHxugtXVZwsoR6k0/wt7d72eVsvAXplVzY1QXMTb6JYOBgXAL62VM4aY3J
         d3hgJOe0FUoSu0UcQHZLkJ0UpUm7i4F6o68AOkIJoUarbJFPvj0bMeaiTAYDdn6xcBG4
         PjpUPHYCVGNEJ0s4EFvH6lXdyhzukuImjhIAKtqEWX4pv+n7g4rvFrWryoZduQgfu4ki
         VxwiQANOyYJlICaBkWy0MuwgkEN5eZnPX7Bp8InmJ7D5B4pNLtMDkLaRigOgxudtIyNA
         M+uOkWDX7SFC1/P/5AKz8xyZlbzWwoSpljryyIlyJZuk8NNRUL6o+Wg+akH6mFUt6Rqn
         wBUA==
X-Gm-Message-State: APjAAAUu95UBSWYFxp98BMhK4v5e7NHf4cX5tt08i8XSWS2S5rNT/ICB
        M96In3p4zjiRk5Evdt8KA00=
X-Google-Smtp-Source: APXvYqwqYsz8ttcqaewkZkkOJpX4/RTeqO4MzB+KxEbH1U4y9n7I3g2XwPfP8FXlpiiZdiIdPZbsMQ==
X-Received: by 2002:adf:e94e:: with SMTP id m14mr38108277wrn.230.1566332505727;
        Tue, 20 Aug 2019 13:21:45 -0700 (PDT)
Received: from kozik-lap ([194.230.155.124])
        by smtp.googlemail.com with ESMTPSA id c187sm1943526wmd.39.2019.08.20.13.21.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 20 Aug 2019 13:21:45 -0700 (PDT)
Date:   Tue, 20 Aug 2019 22:21:42 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
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
Subject: Re: [PATCH v6 3/4] dt-bindings: arm: fsl: Add Kontron i.MX6UL N6310
 compatibles
Message-ID: <20190820202142.GA15866@kozik-lap>
References: <1566315318-30320-1-git-send-email-krzk@kernel.org>
 <1566315318-30320-3-git-send-email-krzk@kernel.org>
 <CAL_JsqJLSZ50tdFcdPFc2ifcDoFZFuw=SoKsunzjtAhZ-11fBg@mail.gmail.com>
 <CAJKOXPfkNcWw9sunwXGRz42jOL0cdRC-iiHLtWCYvo5oxCMwFQ@mail.gmail.com>
 <CAL_JsqKAH6n1sMoWOhfiHKxgREr-EN1tw0QtC1H8Fm=a7PNzOA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAL_JsqKAH6n1sMoWOhfiHKxgREr-EN1tw0QtC1H8Fm=a7PNzOA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 20, 2019 at 03:04:57PM -0500, Rob Herring wrote:
> On Tue, Aug 20, 2019 at 1:36 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> >
> > On Tue, 20 Aug 2019 at 18:59, Rob Herring <robh+dt@kernel.org> wrote:
> > >
> > > On Tue, Aug 20, 2019 at 10:35 AM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> > > >
> > > > Add the compatibles for Kontron i.MX6UL N6310 SoM and boards.
> > > >
> > > > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> > > >
> > > > ---
> > > >
> > > > Changes since v5:
> > > > New patch
> > > > ---
> > > >  Documentation/devicetree/bindings/arm/fsl.yaml | 3 +++
> > > >  1 file changed, 3 insertions(+)
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
> > > > index 7294ac36f4c0..d07b3c06d7cf 100644
> > > > --- a/Documentation/devicetree/bindings/arm/fsl.yaml
> > > > +++ b/Documentation/devicetree/bindings/arm/fsl.yaml
> > > > @@ -161,6 +161,9 @@ properties:
> > > >          items:
> > > >            - enum:
> > > >                - fsl,imx6ul-14x14-evk      # i.MX6 UltraLite 14x14 EVK Board
> > > > +              - kontron,imx6ul-n6310-som  # Kontron N6310 SOM
> > > > +              - kontron,imx6ul-n6310-s    # Kontron N6310 S Board
> > > > +              - kontron,imx6ul-n6310-s-43 # Kontron N6310 S 43 Board
> > >
> > > This doesn't match what is in your dts files. Run 'make dtbs_check' and see.
> >
> > You mean the name does not match? I thought that '#' is a comment in YAML...
> 
> No, the number of compatible strings is the problem.

I see. If I understand the schema correctly, this should look like:

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 7294ac36f4c0..eb263d1ccf13 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -161,6 +161,22 @@ properties:
         items:
           - enum:
               - fsl,imx6ul-14x14-evk      # i.MX6 UltraLite 14x14 EVK Board
+              - kontron,imx6ul-n6310-som  # Kontron N6310 SOM
+          - const: fsl,imx6ul
+
+      - description: Kontron N6310 S Board
+        items:
+          - enum:
+              - kontron,imx6ul-n6310-s
+          - const: kontron,imx6ul-n6310-som
+          - const: fsl,imx6ul
+
+      - description: Kontron N6310 S 43 Board
+        items:
+          - enum:
+              - kontron,imx6ul-n6310-s-43
+          - const: kontron,imx6ul-n6310-s
+          - const: kontron,imx6ul-n6310-som
           - const: fsl,imx6ul

       - description: i.MX6ULL based Boards


It passes the dtbs_check. Is it correct?

Best regards,
Krzysztof

