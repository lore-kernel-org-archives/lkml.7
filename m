Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4416DC3A589
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 13:44:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13E402133F
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 13:44:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565876651;
	bh=BdDVze++kobDRbQfo5kqbHuTszHekzFi8W8/Yee/97U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=HGu9yJrQ6i7B9PkGUdb/y1qp0HDY7ajc57pESUFbF6oWczcu43SVV4fCjASzURfvp
	 kR/gfWF47Vlh/S20aRzqrY7/Sy5og2qtVDAq7J4qT48ycbEK/3XA+etIBz8JyIiq6n
	 ElxsovIJpa3u4Unac4i+uPoERDrqNvFDrbZFGCho=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732447AbfHONoK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 09:44:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:37894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732183AbfHONoK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 09:44:10 -0400
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 96B812171F;
        Thu, 15 Aug 2019 13:44:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565876648;
        bh=BdDVze++kobDRbQfo5kqbHuTszHekzFi8W8/Yee/97U=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=pSaQFREKkeHL2Eq2UHzL1H+omLTGRR59RyTv7RVzaQqKh/Vsl+yXDjNqt4c6SILoD
         T5nICWxrzV4iiuHn+hCN5ct9b39FYXXpkRMQ8MmLCkDHFtBEF0nyy30KLeODbmjtto
         3qHIZICqRAJtFkIpmOqkx2YSRtcgtwaEYwrAhfkg=
Received: by mail-qk1-f173.google.com with SMTP id 201so1816130qkm.9;
        Thu, 15 Aug 2019 06:44:08 -0700 (PDT)
X-Gm-Message-State: APjAAAWnlKl7u06j46uUWkeejVJgNkn1hyJqGr+CZYxUzMFCJdqQxKJa
        BXfN6HLIKdIEDH33xXcbQfgaYykvAcq4LBLItA==
X-Google-Smtp-Source: APXvYqxC9xQ6Q1ocGYRDuxKbiP6NP21p0YyDQx2l9SALQGFg6LxmBR43l1CbQ66Q0ERY868FfWbPmxkSODG7cJUnq5g=
X-Received: by 2002:a37:a010:: with SMTP id j16mr4193785qke.152.1565876647784;
 Thu, 15 Aug 2019 06:44:07 -0700 (PDT)
MIME-Version: 1.0
References: <1563954573-370205-1-git-send-email-s.riedmueller@phytec.de>
 <20190813160448.GA27548@bogus> <073f9466-9dd3-a22c-e000-e9f4c60f90a0@phytec.de>
In-Reply-To: <073f9466-9dd3-a22c-e000-e9f4c60f90a0@phytec.de>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 15 Aug 2019 07:43:56 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJHfVDfpC9Yr7o3HO4wU7QR+sp0mxFLkxwVcGXXLeAyJw@mail.gmail.com>
Message-ID: <CAL_JsqJHfVDfpC9Yr7o3HO4wU7QR+sp0mxFLkxwVcGXXLeAyJw@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: arm: fsl: Add PHYTEC i.MX6 UL/ULL
 devicetree bindings
To:     =?UTF-8?Q?Stefan_Riedm=C3=BCller?= <s.riedmueller@phytec.de>
Cc:     "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, Fabio Estevam <festevam@gmail.com>,
        Andrew Smirnov <andrew.smirnov@gmail.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        NXP Linux Team <linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 15, 2019 at 4:55 AM Stefan Riedm=C3=BCller
<s.riedmueller@phytec.de> wrote:
>
> Hi Rob,
>
> On 13.08.19 18:04, Rob Herring wrote:
> > On Wed, Jul 24, 2019 at 09:49:32AM +0200, Stefan Riedmueller wrote:
> >> Add devicetree bindings for i.MX6 UL/ULL based phyCORE-i.MX6 UL/ULL an=
d
> >> phyBOARD-Segin.
> >>
> >> Signed-off-by: Stefan Riedmueller <s.riedmueller@phytec.de>
> >> ---
> >>   Documentation/devicetree/bindings/arm/fsl.yaml | 8 ++++++++
> >>   1 file changed, 8 insertions(+)
> >>
> >> diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Document=
ation/devicetree/bindings/arm/fsl.yaml
> >> index 7294ac36f4c0..40f007859092 100644
> >> --- a/Documentation/devicetree/bindings/arm/fsl.yaml
> >> +++ b/Documentation/devicetree/bindings/arm/fsl.yaml
> >> @@ -161,12 +161,20 @@ properties:
> >>           items:
> >>             - enum:
> >>                 - fsl,imx6ul-14x14-evk      # i.MX6 UltraLite 14x14 EV=
K Board
> >> +              - phytec,imx6ul-pbacd10     # PHYTEC phyBOARD-Segin wit=
h i.MX6 UL
> >> +              - phytec,imx6ul-pbacd10-emmc  # PHYTEC phyBOARD-Segin e=
MMC Kit
> >> +              - phytec,imx6ul-pbacd10-nand  # PHYTEC phyBOARD-Segin N=
AND Kit
> >> +              - phytec,imx6ul-pcl063      # PHYTEC phyCORE-i.MX 6UL
> >
> > This doesn't match what is in the dts files:
> >
> > arch/arm/boot/dts/imx6ul-phytec-pcl063.dtsi:    compatible =3D "phytec,=
imx6ul-pcl063", "fsl,imx6ul";
> > arch/arm/boot/dts/imx6ul-phytec-phyboard-segin-full.dts:      compatibl=
e =3D "phytec,imx6ul-pbacd10", "phytec,imx6ul-pcl063",
> > "fsl,imx6ul";
> > arch/arm/boot/dts/imx6ul-phytec-phyboard-segin.dtsi:    compatible =3D =
"phytec,imx6ul-pbacd-10", "phytec,imx6ul-pcl063",
> > "fsl,imx6ul";
>
> Shawn already applied my patches which rename the compatibles, see
> https://lkml.org/lkml/2019/7/23/42

In any case, it still doesn't match. For example, from those patches:

+ model =3D "PHYTEC phyBOARD-Segin i.MX6 ULL Full Featured with eMMC";
+ compatible =3D "phytec,imx6ull-pbacd10-emmc", "phytec,imx6ull-pbacd10",
+     "phytec,imx6ull-pcl063","fsl,imx6ull";

The correct schema for this would be:

items:
  - const: phytec,imx6ull-pbacd10-emmc
  - const: phytec,imx6ull-pbacd10
  - const: phytec,imx6ull-pcl063
  - const: fsl,imx6ull

This defines how many entries (4), what they are, and the order of
them. Maybe the first entry can be an enum with the -nand compatible
if those are 2 options.

Run 'make dtbs_check' and make sure there aren't warnings for the root node=
.

Rob
