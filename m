Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A6F1C0650E
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 16:39:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11AD621473
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 16:39:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="l8cPKTj8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729392AbfGAQjW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 12:39:22 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:34286 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729348AbfGAQjW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 12:39:22 -0400
Received: by mail-io1-f68.google.com with SMTP id k8so30339215iot.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2019 09:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kppcviH+BoC+77/HRSzA2CtnCng6H6sR34sahxlv0iM=;
        b=l8cPKTj8ipi85OjiSdxsurBNgqkamorQzNfjx/xqkapjGRKCzoSEN1wrf0A0alRim5
         pqp047CPO1eIRcvQYOHaZ7kUNhu1N2LjG8SdFidYjiFofK4vUs9GcAZvA63g4wWTZ/CL
         zedE5gR5JSyeesKh8hGIk4cLkNCN36WaOwVAY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kppcviH+BoC+77/HRSzA2CtnCng6H6sR34sahxlv0iM=;
        b=UQn0zH7gKxuzbdxx0TworslePw1n0C2KAlQUdM3JDhc9XthXm4wiMvF8sK0i6Yduwa
         wT/23fLXjSmuP9kM9vqcR8QdaFOK9zOUsBz+tVTn8lgpkaLsZUnOLtxRYi3fkuO1ZtXU
         jvZ2FhGsPvXYihURi5Vs9DaJ41pRS/Ek5N4LVh3LDjZr8MhY0NdoV/87azunAtiDjCJe
         /w/8FRG30e0qxA9jcP7h9D+67A70rKF+TU9e8vOWXbo2lyjrtEf39VXsV5q61JYGPtu4
         liCO+98CReMkX9SNq+pdo4OOz91E3riq+P4lDOp9ogrhgGQQkwU+cmMdD3lpN8pF4TVQ
         0mqw==
X-Gm-Message-State: APjAAAXGMGmBlJgGMiwR7eNw+BQHhohKRuAGwgoJ7F8XZpcI3LJ+7cPb
        HsayOKaojDmBzNeZpNgxAy+hTnfF0Ig=
X-Google-Smtp-Source: APXvYqyvohlDUoGF47N92nUN9c32+7vtzFP1FiRBbHTcm35lRSQEsvJ968F0ns56HmPMOelYJlbV5w==
X-Received: by 2002:a5d:924e:: with SMTP id e14mr14725513iol.215.1561999161378;
        Mon, 01 Jul 2019 09:39:21 -0700 (PDT)
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com. [209.85.166.49])
        by smtp.gmail.com with ESMTPSA id y17sm9870003ioa.40.2019.07.01.09.39.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Jul 2019 09:39:19 -0700 (PDT)
Received: by mail-io1-f49.google.com with SMTP id e5so30284592iok.4
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2019 09:39:19 -0700 (PDT)
X-Received: by 2002:a02:6597:: with SMTP id u145mr30862693jab.26.1561999159046;
 Mon, 01 Jul 2019 09:39:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190401171724.215780-1-dianders@chromium.org>
 <20190401171724.215780-3-dianders@chromium.org> <20190630202246.GB15102@ravnborg.org>
 <20190630205514.GA17046@ravnborg.org>
In-Reply-To: <20190630205514.GA17046@ravnborg.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 1 Jul 2019 09:39:06 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WH4kmhQA0kbKcAUx=oOeqTZiQOFCXYpVWwq+mG7Y7ofA@mail.gmail.com>
Message-ID: <CAD=FV=WH4kmhQA0kbKcAUx=oOeqTZiQOFCXYpVWwq+mG7Y7ofA@mail.gmail.com>
Subject: Re: [PATCH v5 2/7] drm/panel: simple: Add ability to override typical timing
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     devicetree@vger.kernel.org, David Airlie <airlied@linux.ie>,
        Jeffy Chen <jeffy.chen@rock-chips.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sean Paul <seanpaul@chromium.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        =?UTF-8?Q?Enric_Balletb=C3=B2?= <enric.balletbo@collabora.com>,
        =?UTF-8?Q?St=C3=A9phane_Marchesin?= <marcheu@chromium.org>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, Jun 30, 2019 at 1:55 PM Sam Ravnborg <sam@ravnborg.org> wrote:
>
> Hi Douglas.
>
> > > +
> > > +   /* Only add timings if override was not there or failed to validate */
> > > +   if (num == 0 && panel->desc->num_timings)
> > > +           num = panel_simple_get_timings_modes(panel);
> > > +
> > > +   /*
> > > +    * Only add fixed modes if timings/override added no mode.
> >
> > This part I fail to understand.
> > If we have a panel where we in panel-simple have specified the timings,
> > and done so using display_timing so with proper {min, typ, max} then it
> > should be perfectly legal to specify a more precise variant in the DT
> > file.
> > Or what did I miss here?
>
> Got it now.
> If display_mode is used for timings this is what you call "fixed mode".
> Hmm, if I got confused someone else may also be confused by this naming.

The name "fixed mode" comes from the old code, though I guess in the
old code it used to refer to a mode that came from either the
display_timing or the display_mode.

How about if I call it "panel_simple_get_from_fixed_display_mode"?
...or if you have another suggestion feel free to chime in.

NOTE: Since this feedback is minor and this patch has been outstanding
for a while (and is blocking other work), I am assuming that the best
path forward is for Heiko to land this patch with Thierry's Ack and
I'll send a follow-up.  Please yell if you disagree.  I'll respond to
each of your emails separately and then wait for your response before
sending the follow-up series.


-Doug
