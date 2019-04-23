Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E568AC10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 06:16:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1D71206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 06:16:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D4RA+nAK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726222AbfDWGQk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 02:16:40 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:42192 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbfDWGQk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 02:16:40 -0400
Received: by mail-ed1-f68.google.com with SMTP id u23so11180026eds.9;
        Mon, 22 Apr 2019 23:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vXl6q5zeQKSYBdKSjEhpsF15Oe7Ve1qPnsXuP1rWgWE=;
        b=D4RA+nAKwVy9Xgxk3ChMxDQNmZ2ZnD35mgksgQhD1TngjCI8C1U+1cNE1/p4xYTrmW
         QDx2Q+meUafIV3VLnGYFOPlUek8wWtr/+cxUZtuR/kP4BU7IKXRpZ49gmmL/OOARik36
         PPQ66hwLVxfjzALwnuBiwxNhKPmYpEGP29ZzXWhEsTdNkmoszi1rPTdTkkMhuXPl9rnT
         fbpLn2KGXAV+MqaN/yXjuzjqzzKjNUPqPkaytP8jczgnIKhydxzz+mVqsVJ+Zs76cWoY
         rTVnTKkKBxu/6LdJlNAAq5pol805/4ixvmnyqKYP0nSdxtAAk4fKGA7Hwt/HvwC8zze0
         oFyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vXl6q5zeQKSYBdKSjEhpsF15Oe7Ve1qPnsXuP1rWgWE=;
        b=g2smmxeJMIFrHNFgBAegnwjoIdq6aQcU0pkfJsfsXsCmQ1ft8TlQdA6taXF4P5pwVY
         85RdgtkvA9hgW+1WS2XcqHHqy4alnw+AD3/8tM7WWolbY4VwJ55U2wF7L76hAy42XxD6
         eWix+NqwWfLtnI35JNpQxhlRodbSTTsY1VT7GV070D70SD40K2tyK9ms68MfLkE0RVYV
         cuAIcAo8wN8UBvJabswmL53DzczggLZxaDVmjTr8GMvHT+fYUyXctdZ/YcV+KKIfWR6x
         GaCBqSii6jYZdI+tnfBsC4ATT0tC6vDFDf1xiGga8psCwwIeU+Gkl/erHsqaEPrrGulx
         yKqw==
X-Gm-Message-State: APjAAAX6VPfdijDgCW1bx2BHaZroSZLkyc2bLyyFa/zTGLjhdM8PL6FX
        rgqRsLEtyg41W8cbnqOHmRIvZVICmcFpluxiEYM=
X-Google-Smtp-Source: APXvYqzhnkk3vJ9OKsBmAKsaeiC2UufvH45N2K4DyrrMJf+iLoqI4qETR620rA5hgShr1bcgjb7l/bg1iRL/RJNzd60=
X-Received: by 2002:a50:a3c2:: with SMTP id t2mr14767339edb.46.1556000198022;
 Mon, 22 Apr 2019 23:16:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190422193542.2853-1-daniel.baluta@nxp.com> <20190422193542.2853-2-daniel.baluta@nxp.com>
 <20190423052022.orwkfjy6ftqmjq5p@pengutronix.de>
In-Reply-To: <20190423052022.orwkfjy6ftqmjq5p@pengutronix.de>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Tue, 23 Apr 2019 09:16:26 +0300
Message-ID: <CAEnQRZA=Ko+hebpCpFAvBMiAtFr8o1m+oktpOpDJh2pkmiEk6A@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] arm64: dts: imx8mm: Add SAI nodes
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     Daniel Baluta <daniel.baluta@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Peng Fan <peng.fan@nxp.com>, Anson Huang <anson.huang@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "S.j. Wang" <shengjiu.wang@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 23, 2019 at 8:21 AM Marco Felsch <m.felsch@pengutronix.de> wrote:
>
> Hi Daniel,
>
> On 19-04-22 19:35, Daniel Baluta wrote:
> > i.MX8MM has 5 SAI instances with the following base
> > addresses according to RM.
> >
> > SAI1 base address: 3001_0000h
> > SAI2 base address: 3002_0000h
> > SAI3 base address: 3003_0000h
> > SAI5 base address: 3005_0000h
> > SAI6 base address: 3006_0000h
> >
> > Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
> > ---
> >  arch/arm64/boot/dts/freescale/imx8mm.dtsi | 71 +++++++++++++++++++++++
> >  1 file changed, 71 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> > index de3498c2dd44..4d080dc47216 100644
> > --- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> > +++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> > @@ -171,6 +171,77 @@
> >                       #size-cells = <1>;
> >                       ranges;
> >
> > +                     sai1: sai@30010000 {
> > +                             compatible = "fsl,imx8mm-sai",
> > +                                             "fsl,imx8mq-sai";
>
> Just a nitpick but I would not break this line here. This applies to the
> other sai nodes too.

Yes, I thought about this and I think I will fix it as you say also I get past
the 80 chars limit.
