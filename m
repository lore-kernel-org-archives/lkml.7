Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BD28C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 23:54:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 225722073F
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 23:54:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564444478;
	bh=7M7iM5NZ1SgdUOG+BMFQMLBU2J1/FLifWH7WWo4vukw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=bKCZ3KX1aLu1Zb8FYj/e5Fh/HzcRcRMmEB3RgBx7qtrKJ6EGY0OX3OWJA7ZEQ8FWF
	 aMeMwPUBYNh0aVWM8V35vE++70DrROnqXA6JfvYUcldNmr+EAcR+Kznfz/c8rjelJ3
	 75CXPrK3vuitDrW8PLl9wwG/QYkdSGz+8njYRJ24=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729922AbfG2Xyg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 19:54:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:41194 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728809AbfG2Xyf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 19:54:35 -0400
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 623C9206BA;
        Mon, 29 Jul 2019 23:54:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564444474;
        bh=7M7iM5NZ1SgdUOG+BMFQMLBU2J1/FLifWH7WWo4vukw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=wIDAiVgh8oFtCAHjZALXvXLlF06U5PG+b+RlokjKcUA+9gTiIQfq+hQf4JLn3jQqv
         5FCecCmkCjAKo3SLAn3us51NrlQf/6cZWaRJrH30n0bTmbsUgHMHgFxjBmnZ421Lz1
         XLXZCIiUws+DJYgL8XSsNCIr34nlTVVrVgiufrKM=
Received: by mail-qt1-f176.google.com with SMTP id w17so16966692qto.10;
        Mon, 29 Jul 2019 16:54:34 -0700 (PDT)
X-Gm-Message-State: APjAAAUgrLsv9jpLRUivJp8ogfVxrCT0n7QsumPZd4lEuq/FAy1m54JP
        tMPtYqeuC98fviLSbC6WdSkJE9krveXjHjWn1w==
X-Google-Smtp-Source: APXvYqyvVVqVtiLHXCcmAnRN5s1dQ0v6PPdL5zspMJDODprjdlHMPqDWq1VLjpfR7WA8o08e4xLxr0pSQlrAw0k6B0M=
X-Received: by 2002:aed:3f10:: with SMTP id p16mr79236510qtf.110.1564444473606;
 Mon, 29 Jul 2019 16:54:33 -0700 (PDT)
MIME-Version: 1.0
References: <20190722150414.9F97668B20@verein.lst.de> <20190725151829.DC20968B02@verein.lst.de>
 <20190726163601.o32bxqew5xavjgyi@flea> <20190729142258.GB7946@lst.de>
In-Reply-To: <20190729142258.GB7946@lst.de>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 29 Jul 2019 17:54:21 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKAU3WG3L=KP8A8u4vW=q_BQWPN-m_c+ADOwTioJ2-cmg@mail.gmail.com>
Message-ID: <CAL_JsqKAU3WG3L=KP8A8u4vW=q_BQWPN-m_c+ADOwTioJ2-cmg@mail.gmail.com>
Subject: Re: [PATCH v3 6a/7] dt-bindings: Add ANX6345 DP/eDP transmitter binding
To:     Torsten Duwe <duwe@lst.de>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        Sean Paul <seanpaul@chromium.org>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Harald Geyer <harald@ccbib.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree@vger.kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 29, 2019 at 8:23 AM Torsten Duwe <duwe@lst.de> wrote:
>
> On Fri, Jul 26, 2019 at 06:36:01PM +0200, Maxime Ripard wrote:
> > > +
> > > +  dvdd12-supply:
> > > +    maxItems: 1
> > > +    description: Regulator for 1.2V digital core power.
> > > +    $ref: /schemas/types.yaml#/definitions/phandle
> > > +
> > > +  dvdd25-supply:
> > > +    maxItems: 1
> > > +    description: Regulator for 2.5V digital core power.
> > > +    $ref: /schemas/types.yaml#/definitions/phandle
> >
> > There's no need to specify the type here, all the properties ending in
> > -supply are already checked for that type
>
> Ok, thanks for the hint.
>
> > > +  ports:
> > > +    type: object
> > > +    minItems: 1
> > > +    maxItems: 2
> > > +    description: |
> > > +      Video port 0 for LVTTL input,
> > > +      Video port 1 for eDP output (panel or connector)
> > > +      using the DT bindings defined in
> > > +      Documentation/devicetree/bindings/media/video-interfaces.txt
> >
> > You should probably describe the port@0 and port@1 nodes here as
> > well. It would allow you to express that the port 0 is mandatory and
> > the port 1 optional, which got dropped in the conversion.
>
> I would have liked to, but have not discovered yet a comprehensive source
> of information about recommended syntax and semantics of the YAML schemes.

The language is json-schema.

> Is there some central reference for these types of issues? I mean not the
> "here is a git repo with the meta-schemes" but sort of a cookbook?

Documentation/devicetree/writing-schema.md (soon .rst) and
Documentation/devicetree/bindings/example-schema.yaml attempt to do
this. Any feedback on them would be helpful.

For this case specifically, we do need to define a common graph
schema, but haven't yet. You can assume we do and only really need to
capture what Maxime said above.

Rob
