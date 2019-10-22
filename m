Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FC5FCA9EB9
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 08:59:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 454EE20640
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 08:59:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="FzT8PFDj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731380AbfJVI7e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 04:59:34 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40050 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728832AbfJVI7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 04:59:33 -0400
Received: by mail-wr1-f67.google.com with SMTP id o28so17077993wro.7
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2019 01:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=jxmCwIeHDgkpYVsOzcGzZpWtPrDaLJlk3S4i0/jBbqQ=;
        b=FzT8PFDjIeRzigByVRwj0mJBOY+NZri4fx2GCcFeQvsKu0uIP5+G1eqnDjAUzziXIW
         iSpGdtjw/lp3Cqe01O2ixd9JHyOXSLeoDOMn/iys8YEejPa0QHKhm7+iDi1ZmWFGWNjP
         E9UwvDBr6PKnx7uCF5g51cb3H2YhOPDsKpR2o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=jxmCwIeHDgkpYVsOzcGzZpWtPrDaLJlk3S4i0/jBbqQ=;
        b=ovJTohS9Ic68MVmkohPW6dKG1/gtQm00QhF0yte6rJlVzcWW4cSDDtRqACdDrMwGLt
         BTlP/jObJ+xn20zFAr1s46nXAauPLjgT0YpA2DLP/Scx5sIJinDvZeq+IaIjKKUVYCYu
         7MMjOn8R4h5V623whf1t111ukpejQWVhoRqWi1zZw6a/Z59LQtjO8yaWe999GxtztvFt
         uxTfMkj20m9AfD01qPt971cs7eBsiZPwRe71xQ/9BHQIMSKRnJAGU9DInxCgOl/wTb2l
         LFDBkdD6+RB98T7U5gyTVlPxiQxGkqEcE7sJASOD5ziMFxG2N1/GEgVG6xDXH8ZM2n9o
         wn2Q==
X-Gm-Message-State: APjAAAWI8bPvRTXnSKjjOtScanphu0wwgC2pMpKhZJVYTxIYP0Olk6BJ
        s5xUSpha/eCDqxI52V10M8RgYA==
X-Google-Smtp-Source: APXvYqzd2QpyGvXdawpEdZBVER8fWByd/JbP1ANnd25CFqLpm8M5brZeLwzlHZe2BHfKM5mySIaaEw==
X-Received: by 2002:adf:9bdc:: with SMTP id e28mr2303057wrc.309.1571734770249;
        Tue, 22 Oct 2019 01:59:30 -0700 (PDT)
Received: from phenom.ffwll.local (212-51-149-96.fiber7.init7.net. [212.51.149.96])
        by smtp.gmail.com with ESMTPSA id b196sm10894237wmd.24.2019.10.22.01.59.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2019 01:59:29 -0700 (PDT)
Date:   Tue, 22 Oct 2019 10:59:27 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Kangjie Lu <kjlu@umn.edu>
Cc:     Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/gma500: fix memory disclosures due to uninitialized
 bytes
Message-ID: <20191022085927.GA11828@phenom.ffwll.local>
Mail-Followup-To: Kangjie Lu <kjlu@umn.edu>,
        Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
        David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20191018044150.1899-1-kjlu@umn.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191018044150.1899-1-kjlu@umn.edu>
X-Operating-System: Linux phenom 5.2.0-2-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 17, 2019 at 11:41:50PM -0500, Kangjie Lu wrote:
> "clock" may be copied to "best_clock". Initializing best_clock
> is not sufficient. The fix initializes clock as well to avoid
> memory disclosures and informaiton leaks.
> 
> Signed-off-by: Kangjie Lu <kjlu@umn.edu>

Again no leak here, but also doesn't hurt, so applied.
-Daniel

> ---
>  drivers/gpu/drm/gma500/oaktrail_crtc.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/gpu/drm/gma500/oaktrail_crtc.c b/drivers/gpu/drm/gma500/oaktrail_crtc.c
> index 167c10767dd4..900e5499249d 100644
> --- a/drivers/gpu/drm/gma500/oaktrail_crtc.c
> +++ b/drivers/gpu/drm/gma500/oaktrail_crtc.c
> @@ -129,6 +129,7 @@ static bool mrst_sdvo_find_best_pll(const struct gma_limit_t *limit,
>  	s32 freq_error, min_error = 100000;
>  
>  	memset(best_clock, 0, sizeof(*best_clock));
> +	memset(&clock, 0, sizeof(clock));
>  
>  	for (clock.m = limit->m.min; clock.m <= limit->m.max; clock.m++) {
>  		for (clock.n = limit->n.min; clock.n <= limit->n.max;
> @@ -185,6 +186,7 @@ static bool mrst_lvds_find_best_pll(const struct gma_limit_t *limit,
>  	int err = target;
>  
>  	memset(best_clock, 0, sizeof(*best_clock));
> +	memset(&clock, 0, sizeof(clock));
>  
>  	for (clock.m = limit->m.min; clock.m <= limit->m.max; clock.m++) {
>  		for (clock.p1 = limit->p1.min; clock.p1 <= limit->p1.max;
> -- 
> 2.17.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
