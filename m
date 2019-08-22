Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C74E3C3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 12:52:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9364C2070B
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 12:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566478326;
	bh=M+Cv//+XfrETRuLsfLdPmRxWKe2q0redejZXokNjvFQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=jqWWIoLLljOviVLqhO1GdtJFXOvQKNxGsQwrTCxmewuSifm72Ywf2AzO4PjqWz+J/
	 Cp01ebthh80u095Bza6QzhTEOORj6xkPcOACMAufwiToC+2ox02MXYJx526JlWRtPm
	 19UvsFZOnkJlOARyztHW5/G3ZeKCq1HwI9NHQ2A8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388107AbfHVMwF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 08:52:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:40124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725856AbfHVMwF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 08:52:05 -0400
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3A900233A2;
        Thu, 22 Aug 2019 12:52:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566478324;
        bh=M+Cv//+XfrETRuLsfLdPmRxWKe2q0redejZXokNjvFQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Q2wTLVosMvILxnc9Lw9AIYfhRlWhXFI7PJchdrPati0756F0Lz9FjEGI7PQ9e16lC
         aS9vv0kEAUlHPrbAG9z8xFnPV7PEU3s7u1jQ0aCewbDybe52QMBrdetWAHg3y0hHK+
         h2g5SqKoLrGax+PD5EtieoOuK42O3+93WLXHlp/k=
Received: by mail-qt1-f172.google.com with SMTP id q4so7490385qtp.1;
        Thu, 22 Aug 2019 05:52:04 -0700 (PDT)
X-Gm-Message-State: APjAAAVXrgirlOpg41l3ev7OoU21YsRHb1vUOwdJCEsUzhDkJLMBhgpp
        cpwXb+7ZqjZcDvV2Jwc9URWEEpumx5VmFQ6w/g==
X-Google-Smtp-Source: APXvYqyud1uld7PRlHZyZGc9pJSR2E2SAPODxijwM1XUjXe1gqeZih14Umvdcphw6A3XJwJs9+MIzzyXSO4CKcIra7w=
X-Received: by 2002:aed:24f4:: with SMTP id u49mr36868968qtc.110.1566478323380;
 Thu, 22 Aug 2019 05:52:03 -0700 (PDT)
MIME-Version: 1.0
References: <1566315318-30320-1-git-send-email-krzk@kernel.org>
 <1566315318-30320-3-git-send-email-krzk@kernel.org> <CAL_JsqJLSZ50tdFcdPFc2ifcDoFZFuw=SoKsunzjtAhZ-11fBg@mail.gmail.com>
 <CAJKOXPfkNcWw9sunwXGRz42jOL0cdRC-iiHLtWCYvo5oxCMwFQ@mail.gmail.com>
 <CAL_JsqKAH6n1sMoWOhfiHKxgREr-EN1tw0QtC1H8Fm=a7PNzOA@mail.gmail.com>
 <20190820202142.GA15866@kozik-lap> <CAL_JsqKBWB2FiVjYo9O7DPw1JYJvan7uRgbR0VBG=FfHDVYdZQ@mail.gmail.com>
 <20190821175458.GA25168@kozik-lap>
In-Reply-To: <20190821175458.GA25168@kozik-lap>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 22 Aug 2019 07:51:51 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+YZ9KdCCT1grtpf7Z1o=-mFuq3O=o7iVGSAhJYO1-=Ww@mail.gmail.com>
Message-ID: <CAL_Jsq+YZ9KdCCT1grtpf7Z1o=-mFuq3O=o7iVGSAhJYO1-=Ww@mail.gmail.com>
Subject: Re: [PATCH v6 3/4] dt-bindings: arm: fsl: Add Kontron i.MX6UL N6310 compatibles
To:     Krzysztof Kozlowski <krzk@kernel.org>
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 21, 2019 at 12:55 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On Tue, Aug 20, 2019 at 03:27:39PM -0500, Rob Herring wrote:
> > > I see. If I understand the schema correctly, this should look like:
> >
> > Looks correct, but a couple of comments.
> >
> > > diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
> > > index 7294ac36f4c0..eb263d1ccf13 100644
> > > --- a/Documentation/devicetree/bindings/arm/fsl.yaml
> > > +++ b/Documentation/devicetree/bindings/arm/fsl.yaml
> > > @@ -161,6 +161,22 @@ properties:
> > >          items:
> > >            - enum:
> > >                - fsl,imx6ul-14x14-evk      # i.MX6 UltraLite 14x14 EVK Board
> > > +              - kontron,imx6ul-n6310-som  # Kontron N6310 SOM
> >
> > Is the SOM ever used alone? If not, then no point in listing this here.
>
> SoM alone: no, because it requires some type of base board. However it
> will be used by some customer designs with some amount of
> changes/addons.
>
> Looking at other aproaches, usually SoMs have their own compatible.  In
> such case - I should document it somewhere.

I wasn't suggesting not having the compatible for it, but you don't
need it in this list because that is not valid. You have to list it
with the base board compatibles.

Rob
