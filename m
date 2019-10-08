Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 228F8C4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 14:38:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFC1B20659
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 14:38:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570545510;
	bh=1Q4mMsOb96kylNfFxUq+jNGhofo0vA75cx96BsraELc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=LmI9m2GWCwgvmkA3ASnkKzB32xA7dAhhkA3DkHisKP7hEl6wMoJpRohUcbHZhjs+d
	 apiiCYemm3ZTBRnCcJlZ/5YUG7qL8CHiblQ4M2xVazJOVP74yYKUoblMQefNsWYAWn
	 ej/B0rYYDaTdWlRX9LCM35OXTKtZu1w5hPkdGGHc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726349AbfJHOi3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 10:38:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:56052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725795AbfJHOi2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 10:38:28 -0400
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7CAC121871;
        Tue,  8 Oct 2019 14:38:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570545507;
        bh=1Q4mMsOb96kylNfFxUq+jNGhofo0vA75cx96BsraELc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=uHp1KfTNQWDdfSngQbG2a61L+AfiFcIuxX05zWvcMEkTqqrjwkoMahdNpPRCZmhIE
         tVQ3fNX1NmBrY9KHHIFaQ4zNPuZjGbiRB5ZesilRKdAOxL+BPAI1T/DOb0BmSvVELs
         1jc6/vhHbdHTBxIGs2mMmAIIDgK/7nDthGD7t1KQ=
Received: by mail-qt1-f178.google.com with SMTP id u40so25602172qth.11;
        Tue, 08 Oct 2019 07:38:27 -0700 (PDT)
X-Gm-Message-State: APjAAAV41OQzXMAcbq7Gh2qacZEcT1HaztH+KfVEjGw5v9p24adHGmu2
        //MmURqu+tSaA7L9xAATbsEcij8qJ9mECBZUNA==
X-Google-Smtp-Source: APXvYqyTiDBKsgu4+AG5Pntyh3cdGaf1r6LnkyAMi4aS1suYyJJDpHx4CMSAkGYGBnyIWM7DQIrHIaFzaWMBtTBS7B8=
X-Received: by 2002:a05:6214:1590:: with SMTP id m16mr32958286qvw.20.1570545506528;
 Tue, 08 Oct 2019 07:38:26 -0700 (PDT)
MIME-Version: 1.0
References: <20191004151414.8458-1-krzk@kernel.org> <CAL_JsqJDTcHu5oXG6zszGHCBhTE6EW94AANUjyMV78SkKcn5yA@mail.gmail.com>
 <20191008125038.GA2550@pi3> <CAL_Jsq+GcsUWN6kjBLkyr1rHGh6_4=w6JL6+k7DBXkBcvHcSBw@mail.gmail.com>
 <CAL_JsqKBzZCShxx99aB4z15XYNbUionVicmfNNXEfq=iohWLCA@mail.gmail.com> <20191008142900.GA2635@pi3>
In-Reply-To: <20191008142900.GA2635@pi3>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 8 Oct 2019 09:38:15 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+ObMD=inkMFqkZbKFoKZUxw53gUMnjsC1pU5GwumK8LQ@mail.gmail.com>
Message-ID: <CAL_Jsq+ObMD=inkMFqkZbKFoKZUxw53gUMnjsC1pU5GwumK8LQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: arm: samsung: Force clkoutN names to be
 unique in PMU
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Kukjin Kim <kgene@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Lee Jones <lee.jones@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Maciej Falkowski <m.falkowski@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 8, 2019 at 9:29 AM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On Tue, Oct 08, 2019 at 09:17:16AM -0500, Rob Herring wrote:
> > On Tue, Oct 8, 2019 at 9:05 AM Rob Herring <robh+dt@kernel.org> wrote:
> > >
> > > On Tue, Oct 8, 2019 at 7:50 AM Krzysztof Kozlowski <krzk@kernel.org> =
wrote:
> > > >
> > > > On Tue, Oct 08, 2019 at 07:38:14AM -0500, Rob Herring wrote:
> > > > > On Fri, Oct 4, 2019 at 10:14 AM Krzysztof Kozlowski <krzk@kernel.=
org> wrote:
> > > > > >
> > > > > > The clkoutN names of clocks must be unique because they represe=
nt
> > > > > > unique inputs of clock multiplexer.
> > > > > >
> > > > > > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> > > > > > ---
> > > > > >  Documentation/devicetree/bindings/arm/samsung/pmu.yaml | 6 +++=
+--
> > > > > >  1 file changed, 4 insertions(+), 2 deletions(-)
> > > > > >
> > > > > > diff --git a/Documentation/devicetree/bindings/arm/samsung/pmu.=
yaml b/Documentation/devicetree/bindings/arm/samsung/pmu.yaml
> > > > > > index 73b56fc5bf58..d8e03716f5d2 100644
> > > > > > --- a/Documentation/devicetree/bindings/arm/samsung/pmu.yaml
> > > > > > +++ b/Documentation/devicetree/bindings/arm/samsung/pmu.yaml
> > > > > > @@ -53,8 +53,10 @@ properties:
> > > > > >        List of clock names for particular CLKOUT mux inputs
> > > > > >      minItems: 1
> > > > > >      maxItems: 32
> > > > > > -    items:
> > > > > > -      pattern: '^clkout([0-9]|[12][0-9]|3[0-1])$'
> > > > > > +    allOf:
> > > > > > +      - items:
> > > > > > +          pattern: '^clkout([0-9]|[12][0-9]|3[0-1])$'
> > > > > > +      - uniqueItems: true
> > > > >
> > > > > You shouldn't need the 'allOf', just add uniqueItems at the same =
level as items.
> > > >
> > > > If you mean something like:
> > > >   56     uniqueItems: true
> > > >   57     items:
> > > >   58       pattern: '^clkout([0-9]|[12][0-9]|3[0-1])$'
> > > >
> > > > Then the dt_binding_check fails:
> > > >
> > > > dev/linux/Documentation/devicetree/bindings/arm/samsung/pmu.yaml: p=
roperties:clock-names:
> > > > 'uniqueItems' is not one of ['$ref', 'additionalItems', 'additional=
Properties', 'allOf', 'anyOf', 'const', 'contains', 'default', 'dependencie=
s', 'deprecated', 'description', 'else', 'enum', 'items', 'if', 'minItems',=
 'minimum', 'maxItems', 'maximum', 'not', 'oneOf', 'pattern', 'patternPrope=
rties', 'properties', 'required', 'then', 'type', 'typeSize', 'unevaluatedP=
roperties']
> > >
> > > I can add it.
> > >
> > > The other option is to fix this in the clock schema. I'm not sure if
> > > there's a need for duplicate clock-names. Seems unlikely. I'll test
> > > that.
> >
> > Actually, clock-names is already set to be unique. Did you see otherwis=
e?
>
> Yeah, I duplicated on purpose "clkout1" and it was not reported as an
> error. That's why I added "uniqueItems".

Are you running using DT_SCHEMA_FILES? If so, you won't get the core schema=
.

Rob
