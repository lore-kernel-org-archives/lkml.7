Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 446A7C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 15:10:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02D48205F4
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 15:10:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=onstation.org header.i=@onstation.org header.b="Qu+X1sO9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732607AbfDQPKv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 11:10:51 -0400
Received: from onstation.org ([52.200.56.107]:43318 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729395AbfDQPKv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 11:10:51 -0400
Received: from localhost (c-98-239-145-235.hsd1.wv.comcast.net [98.239.145.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: masneyb)
        by onstation.org (Postfix) with ESMTPSA id DB6233E8E1;
        Wed, 17 Apr 2019 15:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=onstation.org;
        s=default; t=1555513850;
        bh=oqLqGPgG/uQ6kYBJLlbh+vClHzm6WK5R1zPdHm69Iok=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Qu+X1sO96vjDD4kzUZ1fD1Z/4djVpsh/S5gtdzhVECJTYUs/k8QLxz8EiJ/w6X9ZH
         sDqYRDWKl6nIqtSPvT3Bs6IYpWPtBy/gJEsm8a7+EXGmaHEGJj0cP1lhIk/cuu0D4e
         ehZzIsAEFUCY38NcnW6LrqiU9LXH1FIZ0e9MF7As=
Date:   Wed, 17 Apr 2019 11:10:49 -0400
From:   Brian Masney <masneyb@onstation.org>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Lee Jones <lee.jones@linaro.org>,
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
        Dan Murphy <dmurphy@ti.com>, Jonathan Marek <jonathan@marek.ca>
Subject: Re: [PATCH v4 2/3] dt-bindings: backlight: add lm3630a bindings
Message-ID: <20190417151049.GA18138@basecamp>
References: <20190416235350.13742-1-masneyb@onstation.org>
 <20190416235350.13742-3-masneyb@onstation.org>
 <CAL_Jsq+YnjDGmLODXy6M1GpixMV=spfc809atGkrighvy=QPHg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_Jsq+YnjDGmLODXy6M1GpixMV=spfc809atGkrighvy=QPHg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 17, 2019 at 08:34:33AM -0500, Rob Herring wrote:
> On Tue, Apr 16, 2019 at 6:54 PM Brian Masney <masneyb@onstation.org> wrote:
> >
> > Add new backlight bindings for the TI LM3630A dual-string white LED.
> >
> > Signed-off-by: Brian Masney <masneyb@onstation.org>
> > ---
> > Rob: Since the common bindings aren't converted to the new JSON schema
> > yet, I'm not sure how to do led-sources here. I would expect that we'd
> > have the uint32-array on the common binding once it exists. I had to
> > add it here to keep 'make dt_binding_check' happy. I left the
> > description off though for that property since that'll come from common
> > once its converted.
> 
> What was the error? '$ref' shouldn't be needed for this. The tooling
> has no knowledge whether there's common schema or not. So you probably
> have some pattern the meta-schema doesn't like and we need to fix.

Ahh, you're right... it works without the $ref. I just needed the
minItems and maxItems to fix the error I originally saw.

I'll wait for feedback from Dan before I send out another version with
your changes.

Thanks,

Brian
