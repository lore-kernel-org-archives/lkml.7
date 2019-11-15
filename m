Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3A3AC43141
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 02:11:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B542206F4
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 02:11:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B5q0wHOf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727222AbfKOCL1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 21:11:27 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:34355 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726399AbfKOCL1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 21:11:27 -0500
Received: by mail-qk1-f196.google.com with SMTP id 205so6926714qkk.1;
        Thu, 14 Nov 2019 18:11:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iwrIjV3rAOWSyJGG0/sIPU9f3LX/vsYsv+fodZVW0cU=;
        b=B5q0wHOfASmZ2Lh14yogezn+rxmdrhLEqWhuNk93pGbwQbaO6sLoWN7peQg5V6zIB6
         KHayoKlXplSk/aAY4eaN8FJ/LAw9ESKXao6PP24mYa/m6e90+PSSO74emOhetwN0BmXu
         x4/s0wWLW7qZEQoT34tbAxMOASITbRC12NeR9YdqxBOuZcoQvxYgnFDcm9j6MATYT+L6
         jXZi8EgW68Tv/u65e1Vh0dJ0TP4SInsfheo6NTaxtuF6qIk0orBHmmXtqCB5djpK2PBl
         5IIP2SiNR3Z/SA2ocdB8O4KPAnhgDXzbHSYDOGXEhLIbfxrZXIrOrXRk3z8Y3LPaiICF
         GjMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iwrIjV3rAOWSyJGG0/sIPU9f3LX/vsYsv+fodZVW0cU=;
        b=NRzz+cBR/kuAcanpMgfleEk6pLGF5FydMMRTXW0he5C7leHwlI2gE1fmJTCsPD/O2D
         E0MbhsyB4W0hjJxp/s/gsqe6JlVEFYAErIWJLuuKoNrGKaj+fakkxDHBgx9h0H3tvnG+
         fv1fuxZssoaV5FNbGv1FWZdDL5enYjaFBZq1owR3gr6n+VXjJX8xgJzHXqrPhX/CfIg2
         qxSVwJzsz3u0EzwSiQ0r53pg08YjaIcUNFLYjMhTGEIP8VhmBbXGYc8oEUNmVcehRbZo
         3GlaX9zmlPZS5O7o6DD6hpA8N++JrnsNupAWEwwO72CoZliPRxKJ7OTp3ea66ykn+E9P
         X4Vg==
X-Gm-Message-State: APjAAAU/kHUgpsG3G9rCxgE5BaLIFZ0VVTuM0IOjDX0FYf1xs0dbAFmW
        Ce/Oo7Q19ufhA3M9eHQvAzEsUz2racBNuxPub0CHM2ffnIfcgQ==
X-Google-Smtp-Source: APXvYqzZHeRcZIgni1l1ogsgH8eDjDju0/cJCQTbsqWiKfxK9978qCLi+jtHTfqk6AqN7EAjBIsCUqRktKpqKTvt5gY=
X-Received: by 2002:a37:a00f:: with SMTP id j15mr10776968qke.103.1573783886106;
 Thu, 14 Nov 2019 18:11:26 -0800 (PST)
MIME-Version: 1.0
References: <b1c922b3496020f611ecd6ea27d262369646d830.1573462647.git.shengjiu.wang@nxp.com>
 <20191114211237.GA25375@bogus>
In-Reply-To: <20191114211237.GA25375@bogus>
From:   Shengjiu Wang <shengjiu.wang@gmail.com>
Date:   Fri, 15 Nov 2019 10:11:14 +0800
Message-ID: <CAA+D8AOfPbS4dn=p+0f8icWBsZegUubJ21qsY7yFw2a=a3Mb_A@mail.gmail.com>
Subject: Re: [alsa-devel] [PATCH V3 1/2] ASoC: dt-bindings: fsl_asrc: add
 compatible string for imx8qm
