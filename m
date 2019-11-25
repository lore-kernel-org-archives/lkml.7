Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13BF7C432C3
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 14:39:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7A8420679
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 14:39:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VVrUFOsJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728228AbfKYOji (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 09:39:38 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45467 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728071AbfKYOjf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 09:39:35 -0500
Received: by mail-wr1-f65.google.com with SMTP id z10so18269157wrs.12;
        Mon, 25 Nov 2019 06:39:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ecueCuKSr37n+vkm31GM7A+71gfejKdjoOMSUhMBo2o=;
        b=VVrUFOsJGQExRW2rDxIPa6RJmJnRc7IGGJkgd4Ak9GySSwa9AdmDhwCCuTYARJKBcT
         e0zltgd1kPZbnQTSye+EphEnJf2yE6gIXhsm5h9IQ99Hx1qLzOadICfMyHwV1/3MK4Oq
         uWDjDBnrLW6KwgVlhdKnTtpkIfjNI3pJuLOh16qWQ7YH3irQQf3Vo6xbXQwJHlVz+QkH
         meJFoGpfhu07JRlCX7zcMCcgJ3fa9JZPNHbxHPdKPP2XzFx4M/JYawF8QmQXG8OBdJKW
         Vzv/kK4zxK0wDkO5nsIvoC2oH2hJwClBj4fKkhKIT+ErrUc3kNQ5dHi1C5bJqzW2EuD9
         Uc2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ecueCuKSr37n+vkm31GM7A+71gfejKdjoOMSUhMBo2o=;
        b=hYP7Ecx50UhzI80kaapjz/m/S3WL559IXj7pE21MizcIgxvQumZwKZuxmLYsdXFRqX
         lcEEAo4ELcAxRSwyBBkWWmCVZKQ/83bTOAqfyHraKYRHZt/fTW7/r3LxlPUAKb44TTno
         pJyq86WHylprwjuamYiXMNrjs05Kti/y96iQ2s5yHXFH0AClqgUnUNxgB8OmeXqHRsWy
         hLJcBjX7r1ngS7hfRW5MBjwt2YlDrFz+wChEaaYUL8l1rwH0O81wgYBTqD4tH/dMdk3S
         imDRSkyvwjrZBW99bDUBH64q/WanlW4m5UTe971NrC9jEoJA0B47eDWLtOpNFW23HPOQ
         K2Ug==
X-Gm-Message-State: APjAAAXuaQ9QjWJAM+hnGBst5F1kIk9Q8Ua482XppBrKMegnGU9ugwRJ
        gDM7IoYikDTo8T/xeuf+J3FZhz/0oHsV0XV444I=
X-Google-Smtp-Source: APXvYqyjTXu9vQHknVXc4ju7K1dNWI7kc+GqpCB40hEyro6dQNA7puIeMT9WyIgbJMLN5Wo8ImF120mcCzV/rPW+ujc=
X-Received: by 2002:adf:f54c:: with SMTP id j12mr13947842wrp.40.1574692773362;
 Mon, 25 Nov 2019 06:39:33 -0800 (PST)
MIME-Version: 1.0
References: <20191122230407.109636-1-colin.king@canonical.com>
In-Reply-To: <20191122230407.109636-1-colin.king@canonical.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 25 Nov 2019 09:39:21 -0500
Message-ID: <CADnq5_PN99cigjruAv38y2KHHdrNY2VAqKhD_K3yUoO01Q4b_w@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/powerplay: remove redundant assignment to
 variables HiSidd and LoSidd
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

On Fri, Nov 22, 2019 at 6:04 PM Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> The variables HiSidd and LoSidd are being initialized with values that
> are never read and are being updated a little later with a new value.
> The initialization is redundant and can be removed.
>
> Addresses-Coverity: ("Unused value")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied.  Thanks!

Alex

> ---
>  drivers/gpu/drm/amd/powerplay/smumgr/ci_smumgr.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/ci_smumgr.c b/drivers/gpu/drm/amd/powerplay/smumgr/ci_smumgr.c
> index 15590fd86ef4..868e2d5f6e62 100644
> --- a/drivers/gpu/drm/amd/powerplay/smumgr/ci_smumgr.c
> +++ b/drivers/gpu/drm/amd/powerplay/smumgr/ci_smumgr.c
> @@ -653,8 +653,8 @@ static int ci_min_max_v_gnbl_pm_lid_from_bapm_vddc(struct pp_hwmgr *hwmgr)
>  static int ci_populate_bapm_vddc_base_leakage_sidd(struct pp_hwmgr *hwmgr)
>  {
>         struct ci_smumgr *smu_data = (struct ci_smumgr *)(hwmgr->smu_backend);
> -       uint16_t HiSidd = smu_data->power_tune_table.BapmVddCBaseLeakageHiSidd;
> -       uint16_t LoSidd = smu_data->power_tune_table.BapmVddCBaseLeakageLoSidd;
> +       uint16_t HiSidd;
> +       uint16_t LoSidd;
>         struct phm_cac_tdp_table *cac_table = hwmgr->dyn_state.cac_dtp_table;
>
>         HiSidd = (uint16_t)(cac_table->usHighCACLeakage / 100 * 256);
> --
> 2.24.0
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
