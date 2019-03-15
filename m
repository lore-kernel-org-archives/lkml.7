Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B16CC4360F
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 10:48:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BFAB21871
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 10:48:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="bsx8eHj3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728898AbfCOKsT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 06:48:19 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:38715 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728745AbfCOKsS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 06:48:18 -0400
Received: by mail-ed1-f65.google.com with SMTP id e10so3295080edy.5
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2019 03:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=KuZv0S1tjaJAsiqq7PjT7EfO6XTWwwtL1h2LSortnxw=;
        b=bsx8eHj3Gig6PPM0vBCI2pOLG9aSNoSrJGr9JC+Ln8AnmzzS0alpR6FirCwPb7w4hh
         G1LZCAjm59Judza/i2vZcGgD8CKG/nEz/y8ufTmNlFRB3pTFRbb8OvLU30/4Lw07ki04
         yoQMDSLiRHnACEC7gEv//j2z5QWRx+gLelDTY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=KuZv0S1tjaJAsiqq7PjT7EfO6XTWwwtL1h2LSortnxw=;
        b=d+mws+Ytyx+5cBj0yNtPCeCJR5VfYbbHDAYDAWS3urWZ0ntdjiX0iH6I25wCcHEtjz
         DOhUs9/YhSCJp9cYvjgxK9BMcSNMQP7zsgrkLNd+O8HF1YkZ2qa31GlUXJyl4gMdTJzM
         9CVDZG2SOwhcc9Tx/GpWzh0dfeZbuwfzDJuy6LrGC77CPNZgJwBZolWXyjrHcN+vbdY5
         EudqFp0SQAxhjNcSJ8ks8iB5JBU8dfQZcfofqiW5GEeJ5Wcx2Ot1sP5l2AmJDYX2zUIu
         8Tuo0BNUIqa1aXOoArIXnJ+BzmlMMVrEtfJJTrcNVGX1K+SIi0evL6lW0dkB0X8SIskj
         IwWg==
X-Gm-Message-State: APjAAAUXYz6U6K/Hm1f+TBFqbRWleaXwzn4kLd7Wgx/a2/2bSwapbOlJ
        O/eqo12Jw7HgWmW9bD5rLKBCYQ==
X-Google-Smtp-Source: APXvYqy2TUaPKeC+JB4jyYCjEdZxgIzSE+HwlgPv6i4+Na2CHGUhGnYtbIpOC3i7RyVkgcfgAukAKg==
X-Received: by 2002:a17:906:6991:: with SMTP id i17mr1826610ejr.96.1552646896740;
        Fri, 15 Mar 2019 03:48:16 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id c8sm335077ejb.9.2019.03.15.03.48.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Mar 2019 03:48:15 -0700 (PDT)
Date:   Fri, 15 Mar 2019 11:48:13 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Cc:     linux-renesas-soc@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH 1/3] drm: fix subtle spelling error in drm_crtc_state
Message-ID: <20190315104813.GT2665@phenom.ffwll.local>
Mail-Followup-To: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        linux-renesas-soc@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>
References: <20190314220420.32487-1-kieran.bingham+renesas@ideasonboard.com>
 <20190314220420.32487-2-kieran.bingham+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190314220420.32487-2-kieran.bingham+renesas@ideasonboard.com>
X-Operating-System: Linux phenom 4.19.0-1-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 14, 2019 at 10:04:18PM +0000, Kieran Bingham wrote:
> The drm_crtc_state documentation contains a subtle misspelling of the
> word subtle. Correct it.
> 
> Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

> ---
>  include/drm/drm_crtc.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/drm/drm_crtc.h b/include/drm/drm_crtc.h
> index 85abd3fe9e83..f2b3762636df 100644
> --- a/include/drm/drm_crtc.h
> +++ b/include/drm/drm_crtc.h
> @@ -78,7 +78,7 @@ struct drm_plane_helper_funcs;
>  /**
>   * struct drm_crtc_state - mutable CRTC state
>   *
> - * Note that the distinction between @enable and @active is rather subtile:
> + * Note that the distinction between @enable and @active is rather subtle:
>   * Flipping @active while @enable is set without changing anything else may
>   * never return in a failure from the &drm_mode_config_funcs.atomic_check
>   * callback. Userspace assumes that a DPMS On will always succeed. In other
> -- 
> 2.19.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
