Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4761EC4CECE
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 08:56:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10BCF20673
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 08:56:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="H3fsufQY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730617AbfJNI4K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 04:56:10 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:37418 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730354AbfJNI4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 04:56:10 -0400
Received: by mail-ed1-f65.google.com with SMTP id r4so14109328edy.4
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2019 01:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=9F9gOYnMz1+3hKjqRaXRapzlcu7Wa8gomJLsrlXQKa0=;
        b=H3fsufQY+jqDLcAODQvS6dik5keKPPlV2l5p8CI7y+FRxa4pGXYxJjncbozWnJXz6G
         ceDsHxGT9HNEGu4vcQsYHfkpiTXCYlvrJL4wrEsl2Ov72zkFDOjo+IJt5uyvUQusaUds
         9xbzdg1w3vJK3LNLxoAHppF0MzZm0Od1SGiEU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=9F9gOYnMz1+3hKjqRaXRapzlcu7Wa8gomJLsrlXQKa0=;
        b=LWH7R3zmv6qhSw9UvDSzsnBNFLuutaIw+8woOAhHmGIWQMvH43onzBm1kHNkQwQbpq
         IHOhVX+8gIclvdC0WG/HvMIxyynp/xfL6kTOVfXPlNegJDyaTG27ddemkGYORtdYjdsG
         3600JvrI4aXHJpWZywcLBmAfbG7d0B0EP8MWPu1CJrxCCBmBJurSk/3zLrMRuD/XzDdJ
         E5iXtLOH68gnQHDMTxpB51+rrxCTA/psBAWqtnKkgdNxpPzrCnuKnjOHtU3XU9w1I85B
         D30j+W7vvFBACUfYKMdkEjz3ZurmSBIfSXbmxXrV0YZV0+xrjsfB7IYVzQGB9PfIqM6Q
         pO7w==
X-Gm-Message-State: APjAAAV9uK07HdYknkt33HXMz6ePKjrgHVBbKQqAGL4fz1zN1n/qALM6
        JDRAbfQecoKa6xwxxVLHGQ+Ldg==
X-Google-Smtp-Source: APXvYqz+qN5kR4Hx6/KSVeypn+Z7ntkOnMDY9b5LAjIyvJNHuU8TmhPdlZMFr08lxA2iT3clRfPgFg==
X-Received: by 2002:a17:906:5388:: with SMTP id g8mr27299623ejo.278.1571043368485;
        Mon, 14 Oct 2019 01:56:08 -0700 (PDT)
Received: from phenom.ffwll.local (212-51-149-96.fiber7.init7.net. [212.51.149.96])
        by smtp.gmail.com with ESMTPSA id v22sm3077031edm.89.2019.10.14.01.56.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2019 01:56:07 -0700 (PDT)
Date:   Mon, 14 Oct 2019 10:56:05 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
Cc:     Liviu Dudau <Liviu.Dudau@arm.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        Brian Starkey <Brian.Starkey@arm.com>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "sean@poorly.run" <sean@poorly.run>,
        "imirkin@alum.mit.edu" <imirkin@alum.mit.edu>, nd <nd@arm.com>,
        Ayan Halder <Ayan.Halder@arm.com>,
        "Oscar Zhang (Arm Technology China)" <Oscar.Zhang@arm.com>,
        "Tiannan Zhu (Arm Technology China)" <Tiannan.Zhu@arm.com>,
        Mihail Atanassov <Mihail.Atanassov@arm.com>,
        "Jonathan Chai (Arm Technology China)" <Jonathan.Chai@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "Julien Yin (Arm Technology China)" <Julien.Yin@arm.com>,
        "Channing Chen (Arm Technology China)" <Channing.Chen@arm.com>,
        "Yiqi Kang (Arm Technology China)" <Yiqi.Kang@arm.com>,
        "Thomas Sun (Arm Technology China)" <thomas.Sun@arm.com>,
        "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>,
        Ben Davis <Ben.Davis@arm.com>
Subject: Re: [PATCH v2 1/4] drm/komeda: Add a new helper
 drm_color_ctm_s31_32_to_qm_n()
