Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B038EC76188
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 06:34:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E8582173B
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 06:34:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QSOwOufE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbfGSGet (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 02:34:49 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35060 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726067AbfGSGes (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 02:34:48 -0400
Received: by mail-wr1-f67.google.com with SMTP id y4so31062318wrm.2;
        Thu, 18 Jul 2019 23:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kMcKTsEVyji+n2fYLtlne8FEnWZcMA2/ktkd0SxT+VI=;
        b=QSOwOufE4zhKaOthPkDk7gWdX3qwYegZikq56s0mkeTwW5vSbnTSAff0lcnACu34zb
         vdRjrjSoxzugWQ5xieksmi9CByUQ5AnlvJvPceiVK6Sma4J2CcItR6GSqE/+xv2rjim9
         hszdEfhJIQs0Cvwusfs52LSo1AccmTUPJozjSty8KUF6cjhaQHqgQxUAgI0dd8a4xTnH
         BZ8cKAEWJkxNC2IOVZ6nJ+kTlghlY5buBFzyqooQ2Jiy3cOwUPAYOLNzB/9wFrTNfb72
         p9dkMyMTd4O6yToPz/j1GJ9UScDq+CL+Hi80pQVbp5CH5uBdZp0mNnDg/VSEYBXXVgOE
         ehYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kMcKTsEVyji+n2fYLtlne8FEnWZcMA2/ktkd0SxT+VI=;
        b=BILJIDFTiLJd6KQpuJOQE9102mtBhs0Gesstd355vEv53pVH5YpninYpuzepLU6/IK
         5qx9irZVuyVpmP6sP65zYReupDmBrFUjWdeG8Sf7qSDk6poCR4pUBrtRC618QuWrnY9Y
         9FdAkTAliSbif+WcdO38zFv/SzRv9r6Wn+f5dH1SHSg87UzteIi+PSgMqemtVNRbhqq3
         YP4+L+qOsSaXNKcVgq/mj0oX6pYHnK1oYWPWkBfTLPRIepIoKlbhY2qBxtuFeT0QgUtq
         JS8OPQ92ASJfRMRWhf3o35X2F/dCZzoHLQnVKXOHHHZyvYZiF6l+JeXE9GVu/MSXnHZ5
         Nx1Q==
X-Gm-Message-State: APjAAAUTuxFSwkXPusqmSGYuT4NSCRlEa+4gaKO9tspXTaUbOnR7biK8
        lTq5yylCqjo3tcrihqOS+HpQsdYAjL/auJCOiB4=
X-Google-Smtp-Source: APXvYqzkF6gS1MNZBLZ1Ty1LQtpQfLnkNKW7cn72gR9MP8uHzDu7PJQxe2xQB/GaBTVdYHWPDS52KzZOIEH2mFQtBgM=
X-Received: by 2002:a05:6000:14b:: with SMTP id r11mr54574650wrx.196.1563518086309;
 Thu, 18 Jul 2019 23:34:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190718151346.3523-1-daniel.baluta@nxp.com> <20190718151346.3523-4-daniel.baluta@nxp.com>
 <CAL_JsqJ6o9mTjLYjnfcYgfSFKb95W8FseZBBb8RLosB__GNBcw@mail.gmail.com>
 <CAEnQRZBubFz90Xf8irDwc=erTXmByXX4rkzZy9r8ymfAuQEsZA@mail.gmail.com> <VI1PR04MB5055597B7C3AC114FEB7E3E5EEC80@VI1PR04MB5055.eurprd04.prod.outlook.com>
In-Reply-To: <VI1PR04MB5055597B7C3AC114FEB7E3E5EEC80@VI1PR04MB5055.eurprd04.prod.outlook.com>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Fri, 19 Jul 2019 09:34:34 +0300
Message-ID: <CAEnQRZC+LyoZ_C3_0RVgRpBFVMuMT26KPVZunqqNKC=OJcERog@mail.gmail.com>
Subject: Re: [PATCH 3/3] dt-bindings: dsp: fsl: Add DSP core binding support
To:     Leonard Crestez <leonard.crestez@nxp.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "S.j. Wang" <shengjiu.wang@nxp.com>,
        Paul Olaru <paul.olaru@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Anson Huang <anson.huang@nxp.com>, Peng Fan <peng.fan@nxp.com>,
        Frank Li <frank.li@nxp.com>,
        Devicetree List <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "sound-open-firmware@alsa-project.org" 
        <sound-open-firmware@alsa-project.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 18, 2019 at 9:40 PM Leonard Crestez <leonard.crestez@nxp.com> wrote:
>
> On 18.07.2019 21:24, Daniel Baluta wrote:
> > On Thu, Jul 18, 2019 at 7:41 PM Rob Herring <robh+dt@kernel.org> wrote:
> >>
> >> On Thu, Jul 18, 2019 at 9:13 AM Daniel Baluta <daniel.baluta@nxp.com> wrote:
> >>>
> >>> This describes the DSP device tree node.
> >>>
> >>> Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
>
> >>> +  power-domains:
> >>> +    description:
> >>> +      List of phandle and PM domain specifier as documented in
> >>> +      Documentation/devicetree/bindings/power/power_domain.txt
> >>
> >> How many? 4?
> >
> > Yes, 4 for i.MX8QXP. Also, the same number is for i.MX8QM. Anyhow, I didn't
> > added added a limit here because I really don't know how many will be
> > in upcoming i.MX platforms.
>
> Which 4? It might help to use power-domain-names explicitly just like
> it's done for clocks and mboxes.
>
> This is very common for phandle lists.

4 like in the example at the bottom of the patch:

+   power-domains = <&pd IMX_SC_R_MU_13A>,
+                        <&pd IMX_SC_R_MU_13B>,
+                        <&pd IMX_SC_R_DSP>,
+                        <&pd IMX_SC_R_DSP_RAM>;

Not sure if it makes sense to use power-domain-names as the driver parses
directly the "power-domains" property.
