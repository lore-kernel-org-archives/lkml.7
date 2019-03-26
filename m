Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2C2DC4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 15:43:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B916A20823
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 15:43:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mind-be.20150623.gappssmtp.com header.i=@mind-be.20150623.gappssmtp.com header.b="iLzhsYGk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731798AbfCZPnI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 11:43:08 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:37965 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726278AbfCZPnI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 11:43:08 -0400
Received: by mail-ed1-f66.google.com with SMTP id q14so11179164edr.5
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 08:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mind-be.20150623.gappssmtp.com; s=20150623;
        h=from:in-reply-to:to:cc:subject:organization:message-id:date
         :user-agent:mime-version:content-transfer-encoding:content-language;
        bh=qTFbVP0RRxY4mxvJEr6n3CrBaxLEfK17JkB/F+rzF78=;
        b=iLzhsYGk5hCkyDchoxlIl3+hBkRaD7/IFwG1pWXJ/egfc+VoB/jvXJ9lwg8Rob6z4g
         pJn7HOSVewxcMdvO/rpSThHa2R4THLCBF2QFbHYQEHVENtaFaswnYBhj0lMrEZSXnyo8
         Z8/qv2iow1XN2wV2xsrhKI3hjiYGTUg8OMIgxzZv6/TvMxbryE9SfVcu1rxhp/tb3RB/
         JQwLrml8TCVX+21mVfRgNT0Z6eJpYX6G5IMFUQxCVgd0i53SZPv11YC2milbjE89xE5y
         LQhGULZalbO6jIZaH6CwG3TnW91vR7YA65fg7se1uJ+CRB2Qpa5tmP8Wy+84EqakhKDf
         Zlvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:in-reply-to:to:cc:subject:organization
         :message-id:date:user-agent:mime-version:content-transfer-encoding
         :content-language;
        bh=qTFbVP0RRxY4mxvJEr6n3CrBaxLEfK17JkB/F+rzF78=;
        b=kT56kOPv6kP0fj1oIP6izdHMMt90uNUT8UEMUCNH9uDyfGPLhD1FWsp2jUzg5kY4gU
         KWjrb04U5tY8c2UBUtH/flzdyPzjOrlr2xfsA4X3uJUkyNE16pXL9JZtmIYYJ451B0lv
         /W+mGkC5ElWgLjdI0xBnFGTak1K73Foby5lbD0+yRHkqD5LOla8V+YaLwqhH92HqMa7f
         ms/ckiqrt3dXXz1F/b0uket0OuM/8mikBwe3Y/PyzjLAuJ2n09GbuFnOMkxtiH6GHKKF
         7+JnQ2+200IfXp6xhqf9q1N4xVU3qXhyQui2K6Z0cEoIfrAibl3RU6hPma2XhfH8p9k1
         VObQ==
X-Gm-Message-State: APjAAAUkYgVhYe04Yv6d9BtzRCcFL0kLDQXCiZDvkVZjGGONMFVPDZmG
        /j/5aUNmoUGGxkKAbb7ZZ9E1Xg==
X-Google-Smtp-Source: APXvYqwE0TaKGdFtgbR/0LNQHwwQZn7e/3PPeDeLG8o0xEQPrq7i+9UH5mIvezIE0te2+XdcAMLuxA==
X-Received: by 2002:a17:906:194c:: with SMTP id b12mr8136512eje.228.1553614985501;
        Tue, 26 Mar 2019 08:43:05 -0700 (PDT)
