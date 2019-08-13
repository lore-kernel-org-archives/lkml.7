Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E41C6C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 13:58:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B13C8206C2
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 13:58:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="siHyO+zp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729400AbfHMN6s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 09:58:48 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:32788 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727427AbfHMN6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 09:58:46 -0400
Received: by mail-wr1-f67.google.com with SMTP id n9so107968792wru.0;
        Tue, 13 Aug 2019 06:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zfy6948lUCOH92chkbvQy5u5Vo5igoZFuLdDnErvh/A=;
        b=siHyO+zpdjCbmYJUB8AsKVn3x5BCxwl2tdS+wgEd51z0mxogY/e7MqaZp7UtV2u/LY
         Jo+scdY/Tuv1p39KbQOMUa++vBzRJk3ULd7ruis7M4CX1KZjBX6pDtErNC3BCJlMwiU6
         wQ8T4006wJaBMfzGp1Xqg7BXzepb1zjn6q0SkD8Pmhw6t0Gdvw2gXduZ4slbwPlmWbW3
         pOSMee4YOfv97mCHzkZLoIWy6XTmVbcpvu991oOjSQju5vrZjp3h2aDRxm8y3jbNsKt6
         DeNxCbdboaTkvOyclEtebepz+KTExLHBv7Q2OBlbln72g/JSlDf+OWJDa+j7ZHbikQwu
         t40w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zfy6948lUCOH92chkbvQy5u5Vo5igoZFuLdDnErvh/A=;
        b=Qutms+zIMWRVuHPrMiFZBBH0Bvh2Vew7hdZmfKHJs1GFn5uCFanegyF5HlnGpW8vmi
         Qb0+HrUGwIhnuz4zsDHPl5ajNXjKGgX+gNwKt3rE+/V9YHXvJRgy/DeTM1bZgTX0mKDY
         HZMVCQb4u5UZtOK02leQ45HArcOSXy3DyXvkYNppeIbZMU5MyXBuCqQxsX28W6BvYUGz
         616mI4kkcO2no7CDi/AmSn3H2fbgdGJ2e/FgKCef5jLbjbEmGiYH/LO7GjDJr0FMag7s
         44uLWtcyjBBnhQrSznd7RSN1TNaQ3hh7mQHrwCjUcgP7wMv8dw87hRH52RRVQLjTEMpU
         9JSg==
X-Gm-Message-State: APjAAAWGAggU55QVz8ts00bqjjxQ7mloWCOvUe3ACu9sRqydQAeqnPbk
        UX8eDa6fvu8Sya53Y74pI/xpvU6p+KDwFUZDn+A=
X-Google-Smtp-Source: APXvYqxxFFU/uYf0Bs2fkypX/f2q7giWV1wCz2O0fpuwjUUfiCJon9Ab+ZGb6Su5aKytZMAno3nfTqkgLxpw3afkFuc=
X-Received: by 2002:adf:f94a:: with SMTP id q10mr43676562wrr.341.1565704723878;
 Tue, 13 Aug 2019 06:58:43 -0700 (PDT)
MIME-Version: 1.0
References: <20190813103340.11051-1-colin.king@canonical.com>
In-Reply-To: <20190813103340.11051-1-colin.king@canonical.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 13 Aug 2019 09:58:31 -0400
Message-ID: <CADnq5_MihuON5NRn7gbjbD9br37=vL+ZtjNqqFE2XQGrA_P7Zw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/powerplay: fix spelling mistake "unsuported"
 -> "unsupported"
To:     Colin King <colin.king@canonical.com>
Cc:     Rex Zhu <rex.zhu@amd.com>, Evan Quan <evan.quan@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        David Zhou <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>, kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

Alex

On Tue, Aug 13, 2019 at 6:33 AM Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> There is a spelling mistake in a pr_err error message. Fix it. Also
> add a space after a comma to clean up a checkpatch warning.
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/gpu/drm/amd/powerplay/smu_v11_0.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
> index 8bbcf034799c..d324bd28934d 100644
> --- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
> +++ b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
> @@ -288,7 +288,7 @@ static int smu_v11_0_check_fw_version(struct smu_context *smu)
>                 smu->smc_if_version = SMU11_DRIVER_IF_VERSION_NV14;
>                 break;
>         default:
> -               pr_err("smu unsuported asic type:%d.\n",smu->adev->asic_type);
> +               pr_err("smu unsupported asic type:%d.\n", smu->adev->asic_type);
>                 smu->smc_if_version = SMU11_DRIVER_IF_VERSION_INV;
>                 break;
>         }
> --
> 2.20.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
