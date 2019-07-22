Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 127EEC7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 19:12:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE9A421901
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 19:12:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AFf6ArnN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731459AbfGVTM0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 15:12:26 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37400 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726930AbfGVTMY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 15:12:24 -0400
Received: by mail-wr1-f65.google.com with SMTP id n9so15485960wrr.4
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 12:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E5mBJQbASIWLcBRoSyRYLQDBK0lNLjxZqisDqmDkveo=;
        b=AFf6ArnNfbHJsDlo3L0mHVyYTahFZ+Hs+FvkmWx2MNN7P4WvvwCceoQAqnlZa+zHsl
         +1eAKtDu7XB2g+bho+2CuUFZsWyduG7i6PlGMeNReDIResI1pqbajCZr8oDMrjPHZu2j
         /9TCp1bmpurWvgB4YpbhTghzO8JpsXSfJkUH13NI0TPwGGIPLFrDDEQDLBtvrWM5Zf/W
         QWish7yDFa893WoQeCf+aV33tAw3tqiGaWJBW+/UkM5kCqAb2oMzd/k9Ez3rnPJxrh3u
         7BOfYuVlv7L3exMhjN1pqA0/81lKMeGXKlakc/M9cpwDJ0585ljkq12LdNCz4wiZX9ZQ
         lBEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E5mBJQbASIWLcBRoSyRYLQDBK0lNLjxZqisDqmDkveo=;
        b=crhJ8mqIRXOdcH1esB63xESc2kfyNUnJAu80d5OXEgDsfuL4YDKD8r1QNzHacSmubs
         /PN4nme/r94wA1Md5wlX2ytudUltXCdfXjCBGZmcuChLgsc40gHk5kO+EQ/fUZdsxDdT
         qXUQDpTkus+NAV9ZP6mOGMD0kIt8LHKbtdJ9R2h9mLvC9fSMiLUdcbamtSfwZJ80lxN9
         mR+L6lBRXG9y/XfQaUICDT2GQR51+YCtGTSPGPA7F6zZKTurc0gaGA/PSrHPjJ0wpkCS
         WtBGraqxZ3yLeNOdk5qjM+/ff8E1L3LGadgQXWPZYByvW8vbaH4DYpRD22tLQkq5vkcj
         43tw==
X-Gm-Message-State: APjAAAWh6yWMC48cB87arbTQQXDLfAbXNeWa0b6wDEip6KtgjPzfegOz
        1oNbWqnPqQdJQF896/d+sahQy6KhsiSPc7bnu+Q=
X-Google-Smtp-Source: APXvYqzZuDxJEjG1iXUQjcFTW3PQBCK+hlG/4cTZn/bdmQTyxnOBEg1WLZ03tbAGunknQcHYIut1/j3bX5uPQmino88=
X-Received: by 2002:a5d:6ccd:: with SMTP id c13mr72770190wrc.4.1563822742766;
 Mon, 22 Jul 2019 12:12:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190721223949.GA13591@embeddedor>
In-Reply-To: <20190721223949.GA13591@embeddedor>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 22 Jul 2019 15:12:11 -0400
Message-ID: <CADnq5_NZNA3wCq4U4jbOU7BHfYgan5m=R6MbWmJ3Xp1oYMAUog@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/gfx10: Fix missing break in switch statement
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Hawking Zhang <Hawking.Zhang@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Kees Cook <keescook@chromium.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 21, 2019 at 6:39 PM Gustavo A. R. Silva
<gustavo@embeddedor.com> wrote:
>
> Add missing break statement in order to prevent the code from falling
> through to case AMDGPU_IRQ_STATE_ENABLE.
>
> This bug was found thanks to the ongoing efforts to enable
> -Wimplicit-fallthrough.
>
> Fixes: a644d85a5cd4 ("drm/amdgpu: add gfx v10 implementation (v10)")
> Cc: stable@vger.kernel.org
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Applied.  Thanks!

Alex

> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> index 1675d5837c3c..35e8e29139b1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -4611,6 +4611,7 @@ gfx_v10_0_set_gfx_eop_interrupt_state(struct amdgpu_device *adev,
>                 cp_int_cntl = REG_SET_FIELD(cp_int_cntl, CP_INT_CNTL_RING0,
>                                             TIME_STAMP_INT_ENABLE, 0);
>                 WREG32(cp_int_cntl_reg, cp_int_cntl);
> +               break;
>         case AMDGPU_IRQ_STATE_ENABLE:
>                 cp_int_cntl = RREG32(cp_int_cntl_reg);
>                 cp_int_cntl = REG_SET_FIELD(cp_int_cntl, CP_INT_CNTL_RING0,
> --
> 2.22.0
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
