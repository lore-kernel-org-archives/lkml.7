Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56C86C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 09:49:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27F4320872
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 09:49:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="Lc7VSrvS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbfKUJtc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 04:49:32 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:56019 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726792AbfKUJtb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 04:49:31 -0500
Received: by mail-wm1-f66.google.com with SMTP id b11so2943680wmb.5
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2019 01:49:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mQ72QGAuONoaD06OtAUFQjjkbWWipmAJdNTyvJOj0zw=;
        b=Lc7VSrvSOKjJsQGNVMBoNqty9LZdG+eGBss036j1dc+dtCkIbLCBYS6Xu3Mzr+uCCH
         U+4PvmPM16zC4t743caJWje5/YOdFcChk7BIoVIYbt63eDeTa1Z5ySkg1GDMk1iEXph6
         MkdejZkPZ14Xqv4Kx6WhConq/x7/9mS8EN1U4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=mQ72QGAuONoaD06OtAUFQjjkbWWipmAJdNTyvJOj0zw=;
        b=Zd9y4ktIMEj8XS9wpMu8b58j1PCGGrUT35mZGvSn8IecE7wy55PRhfh1uK9AIg39zy
         t5DfOJRUrAan8FEx+eiUEvKx2sCW/wFzLWEdkNhHtGKEsdzjNsFLi+6qAbdsBvzf3mIo
         rPc+Etd/2hTpPo97kQWf4ZcVplrHk8aG+qG+VJMaqcdQRAulBGGqYKAjnRyK/KeAC83T
         WQdngoct7Hq44tKPFo8JfIrASdRzszMk9VW31y6QOoLbLNcoosmzSiSv+gA7bZ5L1MKx
         Su98es216gN5MVdq/Y+QNDoER/zvB0yLCLQrylSMnYcZMOV4YhZxV7hvmRqyswutjMy+
         sPmQ==
X-Gm-Message-State: APjAAAU02SehcP3MTfWU4RgKbOwxsVLyq+m20OJGrJfCAzIDwqqv5+ji
        0Q5UD2rdsHqzr08vMi9d0I3WEA==
X-Google-Smtp-Source: APXvYqyWLlsZIl/sVzGpMq0amP0tId4NYVfLQK9FPM7iZRvYtQmGILYlVx6PgqxtGP5+7WicEJmtgw==
X-Received: by 2002:a05:600c:2295:: with SMTP id 21mr8289518wmf.85.1574329769158;
        Thu, 21 Nov 2019 01:49:29 -0800 (PST)
Received: from phenom.ffwll.local (212-51-149-96.fiber7.init7.net. [212.51.149.96])
        by smtp.gmail.com with ESMTPSA id r25sm2269227wmh.6.2019.11.21.01.49.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2019 01:49:28 -0800 (PST)
Date:   Thu, 21 Nov 2019 10:49:26 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>,
        Dave Airlie <airlied@gmail.com>
Cc:     Liviu Dudau <Liviu.Dudau@arm.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        Brian Starkey <Brian.Starkey@arm.com>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        Mihail Atanassov <Mihail.Atanassov@arm.com>, nd <nd@arm.com>,
        "Oscar Zhang (Arm Technology China)" <Oscar.Zhang@arm.com>,
        "Tiannan Zhu (Arm Technology China)" <Tiannan.Zhu@arm.com>,
        "Jonathan Chai (Arm Technology China)" <Jonathan.Chai@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "Julien Yin (Arm Technology China)" <Julien.Yin@arm.com>,
        "Channing Chen (Arm Technology China)" <Channing.Chen@arm.com>,
        "Thomas Sun (Arm Technology China)" <thomas.Sun@arm.com>,
        "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>,
        Ben Davis <Ben.Davis@arm.com>
Subject: Re: [PATCH v4 6/6] drm/komeda: Expose side_by_side by sysfs/config_id
Message-ID: <20191121094926.GC6236@phenom.ffwll.local>
Mail-Followup-To: "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>,
        Dave Airlie <airlied@gmail.com>, Liviu Dudau <Liviu.Dudau@arm.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        Brian Starkey <Brian.Starkey@arm.com>,
        "maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>,
        Mihail Atanassov <Mihail.Atanassov@arm.com>, nd <nd@arm.com>,
        "Oscar Zhang (Arm Technology China)" <Oscar.Zhang@arm.com>,
        "Tiannan Zhu (Arm Technology China)" <Tiannan.Zhu@arm.com>,
        "Jonathan Chai (Arm Technology China)" <Jonathan.Chai@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "Julien Yin (Arm Technology China)" <Julien.Yin@arm.com>,
        "Channing Chen (Arm Technology China)" <Channing.Chen@arm.com>,
        "Thomas Sun (Arm Technology China)" <thomas.Sun@arm.com>,
        "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>,
        Ben Davis <Ben.Davis@arm.com>
References: <20191121071205.27511-1-james.qian.wang@arm.com>
 <20191121071205.27511-7-james.qian.wang@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191121071205.27511-7-james.qian.wang@arm.com>
X-Operating-System: Linux phenom 5.3.0-1-amd64 
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 21, 2019 at 07:12:55AM +0000, james qian wang (Arm Technology China) wrote:
> There are some restrictions if HW works on side_by_side, expose it via
> config_id to user.
> 
> Signed-off-by: James Qian Wang (Arm Technology China) <james.qian.wang@arm.com>
> ---
>  drivers/gpu/drm/arm/display/include/malidp_product.h | 3 ++-
>  drivers/gpu/drm/arm/display/komeda/komeda_dev.c      | 1 +
>  2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/arm/display/include/malidp_product.h b/drivers/gpu/drm/arm/display/include/malidp_product.h
> index 1053b11352eb..96e2e4016250 100644
> --- a/drivers/gpu/drm/arm/display/include/malidp_product.h
> +++ b/drivers/gpu/drm/arm/display/include/malidp_product.h
> @@ -27,7 +27,8 @@ union komeda_config_id {
>  			n_scalers:2, /* number of scalers per pipeline */
>  			n_layers:3, /* number of layers per pipeline */
>  			n_richs:3, /* number of rich layers per pipeline */
> -			reserved_bits:6;
> +			side_by_side:1, /* if HW works on side_by_side mode */
> +			reserved_bits:5;
>  	};
>  	__u32 value;
>  };
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_dev.c b/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
> index c3fa4835cb8d..4dd4699d4e3d 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
> @@ -83,6 +83,7 @@ config_id_show(struct device *dev, struct device_attribute *attr, char *buf)

Uh, this sysfs file here looks a lot like uapi for some compositor to
decide what to do. Do you have the userspace for this?

Also a few more thoughts on this:
- You can't just add more fields to uapi structs.
- This doesn't really feel like it was ever reviewed to fit into atomic.
- sysfs should be one value per file, not a smorgasbrod of things stuffed
  into a binary structure.
-Daniel

>  	memset(&config_id, 0, sizeof(config_id));
>  
>  	config_id.max_line_sz = pipe->layers[0]->hsize_in.end;
> +	config_id.side_by_side = mdev->side_by_side;
>  	config_id.n_pipelines = mdev->n_pipelines;
>  	config_id.n_scalers = pipe->n_scalers;
>  	config_id.n_layers = pipe->n_layers;
> -- 
> 2.20.1
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
