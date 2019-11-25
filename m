Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C4A4C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 14:55:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 029E92084D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 14:55:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IP1XcgI3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728378AbfKYOzV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 09:55:21 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:56251 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728071AbfKYOzU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 09:55:20 -0500
Received: by mail-wm1-f66.google.com with SMTP id b11so15743241wmb.5
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2019 06:55:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=17aeOdEACV6GCmSBNGeLhdL7I8VMOLywDStXvLbpbKk=;
        b=IP1XcgI3FysrVnSEq8NB1nv49cr+e9Hb9dyhbhW70lnBxvM/OZgDc7OXAcrdnmF4Pb
         H2gZWJLH2T5+0Tc3UDrIQ3vfI54Ci1QgwXUwGvlYyZEbSdTo5yuIuVUKZi7un7oFA9gv
         92gzSz4kmdpAtptFarF2mq+KGXEVTxauk3Nj9eLW9s/uRnzhIbriu7XqjWZLgCtWPEGX
         CKIF5KUlDC46PrOX93AYhEs6jBSmVrpXf/Syk4n8HRAthBNuq7qAAq4AYiRsPtLMAvg7
         2xMM1JO0iAsLDvC4r6cxagSfMtyYYWZ5Upmccwec+s6MeHzJf+HxW9GFU+cPldLVplE+
         jyDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=17aeOdEACV6GCmSBNGeLhdL7I8VMOLywDStXvLbpbKk=;
        b=ojuVvFEXn/gGW0SP5NdZUQROnTkTUOAZyp/wSw4/fBO+b3CQyaMLNiif9gCN9jM+oE
         aasCaNpANZfoO7QNk3wa89P2qP5kusmMypwnQ42ekaycdLHklA1MkVpm/bQ0QYoCxSZT
         bQvnvLQIBPCGy7e1AaWtm7J5u14DZbWRd41O8D3gjEqDWHilPJKdWJ++i8d3bq/7V8Si
         cRib9CAGShbKUl7mLoN6C3xlBG6nb2yw5HAfA/9uwdzsLlZtXWYOMlwP049Z6nrn1h8x
         s7qwn4fPODgGfblhMkIxy5FhDqk2hoxVCp0qURLhZ3go43EccSHRdylrgjPnLuKrj/E6
         jiWg==
X-Gm-Message-State: APjAAAWwVwnkz8CLPjJ7G/dizzkhwxH2BUmeHBkY6IsyJYYkpS3Le439
        AABMgLl7bENHPHmW5o/BJjtiFBLte8p6rlUIU6Y=
X-Google-Smtp-Source: APXvYqyJqzPNBd01KuJnFGkGbR9BT5A13oFsJBoVd9HZiHyyG7q0VSD1WrYZcsuWBBJork2bw1Gm9MyvPiwdDVL8C2A=
X-Received: by 2002:a7b:cb89:: with SMTP id m9mr29337295wmi.141.1574693718199;
 Mon, 25 Nov 2019 06:55:18 -0800 (PST)
MIME-Version: 1.0
References: <20191123192336.11678-1-natechancellor@gmail.com>
In-Reply-To: <20191123192336.11678-1-natechancellor@gmail.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 25 Nov 2019 09:55:06 -0500
Message-ID: <CADnq5_OGD5q44nEhHp2+RU3syhO9cUhqfnH34BRJhJrC-b+rLw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Ensure ret is always initialized when using SOC15_WAIT_ON_RREG
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Leo Liu <leo.liu@amd.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 25, 2019 at 3:07 AM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> Commit b0f3cd3191cd ("drm/amdgpu: remove unnecessary JPEG2.0 code from
> VCN2.0") introduced a new clang warning in the vcn_v2_0_stop function:
>
> ../drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c:1082:2: warning: variable 'r'
> is used uninitialized whenever 'while' loop exits because its condition
> is false [-Wsometimes-uninitialized]
>         SOC15_WAIT_ON_RREG(VCN, 0, mmUVD_STATUS, UVD_STATUS__IDLE, 0x7, r);
>         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ../drivers/gpu/drm/amd/amdgpu/../amdgpu/soc15_common.h:55:10: note:
> expanded from macro 'SOC15_WAIT_ON_RREG'
>                 while ((tmp_ & (mask)) != (expected_value)) {   \
>                        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ../drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c:1083:6: note: uninitialized use
> occurs here
>         if (r)
>             ^
> ../drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c:1082:2: note: remove the
> condition if it is always true
>         SOC15_WAIT_ON_RREG(VCN, 0, mmUVD_STATUS, UVD_STATUS__IDLE, 0x7, r);
>         ^
> ../drivers/gpu/drm/amd/amdgpu/../amdgpu/soc15_common.h:55:10: note:
> expanded from macro 'SOC15_WAIT_ON_RREG'
>                 while ((tmp_ & (mask)) != (expected_value)) {   \
>                        ^
> ../drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c:1072:7: note: initialize the
> variable 'r' to silence this warning
>         int r;
>              ^
>               = 0
> 1 warning generated.
>
> To prevent warnings like this from happening in the future, make the
> SOC15_WAIT_ON_RREG macro initialize its ret variable before the while
> loop that can time out. This macro's return value is always checked so
> it should set ret in both the success and fail path.
>
> Link: https://github.com/ClangBuiltLinux/linux/issues/776
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>

Applied.  Thanks!

Alex

> ---
>  drivers/gpu/drm/amd/amdgpu/soc15_common.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc15_common.h b/drivers/gpu/drm/amd/amdgpu/soc15_common.h
> index 839f186e1182..19e870c79896 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc15_common.h
> +++ b/drivers/gpu/drm/amd/amdgpu/soc15_common.h
> @@ -52,6 +52,7 @@
>                 uint32_t old_ = 0;      \
>                 uint32_t tmp_ = RREG32(adev->reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + reg); \
>                 uint32_t loop = adev->usec_timeout;             \
> +               ret = 0;                                        \
>                 while ((tmp_ & (mask)) != (expected_value)) {   \
>                         if (old_ != tmp_) {                     \
>                                 loop = adev->usec_timeout;      \
> --
> 2.24.0
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
