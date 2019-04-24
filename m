Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA12AC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 15:58:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AA6421900
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 15:58:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556121485;
	bh=BaPXefsCk3cDuPEOcGo3SneaANQ8pQz0MKY+7t68kKI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=yc22Zsn9W6Wh+OJFYXopdB7Z2nNqL4wFujiR/4nV6yBc3ObOPe7HfYD+VCX/HiPvz
	 UXORUVLqyZfxsOho8SaGb6kI2Q/MyYLUuXNIGuTa7WNgHi/Vim8Z8NsoNAMS2uMkeP
	 1KPJIS7Hl1TvZBOQwYr3OX6oa/UCYXMjKqWH59PQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732089AbfDXP6E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 11:58:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:59056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732008AbfDXP6E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 11:58:04 -0400
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EC01E21904;
        Wed, 24 Apr 2019 15:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556121483;
        bh=BaPXefsCk3cDuPEOcGo3SneaANQ8pQz0MKY+7t68kKI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=1f/r8D9biHO0DpqJm4bWxybwmX65C63Uolh0tCuZ3yOKZuhHYD9Fcfm8SpAkc/bhF
         XAw/FrBB6AIm85VTDnApsl/apSc2TDjU+lbVWoIgnUelYL/RbBQN+abtFCDPeyOH0u
         9mmOksB/WRRJatP78aAu27/TORKBKgmKpOh5ItdY=
Received: by mail-qt1-f177.google.com with SMTP id j6so1623669qtq.1;
        Wed, 24 Apr 2019 08:58:02 -0700 (PDT)
X-Gm-Message-State: APjAAAUMVThIb7cioB5i5XAO7g1hAkod+HPndPah/1GIrxjheemTJ/o2
        Xhyx+JNo8fAsdxlf/SR3dBa7eoppQuDrKn1dVg==
X-Google-Smtp-Source: APXvYqxsOGSBvL7kvmVXzykgzZAnRGrA1YB7fQ098wQkGPjTWa148Ef7OWF2usmqo4JuByBWbXnP1hx+03eeUi/Z3bA=
X-Received: by 2002:ac8:7c9:: with SMTP id m9mr23942316qth.26.1556121482162;
 Wed, 24 Apr 2019 08:58:02 -0700 (PDT)
MIME-Version: 1.0
References: <20190424092505.6578-1-masneyb@onstation.org> <20190424092505.6578-3-masneyb@onstation.org>
 <20190424142037.GA20237@amd>
In-Reply-To: <20190424142037.GA20237@amd>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 24 Apr 2019 10:57:50 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJSpmG_TfNaxHKQMzVn0ig=HaBupQ22bbPAa9riuCU71Q@mail.gmail.com>
Message-ID: <CAL_JsqJSpmG_TfNaxHKQMzVn0ig=HaBupQ22bbPAa9riuCU71Q@mail.gmail.com>
Subject: Re: [PATCH v6 2/3] dt-bindings: backlight: add lm3630a bindings
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Brian Masney <masneyb@onstation.org>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Dan Murphy <dmurphy@ti.com>, Jonathan Marek <jonathan@marek.ca>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019 at 9:20 AM Pavel Machek <pavel@ucw.cz> wrote:
>
> Hi!
>
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/leds/backlight/lm3630a-backlight.yaml
> > @@ -0,0 +1,129 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/leds/backlight/lm3630a-backlight.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
>
> I'm not a great fan on links to external websites. But this is comment
> for Rob.

This is simply how json-schema works. $schema says what meta-schema
this file should validate against so it's versioned if we change the
schema format. $id is just a unique identifier and is used to resolve
$ref values. Note that these aren't live urls either (but could be at
some point in the future).

> > +title: TI LM3630A High-Efficiency Dual-String White LED
> > +
> > +maintainers:
> > +  - Lee Jones <lee.jones@linaro.org>
> > +  - Daniel Thompson <daniel.thompson@linaro.org>
> > +  - Jingoo Han <jingoohan1@gmail.com>
>
> Not a great fan of duplicating MAINTAINERS information here. But this
> is a comment for Rob, again.

Hopefully this is temporary until we move to per directory MAINTAINERS
files. Not sure what happened with that.

Rob
