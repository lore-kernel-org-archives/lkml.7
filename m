Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 344CCC072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 16:20:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 020AE21848
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 16:20:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="YUKjt5T1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390626AbfEXQUJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 12:20:09 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:41122 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389588AbfEXQUI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 12:20:08 -0400
Received: by mail-ed1-f68.google.com with SMTP id m4so15105375edd.8
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 09:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=qa/iTdMK2I5u7OLH5mUmubpi3Ui2X4Y/60DebnqcWKA=;
        b=YUKjt5T1Uxbnehko3JGL2u2xg4tM7137f8tigXS15tKoOaor5fhH2rdF2bZu2pmZ29
         CXlen5OW7V7h5ZAJUlNaFmfhRqbz3V6eiRg1mrMLmxwMXEq8FAC96F/w2Y1k4xI8mTF8
         hN4YPvaOwSEvViy+ZqNaKCMe9VigQy4rKnUWI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=qa/iTdMK2I5u7OLH5mUmubpi3Ui2X4Y/60DebnqcWKA=;
        b=ASLSYy6b0XtvKiYN9oQoirsYqm+pT9wRhH4yyCsmjxa4JCbv+NDWbvNZOtSIql/XL/
         NWgqAzvH2MtpghSnYUoPpWm33J8Z4EUJTnUXGOapSi5l9tFaqMMtZkYwRMMVt25unY/+
         3HTK2wKuv+4Y98LdRYmo9/xTt7uUCz5JXLMWb1dfEDayeyTp14CI33fbjmnh6nal2vU8
         sVWmHDsrCEqCd2JNaKTtmTUXqvE42Y5zL++b1QQXUWYopDwaPb4Lm+fZjbyJnrgDhsID
         hfd2+BhKjlvAZHW37q24KV4iWLroLuZaHrKG2WAKPK4f/bXV+XbNNDXOtDy3VwGIdI7A
         +VIA==
X-Gm-Message-State: APjAAAVZ9GTBH0p3VVDEVytJeM01FWDmoBPK2qDikSjsPAhO0YIf+s9i
        6swMQozVBkIAZ7qKeEXMf6totg==
X-Google-Smtp-Source: APXvYqyyUQQMpWFfqqnY1+kkknYiFDuvhN02hQKZ5YtOLDuOntF6aWyDvGMULBXc37JgAEFjADK+/Q==
X-Received: by 2002:a17:906:4581:: with SMTP id t1mr64624488ejq.187.1558714806496;
        Fri, 24 May 2019 09:20:06 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id f32sm850181edf.36.2019.05.24.09.20.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 24 May 2019 09:20:05 -0700 (PDT)
Date:   Fri, 24 May 2019 18:20:03 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     dri-devel@lists.freedesktop.org, Dave Airlie <airlied@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "open list:DRM DRIVER FOR QXL VIRTUAL GPU" 
        <virtualization@lists.linux-foundation.org>,
        "open list:DRM DRIVER FOR QXL VIRTUAL GPU" 
        <spice-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/qxl: drop WARN_ONCE()
Message-ID: <20190524162003.GC21222@phenom.ffwll.local>
Mail-Followup-To: Gerd Hoffmann <kraxel@redhat.com>,
        dri-devel@lists.freedesktop.org, Dave Airlie <airlied@redhat.com>,
        David Airlie <airlied@linux.ie>,
        "open list:DRM DRIVER FOR QXL VIRTUAL GPU" <virtualization@lists.linux-foundation.org>,
        "open list:DRM DRIVER FOR QXL VIRTUAL GPU" <spice-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20190524104251.22761-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190524104251.22761-1-kraxel@redhat.com>
X-Operating-System: Linux phenom 4.14.0-3-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 24, 2019 at 12:42:50PM +0200, Gerd Hoffmann wrote:
> There is no good reason to flood the kernel log with a WARN
> stacktrace just because someone tried to mmap a prime buffer.

Yeah no userspace triggerable dmesg noise above debug level.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> ---
>  drivers/gpu/drm/qxl/qxl_prime.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/qxl/qxl_prime.c b/drivers/gpu/drm/qxl/qxl_prime.c
> index 114653b471c6..7d3816fca5a8 100644
> --- a/drivers/gpu/drm/qxl/qxl_prime.c
> +++ b/drivers/gpu/drm/qxl/qxl_prime.c
> @@ -77,6 +77,5 @@ void qxl_gem_prime_vunmap(struct drm_gem_object *obj, void *vaddr)
>  int qxl_gem_prime_mmap(struct drm_gem_object *obj,
>  		       struct vm_area_struct *area)
>  {
> -	WARN_ONCE(1, "not implemented");
>  	return -ENOSYS;
>  }
> -- 
> 2.18.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
