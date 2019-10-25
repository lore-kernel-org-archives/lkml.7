Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2E7ACA9EBC
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 15:00:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B4A221E6F
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 15:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572015616;
	bh=f2yf9WpyouCealS+fktBfB/szXs5aGxga2kI9M3FDlY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=PxABGCt9RClw1REI2XjzT/4l9QxyEX+ToSSZa5NT114KfwwtzB0ipxjhaQs4L1l1M
	 2eRmT9IScnevwff7LMgmpCjL4Y/CsiIePCf4ZhxPBMEIU5TtrpAzqni/NayZh99vxm
	 ethsQdCSJ83lDpfSUIY9RQnLhLgzjJDudkSeOpqw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407800AbfJYPAP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 11:00:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:49306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726168AbfJYPAP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 11:00:15 -0400
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9424D21D7F;
        Fri, 25 Oct 2019 15:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572015613;
        bh=f2yf9WpyouCealS+fktBfB/szXs5aGxga2kI9M3FDlY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=vBpdbmlldWSSg3zELNMATQBvbJ4pmxUC9Vuhdr6ONwQF0+otKu2JdUNPyjKTpBSU9
         vuVJfZuy4wJMlMTVoVLWs7zqUDSnwI1ZB6UsQF2wNz83KjT5pXzlqR/kUsDco828u9
         7Vs4EWkQZqLL9LoT0NDyCOyxcrTaP4tG+/O5YqN8=
Received: by mail-qk1-f174.google.com with SMTP id 71so2054591qkl.0;
        Fri, 25 Oct 2019 08:00:13 -0700 (PDT)
X-Gm-Message-State: APjAAAW8S44J4i4E9+10uNVMusOuYatgiFI8+YgBbIx/bwM2GMngBrpj
        mptlVIHVbnYxbffYiQJxcmgpDo2MorSebVCYSQ==
X-Google-Smtp-Source: APXvYqxyzg3cWltGQSwBHgv+PTKLola2kTTOSA/qAZ8b3mYsCjOEIv9QdBh6RrG2w1dFyen5KJGFCzbPcplD6nP0UcE=
X-Received: by 2002:a05:620a:12b4:: with SMTP id x20mr3443712qki.254.1572015612674;
 Fri, 25 Oct 2019 08:00:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190705164221.4462-1-robh@kernel.org> <20190705164221.4462-2-robh@kernel.org>
 <CAMuHMdW86UOVp5vjdFBzjbqsG_wemjZ77LyVnc+oZ6ZDccv_cA@mail.gmail.com>
 <CAL_JsqJA_ZZ5CjoGrB4NofAcwMPXhnC0ddWZqZ9SXSTNAWB3cQ@mail.gmail.com> <CAMuHMdU-ubE9y3V9W_ij5OFyxNLu0LmdrH88=vkkr6uSAJrTPA@mail.gmail.com>
