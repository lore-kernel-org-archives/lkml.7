Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5D78CA9EBD
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 14:26:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADD0F21655
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 14:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572013560;
	bh=DU7fSFJ7Tbm2ALQlO0YChij89rQy5SaOWUBg7BPLtqY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=EgkVUsketM/HA/bhRBy9P9pOqbtE+LEVwSwG19xs9kxMhga4Vr0GkerUOlULtsuXS
	 zM3cL49I/LsfWFxzIZA3MLj5ff2eWRo7c3UOO+NTdDYlrrG/fCeYghvuWJ4D0ddTk6
	 RSIMsRvr5M6c5l+EPGfphD5I9Zar9WbJw1Ox1vps=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395373AbfJYOZ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 10:25:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:40906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2395358AbfJYOZy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 10:25:54 -0400
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B21D6222C1;
        Fri, 25 Oct 2019 14:25:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572013552;
        bh=DU7fSFJ7Tbm2ALQlO0YChij89rQy5SaOWUBg7BPLtqY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=lls4C6GhAMZkjiMHxUNM8e3MpVtTjHRcp7rtbeWxNU6wPCOgmjE3zkRA3BaLtvaMu
         Ik1lbhOO5WwIWedKrjVgJYkBqK0RyKpoQxLvxyz5dqKrbrzgU/En4i9HWrJoKn8Xec
         mU9sGQ/QhVMGbMoSZaRbAqSBj0FGKs5gqZfGPCOg=
Received: by mail-qt1-f171.google.com with SMTP id r5so3545969qtd.0;
        Fri, 25 Oct 2019 07:25:52 -0700 (PDT)
X-Gm-Message-State: APjAAAWv9kXSGcLQHmxNmIBYseNidlOOwCLmGapkoXxClHjEZYBO6900
        TRXOLZtPVMHe/Oe1LSWC/PhVaxt+5HYrQcBPdQ==
X-Google-Smtp-Source: APXvYqyHGFuHzLeeCiWmC38AWf47YzHtjUGWCvnVQnR7njmNGQzh6atSkOGaDQVT1lTzgwxR3JWh+i3JbBURQZyByQQ=
X-Received: by 2002:a05:6214:1552:: with SMTP id t18mr3275282qvw.136.1572013551842;
 Fri, 25 Oct 2019 07:25:51 -0700 (PDT)
MIME-Version: 1.0
References: <20190705164221.4462-1-robh@kernel.org> <20190705164221.4462-2-robh@kernel.org>
 <CAMuHMdW86UOVp5vjdFBzjbqsG_wemjZ77LyVnc+oZ6ZDccv_cA@mail.gmail.com>
In-Reply-To: <CAMuHMdW86UOVp5vjdFBzjbqsG_wemjZ77LyVnc+oZ6ZDccv_cA@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 25 Oct 2019 09:25:39 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJA_ZZ5CjoGrB4NofAcwMPXhnC0ddWZqZ9SXSTNAWB3cQ@mail.gmail.com>
Message-ID: <CAL_JsqJA_ZZ5CjoGrB4NofAcwMPXhnC0ddWZqZ9SXSTNAWB3cQ@mail.gmail.com>
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

On Fri, Oct 25, 2019 at 8:07 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Rob,
>
> On Fri, Jul 5, 2019 at 6:46 PM Rob Herring <robh@kernel.org> wrote:
> > Convert the common panel bindings to DT schema consolidating scattered
> > definitions to a single schema file.
> >
> > The 'simple-panel' binding just a collection of properties and not a
> > complete binding itself. All of the 'simple-panel' properties are
> > covered by the panel-common.txt binding with the exception of the
> > 'no-hpd' property, so add that to the schema.
> >
> > As there are lots of references to simple-panel.txt, just keep the file
> > with a reference to common.yaml for now until all the bindings are
> > converted.
> >
> > Cc: Thierry Reding <thierry.reding@gmail.com>
> > Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > Cc: dri-devel@lists.freedesktop.org
> > Acked-by: Sam Ravnborg <sam@ravnborg.org>
> > Reviewed-by: Maxime Ripard <maxime.ripard@bootlin.com>
> > Reviewed-by: Thierry Reding <treding@nvidia.com>
> > Signed-off-by: Rob Herring <robh@kernel.org>
>
> This is now commit 821a1f7171aeea5e ("dt-bindings: display: Convert
> common panel bindings to DT schema").
>
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/display/panel/panel-common.yaml
>
> > +  backlight:
> > +    $ref: /schemas/types.yaml#/definitions/phandle
> > +    description:
> > +      For panels whose backlight is controlled by an external backlight
> > +      controller, this property contains a phandle that references the
> > +      controller.
>
> This paragraph seems to apply to all nodes named "backlight", causing
> e.g. (for ARCH=arm mach_shmobile_defconfig) "make dtbs_check
> DT_SCHEMA_FILES=Documentation/devicetree/bindings/display/panel/panel-common.yaml"
> to start complaining:
>
>     arch/arm/boot/dts/r8a7740-armadillo800eva.dt.yaml: backlight:
> {'compatible': ['pwm-backlight'], 'pwms': [[40, 2, 33333, 1]],
> 'brightness-levels': [[0, 1, 2, 4, 8, 16, 32, 64, 128, 255]],
> 'default-brightness-level': [[9]], 'pinctrl-0': [[41]],
> 'pinctrl-names': ['default'], 'power-supply': [[42]], 'enable-gpios':
> [[15, 61, 0]]} is not of type 'array'
>     arch/arm/boot/dts/r8a7740-armadillo800eva.dt.yaml: backlight:
> {'groups': ['tpu0_to2_1'], 'function': ['tpu0'], 'phandle': [[41]]} is
> not of type 'array'
>
> Do you know what's wrong?

I'm not seeing that. What does .../bindings/processed-schema.yaml look like?

Rob
