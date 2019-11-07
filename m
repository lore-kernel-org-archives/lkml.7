Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03AC4C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 18:29:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCD00206DF
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 18:29:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rbUomZKe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727879AbfKGS3V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 13:29:21 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40482 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725823AbfKGS3V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 13:29:21 -0500
Received: by mail-pg1-f196.google.com with SMTP id 15so2553611pgt.7
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2019 10:29:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=L27L6nvKvaj+gPXc0hUn4bbWpeFZdtO6lr7Y2U0Ty4M=;
        b=rbUomZKewSy4DXhw/7Z7m3aDjtDHGfsAELPyU27m6jCHbYjFFdiyfTC6mZjX4XjgwO
         secNzkkFwPso2HohuanZpJAlrW2mbDRRAaoXFhhzp5KYENc9r910tqazGZS7+hrBtB7H
         GFS55JgTj2VCW45MbVTWwrTNTVdZq0gcK9dWG45jOVju9al4s+pZc1UTM1jyxj6fn0/k
         PodVmbSh5UnsfSL1g25h3ax/kVBD/BGBoj80X6tkfE6MOrom/b6/FSlpPwUGeD1kyG1h
         pfkkFRvPJSJ/HB6oKRfWpudMsKLPrtBEVaVM3K4k89YH49IJfBD4252Ombv87DBtHJdO
         cNAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=L27L6nvKvaj+gPXc0hUn4bbWpeFZdtO6lr7Y2U0Ty4M=;
        b=W4VhCH5ouepcS5Kl960ILT9OLUBMBNtEMUGH/0b1EJJhg424mU/c9JeumnKyDxPURH
         ruLavE+/1LaBj7rF2JbErU49d3G5pn28rvP2vAoaIiHPJQttdaxoOzQfsyPcrJla2uRE
         5xoFGlOeYK3sBFdkYUYHQttV7bWWSga+RHUnC4ItZuiQFWKxFqD9JvstA6p7n8t654ZW
         WexZh3loCEegbjpSdZfr3T3kPQTV1XZj+YxAZHQCxgmNMpAP2KmyFhb7F4V2I4bA4Fp+
         9QVW4q15n2mkPbGRp4qEscTX0DqPM933NWGZrvXrZABJhFqoTZIsFAkLDGt32kfNCbqa
         +ENQ==
X-Gm-Message-State: APjAAAWW/MJCP3DPjsPg5NMyMkSLyHCJAvqfsbrJxx6cvd37mf1Lao74
        A+w+8zgZgT+z+xBBn37gOOg=
X-Google-Smtp-Source: APXvYqz5WQrxb5VyPVMHdWgZQ8z97ty0BNqyApspbxG5LjM7qj9BgZ/z2h7xzjcYRVuJ/De/poKAug==
X-Received: by 2002:aa7:82cd:: with SMTP id f13mr5896715pfn.69.1573150968760;
        Thu, 07 Nov 2019 10:22:48 -0800 (PST)
Received: from wambui ([197.237.61.225])
        by smtp.gmail.com with ESMTPSA id e17sm3711816pgg.5.2019.11.07.10.22.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2019 10:22:48 -0800 (PST)
Date:   Thu, 7 Nov 2019 21:22:35 +0300
From:   Wambui Karuga <wambui.karugax@gmail.com>
To:     Sean Paul <sean@poorly.run>
Cc:     hjc@rock-chips.com, heiko@sntech.de, airlied@linux.ie,
        daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        joe@perches.com
Subject: Re: [PATCH] drm/rockchip: use DRM_DEV_ERROR for log output
Message-ID: <20191107182235.GA3585@wambui>
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
Sure, I can send a patch for that.
> I'll apply this to drm-misc-next and expand on the commit message a bit.
> 
Thanks,
wambui

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
