Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 630F5C33C9E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 16:17:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39EDB214D8
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 16:17:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578413830;
	bh=TcK/7aE4Lb5IQGTN4l832m41faNVf2PC5yZ/92fqI2A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=s4mA3C6eXdfE+vCbO0hAgimBaz3IA15LwDnAeJqCVBKNKMgBWisx7kLCltfkoqP6D
	 sHefZ9d0JSjZCvDijgw0OTEqb6PvnIcRPGAcfhVfCwHrTegoQ3dZ55atYvyi89I1DV
	 f8r8k3t8wDtLCv4eQ9N+iKlfS59OowiTB/PuB5NM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728352AbgAGQRJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 11:17:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:51238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728020AbgAGQRJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 11:17:09 -0500
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E49AE2087F;
        Tue,  7 Jan 2020 16:17:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578413828;
        bh=TcK/7aE4Lb5IQGTN4l832m41faNVf2PC5yZ/92fqI2A=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=MtXDAItdlR0w7BtO9nkPqbz8JjRbHTxkmI6J3QHqdH99i8TS81f1ggDuImhedCVwQ
         cocox4EgDVcMOxxMWJ+aP83KffqYb2WhqpOFDst2PKEBTpojXcr/YtO8kSHpIx8VxK
         DIq8qyPOa8nqN9mHhbrwf7AeFOStpWTYU80Tkrms=
Received: by mail-qt1-f180.google.com with SMTP id w47so232430qtk.4;
        Tue, 07 Jan 2020 08:17:07 -0800 (PST)
X-Gm-Message-State: APjAAAViIElWJOAKvYIkupkmQfdQtnU3qzWguGry4R154Uwdr17BDuYx
        PJOKXg4BBxQuBOg4Vvm2KUFNsnBys5MaJzTNzA==
X-Google-Smtp-Source: APXvYqxu6QS6UEy/ATbaU7VuwfNWuBF7IRyea4pEzngRlZmCRsIAC/DS1RwMyWEY7uG3GrUoCz0vxhPI3sFuOGops/M=
X-Received: by 2002:ac8:1415:: with SMTP id k21mr65903534qtj.300.1578413827079;
 Tue, 07 Jan 2020 08:17:07 -0800 (PST)
MIME-Version: 1.0
References: <20191230231953.29646-1-rjones@gateworks.com> <20191230231953.29646-2-rjones@gateworks.com>
 <20200103223225.GB654@bogus> <CALAE=UATZtN47J421Y4i+GqvijiiECAuc25kLSmYNAe6jGhxiA@mail.gmail.com>
In-Reply-To: <CALAE=UATZtN47J421Y4i+GqvijiiECAuc25kLSmYNAe6jGhxiA@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 7 Jan 2020 10:16:52 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKmCeKw4ErVGMeLCvZvvHp2Z4qkUswV=aDN1hjb6-x0Aw@mail.gmail.com>
Message-ID: <CAL_JsqKmCeKw4ErVGMeLCvZvvHp2Z4qkUswV=aDN1hjb6-x0Aw@mail.gmail.com>
Subject: Re: [PATCH v5 1/5] dt-bindings: arm: fsl: Add Gateworks Ventana
 i.MX6DL/Q compatibles
