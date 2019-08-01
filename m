Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8C75C19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 19:02:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A93A620838
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 19:02:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rcE8EeiR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388040AbfHATCp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 15:02:45 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:33277 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbfHATCo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 15:02:44 -0400
Received: by mail-wm1-f67.google.com with SMTP id h19so4316242wme.0;
        Thu, 01 Aug 2019 12:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/POvTmTfjL31nxmINd6RtTIgV6KXg8CsQfIX6UeNUIA=;
        b=rcE8EeiR8tECv5Jp3ADVBJoLuCzbgP+eanvLuzFYhYz/P2uJlPRPIa2JcgjPl6ntA6
         bzpgX3XyrX+Ttzr3kI0thbxr3oAktPgjIXJC/QtgbYuFjIXUb60WzYTqpgb8z5eZ8qcr
         +mJUwXGEtw0OA9ERd2nfA5Q+qS+Cf8kbRnvD8sEJyXcR4hbcp7C+pdatinbgVFIvtPE7
         wqNvG7gzcYCTWvQDzmtE07B/sKnGNu1F7y3iJQ9FCqCl417wV9FInMOGQl71BwXNwwBS
         rgx+m2BLJ41o9aXZUMV3D5zr6ZjKa1hF1VqFal2ytUDDZ959/NSb/bfxC4KM2bv/Z5Hj
         7+cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/POvTmTfjL31nxmINd6RtTIgV6KXg8CsQfIX6UeNUIA=;
        b=ebLji+SWykoFCGc1o2lbldqyZXuk7c7ZGnmRvkGiy8vv8x+AoCZ65mtxiXizCM5a1n
         7wU+5VqFepGjeSTgQUofmAA5VLGsm4vRlnM2IoqkehyI2yRxFGy/at8oriIXNY3rnKbV
         vy2xlcaGKrMp4PepXW0vhwea0ExxEbz+ukUJjvY314A+YKhMmvRyVce/Sl81SmCIddnS
         IesK+yRqseTMoDyGguyNGVDhHyeoFQSTmwMZxh00ufEBjYpsMnu7NCpYMfgN2iRZFgmV
         NiXr77jTyQRTa9q/SqklqyTalrzMlwMTLT2t/i2KMJmcJczTT20b16n1qeWdYTuBBjnY
         +Fig==
X-Gm-Message-State: APjAAAU0qCevRfa0SFBb3jwhwgbBKT5kSXLaP0jwzbCVyqo0MUbaWkXo
        rHKw0LE5pWZbOm99xJHi0q9gRQ4rn27h3XDhs58=
X-Google-Smtp-Source: APXvYqxd7txH/0Xqawtlq4/3946FsQXXqi/tgTt2bmCLEn79m8eixcweHvGESH1mFACooCrMoEojNCTRqwePPhfPcIE=
X-Received: by 2002:a7b:c751:: with SMTP id w17mr175934wmk.127.1564686161830;
 Thu, 01 Aug 2019 12:02:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190801083941.4230-1-colin.king@canonical.com>
In-Reply-To: <20190801083941.4230-1-colin.king@canonical.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 1 Aug 2019 15:02:30 -0400
Message-ID: <CADnq5_OdBM83zkkgtjwzQ0jqsiDP5wZoMXioGcq4mycX2=Tavw@mail.gmail.com>
Subject: Re: [PATCH][drm-next] drm/amd/powerplay: fix a few spelling mistakes
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

Applied.  thanks!

Alex

On Thu, Aug 1, 2019 at 4:39 AM Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> There are a few spelling mistakes "unknow" -> "unknown" and
> "enabeld" -> "enabled". Fix these.
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/gpu/drm/amd/powerplay/amdgpu_smu.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> index 13b2c8a60232..d029a99e600e 100644
> --- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> @@ -39,7 +39,7 @@ static const char* __smu_message_names[] = {
>  const char *smu_get_message_name(struct smu_context *smu, enum smu_message_type type)
>  {
>         if (type < 0 || type > SMU_MSG_MAX_COUNT)
> -               return "unknow smu message";
> +               return "unknown smu message";
>         return __smu_message_names[type];
>  }
>
> @@ -52,7 +52,7 @@ static const char* __smu_feature_names[] = {
>  const char *smu_get_feature_name(struct smu_context *smu, enum smu_feature_mask feature)
>  {
>         if (feature < 0 || feature > SMU_FEATURE_COUNT)
> -               return "unknow smu feature";
> +               return "unknown smu feature";
>         return __smu_feature_names[feature];
>  }
>
> @@ -79,7 +79,7 @@ size_t smu_sys_get_pp_feature_mask(struct smu_context *smu, char *buf)
>                                count++,
>                                smu_get_feature_name(smu, i),
>                                feature_index,
> -                              !!smu_feature_is_enabled(smu, i) ? "enabeld" : "disabled");
> +                              !!smu_feature_is_enabled(smu, i) ? "enabled" : "disabled");
>         }
>
>  failed:
> --
> 2.20.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
