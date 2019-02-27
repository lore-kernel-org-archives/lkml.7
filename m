Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18839C00319
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 23:52:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9CF3218A4
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 23:52:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730551AbfB0Xwv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 18:52:51 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:46167 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729918AbfB0Xwv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 18:52:51 -0500
Received: by mail-qt1-f196.google.com with SMTP id z25so21446726qti.13
        for <linux-kernel@vger.kernel.org>; Wed, 27 Feb 2019 15:52:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=477+SFDfE0ZoYOb3guhbOjb9WVbbi2f4zeBLAL1clJ0=;
        b=Nc6wGiL/ymLewt55qwyZYjUowTaUlDDHLowLu8SrVyr4j7dMFnF07WR7LommQvg+wh
         dbtzX3kbSTOLxNiHvhhk73+87u+7yVSVDIa4Gqf3kTLGxHYrvmp2iHoy8m9dluns82AQ
         tjnMIqa6MNSg63nWWMyeWoETUZosEwPpq7QlWYffQyJM40fsyyqbRdEsFDEeANKGOk4r
         C1VDt/SNcbWtcnghOrmsh+m2sGtPBliwK6eOJ8Eos/vV2ByTx3cDeXLvcEqXU8hIWqgO
         Ev7c85siUDxZDPqq9AAG74p///3zHuyYbGCZCqvkX+Iz3DTZx3QpKKyneK27x9HIUhbD
         7Qxg==
X-Gm-Message-State: APjAAAX33Ks1IneB5wwwA14seOnIP5oRmxmX9vhC1i4rnrO40EAM3wKM
        VCBI75o4h42XpinchMhS+1gpJw==
X-Google-Smtp-Source: APXvYqxqqO+SwdGRwFcJnzd3JKyqOvRvs5BLqRHEBADhz+tYfoycgKk42qQ6DgB6YUOQYuWLJTmyCA==
X-Received: by 2002:a0c:95dd:: with SMTP id t29mr4177370qvt.174.1551311569950;
        Wed, 27 Feb 2019 15:52:49 -0800 (PST)
Received: from ?IPv6:2601:602:9800:dae6:8083:e891:a0d6:f666? ([2601:602:9800:dae6:8083:e891:a0d6:f666])
        by smtp.gmail.com with ESMTPSA id a3sm12856551qta.21.2019.02.27.15.52.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Feb 2019 15:52:48 -0800 (PST)
Subject: Re: [PATCH v2] drm/vgem: fix use-after-free when
 drm_gem_handle_create() fails
To:     Eric Biggers <ebiggers@kernel.org>, dri-devel@lists.freedesktop.org
Cc:     Chris Wilson <chris@chris-wilson.co.uk>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        linux-kernel@vger.kernel.org,
        syzbot+e73f2fb5ed5a5df36d33@syzkaller.appspotmail.com,
        Daniel Vetter <daniel.vetter@ffwll.ch>, stable@vger.kernel.org
References: <20190226213053.GC218103@gmail.com>
 <20190226214451.195123-1-ebiggers@kernel.org>
From:   Laura Abbott <labbott@redhat.com>
Message-ID: <2ba38b28-89a3-3ae7-6f13-af298165cfd8@redhat.com>
Date:   Wed, 27 Feb 2019 15:52:43 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190226214451.195123-1-ebiggers@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/26/19 1:44 PM, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> If drm_gem_handle_create() fails in vgem_gem_create(), then the
> drm_vgem_gem_object is freed twice: once when the reference is dropped
> by drm_gem_object_put_unlocked(), and again by __vgem_gem_destroy().
> 
> This was hit by syzkaller using fault injection.
> 
> Fix it by skipping the second free.
> 
> Reported-by: syzbot+e73f2fb5ed5a5df36d33@syzkaller.appspotmail.com
> Fixes: af33a9190d02 ("drm/vgem: Enable dmabuf import interfaces")
> Reviewed-by: Chris Wilson <chris@chris-wilson.co.uk>
> Cc: Laura Abbott <labbott@redhat.com>
> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> Cc: stable@vger.kernel.org
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
>   drivers/gpu/drm/vgem/vgem_drv.c | 6 +-----
>   1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/vgem/vgem_drv.c b/drivers/gpu/drm/vgem/vgem_drv.c
> index 5930facd6d2d8..11a8f99ba18c5 100644
> --- a/drivers/gpu/drm/vgem/vgem_drv.c
> +++ b/drivers/gpu/drm/vgem/vgem_drv.c
> @@ -191,13 +191,9 @@ static struct drm_gem_object *vgem_gem_create(struct drm_device *dev,
>   	ret = drm_gem_handle_create(file, &obj->base, handle);
>   	drm_gem_object_put_unlocked(&obj->base);
>   	if (ret)
> -		goto err;
> +		return ERR_PTR(ret);
>   
>   	return &obj->base;
> -
> -err:
> -	__vgem_gem_destroy(obj);
> -	return ERR_PTR(ret);
>   }
>   
>   static int vgem_gem_dumb_create(struct drm_file *file, struct drm_device *dev,
> 


Acked-by: Laura Abbott <labbott@redhat.com>
