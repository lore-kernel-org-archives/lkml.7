Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CBBFC3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 13:45:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CB5F23400
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 13:45:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566481528;
	bh=Hj0g9/YvLJB/GMiuttfnQ/wy/9VbH/xrP0IgPVN17Zc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=pj1DsA/yGz+luCHkm/wC+shUhQLCRLY671oF4Q1SYOgMEFfksui6eHIyUIJT4cwMc
	 gEGbG0bAlD1hAeztWNAXClD1SlSOu+yrG+cBwVe6xhdK28L1wt1cm5Wi+IRjn5IhVd
	 /ew8ZT+n15zQYq6dGrb+qTuy6jZs/2CKR06v/aWM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730788AbfHVNp1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 09:45:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:38516 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726536AbfHVNp1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 09:45:27 -0400
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 06DB223400;
        Thu, 22 Aug 2019 13:45:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566481526;
        bh=Hj0g9/YvLJB/GMiuttfnQ/wy/9VbH/xrP0IgPVN17Zc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jnCnwugfLNTVW8eVNE6bQqVVKL+dAwDnJpPYacg1hM7jXTfCWILOKFzZoPIm0D/t7
         zD5RK29BhwJU/3yKCHRQyfAix/bDnhvz+dfTEv9VjFG0eRlol+pExjsikW7p0GP6HQ
         of4HWU/LjS8/pz2xoPQn6iebjvjjqQB1eYXfW0gA=
Received: by mail-lj1-f177.google.com with SMTP id e24so5595639ljg.11;
        Thu, 22 Aug 2019 06:45:25 -0700 (PDT)
X-Gm-Message-State: APjAAAU3kxuXHtpDz4P99SBvEVeZp7L5aNNOMaHjsWMGpAAc1W/7rE/N
        UMvMfDiQ6OORG+gXRAXC6YZMYrdm8YVn/rDL3zE=
X-Google-Smtp-Source: APXvYqxuT8xlgNSPZt83epiF37LgDQ9sK/vsAV6n794RAbob+czv9NCCVo7yAkDhpbS+aGKCuJAFi74CavuVY4sEe7E=
X-Received: by 2002:a2e:a0c3:: with SMTP id f3mr1973090ljm.123.1566481524218;
 Thu, 22 Aug 2019 06:45:24 -0700 (PDT)
MIME-Version: 1.0
References: <1566315318-30320-1-git-send-email-krzk@kernel.org>
 <1566315318-30320-3-git-send-email-krzk@kernel.org> <CAL_JsqJLSZ50tdFcdPFc2ifcDoFZFuw=SoKsunzjtAhZ-11fBg@mail.gmail.com>
 <CAJKOXPfkNcWw9sunwXGRz42jOL0cdRC-iiHLtWCYvo5oxCMwFQ@mail.gmail.com>
 <CAL_JsqKAH6n1sMoWOhfiHKxgREr-EN1tw0QtC1H8Fm=a7PNzOA@mail.gmail.com>
 <20190820202142.GA15866@kozik-lap> <CAL_JsqKBWB2FiVjYo9O7DPw1JYJvan7uRgbR0VBG=FfHDVYdZQ@mail.gmail.com>
 <20190821175458.GA25168@kozik-lap> <CAL_Jsq+YZ9KdCCT1grtpf7Z1o=-mFuq3O=o7iVGSAhJYO1-=Ww@mail.gmail.com>
In-Reply-To: <CAL_Jsq+YZ9KdCCT1grtpf7Z1o=-mFuq3O=o7iVGSAhJYO1-=Ww@mail.gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Thu, 22 Aug 2019 15:45:12 +0200
X-Gmail-Original-Message-ID: <CAJKOXPc6UNMszVr+fRdLtPxj0GFVrwJ7JqyGrzXz+MC=fY7gUA@mail.gmail.com>
Message-ID: <CAJKOXPc6UNMszVr+fRdLtPxj0GFVrwJ7JqyGrzXz+MC=fY7gUA@mail.gmail.com>
Subject: Re: [PATCH v6 3/4] dt-bindings: arm: fsl: Add Kontron i.MX6UL N6310 compatibles
To:     Rob Herring <robh+dt@kernel.org>
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

On Thu, 22 Aug 2019 at 14:52, Rob Herring <robh+dt@kernel.org> wrote:
>
> On Wed, Aug 21, 2019 at 12:55 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> >
> > On Tue, Aug 20, 2019 at 03:27:39PM -0500, Rob Herring wrote:
> > > > I see. If I understand the schema correctly, this should look like:
> > >
> > > Looks correct, but a couple of comments.
> > >
> > > > diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
> > > > index 7294ac36f4c0..eb263d1ccf13 100644
> > > > --- a/Documentation/devicetree/bindings/arm/fsl.yaml
> > > > +++ b/Documentation/devicetree/bindings/arm/fsl.yaml
> > > > @@ -161,6 +161,22 @@ properties:
> > > >          items:
> > > >            - enum:
> > > >                - fsl,imx6ul-14x14-evk      # i.MX6 UltraLite 14x14 EVK Board
> > > > +              - kontron,imx6ul-n6310-som  # Kontron N6310 SOM
> > >
> > > Is the SOM ever used alone? If not, then no point in listing this here.
> >
> > SoM alone: no, because it requires some type of base board. However it
> > will be used by some customer designs with some amount of
> > changes/addons.
> >
> > Looking at other aproaches, usually SoMs have their own compatible.  In
> > such case - I should document it somewhere.
>
> I wasn't suggesting not having the compatible for it, but you don't
> need it in this list because that is not valid. You have to list it
> with the base board compatibles.

The diff against v7 would be like this then:
---
diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml
b/Documentation/devicetree/bindings/arm/fsl.yaml
index 1f440817fc03..7219c15f6185 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -161,7 +161,6 @@ properties:
         items:
           - enum:
               - fsl,imx6ul-14x14-evk      # i.MX6 UltraLite 14x14 EVK Board
-              - kontron,imx6ul-n6310-som  # Kontron N6310 SOM
           - const: fsl,imx6ul

       - description: Kontron N6310 S Board
---

This passes the dtbs_check.

I'll send v8
