Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D16ACC432C3
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 21:12:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9DD52230F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 21:12:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=poorly.run header.i=@poorly.run header.b="APsvoPZq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbfKRVM0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 16:12:26 -0500
Received: from mail-yw1-f66.google.com ([209.85.161.66]:38614 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726712AbfKRVM0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 16:12:26 -0500
Received: by mail-yw1-f66.google.com with SMTP id m196so6443225ywd.5
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2019 13:12:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=poorly.run; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6upXDhNFo0nrsQ2L0RqECuxOTI7O5ERKPLneAxPvz7c=;
        b=APsvoPZqd3/4J1mskST0MM0sGTrFWZWLOEAYmOBonP6JvkuEWs9/P/zm2cGhbbAdwR
         RkAdbYictFRA3Lu3MV/9wWkWd1qXzUczVbmHVDRUz+00GgtdZE7BiOlTfhG84lRwIefh
         Bh11q6gC0MXkEVYaXXLbnjc0VOj2d1M3CZ4CETazCX5Pkfx61+yLw9lBNVZbrKCkVoLo
         3NeFEg3x0ez3aQDopQg9loBZHPmttmgYJwKZWeAEx7JGFnDxjUDo+BY2+ywBXULp5Eg7
         FeLIm35E200T3dXB4+wltq1sUd9Fi7m8gcFM/H5GR9jFvoQFVPEyIMQIM8hXoJmDYF+9
         BIHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6upXDhNFo0nrsQ2L0RqECuxOTI7O5ERKPLneAxPvz7c=;
        b=QRtTYK6J94vc9+M2GjNLPq1v0U5v7a6PNTIyyjLKYAd9TGG28zcjUSH+ru2StVP1eF
         gvxPYi+vvGbglOhWHDCjxDvcZyFONaBjapvGeWBR/djAU85RzyhNbDzrA6gqa9JHHt0L
         5H/TciH5kpYesCh5uMt6OChKk9Cuv6+NCD+PkSL6uKs+UrsnkUDqpvW/l69LMgrbR4QN
         mgRONoJvyfLyh7IbiUGMa4R3mdvgYJznQkksHpyM1yakBlZqg6NFHZefA53RPTpd1I96
         XBVBrKmnw3kq8PLa5vKugIgZrAVEOFXPPXdf8Xe1lkSfTbBQs/L6o95bY35ahInM21oT
         rYfQ==
X-Gm-Message-State: APjAAAW1e2SF39S90V9EmV+YdPAe6JTj/D9kszTdBg+M81Syid4NX1y0
        WcUAvxuqpiNibHyemYZsziaiGw==
X-Google-Smtp-Source: APXvYqzAinz5ZQxnMdmq3uJvhm1X1FgntGJvMLmBXoROvfsqoAMA3ftORkYq9KGMR2pOobqbP/cByQ==
X-Received: by 2002:a81:4e04:: with SMTP id c4mr9481605ywb.298.1574111544976;
        Mon, 18 Nov 2019 13:12:24 -0800 (PST)
Received: from localhost ([2620:0:1013:11:89c6:2139:5435:371d])
        by smtp.gmail.com with ESMTPSA id n191sm8487846ywd.56.2019.11.18.13.12.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 13:12:24 -0800 (PST)
Date:   Mon, 18 Nov 2019 16:12:23 -0500
From:   Sean Paul <sean@poorly.run>
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     Sean Paul <sean@poorly.run>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Wambui Karuga <wambui.karugax@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Dave Airlie <airlied@linux.ie>,
        Sandy Huang <hjc@rock-chips.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/2] add new DRM_DEV_WARN macro
Message-ID: <20191118211223.GB135013@art_vandelay>
References: <20191114132436.7232-1-wambui.karugax@gmail.com>
 <8736ep1hm2.fsf@intel.com>
 <20191118192450.GA135013@art_vandelay>
 <CAKMK7uG7Tb6oocrRgRFvq5oB2Rxjy+JmyOSXQtjo6Gt_WH91+A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKMK7uG7Tb6oocrRgRFvq5oB2Rxjy+JmyOSXQtjo6Gt_WH91+A@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 18, 2019 at 09:03:20PM +0100, Daniel Vetter wrote:
> On Mon, Nov 18, 2019 at 8:24 PM Sean Paul <sean@poorly.run> wrote:
> > On Fri, Nov 15, 2019 at 01:52:53PM +0200, Jani Nikula wrote:
> > > On Thu, 14 Nov 2019, Wambui Karuga <wambui.karugax@gmail.com> wrote:
> > > > This adds a new DRM_DEV_WARN helper macro for warnings log output that include
> > > > device pointers. It also includes the use of the DRM_DEV_WARN macro in
> > > > drm/rockchip to replace dev_warn.
> > >
> > > I'm trying to solicit new struct drm_device based logging macros, and
> > > starting to convert to those. [1]
> > >
> >
> > This sounds good to me, I'd much prefer the non-caps versions of these
> > functions. So let's wait for those to bubble up and then convert rockchip to
> > drm_dev_*
> 
> Care to ack Jani's patch directly, so this is all formal?

I just time traveled to last week and acked the whole series :)

Sean

> 
> Jani, can you pls also add a todo.rst patch on top to adjust the
> relevant item to the new color choice?
> 
> Wambui, I guess slight change of plans, it happens ...
> 
> Cheers, Daniel
> 
> >
> > Sean
> >
> > > BR,
> > > Jani.
> > >
> > >
> > > [1] http://patchwork.freedesktop.org/patch/msgid/63d1e72b99e9c13ee5b1b362a653ff9c21e19124.1572258936.git.jani.nikula@intel.com
> > >
> > >
> > >
> > >
> > > >
> > > > Wambui Karuga (2):
> > > >   drm/print: add DRM_DEV_WARN macro
> > > >   drm/rockchip: use DRM_DEV_WARN macro in debug output
> > > >
> > > >  drivers/gpu/drm/rockchip/inno_hdmi.c | 3 ++-
> > > >  include/drm/drm_print.h              | 9 +++++++++
> > > >  2 files changed, 11 insertions(+), 1 deletion(-)
> > >
> > > --
> > > Jani Nikula, Intel Open Source Graphics Center
> >
> > --
> > Sean Paul, Software Engineer, Google / Chromium OS
> 
> 
> 
> -- 
> Daniel Vetter
> Software Engineer, Intel Corporation
> +41 (0) 79 365 57 48 - http://blog.ffwll.ch

-- 
Sean Paul, Software Engineer, Google / Chromium OS
