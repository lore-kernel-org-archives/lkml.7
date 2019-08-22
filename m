Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEB20C3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 20:51:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 960DB2341E
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 20:51:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ca5Ppa+M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392208AbfHVUvk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 16:51:40 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33356 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388241AbfHVUvk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 16:51:40 -0400
Received: by mail-wr1-f68.google.com with SMTP id u16so6680237wrr.0;
        Thu, 22 Aug 2019 13:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ypNP1kJ2eEs/EAi1HZN+8+beflxZCGBjmUyy7v7X9eU=;
        b=ca5Ppa+MCF+DQvu+mF0mpSgCn71cKIzPoQZ5XK9eLTa9ftfSOoVXJ4IRJ1y2KXDmSi
         W37s+l8yo6mHXHNeyfFeDe6oEiTziOsHIn3Fmp/JUPf0nmIrAww7zGz2dHfFl/0EX3np
         AuAg6RRJF8jYaa/u5FxmEEm+PjLZZ1uZKZSpufY+8sBx4Kq8PPyi41cLrghGbvHX/BHY
         aSlzKPde/+kFRKNpM+qU4jiVTNoOEqvltua+C5XQ2CqRC/qpW85AvtRz9jH7bNDgeLZP
         OxncTcVaUh5dvOeBGgQI+CS3hvHcekZtYze60cOI1TqgTsaoZRVgpuVJ6scw316FSqn+
         GEdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ypNP1kJ2eEs/EAi1HZN+8+beflxZCGBjmUyy7v7X9eU=;
        b=XHGOmaz/Ms7zS23u14POo/co6qnwXnVKhX98wuYoBVULiejeNWycZT69DkohoTur7z
         zYpd61rhdHlQ1S9C+T4kOH2c+HLyZGiF9YVpJXd0n3bqI7pcSarXZiYhviOnTGv9QGA9
         uZJQiyAY1JeT3JWNRPARJmiy/yDR8BpD0an4SRLwZWmWepmKPlsx+mYSoDao1iEozHLV
         eYFk7LPQkVmsGC723vvEqQeJyUzxrBN2zJZeygqj8zqaIakA8GiSnKU3c7I2wWxjjRWZ
         G6cxkz0xb0G4kovsut/MkeopE34iNvH7l3/wZaoAxU79meZWRhlm5lbL2IGZ/Z8lqaxx
         msSw==
X-Gm-Message-State: APjAAAXoZootLu+XGtv+honTyI1mnaFqpnA9YvpsvtrqFdS7ihcyIlhB
        vYGL17J0Aik6VUSUfbG+kOeIestLh/VPGJFlovdf0IXJ
X-Google-Smtp-Source: APXvYqwLkyCSFex31CA1uzOruakJcFqOEcFr8tq/u+g1hcxkFaEl4VVU+6teCA/XPl3+hxCo8Rhhmx/xfcNfVAFXFR4=
X-Received: by 2002:a5d:6ccd:: with SMTP id c13mr1006134wrc.4.1566507098156;
 Thu, 22 Aug 2019 13:51:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190822130948.32195-1-colin.king@canonical.com>
In-Reply-To: <20190822130948.32195-1-colin.king@canonical.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 22 Aug 2019 16:51:25 -0400
Message-ID: <CADnq5_O=V0_MNenTdxFsprmrGQiwMQNDFFkzYH-ZWw11VaMYmA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/powerplay: remove redundant assignment to
 variable baco_state
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

On Thu, Aug 22, 2019 at 9:09 AM Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> Variable baco_state is initialized to a value that is never read and it is
> re-assigned later. The initialization is redundant and can be removed.
>
> Addresses-Coverity: ("Unused Value")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied.  Thanks!

Alex

> ---
>  drivers/gpu/drm/amd/powerplay/smu_v11_0.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
> index 89749b1d2019..a4aba8576900 100644
> --- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
> +++ b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
> @@ -1656,7 +1656,7 @@ static bool smu_v11_0_baco_is_support(struct smu_context *smu)
>  static enum smu_baco_state smu_v11_0_baco_get_state(struct smu_context *smu)
>  {
>         struct smu_baco_context *smu_baco = &smu->smu_baco;
> -       enum smu_baco_state baco_state = SMU_BACO_STATE_EXIT;
> +       enum smu_baco_state baco_state;
>
>         mutex_lock(&smu_baco->mutex);
>         baco_state = smu_baco->state;
> --
> 2.20.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
