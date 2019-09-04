Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA746C3A5A7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 09:06:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C15B722CF7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 09:06:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567587990;
	bh=EOQcGVJ6OuDmcoR+UhqLOItk6Uldp6Kp+u0aoDcoTrc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Z8VZZ4lyd06O/f8xjrw1GHjnhAeUfuFxULw0E/h5sqe3TRo8brLO0wvn/gAWIzGu6
	 TFlsnwk0ecNy082Mxb7f4FGMrSD2U3uh/tOgQWYidikWIJ1H3yU7iYUC6LaAf4GUc3
	 Qq4KRQ2QDaNANg7A2Lj61aUahYS9kodaW02adPoE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729498AbfIDJG3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 05:06:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:34844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727144AbfIDJG2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 05:06:28 -0400
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 199892339E;
        Wed,  4 Sep 2019 09:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567587987;
        bh=EOQcGVJ6OuDmcoR+UhqLOItk6Uldp6Kp+u0aoDcoTrc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=SbUL5oScju8aqdkKXaEH+CLZTc/GskaW/IOHPyNgRiBmDNvDEJwzQgaBZ0zTfOL5z
         +vqeoa1MgUs+FrLTyZcHaiy8NltzgewYw2/Z2dvhdPqrlV3CRcpuXJp3mE565N4M+i
         FrDdqHCVZ6e9f6fLxpH4FxNRVBtKdI4WHTMRZvtI=
Received: by mail-qk1-f177.google.com with SMTP id f13so18842922qkm.9;
        Wed, 04 Sep 2019 02:06:27 -0700 (PDT)
X-Gm-Message-State: APjAAAWglR6rpNcHI8m+gZCitflQGJpP+A12fXUz3t5pfwA49fm2ymSI
        RqKhFhmsg5mQ/h1J4QwQNtB1kaEbHeDmbe98SQ==
X-Google-Smtp-Source: APXvYqwsUjYioCkp7chtGIyXBeWPxAmAYYRHsnnUJEmm0tjJuP13a/87Fssk2rAEhdN6wQH59jQzx/qASdFezPeBZ/Q=
X-Received: by 2002:a05:620a:1356:: with SMTP id c22mr18142847qkl.119.1567587986249;
 Wed, 04 Sep 2019 02:06:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190903080336.32288-1-philippe.schenker@toradex.com>
 <20190903080336.32288-4-philippe.schenker@toradex.com> <CAL_JsqLnqZ80soGVMvZjAMZvu+K=ebDUz2bM_ZodPp7YRvUnDw@mail.gmail.com>
 <e64429ba4b86411da1741ab54176fb5b4b7a36de.camel@toradex.com>
In-Reply-To: <e64429ba4b86411da1741ab54176fb5b4b7a36de.camel@toradex.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 4 Sep 2019 10:06:14 +0100
X-Gmail-Original-Message-ID: <CAL_JsqLLSUWhkguCx2mc2oyV-0MHp4RWwJr5oTWRUvQiovn4Gw@mail.gmail.com>
Message-ID: <CAL_JsqLLSUWhkguCx2mc2oyV-0MHp4RWwJr5oTWRUvQiovn4Gw@mail.gmail.com>
Subject: Re: [PATCH 3/3] dt-bindings: regulator: add regulator-fixed-clock binding
To:     Philippe Schenker <philippe.schenker@toradex.com>
Cc:     Max Krummenacher <max.krummenacher@toradex.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Luka Pivk <luka.pivk@toradex.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Stefan Agner <stefan.agner@toradex.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 4, 2019 at 9:07 AM Philippe Schenker
<philippe.schenker@toradex.com> wrote:
>
> On Tue, 2019-09-03 at 09:45 +0100, Rob Herring wrote:
> > On Tue, Sep 3, 2019 at 9:03 AM Philippe Schenker
> > <philippe.schenker@toradex.com> wrote:
> > > This adds the documentation to the compatible regulator-fixed-clock
> >
> > Please explain what that is in this patch.
>
> Hi Rob and thanks for your comments. I will change this commit message
> for a possible v2 into this:
>
> This adds the documentation to the compatible regulator-fixed-clock.
> This binding is a special binding of regulator-fixed and adds the
> ability to add a clock to regulator-fixed, so the regulator can be
> enabled and disabled with that clock.
> If the special compatible regulator-fixed-clock is used it is mandatory
> to supply a clock.
>
> > >
> >
> > > Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
> > >
> > > ---
> > >
> > >  .../bindings/regulator/fixed-regulator.yaml    | 18
> > > +++++++++++++++++-
> > >  1 file changed, 17 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/Documentation/devicetree/bindings/regulator/fixed-
> > > regulator.yaml b/Documentation/devicetree/bindings/regulator/fixed-
> > > regulator.yaml
> > > index a650b457085d..5fd081e80b43 100644
> > > --- a/Documentation/devicetree/bindings/regulator/fixed-
> > > regulator.yaml
> > > +++ b/Documentation/devicetree/bindings/regulator/fixed-
> > > regulator.yaml
> > > @@ -19,9 +19,19 @@ description:
> > >  allOf:
> > >    - $ref: "regulator.yaml#"
> > >
> > > +select:
> > > +  properties:
> > > +    compatible:
> > > +      contains:
> > > +        const: regulator-fixed-clock
> > > +  required:
> > > +    - clocks
> >
> > You don't need this.
> >
> > If you add a new compatible, then this should probably be a new schema
> > doc. Is the 'gpio' property valid in this case as if a clock is the
> > enable, can you also have a gpio enable? That said, it seems like the
> > new compatible is only for validating the DT in the driver. You could
> > just use a clock if present and default to current behavior if not.
> > It's not the kernel's job to validate DTs.
>
> The gpio property is valid with this compatible. I added regulator-
> fixed-clock to regulator-fixed hence I also don't want to create a new
> schema file.

Okay, if all the other properties are valid then adding to this file is fine.

> With the above select statement I wanted to state clocks as required
> when the compatible regulator-fixed-clock is given.

select is not the right way to do that. select is for whether to apply
the schema to a node or not. What you have will silently not apply the
schema if 'clocks' is missing or compatible is 'regulator-fixed'.
Essentially what you need to do here is:

if:
  properties:
    compatible:
      contains:
        const: regulator-fixed-clock
then:
  required:
    - clocks

Rob
