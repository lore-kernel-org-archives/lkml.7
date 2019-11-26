Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94F76C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 16:28:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6763820722
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 16:28:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JieTCFWq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727851AbfKZQ2K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 11:28:10 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36407 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727154AbfKZQ2K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 11:28:10 -0500
Received: by mail-wm1-f68.google.com with SMTP id n188so4075160wme.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2019 08:28:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lpf541/6ikEv3JJ2ul3APwZIfgPQ6unMan8v4La6FD4=;
        b=JieTCFWq0nixSvgtCiL59CJeZu3LC4DI3ozvC6SCMq8yOfpTyvmgTzQNJB+0KAwH82
         FZbWZ0MSaOx8Xwf/PcFSyviWSsAoeAD1S9lbb0qYtC+z0LsSqUobyrgpQBvsYKUKNeJH
         54d3rcSJAhK5M6xcDfm2qQeTrxTEbQ6aZXBu/JVFc6plWpWQ9ActI88B5VDmDI88O2g8
         vzq1ICpaahQOIJ9rTg0v9zl+daqycOPMvOjmbodK1inIBUcGVJyniMp0ftf5N9SVLPji
         eGpys0U4dyYb/gOJCFwIecl920Kn7XlKRr9hhe0yIdtQG6FInOpysmI5/FNkDA31yEYG
         h6+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lpf541/6ikEv3JJ2ul3APwZIfgPQ6unMan8v4La6FD4=;
        b=hRn4jZC4JEHz1bKWB8KXBsCuEBPiuQMHB56L1vmdZKp4C743IKk85oz0QqCfSSUraH
         eDDC7uN8KrSFxdFCRLA3gQW5UmFJ14Pc1d38odseCfX8rJnPJ7uAA70YeXMx+Vu9OBz6
         18JeKb+wiLcDuzWqFjYLZ9CudbqDf2ckHcpuYOO/NJSVGyiDXsWa8T3QaYUt7MM+30Yj
         6a80J3fzr25oJ7yL5eqYjoPHh+aNsf8sen2RN8eBOSQktpS/t86NsPAmND2bLNPCb1Gv
         tHjhLJ56yQOPtxWOPIOjlouLTWsBQlmA486KDsBphNAf/5D/4J57O6eDFV3apB/AdhYb
         pjLw==
X-Gm-Message-State: APjAAAXMkKC1AHLgCsOXurRlZGNoCS4AgHsxLmBWWrWnV2KIusDOdyH0
        fPDvoWPtSjLMILfnTTLURILiSMD/cBlMBBPsQxQ=
X-Google-Smtp-Source: APXvYqwgv1uiWhI8ounqnl7xziQvTMjaQD4iWYsok936xxtQ3YUO0jFuO7HLV9vH7BCmji9L/qv8lpPQJxxXiA+Z+H8=
X-Received: by 2002:a7b:c1d3:: with SMTP id a19mr5326942wmj.127.1574785687879;
 Tue, 26 Nov 2019 08:28:07 -0800 (PST)
MIME-Version: 1.0
References: <20191126003514.133692-1-jbi.octave@gmail.com>
In-Reply-To: <20191126003514.133692-1-jbi.octave@gmail.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 26 Nov 2019 11:27:55 -0500
Message-ID: <CADnq5_Mvx8yNG=PUYB6s+Dwqevbx4a0gC-K7iqmNtM-shrDOLw@mail.gmail.com>
Subject: Re: [PATCH] drm: radeon: replace 0 with NULL
To:     Jules Irenge <jbi.octave@gmail.com>
Cc:     "Deucher, Alexander" <alexander.deucher@amd.com>,
        Dave Airlie <airlied@linux.ie>,
        LKML <linux-kernel@vger.kernel.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Christian Koenig <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  thanks!

Alex

On Tue, Nov 26, 2019 at 3:15 AM Jules Irenge <jbi.octave@gmail.com> wrote:
>
> Replace 0 with NULL to fix sparse tool  warning
>  warning: Using plain integer as NULL pointer
>
> Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
> ---
>  drivers/gpu/drm/radeon/radeon_audio.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/radeon/radeon_audio.c b/drivers/gpu/drm/radeon/radeon_audio.c
> index b9aea5776d3d..2269cfced788 100644
> --- a/drivers/gpu/drm/radeon/radeon_audio.c
> +++ b/drivers/gpu/drm/radeon/radeon_audio.c
> @@ -288,7 +288,7 @@ static void radeon_audio_interface_init(struct radeon_device *rdev)
>         } else {
>                 rdev->audio.funcs = &r600_funcs;
>                 rdev->audio.hdmi_funcs = &r600_hdmi_funcs;
> -               rdev->audio.dp_funcs = 0;
> +               rdev->audio.dp_funcs = NULL;
>         }
>  }
>
> --
> 2.23.0
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
