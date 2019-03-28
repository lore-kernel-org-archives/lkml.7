Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ED35C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 23:57:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 323F020823
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 23:57:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ga86VdDd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728627AbfC1X50 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 19:57:26 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:36172 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728500AbfC1X50 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 19:57:26 -0400
Received: by mail-vs1-f65.google.com with SMTP id n4so285250vsm.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 16:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=J6I/v/YVpxo56EJoyi5w98mpxEiiogVWXHjkzoeLl1I=;
        b=Ga86VdDd6kWzK/FBE88ab6bo/fdaiYvHnzzqI+HiDCwHXSGdezxpJA41swbu2aV1bW
         1/eOnp90VIezOOORIq/ox96YKRX6oANi0368wQOuV+RLtwAD884Q7YGxzNpVfyyEZ+61
         nt9pER/XqQzqA6el/XQXTR7K1zyuJ+so/ySjE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=J6I/v/YVpxo56EJoyi5w98mpxEiiogVWXHjkzoeLl1I=;
        b=EMozaaZF6oevcWzOzRSg56RJc2bJCAXs/ptosIsYyqqaV84IqFBFxa9XProf2tK1iA
         8c1THWtodQIPF3Z17qLyL4tf1eSJJvcKPqANg4e8Qio1Bn9Q148MS7El+tg/pZFCMDXJ
         K2sJJ/N5ycHjTB1bWlNlxWCGjNUG9CAxeqUlzqJnPfdwMkKNWrwZpnVvH9/IdFamc++l
         aklJQ4itbvLDcJc0r+CrBaPan7XA4/DdVJQXml9FLCdVLx7bxBnvAclVJ9Cbr7w9IMRr
         iJpHZQW8u+GTLc16NdZAAfur/lxChpbfqd0V8GCVXILzzI4qzkPe6j9KHgEPwCllnoBT
         CQwA==
X-Gm-Message-State: APjAAAVqZF/zr1PoxRT4/OMb4BK5QKGSbCXY5M8ygK8hJQccb+iIOToi
        bx7liPxajsdSyxOdQEik29Tv9qd2ZUc=
X-Google-Smtp-Source: APXvYqwJmYaJS9EZXWP06TItlKxRB2VlL6oJs/zeUsBynAODYcf4nPLrrnRKY1MBQeFl0su5FD71Lw==
X-Received: by 2002:a67:f10e:: with SMTP id n14mr27179672vsk.110.1553817444749;
        Thu, 28 Mar 2019 16:57:24 -0700 (PDT)
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com. [209.85.222.54])
        by smtp.gmail.com with ESMTPSA id j186sm77506vsd.21.2019.03.28.16.57.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Mar 2019 16:57:24 -0700 (PDT)
Received: by mail-ua1-f54.google.com with SMTP id d4so97439uap.5
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 16:57:24 -0700 (PDT)
X-Received: by 2002:ab0:2692:: with SMTP id t18mr3058917uao.106.1553817025313;
 Thu, 28 Mar 2019 16:50:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190328171710.31949-1-dianders@chromium.org> <20190328171710.31949-2-dianders@chromium.org>
 <f2f82f439f2b7586cb4c83f15122d8d19952d596.camel@collabora.com>
In-Reply-To: <f2f82f439f2b7586cb4c83f15122d8d19952d596.camel@collabora.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 28 Mar 2019 16:50:13 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WOKSHWCHPv9kQT7np6v_ZYBmAsnTpAHJv7zRS_3b46JQ@mail.gmail.com>
Message-ID: <CAD=FV=WOKSHWCHPv9kQT7np6v_ZYBmAsnTpAHJv7zRS_3b46JQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/7] dt-bindings: Add panel-timing subnode to simple-panel
To:     Ezequiel Garcia <ezequiel@collabora.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Sean Paul <seanpaul@chromium.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        =?UTF-8?Q?Enric_Balletb=C3=B2?= <enric.balletbo@collabora.com>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Eric Anholt <eric@anholt.net>,
        Jeffy Chen <jeffy.chen@rock-chips.com>,
        =?UTF-8?Q?St=C3=A9phane_Marchesin?= <marcheu@chromium.org>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        David Airlie <airlied@linux.ie>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Vetter <daniel@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


On Thu, Mar 28, 2019 at 1:27 PM Ezequiel Garcia <ezequiel@collabora.com> wr=
ote:
>
> On Thu, 2019-03-28 at 10:17 -0700, Douglas Anderson wrote:
> > From: Sean Paul <seanpaul@chromium.org>
> >
> > This patch adds a new subnode to simple-panel allowing us to override
> > the typical timing expressed in the panel's display_timing.
> >
> > Changes in v2:
> >  - Split out the binding into a new patch (Rob)
> >  - display-timings is a new section (Rob)
> >  - Use the full display-timings subnode instead of picking the timing
> >    out (Rob/Thierry)
> > Changes in v3:
> >  - Go back to using the timing subnode directly, but rename to
> >    panel-timing (Rob)
> > Changes in v4:
> >  - Simplify desc. for when override should be used (Thierry/Laurent)
> >  - Removed Rob H review since it's been a year and wording changed
> >
> > Cc: Doug Anderson <dianders@chromium.org>
> > Cc: Eric Anholt <eric@anholt.net>
> > Cc: Heiko Stuebner <heiko@sntech.de>
> > Cc: Jeffy Chen <jeffy.chen@rock-chips.com>
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Cc: St=C3=A9phane Marchesin <marcheu@chromium.org>
> > Cc: Thierry Reding <thierry.reding@gmail.com>
> > Cc: devicetree@vger.kernel.org
> > Cc: dri-devel@lists.freedesktop.org
> > Cc: linux-rockchip@lists.infradead.org
> > Signed-off-by: Sean Paul <seanpaul@chromium.org>
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > ---
> >
> >  .../bindings/display/panel/simple-panel.txt   | 24 +++++++++++++++++++
> >  1 file changed, 24 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/display/panel/simple-pan=
el.txt b/Documentation/devicetree/bindings/display/panel/simple-panel.txt
> > index b2b872c710f2..6157f86ddce4 100644
> > --- a/Documentation/devicetree/bindings/display/panel/simple-panel.txt
> > +++ b/Documentation/devicetree/bindings/display/panel/simple-panel.txt
> > @@ -15,6 +15,18 @@ Optional properties:
> >    (hot plug detect) signal, but the signal isn't hooked up so we shoul=
d
> >    hardcode the max delay from the panel spec when powering up the pane=
l.
> >
> > +panel-timing subnode
> > +--------------------
> > +
> > +This optional subnode is for devices which require a mode differing
> > +from the panel's "typical" display timing.  The panel timings provided
> > +here will be ignored if they are found to be outside of allowable
> > +ranges for the given panel.
> > +
>
> Is it OK to put this comment about how the implementation
> will behave when values are out of range, given this is just a binding
> spec?
>
> Perhaps -if needed- this sentence can be rephrased to state that,
> e.g. the OS may not be able to apply these values, if the controller
> or device is unable to?

I will defer to Rob H. on this one, but I'm happy to simply remove the
last sentence.  I was trying to add a more OS-agnostic version of the
bullet points from V3 but agree that we could just remove this from
the bindings completely.


-Doug
