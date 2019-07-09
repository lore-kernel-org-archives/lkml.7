Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4685DC606B0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 04:37:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 191A32166E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 04:37:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gWZoZadS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726027AbfGIEhB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 00:37:01 -0400
Received: from mail-wm1-f45.google.com ([209.85.128.45]:39896 "EHLO
        mail-wm1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725818AbfGIEhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 00:37:01 -0400
Received: by mail-wm1-f45.google.com with SMTP id z23so1635825wma.4
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2019 21:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jqwkwVE59UJqKjWZ2I2XtyhSam/I8a/ABZ3OJDi+mEo=;
        b=gWZoZadSn0lLJKezugAflpCMLI6XKT2WT+Q7/Iu8Twt7uE3LNPDuwOEPSa/4Wbl8E5
         ojZZA9RBw4qaFW/88iF4M1y5QmHk7ulslt7jGj9isY8su6pzD5fZGNIu92/rCGi3+U7T
         HsnntrcGIqp5gHXmJZjcftlf2N99RzuKD+djahAC3rrKs5T0+mFJTVvGTt/LXjVv9SHZ
         vxVinGG3nRhC6+N27GS81cluJLFM4mPFxvzDH/I6UaWdbnmrmnIgkuTL4TiGZR8Qxs3n
         ySlYUo0Ai/LQQdEoLyUu20DlL8IMByQkfyJvy602s2bgxUF2S9aKZtlLg1A3sSUKHx4h
         B5Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jqwkwVE59UJqKjWZ2I2XtyhSam/I8a/ABZ3OJDi+mEo=;
        b=gvAxz1bV0eX6z0nAzj1jTacZbV16Dwl0miv2omnC4sMRj5HcWCHK7UHCiWOMh3tbCt
         3sB0UjUwN5/f4ovslvd6GQ7+HbBhib6pMCMRwphpnDwjZY8UQnRr2DasZwVMb0vxmWJl
         8pCBhyIIqxBPqqE5U9ShztcGZSMBL3sNhd54L3L7pTRiKeQmE6ipE3vKXy88TuzqNSCz
         c+MQvqU/qYPdBmr4S+0kTSWHHbOiX2TgTLEV3NBwlFtbAl0zh2tz8L/Ayc34U9VC45cN
         4Eov9/5q1OqW4qcOI6M5ftxyDFxNFg7LoGJWExPPBwxaKnzpyyr+xydOeyn8tMO04HwF
         UeRw==
X-Gm-Message-State: APjAAAVP+aWa7/mftPYYTVbx6I+qgyMqB3u6h4JTrqbFj3cT7kVQqtcv
        4zpfFXh+s1+7QZIGA2c44EuJE78KR4+1vvM/iPd+ZA==
X-Google-Smtp-Source: APXvYqwV9a7jGg5wBwTO0xIx0p5O8ueVIgCSBnjlU+xk3d7qiuvY0LTAcvdJwaH54ELDXYewDaDN40mczeKUyx9TXbU=
X-Received: by 2002:a7b:c751:: with SMTP id w17mr20589916wmk.127.1562647019628;
 Mon, 08 Jul 2019 21:36:59 -0700 (PDT)
MIME-Version: 1.0
References: <f87f3e2f-4d02-4548-3b9f-c012d811ac6b@molgen.mpg.de>
In-Reply-To: <f87f3e2f-4d02-4548-3b9f-c012d811ac6b@molgen.mpg.de>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 9 Jul 2019 00:36:48 -0400
Message-ID: <CADnq5_PvHZweyud9FaZL2bve5ytqDgNSF0Dg9ux5=n8jHUK4nQ@mail.gmail.com>
Subject: Re: drm/amdgpu: Print out voltage in DM_PPLIB
To:     Paul Menzel <pmenzel+amd-gfx@molgen.mpg.de>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 8, 2019 at 7:50 AM Paul Menzel
<pmenzel+amd-gfx@molgen.mpg.de> wrote:
>
> From: Paul Menzel <pmenzel@molgen.mpg.de>
> Date: Sun, 7 Jul 2019 14:23:08 +0200
>
> As the clock is already logged, also log the voltage.
>
> Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>

Applied.  Thanks.

Alex

> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c
> index 350e7a620d45..7fdf2f53c0ee 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c
> @@ -292,7 +292,7 @@ static void pp_to_dc_clock_levels_with_voltage(
>                         DC_DECODE_PP_CLOCK_TYPE(dc_clk_type));
>
>         for (i = 0; i < clk_level_info->num_levels; i++) {
> -               DRM_INFO("DM_PPLIB:\t %d in kHz\n", pp_clks->data[i].clocks_in_khz);
> +               DRM_INFO("DM_PPLIB:\t %d in kHz, %d in mV\n", pp_clks->data[i].clocks_in_khz,
> +                         pp_clks->data[i].voltage_in_mv);
>                 clk_level_info->data[i].clocks_in_khz = pp_clks->data[i].clocks_in_khz;
>                 clk_level_info->data[i].voltage_in_mv = pp_clks->data[i].voltage_in_mv;
>         }
> --
> 2.22.0
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
