Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5879C7618F
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 00:29:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80A0320693
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 00:29:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qrzqnSsA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732926AbfGPA3N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 20:29:13 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:43775 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730355AbfGPA3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 20:29:12 -0400
Received: by mail-ot1-f68.google.com with SMTP id h59so15205831otb.10;
        Mon, 15 Jul 2019 17:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5BYdUBysZ67vKMguvZgCh6yaor9Vs/Z93uWHz9zlur8=;
        b=qrzqnSsAKZNB/gem9bh/PkqLvVoR1oPCSliwxzsHir00TcpgIFy8AqTQIBspieq+bY
         oSinjoTFA9vRBFsRFOrXQbG3M9Xw0dvRlMoiIcewyU5D+7zxapkXZioy952S9ieXo8J3
         dLEGfocIuYgtUOQ8Y89CqwaILV2mKIj47y1DGwoa84qicsAyMD2nX3HzDKqHZEZM0VoU
         CYPCCAMkyM6+67xwDgCSc9rCBA++QDEQVW34C6PFmHyd7sqerODgwUXcAE3ynqQUQXOI
         a3XMHvh26a4Lw21UNpCplFEdq1j6AKNJddJrQ0gLoN9URjYCbKhN8JyfnM1q7XosTYyS
         GsSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5BYdUBysZ67vKMguvZgCh6yaor9Vs/Z93uWHz9zlur8=;
        b=RFmTn/dASYH9Mrd6ofqO+W95hjGxm+4BcrqtQtQOFxI5Af+pvOiQAG+W774f7ePX8r
         mqCAX/n98UlID1tI0YTiL+BFVkaEWq3R+GmcvdCXkzSwIURBEJBSXWJgbN4KgyKirgEW
         89W2xjAeBaVGp/XhgTgeNQs1p0ZMHLGNfkRsku7fiJb0jsgji2LPoeIHljILxys4MO9K
         FlZukemjWZcWTrdavoSjp/F9Y64xTU/MnkFJm/Dvc99oj4bLJsT27KY3xPMt+dHglLT4
         vzsSZJ7Q/mhDa0qKsyM9U/6XSfgO26wR+GJ0V0EenGF8xXdeMAIckz//kLHdxqIPghby
         sL6Q==
X-Gm-Message-State: APjAAAXzpwMdbGSpsw5LolCPI0LFIc36FV/q9WLVemGojtJ+s9B1FlMV
        h9/BFxWe0wIQQImkph9x+I9Kw50OlPw1Chh7sq4=
X-Google-Smtp-Source: APXvYqyEwg0cMSPwazZQij8oSS8ufGofjpqsKvgU98cS9UwddqUTmsuhAclAe7DHgcfs5tJkXQ2qzoJLnu9bi6JTBlk=
X-Received: by 2002:a9d:4b02:: with SMTP id q2mr2561759otf.312.1563236951460;
 Mon, 15 Jul 2019 17:29:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190607094030.GA12373@lst.de> <66707fcc-b48e-02d3-5ed7-6b7e77d53266@samsung.com>
 <20190612152022.c3cfhp4cauhzhfyr@flea> <bb2c2c00-b46e-1984-088f-861ac8952331@samsung.com>
 <20190701095842.fvganvycce2cy7jn@flea> <CA+E=qVdsYV2Bxk245=Myq=otd7-7WHzUnSJN8_1dciAzvSOG8g@mail.gmail.com>
 <20190709085532.cdqv7whuesrjs64c@flea> <CA+E=qVdz4vfU3rtTTKjYdM+4UA+=FWheJfWOMaDtFMnWQ1rHbw@mail.gmail.com>
 <20190710114042.ybgavnxb4hgqrtor@flea> <CA+E=qVdFoT137pADfxz3uMwhOqjqrA9+6hBeOfbJxuH-M-3Pjw@mail.gmail.com>
 <20190712201543.krhsfjepd3cqndla@flea>
