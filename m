Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C00F6C43331
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 15:24:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 975922245B
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 15:24:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c/X7BxOj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728001AbfKMPYV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 10:24:21 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37765 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726812AbfKMPYV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 10:24:21 -0500
Received: by mail-wm1-f66.google.com with SMTP id b17so2466354wmj.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2019 07:24:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EZIr8n1tU+j0xhtRpbzRhBLFBsZMuPY7L0CnRVcZR4k=;
        b=c/X7BxOj/QjILROu0J4DmJluqRkTUtYoR0f7eEpN/8Yq7Vyg64Xb8zYRvXYHRBDTfI
         Qahh/XnS36s2Q3+nuvxj8n0hh4V+DEQq3MlaejW5Yv/uRPSEPqtWTG9ZTc9Jz3hzIakk
         HnZjZUGnvxb08VG5g26S5ivktTIFPJ9FWZrCnuYgITCkeu5uPgsIx/6FCy5+qGyhhQ/2
         pqxmX75YScunIZ3uUo6Krl8P/I23/PJ4eDzVVO6Zuh/q9Qty81S2NJ8ubrVbmrsfHgYZ
         2Hsk9KE1rsL1pb/e0qyiNonYkWoI1lx4Lqrsq9Q30l+ASHJBNVaxitEpDqH1lndQKH3Y
         s3uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EZIr8n1tU+j0xhtRpbzRhBLFBsZMuPY7L0CnRVcZR4k=;
        b=pPt5C2smW4uaCB+nVDxwdcMGmQi3g0pEfeqM0331CvSZwl2ztajz6Mz8tWxLzfCNHS
         dQa2WdySUw+gCTKCx1hg+QDrvXQCqTTG6Qjn8jx4mkti7ZbRMxzHFFrMQVy9c8X4UQyX
         HmJNe+3L6g6VrSRZs9v4sRWsR3cf19HFLliF9XNJkBvBdqa1Zb0yzSkV813rcPdp31dK
         IOKU0XxuiC82sylYQnzpunXAQOjGArfH6fx1XZq9I8/T+20vXngMO9E3heL6HZOPCGr9
         ieBbDzkEMalR4oPQ6E2vu3DgSXKQw8vuEMUf/x/wk8xiFfz5Kbc72Qp7nsGhQ523hSAu
         WhOg==
X-Gm-Message-State: APjAAAWC0u4YCMRxPDqEH6eR/GyL5I+L2viuRUJGFMW5S6y7zOG2+shH
        L6c5OGD1qmCA3yM06ZA5QNF62VRR6KgKaP+TShdtag==
X-Google-Smtp-Source: APXvYqyh/U3wryjoZZSptRRKloXLftAMfY1jR1cvrpoCxOaKPTJf/IYD45uGLGkd1pxrgI+3IHhHsLJO4Mf4t58c4rs=
X-Received: by 2002:a1c:790b:: with SMTP id l11mr3485526wme.127.1573658659004;
 Wed, 13 Nov 2019 07:24:19 -0800 (PST)
MIME-Version: 1.0
References: <1573649074-72589-1-git-send-email-yukuai3@huawei.com>
In-Reply-To: <1573649074-72589-1-git-send-email-yukuai3@huawei.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 13 Nov 2019 10:24:07 -0500
Message-ID: <CADnq5_P38AfOHtRAAYXHVmjPPS9ot4NTGX-dQXgeUiGUjYUCHw@mail.gmail.com>
Subject: Re: [PATCH 0/7] various '-Wunused-but-set-variable' gcc warning fixes
To:     yu kuai <yukuai3@huawei.com>
Cc:     "Deucher, Alexander" <alexander.deucher@amd.com>,
        "Kuehling, Felix" <Felix.Kuehling@amd.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Chunming Zhou <David1.Zhou@amd.com>,
        Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Rex Zhu <Rex.Zhu@amd.com>,
        "Quan, Evan" <evan.quan@amd.com>, yi.zhang@huawei.com,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        zhengbin <zhengbin13@huawei.com>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied the series, although a couple of the patches were already
applied from a previous patch set.

Thanks,

Alex

On Wed, Nov 13, 2019 at 9:12 AM yu kuai <yukuai3@huawei.com> wrote:
>
> This patch set fixes various unrelated gcc '-Wunused-but-set-variable'
> warnings.
>
> yu kuai (7):
>   drm/amdgpu: remove set but not used variable 'mc_shared_chmap' from
>     'gfx_v6_0.c' and 'gfx_v7_0.c'
>   drm/amdgpu: remove set but not used variable 'amdgpu_connector'
>   drm/amdgpu: remove set but not used variable 'count'
>   drm/amdgpu: remove set but not used variable 'invalid'
>   drm/amdgpu: remove set but not used variable 'threshold'
>   drm/amdgpu: remove set but not used variable 'state'
>   drm/amdgpu: remove set but not used variable 'us_mvdd'
>
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c    |  4 ++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_display.c         |  2 --
>  drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c               |  3 +--
>  drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c               |  3 +--
>  drivers/gpu/drm/amd/amdkfd/kfd_device.c             |  4 ++--
>  drivers/gpu/drm/amd/powerplay/smumgr/fiji_smumgr.c  |  7 ++-----
>  drivers/gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c | 12 ------------
>  7 files changed, 8 insertions(+), 27 deletions(-)
>
> --
> 2.7.4
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