Received: from [10.3.4.110] (ip-188-118-3-185.reverse.destiny.be. [188.118.3.185])
        by smtp.gmail.com with ESMTPSA id p26sm4279205eju.10.2019.03.26.08.43.03
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Mar 2019 08:43:04 -0700 (PDT)
From:   Arnout Vandecappelle <arnout@mind.be>
In-Reply-To: <20190316142138.65860d88@archlinux>
To:     Patrick Havelange <patrick.havelange@essensium.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     William Breathitt Gray <vilhelm.gray@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Esben Haabendal <esben@haabendal.dk>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pwm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 4/7] dt-bindings: counter: ftm-quaddec
Organization: Essensium/Mind
Message-ID: <55b4aaba-a94f-2a9d-c96d-e591877fe075@mind.be>
Date:   Tue, 26 Mar 2019 16:43:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 [Full disclosure: I'm a colleague of Patrick.]

On 2019-03-16 14:21:38, Jonathan Cameron wrote:

> On Tue, 12 Mar 2019 14:09:52 -0500
> Rob Herring <robh@kernel.org> wrote:
>
> > On Wed, Mar 06, 2019 at 12:12:05PM +0100, Patrick Havelange wrote:
> > > FlexTimer quadrature decoder driver.
> > > 
> > > Signed-off-by: Patrick Havelange <patrick.havelange@essensium.com>
> > > Reviewed-by: Esben Haabendal <esben@haabendal.dk>
> > > ---
> > > Changes v2
> > > - None
> > > ---
> > > .../bindings/counter/ftm-quaddec.txt           | 18 ++++++++++++++++++
> > > 1 file changed, 18 insertions(+)
> > > create mode 100644 Documentation/devicetree/bindings/counter/ftm-quaddec.txt
> > > 
> > > diff --git a/Documentation/devicetree/bindings/counter/ftm-quaddec.txt \
> > > b/Documentation/devicetree/bindings/counter/ftm-quaddec.txt new file mode 100644
> > > index 000000000000..4d18cd722074
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/counter/ftm-quaddec.txt
> > > @@ -0,0 +1,18 @@
> > > +FlexTimer Quadrature decoder counter
> > > +
> > > +This driver exposes a simple counter for the quadrature decoder mode.  
> > 
> > Seems like this is more a mode of a h/w block than describing a h/w 
> > block. Bindings should do the latter.


  As Jonathan writes below, it really is a "hardware mode", since it is tied
very closely to how the device is wired up.

 Basically, the same block can be used for pretty diverse functions: a PWM where
the pins are output, a counter where the pins are input, or a timer where the
interrupt or timer value is used purely internally.

 This smells a bit like an MFD, but IMO it really isn't, because only one of the
functions can be enabled. So indeed, it's more like a mode.


> The snag is that we need to dig ourselves out of the hole set by:
> fsl,vf610-ftm-pwm etc.
>
> Documentation/devicetree/bindings/pwm/pwm-fsl-ftm.txt
> Documentation/devicetree/bindings/timer/fsl,ftm-timer.txt
> (I'm assuming these are the same IP block).
>
> Can probably be sorted out though.  One core driver binds against the
> ftm and deals with instantiating the others depending on the configuration
> (note that this mode for instance does make sense in DT as it's
> really reflecting the fact there is a quadrature encoder
> connected to the ftm).
>
> Fiddly though :)


 The way I see it, there are 3 ways this could be modelled (other than the
current way: several nodes with the same address).


1. The SoC's .dtsi defines a single node, and the compatible string (which would
be defined by the board .dts) both enables the node and sets the compatible
string. The .dtsi would also define the static properties of all the different
functions: some "static" properties, e.g. reg, but also some function
specific-properties, e.g.#pwm-cells (only for PWM), interrupts (only for timer).
The driver (selected through compatible) anyway only uses the properties that it
needs, so it doesn't hurt to have those other-function properties there.


2. Like 1, but instead of defining the compatible string in the .dts, use a
single compatible string for all the different drivers which is set in the
.dtsi, and add a mode property (to be set in the .dts) to select the driver. The
selection can be done either by having a top-level driver that calls out to the
subsystem-specific one based on the mode, or by having each driver bail out of
its probe function if the mode is not as expected.


3. Have a common node that essentially does nothing except occupy the memory
resource, and sub-nodes for each function. This can again be combined with a
common driver that does the common resource allocation, or each function driver
can just look at its parent node to find the resources. A disadvantage of this
one is that it is possible to enable several functions in the DT, while only one
can actually work.


 Option 3 is what is used for e.g. stm32-lptimer. It also uses an mfd driver to
model the common part. But possibly it actually allows the different functions
to operate simultaneously.


 Option 3 has the additional disadvantage that it requires changes in existing
DTs for ftm-pwm and ftm-timer, because some properties are moved one level down.
Since we need to retain backward compatibility, we'd need to look for those
properties both in the node itself and in the parent node. In particular, the
common driver part would be fairly complicated to implement in a backward
compatible way because it's not enough to do a simple devm_of_platform_populate().


 Personally I don't like the common driver part too much. This common driver
does almost nothing (iomap and clock) and it creates dependencies between
different drivers. Combined with the backward compatibility problem, I don't see
much point to it.


 I personally like option 2 the most. It's easy to be backward compatible (if
mode is not set, revert to the current behaviour, i.e. assume that the
compatible string has encoded the mode and that you're the only driver). It
doesn't introduce subnodes that have no hardware equivalent. The only messy
thing about it is that properties belonging to the different modes are mixed
together in a single node. And also, I don't think this kind of model is
currently used anywhere else in the kernel.



 Regards,
 Arnout


