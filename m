Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D1FDC2D0CD
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 13:13:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22826206EC
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 13:13:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="PlsYyESZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728144AbfLQNNo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 08:13:44 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35439 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726858AbfLQNNn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 08:13:43 -0500
Received: by mail-wr1-f66.google.com with SMTP id g17so11256273wro.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2019 05:13:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UiukVznUb6RbaIEpjFFv8iLF7eFYnMmkDknHSlpOQhc=;
        b=PlsYyESZ7nq7NH2yQgpIg73rAVA/3twGoT+E2NgINMQNBJj9SII/0t0E3mNu+DlLjK
         xPgazXwMdXB5f6rBGo9Dpykj917jG9QlTUR7XCydqHYMBKHEZFcd+IuZE9kR2W45V78z
         5EP/LWRnFSNYjCs43rvicFPIjboFM3Elx0SyM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=UiukVznUb6RbaIEpjFFv8iLF7eFYnMmkDknHSlpOQhc=;
        b=IJUETIpTRbkK2XIAazb81sPw0gsp2gCDXhwfI1qwSreNUGDUqLjvQl/ACLNM03CraN
         QHDviPPfavUseCfnrDTbs3GnGiFsBPQTIAJQ/IZq//2Ql3wZqe6Wh8K0Z8DNXpyo0mNq
         pFk8s6F3CJLeAnK5hu0otMqXSQiGBXheObHVOJrdiY++bmk3Ptw7RyjlkhZRr4hjAqzC
         w0rITsOSd4BTiMOJTDhjMX49DiZLWgbnGZeiI+2clhtGBfpLb6bEorxWRo8YBJ5C082A
         1LePwoL0SOZMWcdjYgvQaknPdGQfD4jzLGf9ftfN8xpxxl2UqAxk6yqiLn/p1ykG4ubV
         5W8w==
X-Gm-Message-State: APjAAAXrY9TT1xY71oLa7+nNGsohVumWxvJD+wtnOoHuEa45DzFTEXIw
        O2wj/QmIp0TQ4wB7fbdPYbQ5Nw==
X-Google-Smtp-Source: APXvYqxPRzCnT2gvRTsWttk3WXMlk8T7TgZ6vhGyRieUqp/P2hbZfco1H9nFMdnqRHYZ6d+Dbu/kbg==
X-Received: by 2002:a5d:640d:: with SMTP id z13mr37251617wru.181.1576588421585;
        Tue, 17 Dec 2019 05:13:41 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:564b:0:7567:bb67:3d7f:f863])
        by smtp.gmail.com with ESMTPSA id x26sm2925754wmc.30.2019.12.17.05.13.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 05:13:40 -0800 (PST)
Date:   Tue, 17 Dec 2019 14:13:38 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Aditya Pakki <pakki001@umn.edu>
Cc:     kjlu@umn.edu,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm: remove duplicate check on parent and avoid BUG_ON
Message-ID: <20191217131338.GY624164@phenom.ffwll.local>
Mail-Followup-To: Aditya Pakki <pakki001@umn.edu>, kjlu@umn.edu,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20191215194345.4679-1-pakki001@umn.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191215194345.4679-1-pakki001@umn.edu>
X-Operating-System: Linux phenom 5.3.0-2-amd64 
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 15, 2019 at 01:43:44PM -0600, Aditya Pakki wrote:
> In drm_dev_init, parent is checked for NULL via assert after
> checked in devm_drm_dev_init(). The patch removes the duplicate
> check and replaces the assertion with WARN_ON. Further, it returns
> -EINVAL consistent with the usage in devm_drm_dev_init.
> 
> Signed-off-by: Aditya Pakki <pakki001@umn.edu>

Makes sense, patch applied to drm-misc-next.

Thanks, Daniel

> ---
>  drivers/gpu/drm/drm_drv.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_drv.c b/drivers/gpu/drm/drm_drv.c
> index 1b9b40a1c7c9..7c18a980cd4b 100644
> --- a/drivers/gpu/drm/drm_drv.c
> +++ b/drivers/gpu/drm/drm_drv.c
> @@ -622,7 +622,8 @@ int drm_dev_init(struct drm_device *dev,
>  		return -ENODEV;
>  	}
>  
> -	BUG_ON(!parent);
> +	if (WARN_ON(!parent))
> +		return -EINVAL;
>  
>  	kref_init(&dev->ref);
>  	dev->dev = get_device(parent);
> @@ -725,7 +726,7 @@ int devm_drm_dev_init(struct device *parent,
>  {
>  	int ret;
>  
> -	if (WARN_ON(!parent || !driver->release))
> +	if (WARN_ON(!driver->release))
>  		return -EINVAL;
>  
>  	ret = drm_dev_init(dev, driver, parent);
> -- 
> 2.20.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