In-Reply-To: <CAMuHMdU-ubE9y3V9W_ij5OFyxNLu0LmdrH88=vkkr6uSAJrTPA@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 25 Oct 2019 10:00:00 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLDoOQ-E=qh1e-jquKHcNOTSXysQV7RKWYCqPwFtYbdBQ@mail.gmail.com>
Message-ID: <CAL_JsqLDoOQ-E=qh1e-jquKHcNOTSXysQV7RKWYCqPwFtYbdBQ@mail.gmail.com>
Subject: Re: [PATCH v3 01/13] dt-bindings: display: Convert common panel
 bindings to DT schema
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Thierry Reding <treding@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 25, 2019 at 9:39 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Rob,
>
> On Fri, Oct 25, 2019 at 4:25 PM Rob Herring <robh@kernel.org> wrote:
> > On Fri, Oct 25, 2019 at 8:07 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > On Fri, Jul 5, 2019 at 6:46 PM Rob Herring <robh@kernel.org> wrote:
> > > > Convert the common panel bindings to DT schema consolidating scattered
> > > > definitions to a single schema file.
> > > >
> > > > The 'simple-panel' binding just a collection of properties and not a
> > > > complete binding itself. All of the 'simple-panel' properties are
> > > > covered by the panel-common.txt binding with the exception of the
> > > > 'no-hpd' property, so add that to the schema.
> > > >
> > > > As there are lots of references to simple-panel.txt, just keep the file
> > > > with a reference to common.yaml for now until all the bindings are
> > > > converted.
> > > >
> > > > Cc: Thierry Reding <thierry.reding@gmail.com>
> > > > Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > > > Cc: dri-devel@lists.freedesktop.org
> > > > Acked-by: Sam Ravnborg <sam@ravnborg.org>
> > > > Reviewed-by: Maxime Ripard <maxime.ripard@bootlin.com>
> > > > Reviewed-by: Thierry Reding <treding@nvidia.com>
> > > > Signed-off-by: Rob Herring <robh@kernel.org>
> > >
> > > This is now commit 821a1f7171aeea5e ("dt-bindings: display: Convert
> > > common panel bindings to DT schema").
> > >
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/display/panel/panel-common.yaml
> > >
> > > > +  backlight:
> > > > +    $ref: /schemas/types.yaml#/definitions/phandle
> > > > +    description:
> > > > +      For panels whose backlight is controlled by an external backlight
> > > > +      controller, this property contains a phandle that references the
> > > > +      controller.
> > >
> > > This paragraph seems to apply to all nodes named "backlight", causing
> > > e.g. (for ARCH=arm mach_shmobile_defconfig) "make dtbs_check
> > > DT_SCHEMA_FILES=Documentation/devicetree/bindings/display/panel/panel-common.yaml"
> > > to start complaining:
> > >
> > >     arch/arm/boot/dts/r8a7740-armadillo800eva.dt.yaml: backlight:
> > > {'compatible': ['pwm-backlight'], 'pwms': [[40, 2, 33333, 1]],
> > > 'brightness-levels': [[0, 1, 2, 4, 8, 16, 32, 64, 128, 255]],
> > > 'default-brightness-level': [[9]], 'pinctrl-0': [[41]],
> > > 'pinctrl-names': ['default'], 'power-supply': [[42]], 'enable-gpios':
> > > [[15, 61, 0]]} is not of type 'array'
> > >     arch/arm/boot/dts/r8a7740-armadillo800eva.dt.yaml: backlight:
> > > {'groups': ['tpu0_to2_1'], 'function': ['tpu0'], 'phandle': [[41]]} is
> > > not of type 'array'
> > >
> > > Do you know what's wrong?
> >
> > I'm not seeing that. What does .../bindings/processed-schema.yaml look like?
>
> I see it with both next-20191015 and v5.4-rc4.
>
> - $filename: /scratch/geert/linux/linux-next/Documentation/devicetree/bindings/display/panel/panel-common.yaml
>   $id: http://devicetree.org/schemas/display/panel/panel-common.yaml#
>   $schema: http://devicetree.org/meta-schemas/core.yaml#
>   dependencies:
>     height-mm: [width-mm]
>     width-mm: [height-mm]
>   patternProperties: {'pinctrl-[0-9]+': true}
>   properties:
>     $nodename: true
>     backlight: {$ref: /schemas/types.yaml#/definitions/phandle}
>     ddc-i2c-bus: {$ref: /schemas/types.yaml#/definitions/phandle}
>     enable-gpios: {maxItems: 1, minItems: 1}
>     height-mm: {}
>     label: {}
>     no-hpd: {type: boolean}
>     panel-timing: {type: object}
>     phandle: true
>     pinctrl-names: true
>     port: {type: object}
>     ports: {type: object}
>     power-supply: {}
>     reset-gpios: {maxItems: 1, minItems: 1}
>     rotation:
>       allOf:
>       - {$ref: /schemas/types.yaml#/definitions/uint32}
>       - additionalItems: false
>         items:
>           additionalItems: false
>           items:
>             enum: [0, 90, 180, 270]
>           maxItems: 1
>           minItems: 1
>           type: array
>         maxItems: 1
>         minItems: 1
>         type: array
>     status: true
>     width-mm: {}
>   select:
>     properties: {$nodename: true}
>     required: [$nodename]

The problem is this causing the schema to be applied to every node.
Update dtschema repo. This was fixed some time ago.

Rob
