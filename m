Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED635C04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 15:04:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBCFD2087F
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 15:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557155067;
	bh=GTU8OTjGtl5LOFT7cRg59KsW701NKsE0VzSWQUozfUE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=OGJUaS8FwfWgOKdYnIYgnfZr2mgECoEZtcgqTOHUSyiAUS880knw2TtmIs5oT+eXb
	 LEcCkjN70w1EcJFQ4FUL5nyE20YhPLF9xUUr5qMR9YQ4dBHoYd4v+Xsqq2F/1Rx8er
	 lOFTOQ4DXal94WSlpwY28mr9IdXlfKWAecFjEM2Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727939AbfEFPE0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 11:04:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:35878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726496AbfEFPEY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 11:04:24 -0400
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 339E821530;
        Mon,  6 May 2019 15:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557155063;
        bh=GTU8OTjGtl5LOFT7cRg59KsW701NKsE0VzSWQUozfUE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Cvs5PHrbtmKdII0xM3nLCehc/8f272vJsChhVCWWGXtXnPy7j1H/KGXvY2kmKL2BW
         ztsO2Cyzhz3QDyMR2bZxoONjXQdNpFbU42iJMQvfAsfgu9+xrUYnRYmd6+1vxUO5xT
         aEepz0ihsx+ItjP/ZKs1EzwY1OQWrEXvEeWPn5E8=
Received: by mail-qt1-f175.google.com with SMTP id a17so916220qth.3;
        Mon, 06 May 2019 08:04:23 -0700 (PDT)
X-Gm-Message-State: APjAAAVnxHMPXMMnu0dzdtwns4A9qAT51tAzYWr2Hb9NvJRBrfgc42+P
        tJYTEK87m7QrURWOyVvUY6DaKew3ViRfqkf+aA==
X-Google-Smtp-Source: APXvYqwTGaTwpQhCxUNSWGGAJ6lrotLyqlbDqtumhudX19OwLFLZtjwpqmue9eoggzwpO7k4YQzf0M3Agg9uhmRbdSE=
X-Received: by 2002:ac8:610f:: with SMTP id a15mr21088874qtm.257.1557155062365;
 Mon, 06 May 2019 08:04:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190501121448.3812-1-jagan@amarulasolutions.com>
 <20190501193429.GA9075@ravnborg.org> <CAMty3ZAfwVyvmAmenhrQHJcy3eq-Yb61a4WLop_8jS-7vM940A@mail.gmail.com>
In-Reply-To: <CAMty3ZAfwVyvmAmenhrQHJcy3eq-Yb61a4WLop_8jS-7vM940A@mail.gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 6 May 2019 10:04:10 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+mYy1JF_cM7sD82aLuUSnZnwsSD6-Q-W1uTp+_oSdRmg@mail.gmail.com>
Message-ID: <CAL_Jsq+mYy1JF_cM7sD82aLuUSnZnwsSD6-Q-W1uTp+_oSdRmg@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/panel: simple: Add FriendlyELEC HD702E 800x1280
 LCD panel
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Sam Ravnborg <sam@ravnborg.org>, Heiko Stuebner <heiko@sntech.de>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-amarula <linux-amarula@amarulasolutions.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 6, 2019 at 4:56 AM Jagan Teki <jagan@amarulasolutions.com> wrote:
>
> Hi Sam,
>
> On Thu, May 2, 2019 at 1:04 AM Sam Ravnborg <sam@ravnborg.org> wrote:
> >
> > Hi Jagan
> >
> > On Wed, May 01, 2019 at 05:44:47PM +0530, Jagan Teki wrote:
> > > HD702E lcd is FriendlyELEC developed eDP LCD panel with 800x1280
> > > resolution. It has built in Goodix, GT9271 captive touchscreen
> > > with backlight adjustable via PWM.
> > >
> > > Add support for it.
> > >
> > > Cc: Thierry Reding <thierry.reding@gmail.com>
> > > Cc: Sam Ravnborg <sam@ravnborg.org>
> > > Cc: David Airlie <airlied@linux.ie>
> > > Cc: Daniel Vetter <daniel@ffwll.ch>
> > > Cc: dri-devel@lists.freedesktop.org
> > > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> >
> > Please submit the binding in a separate patch as per
> > Documentation/devicetree/bindings/submitting-patches.txt
>
> Hmm.. prepared like this initially but few of my patches were combined
> earlier even-though I sent it separately. anyway let me separate it
> again.

For what subsystem? All the maintainers that I was aware of doing that
have stopped.

Rob
