Return-Path: <SRS0=E66v=2U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3FA0C2D0D3
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 17:53:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDB4120730
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 17:53:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577728386;
	bh=qiX/ki1VZ10dHl+G3bmaxWsgUgJaJdPyetC5TOSqHeo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=sy3sLnPhYVUniUDuBnrtkAzn+FQ2VOpZH2a148fFfZxNnEfYjQym2jIDfS9IK+MGV
	 tK+ndTVFp9eC+FVlyTxgrIjjf3yuZYMYw5OjOSXK2DrFz9FOd/UkiPuT+z+Ytz49V4
	 KR02PE8S9m5FQR4Fbt3XDrNYaVK5pySlO+sPzMSQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727537AbfL3RxG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Dec 2019 12:53:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:56460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726602AbfL3RxF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Dec 2019 12:53:05 -0500
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A2363207E0;
        Mon, 30 Dec 2019 17:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577728384;
        bh=qiX/ki1VZ10dHl+G3bmaxWsgUgJaJdPyetC5TOSqHeo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=fYlbAl/999Il/xXeYC00+VWL3M154DKx/6rNFXomPd20BDV31BDm0LjotziGAJsGw
         X2TK1VOOtFUnn7NY/8sgs5AqG4MKsV8kdTc5raNXboKso5z0AcnpUGgBNYJ6wXnUW7
         xQAmwkL4nWfGUohfqQwBwXkzdchfKpy6l4EBiYUc=
Received: by mail-qt1-f174.google.com with SMTP id w47so30111475qtk.4;
        Mon, 30 Dec 2019 09:53:04 -0800 (PST)
X-Gm-Message-State: APjAAAUJnCsrcDlgWTtA1Vl6GGY5291kjjVs4Btx12qYKEQDIy4EuqZf
        0vn0DJwuZcxq7/pLnEyskco2w+0kErhTFRshrg==
X-Google-Smtp-Source: APXvYqyaZydxwFW02BlCZCg9ra5E5cTvKaoWIYuHbN3644YIXtRs5mhdInVI5/ETrktTRqg3jjzf+amLHcIDIwstXic=
X-Received: by 2002:ac8:59:: with SMTP id i25mr49935662qtg.110.1577728383766;
 Mon, 30 Dec 2019 09:53:03 -0800 (PST)
MIME-Version: 1.0
References: <20191224010020.15969-1-rjones@gateworks.com> <20191224010020.15969-2-rjones@gateworks.com>
 <20191226232625.GA2186@bogus> <CAOMZO5Aj+PfzXrYoV8LxKStdQ-B0BLdMV16L3ya0NokozG479g@mail.gmail.com>
In-Reply-To: <CAOMZO5Aj+PfzXrYoV8LxKStdQ-B0BLdMV16L3ya0NokozG479g@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 30 Dec 2019 10:52:52 -0700
X-Gmail-Original-Message-ID: <CAL_Jsq+8tpxUqzPt2wP668_GTmtaSuaBRSO_k7db4Jt06MWk9g@mail.gmail.com>
Message-ID: <CAL_Jsq+8tpxUqzPt2wP668_GTmtaSuaBRSO_k7db4Jt06MWk9g@mail.gmail.com>
Subject: Re: [PATCH v4 1/5] dt-bindings: arm: fsl: Add Gateworks Ventana
 i.MX6DL/Q compatibles
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Robert Jones <rjones@gateworks.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
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

On Thu, Dec 26, 2019 at 5:34 PM Fabio Estevam <festevam@gmail.com> wrote:
>
> Hi Rob,
>
> On Thu, Dec 26, 2019 at 8:26 PM Rob Herring <robh@kernel.org> wrote:
> >
> > On Mon, Dec 23, 2019 at 05:00:16PM -0800, Robert Jones wrote:
> > > Add the compatible enum entries for Gateworks Ventana boards.
> > >
> > > Signed-off-by: Robert Jones <rjones@gateworks.com>
> > > ---
> > >  Documentation/devicetree/bindings/arm/fsl.yaml | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
> > > index f79683a..a02e980 100644
> > > --- a/Documentation/devicetree/bindings/arm/fsl.yaml
> > > +++ b/Documentation/devicetree/bindings/arm/fsl.yaml
> > > @@ -126,6 +126,7 @@ properties:
> > >                - toradex,apalis_imx6q-ixora      # Apalis iMX6 Module on Ixora
> > >                - toradex,apalis_imx6q-ixora-v1.1 # Apalis iMX6 Module on Ixora V1.1
> > >                - variscite,dt6customboard
> > > +              - gw,ventana                # Gateworks i.MX6DL or i.MX6Q Ventana
> >
> > Keep entries sorted.
>
> Just for clarification: shouldn't the entries inside fsl.yaml match
> the dtb file names?

No. They should match top-level compatibles. However, I'd expect a 1:1
relationship of dtbs to top-level compatible entries.

> In case of the i.MX6Q based gateworks board, this should be:
>
> gw,imx6q-gw51xx
> gw,imx6q-gw52xx
> gw,imx6q-gw53xx
> gw,imx6q-gw5400-a
> gw,imx6q-gw54xx
> gw,imx6q-gw551x
> gw,imx6q-gw552x
> gw,imx6q-gw553x
> gw,imx6q-gw560x
> gw,imx6q-gw5903
> gw,imx6q-gw5904
>
> Please advise.

Yes, if this is 11 different boards, then yes, I'd expect 11
permutations for the schema.

Rob
