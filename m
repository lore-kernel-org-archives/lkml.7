Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5BE9C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 13:24:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7816220830
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 13:24:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=onstation.org header.i=@onstation.org header.b="Tcbq+zIT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731234AbfDBNYn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 09:24:43 -0400
Received: from onstation.org ([52.200.56.107]:41432 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726716AbfDBNYm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 09:24:42 -0400
Received: from localhost (c-98-239-145-235.hsd1.wv.comcast.net [98.239.145.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: masneyb)
        by onstation.org (Postfix) with ESMTPSA id CDBCC4502C;
        Tue,  2 Apr 2019 13:24:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=onstation.org;
        s=default; t=1554211481;
        bh=0T4dDsKz2NW5cIQbHt3NSk01QVcnIMhTTjqRyuGpjdA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Tcbq+zIT4Aq9IvKauOc6j6lQH7l7UrWgrhYhioQM1x5lfXsbIfQ9UaV4skhnBQigP
         lD6bs3Dyq+aSJfy6AFTRcXLYZujZfxOAiYegfeZchB5k6b4uCfrAINXR0478PR3Z2c
         Xpz4vT0utCiuj4RthKshFla0gyzhqgVkjh57OD1A=
Date:   Tue, 2 Apr 2019 09:24:40 -0400
From:   Brian Masney <masneyb@onstation.org>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     lee.jones@linaro.org, daniel.thompson@linaro.org,
        jingoohan1@gmail.com, robh+dt@kernel.org,
        jacek.anaszewski@gmail.com, pavel@ucw.cz, mark.rutland@arm.com,
        b.zolnierkie@samsung.com, dri-devel@lists.freedesktop.org,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
        jonathan@marek.ca
Subject: Re: [PATCH v2 2/3] dt-bindings: backlight: add lm3630a bindings
Message-ID: <20190402132440.GA10359@basecamp>
References: <20190401103034.21062-1-masneyb@onstation.org>
 <20190401103034.21062-3-masneyb@onstation.org>
 <68229e7f-4749-cde5-f541-793ab614084d@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68229e7f-4749-cde5-f541-793ab614084d@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 02, 2019 at 07:56:55AM -0500, Dan Murphy wrote:
> This would connect control bank B to control bank A.  Or just use a flag to denote to connect them
> and not use led-sources.  But led-sources is the property of choice.
> 
> led@0 {
> 	reg = <0>;
> 	led-sources = < 0 1 >;
> 	label = "main-lcd";
> 	default-brightness = <200>;
> 	max-brightness = <255>;
> };

OK, I see. I wondered how we could do that in device tree.

> > +    properties:
> > +      label:
> > +        description: |
> > +          The label for this LED. If omitted, the label is taken from the node
> > +          name (excluding the unit address). It has to uniquely identify a
> > +          device, i.e. no other LED class device can be assigned the same label.
> > +
> > +      led-sources:
> > +        description: |
> > +          List of device current outputs the LED is connected to.
> > +        allOf:
> > +          - $ref: /schemas/types.yaml#/definitions/uint32-array
> > +          - minItems: 1
> > +            maxItems: 2
> > +            items:
> > +              minimum: 0
> > +              maximum: 1
> > +
> 
> label and led-sources are already defined in the common.txt no need to redefine them here.

If I'm going to use the new-style bindings, then I'll need to convert
common.txt over to use the new format as well so that the automated
schema validations will work. I'm willing to do that work if there is
interest from the LED / backlight maintainers. The main issue is that
there are 62 references to the file common.txt in the directory
Documentation/devicetree/bindings/leds/. Would the maintainers prefer:

- Once common.txt is converted to common.yaml, make common.txt only
  have a line stating that the common bindings were moved into
  common.yaml. We can remove this file once all of the other bindings
  are converted to the new-style format.

- Update all references to common.txt to common.yaml. (1 patch or 62
  patches?)

- Or, just go with the older-style binding format for now.

Thanks Dan for your other comments. They make sense and I'll incorporate
those changes into my next version.

Brian
