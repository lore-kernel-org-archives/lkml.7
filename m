Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 153DEC3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 20:10:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD6402086A
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 20:09:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=poorly.run header.i=@poorly.run header.b="Zm+UazHZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728519AbfITUJ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 16:09:58 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:36316 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728325AbfITUJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 16:09:58 -0400
Received: by mail-yw1-f65.google.com with SMTP id x64so2923754ywg.3
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2019 13:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=poorly.run; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fPRCHQzpfEtb8pJUsApdl9+PA2f2wilGmwV36eHSwJw=;
        b=Zm+UazHZXDVBPVmnbWqq42tkf0O74KCkKSHLn0pJ/FvfQ8e9QvCMQ/HN0Z+Yy7wnmI
         +3+M+Rk+ejc7xtzj/Aglz2pJiMsb0nbGkiSVlcZ9OZVto0xlb6mIl21gUe5zSqoy1iB+
         Xwr6ggqAAMTI1kn349tSiDMQnuJqBINH1/qgOjfxxaon457VjkYakk9AbvQrEdEX5XHN
         FNtqKXdp583UpURWn0jx4vasTm7bD3ajA5vLbDLkTOYJxLD83LVUFlA14dD/AzRwEpS4
         vUMUjYw3XYSPTX/5Azqpe4cNggVD8rZw6C67o0xuX3lXnG6DCUPHW6B+4VPJW2apWmND
         E+UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fPRCHQzpfEtb8pJUsApdl9+PA2f2wilGmwV36eHSwJw=;
        b=BFa3Z28pNaLm4abUXVSVp7W/wCOvzmi9gxblKWXs3rNnaOxAauRDUdFcfC8+cSD/XU
         lFeOUkILQUGpJLta6F1T6oAq9WxzxLV5/fOs+dTAwiGxNVifku4tqKvyF/o89xoWNgz9
         y7Wahza6eywfffXjV6qpCxeujRoNNahbxyO+l+DyOxhzuq0KPygzHVw/I0Uwq59W197j
         DyWvcV60YMDedKoPLlOoPbOkWvytiEfe5RbyQV4n4ydCGSeAv+kbBXg1FOQi1K8OxKaC
         d2d8bseaxYo6AasvrfYr9QrtpRUFc/4TWpVMULZZf/mfoo81v05REmSyzDvEhRt2sKZ9
         ZF7w==
X-Gm-Message-State: APjAAAXFGhJR/xIQJuWnNPCm3g04xbQLu9LAVW0uJXmV0NDBKIOJAhAW
        +FBdGga7tNf2M0qDNy5JFrAwa3I0FqZZfM0FDkmyxg==
X-Google-Smtp-Source: APXvYqzK0C/i2SB82eJl+OB23YtwahG1WzvELYqmDwqX18Zw57PhUOtsAUdaCOM1Oi2vvaztcb67riyJvckS73UEUjg=
X-Received: by 2002:a81:92c3:: with SMTP id j186mr13116669ywg.372.1569010197120;
 Fri, 20 Sep 2019 13:09:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190920172914.4015180-1-megous@megous.com>
In-Reply-To: <20190920172914.4015180-1-megous@megous.com>
From:   Sean Paul <sean@poorly.run>
Date:   Fri, 20 Sep 2019 16:09:21 -0400
Message-ID: <CAMavQKKLew+iyL5LVEE9hD9Gyt3WmbnUQf5a=h3OwdmSydzAGw@mail.gmail.com>
Subject: Re: [PATCH] drm: Remove redundant of_device_is_available check
To:     megous@megous.com
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 20, 2019 at 1:29 PM <megous@megous.com> wrote:
>
> From: Ondrej Jirman <megous@megous.com>
>
> This check is already performed by of_graph_get_remote_node. No
> need to repeat it immediately after the call.
>
> Signed-off-by: Ondrej Jirman <megous@megous.com>

Thanks for your patch, I've applied it to drm-misc-next.

Sean

> ---
>  drivers/gpu/drm/drm_of.c | 5 -----
>  1 file changed, 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_of.c b/drivers/gpu/drm/drm_of.c
> index 43d89dd59c6b..0ca58803ba46 100644
> --- a/drivers/gpu/drm/drm_of.c
> +++ b/drivers/gpu/drm/drm_of.c
> @@ -247,17 +247,12 @@ int drm_of_find_panel_or_bridge(const struct device_node *np,
>                 *panel = NULL;
>
>         remote = of_graph_get_remote_node(np, port, endpoint);
>         if (!remote)
>                 return -ENODEV;
>
> -       if (!of_device_is_available(remote)) {
> -               of_node_put(remote);
> -               return -ENODEV;
> -       }
> -
>         if (panel) {
>                 *panel = of_drm_find_panel(remote);
>                 if (!IS_ERR(*panel))
>                         ret = 0;
>                 else
>                         *panel = NULL;
> --
> 2.23.0
>
