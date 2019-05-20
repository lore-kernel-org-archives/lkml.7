Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22B61C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 18:36:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBA8A214DA
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 18:35:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SXkXCP1G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726515AbfETSf7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 14:35:59 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:43403 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725985AbfETSf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 14:35:58 -0400
Received: by mail-vs1-f68.google.com with SMTP id d128so9518380vsc.10
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 11:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=rJByBVnGlp63e7yCKsZ7SDuzR3kRoRVQ2u81Jed5J5c=;
        b=SXkXCP1GPoj17g4AfmKPdPV0NMDi4QcPSc930K1MaUzykox1V/AWM7p2qi1vBMUV6A
         59guNLCDAi9jEpOeuMIHyL4RMfZYpZB5w864pCNBczZY7zbrSjAe4aT6y3rUL1H7rohE
         f828A3dpBu61qyr0ohzqi8XBPtXz4sf44/Wug=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=rJByBVnGlp63e7yCKsZ7SDuzR3kRoRVQ2u81Jed5J5c=;
        b=LmVOMD4nvBcKt8lipGMeniGwAnpxdAUlOUnfQfe+YxMaMWU3kheks6SbVvrYgef8Dj
         BcMTDHGOac2szpmYo3X+4MiCFprK6AM23/peBK99QY5CAoqc9C+X3LxH4c9rSDJCevZI
         pV7Jxa79PtM2H1vc5LXfYZRoUAHmZ+Pal5vn8Emiu8+jBB694jShoEEtsvVWT2JAe/DI
         dnLjJ8u9Apfq5t6MmScxOi8n+k7R1AAstrySDJGjzytPK0Dptu+XlrkKptj29e7/BqqU
         xtUvkCWULOxtBVsqYenCUFxBCgld8uhoUBU6lxaa9VFPeAVRPsqsqrkJAeWKlzB82MRp
         0Ksg==
X-Gm-Message-State: APjAAAVOJjwkj47LE2w+319Gj0kLCa8UzJl/jTUZGNEl8loRtONV2CZk
        ANVyRu52IzxNPiomfTR1iuG80qxPuyY=
X-Google-Smtp-Source: APXvYqxGlES1kF+iF6zicr9ErKNXgm1NK8XRvhUc0aRnimZuK7oX07kjHmPEUtVh7f8noVveCkX6Jw==
X-Received: by 2002:a67:e286:: with SMTP id g6mr31067316vsf.113.1558377356673;
        Mon, 20 May 2019 11:35:56 -0700 (PDT)
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com. [209.85.217.46])
        by smtp.gmail.com with ESMTPSA id j63sm6495817vke.8.2019.05.20.11.35.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 May 2019 11:35:55 -0700 (PDT)
Received: by mail-vs1-f46.google.com with SMTP id o5so9549185vsq.4
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 11:35:55 -0700 (PDT)
X-Received: by 2002:a67:dd8e:: with SMTP id i14mr31065192vsk.149.1558377354571;
 Mon, 20 May 2019 11:35:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190401171724.215780-1-dianders@chromium.org>
 <20190401171724.215780-2-dianders@chromium.org> <20190408103240.GF6644@ulmo> <CAD=FV=UJXLeEDPRAHY5-f2D4qJ4rq0LmKUDf4MANrb5KOm_x=g@mail.gmail.com>
In-Reply-To: <CAD=FV=UJXLeEDPRAHY5-f2D4qJ4rq0LmKUDf4MANrb5KOm_x=g@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 20 May 2019 11:35:43 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WKkfhS8q2Wnx6PfHyq8m6oGhu=RideOykdTQ4dJrwfUg@mail.gmail.com>
Message-ID: <CAD=FV=WKkfhS8q2Wnx6PfHyq8m6oGhu=RideOykdTQ4dJrwfUg@mail.gmail.com>
Subject: Re: [PATCH v5 1/7] dt-bindings: Add panel-timing subnode to simple-panel
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Sean Paul <seanpaul@chromium.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Ezequiel Garcia <ezequiel@collabora.com>,
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

