Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79CF1C76194
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 20:06:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51577218C9
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 20:06:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=poorly.run header.i=@poorly.run header.b="JtIYbjWt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732479AbfGVUGa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 16:06:30 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:34995 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728180AbfGVUG1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 16:06:27 -0400
Received: by mail-yw1-f65.google.com with SMTP id g19so15610018ywe.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 13:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=poorly.run; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HwvJiB020PdHZrr6dRx+YAOsgzbnAkiZvqKqCv91HY0=;
        b=JtIYbjWtQYouQdTV52R6hWVjmr3h57dT7O21FB17MAyvKSdf74C8ZQ/+UWuVXvOJPp
         aKOjxaacmyjkLvWwvM4/prsMKdiimEZ9YgK3Fcv2V7GMLb/sIaU6zTApATxI39pVHQWV
         lyNwl6s5dbvE73l0D+VnMm2cQWYc8y1prkn79WgdqihoOcXQaiZ9L44hPGAqOvspPIYf
         sVsWG16yFJULB+qnmzLAjFYcKLfidEqT5RbRJW4cYbtVj0sIOkBygQRSny/9K7KoROeD
         SKOl/vT9+KCDofXbNh/M8kkSINAXNf3Fsw0LqEzLhh1zlzGwFA8KzmNo/2ySLN3D/puE
         fTnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HwvJiB020PdHZrr6dRx+YAOsgzbnAkiZvqKqCv91HY0=;
        b=ItotVd9TLoc9NVZpjPJ0Mm30SZkP8CpiXWgn797XzwMPdGA7bea2JBP60lXYYRrFI6
         EkWe+nJ7y9Ldh1RUD1nU/uZLaUGn2JZwr6gCRlp/Y5/+WT8g1xsjxz8PJv0+AwPcEzqv
         Cjx5zcbc4HLcUS5z8ybjAl1An+gRo+iL8S61CqbGTnSKjtpw9UBcm8csk0Nm+df7hiNs
         70DGcGjsLt1QU67DMzlg77ip/wQiW0xrh/6txazBbUY8knRMEM6zTQLQ4P1/0/mZaLk9
         A79C/3bLLi0m2OjuDgBrpLu3mC/ah2EWxtG0ORvdRqSZ+5OA1mofShzuhXbgqsuy/p90
         hkjg==
X-Gm-Message-State: APjAAAXmEngW421Bqd8UqdYMX3X/vHK2RGQvD0uI5H/lhZrhcEbHMIAS
        aPU+0ZDF6TiDlWEw3Ic1o4AojQ==
X-Google-Smtp-Source: APXvYqzI5OqP4T4u5XK4DV6I74KUqwu9SCJCcgyXgPpUcws2Jxp6KM4gJRYUdFkGTCujjYBQpMHQPQ==
X-Received: by 2002:a81:aa50:: with SMTP id z16mr41029409ywk.278.1563825986781;
        Mon, 22 Jul 2019 13:06:26 -0700 (PDT)
Received: from localhost ([2620:0:1013:11:89c6:2139:5435:371d])
        by smtp.gmail.com with ESMTPSA id 131sm9412431ywq.21.2019.07.22.13.06.26
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 22 Jul 2019 13:06:26 -0700 (PDT)
Date:   Mon, 22 Jul 2019 16:06:25 -0400
From:   Sean Paul <sean@poorly.run>
To:     Qian Cai <cai@lca.pw>
Cc:     daniel@ffwll.ch, maarten.lankhorst@linux.intel.com,
        maxime.ripard@bootlin.com, sean@poorly.run, airlied@linux.ie,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm: silence variable 'conn' set but not used
Message-ID: <20190722200625.GJ104440@art_vandelay>
References: <1563822886-13570-1-git-send-email-cai@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1563822886-13570-1-git-send-email-cai@lca.pw>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 22, 2019 at 03:14:46PM -0400, Qian Cai wrote:
> The "struct drm_connector" iteration cursor from
> "for_each_new_connector_in_state" is never used in atomic_remove_fb()
> which generates a compilation warning,
> 
> drivers/gpu/drm/drm_framebuffer.c: In function 'atomic_remove_fb':
> drivers/gpu/drm/drm_framebuffer.c:838:24: warning: variable 'conn' set
> but not used [-Wunused-but-set-variable]
> 
> Silence it by marking "conn" __maybe_unused.
> 
> Signed-off-by: Qian Cai <cai@lca.pw>

Thanks for your patch! I've applied it to drm-misc-fixes

Sean

> ---
>  drivers/gpu/drm/drm_framebuffer.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/drm_framebuffer.c b/drivers/gpu/drm/drm_framebuffer.c
> index 0b72468e8131..57564318ceea 100644
> --- a/drivers/gpu/drm/drm_framebuffer.c
> +++ b/drivers/gpu/drm/drm_framebuffer.c
> @@ -835,7 +835,7 @@ static int atomic_remove_fb(struct drm_framebuffer *fb)
>  	struct drm_device *dev = fb->dev;
>  	struct drm_atomic_state *state;
>  	struct drm_plane *plane;
> -	struct drm_connector *conn;
> +	struct drm_connector *conn __maybe_unused;
>  	struct drm_connector_state *conn_state;
>  	int i, ret;
>  	unsigned plane_mask;
> -- 
> 1.8.3.1
> 

-- 
Sean Paul, Software Engineer, Google / Chromium OS