To:     Bobby Jones <rjones@gateworks.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 6, 2020 at 3:25 PM Bobby Jones <rjones@gateworks.com> wrote:
>
> On Fri, Jan 3, 2020 at 2:32 PM Rob Herring <robh@kernel.org> wrote:
> >
> > On Mon, Dec 30, 2019 at 03:19:49PM -0800, Robert Jones wrote:
> > > Add the compatible enum entries for Gateworks Ventana boards.
> > >
> > > Signed-off-by: Robert Jones <rjones@gateworks.com>
> > > ---
> > >  Documentation/devicetree/bindings/arm/fsl.yaml | 31 ++++++++++++++++++++++++++
> > >  1 file changed, 31 insertions(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
> > > index f79683a..8ed4c85 100644
> > > --- a/Documentation/devicetree/bindings/arm/fsl.yaml
> > > +++ b/Documentation/devicetree/bindings/arm/fsl.yaml
> > > @@ -126,6 +126,22 @@ properties:
> > >                - toradex,apalis_imx6q-ixora      # Apalis iMX6 Module on Ixora
> > >                - toradex,apalis_imx6q-ixora-v1.1 # Apalis iMX6 Module on Ixora V1.1
> > >                - variscite,dt6customboard
> > > +              - gw,ventana                # Gateworks i.MX6DL or i.MX6Q Ventana
> > > +              - gw,imx6q-gw51xx
> >
> > This doesn't match what you have in dts files. Please check with:
> >
> > make dtbs_check DT_SCHEMA_FILES=Documentation/devicetree/bindings/arm/fsl.yaml
> >
> > You'll need a separate entry with 3 compatibles and 'gw,ventana' or drop
> > it.
>
> Hi Rob,
>
> Sorry, I'm still getting used to the whole schema format and a bit
> confused. Can you be more specific in how it doesn't match? I looked
> at the imx6q-gw51xx.dts file where I got the entry from and it has the
> following line:
>
> compatible = "gw,imx6q-gw51xx", "gw,ventana", "fsl,imx6q";

As written, the schema would not allow this, but would allow one of these:

"gw,imx6q-gw51xx", "fsl,imx6q"
"gw,ventana", "fsl,imx6q"

The 'items' schema allows for 2 entries. So if you want/need to
support 3 entries for compatible, you need a new 'items' schema with 3
entries:

items:
  - enum:
      - gw,imx6q-gw51xx
      - ... all the other boards listed below
  - const: gw,ventana
  - enum:
      - fsl,imx6dl
      - fsl,imx6q

> Obviously I'm only submitting the gw59xx board device trees but a
> previous version of this submission was asked to add all of the
> compatible strings for the Gateworks boards. Are you asking me to only
> post the gw59xx lines?

That's an orthogonal issue which I'll leave to the i.MX maintainers.

> >
> > > +              - gw,imx6q-gw52xx
> > > +              - gw,imx6q-gw53xx
> > > +              - gw,imx6q-gw5400-a
> > > +              - gw,imx6q-gw54xx
> > > +              - gw,imx6q-gw551x
> > > +              - gw,imx6q-gw552x
> > > +              - gw,imx6q-gw553x
> > > +              - gw,imx6q-gw560x
> > > +              - gw,imx6q-gw5903
> > > +              - gw,imx6q-gw5904
> > > +              - gw,imx6q-gw5907
> > > +              - gw,imx6q-gw5910
> > > +              - gw,imx6q-gw5912
> > > +              - gw,imx6q-gw5913
> > >            - const: fsl,imx6q
> > >
> > >        - description: i.MX6QP based Boards
> > > @@ -152,6 +168,21 @@ properties:
> > >                - ysoft,imx6dl-yapp4-draco  # i.MX6 DualLite Y Soft IOTA Draco board
> > >                - ysoft,imx6dl-yapp4-hydra  # i.MX6 DualLite Y Soft IOTA Hydra board
> > >                - ysoft,imx6dl-yapp4-ursa   # i.MX6 Solo Y Soft IOTA Ursa board
> > > +              - gw,ventana                # Gateworks i.MX6DL or i.MX6Q Ventana
> > > +              - gw,imx6dl-gw51xx
> > > +              - gw,imx6dl-gw52xx
> > > +              - gw,imx6dl-gw53xx
> > > +              - gw,imx6dl-gw54xx
> > > +              - gw,imx6dl-gw551x
> > > +              - gw,imx6dl-gw552x
> > > +              - gw,imx6dl-gw553x
> > > +              - gw,imx6dl-gw560x
> > > +              - gw,imx6dl-gw5903
> > > +              - gw,imx6dl-gw5904
> > > +              - gw,imx6dl-gw5907
> > > +              - gw,imx6dl-gw5910
> > > +              - gw,imx6dl-gw5912
> > > +              - gw,imx6dl-gw5913
> > >            - const: fsl,imx6dl
> > >
> > >        - description: i.MX6SL based Boards
> > > --
> > > 2.9.2
> > >
