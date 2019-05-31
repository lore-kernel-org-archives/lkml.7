Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 459F8C04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 07:21:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1783E23AC3
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 07:21:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="AGwQrFiO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbfEaHVg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 03:21:36 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:36823 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726330AbfEaHVf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 03:21:35 -0400
Received: by mail-it1-f194.google.com with SMTP id e184so13683526ite.1
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2019 00:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QBBKhSbZP7EAiicuPXkBfvJuEZTNKNpMjn27c5MZ3Dc=;
        b=AGwQrFiOCXgty4N4Ai5lLfQQ6Xg6MpVZHZRCHn9hb3ZDqRg/wR45SafGZhZKmmDC8y
         rHi8kv3AK9Dyf1clZUArh8rLaWgNT8PRSYqvMkcfx4hMo41rbMKlE53+ta/onOJtH6oo
         dfsWtjfgGEsFvdUTkgJxMtxVJftBAPsCWuVaQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QBBKhSbZP7EAiicuPXkBfvJuEZTNKNpMjn27c5MZ3Dc=;
        b=U0iJGnk59tKxYIpy4MsyGCiYP2+2Ua/2bIzXQIZomm2dfiSQgpH6qiSQhv0ivYcRwR
         HluiZb3GxToWoxTl4U7Mni2ZDiuwKk59hZx7uawmExBD13lBXRL4rIbp9U5lhwXI9SvC
         gJoM2oIpkkICzx2uwZrHpY5scC0VyTfZM9KicC1xGbxbh6/bdk9Bb0c5sU0+m67esWC3
         j40SEheFd0CrDSQxABZJy8Zx9QzB9QcVTC12PUBzRpqci8ZngieWXGqfALwvq6mgUOVD
         ppJQ1mqyTphKXULIq2E5gNWp7/EMeW8SquIuZpZYZVsNJToFOQeZ7t7OMDiZdpzT7c2L
         PrIg==
X-Gm-Message-State: APjAAAX0MB+UFmKb63x9dfCqYNsmZwBSODNrDx4GGt/DQl4NmN2Yle/A
        F1VBPKC8f52zpNAosVhd7/aFvsxgmvSVU3EMMxNvHw==
X-Google-Smtp-Source: APXvYqz2PDD+zioaMHLifADW+9kK68f43tOq4Amc0xMgAm0W/t6TnadR93Ukk5QMxHkQCpAl7zFjHTl9o7dS+amRmzU=
X-Received: by 2002:a24:2846:: with SMTP id h67mr6274629ith.94.1559287294453;
 Fri, 31 May 2019 00:21:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190529105615.14027-1-jagan@amarulasolutions.com>
 <20190529105615.14027-2-jagan@amarulasolutions.com> <20190531065928.4wfr3kjngefy4q2b@flea>
In-Reply-To: <20190531065928.4wfr3kjngefy4q2b@flea>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Fri, 31 May 2019 12:51:23 +0530
Message-ID: <CAMty3ZBTu5DqcL+u6KTUC=Ofe9Gwdcu8VT-kSwWb2O3n9gnrWQ@mail.gmail.com>
Subject: Re: [PATCH v9 1/9] dt-bindings: sun6i-dsi: Add A64 MIPI-DSI compatible
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Chen-Yu Tsai <wens@csie.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        linux-amarula <linux-amarula@amarulasolutions.com>,
        Sergey Suloev <ssuloev@orpaltech.com>,
        Ryan Pannell <ryan@osukl.com>, Bhushan Shah <bshah@mykolab.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 31, 2019 at 12:29 PM Maxime Ripard
<maxime.ripard@bootlin.com> wrote:
>
> On Wed, May 29, 2019 at 04:26:07PM +0530, Jagan Teki wrote:
> > The MIPI DSI controller in Allwinner A64 is similar to A33.
> >
> > But unlike A33, A64 doesn't have DSI_SCLK gating so it is valid
> > to with separate compatible for A64 on the same driver.
> >
> > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > Reviewed-by: Rob Herring <robh@kernel.org>
> > Tested-by: Merlijn Wajer <merlijn@wizzup.org>
> > ---
> >  Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.txt | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.txt b/Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.txt
> > index 1cc40663b7a2..9877398be69a 100644
> > --- a/Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.txt
> > +++ b/Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.txt
> > @@ -12,6 +12,7 @@ The DSI Encoder generates the DSI signal from the TCON's.
> >  Required properties:
> >    - compatible: value must be one of:
> >      * allwinner,sun6i-a31-mipi-dsi
> > +    * allwinner,sun50i-a64-mipi-dsi
> >    - reg: base address and size of memory-mapped region
> >    - interrupts: interrupt associated to this IP
> >    - clocks: phandles to the clocks feeding the DSI encoder
>
> We've switch to YAML now, and the compatible should be expressed that
> way now:

Yes, I have seen it few days back will update on top of that, thanks!