In-Reply-To: <20190712201543.krhsfjepd3cqndla@flea>
From:   Vasily Khoruzhick <anarsoul@gmail.com>
Date:   Mon, 15 Jul 2019 17:28:53 -0700
Message-ID: <CA+E=qVeDpLqAM6Qsd6oHfeYHB_JHdSb5GtY7i994GT5_RW4_Bg@mail.gmail.com>
Subject: Re: [PATCH v2 7/7] arm64: dts: allwinner: a64: enable ANX6345 bridge
 on Teres-I
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Andrzej Hajda <a.hajda@samsung.com>, Torsten Duwe <duwe@lst.de>,
        Harald Geyer <harald@ccbib.org>, Chen-Yu Tsai <wens@csie.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        Sean Paul <seanpaul@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree <devicetree@vger.kernel.org>,
        arm-linux <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 12, 2019 at 1:15 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> On Wed, Jul 10, 2019 at 03:11:04PM -0700, Vasily Khoruzhick wrote:
> > On Wed, Jul 10, 2019 at 4:40 AM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> > > > > > There's another issue: if we introduce edp-connector we'll have to
> > > > > > specify power up delays somewhere (in dts? or in platform driver?), so
> > > > > > edp-connector doesn't really solve the issue of multiple panels with
> > > > > > same motherboard.
> > > > >
> > > > > And that's what that compatible is about :)
> > > >
> > > > Sorry, I fail to see how it would be different from using existing
> > > > panels infrastructure and different panels compatibles. I think Rob's
> > > > idea was to introduce generic edp-connector.
> > >
> > > Again, there's no such thing as a generic edp-connector. The spec
> > > doesn't define anything related to the power sequence for example.
> > >
> > > > If we can't make it generic then let's use panel infrastructure.
> > >
> > > Which uses a device specific compatible. Really, I'm not sure what
> > > your objection and / or argument is here.
> > >
> > > In addition, when that was brought up in the discussion, you rejected
> > > it because it was inconvenient:
> > > https://patchwork.freedesktop.org/patch/283012/?series=56163&rev=1#comment_535206
> >
> > It is inconvenient, but I don't understand how having board-specific
> > connectors fixes it.
>
> How it would not fix it?

I think I got your idea, but yet I think it's not the best solution.

Do I understand correctly that you're proposing to introduce
board-specific edp-connector driver that will be aware of worst case
power up delays and will control backlight and power?

Then why not to add another board-specific panel (e.g.
"pine64,pinebook-panel") to simple-panel.c that does the same?

> You'll have one connector, without the need to describe each and every
> panel in the device tree and rely on the EDID instead, and you'll have
> the option to power up the regulator you need.
>
> I really don't understand what's the issue here, so let's take a step
> back. What are is the issue , what are your requirements, and how
> would you like that to be described ?

We have a device (Pinebook) that uses the same board with multiple edp
panels. So far there're pinebooks with 3 different panels: 11" with
768p panel, 11" with 1080p panel, 14" with 768p panel.

Currently there's no way to describe all pinebooks with a single dts.
There's a simple workaround though -- we can just specify a panel with
worst power up delays in dts and it'll work since anx6345 driver
ignores panel modes anyway and uses EDID.

Originally I proposed to extend simple-panel driver to support generic
edp-panel but it was rejected. I still believe that it's the best
solution assuming we can specify delays in dts, since panels list is
specific to particular device and it probably can't be reused, i.e.
there's no good reason to move it into C code.

Rob Herring proposed to introduce edp-connector. While I still believe
that it's not accurate description of hardware since it'll have to
have backlight node (backlight is actually panel property) I was OK
with this approach assuming we can store delays in dts.

Later it evolved into board-specific edp-connector.

So far I don't understand why everyone is trying to avoid introducing
edp-panel driver that can read delays from dts. Basically, I don't
understand what's the magic behind simple-panel.c and why new panels
should be added there rather than described in dts. [1] Doesn't
explain that.

[1] http://sietch-tagr.blogspot.com/2016/04/display-panels-are-not-special.html

Regards,
Vasily


> Maxime
>
> --
> Maxime Ripard, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
