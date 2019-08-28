Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B60AC3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 18:34:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EEED22CF8
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 18:34:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567017276;
	bh=QlJKrHuG8AijV/iNEU5ZY82mlQS+xGN6r27ZxabHhuE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Wz/Fejxx5P/AP4xclaTeRCZc4di8s6SEu8MkP+pZ3dJvqr4bfl8scTmTzSDA66DWu
	 J71RwWt7rUsQEVMiwEV4W5IsO2Kxk5F7/pnObXAjCBApf0JJt0ZeqWJKKKWrsEA/ax
	 I3RuOFAoU1E34AFDAQAZKsZ/9AJQzv64aHz17nxk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbfH1Sef (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 14:34:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:35762 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726567AbfH1See (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 14:34:34 -0400
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2A64C22DA7;
        Wed, 28 Aug 2019 18:34:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567017273;
        bh=QlJKrHuG8AijV/iNEU5ZY82mlQS+xGN6r27ZxabHhuE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=MLqrqhKZvW++VoqjZu0wKlAS41c+6bTvUhyT44KCDmpDXDeL6e9Z+bh46Izr+Cg6o
         aMW7k13Tnkpn/nhxaWJLmRCcQwwB6ZEkyDRvuvwY/WsDNW65AHvfskOlzpqXdyXJ5C
         pOmeQkVOnKSdT9EoZITcYWWMEAQ93s0tEGfcaFA0=
Received: by mail-qk1-f176.google.com with SMTP id m2so620787qkd.10;
        Wed, 28 Aug 2019 11:34:33 -0700 (PDT)
X-Gm-Message-State: APjAAAX2znrRGdgWN1JLRunj2LxQOERqqu4azH/P9W49X02goVMITrEX
        6Fj7xhFiimiSMrK13QTDSXtIVB5KnOaIftAiQA==
X-Google-Smtp-Source: APXvYqz5A5Bvj5V4jmWUchP11mypRsc4CrfFKrk/S0ky7O9zQRqolgrNnj40h/MhRHeg7iGHdxRMNzcIxjSQshaobs4=
X-Received: by 2002:a37:8905:: with SMTP id l5mr5638069qkd.152.1567017272343;
 Wed, 28 Aug 2019 11:34:32 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1566677788.git.mirq-linux@rere.qmqm.pl> <9b85d5a7c7e788e9ed87d020323ad9292e3aeab7.1566677788.git.mirq-linux@rere.qmqm.pl>
 <20190827223716.GA31605@bogus> <20190828130252.GD20202@qmqm.qmqm.pl>
In-Reply-To: <20190828130252.GD20202@qmqm.qmqm.pl>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 28 Aug 2019 13:34:20 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+tD1U2znUTdHxZDCJnfYa9fUeU4YMDAMMFXDka8vJ7jg@mail.gmail.com>
Message-ID: <CAL_Jsq+tD1U2znUTdHxZDCJnfYa9fUeU4YMDAMMFXDka8vJ7jg@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] dt-bindings: misc: atmel-ssc: LRCLK from TF/RF pin option
To:     =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     Linux-ALSA <alsa-devel@alsa-project.org>,
        devicetree@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Chas Williams <3chas3@gmail.com>,
        Codrin Ciubotariu <codrin.ciubotariu@microchip.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Takashi Iwai <tiwai@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 28, 2019 at 8:03 AM Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.=
qmqm.pl> wrote:
>
> On Tue, Aug 27, 2019 at 05:37:16PM -0500, Rob Herring wrote:
> > On Sat, Aug 24, 2019 at 10:26:55PM +0200, Micha=C5=82 Miros=C5=82aw wro=
te:
> > > Add single-pin LRCLK source options for Atmel SSC module.
> > >
> > > Signed-off-by: Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm.pl>
> > >
> > > ---
> > >   v2: split from implementation patch
> > >
> > > ---
> > >  Documentation/devicetree/bindings/misc/atmel-ssc.txt | 5 +++++
> > >  1 file changed, 5 insertions(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/misc/atmel-ssc.txt b/D=
ocumentation/devicetree/bindings/misc/atmel-ssc.txt
> > > index f9fb412642fe..c98e96dbec3a 100644
> > > --- a/Documentation/devicetree/bindings/misc/atmel-ssc.txt
> > > +++ b/Documentation/devicetree/bindings/misc/atmel-ssc.txt
> > > @@ -24,6 +24,11 @@ Optional properties:
> > >         this parameter to choose where the clock from.
> > >       - By default the clock is from TK pin, if the clock from RK pin=
, this
> > >         property is needed.
> > > +  - atmel,lrclk-from-tf-pin: bool property.
> > > +  - atmel,lrclk-from-rf-pin: bool property.
> > > +     - SSC in slave mode gets LRCLK from RF for receive and TF for t=
ransmit
> > > +       data direction. This property makes both use single TF (or RF=
) pin
> > > +       as LRCLK. At most one can be present.
> >
> > A single property taking 1 of possible 2 values would prevent the error
> > of more than 1 property present.
>
> It still would need a validation check in the code, though: you
> could put wrong value then.  It seems more consistent with the
> existing parameters to have two bool properties.

It was validation using schema that I was thinking about. Expressing a
possible set of values for a property is easier than inter-property
constraints.

But if you really prefer as-is:

Reviewed-by: Rob Herring <robh@kernel.org>
