Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EF54FA372C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 12:46:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEDCA21D6C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 12:46:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uPGazBXt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727247AbfKHMqo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 07:46:44 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46852 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726299AbfKHMqo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 07:46:44 -0500
Received: by mail-pg1-f196.google.com with SMTP id r18so3855799pgu.13
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2019 04:46:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5rxvla9MqG20qS8PvXLmnssk4K8x/Hmcm3O9O7mRXxw=;
        b=uPGazBXt00dkMb4XcC5rtgD+hXWx7CX3wPcgEwLyc7/uLOfYxE6FYllxMnuz+mWElt
         TFD5nUaNmEAmii33SlcKmcwRB/VpqoHROLQX9ZyCrtx9I4iBwX8+lYIDPNfhEfijDRba
         bgcv/EsdA1DP+E5Hrr68Xo4mcflJRzSKf1MMQV10Dg+1kcWGz90yKhlmkk11yAfexpqx
         0dL1pT6VkNqhUK5pZzP1sxhyhWIrBVnYdFEDS5ZRUp5L6g4sixLzlXeJSblLGsL8+M+K
         g9JsPudijfoCeT2BTdTQukwx+LJytsnw6bdwQ/QAf/tWC8Qgm7SY9Efvhhs+ViecTSzM
         YUFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=5rxvla9MqG20qS8PvXLmnssk4K8x/Hmcm3O9O7mRXxw=;
        b=C3UqMbNCcp+ImtV8BqBL7r8YMahcoVOy+0j1IrWYaHKXRf2oBaErK3MLqjL5ev6Ylf
         y6PGbcfk3PPuYdjDnRDHWsFGvZX3pbinSVVVmCjVKpxR4vXpIy16cZeHD3+XSk1Rphp6
         uoZaxPqVtFr8YtPcru09tpm2I5wAk2lzHknnNxM978Wl6TPh1X6jO4UYJQrbOhJuLcWe
         d138FvPBqCWzB8kDNMa9Usa/KGUmF/IGRU76nhtAhgSoS5+AKuktsX/0i8RwxdQATwRW
         pYvLPDIRiSiWoBwzyukJOQWaxJLhEsNS/MxqLPE6bquYkUbwoIMnW455U+kS7ZeL0L9Q
         uYrg==
X-Gm-Message-State: APjAAAVApbXGzf58i1mx1FuYiunAfEQDHuaA23YxW/0L236nSlnS6klT
        dUws6RkyyqC2uYB0AMVd8AqAxf4puswSTg==
X-Google-Smtp-Source: APXvYqyQ+Qhfryqn9y1yTDk88XHS4CTDkPsbWWZl/mPudP1Bo8G6TeUELgpef4D8uHsAaYCDaB2Pyw==
X-Received: by 2002:a17:90a:c004:: with SMTP id p4mr8684007pjt.104.1573217203600;
        Fri, 08 Nov 2019 04:46:43 -0800 (PST)
Received: from wambui ([197.254.95.38])
        by smtp.gmail.com with ESMTPSA id n23sm5601302pff.137.2019.11.08.04.46.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2019 04:46:42 -0800 (PST)
Date:   Fri, 8 Nov 2019 15:46:30 +0300
From:   Wambui Karuga <wambui.karugax@gmail.com>
To:     Sean Paul <sean@poorly.run>
Cc:     hjc@rock-chips.com, heiko@sntech.de, airlied@linux.ie,
        daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/rockchip: use DRM_DEV_ERROR for log output
Message-ID: <20191108124630.GA10207@wambui>
Reply-To: 20191107133851.GF63329@art_vandelay
References: <20191107092945.15513-1-wambui.karugax@gmail.com>
 <4c74db2614cefe23f888d0643c2d7c356086745a.camel@perches.com>
 <20191107133851.GF63329@art_vandelay>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191107133851.GF63329@art_vandelay>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 07, 2019 at 08:38:51AM -0500, Sean Paul wrote:
> On Thu, Nov 07, 2019 at 01:54:22AM -0800, Joe Perches wrote:
> > On Thu, 2019-11-07 at 12:29 +0300, Wambui Karuga wrote:
> > > Replace the use of the dev_err macro with the DRM_DEV_ERROR
> > > DRM helper macro.
> > 
> > The commit message should show the reason _why_ you are doing
> > this instead of just stating that you are doing this.
> > 
> > It's not that dev_err is uncommon in drivers/gpu/drm.
> > 
> 
> It is uncommon (this is the sole instance) in rockchip, however. So it makes
> sense to convert the dev_* prints in rockchip to DRM_DEV for consistency.
> 
> Wambui, could you also please convert the dev_warn instance as well?
> 
Hey, Sean.
Trying to convert this dev_warn instance, but the corresponding DRM_WARN
macro does not take the dev parameter which seems to be useful in the
original output.
Should I still convert it to DRM_WARN without the hdmi->dev parameter?

Thanks,
wambui
> I'll apply this to drm-misc-next and expand on the commit message a bit.
> 
> Thanks,
> 
> Sean
> 
> > $ git grep -w dev_err drivers/gpu/drm | wc -l
> > 1950
> > $ git grep -w DRM_DEV_ERROR drivers/gpu/drm | wc -l
> > 756
> > 
> > > diff --git a/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c b/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
> > []
> > > @@ -916,7 +916,7 @@ static int dw_mipi_dsi_rockchip_probe(struct platform_device *pdev)
> > >  	}
> > >  
> > >  	if (!dsi->cdata) {
> > > -		dev_err(dev, "no dsi-config for %s node\n", np->name);
> > > +		DRM_DEV_ERROR(dev, "no dsi-config for %s node\n", np->name);
> > >  		return -EINVAL;
> > >  	}
> > 
> > 
> > 
> > _______________________________________________
> > dri-devel mailing list
> > dri-devel@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/dri-devel
> 
> -- 
> Sean Paul, Software Engineer, Google / Chromium OS
