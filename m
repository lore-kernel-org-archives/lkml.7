Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CAF1CA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 08:56:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3ED92184C
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 08:56:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="HkJ5+MiJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731221AbfJVI4f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 04:56:35 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54945 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726978AbfJVI4f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 04:56:35 -0400
Received: by mail-wm1-f65.google.com with SMTP id p7so16246093wmp.4
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2019 01:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=NhL0fj9j5ptz9/xvHkQKOUdaslq/CkWZYa1JsAOtxdI=;
        b=HkJ5+MiJN5s233Lm4108n/NHXuc/rh3e7JUmGptlI92KC8Q+kkmPwZVA11ptKcqGBP
         nkgtevwOkp8YI1V/3vsZB61EqzCJmPDEJ8ZKissu//tLQ9HadBwMaJ0WBm5IU/+LyRig
         R1iIlCkSBTesmDVn577MKXytRnEQoDXE6RDuk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=NhL0fj9j5ptz9/xvHkQKOUdaslq/CkWZYa1JsAOtxdI=;
        b=okIXZmtRfPw4683vv7dtEySjCgSQmuq7mCm22OmFVqvrvoUZ3fzPEh0/1BLn2X1K7A
         ViQX0z876F+m+l1J2yN5SDU1qPiF5eCmrNV3a2qWIg1lThWvuNYW/R0pUzYnXUmIZTgX
         3e2vH2DRsttwTcJhYrUfZxZR+e7Wm4GzxpU1D9GwOOwiK0Df1nElEL8nzrdpM7VbgIcy
         8ddxs1GTG1Ypzpr+r2RsuqveGnO5E638U6s36fmKxXYbqOoabXa0J/+aIzauTqRR13J6
         0FWG5Xzc9H/5u7NAa/rNAppZKGMZOUMXLX6+2YiiEIu6QvNvHopBZwxuo+LSXoBKxjn2
         MIlg==
X-Gm-Message-State: APjAAAXjHHN8Epzans9Qi257VtGFeNdabamw2qBWmG+33np0kazE1SOI
        K/zhBrwWMtJQSFILNac1Tg2o9w==
X-Google-Smtp-Source: APXvYqxAfMxeUyGmFf4v1DK17doImX3Vhpdg+HjGuwTEd4+hbl0KGo4Sg9ZmYxWQbSjf750Elb+ibQ==
X-Received: by 2002:a05:600c:211:: with SMTP id 17mr1886520wmi.135.1571734593057;
        Tue, 22 Oct 2019 01:56:33 -0700 (PDT)
Received: from phenom.ffwll.local (212-51-149-96.fiber7.init7.net. [212.51.149.96])
        by smtp.gmail.com with ESMTPSA id p17sm14054884wrn.4.2019.10.22.01.56.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2019 01:56:32 -0700 (PDT)
Date:   Tue, 22 Oct 2019 10:56:30 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Kangjie Lu <kjlu@umn.edu>
Cc:     Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gma/gma500: fix a memory disclosure bug due to
 uninitialized bytes
Message-ID: <20191022085630.GZ11828@phenom.ffwll.local>
Mail-Followup-To: Kangjie Lu <kjlu@umn.edu>,
        Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
        David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20191018042953.31099-1-kjlu@umn.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191018042953.31099-1-kjlu@umn.edu>
X-Operating-System: Linux phenom 5.2.0-2-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 17, 2019 at 11:29:53PM -0500, Kangjie Lu wrote:
> `best_clock` is an object that may be sent out. Object `clock`
> contains uninitialized bytes that are copied to `best_clock`,
> which leads to memory disclosure and information leak.
> 
> Signed-off-by: Kangjie Lu <kjlu@umn.edu>
> ---
>  drivers/gpu/drm/gma500/cdv_intel_display.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/gpu/drm/gma500/cdv_intel_display.c b/drivers/gpu/drm/gma500/cdv_intel_display.c
> index f56852a503e8..8b784947ed3b 100644
> --- a/drivers/gpu/drm/gma500/cdv_intel_display.c
> +++ b/drivers/gpu/drm/gma500/cdv_intel_display.c
> @@ -405,6 +405,8 @@ static bool cdv_intel_find_dp_pll(const struct gma_limit_t *limit,
>  	struct gma_crtc *gma_crtc = to_gma_crtc(crtc);
>  	struct gma_clock_t clock;
>  
> +	memset(&clock, 0, sizeof(clock));

I guess whatever analyzer you use for this doesn't see past the ->clock
vfunc call, so shouldn't be a real issue. Also, it's not an information
disclosure since we only ever leak this to other kernel code, never
userspace.

But I guess doesn't hurt, so applied.
-Daniel

> +
>  	switch (refclk) {
>  	case 27000:
>  		if (target < 200000) {
> -- 
> 2.17.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
