Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0EEFC5DF60
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 13:38:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B100C2075C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 13:38:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=poorly.run header.i=@poorly.run header.b="csf58IPg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388369AbfKGNiy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 08:38:54 -0500
Received: from mail-yb1-f194.google.com ([209.85.219.194]:35544 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727858AbfKGNix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 08:38:53 -0500
Received: by mail-yb1-f194.google.com with SMTP id i12so935182ybg.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2019 05:38:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=poorly.run; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UR+FMpDRyPvXwNuet63hIA/KDaiYBztB4W2oxpuqt4A=;
        b=csf58IPg/w9lQ2Nl9oTvOEkFzDSskXTPBRw8RrWxLtI2rQy0W4i6vmQjsgLc6BoO+F
         YTwCDTgQVpF7vOqHSlyNAoDkvZPu8DoGhp4BImq5C36qnqFYH+f7ZnATq69eSOifv8Vu
         FSqy2tMQSkpc+MJ5dsMIbD4sVXsKkMrstvBaLhTvk8DoTkXYAaB+uta+3AVkJanTarNL
         EIIb/RnSDc0la+ZBS/pl2Qde1zl1wO453vc7F21/7iTG+a8J6RH+7gXYi/0zBvk5chRL
         se/x7c6J5b1pPsDWS+s/sbSoRs1b+WqYISDDPF9PZqfyCv6ZkcTYwGvP8qxTeqBIOwJ2
         PJTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UR+FMpDRyPvXwNuet63hIA/KDaiYBztB4W2oxpuqt4A=;
        b=lViU49+FPWdEyBLi5UkwyD4PWZp0BT4XcX+6SpTLXyLhmdCk0wiSwwTk29e0BPBmIx
         pJEBPkniukEWM28Z1EDX0lTriCBZyWtwbrUxfOuXhW+lh+U+DXowqlwjvMLIm2cPZsRY
         rmC3o2tWYspBgY/XNqpLtkfy6NRJGfJkD6Pxp+ZR8qimAmPRTHCowMBljrwj7yo4cs+S
         U4HJTysL8cYBI4MYqF1hatEPmATVtz87xQiNr9pENPZAo5OGYUza/qUeKx+8Ww2EScOH
         XXmYSujUv8J5M9AuFmy2sq+KxKUR2WzI//vx5k16ewNNf1Sf3BrqQW2tqdb8CPhcm1z5
         N9mw==
X-Gm-Message-State: APjAAAXajbw40CBTsO/j1zE72qX60CnGBpuITwPWVexygMBYDjbVdand
        kRMgN+o525ofmPsRi2kmoGMzNAZYxYw=
X-Google-Smtp-Source: APXvYqxMAOnQy88pixXrXkLY51EbFIn3dNn0lEnxFRVO0u+p/OxQmgx371p0fYm+lPnMmM6+RPfj8A==
X-Received: by 2002:a5b:d07:: with SMTP id y7mr3445302ybp.313.1573133932475;
        Thu, 07 Nov 2019 05:38:52 -0800 (PST)
Received: from localhost ([2620:0:1013:11:89c6:2139:5435:371d])
        by smtp.gmail.com with ESMTPSA id i125sm750756ywa.68.2019.11.07.05.38.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2019 05:38:51 -0800 (PST)
Date:   Thu, 7 Nov 2019 08:38:51 -0500
From:   Sean Paul <sean@poorly.run>
To:     Joe Perches <joe@perches.com>
Cc:     Wambui Karuga <wambui.karugax@gmail.com>, hjc@rock-chips.com,
        heiko@sntech.de, airlied@linux.ie, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/rockchip: use DRM_DEV_ERROR for log output
Message-ID: <20191107133851.GF63329@art_vandelay>
References: <20191107092945.15513-1-wambui.karugax@gmail.com>
 <4c74db2614cefe23f888d0643c2d7c356086745a.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4c74db2614cefe23f888d0643c2d7c356086745a.camel@perches.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 07, 2019 at 01:54:22AM -0800, Joe Perches wrote:
> On Thu, 2019-11-07 at 12:29 +0300, Wambui Karuga wrote:
> > Replace the use of the dev_err macro with the DRM_DEV_ERROR
> > DRM helper macro.
> 
> The commit message should show the reason _why_ you are doing
> this instead of just stating that you are doing this.
> 
> It's not that dev_err is uncommon in drivers/gpu/drm.
> 

It is uncommon (this is the sole instance) in rockchip, however. So it makes
sense to convert the dev_* prints in rockchip to DRM_DEV for consistency.

Wambui, could you also please convert the dev_warn instance as well?

I'll apply this to drm-misc-next and expand on the commit message a bit.

Thanks,

Sean

> $ git grep -w dev_err drivers/gpu/drm | wc -l
> 1950
> $ git grep -w DRM_DEV_ERROR drivers/gpu/drm | wc -l
> 756
> 
> > diff --git a/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c b/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
> []
> > @@ -916,7 +916,7 @@ static int dw_mipi_dsi_rockchip_probe(struct platform_device *pdev)
> >  	}
> >  
> >  	if (!dsi->cdata) {
> > -		dev_err(dev, "no dsi-config for %s node\n", np->name);
> > +		DRM_DEV_ERROR(dev, "no dsi-config for %s node\n", np->name);
> >  		return -EINVAL;
> >  	}
> 
> 
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Sean Paul, Software Engineer, Google / Chromium OS
