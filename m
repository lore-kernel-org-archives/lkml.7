Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACE8BC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 10:43:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 783302184E
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 10:43:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="A+zlhz5h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727399AbfCNKnV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 06:43:21 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:47047 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726337AbfCNKnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 06:43:21 -0400
Received: by mail-ed1-f65.google.com with SMTP id n17so4144025edt.13
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 03:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=97AJrS/w1x/0ngD4ZaJAOq1vLtobombFG/KIgsrR02s=;
        b=A+zlhz5hMoqCS/crzHPUCjz3rFPbdf3Er2E5QkCcrAvcVnpSHacqGdunaTJL1h8kPj
         Ij2IOm34/PDapzK2BmWEdLkbclkLIxuLaFkMLhahWMbu1bjSfu3pK/zYIFSuHZr0GVs2
         xqYIvGu5YMji8pFpcGX68Qt2i8IcMsRKDyfmI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=97AJrS/w1x/0ngD4ZaJAOq1vLtobombFG/KIgsrR02s=;
        b=FI4bgG5ZzqgrNBxhyQVEU5TDYlyI5smtZtQRONQXnKH6GfBOIgkMJwZzvx6m4W4jOX
         47tMUWR9EynreaRjekojBIUe4YmicFjD8jQou3yuDzWn77MixCzoAcLIGY6u43XJWKWF
         nH+BdmWXLuRUhOtMMiyjpv+8PozO/U7HOdZw2roP7rADMBVVzyLfDOzUHZMnwXLGy2u+
         XwJyc+X5tqtUPkRnPdTqrHfAx2MOiiKRl2hU/UqOEYkZx4CiVGny1ERyU3mGhk31bSV8
         CPvkEStEX8SYjqmVXKTc4R29314HgfanaCLCppmBYdb52+/8cYCS+q+2cLFct16lHQG6
         K/Kw==
X-Gm-Message-State: APjAAAVoxmqHY3aJYaInweHvJUlmqk5nP8JtpnwuCR54NGEHN9qPznvV
        B6j17e1BOogelTO8MXzg8CFybUYzmEFyHQ==
X-Google-Smtp-Source: APXvYqwbUmCJc9c0OT9bGoJgJ/TJ33v9DVARMizM2kd84vT9EeWb2IzfUiSBGv4HtQ1DXrmzVW+FOQ==
X-Received: by 2002:a50:b3bc:: with SMTP id s57mr10853479edd.206.1552560199585;
        Thu, 14 Mar 2019 03:43:19 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id v15sm1434577edl.40.2019.03.14.03.43.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Mar 2019 03:43:18 -0700 (PDT)
Date:   Thu, 14 Mar 2019 11:43:16 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Luca Ceresoli <luca@lucaceresoli.net>
Cc:     dri-devel@lists.freedesktop.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] drm/doc: fix missing verb
Message-ID: <20190314104316.GS2665@phenom.ffwll.local>
Mail-Followup-To: Luca Ceresoli <luca@lucaceresoli.net>,
        dri-devel@lists.freedesktop.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        linux-kernel@vger.kernel.org
References: <20190313153537.22654-1-luca@lucaceresoli.net>
 <20190313153537.22654-2-luca@lucaceresoli.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190313153537.22654-2-luca@lucaceresoli.net>
X-Operating-System: Linux phenom 4.19.0-1-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 13, 2019 at 04:35:37PM +0100, Luca Ceresoli wrote:
> Add a missing "be". While there, also fix the syntax for
> struct drm_device.
> 
> Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>

Queued for 5.2, thanks for your patch.
-Daniel

> ---
>  include/drm/drm_drv.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/include/drm/drm_drv.h b/include/drm/drm_drv.h
> index 570f9d03b2eb..ecbbcb281260 100644
> --- a/include/drm/drm_drv.h
> +++ b/include/drm/drm_drv.h
> @@ -152,9 +152,9 @@ enum drm_driver_feature {
>  /**
>   * struct drm_driver - DRM driver structure
>   *
> - * This structure represent the common code for a family of cards. There will
> - * one drm_device for each card present in this family. It contains lots of
> - * vfunc entries, and a pile of those probably should be moved to more
> + * This structure represent the common code for a family of cards. There will be
> + * one &struct drm_device for each card present in this family. It contains lots
> + * of vfunc entries, and a pile of those probably should be moved to more
>   * appropriate places like &drm_mode_config_funcs or into a new operations
>   * structure for GEM drivers.
>   */
> -- 
> 2.17.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
