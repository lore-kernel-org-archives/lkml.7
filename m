Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E751AC432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 13:55:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE68B20714
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 13:55:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="NXvERH9x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbfKUNzx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 08:55:53 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:34984 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726546AbfKUNzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 08:55:53 -0500
Received: by mail-wm1-f67.google.com with SMTP id 8so3838029wmo.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2019 05:55:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9ySz0CwRZWHJZeoXGkyjArkEnAI6EPJLUR1wbzYKrBQ=;
        b=NXvERH9x28CAg2d7Yb67iVNC5YQ/S+Mx85h8A/BauEU7nfIXLInBktQXN0epsENDlP
         9Ccqiw+qy2rPeiXmtSZ78sJMmK4f2IAr6MFPNm7WgdSCO0K0nvL4R39ngGn5X0ipbI1u
         Y7IRB3tc3iGQupgccPGXN/bfAnS81ytVunXfU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=9ySz0CwRZWHJZeoXGkyjArkEnAI6EPJLUR1wbzYKrBQ=;
        b=FpHPEk8qTpMMm0O/7HL9soooXtRFd7+S+kGj8mFbuhx22RnshBlxBgm07bEhAdjxaZ
         fRkj5mVkWXO51kD8bF2V35AdvrmdSGU7ve4XVD6oIny7i07mFvm6cdYk8Q9ITDSoUJHR
         WKnGs8ICAPx1VDT/A8riC9XjnBLpXhaAy0WKXQB+dgYu1KwSoulx0G7eXMmlPBF4NOo0
         ohG9qIMJf9UGU3pkqoxY7k2zHOP7PI7b6c3jDMx5SUBxfmUUxSlHkYiyBIpIozqKVNhH
         To1HNITRn72XEtLKXpMnNTcrhsKvIjmkFgPoxK6hTztjoK8V2tcPGnRTWfCNSFOK928j
         HQBg==
X-Gm-Message-State: APjAAAXm5tDPGuxOrOHrrrFOaORSA/ZYttcLGxoUQyYZu4r+udqEb2Ll
        KJYJCnAinN4D2dyVmaLKez2cFw==
X-Google-Smtp-Source: APXvYqyPjxCiSx6aRgQWwIldMrYfO6t2JwKnW+USv8OSUlMJ3Cgu+UrDu2H7r9eK85r7VgG7mWz6yA==
X-Received: by 2002:a05:600c:2257:: with SMTP id a23mr10535918wmm.143.1574344551219;
        Thu, 21 Nov 2019 05:55:51 -0800 (PST)
Received: from phenom.ffwll.local (212-51-149-96.fiber7.init7.net. [212.51.149.96])
        by smtp.gmail.com with ESMTPSA id q5sm2956771wmc.27.2019.11.21.05.55.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2019 05:55:50 -0800 (PST)
Date:   Thu, 21 Nov 2019 14:55:48 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] drm: share address space for dma bufs
Message-ID: <20191121135548.GF6236@phenom.ffwll.local>
Mail-Followup-To: Gerd Hoffmann <kraxel@redhat.com>,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>
References: <20191121103807.18424-1-kraxel@redhat.com>
 <20191121103807.18424-3-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191121103807.18424-3-kraxel@redhat.com>
X-Operating-System: Linux phenom 5.3.0-1-amd64 
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 21, 2019 at 11:38:07AM +0100, Gerd Hoffmann wrote:
> Use the shared address space of the drm device (see drm_open() in
> drm_file.c) for dma-bufs too.  That removes a difference betweem drm
> device mmap vmas and dma-buf mmap vmas and fixes corner cases like
> unmaps not working properly.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  drivers/gpu/drm/drm_prime.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/drm_prime.c b/drivers/gpu/drm/drm_prime.c
> index a9633bd241bb..c3fc341453c0 100644
> --- a/drivers/gpu/drm/drm_prime.c
> +++ b/drivers/gpu/drm/drm_prime.c
> @@ -240,6 +240,7 @@ void drm_prime_destroy_file_private(struct drm_prime_file_private *prime_fpriv)
>  struct dma_buf *drm_gem_dmabuf_export(struct drm_device *dev,
>  				      struct dma_buf_export_info *exp_info)
>  {
> +	struct drm_gem_object *obj = exp_info->priv;
>  	struct dma_buf *dma_buf;
>  
>  	dma_buf = dma_buf_export(exp_info);
> @@ -247,7 +248,8 @@ struct dma_buf *drm_gem_dmabuf_export(struct drm_device *dev,
>  		return dma_buf;
>  
>  	drm_dev_get(dev);
> -	drm_gem_object_get(exp_info->priv);
> +	drm_gem_object_get(obj);
> +	dma_buf->file->f_mapping = obj->dev->anon_inode->i_mapping;

Can you pls also throw the change to amdgpu_gem_prime_export on top here?
Imo makes a lot more sense that way. With that added I'm happy to r-b.
-Daniel

>  
>  	return dma_buf;
>  }
> -- 
> 2.18.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
