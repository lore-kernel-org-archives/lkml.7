Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30207C4CECE
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 15:59:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F4D120873
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 15:59:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732283AbfJNP7B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 11:59:01 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:42957 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731960AbfJNP7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 11:59:00 -0400
Received: by mail-vs1-f66.google.com with SMTP id m22so11110389vsl.9
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2019 08:59:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YhZmTuECyvNatPuwMHw4UrCLmojj7sz6D63jp3de7MU=;
        b=cn9bii7r/yhIBkbkP7/fp4o6xUMkh3cGnr1j9tpAr6Mjn20QzZfV5DjizDBY9UqFaq
         W4un88SuqUHR5NUP00VPS7kHZPFVlbAekKT57mMYmIdlHj9y3N3pqi+JnLxL1+wO/DD9
         RtwxsIRCJtjhFDdmt/6p2C6/lnwopcnyXd+FH1Z84+a3a4sF6hROfGoTiy0J+/aedQqh
         X1QjxJ2NjzmvPruaHGrZqZRHg86dvQf8vmwgOOmhxohAPHgA6NEvk5b2nmFWq5qJJzJX
         6TsAaanfHkBLvMYxYjdpGn+5OUyMr8efQUQC2a3tlA5x+T6CMbV/i8WUBsa0y2o65/IP
         c+dQ==
X-Gm-Message-State: APjAAAUctm7vii3xK7DO2lVjK6iQFT1h5wp/MPzKLbW9uHJFI5diop9/
        SY447yMWxxpS3mnIUv7VXGfwj8Xw1LDz4jMZItM=
X-Google-Smtp-Source: APXvYqwcPL8t68p5ICsXAF44cUv/Deq8Lfd1v6j50uCjwERnfswo082+5RyGFNTyE8RiX0Re8APNiEdJOCFy36neXSk=
X-Received: by 2002:a05:6102:253:: with SMTP id a19mr17354178vsq.37.1571068739538;
 Mon, 14 Oct 2019 08:58:59 -0700 (PDT)
MIME-Version: 1.0
References: <20191011054240.17782-1-james.qian.wang@arm.com> <20191011054240.17782-2-james.qian.wang@arm.com>
In-Reply-To: <20191011054240.17782-2-james.qian.wang@arm.com>
From:   Ilia Mirkin <imirkin@alum.mit.edu>
Date:   Mon, 14 Oct 2019 11:58:48 -0400
Message-ID: <CAKb7Uvik6MZSwCQ4QF7ed1wttfufbR-J4vNdOtYzM+1tqPE_vw@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] drm/komeda: Add a new helper drm_color_ctm_s31_32_to_qm_n()
To:     "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
Cc:     Liviu Dudau <Liviu.Dudau@arm.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        Brian Starkey <Brian.Starkey@arm.com>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "sean@poorly.run" <sean@poorly.run>,
        "Jonathan Chai (Arm Technology China)" <Jonathan.Chai@arm.com>,
        "Julien Yin (Arm Technology China)" <Julien.Yin@arm.com>,
        "Thomas Sun (Arm Technology China)" <thomas.Sun@arm.com>,
        "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>,
        Ayan Halder <Ayan.Halder@arm.com>,
        "Tiannan Zhu (Arm Technology China)" <Tiannan.Zhu@arm.com>,
        "Yiqi Kang (Arm Technology China)" <Yiqi.Kang@arm.com>,
        nd <nd@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Ben Davis <Ben.Davis@arm.com>,
        "Oscar Zhang (Arm Technology China)" <Oscar.Zhang@arm.com>,
        "Channing Chen (Arm Technology China)" <Channing.Chen@arm.com>,
        Mihail Atanassov <Mihail.Atanassov@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 11, 2019 at 1:43 AM james qian wang (Arm Technology China)
<james.qian.wang@arm.com> wrote:
>
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

Is this the full 2's complement value? i.e. including the "sign" bit
of the 2's complement representation? I'd kinda assume that m = 32, n
= 0 would just get me the integer portion of this, for example.

> + * @n: number of fractinal bits

fractional

> + *
> + * Convert and clamp S31.32 sign-magnitude to Qm.n 2's complement.
> + */
> +uint64_t drm_color_ctm_s31_32_to_qm_n(uint64_t user_input,
> +                                     uint32_t m, uint32_t n)
> +{
> +       u64 mag = (user_input & ~BIT_ULL(63)) >> (32 - n);
> +       bool negative = !!(user_input & BIT_ULL(63));
> +       s64 val;
> +
> +       /* the range of signed 2s complement is [-2^n+m, 2^n+m - 1] */

This implies that n = 32, m = 0 would actually yield a 33-bit 2's
complement number. Is that what you meant?

> +       val = clamp_val(mag, 0, negative ? BIT(n + m) : BIT(n + m) - 1);

I'm going to play with numpy to convince myself that this is right
(esp with the endpoints), but in the meanwhile, you probably want to
use BIT_ULL in case n + m > 32 (I don't think that's the case with any
current hardware though).

> +
> +       return negative ? 0ll - val : val;

Why not just "negative ? -val : val"?

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
> +                                     uint32_t m, uint32_t n);
>
>  void drm_crtc_enable_color_mgmt(struct drm_crtc *crtc,
>                                 uint degamma_lut_size,
> --
> 2.20.1
>
