Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BEC7C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 07:54:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B53C2084C
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 07:54:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="Uw3idvre"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728772AbfDBHyH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 03:54:07 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:41003 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725884AbfDBHyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 03:54:07 -0400
Received: by mail-ed1-f66.google.com with SMTP id a25so10723908edc.8
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2019 00:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=pNhzNlriN7P104GbvijtfCVbHe0BD03wxBfL+Uq3wnA=;
        b=Uw3idvreskrRNOeVlYsTwS9Tth9dvZ1UE4EVdGc0ypityb2rLix8Zoqi6PTE1kg6C/
         7zS6q3XdMLfOBVMzavLxcVeqcWHgU6JB30fW3vXQFHKRv9eb/gMhmjOzb+pB1101HaJs
         ZKVlitoOu00becT8vPXOh8uJexwFkGAPMk7R0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=pNhzNlriN7P104GbvijtfCVbHe0BD03wxBfL+Uq3wnA=;
        b=QHUBa1dFk6ZH+pNfHYabL3t9SOqyvI/axF+y7bnyxpMl1RcPrpSrdkIStWCQUKiomt
         rHK6+I18pjjge6WRtRQyhouRB25ZBj12N0Us0EGIctxKp7t4qxxVxEAq33quUyDpLxHT
         Pqsmww3fKNNkG+8UCokEZvRD8g/vvK/z7J/04F55o5+uap0CU8oRT6IoWn6OlTTj9UBM
         Qbk+UXNbXhExhd/etVyZr5HikZ6EfXxTyMgJNZTrSnXC13Q1j24Gu92ZLiAK80tk5M6Q
         JfKDYo9BXDi9vqjlNPEf4Q61pLuPB2oJFtpaXqUV8cJSJ+1Z0LL5t9jGAd+7+PMMx7vs
         hY3w==
X-Gm-Message-State: APjAAAV8sn4ze5i48QV2UFkBG4xrD4XThh+W6dFkwgmGv+VrWGZKFLP5
        lp9If8gkbTMOyec2kWvmTH/AHQ==
X-Google-Smtp-Source: APXvYqwgi4mMEnqtEeUleJ3OhJZvdLeI1loE3kDEEnl6xTDy0K+qw0QQ+t0yMVjxjEFsq5cvuRKCEQ==
X-Received: by 2002:a17:906:1811:: with SMTP id v17mr26505019eje.109.1554191645723;
        Tue, 02 Apr 2019 00:54:05 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id z2sm2288741ejn.37.2019.04.02.00.54.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Apr 2019 00:54:04 -0700 (PDT)
Date:   Tue, 2 Apr 2019 09:54:02 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "open list:DRM DRIVER FOR BOCHS VIRTUAL GPU" 
        <virtualization@lists.linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] drm/bochs: add missing drm_atomic_helper_shutdown()
 call.
Message-ID: <20190402075402.GA2665@phenom.ffwll.local>
Mail-Followup-To: Gerd Hoffmann <kraxel@redhat.com>,
        dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        "open list:DRM DRIVER FOR BOCHS VIRTUAL GPU" <virtualization@lists.linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20190401140306.28063-1-kraxel@redhat.com>
 <20190401140306.28063-3-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190401140306.28063-3-kraxel@redhat.com>
X-Operating-System: Linux phenom 4.19.0-1-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 01, 2019 at 04:03:05PM +0200, Gerd Hoffmann wrote:
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  drivers/gpu/drm/bochs/bochs_kms.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/bochs/bochs_kms.c b/drivers/gpu/drm/bochs/bochs_kms.c
> index 9e7cd6b34106..93cb27f93d39 100644
> --- a/drivers/gpu/drm/bochs/bochs_kms.c
> +++ b/drivers/gpu/drm/bochs/bochs_kms.c
> @@ -293,6 +293,7 @@ int bochs_kms_init(struct bochs_device *bochs)
>  void bochs_kms_fini(struct bochs_device *bochs)
>  {
>  	if (bochs->mode_config_initialized) {

This mode_config_initialized is hilarious. I think (from looking at git
history and all) this started in radeon, back when kms was an add-on, and
radeon.ko still supported ums. Then it was dutifully copypasted into
cirrus, bochs, mgag200, hisilicon and also amdgpu.

Afaict none of these drivers need this (but I didn't bother to review
amdgpu and radeon fully). Would be nice little cleanup to follow up with.

Anyway, on your 3 patches here:

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

> +		drm_atomic_helper_shutdown(bochs->dev);
>  		drm_mode_config_cleanup(bochs->dev);
>  		bochs->mode_config_initialized = false;
>  	}
> -- 
> 2.18.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
