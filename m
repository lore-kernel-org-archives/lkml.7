Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEC5FC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 02:47:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADDB32186A
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 02:47:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qYoc/vau"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730790AbfB1Cri (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 21:47:38 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55732 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730621AbfB1Crh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 21:47:37 -0500
Received: by mail-wm1-f68.google.com with SMTP id q187so7792869wme.5;
        Wed, 27 Feb 2019 18:47:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=piun7cPCDuB9fhc+zbtouycM0pCBqlSH7LI+pTCrrFA=;
        b=qYoc/vauBb0mvg0h2P2uDTLWw1WojP/LlO7d7AEyZMEt37IR/WHnNvcXLLNsMMAPOD
         l8P9ygdHaXrzPu2PrWJnF4bPRrHyQWDHkUMCw5fR1Ahn1n9i85Ueoab1qFLwHfeYlqfk
         SFsUSr9IS7FQ7PbFwnHEy95NZC58GPDhEZ0lIi8HUVFBYIreX8ldJWgDEy7Ot/nNXXP4
         szeLRhdAoSjhSWu5N08LovteeXOF2EWC69kcmGIrvw/C+0vJYz1QHCC0fN7lLrYOEbxr
         CRBZNeX78ftR12b/KE2QQhxIEtw1WcUbzkGq6M0Qq41oyeKw+eGGPp7U9QgjQSAYxt6x
         KCTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=piun7cPCDuB9fhc+zbtouycM0pCBqlSH7LI+pTCrrFA=;
        b=dSqTLxtqRUKJaipH914mlzpypGA+B2mMJvts317SihG1lTLhrKZ3A1TiEi/bc9YArX
         y+4+Ef+BW3FJpiPqjufNPFXMdkuVVTt8D9ksTrmvnnZ2NW+xIa8iCo3EMyr+UsMUa/Tl
         nGxlC9oyxnsB7yw/arTxPMErER2a5vesDjGIYNgOy04vLBiEZANWnMAocbWzOe4G/lr+
         i1ZH7NQcYMPmCIPguNShpRMKFSJQO6/a5o9FVcd0PubPvTzOp2m36++2L8vADS8ecaZt
         WdsVmHooJpxyz/5Vb3VZMvD2KfGoJ8lSKJGYPRrQQcRMClTqkJwtU2YHkUEIA8UpzocW
         cl/Q==
X-Gm-Message-State: AHQUAuY9n5eIL6WCvaoKQOqt4QD/a+rIoV7PJG98nH9RIyHRpqJ1oqm7
        46ZxnX5C6yV2vMc7VQTU7kfESYflcnyfL19IfZk=
X-Google-Smtp-Source: APXvYqwciHcVMwKXOaRDXCKgTJwtRJ/RNrINtDr+wHckAKXRB/Ggk27VO92fjDEW+x6Cpj27+dTLF6318ztJgsXSHic=
X-Received: by 2002:a1c:c205:: with SMTP id s5mr1231874wmf.116.1551322055306;
 Wed, 27 Feb 2019 18:47:35 -0800 (PST)
MIME-Version: 1.0
References: <20190226054828.120809-1-yuehaibing@huawei.com>
In-Reply-To: <20190226054828.120809-1-yuehaibing@huawei.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 27 Feb 2019 21:47:23 -0500
Message-ID: <CADnq5_McbtEZVjyrP+E1ORx8UKMhmPmK2C5rSmcbDCothx0g-w@mail.gmail.com>
Subject: Re: [PATCH -next] drm/amdgpu: remove set but not used variable 'vbi_time_out'
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     "Deucher, Alexander" <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Chunming Zhou <David1.Zhou@amd.com>,
        Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Kees Cook <keescook@chromium.org>, Rex Zhu <Rex.Zhu@amd.com>,
        "Quan, Evan" <evan.quan@amd.com>, Huang Rui <ray.huang@amd.com>,
        kernel-janitors@vger.kernel.org,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  thanks!

On Tue, Feb 26, 2019 at 12:36 AM YueHaibing <yuehaibing@huawei.com> wrote:
>
> Fixes gcc '-Wunused-but-set-variable' warning:
>
> drivers/gpu/drm/amd/amdgpu/si_dpm.c: In function 'si_program_response_times':
> drivers/gpu/drm/amd/amdgpu/si_dpm.c:4101:29: warning:
>  variable 'backbias_response_time' set but not used [-Wunused-but-set-variable]
>
> It's never used since introduction in 841686df9f7d ("drm/amdgpu: add SI DPM
> support (v4)"), so can be removed
>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/si_dpm.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/si_dpm.c b/drivers/gpu/drm/amd/amdgpu/si_dpm.c
> index 41e01a7f57a4..d57e75e5c71f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/si_dpm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/si_dpm.c
> @@ -4098,14 +4098,13 @@ static int si_notify_smc_display_change(struct amdgpu_device *adev,
>
>  static void si_program_response_times(struct amdgpu_device *adev)
>  {
> -       u32 voltage_response_time, backbias_response_time, acpi_delay_time, vbi_time_out;
> +       u32 voltage_response_time, acpi_delay_time, vbi_time_out;
>         u32 vddc_dly, acpi_dly, vbi_dly;
>         u32 reference_clock;
>
>         si_write_smc_soft_register(adev, SI_SMC_SOFT_REGISTER_mvdd_chg_time, 1);
>
>         voltage_response_time = (u32)adev->pm.dpm.voltage_response_time;
> -       backbias_response_time = (u32)adev->pm.dpm.backbias_response_time;
>
>         if (voltage_response_time == 0)
>                 voltage_response_time = 1000;
>
>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
