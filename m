Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7B29C76186
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 18:45:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91D8621841
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 18:45:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KCHVNknd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391558AbfGWSpV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 14:45:21 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46884 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728243AbfGWSpU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 14:45:20 -0400
Received: by mail-wr1-f65.google.com with SMTP id z1so44229528wru.13;
        Tue, 23 Jul 2019 11:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5uJhkLXJdGxLJxdwTXXjbtfErmAZdUMl9oepnhVnpJU=;
        b=KCHVNkndiWJSE0kTr3cYX3OnwDHz9/b3q+v6QwNjzUH61qyGRuSe4P2eo3ZE4NwOrf
         xfqW2OzYPUKqMNRHbt26vA7ZMjGAJMF92jul6OW7k//Mdxxc3utIM/pjDCYohTfRPrdd
         1XPzRDlmA7tEd0sNJavA0Ffo5bNDFi8tv8KI8Xl1iDTt/ukbtRQZLX5Nh6+3b+bIxtV+
         J+9T8sABvI8OXdd/nC3eYbB0h21KU4JPf2Tb5+qzT2rG0lfeDLXYtParESonPFKsHc98
         Lnun+5anztR5gJaS1lQRGUTgP8y6V3SCqfYdFtDdAjAQa1Vv4LkCoU6VqPVn31WlV+Jq
         5kUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5uJhkLXJdGxLJxdwTXXjbtfErmAZdUMl9oepnhVnpJU=;
        b=b/ZvO1VOcFzcmMMge+Fx5WC29xnlfMUnmRzq7gHwn5+yOeFMmc45m4A9isiTWXJLJx
         65pURbzme1fdvN/XxZ9eUh82SrVzQKkwNQG4sBA9e3f2shgSY3Du0BEGaGHUAeYTxRCN
         LzYmdg/9kdh7TIpDu7FuwVKU53W1VKmVpohDOV0WsI83sxRbn1tuj3jVX25ZfZFH64Bs
         o76UrP8UeLDbkX3mPcFzglD6+V6BT8t1GWZnEhK3ThrsWdtJ2wY6jtHxkiSxrpRv8Eu7
         0EeKEBkBMvpbd6GpfQblOPe9d5skYUwJalk2BvXWw8yHFHZ5d+7IOVxA5klgW0YYDGA2
         RKuw==
X-Gm-Message-State: APjAAAVqGoiVzZzol4mt4PSKRM/MMdPdDTLAerWp7blAvpugYDRwHkqq
        lWZP8+MxcwqPmaReR3Lcz4ebHuUKgOBQ8ylzgdw=
X-Google-Smtp-Source: APXvYqyHjjqtHDgklRtxzyV71CQoAnoB9+E/YFBvxbOAhcaWr0Ba2y8dm7WcuR5DTH12Yf9Afxc8MjOei6MHmqudqBk=
X-Received: by 2002:adf:f94a:: with SMTP id q10mr59242784wrr.341.1563907518245;
 Tue, 23 Jul 2019 11:45:18 -0700 (PDT)
MIME-Version: 1.0
References: <20190723134120.28441-1-colin.king@canonical.com>
In-Reply-To: <20190723134120.28441-1-colin.king@canonical.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 23 Jul 2019 14:45:07 -0400
Message-ID: <CADnq5_PE1rDzqd13MPWJmeK_BUS0EthH=WcZ0wruTy55yarnpw@mail.gmail.com>
Subject: Re: [PATCH][next] drm/amdgpu: remove redundant assignment to pointer 'ring'
To:     Colin King <colin.king@canonical.com>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        David Zhou <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Leo Liu <leo.liu@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>, kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 23, 2019 at 9:41 AM Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> The pointer 'ring' is being assigned a value that is never
> read, hence the assignment is redundant and can be removed.
>
> Addresses-Coverity: ("Unused value")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> index 93b3500e522b..a2a8ca942f34 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> @@ -1331,7 +1331,6 @@ static int vcn_v1_0_pause_dpg_mode(struct amdgpu_device *adev,
>                                 WREG32_SOC15(UVD, 0, mmUVD_JRBC_RB_CNTL,
>                                                         UVD_JRBC_RB_CNTL__RB_RPTR_WR_EN_MASK);
>
> -                               ring = &adev->vcn.inst->ring_dec;
>                                 WREG32_SOC15(UVD, 0, mmUVD_RBC_RB_WPTR,
>                                                    RREG32_SOC15(UVD, 0, mmUVD_SCRATCH2) & 0x7FFFFFFF);
>                                 SOC15_WAIT_ON_RREG(UVD, 0, mmUVD_POWER_STATUS,

While we don't use ring here, I think the assignment is useful to
delineate that we are no longer working with the jpeg ring, but rather
the decode ring.  The mmUVD_RBC_RB_WPTR register is part of the decode
ring, not jpeg.  We would normally use the ring->wptr like we do for
the other rings, but in this particular case, the value happens to be
shadowed to a scratch register due to the way the dynamic power gating
works on that ring.

Alex

> --
> 2.20.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