Thierry,

On Mon, Apr 8, 2019 at 7:39 AM Doug Anderson <dianders@chromium.org> wrote:
>
> Thierry,
>
> On Mon, Apr 8, 2019 at 3:32 AM Thierry Reding <thierry.reding@gmail.com> =
wrote:
> >
> > On Mon, Apr 01, 2019 at 10:17:18AM -0700, Douglas Anderson wrote:
> > > From: Sean Paul <seanpaul@chromium.org>
> > >
> > > This patch adds a new subnode to simple-panel allowing us to override
> > > the typical timing expressed in the panel's display_timing.
> > >
> > > Changes in v2:
> > >  - Split out the binding into a new patch (Rob)
> > >  - display-timings is a new section (Rob)
> > >  - Use the full display-timings subnode instead of picking the timing
> > >    out (Rob/Thierry)
> > > Changes in v3:
> > >  - Go back to using the timing subnode directly, but rename to
> > >    panel-timing (Rob)
> > > Changes in v4:
> > >  - Simplify desc. for when override should be used (Thierry/Laurent)
> > >  - Removed Rob H review since it's been a year and wording changed
> > > Changes in v5:
> > >  - Removed bit about OS may ignore (Rob/Ezequiel)
> > >
> > > Cc: Doug Anderson <dianders@chromium.org>
> > > Cc: Eric Anholt <eric@anholt.net>
> > > Cc: Heiko Stuebner <heiko@sntech.de>
> > > Cc: Jeffy Chen <jeffy.chen@rock-chips.com>
> > > Cc: Rob Herring <robh+dt@kernel.org>
> > > Cc: St=C3=A9phane Marchesin <marcheu@chromium.org>
> > > Cc: Thierry Reding <thierry.reding@gmail.com>
> > > Cc: devicetree@vger.kernel.org
> > > Cc: dri-devel@lists.freedesktop.org
> > > Cc: linux-rockchip@lists.infradead.org
> > > Signed-off-by: Sean Paul <seanpaul@chromium.org>
> > > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > > ---
> > >
> > >  .../bindings/display/panel/simple-panel.txt   | 22 +++++++++++++++++=
++
> > >  1 file changed, 22 insertions(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/display/panel/simple-p=
anel.txt b/Documentation/devicetree/bindings/display/panel/simple-panel.txt
> > > index b2b872c710f2..93882268c0b9 100644
> > > --- a/Documentation/devicetree/bindings/display/panel/simple-panel.tx=
t
> > > +++ b/Documentation/devicetree/bindings/display/panel/simple-panel.tx=
t
> > > @@ -15,6 +15,16 @@ Optional properties:
> > >    (hot plug detect) signal, but the signal isn't hooked up so we sho=
uld
> > >    hardcode the max delay from the panel spec when powering up the pa=
nel.
> > >
> > > +panel-timing subnode
> >
> > Is there any reason why we need the panel- prefix? This is already part
> > of a panel definition, so it's completely redundant. Why not just name
> > the subnode "timing"?
>
> It was a really long time ago since this patch series was idle for a
> while, but you previous had similar feedback in v3 but ended up OK
> with it.  See:
>
> https://patchwork.kernel.org/patch/10207583/
>
> I believe the original node name came out of some back and forth
> between Rob and Sean.  As far as I can tell, the context is back in
> <https://patchwork.kernel.org/patch/10203483/>.  I think Rob wanted it
> to follow other similar node names.
>
>
> That all being said, if you feel strongly about it being called
> "timing" and Rob's OK w/ that too then I'll re-spin the series.

With 5.2-rc1 out, maybe this series is ready to land?  If you'd like
me to change things as per above I can.  ...but it feels like keeping
the already-agreed-upon name might be easiest / best?  Presumably
you'd land patches 1, 2, 4, and 5 and then Heiko could land the dts
patches?

Thanks!

-Doug
