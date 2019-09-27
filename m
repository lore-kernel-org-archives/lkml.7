Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E130C4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 15:27:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28B71217D7
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 15:27:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=poorly.run header.i=@poorly.run header.b="cMG2MtTo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727917AbfI0P1n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 11:27:43 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:37943 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727159AbfI0P1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 11:27:43 -0400
Received: by mail-yb1-f193.google.com with SMTP id o18so2143714ybp.5
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2019 08:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=poorly.run; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=xCO5ciSSmIdXUVqoacYxpnyVZL078hnLTwI76k2DE7k=;
        b=cMG2MtToZzs3UHpI4/HPfkMWHQsMl3J0yUvt0dq90wo0nEp75aU/LhW8CZaUkAoJux
         vrO0oVe7aNc9TJr2ts+E0u31AkU85ro9bfc0Baeyx5eNn88oPZq3lNiK9cEbtKAXBERq
         iUbcOZ2DhLUYhJkDkNnZ3iREICTGVEd6NamF4yLvSlZLhS2QU4CJzd2V0+/zAHwhn067
         bSSQVZEN4GJugjJ+g9Ktr9e8jj5lTI0wDQOewqHICOYgmWh9K6EE3/FYFCYHvvx+eZuG
         717osfvhyXcCzvzXBMJAholxzGNrI/rNrFDHCQZ6C0ZbCK0GGShfAsFnUCM3uvTb/Pd/
         Tiaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=xCO5ciSSmIdXUVqoacYxpnyVZL078hnLTwI76k2DE7k=;
        b=oBG4VBJCNdVpW+pVQhyn8xRkfq0ozGim5IISS3dieZ/DsUIRCRBP9Vj4wVeQRqhBPO
         3s5NkNckccEkPhCAEgSp6ZQcK3WnmOwOMrqo/VL5yuZ24h8XZNOgm4+a7Op0sYWyeUcX
         Zp/WCsHqhCjuhIzpp8NMXIbYwUE8kO1YZI3YuIcY9iHwwtGd5WzTtQ1BfzOh3WulIxwo
         ceYHp3i+bcFYS7ltftBxYu00Bxy3rS3wZ4Rhkd8eF2t1OeMiEABEgDS1t7vEfScqjN1G
         XuzOrUhBVbX/Yy673WaaJNq9eHAE16AF7nCzy2lCKDsxVuxWihSUWnI4TYrLIfO9hnF3
         oCKQ==
X-Gm-Message-State: APjAAAXsQvIH9GmwdmxySeVLIdDOZ0hUpKYGPpELJZ+9fB0EaarP5p/z
        XyxAdzuEgWEDD0VfhY+9611NGg==
X-Google-Smtp-Source: APXvYqxkU8et7jLwrzFx/tRStZaD6IFTrQHtqijrmhQ0XMDpm/KwUIV+ELQYIos5zDDP46bNGkWn4A==
X-Received: by 2002:a25:5f10:: with SMTP id t16mr5955074ybb.25.1569598062040;
        Fri, 27 Sep 2019 08:27:42 -0700 (PDT)
Received: from localhost ([2620:0:1013:11:89c6:2139:5435:371d])
        by smtp.gmail.com with ESMTPSA id 207sm644901ywu.106.2019.09.27.08.27.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2019 08:27:41 -0700 (PDT)
Date:   Fri, 27 Sep 2019 11:27:41 -0400
From:   Sean Paul <sean@poorly.run>
To:     Lyude Paul <lyude@redhat.com>
Cc:     amd-gfx@lists.freedesktop.org,
        Ville =?iso-8859-1?Q?Syrj=E4l=E4?= 
        <ville.syrjala@linux.intel.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        David Francis <David.Francis@amd.com>,
        Mario Kleiner <mario.kleiner.de@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] drm/amdgpu/dm/mst: Report possible_crtcs
 incorrectly, for now
Message-ID: <20190927152741.GU218215@art_vandelay>
References: <20190926225122.31455-1-lyude@redhat.com>
 <20190926225122.31455-6-lyude@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190926225122.31455-6-lyude@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 26, 2019 at 06:51:07PM -0400, Lyude Paul wrote:
> This commit is seperate from the previous one to make it easier to
> revert in the future. Basically, there's multiple userspace applications
> that interpret possible_crtcs very wrong:
> 
> https://gitlab.freedesktop.org/xorg/xserver/merge_requests/277
> https://gitlab.gnome.org/GNOME/mutter/issues/759
> 
> While work is ongoing to fix these issues in userspace, we need to
> report ->possible_crtcs incorrectly for now in order to avoid
> introducing a regression in in userspace. Once these issues get fixed,
> this commit should be reverted.
> 
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index b404f1ae6df7..fe8ac801d7a5 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -4807,6 +4807,17 @@ static int amdgpu_dm_crtc_init(struct amdgpu_display_manager *dm,
>  	if (!acrtc->mst_encoder)
>  		goto fail;
>  
> +	/*
> +	 * FIXME: This is a hack to workaround the following issues:
> +	 *
> +	 * https://gitlab.gnome.org/GNOME/mutter/issues/759
> +	 * https://gitlab.freedesktop.org/xorg/xserver/merge_requests/277
> +	 *
> +	 * One these issues are closed, this should be removed

Even when these issues are closed, we'll still be introducing a regression if we
revert this change. Time for actually_possible_crtcs? :)

You also might want to briefly explain the u/s bug in case the links go sour.

> +	 */
> +	acrtc->mst_encoder->base.possible_crtcs =
> +		amdgpu_dm_get_encoder_crtc_mask(dm->adev);

Why don't we put this hack in amdgpu_dm_dp_create_fake_mst_encoder()?

Sean

> +
>  	return 0;
>  
>  fail:
> -- 
> 2.21.0
> 

-- 
Sean Paul, Software Engineer, Google / Chromium OS
