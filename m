Return-Path: <SRS0=A1VX=SJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 520C4C10F0E
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 11:28:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D36020B1F
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 11:28:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=onstation.org header.i=@onstation.org header.b="UDoNhSYo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726501AbfDGL2Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Apr 2019 07:28:24 -0400
Received: from onstation.org ([52.200.56.107]:56468 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726245AbfDGL2X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Apr 2019 07:28:23 -0400
Received: from localhost (c-98-239-145-235.hsd1.wv.comcast.net [98.239.145.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: masneyb)
        by onstation.org (Postfix) with ESMTPSA id 1F61F3EE68;
        Sun,  7 Apr 2019 11:28:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=onstation.org;
        s=default; t=1554636502;
        bh=vpMqsdsNHGaPr7vvdFnzl7khluIySmMwQJVbwnsvz5w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UDoNhSYodRYRlsTqqsqSCiNzS06vLo0B+U3gkZcqTwsIDMLAV1MXlb/1yZfxg7g9E
         jlIRnHlyQvlx3cyLDkvj1Gfg2DfifhNvdPyWPMTneL3BJB769EOy5XqMyEMEBsneVz
         uJvZHJRVIkcsYWTbJjrpcKzzC4T2Bi+xMsdhS/EE=
Date:   Sun, 7 Apr 2019 07:28:21 -0400
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
Message-ID: <20190407112821.GA6922@basecamp>
References: <20190401103034.21062-1-masneyb@onstation.org>
 <20190401103034.21062-3-masneyb@onstation.org>
 <68229e7f-4749-cde5-f541-793ab614084d@ti.com>
 <20190402132440.GA10359@basecamp>
 <c88d954a-ce37-35dc-414b-df28d6095d89@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c88d954a-ce37-35dc-414b-df28d6095d89@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan,

On Tue, Apr 02, 2019 at 08:44:22AM -0500, Dan Murphy wrote:
> Also one other comment I noticed when reviewing the code that there is no definition to
> which child led properties are optional and which are required?

With the new YAML bindings, there is a separate toplevel 'required' tag in
the schema. Here is a snippet from my last submission that illustrates
this:

    properties:
      compatible:
        const: ti,lm3630a
    
      reg:
        maxItems: 1
    
      ti,linear-mapping-mode:
        description: |
          Enable linear mapping mode. If disabled, then it will use exponential
          mapping mode in which the ramp up/down appears to have a more uniform
          transition to the human eye.
        type: boolean
    
    required:
      - compatible
      - reg

So 'ti,linear-mapping-mode' is optional in this example.

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

We'll still need to define the led-sources and label in this binding
with the new format even though it will also be in the LED common
bindings. We won't have to put the common things like the description
since that information will come from the common binding. We only need
to specify the additional constraints like the min/max number of items
and the min/max value for each item for this particular example.

Brian