To:     Rob Herring <robh@kernel.org>
Cc:     Shengjiu Wang <shengjiu.wang@nxp.com>, mark.rutland@arm.com,
        devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        timur@kernel.org, Xiubo.Lee@gmail.com,
        linuxppc-dev@lists.ozlabs.org, tiwai@suse.com, lgirdwood@gmail.com,
        Nicolin Chen <nicoleotsuka@gmail.com>, broonie@kernel.org,
        festevam@gmail.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob

On Fri, Nov 15, 2019 at 5:14 AM Rob Herring <robh@kernel.org> wrote:
>
> On Mon, Nov 11, 2019 at 05:18:22PM +0800, Shengjiu Wang wrote:
> > Add compatible string "fsl,imx8qm-asrc" for imx8qm platform.
> >
> > There are two asrc modules in imx8qm, the clock mapping is
> > different for each other, so add new property "fsl,asrc-clk-map"
> > to distinguish them.
>
> What's the clock mapping?
>
The two asrc have different clock source connected to it,  also
the asrc in other platform, like imx6, has different clock source.

We collect all these clock source together, defined an enumerate
format structure in driver, so for the asrc in each platform, we
need to remap the clock source from the enumerate index to
the real connection index in hardware.

The range of  the enumerate structure is 0-0x30, some index
may not be used in this platform, but used in other platform
the range of the real connection range is 0-0xf, so we do
the remapping for [0, 0x30]  to [0, 0xf]

>
> > Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> > ---
> > changes in v2
> > -none
> >
> > changes in v3
> > -use only one compatible string "fsl,imx8qm-asrc",
> > -add new property "fsl,asrc-clk-map".
> >
> >  Documentation/devicetree/bindings/sound/fsl,asrc.txt | 10 +++++++++-
> >  1 file changed, 9 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/devicetree/bindings/sound/fsl,asrc.txt b/Documentation/devicetree/bindings/sound/fsl,asrc.txt
> > index 1d4d9f938689..02edab7cf3e0 100644
> > --- a/Documentation/devicetree/bindings/sound/fsl,asrc.txt
> > +++ b/Documentation/devicetree/bindings/sound/fsl,asrc.txt
> > @@ -8,7 +8,8 @@ three substreams within totally 10 channels.
> >
> >  Required properties:
> >
> > -  - compatible               : Contains "fsl,imx35-asrc" or "fsl,imx53-asrc".
> > +  - compatible               : Contains "fsl,imx35-asrc", "fsl,imx53-asrc",
> > +                       "fsl,imx8qm-asrc".
> >
> >    - reg                      : Offset and length of the register set for the device.
> >
> > @@ -35,6 +36,13 @@ Required properties:
> >
> >     - fsl,asrc-width  : Defines a mutual sample width used by DPCM Back Ends.
> >
> > +   - fsl,asrc-clk-map   : Defines clock map used in driver. which is required
> > +                       by imx8qm/imx8qxp platform
> > +                       <0> - select the map for asrc0 in imx8qm
> > +                       <1> - select the map for asrc1 in imx8qm
> > +                       <2> - select the map for asrc0 in imx8qxp
> > +                       <3> - select the map for asrc1 in imx8qxp
>
> Is this 4 modes of the h/w or just selecting 1 of 4 settings defined in
> the driver? How does one decide? This seems strange.

The setting is defined in driver.  please see the following definition in
driver.  This is some kind of hard code, for the asrc0 in imx8qm,
we need to set fsl,asrc-clk-map = 0.

+/**
+ * i.MX8QM/i.MX8QXP uses the same map for input and output.
+ * clk_map_imx8qm[0] is for i.MX8QM asrc0
+ * clk_map_imx8qm[1] is for i.MX8QM asrc1
+ * clk_map_imx8qm[2] is for i.MX8QXP asrc0
+ * clk_map_imx8qm[3] is for i.MX8QXP asrc1
+ */
+static unsigned char clk_map_imx8qm[4][ASRC_CLK_MAP_LEN] = {


>
> imx8qxp should perhaps be a separate compatible. Then you only need 1 of
> 2 modes...
>
Yes, that is an option.  If you agree that we can use fsl,asrc-clk-map to
distinguish the clock mapping defined in driver,  I can do this change that
add new compatible string for imx8qxp.


Best Regards
Wang Shengjiu
