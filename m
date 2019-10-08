Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02C12C10F14
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 12:50:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDF852070B
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 12:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570539047;
	bh=OySsODi2IfcQ285IR9RvwAvsWOvDc/nsOHoTuBIMQtU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=LKXzjCRrGBw8jgPlwUlCEImMSvEkca1leIdRy95MfUojPvb/WVJ6XQ0a22v+MR9m2
	 RwpBOa8cu5pz0qrdHrOwHsGNfAVdUkZwJxebvMVO6/8CGSzvOmnFQTMtMWhKSo3gMr
	 CNVTD1u5aGG8oEqPAm8FIXcpqK5HEwByDnIUV8Rc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730317AbfJHMur (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 08:50:47 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36287 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730541AbfJHMup (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 08:50:45 -0400
Received: by mail-wm1-f66.google.com with SMTP id m18so3013420wmc.1;
        Tue, 08 Oct 2019 05:50:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bFWMwkdfgSlqbJTIDocqKJvGwcD57UaC11+rFmnz6Kc=;
        b=GhkTuSjagptOd/MCxBGk0X8z723P3bWDQ3JDjvCeXGKMHyUmd6o0BroJSAhraSuAMl
         p99UIV07b+280mG3NlnwwarJxXiZV4neia70FwuNiZxSdXELDeN3h9eegzsyzsTneLYY
         kPj9Z4FnrZttUpB0vNsqxwWlsGtXYQ1P0NPNXg7jmQfDmYc+MyLSL/uPEdx0v5Ygpff8
         cBFHKDSj+i8zqNJCQ4rU62ho8JbHYtMNhgokjW3EUf9PX1yXYMVLyxqs2NY6DGjheCRv
         x+fEtDQucKvKxrdHdnM+/XeYs/OLJQLWdALjh+5YKL8CLRnhA3XRk/xd+uEEe49spyZ1
         87IA==
X-Gm-Message-State: APjAAAW/lw6q+1vSZwV2SUyoKANwQBZP+r1DQf6A/cshdJYi9x/LhSKp
        RD68D+AnlXQ1jOCBk9rOgqU=
X-Google-Smtp-Source: APXvYqynsGw67zM/kLC2+YxQ7cWPgz0Fnub1csInHDDTqUjZRtD9OaXw2dWRP/82MQmeVhcp3vQOIg==
X-Received: by 2002:a7b:cd13:: with SMTP id f19mr3469466wmj.4.1570539043033;
        Tue, 08 Oct 2019 05:50:43 -0700 (PDT)
Received: from pi3 ([194.230.155.145])
        by smtp.googlemail.com with ESMTPSA id 63sm24153438wri.25.2019.10.08.05.50.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2019 05:50:42 -0700 (PDT)
Date:   Tue, 8 Oct 2019 14:50:38 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>
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
Subject: Re: [PATCH 1/3] dt-bindings: arm: samsung: Force clkoutN names to be
 unique in PMU
Message-ID: <20191008125038.GA2550@pi3>
References: <20191004151414.8458-1-krzk@kernel.org>
 <CAL_JsqJDTcHu5oXG6zszGHCBhTE6EW94AANUjyMV78SkKcn5yA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAL_JsqJDTcHu5oXG6zszGHCBhTE6EW94AANUjyMV78SkKcn5yA@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 08, 2019 at 07:38:14AM -0500, Rob Herring wrote:
> On Fri, Oct 4, 2019 at 10:14 AM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> >
> > The clkoutN names of clocks must be unique because they represent
> > unique inputs of clock multiplexer.
> >
> > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> > ---
> >  Documentation/devicetree/bindings/arm/samsung/pmu.yaml | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/arm/samsung/pmu.yaml b/Documentation/devicetree/bindings/arm/samsung/pmu.yaml
> > index 73b56fc5bf58..d8e03716f5d2 100644
> > --- a/Documentation/devicetree/bindings/arm/samsung/pmu.yaml
> > +++ b/Documentation/devicetree/bindings/arm/samsung/pmu.yaml
> > @@ -53,8 +53,10 @@ properties:
> >        List of clock names for particular CLKOUT mux inputs
> >      minItems: 1
> >      maxItems: 32
> > -    items:
> > -      pattern: '^clkout([0-9]|[12][0-9]|3[0-1])$'
> > +    allOf:
> > +      - items:
> > +          pattern: '^clkout([0-9]|[12][0-9]|3[0-1])$'
> > +      - uniqueItems: true
> 
> You shouldn't need the 'allOf', just add uniqueItems at the same level as items.

If you mean something like:
  56     uniqueItems: true
  57     items:
  58       pattern: '^clkout([0-9]|[12][0-9]|3[0-1])$'

Then the dt_binding_check fails:

dev/linux/Documentation/devicetree/bindings/arm/samsung/pmu.yaml: properties:clock-names:
'uniqueItems' is not one of ['$ref', 'additionalItems', 'additionalProperties', 'allOf', 'anyOf', 'const', 'contains', 'default', 'dependencies', 'deprecated', 'description', 'else', 'enum', 'items', 'if', 'minItems', 'minimum', 'maxItems', 'maximum', 'not', 'oneOf', 'pattern', 'patternProperties', 'properties', 'required', 'then', 'type', 'typeSize', 'unevaluatedProperties']

Best regards,
Krzysztof


