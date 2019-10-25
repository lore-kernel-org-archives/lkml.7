Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36BE3CA9EBC
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 13:07:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 170AC2084C
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 13:07:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504728AbfJYNHS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 09:07:18 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:36179 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2440294AbfJYNHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 09:07:17 -0400
Received: by mail-ot1-f66.google.com with SMTP id c7so2043151otm.3;
        Fri, 25 Oct 2019 06:07:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cjIHQSLxAfrO8r2mYhvtTFdVGXGSg2sOMWkk/+SphrE=;
        b=qKyYZu//ola0l74wKrpCXJ8hPsd2wrypyXnUv9YlDHhKVgUtocVacIEFrVdrPqaUJH
         x++6W2rYpqCDAVB+7Z30Ck37xWCuXPK2A9qpP6LH154PFnCgTU9t1ift3+25Uh63RzjZ
         CJglZJ2M/vb2Uf4Lj7+8NC3kvZn6WEv28bziqn7svyBPtIW4xVlmcsPZtwqAAr0SSe4v
         jAiblXFoZMh1oSCSbAaPTiLcsVxO2KqibSFcwO75gJ02t8tcKE+F2GH6iG119FEq726j
         WIZpwId7fiJ2H/3bIQSphKe0lm/3fxrPOFPSKNo8YFfg7QpMHo+ZbkPZvmHUXfDSToJK
         Hpkw==
X-Gm-Message-State: APjAAAWubfaFRlp27Xm8BG9zNdrbjXdo6EKBSyAycCrUpQ0vSnYmIW+p
        J+ictOtQw55ADqYmurotUctScn0cuzZ+DwkD092PB3ty
X-Google-Smtp-Source: APXvYqzGKbCyS1szfG8o0X910Fume/955nA8LLrYOuI11vgDmVi+31XMEhVH1S52qFAbuu9uH8/7k1ix9oNIdKm0vB4=
X-Received: by 2002:a9d:6e10:: with SMTP id e16mr2735573otr.297.1572008835268;
 Fri, 25 Oct 2019 06:07:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190705164221.4462-1-robh@kernel.org> <20190705164221.4462-2-robh@kernel.org>
In-Reply-To: <20190705164221.4462-2-robh@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 25 Oct 2019 15:07:04 +0200
Message-ID: <CAMuHMdW86UOVp5vjdFBzjbqsG_wemjZ77LyVnc+oZ6ZDccv_cA@mail.gmail.com>
Subject: Re: [PATCH v3 01/13] dt-bindings: display: Convert common panel
 bindings to DT schema
To:     Rob Herring <robh@kernel.org>
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

Hi Rob,

On Fri, Jul 5, 2019 at 6:46 PM Rob Herring <robh@kernel.org> wrote:
> Convert the common panel bindings to DT schema consolidating scattered
> definitions to a single schema file.
>
> The 'simple-panel' binding just a collection of properties and not a
> complete binding itself. All of the 'simple-panel' properties are
> covered by the panel-common.txt binding with the exception of the
> 'no-hpd' property, so add that to the schema.
>
> As there are lots of references to simple-panel.txt, just keep the file
> with a reference to common.yaml for now until all the bindings are
> converted.
>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Cc: dri-devel@lists.freedesktop.org
> Acked-by: Sam Ravnborg <sam@ravnborg.org>
> Reviewed-by: Maxime Ripard <maxime.ripard@bootlin.com>
> Reviewed-by: Thierry Reding <treding@nvidia.com>
> Signed-off-by: Rob Herring <robh@kernel.org>

This is now commit 821a1f7171aeea5e ("dt-bindings: display: Convert
common panel bindings to DT schema").

> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/panel/panel-common.yaml

> +  backlight:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description:
> +      For panels whose backlight is controlled by an external backlight
> +      controller, this property contains a phandle that references the
> +      controller.

This paragraph seems to apply to all nodes named "backlight", causing
e.g. (for ARCH=arm mach_shmobile_defconfig) "make dtbs_check
DT_SCHEMA_FILES=Documentation/devicetree/bindings/display/panel/panel-common.yaml"
to start complaining:

    arch/arm/boot/dts/r8a7740-armadillo800eva.dt.yaml: backlight:
{'compatible': ['pwm-backlight'], 'pwms': [[40, 2, 33333, 1]],
'brightness-levels': [[0, 1, 2, 4, 8, 16, 32, 64, 128, 255]],
'default-brightness-level': [[9]], 'pinctrl-0': [[41]],
'pinctrl-names': ['default'], 'power-supply': [[42]], 'enable-gpios':
[[15, 61, 0]]} is not of type 'array'
    arch/arm/boot/dts/r8a7740-armadillo800eva.dt.yaml: backlight:
{'groups': ['tpu0_to2_1'], 'function': ['tpu0'], 'phandle': [[41]]} is
not of type 'array'

Do you know what's wrong?

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
