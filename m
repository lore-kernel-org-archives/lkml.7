Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01119C2D0C8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 19:39:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C57C3206D8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 19:39:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r/+yaoUA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727505AbfLTTjf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 14:39:35 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41029 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727402AbfLTTjf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 14:39:35 -0500
Received: by mail-wr1-f67.google.com with SMTP id c9so10509618wrw.8
        for <linux-kernel@vger.kernel.org>; Fri, 20 Dec 2019 11:39:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hg66hkKf1/l6gSi7Ru8j+0F4eQ0bALANcCRIs1Swg2o=;
        b=r/+yaoUAVeaMIGg3aNjF1y+tpFeSm1Ds7vqOIVrpyjRCx2u/9/6Ymr9/+P87/OCQRE
         +Nk77dJwyms5xgFPK4+f/eSnyCDgP0Gn4nwxhWVtUTA2C5eZWRLrvcOLyK2uwyWL1Lhf
         M4Ro385jhulqaoz57QOvwJrKtcSRJOT70A3UKDwx1A9xyfn7dxsKbNgBcj6zx851qfOB
         mK+7+An8JhIjPYonOvPOqmCgGa33/PBWjnvlb67MqwshycWxFHM4awVofKI4JJNmuz4j
         q4OpajkPXuZiRIUYtxQ56Y3DRUMsHKaoeB/3sXMzO6dAhyD4U2Vo9Bx1GGfgl3ngWyfF
         21kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hg66hkKf1/l6gSi7Ru8j+0F4eQ0bALANcCRIs1Swg2o=;
        b=QS1NoUPCiKGiKpkKYrIiZT8WQZsuhzvNshxj2ly2BDD54X9nXo2u7O7JwoBUs5SCSh
         /9Pr8xl3FpZ7P6C/sYxydLFj0wh+t7MXfXa0c4W9ABnQRXIl6bHZP9B8TM7OjGcX7yMI
         wRv281gUieWWnA+VxSdHGdEFBJpCyL/DQG6W6SX1Hcz7k8EgSGJHACEEtfMfC9WDlDZW
         RhHz6wJ2KJNivsnVxCfWgsbL7Zt9zvLRxZ4UltuOQLqSrEmO6kR1uPypJCExM6wN2ywo
         VEnuSLQtxdhkIvLNHeKlZlmhsc0UWmt4v8M+fVXze+Kw9bhbkXvSWcicj6VKsCWV/aot
         +BnQ==
X-Gm-Message-State: APjAAAUbtWSLpLsGEDNydU/Z6JxlFPALQqha8oeQUJHyr2ofg87ckOO7
        hCXYTiXFBUVHSriBf46pdaztUJC8994mwY3/POvtvQ==
X-Google-Smtp-Source: APXvYqwDmNTqWZW+leKA59a8gVyfZird0232HELGZmTDZotesfmREMjGXBz0jjcX0ntchFAScxKEm4Gi5Tuy0oass+U=
X-Received: by 2002:a5d:6a0f:: with SMTP id m15mr16913087wru.40.1576870773493;
 Fri, 20 Dec 2019 11:39:33 -0800 (PST)
MIME-Version: 1.0
References: <1576824253-47863-1-git-send-email-mafeng.ma@huawei.com>
In-Reply-To: <1576824253-47863-1-git-send-email-mafeng.ma@huawei.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 20 Dec 2019 14:39:20 -0500
Message-ID: <CADnq5_PBt3LeLPc48C5rP=G9d8TgBNj71XiyXo6kZChr30hyWQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Remove unneeded variable 'ret' in amdgpu_device.c
To:     Ma Feng <mafeng.ma@huawei.com>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Chunming Zhou <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 20, 2019 at 10:10 AM Ma Feng <mafeng.ma@huawei.com> wrote:
>
> Fixes coccicheck warning:
>
> drivers/gpu/drm/amd/amdgpu/amdgpu_device.c:1036:5-8: Unneeded variable: "ret". Return "0" on line 1079
>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Ma Feng <mafeng.ma@huawei.com>

Applied.  thanks!

Alex

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 080ec18..6a4b142 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -1033,8 +1033,6 @@ static void amdgpu_device_check_smu_prv_buffer_size(struct amdgpu_device *adev)
>   */
>  static int amdgpu_device_check_arguments(struct amdgpu_device *adev)
>  {
> -       int ret = 0;
> -
>         if (amdgpu_sched_jobs < 4) {
>                 dev_warn(adev->dev, "sched jobs (%d) must be at least 4\n",
>                          amdgpu_sched_jobs);
> @@ -1076,7 +1074,7 @@ static int amdgpu_device_check_arguments(struct amdgpu_device *adev)
>
>         adev->tmz.enabled = amdgpu_is_tmz(adev);
>
> -       return ret;
> +       return 0;
>  }
>
>  /**
> --
> 2.6.2
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
