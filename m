Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC9FCC5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 16:06:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74FD720679
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 16:06:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=poorly.run header.i=@poorly.run header.b="P9+KNuvn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727585AbfKHQGF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 11:06:05 -0500
Received: from mail-yb1-f196.google.com ([209.85.219.196]:38487 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726200AbfKHQGF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 11:06:05 -0500
Received: by mail-yb1-f196.google.com with SMTP id b11so2335437ybj.5
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2019 08:06:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=poorly.run; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=pp2jWlCqJKLEk+ibjFXlnfbIxOH3q9oKQMy0Ofpc8qE=;
        b=P9+KNuvnFxtHeZW47U9PU1hLw36tD6FBGxejakql8CpvkHWnHxaE2Hsb7Ult2eNypQ
         GfJOBVChlOCUTlmcZG1H+puAgs5DttZdWxZliRFToxhKWccMxT/b0VI05a347WPVP9uY
         k7uIoL08R6YWDSolqaXK0cW9gcfV0NEyYlPI/6raUnB5Wu3yOQDEuVXKPK6QQxDjte/u
         NVLBdMqcIJgzkTG+cvIjn3mPQZoK1A6pS4Fu3joklD3YiDU64B/sUcyDfbqSe+hzpfk+
         gTOUloLnBFdK5+BdO1A3eNjqBPcRGLwipGEtRn6GhK6iCkiDvxjT1gEVcYKAzdmzi6Q1
         yoCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=pp2jWlCqJKLEk+ibjFXlnfbIxOH3q9oKQMy0Ofpc8qE=;
        b=gAyK+ViZH6u+jA+iaPgpXRPkrC65inR5e5+gL2oHoJ/N6dyHW7IoSoJgweYaoN/2s2
         QZqUhHd3p3qJtDygzFRT+Ct1EJNUKo0OVsHNg62x51bJTcO1Dqifpoe6HUF3XUoKbKTi
         1c9KmfpX4YT6q78S47Ni/CW5EMP6Qm7oIq2wYFvnf5eLXg7OEYC3QEWIxQUSJ3RmpPKP
         n68zeNY8YVsmKChSyfAmRiOdXgYy3xxr4gNYCANvoeCZvcUjH6eJVC0ILYJ0PFzUIRBy
         QzXwkNdWyqkP8zRq+SmmCT377LYl5fALRXSengOPPOqmdeqBWz4UO0kE8N8Vd4mnyjdb
         FjFg==
X-Gm-Message-State: APjAAAVr1lVZ+6Uks7RDGtRDNb/qDugx2WaNaJ6JRpnK39KeMz7Q7VHe
        2T4q9/DBxrnnqaGjzyPqzYGJXw==
X-Google-Smtp-Source: APXvYqwHJn8rPwXJPMSPwZbAmzYjmDgS/hvf7KYotndLpNLBWxDPVgII5ANOE6uR/uxdy54DyxixSw==
X-Received: by 2002:a25:c64b:: with SMTP id k72mr9417242ybf.4.1573229163819;
        Fri, 08 Nov 2019 08:06:03 -0800 (PST)
Received: from localhost ([2620:0:1013:11:89c6:2139:5435:371d])
        by smtp.gmail.com with ESMTPSA id 138sm2987950ywr.46.2019.11.08.08.06.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2019 08:06:03 -0800 (PST)
Date:   Fri, 8 Nov 2019 11:06:02 -0500
From:   Sean Paul <sean@poorly.run>
To:     Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Cc:     Wambui Karuga <wambui.karugax@gmail.com>,
        Sean Paul <sean@poorly.run>, hjc@rock-chips.com,
        airlied@linux.ie, daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/rockchip: use DRM_DEV_ERROR for log output
Message-ID: <20191108160602.GG63329@art_vandelay>
References: <20191107092945.15513-1-wambui.karugax@gmail.com>
 <20191107133851.GF63329@art_vandelay>
 <20191108124630.GA10207@wambui>
 <4996186.DxzAFJqeGu@diego>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4996186.DxzAFJqeGu@diego>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 08, 2019 at 03:06:44PM +0100, Heiko Stübner wrote:
> Hi,
> 
> [it seems your Reply-To mail header is set strangely as
> Reply-To: 20191107133851.GF63329@art_vandelay
> which confuses my MTA]
> 
> Am Freitag, 8. November 2019, 13:46:30 CET schrieb Wambui Karuga:
> > On Thu, Nov 07, 2019 at 08:38:51AM -0500, Sean Paul wrote:
> > > On Thu, Nov 07, 2019 at 01:54:22AM -0800, Joe Perches wrote:
> > > > On Thu, 2019-11-07 at 12:29 +0300, Wambui Karuga wrote:
> > > > > Replace the use of the dev_err macro with the DRM_DEV_ERROR
> > > > > DRM helper macro.
> > > > 
> > > > The commit message should show the reason _why_ you are doing
> > > > this instead of just stating that you are doing this.
> > > > 
> > > > It's not that dev_err is uncommon in drivers/gpu/drm.
> > > > 
> > > 
> > > It is uncommon (this is the sole instance) in rockchip, however. So it makes
> > > sense to convert the dev_* prints in rockchip to DRM_DEV for consistency.
> > > 
> > > Wambui, could you also please convert the dev_warn instance as well?
> > > 
> > Hey, Sean.
> > Trying to convert this dev_warn instance, but the corresponding DRM_WARN
> > macro does not take the dev parameter which seems to be useful in the
> > original output.
> > Should I still convert it to DRM_WARN without the hdmi->dev parameter?
> 
> There exists DRM_DEV_ERROR, DRM_DEV_INFO and DRM_DEV_DEBUG to
> handle actual devices. Interestingly there is no DRM_DEV_WARN though.
> 
> So depending on what Sean suggest another option would be to add the
> missing DRM_DEV_WARN and then use it to replace the dev_warn.

Yep, this sounds good to me me.

Sean

> 
> 
> Heiko
> 
> 
> 
> > 
> > Thanks,
> > wambui
> > > I'll apply this to drm-misc-next and expand on the commit message a bit.
> > > 
> > > Thanks,
> > > 
> > > Sean
> > > 
> > > > $ git grep -w dev_err drivers/gpu/drm | wc -l
> > > > 1950
> > > > $ git grep -w DRM_DEV_ERROR drivers/gpu/drm | wc -l
> > > > 756
> > > > 
> > > > > diff --git a/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c b/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
> > > > []
> > > > > @@ -916,7 +916,7 @@ static int dw_mipi_dsi_rockchip_probe(struct platform_device *pdev)
> > > > >  	}
> > > > >  
> > > > >  	if (!dsi->cdata) {
> > > > > -		dev_err(dev, "no dsi-config for %s node\n", np->name);
> > > > > +		DRM_DEV_ERROR(dev, "no dsi-config for %s node\n", np->name);
> > > > >  		return -EINVAL;
> > > > >  	}
> > > > 
> > > > 
> > > > 
> > > > _______________________________________________
> > > > dri-devel mailing list
> > > > dri-devel@lists.freedesktop.org
> > > > https://lists.freedesktop.org/mailman/listinfo/dri-devel
> > > 
> > 
> 
> 
> 
> 

-- 
Sean Paul, Software Engineer, Google / Chromium OS