Message-ID: <20191014085605.GF11828@phenom.ffwll.local>
Mail-Followup-To: "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>,
        Liviu Dudau <Liviu.Dudau@arm.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        Brian Starkey <Brian.Starkey@arm.com>,
        "maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>,
        "sean@poorly.run" <sean@poorly.run>,
        "imirkin@alum.mit.edu" <imirkin@alum.mit.edu>, nd <nd@arm.com>,
        Ayan Halder <Ayan.Halder@arm.com>,
        "Oscar Zhang (Arm Technology China)" <Oscar.Zhang@arm.com>,
        "Tiannan Zhu (Arm Technology China)" <Tiannan.Zhu@arm.com>,
        Mihail Atanassov <Mihail.Atanassov@arm.com>,
        "Jonathan Chai (Arm Technology China)" <Jonathan.Chai@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "Julien Yin (Arm Technology China)" <Julien.Yin@arm.com>,
        "Channing Chen (Arm Technology China)" <Channing.Chen@arm.com>,
        "Yiqi Kang (Arm Technology China)" <Yiqi.Kang@arm.com>,
        "Thomas Sun (Arm Technology China)" <thomas.Sun@arm.com>,
        "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>,
        Ben Davis <Ben.Davis@arm.com>
References: <20191011054240.17782-1-james.qian.wang@arm.com>
 <20191011054240.17782-2-james.qian.wang@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191011054240.17782-2-james.qian.wang@arm.com>
X-Operating-System: Linux phenom 5.2.0-2-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 11, 2019 at 05:43:09AM +0000, james qian wang (Arm Technology China) wrote:
> Add a new helper function drm_color_ctm_s31_32_to_qm_n() for driver to
> convert S31.32 sign-magnitude to Qm.n 2's complement that supported by
> hardware.
> 
> Signed-off-by: james qian wang (Arm Technology China) <james.qian.wang@arm.com>
> ---
>  drivers/gpu/drm/drm_color_mgmt.c | 23 +++++++++++++++++++++++
>  include/drm/drm_color_mgmt.h     |  2 ++
>  2 files changed, 25 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_color_mgmt.c b/drivers/gpu/drm/drm_color_mgmt.c
> index 4ce5c6d8de99..3d533d0b45af 100644
> --- a/drivers/gpu/drm/drm_color_mgmt.c
> +++ b/drivers/gpu/drm/drm_color_mgmt.c
> @@ -132,6 +132,29 @@ uint32_t drm_color_lut_extract(uint32_t user_input, uint32_t bit_precision)
>  }
>  EXPORT_SYMBOL(drm_color_lut_extract);
>  
> +/**
> + * drm_color_ctm_s31_32_to_qm_n
> + *
> + * @user_input: input value
> + * @m: number of integer bits
> + * @n: number of fractinal bits
> + *
> + * Convert and clamp S31.32 sign-magnitude to Qm.n 2's complement.

What's the Q meaning here? Also maybe specify that the higher bits above
m+n are cleared to all 0 or all 1. Unit test would be lovely too. Anyway:

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

> + */
> +uint64_t drm_color_ctm_s31_32_to_qm_n(uint64_t user_input,
> +				      uint32_t m, uint32_t n)
> +{
> +	u64 mag = (user_input & ~BIT_ULL(63)) >> (32 - n);
> +	bool negative = !!(user_input & BIT_ULL(63));
> +	s64 val;
> +
> +	/* the range of signed 2s complement is [-2^n+m, 2^n+m - 1] */
> +	val = clamp_val(mag, 0, negative ? BIT(n + m) : BIT(n + m) - 1);
> +
> +	return negative ? 0ll - val : val;
> +}
> +EXPORT_SYMBOL(drm_color_ctm_s31_32_to_qm_n);
> +
>  /**
>   * drm_crtc_enable_color_mgmt - enable color management properties
>   * @crtc: DRM CRTC
> diff --git a/include/drm/drm_color_mgmt.h b/include/drm/drm_color_mgmt.h
> index d1c662d92ab7..60fea5501886 100644
> --- a/include/drm/drm_color_mgmt.h
> +++ b/include/drm/drm_color_mgmt.h
> @@ -30,6 +30,8 @@ struct drm_crtc;
>  struct drm_plane;
>  
>  uint32_t drm_color_lut_extract(uint32_t user_input, uint32_t bit_precision);
> +uint64_t drm_color_ctm_s31_32_to_qm_n(uint64_t user_input,
> +				      uint32_t m, uint32_t n);
>  
>  void drm_crtc_enable_color_mgmt(struct drm_crtc *crtc,
>  				uint degamma_lut_size,
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
