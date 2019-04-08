Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 981B9C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 14:46:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6794220879
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 14:46:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cHSIJ/3b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727185AbfDHOqn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 10:46:43 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:40256 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726372AbfDHOqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 10:46:42 -0400
Received: by mail-ua1-f66.google.com with SMTP id b8so4373394uaq.7
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2019 07:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=d/KxUcFMn5knOE76pb1A5Y9p+0/egdjAurc8BtENtIA=;
        b=cHSIJ/3b3k3gOwHkL4uUL36Sku2FUsZo6kTSa0veZ6ePGUk2xT4wFQJvaZW+mx/PVb
         TAt+PTtaPERRsmDSjdE5T+cydrNv9ghAhmsqew0344WYZU/vXVdRFzGByfpsqb6OLMYy
         4rWEecZwhA4n0n21WHFNQ8yfU0Z8c6DnAasdI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=d/KxUcFMn5knOE76pb1A5Y9p+0/egdjAurc8BtENtIA=;
        b=UdtYo7yvC0dbgbzlffcGF8AtYjyuT2+MLQwk0FyvgkEz4RCxEELW/gaAbDoWpqZ60b
         FIOVgY5hojBhZ92NBJYJqJylUo1thLI+3Wf0FYclBUvD9x2IKViYj2sh5a6M+epKpSkj
         YgyHtZSZRme4qlI6DfxkvL4xQl6Ijgv2sfu7SUxwZrBqkUNzOgw7C18SgN0N80sN/2Y2
         bwSrLP8mqmCIQr6NG8TLQ/T8/Dvcly//O3zUJDeMrakfsyfYNNLVdGM3jx3lvqhmoYFq
         kq93/n4OZPmRRtQ+uJsgpUCBvp59NgLEOjUtKof/ikGVIOSOO3zesGgtuo+WDcTMc4Ay
         ktWg==
X-Gm-Message-State: APjAAAVVi5UGEDTb527WFAmLZ5TOBTDJ1vo51SKUCLGSlo+SswOGpkQ6
        XmMT8RMp4pGJit+S62bE6QluhAOL9fI=
X-Google-Smtp-Source: APXvYqyn3krP09j6g68M/XNSBGEwOBrTl8R+CSqyZK46MtL7czlW7FQ0pigckFW4eV4vrjyzW/0jng==
X-Received: by 2002:ab0:7817:: with SMTP id x23mr4708uaq.35.1554734801173;
        Mon, 08 Apr 2019 07:46:41 -0700 (PDT)
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com. [209.85.222.43])
        by smtp.gmail.com with ESMTPSA id t207sm8581940vkb.21.2019.04.08.07.46.40
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Apr 2019 07:46:41 -0700 (PDT)
Received: by mail-ua1-f43.google.com with SMTP id n16so4360195uae.10
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2019 07:46:40 -0700 (PDT)
X-Received: by 2002:ab0:474c:: with SMTP id i12mr16099364uac.9.1554734387205;
 Mon, 08 Apr 2019 07:39:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190401171724.215780-1-dianders@chromium.org>
 <20190401171724.215780-2-dianders@chromium.org> <20190408103240.GF6644@ulmo>
In-Reply-To: <20190408103240.GF6644@ulmo>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 8 Apr 2019 07:39:37 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UJXLeEDPRAHY5-f2D4qJ4rq0LmKUDf4MANrb5KOm_x=g@mail.gmail.com>
Message-ID: <CAD=FV=UJXLeEDPRAHY5-f2D4qJ4rq0LmKUDf4MANrb5KOm_x=g@mail.gmail.com>
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

On Mon, Apr 8, 2019 at 3:32 AM Thierry Reding <thierry.reding@gmail.com> wr=
ote:
>
> On Mon, Apr 01, 2019 at 10:17:18AM -0700, Douglas Anderson wrote:
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
> > Changes in v5:
> >  - Removed bit about OS may ignore (Rob/Ezequiel)
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
> >  .../bindings/display/panel/simple-panel.txt   | 22 +++++++++++++++++++
> >  1 file changed, 22 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/display/panel/simple-pan=
el.txt b/Documentation/devicetree/bindings/display/panel/simple-panel.txt
> > index b2b872c710f2..93882268c0b9 100644
> > --- a/Documentation/devicetree/bindings/display/panel/simple-panel.txt
> > +++ b/Documentation/devicetree/bindings/display/panel/simple-panel.txt
> > @@ -15,6 +15,16 @@ Optional properties:
> >    (hot plug detect) signal, but the signal isn't hooked up so we shoul=
d
> >    hardcode the max delay from the panel spec when powering up the pane=
l.
> >
> > +panel-timing subnode
>
> Is there any reason why we need the panel- prefix? This is already part
> of a panel definition, so it's completely redundant. Why not just name
> the subnode "timing"?

It was a really long time ago since this patch series was idle for a
while, but you previous had similar feedback in v3 but ended up OK
with it.  See:

https://patchwork.kernel.org/patch/10207583/

I believe the original node name came out of some back and forth
between Rob and Sean.  As far as I can tell, the context is back in
<https://patchwork.kernel.org/patch/10203483/>.  I think Rob wanted it
to follow other similar node names.


That all being said, if you feel strongly about it being called
"timing" and Rob's OK w/ that too then I'll re-spin the series.

-Doug
