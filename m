Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D7E6C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 14:21:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C2DC214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 14:21:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WkBZ2Plh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729749AbfH0OVr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 10:21:47 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33212 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbfH0OVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 10:21:46 -0400
Received: by mail-wr1-f68.google.com with SMTP id u16so19025428wrr.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 07:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=laSqQOEfNf/YQtcJcPPue42MPQnRnjYdgG2VQPRK7+8=;
        b=WkBZ2PlhNsa6QltAX6IOshMzf5VkyMslx0xpriGkja65CTnGo1GYsiUGlRk4Jm4t3t
         qlJabfeVrActxMaw8VS/eTrl3K5GCUzrbm4r1Zv9Vn2RWTF5RFDmVstO9F6JN5EQkX0F
         HPf4OHWHRszay3KrIhNPW/ggo+BiHXfUst6jI83m6wTttNa/d+eqg+QQfQ0vjZ/1T6rW
         gSBy0zMXMPC/AuFy4Ti/1jth0cUGCe/GpOehDtlQmgGTl7gAOfVkP9gZvQsKaWrj2pFy
         UzedFFyv28V5+FUv9NcVZa9pIVEsVCHt/c3Z0I/fsTq6nnlgYYef/jUL06eKtG5bN0RB
         9oGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=laSqQOEfNf/YQtcJcPPue42MPQnRnjYdgG2VQPRK7+8=;
        b=dsvXWHukGaFS+aRSUguKk7Ukjn1o9+XDFDRGgnk/yg81BfHglsepsxbs7/VSZ3JglO
         k1f2I7LMpiayb0BaJKBF8LGIit7Nl9zHjxc3n9yA4S/ksOnowTdgY+etTs5lrgC0GmsG
         zXkOumSkA0Esnos2wr4If7iI0xczymYGEg4+1CfzHMRZEToQHL2nXMIZ/dUli/W/HyGo
         ffxe+MNGMAHVO2mxr6ZxHmHS1Gzo5umzuisTbWfS4ycGd3sNhvOSKmricBDO/L8+3MT9
         /KtOzbqT3yT/kvqGcvjgR7ZQVgHwmoMNpSSnkrEe8fRrnHlT4dR3wKf+bm0bQB0NA3rn
         LpgA==
X-Gm-Message-State: APjAAAUjvrFabl5wzlc9rg/um9ARzb0btt9oX0SIG8v09ArR6exz1gVj
        /X22tg09A2F+dOgolkXrojAvMxSmgaIQuML6KFk=
X-Google-Smtp-Source: APXvYqy3mc0LRXLtAIIdQ4SagcpdGnfmIZhZN4wxQ6kytbRGlFF6lnryi6maSOw+lb4KJlUyeGkjR62LZdEwMvyZmTY=
X-Received: by 2002:adf:dfc5:: with SMTP id q5mr31086466wrn.142.1566915704413;
 Tue, 27 Aug 2019 07:21:44 -0700 (PDT)
MIME-Version: 1.0
References: <20190827093332.18096-1-kai.heng.feng@canonical.com>
In-Reply-To: <20190827093332.18096-1-kai.heng.feng@canonical.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 27 Aug 2019 10:21:33 -0400
Message-ID: <CADnq5_N7PMxyVDcaQB_L+jNzb=bbMsCBZbn8GmpYewUh+NDLUA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Add APTX quirk for Dell Latitude 5495
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     "Deucher, Alexander" <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Chunming Zhou <David1.Zhou@amd.com>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 27, 2019 at 9:07 AM Kai-Heng Feng
<kai.heng.feng@canonical.com> wrote:
>
> Needs ATPX rather than _PR3 to really turn off the dGPU. This can save
> ~5W when dGPU is runtime-suspended.
>
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

Applied.  thanks!

Alex

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c
> index 92b11de19581..354c8b6106dc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c
> @@ -575,6 +575,7 @@ static const struct amdgpu_px_quirk amdgpu_px_quirk_list[] = {
>         { 0x1002, 0x6900, 0x1002, 0x0124, AMDGPU_PX_QUIRK_FORCE_ATPX },
>         { 0x1002, 0x6900, 0x1028, 0x0812, AMDGPU_PX_QUIRK_FORCE_ATPX },
>         { 0x1002, 0x6900, 0x1028, 0x0813, AMDGPU_PX_QUIRK_FORCE_ATPX },
> +       { 0x1002, 0x699f, 0x1028, 0x0814, AMDGPU_PX_QUIRK_FORCE_ATPX },
>         { 0x1002, 0x6900, 0x1025, 0x125A, AMDGPU_PX_QUIRK_FORCE_ATPX },
>         { 0x1002, 0x6900, 0x17AA, 0x3806, AMDGPU_PX_QUIRK_FORCE_ATPX },
>         { 0, 0, 0, 0, 0 },
> --
> 2.17.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
