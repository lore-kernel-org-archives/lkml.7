Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 656A1C10F14
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 14:29:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3784E2070B
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 14:29:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570544947;
	bh=ys2SNXL5zK/iSkN3q9J3K5H+3XMp/3DlnDb+8W4ifTE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ZEuLCgzTTxhakoYHu6H2+aT/0ivFr2h3rc4Ah02q4lijQXVJIx3ek4g8Z/pmFtukV
	 NTtpo+RZ2LWPDVtBwfv9tuNqbIeQX/HLOI0Hem3/Kc097rot+1ipyXtvPwWp6aepLc
	 SCQvatm/3xInxAhFk2iOfEZZf0RcWgzzUL4dSVsk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbfJHO3G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 10:29:06 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52029 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725795AbfJHO3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 10:29:06 -0400
Received: by mail-wm1-f66.google.com with SMTP id 7so3414306wme.1;
        Tue, 08 Oct 2019 07:29:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YE0D8Jghzw7CVdBybcskFRzbxtu5Ddla3G2nKPd70nY=;
        b=Sc8Om7IguzBfLUV8d0Qb3/RSTq6q2+HX3E3E88BENJ2zail1KFY8MdtpSMcANhmSH9
         hBYWxFhwEIVGjyzS1a5S09LFWFClss+NFEb3UGqcH6VnUAKW3waCdlAC2cqwFoVBZ0wk
         5YZsCI9dC03b9yyLEm5otuFb68kEyhVxpZKLtoWrAwiJY7YJeoz7/iAJYOuCQsr1HE7p
         MsxAF3hEVS8gyUbMNOl8UFD9L5rRE2JIN4G/O7ByydEKqXc4H7Ri+FS7/VmsT334zMJx
         129RCo1MHf+edtdRCzdCI6pauGWSS9bgxWslmc2Btes7xZV8yjLIxi6oi8MiEv3KGTbt
         F7og==
X-Gm-Message-State: APjAAAVn5OEmWl6hXEIVU9qCQesSBTQpVYKjf9VSScFf3MVanW5feC/b
        DMxbteYzs220Bg0urwK96qgD64P3
X-Google-Smtp-Source: APXvYqw13buOvMKCLr9dJbc+42LtMA0u9H09vXHDWUs/lreMeW+bzq3Dl290U336az+CLfiT3ep52A==
X-Received: by 2002:a1c:a6ca:: with SMTP id p193mr3960835wme.103.1570544942984;
        Tue, 08 Oct 2019 07:29:02 -0700 (PDT)
Received: from pi3 ([194.230.155.145])
        by smtp.googlemail.com with ESMTPSA id 143sm4202466wmb.33.2019.10.08.07.29.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2019 07:29:02 -0700 (PDT)
Date:   Tue, 8 Oct 2019 16:29:00 +0200
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
Message-ID: <20191008142900.GA2635@pi3>
References: <20191004151414.8458-1-krzk@kernel.org>
 <CAL_JsqJDTcHu5oXG6zszGHCBhTE6EW94AANUjyMV78SkKcn5yA@mail.gmail.com>
 <20191008125038.GA2550@pi3>
 <CAL_Jsq+GcsUWN6kjBLkyr1rHGh6_4=w6JL6+k7DBXkBcvHcSBw@mail.gmail.com>
 <CAL_JsqKBzZCShxx99aB4z15XYNbUionVicmfNNXEfq=iohWLCA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAL_JsqKBzZCShxx99aB4z15XYNbUionVicmfNNXEfq=iohWLCA@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 08, 2019 at 09:17:16AM -0500, Rob Herring wrote:
> On Tue, Oct 8, 2019 at 9:05 AM Rob Herring <robh+dt@kernel.org> wrote:
> >
> > On Tue, Oct 8, 2019 at 7:50 AM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> > >
> > > On Tue, Oct 08, 2019 at 07:38:14AM -0500, Rob Herring wrote:
> > > > On Fri, Oct 4, 2019 at 10:14 AM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> > > > >
> > > > > The clkoutN names of clocks must be unique because they represent
> > > > > unique inputs of clock multiplexer.
> > > > >
> > > > > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> > > > > ---
> > > > >  Documentation/devicetree/bindings/arm/samsung/pmu.yaml | 6 ++++--
> > > > >  1 file changed, 4 insertions(+), 2 deletions(-)
> > > > >
> > > > > diff --git a/Documentation/devicetree/bindings/arm/samsung/pmu.yaml b/Documentation/devicetree/bindings/arm/samsung/pmu.yaml
> > > > > index 73b56fc5bf58..d8e03716f5d2 100644
> > > > > --- a/Documentation/devicetree/bindings/arm/samsung/pmu.yaml
> > > > > +++ b/Documentation/devicetree/bindings/arm/samsung/pmu.yaml
> > > > > @@ -53,8 +53,10 @@ properties:
> > > > >        List of clock names for particular CLKOUT mux inputs
> > > > >      minItems: 1
> > > > >      maxItems: 32
> > > > > -    items:
> > > > > -      pattern: '^clkout([0-9]|[12][0-9]|3[0-1])$'
> > > > > +    allOf:
> > > > > +      - items:
> > > > > +          pattern: '^clkout([0-9]|[12][0-9]|3[0-1])$'
> > > > > +      - uniqueItems: true
> > > >
> > > > You shouldn't need the 'allOf', just add uniqueItems at the same level as items.
> > >
> > > If you mean something like:
> > >   56     uniqueItems: true
> > >   57     items:
> > >   58       pattern: '^clkout([0-9]|[12][0-9]|3[0-1])$'
> > >
> > > Then the dt_binding_check fails:
> > >
> > > dev/linux/Documentation/devicetree/bindings/arm/samsung/pmu.yaml: properties:clock-names:
> > > 'uniqueItems' is not one of ['$ref', 'additionalItems', 'additionalProperties', 'allOf', 'anyOf', 'const', 'contains', 'default', 'dependencies', 'deprecated', 'description', 'else', 'enum', 'items', 'if', 'minItems', 'minimum', 'maxItems', 'maximum', 'not', 'oneOf', 'pattern', 'patternProperties', 'properties', 'required', 'then', 'type', 'typeSize', 'unevaluatedProperties']
> >
> > I can add it.
> >
> > The other option is to fix this in the clock schema. I'm not sure if
> > there's a need for duplicate clock-names. Seems unlikely. I'll test
> > that.
> 
> Actually, clock-names is already set to be unique. Did you see otherwise?

Yeah, I duplicated on purpose "clkout1" and it was not reported as an
error. That's why I added "uniqueItems".

Best regards,
Krzysztof

