Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF580C4CECD
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 12:58:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8056E21852
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 12:58:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="Tmu3YdHS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728153AbfIQM6V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 08:58:21 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:34045 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727383AbfIQM6U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 08:58:20 -0400
Received: by mail-ed1-f68.google.com with SMTP id p10so1424922edq.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2019 05:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=JXHXCUn3xM+axjQAgcuFy2E9zY+IExK3yfeI1AgqjB4=;
        b=Tmu3YdHSFA/P+RkVYRWHFlE/3X1GgBFXNXG6wy3twbQw9KPZwRbZYwc5AmDRKzeN6g
         SS9cEfqNtVkP0Wsa/59olR50tqTVxpASsF/9EQ0z/X/nry4N1NLvE/wemSdYQMZ/JU8t
         98iX46vz2p7axxaycWCzoz+LQGBLFndkR5hGU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=JXHXCUn3xM+axjQAgcuFy2E9zY+IExK3yfeI1AgqjB4=;
        b=Wi7S/22UHPXQJB/VkO1ZFUgudewW0Sq0D3zlUFHRonb9IYdKTIBAe0bVRqj+xq17SS
         HKBIYo2iHZJDw5G6JtfNoqYbw489Mn4oxT22xRvcLwg39ejmpBR43RNO1U3yq5JvzqIu
         /yIsc+ArCJd2NJoDjypq6IgQDsIartQGb+kmtJONPEn7581NgrpxuWbKoF/wUjajuOHo
         95+QIyuNiRE7sholCNaqAKqe9VgK+eHLOxEeGmqXq6emY84Cyq5xqhgQOe6QGY2IAf19
         pWdTOMawdDHPH5RJ78gD/vibMs20qqTdpO2GBsw+3wPo6Tu2yEvywTu90HuZxzVawIev
         jytg==
X-Gm-Message-State: APjAAAV2jEgWP5WKpMcIDQdLvqV7yN/RAfhObsQPC+OeU217XQqQMpyC
        A5tN6yF28SLHMdn7985bSr+rOg==
X-Google-Smtp-Source: APXvYqwf2E3f40RP0ReqpIf9aZ1TLZgS52+Wgx+6ACEfQaxosSIzrNsstrvKcAOYE/POx7VVeBQCsw==
X-Received: by 2002:a17:906:31c3:: with SMTP id f3mr4727778ejf.296.1568725097303;
        Tue, 17 Sep 2019 05:58:17 -0700 (PDT)
Received: from phenom.ffwll.local (212-51-149-96.fiber7.init7.net. [212.51.149.96])
        by smtp.gmail.com with ESMTPSA id j8sm333049edy.44.2019.09.17.05.58.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2019 05:58:16 -0700 (PDT)
Date:   Tue, 17 Sep 2019 14:58:14 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Colin King <colin.king@canonical.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Alexandru-Cosmin Gheorghe <Alexandru-Cosmin.Gheorghe@arm.com>,
        dri-devel@lists.freedesktop.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/selftests: fix spelling mistake "misssing" ->
 "missing"
Message-ID: <20190917125814.GS3958@phenom.ffwll.local>
Mail-Followup-To: Colin King <colin.king@canonical.com>,
        David Airlie <airlied@linux.ie>,
        Alexandru-Cosmin Gheorghe <Alexandru-Cosmin.Gheorghe@arm.com>,
        dri-devel@lists.freedesktop.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190911091227.5710-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190911091227.5710-1-colin.king@canonical.com>
X-Operating-System: Linux phenom 5.2.0-2-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 11, 2019 at 10:12:27AM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> There is a spelling mistake in a literal string, fix it.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied, thanks.
-Daniel

> ---
>  drivers/gpu/drm/selftests/test-drm_framebuffer.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/selftests/test-drm_framebuffer.c b/drivers/gpu/drm/selftests/test-drm_framebuffer.c
> index 74d5561a862b..2d29ea6f92e2 100644
> --- a/drivers/gpu/drm/selftests/test-drm_framebuffer.c
> +++ b/drivers/gpu/drm/selftests/test-drm_framebuffer.c
> @@ -126,7 +126,7 @@ static struct drm_framebuffer_test createbuffer_tests[] = {
>  		 .handles = { 1, 1, 0 }, .pitches = { MAX_WIDTH, MAX_WIDTH - 1, 0 },
>  	}
>  },
> -{ .buffer_created = 0, .name = "NV12 Invalid modifier/misssing DRM_MODE_FB_MODIFIERS flag",
> +{ .buffer_created = 0, .name = "NV12 Invalid modifier/missing DRM_MODE_FB_MODIFIERS flag",
>  	.cmd = { .width = MAX_WIDTH, .height = MAX_HEIGHT, .pixel_format = DRM_FORMAT_NV12,
>  		 .handles = { 1, 1, 0 }, .modifier = { DRM_FORMAT_MOD_SAMSUNG_64_32_TILE, 0, 0 },
>  		 .pitches = { MAX_WIDTH, MAX_WIDTH, 0 },
> -- 
> 2.20.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
