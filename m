Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE2C7C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 19:24:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D74E22304
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 19:24:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=poorly.run header.i=@poorly.run header.b="X3j1TWib"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbfKRTYw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 14:24:52 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:41392 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726453AbfKRTYw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 14:24:52 -0500
Received: by mail-yw1-f67.google.com with SMTP id j190so6298664ywf.8
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2019 11:24:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=poorly.run; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RR1Ga3A1uU2EwTdicRD/oRGttbdcdStZ/iHxBYKT5CE=;
        b=X3j1TWib3+Ts1yw/h9JSFot/7FOdRZxuSgzhQUhk9RX0px8sG0WBQZhDj4BBYPdlrY
         J4/WP8c5m+JUrfOTQmqzd3YoA61wc3CQh6jEEYyr1o9EJaG1j579HoLiQGB8tkRxyBaW
         XE9aGipx0u+/HUcxEay7fxGgq957hsoo3kGpuXpblgNkQqBm5Z5JhLDCY4uVqqWVtYD4
         WRmNouNlgix/ap6zSk2QUGxa3URJLevajDNFE3t6/jn8ofZ9vf5/RreGwxYmU8os0hcu
         9NGvn1khICOPssu0id2qHZC7cHZboqYSAGyoUNetFiJJAOh8jsKrlhFfeIKuO/tsUCGW
         jOIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RR1Ga3A1uU2EwTdicRD/oRGttbdcdStZ/iHxBYKT5CE=;
        b=PD0p8c6mjd78zJtkbOLyqXF6iCtNQbH+JRG7202dxGoCEwtkNXBbB8nWCp8zIfk2WE
         MIq6Ti/rPITTrJkAPxAlL4HsA9WcdJ7Inyu2GfbidezNlp5TKn+BdNmclehse7Xffj5Z
         gqSlVPIzD73xyF2KrWOpOSYmfgTxJTHkwGBoLchr9XeVa5/l0P2BMaOpx4XGYYGaRlxB
         H6uXc3Yrco9ZXq4+7TCJqC+495KoE7fC/m2W5V4LdT4/3BgG9sH9M/Fyuvj+nnFKFscI
         9RtJTFc6RqJDrsmhyNgIyemdLo2xm+kHjZHMUCSdLj+z9jP2wMHcrlybHtSM+S5q2NPI
         KlRg==
X-Gm-Message-State: APjAAAWTgiwrXk7dzM0axGrSnMpe9vNwTpDs3f+QOiTdHh1TjoD8qDs8
        Q8CPlZjQ1+QI+d9unTrbr1JPiw==
X-Google-Smtp-Source: APXvYqzl9A6vN6o+ULDkUlZz1ITko3Pi29zzVl0fCErvVOD1nwPrfbxJyGG33yD6KHdyQOeaz77hbQ==
X-Received: by 2002:a81:49d1:: with SMTP id w200mr19894554ywa.169.1574105091585;
        Mon, 18 Nov 2019 11:24:51 -0800 (PST)
Received: from localhost ([2620:0:1013:11:89c6:2139:5435:371d])
        by smtp.gmail.com with ESMTPSA id r196sm8953955ywg.102.2019.11.18.11.24.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 11:24:50 -0800 (PST)
Date:   Mon, 18 Nov 2019 14:24:50 -0500
From:   Sean Paul <sean@poorly.run>
To:     Jani Nikula <jani.nikula@linux.intel.com>
Cc:     Wambui Karuga <wambui.karugax@gmail.com>,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        sean@poorly.run, airlied@linux.ie, daniel@ffwll.ch,
        hjc@rock-chips.com, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] add new DRM_DEV_WARN macro
Message-ID: <20191118192450.GA135013@art_vandelay>
References: <20191114132436.7232-1-wambui.karugax@gmail.com>
 <8736ep1hm2.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8736ep1hm2.fsf@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 15, 2019 at 01:52:53PM +0200, Jani Nikula wrote:
> On Thu, 14 Nov 2019, Wambui Karuga <wambui.karugax@gmail.com> wrote:
> > This adds a new DRM_DEV_WARN helper macro for warnings log output that include
> > device pointers. It also includes the use of the DRM_DEV_WARN macro in
> > drm/rockchip to replace dev_warn.
> 
> I'm trying to solicit new struct drm_device based logging macros, and
> starting to convert to those. [1]
> 

This sounds good to me, I'd much prefer the non-caps versions of these
functions. So let's wait for those to bubble up and then convert rockchip to
drm_dev_*

Sean

> BR,
> Jani.
> 
> 
> [1] http://patchwork.freedesktop.org/patch/msgid/63d1e72b99e9c13ee5b1b362a653ff9c21e19124.1572258936.git.jani.nikula@intel.com
> 
> 
> 
> 
> >
> > Wambui Karuga (2):
> >   drm/print: add DRM_DEV_WARN macro
> >   drm/rockchip: use DRM_DEV_WARN macro in debug output
> >
> >  drivers/gpu/drm/rockchip/inno_hdmi.c | 3 ++-
> >  include/drm/drm_print.h              | 9 +++++++++
> >  2 files changed, 11 insertions(+), 1 deletion(-)
> 
> -- 
> Jani Nikula, Intel Open Source Graphics Center

-- 
Sean Paul, Software Engineer, Google / Chromium OS
