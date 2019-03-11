Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCA10C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:24:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8561206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:24:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="Zh2e6nbJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727832AbfCKNYJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 09:24:09 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:33398 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726977AbfCKNYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 09:24:02 -0400
Received: by mail-ed1-f66.google.com with SMTP id d12so4002081edp.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 06:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=PZF5lWUEY+LMwRBVuoqH3/fkw3bGcuiGAdYFuVZ7LPQ=;
        b=Zh2e6nbJJ8zHh1oalJbr/VF2+0jTnYBZLRVhNsdP+4WGyQVZXVkkPnXiU2yP/zjdJR
         6KtxnXafWXzdRAOMVVzhZI3WVOONMZ28VWWg8IxVM8+TmnCb0kxolkij2pdBkeEVEyGI
         gvMn3nZYYF0rJTXg2nxjTbEkYd6TZ01/Kc+Qw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=PZF5lWUEY+LMwRBVuoqH3/fkw3bGcuiGAdYFuVZ7LPQ=;
        b=ke+Qa0DNET22WWP2T+CiIwAJY/nf50k6yyyT9mJYu0tR+emuU5NMmFZTLsQ24ACAQm
         z5/rl2vkgvaISytXlr05/jOzhOcpFRptuoonnLgG79BjWrZ1rc6trRWnI5KYQX/XOPH0
         j3/6lYh9ip1RdVQ7TGmxEaoFdHviF9Wg/7FuVRvqJSbhp1+NZH2Tu8qhz5ZsOvwznCvF
         mO3J8v+WgUp1WD0C4fmNP4tRqAZjmtdA4EtB1wbv1eyLxnQvAwhyknBfDjQFbwy7NNTo
         Wi4OnvP1FXgQrIXfHs7bE2y8Byo+Sofke6yrjmteOyQ/lOXuret2eE6XxD825H0+C2KC
         wJ8w==
X-Gm-Message-State: APjAAAWIRfV9jaFelkSMJRlKuLKcA7dJtEaohcgwTiPUT2+bKuBgG/T2
        psgqrWyeWhY5fhLvzVuQXM3Aiw==
X-Google-Smtp-Source: APXvYqwzuj9tjFTMwXsd2EOvLXuzL0uIBEWMJw3jWz+rI3HU9NitdOfAEawPO5tkVEIg9yy4icQUcg==
X-Received: by 2002:a17:906:512:: with SMTP id j18mr9584026eja.12.1552310640979;
        Mon, 11 Mar 2019 06:24:00 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id 3sm3058450ejx.2.2019.03.11.06.23.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Mar 2019 06:24:00 -0700 (PDT)
Date:   Mon, 11 Mar 2019 14:23:58 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        virtualization@lists.linux-foundation.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/bochs: Fix NULL dereference on atomic_disable helper
Message-ID: <20190311132358.GF2665@phenom.ffwll.local>
Mail-Followup-To: Gerd Hoffmann <kraxel@redhat.com>,
        Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        David Airlie <airlied@linux.ie>,
        virtualization@lists.linux-foundation.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20190310212150.xhhb4abzm7j3ain2@smtp.gmail.com>
 <20190311062200.4mtel3j5fjxtxrcf@sirius.home.kraxel.org>
 <20190311101159.t6mbzm5sdwuh5muc@smtp.gmail.com>
 <20190311130716.6hjqci43clic5lxx@sirius.home.kraxel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190311130716.6hjqci43clic5lxx@sirius.home.kraxel.org>
X-Operating-System: Linux phenom 4.19.0-1-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 11, 2019 at 02:07:16PM +0100, Gerd Hoffmann wrote:
>   Hi,
> 
> > > >  static void bochs_crtc_atomic_flush(struct drm_crtc *crtc,
> > > >  				    struct drm_crtc_state *old_crtc_state)
> > > >  {
> > > > @@ -66,6 +71,7 @@ static const struct drm_crtc_funcs bochs_crtc_funcs = {
> > > >  static const struct drm_crtc_helper_funcs bochs_helper_funcs = {
> > > >  	.mode_set_nofb = bochs_crtc_mode_set_nofb,
> > > >  	.atomic_enable = bochs_crtc_atomic_enable,
> > > > +	.atomic_disable = bochs_crtc_atomic_disable,
> > > 
> > > Shouldn't we make the callback optional instead of adding empty dummy
> > > functions to drivers?
> > 
> > Hi Gerd,
> > 
> > I agree, and I can work in this issue.
> > Just one question, should we make atomic_enable optional as well?
> 
> IIRC the drm code checks for the atomic_enable callback presence to
> figure whenever it should take the atomic or legacy code paths.

It should check for drm_driver->mode_config.funcs.atomic_commit for that,
see drm_drv_uses_atomic_modeset(). Anything else should be a bug.

Or do you mean the fallback to the old crtc helper prepare/commit
callbacks? We'd need to make all of them optional ofc, with atomic_
variants being preferred ofc.
-Daniel


> 
> So, I think that will not work.
> 
> cheers,
>   Gerd
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
