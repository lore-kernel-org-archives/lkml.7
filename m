Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05D24C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 13:10:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCE1E2053B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 13:10:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="S8yvcDyH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbfEGNKt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 09:10:49 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:38019 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726381AbfEGNKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 09:10:48 -0400
Received: by mail-ot1-f66.google.com with SMTP id b1so14845324otp.5
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2019 06:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pAgdAjAQ41e+k9RIOAaf7UwVPbjN19zPzB9CqtCyi8o=;
        b=S8yvcDyHGUuySevVVbPrSHU3t8AKRaaUF6KGBJy+P2dAJmiCw3ZklE01rjGliEZPW4
         C2yMlpkmHc1FHLb2I0w5+p1/BEmwSl2dl/i+CsulO4YWdZcu/KtbaktRVu7wpNNzIGXI
         zbFYwyoJyeynlp/9dqdvyIh1uQnz4KrRNOPaI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pAgdAjAQ41e+k9RIOAaf7UwVPbjN19zPzB9CqtCyi8o=;
        b=kVpmcLEfjNFWjYEg0m5yM5r+hEwwSEmLGt/cigGiPluBIh/qk2vDszc0b+N3nsu8Yy
         pZF6dxfpVpyK9W2HF45evDqz/iVToYXp2mtTVN1TVqdF/rPGT+lbX9Eyde2VNS+Vxd6R
         xqHvn2E99AV3hqrg89lSZqVPBcm0gYCoQbosd0CuLDbeiBXWk3qqv8T8w0g67JtmHeH6
         96gOwzcBNGcXyC/yU9dCmwGW5okjoLbV7OGvY2WiqgzNLDf/W84DEHZBWlbmAwePW8mi
         mM3SIWAnArfM3yDKt3Yt2EsVBTDP41B6dpUp4VGAZ38pF6Ae88ILt7PTG0URnzZ7WgN9
         CyJA==
X-Gm-Message-State: APjAAAUnGaSfFIh7HF//xCMF9eKzv2fV62eHRmwoKrCjMaJ6Uw5g7d7I
        6vPWywzreSZSGN0pIlW4CKVWkLVJa+eHwrvx5T5tWg==
X-Google-Smtp-Source: APXvYqyq6Oa3R9ujCSp5aX2pGJv5ioCCjL3fBgrFeYLXZnoYKeISsxqO4YXczAuWqNLSXAJntbNAN0ExsIJit4gfVno=
X-Received: by 2002:a05:6830:111:: with SMTP id i17mr4016302otp.322.1557234647846;
 Tue, 07 May 2019 06:10:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190501121448.3812-1-jagan@amarulasolutions.com>
 <20190501193429.GA9075@ravnborg.org> <CAMty3ZAfwVyvmAmenhrQHJcy3eq-Yb61a4WLop_8jS-7vM940A@mail.gmail.com>
 <CAL_Jsq+mYy1JF_cM7sD82aLuUSnZnwsSD6-Q-W1uTp+_oSdRmg@mail.gmail.com>
In-Reply-To: <CAL_Jsq+mYy1JF_cM7sD82aLuUSnZnwsSD6-Q-W1uTp+_oSdRmg@mail.gmail.com>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Tue, 7 May 2019 18:40:36 +0530
Message-ID: <CAMty3ZBpRABe4u26ZN91JRB+vVF4Z96k-LDoe37d6EdVDkfJsg@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/panel: simple: Add FriendlyELEC HD702E 800x1280
 LCD panel
To:     Rob Herring <robh+dt@kernel.org>
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

On Mon, May 6, 2019 at 8:34 PM Rob Herring <robh+dt@kernel.org> wrote:
>
> On Mon, May 6, 2019 at 4:56 AM Jagan Teki <jagan@amarulasolutions.com> wrote:
> >
> > Hi Sam,
> >
> > On Thu, May 2, 2019 at 1:04 AM Sam Ravnborg <sam@ravnborg.org> wrote:
> > >
> > > Hi Jagan
> > >
> > > On Wed, May 01, 2019 at 05:44:47PM +0530, Jagan Teki wrote:
> > > > HD702E lcd is FriendlyELEC developed eDP LCD panel with 800x1280
> > > > resolution. It has built in Goodix, GT9271 captive touchscreen
> > > > with backlight adjustable via PWM.
> > > >
> > > > Add support for it.
> > > >
> > > > Cc: Thierry Reding <thierry.reding@gmail.com>
> > > > Cc: Sam Ravnborg <sam@ravnborg.org>
> > > > Cc: David Airlie <airlied@linux.ie>
> > > > Cc: Daniel Vetter <daniel@ffwll.ch>
> > > > Cc: dri-devel@lists.freedesktop.org
> > > > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > >
> > > Please submit the binding in a separate patch as per
> > > Documentation/devicetree/bindings/submitting-patches.txt
> >
> > Hmm.. prepared like this initially but few of my patches were combined
> > earlier even-though I sent it separately. anyway let me separate it
> > again.
>
> For what subsystem? All the maintainers that I was aware of doing that
> have stopped.

May be it was recent, Dmitry combined by previous dt and driver changes.

https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=ae97fb589648cd5558f1ceea317404a639307501
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=a5f50c501321249d67611353dde6d68d48c5b959
