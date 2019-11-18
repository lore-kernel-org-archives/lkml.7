Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B77E3C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 20:03:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9303A20730
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 20:03:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="UxPgDGEU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726717AbfKRUDe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 15:03:34 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:46369 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726250AbfKRUDe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 15:03:34 -0500
Received: by mail-ot1-f65.google.com with SMTP id n23so15629930otr.13
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2019 12:03:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2PDaqtIBFBkrRQtsY42nVpJi6m3lJCgdaGJOcPD9Eus=;
        b=UxPgDGEUGSS2r8QojZ/ioqZmAmyhiiIEOQoy9RtBqwwu3kaOweSHsI8J4m2K+HhZA2
         mjvPBHZeE6rg6BOyz/I2PnBSCrqeMEqNQ6qYLKjizgjbfQauOxWanDCnsw3hAhfcpw40
         76vwRpGOIpHjgHlFudj72VJL3sr8VtLtvfikY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2PDaqtIBFBkrRQtsY42nVpJi6m3lJCgdaGJOcPD9Eus=;
        b=unilPI85LeywuNmryr1T3BhswiZWmFUXN8XXYfCWEt3oSI3APWg83eh2wiFWFCjqk6
         p1AFGTFpXUb/FNYZ7HzrZgIsgSQZrL8U1H5W0QY9Utlm4YD2m4eO5Rn48ALFeD8aS2jZ
         1kpG+/X//g58JGWq5U7GIPnYrZF4pr+CZN//eev5ndeBntPOmlwWkOO8BS2JgghtbqF4
         nGRnf6HBO4xSDc1+YA3b+GN9FUDxoVONulAJeBfEw0W10FAIQOBb6v0RlMJb2JEuJDtL
         OUm+7F63aOWI2bJnMVndNWN251RijU7fAW4v8DiEzTiaxwkdwypZRTjva1v13xECc8TQ
         eleg==
X-Gm-Message-State: APjAAAV8Rub+ajgKkxeK8eRbYlavxK5Okmw+iWq0wTajE1XcWyX25yfm
        MoahI4yqVQqOiCx7Hf7KUAk2Ro0I+Ale59+WCufrRQ==
X-Google-Smtp-Source: APXvYqxmAHc8pVLhK0Y0804VQwtyYsvapomac1UHPu9BRJmQq3WYdIqSwK6xX5pOlFN607Lp+Hp7TwzWoW9x/GPS1/Q=
X-Received: by 2002:a05:6830:22d0:: with SMTP id q16mr849080otc.188.1574107411531;
 Mon, 18 Nov 2019 12:03:31 -0800 (PST)
MIME-Version: 1.0
References: <20191114132436.7232-1-wambui.karugax@gmail.com>
 <8736ep1hm2.fsf@intel.com> <20191118192450.GA135013@art_vandelay>
In-Reply-To: <20191118192450.GA135013@art_vandelay>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Mon, 18 Nov 2019 21:03:20 +0100
Message-ID: <CAKMK7uG7Tb6oocrRgRFvq5oB2Rxjy+JmyOSXQtjo6Gt_WH91+A@mail.gmail.com>
Subject: Re: [PATCH 0/2] add new DRM_DEV_WARN macro
To:     Sean Paul <sean@poorly.run>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Wambui Karuga <wambui.karugax@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Dave Airlie <airlied@linux.ie>,
        Sandy Huang <hjc@rock-chips.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 18, 2019 at 8:24 PM Sean Paul <sean@poorly.run> wrote:
> On Fri, Nov 15, 2019 at 01:52:53PM +0200, Jani Nikula wrote:
> > On Thu, 14 Nov 2019, Wambui Karuga <wambui.karugax@gmail.com> wrote:
> > > This adds a new DRM_DEV_WARN helper macro for warnings log output that include
> > > device pointers. It also includes the use of the DRM_DEV_WARN macro in
> > > drm/rockchip to replace dev_warn.
> >
> > I'm trying to solicit new struct drm_device based logging macros, and
> > starting to convert to those. [1]
> >
>
> This sounds good to me, I'd much prefer the non-caps versions of these
> functions. So let's wait for those to bubble up and then convert rockchip to
> drm_dev_*

Care to ack Jani's patch directly, so this is all formal?

Jani, can you pls also add a todo.rst patch on top to adjust the
relevant item to the new color choice?

Wambui, I guess slight change of plans, it happens ...

Cheers, Daniel

>
> Sean
>
> > BR,
> > Jani.
> >
> >
> > [1] http://patchwork.freedesktop.org/patch/msgid/63d1e72b99e9c13ee5b1b362a653ff9c21e19124.1572258936.git.jani.nikula@intel.com
> >
> >
> >
> >
> > >
> > > Wambui Karuga (2):
> > >   drm/print: add DRM_DEV_WARN macro
> > >   drm/rockchip: use DRM_DEV_WARN macro in debug output
> > >
> > >  drivers/gpu/drm/rockchip/inno_hdmi.c | 3 ++-
> > >  include/drm/drm_print.h              | 9 +++++++++
> > >  2 files changed, 11 insertions(+), 1 deletion(-)
> >
> > --
> > Jani Nikula, Intel Open Source Graphics Center
>
> --
> Sean Paul, Software Engineer, Google / Chromium OS



-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
