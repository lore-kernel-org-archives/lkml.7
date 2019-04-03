Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73B8DC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 01:50:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 354F32084C
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 01:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554256225;
	bh=TtWGvWAmN1BpaQMjj2UUvEHqjIdpAkMpht5VQedYTT8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=jJQUU+WGa3EjfeCIFx70sSDU21BGYvXPI7Ir3bWrTLcHrWbZobk6Y2ZXw11XPFn7q
	 PSBxs5CgnhDeyLdcIXhNH0YXxRZXmFcfP7PzfvR20OQNHXRfCuXmDP3TH95yJ9NTT5
	 6cvNWiLD9bdAyYKzIAoZcxsN0w0Tlsw66bPZJpQk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbfDCBuX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 21:50:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:56362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726071AbfDCBuX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 21:50:23 -0400
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B26521738;
        Wed,  3 Apr 2019 01:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554256221;
        bh=TtWGvWAmN1BpaQMjj2UUvEHqjIdpAkMpht5VQedYTT8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=h8kU3tRdb9dAQygZmpRYQwEQjqjWuvWxSLiKROVFyXrWhnzdTQU7hfR0SyxlJ/FeG
         Fy7Q59VfU5M1x6ho6gpspws4tsjGUv5/my0tq+WuDDtorzMslYndpdkXiASP1YAF7D
         5rLw/BaUOmIWPCNiN4w9Jbu2ETjl9KpY4oxJ6S5w=
Received: by mail-qt1-f175.google.com with SMTP id k2so17765113qtm.1;
        Tue, 02 Apr 2019 18:50:21 -0700 (PDT)
X-Gm-Message-State: APjAAAVU3VDpbYoAXJ7bV9iUy5LoJl/llnjiFf00ti1T8ZDFLevw3l6s
        vKhb8ehFr8lcnuQ9vzAR7Nc6gPF8dCkB0z6lIg==
X-Google-Smtp-Source: APXvYqwRkLCi24b0Urz0E5JBGwM1uSYLYFNOtWI5XqhkY7qKvYd7JbHaLjEWU6PXQoqWCKhjttlWfSUpj+RWsK1nNwE=
X-Received: by 2002:a0c:958d:: with SMTP id s13mr59915247qvs.205.1554256220768;
 Tue, 02 Apr 2019 18:50:20 -0700 (PDT)
MIME-Version: 1.0
References: <20190401103034.21062-1-masneyb@onstation.org> <20190401103034.21062-3-masneyb@onstation.org>
 <68229e7f-4749-cde5-f541-793ab614084d@ti.com> <20190402132440.GA10359@basecamp>
In-Reply-To: <20190402132440.GA10359@basecamp>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 2 Apr 2019 20:50:09 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKCJ0hwBX1P2abLjfMPZow3SJGO65PQ1Fa+Qz9DFHCXSg@mail.gmail.com>
Message-ID: <CAL_JsqKCJ0hwBX1P2abLjfMPZow3SJGO65PQ1Fa+Qz9DFHCXSg@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] dt-bindings: backlight: add lm3630a bindings
To:     Brian Masney <masneyb@onstation.org>
Cc:     Dan Murphy <dmurphy@ti.com>, Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>,
        Mark Rutland <mark.rutland@arm.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Jonathan Marek <jonathan@marek.ca>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 2, 2019 at 8:24 AM Brian Masney <masneyb@onstation.org> wrote:
>
> On Tue, Apr 02, 2019 at 07:56:55AM -0500, Dan Murphy wrote:
> > This would connect control bank B to control bank A.  Or just use a flag to denote to connect them
> > and not use led-sources.  But led-sources is the property of choice.
> >
> > led@0 {
> >       reg = <0>;
> >       led-sources = < 0 1 >;
> >       label = "main-lcd";
> >       default-brightness = <200>;
> >       max-brightness = <255>;
> > };
>
> OK, I see. I wondered how we could do that in device tree.
>
> > > +    properties:
> > > +      label:
> > > +        description: |
> > > +          The label for this LED. If omitted, the label is taken from the node
> > > +          name (excluding the unit address). It has to uniquely identify a
> > > +          device, i.e. no other LED class device can be assigned the same label.
> > > +
> > > +      led-sources:
> > > +        description: |
> > > +          List of device current outputs the LED is connected to.
> > > +        allOf:
> > > +          - $ref: /schemas/types.yaml#/definitions/uint32-array
> > > +          - minItems: 1
> > > +            maxItems: 2
> > > +            items:
> > > +              minimum: 0
> > > +              maximum: 1
> > > +
> >
> > label and led-sources are already defined in the common.txt no need to redefine them here.
>
> If I'm going to use the new-style bindings, then I'll need to convert
> common.txt over to use the new format as well so that the automated
> schema validations will work. I'm willing to do that work if there is
> interest from the LED / backlight maintainers. The main issue is that
> there are 62 references to the file common.txt in the directory
> Documentation/devicetree/bindings/leds/. Would the maintainers prefer:

That would be awesome.

> - Once common.txt is converted to common.yaml, make common.txt only
>   have a line stating that the common bindings were moved into
>   common.yaml. We can remove this file once all of the other bindings
>   are converted to the new-style format.
>
> - Update all references to common.txt to common.yaml. (1 patch or 62
>   patches?)

I'd probably go with the former if I had to pick. The real
complication here is there's some other changes in flight.

>
> - Or, just go with the older-style binding format for now.

I'm okay if you write it with the assumption that the common
properties have a schema even if they don't yet. All that means is you
don't need to define the type, but only the additional constraints.
There doesn't have to be a reference back to the common property
(those references tend to get broken as we can see here). With
everything as structured data, we could even generate references or
have some tool that can lookup the common definitions.

Rob
