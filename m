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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AD90C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 18:53:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4DB720679
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 18:53:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gtMEStmA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387703AbfHASxn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 14:53:43 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:33634 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731721AbfHASxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 14:53:41 -0400
Received: by mail-wm1-f66.google.com with SMTP id h19so4300452wme.0;
        Thu, 01 Aug 2019 11:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hpA12FK0W1igWSv43IQyfHUTzmV9ZaN2qt5GlMGeIqQ=;
        b=gtMEStmAFd31BMXpGF4zhD+ld7F8xGcjaP+pHwnSRp0BTfpM66hPkcTHcfrGK5+ilb
         guxlrrTS/h9fM0PEzKclnfMfzVmMap7CnI1/2O748Q8+IdZXgg4gEvow2mv6KSb7CGUz
         amwlkNos23xZzdmDGZ320LBlAdq3tKHIQJYxQIc7AWd4/E7Dgl4ZUzfICe6mznxsULma
         64bFDnyvhmwbgTs+OXW6540nPzO+AS12dyAtFDvZYsJbONlUlttwzucH96ZjQ82pftbp
         qV7vaKOKnCWX8Tb0wYv6m8g4pDYbfHYMtlci02cuTU/u1iF1eRvLgiPZWGxwhuQp35pZ
         h00Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hpA12FK0W1igWSv43IQyfHUTzmV9ZaN2qt5GlMGeIqQ=;
        b=dQ1BNrQjdnKD0bVELqf5cPXDKQNUZm6qIT4ROADYBam9Y1x7SUsIg4JzFoupKF/lRP
         1dCTsaghZGOxNwgZoOs24eYxVIPT6l8Jpd17cL2mE2cMLSQmOnWBSy0p3x/GfrJN3kTj
         BR636ArZvNhsixAsdq4bPp8hVUjUrB/XcWA9qxlZ+2C9N81hAHOaCbaIAdj4X2lF3wFM
         P0Yd+h15DbWu5iCfZhKTVkgd8WkE1Z9cT+PBs0x8LIJscZClsPQRZDU/FFOdQI9r6A/W
         utY09gjg8pRCl33/MtCdDhxZDDrd/AaRmIiKI6K5XwMfPBT7cwaJBtBOPw4IHNcck8Xo
         bYKA==
X-Gm-Message-State: APjAAAUmHqX+96dw+gyHil4Lme8jdKzo+DFt6VLGH8d6mIq1dUW9NqfT
        YfmM4tGTtD+Z07h15GH0yMEKqRYkkDsTqE72lQI=
X-Google-Smtp-Source: APXvYqwxMAW3EGWSfiHH8NVLzKrNiRVg+4h4WutnKjYpl4NniuItwAt2RcjlWjdKHCF+eI1la04rb0LeZj2R+mji6pA=
X-Received: by 2002:a1c:a1c5:: with SMTP id k188mr168497wme.102.1564685619961;
 Thu, 01 Aug 2019 11:53:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190801111541.13627-1-colin.king@canonical.com>
In-Reply-To: <20190801111541.13627-1-colin.king@canonical.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 1 Aug 2019 14:53:28 -0400
Message-ID: <CADnq5_OqLtvBWXJhT9c=kxK3HeXSEDdfYS1N7Dh68kbiiLk5+w@mail.gmail.com>
Subject: Re: [PATCH][drm-next] drm/amd/powerplay: fix off-by-one upper bounds
 limit checks
To:     Colin King <colin.king@canonical.com>
Cc:     Kevin Wang <kevin1.wang@amd.com>, Rex Zhu <rex.zhu@amd.com>,
        Evan Quan <evan.quan@amd.com>,
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

On Thu, Aug 1, 2019 at 7:15 AM Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> There are two occurrances of off-by-one upper bound checking of indexes
> causing potential out-of-bounds array reads. Fix these.
>
> Addresses-Coverity: ("Out-of-bounds read")
> Fixes: cb33363d0e85 ("drm/amd/powerplay: add smu feature name support")
> Fixes: 6b294793e384 ("drm/amd/powerplay: add smu message name support")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied.  thanks!

Alex

> ---
>  drivers/gpu/drm/amd/powerplay/amdgpu_smu.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> index d029a99e600e..b64113740eb5 100644
> --- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> @@ -38,7 +38,7 @@ static const char* __smu_message_names[] = {
>
>  const char *smu_get_message_name(struct smu_context *smu, enum smu_message_type type)
>  {
> -       if (type < 0 || type > SMU_MSG_MAX_COUNT)
> +       if (type < 0 || type >= SMU_MSG_MAX_COUNT)
>                 return "unknown smu message";
>         return __smu_message_names[type];
>  }
> @@ -51,7 +51,7 @@ static const char* __smu_feature_names[] = {
>
>  const char *smu_get_feature_name(struct smu_context *smu, enum smu_feature_mask feature)
>  {
> -       if (feature < 0 || feature > SMU_FEATURE_COUNT)
> +       if (feature < 0 || feature >= SMU_FEATURE_COUNT)
>                 return "unknown smu feature";
>         return __smu_feature_names[feature];
>  }
> --
> 2.20.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
