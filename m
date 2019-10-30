Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4E82CA9EC5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 19:09:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA10D204FD
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 19:09:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fIzW0cTv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbfJ3TJD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 15:09:03 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39287 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726325AbfJ3TJD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 15:09:03 -0400
Received: by mail-wm1-f68.google.com with SMTP id g19so3392898wmh.4
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2019 12:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uYBiTBzZt5vgvU2mRqgnC6ae48T65098RS0JVybZs/s=;
        b=fIzW0cTv0OFE3KRoEXVVCnS4mqtonyrpX0B+jtwNkLE6FwBeqvYhUZza2h9TZ9bYqm
         tApeumreXyquaAVj0spMTUCUbbtC4adInjw6t3uIkwEy5cqYX22vfmqdMH5yM5Xp/8d/
         UN0NjxNlKlITH3a6GMCP3oXtwqarO6elrP9kKtPrpXeVZcC3LeWo4/S+H8Wq9JXma9HF
         eRroFUJslrY+g0nEQuqEUoqwOX0GgYENRZ4AI/rMx+9JOgFhFhltl2uVHKnLKwK9xco4
         ZrHscJ5STKJmh4Ye7L/bVFv/u86tKFWYogN64nCMgAX2jw9iz0UAun6i6wcHuwyGcQ7F
         G7gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uYBiTBzZt5vgvU2mRqgnC6ae48T65098RS0JVybZs/s=;
        b=WQAEVtJZ3dVekOZdrubmP0tVxz7IXjbcemBaZvo7FEvTeKUxYFwVHpXPfjwzwkdD7G
         YuH849S4A6AIVpK55D/4YTNZXyYhRfHIvkfK9rT+hGulgKkJ0QvEV3nIY4/cAe4pMfwJ
         6TmsWpGWCGM5cLxp5HMG332kX97TWN21zOnzlyXb6iVLEDEJAbqcLaFHSEYSca79UkFB
         zU9hEezdjj37opmuerT+YWyGJeVFCm3MNloUK9uGbRsEfQdvs7qWTmUe4ceTNQiDLVNQ
         aYJbZdgcJv4D8qZHGrgoxsbQm2WmGOw0zo93uwn4l2smgnKC1igYpu1dPpntNa/0KyIn
         XzNw==
X-Gm-Message-State: APjAAAVT0PuCKoG2M0tHvMaG1HJuJtkuknB37N9TXbNuUv88IXV3WKDn
        scOQP9xUg1XfwtdB4pQjxb5+BaYUoi70RpH5MU8=
X-Google-Smtp-Source: APXvYqy1ij+4I1Bx6v2W2ptYFfh5jfigzMHR682nMX26nuyY33Mtt7Jc4N/bGKLHG6e/DVfD8Vs0CkaXXBmohnUW7Fo=
X-Received: by 2002:a7b:c186:: with SMTP id y6mr1007516wmi.67.1572462542027;
 Wed, 30 Oct 2019 12:09:02 -0700 (PDT)
MIME-Version: 1.0
References: <20191028060443.14997-1-madhuparnabhowmik04@gmail.com>
In-Reply-To: <20191028060443.14997-1-madhuparnabhowmik04@gmail.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 30 Oct 2019 15:08:48 -0400
Message-ID: <CADnq5_PHHNYp-nfjsgRfeoaMEo+QeQD1-rtDpQhqdJeG7gMMVA@mail.gmail.com>
Subject: Re: [PATCH] Drivers: gpu: drm: amd: display: amdgpu_dm: amdgpu_dm.h:
 Fixed a documentation warning
To:     madhuparnabhowmik04@gmail.com
Cc:     "Wentland, Harry" <harry.wentland@amd.com>,
        "Deucher, Alexander" <alexander.deucher@amd.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 28, 2019 at 4:25 AM <madhuparnabhowmik04@gmail.com> wrote:
>
> From: Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>
>
> This patch fixes the following  warning: Incorrect use of
>  kernel-doc format:          * @atomic_obj
> by adding a colon after @atomic_obj.
>
> Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>

Thanks for the patch.  This as already fixed by Harry.

Alex

> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> index c8c525a2b505..80d53d095773 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> @@ -128,7 +128,7 @@ struct amdgpu_display_manager {
>         u16 display_indexes_num;
>
>         /**
> -        * @atomic_obj
> +        * @atomic_obj:
>          *
>          * In combination with &dm_atomic_state it helps manage
>          * global atomic state that doesn't map cleanly into existing
> --
> 2.17.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
