Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49D20C35280
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 14:17:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C72621D7B
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 14:17:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R9JOAAoi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728086AbfJBORW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 10:17:22 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55924 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727647AbfJBORW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 10:17:22 -0400
Received: by mail-wm1-f66.google.com with SMTP id a6so7379084wma.5
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2019 07:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6ZK/alQJG/DzU2yr4fmPDAWsu9lpuXfvvu9e0XLg0VM=;
        b=R9JOAAoirQ85aRbnoJE2ghGjMgnYZvgp/+N3TS16/mkj/h2NNpOiHgT9N4Vgb5ZFUr
         Qvt9YwtL7wwJGnMGjciAyBDekZP08zC/RE3WCJGsu54Kg60BFF1aRjSRZOlAexfn8HUG
         v9P0wmbcdn6mtEheFbcfdcbYIM7yWN3wnaXSfHIVlUyiWzoG8X+42qteH2PEW6Bod9ij
         YQ5czd+9r7Q5vkS6EEvyoKKuShp889JJ1P+rxHrMcZ4dTbwOQ7G+QM4EetpDK3dNgOFp
         bFZG6SemRrWRHzHE4w/TaSw0YYfUN+0ytvHd1Ea3x/2gSMAuj5O4UX3bjWSZ/jPdiEm6
         UV3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6ZK/alQJG/DzU2yr4fmPDAWsu9lpuXfvvu9e0XLg0VM=;
        b=QlN/b04O6yLvtnU4K0O5aMHFQXt9xlnkdZfki/+cVx0pDlKmfhA3K1nDJLILbjGQ1w
         +dPj8K1TdE70wiyghwM5qwUFZzoKVUDUfBdXoX0xxjRZ6lHeYuZDKG86F7ySkIEwNNae
         Cmnq9tdcHMyTq3CCLbabFwtflNr2eB0vGCzJku5bIkSwa5/GmW4hmBjp5456F45gHO30
         +QrBR8ZeDCilzadAX6y0R3ZVZbQsX+HH/jLzqWTfLn3DzSHZ8HF8ihE0c51toJC+VP3R
         Li7RrsGNVSDQZrQUM5q/ZoQf69xgwQXHu5dA7IZcChm7OnjU87RabCvWRCukPr6nxeUa
         je4Q==
X-Gm-Message-State: APjAAAWGv8dQHH287Ov7pdhDCXy3k67VuBQS//cbWL5nFTenhfMe4kwt
        9RyaDb/GGspHDvyjXu1BC2O6Ls6frljUvWdakdY=
X-Google-Smtp-Source: APXvYqyXYHJXAwnKoxIMcQTyz+KVy3BGpZtHLq8GhT6Hy6Pq77R1ldTnCYjHcoDu9jFPjmr39XnZGOn/DLiaiC8kTnQ=
X-Received: by 2002:a1c:1a45:: with SMTP id a66mr3100375wma.102.1570025839778;
 Wed, 02 Oct 2019 07:17:19 -0700 (PDT)
MIME-Version: 1.0
References: <20191002120136.1777161-1-arnd@arndb.de> <20191002120136.1777161-5-arnd@arndb.de>
In-Reply-To: <20191002120136.1777161-5-arnd@arndb.de>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 2 Oct 2019 10:17:07 -0400
Message-ID: <CADnq5_PkTwTBbQY9JatZD2_sWjdU5_hK7V2GLfviEvMh_QB12Q@mail.gmail.com>
Subject: Re: [PATCH 4/6] drm/amd/display: fix dcn21 Makefile for clang
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        LKML <linux-kernel@vger.kernel.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        clang-built-linux@googlegroups.com,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 2, 2019 at 8:03 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> Just like all the other variants, this one passes invalid
> compile-time options with clang after the new code got
> merged:
>
> clang: error: unknown argument: '-mpreferred-stack-boundary=3D4'
> scripts/Makefile.build:265: recipe for target 'drivers/gpu/drm/amd/amdgpu=
/../display/dc/dcn21/dcn21_resource.o' failed
>
> Use the same variant that we have for dcn20 to fix compilation.
>
> Fixes: eced51f9babb ("drm/amd/display: Add hubp block for Renoir (v2)")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

I'm getting an error with gcc with this patch:
  CC [M]  drivers/gpu/drm/amd/amdgpu/../display/dc/dcn21/dcn21_resource.o
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn21/dcn21_resource.c: In
function =E2=80=98calculate_wm_set_for_vlevel=E2=80=99:
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn21/dcn21_resource.c:964:22:
error: SSE register return with SSE disabled
  wm_set->urgent_ns =3D get_wm_urgent(dml, pipes, pipe_cnt) * 1000;
                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
make[4]: *** [scripts/Makefile.build:273:
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn21/dcn21_resource.o] Error
1
make[3]: *** [scripts/Makefile.build:490: drivers/gpu/drm/amd/amdgpu] Error=
 2
make[3]: *** Waiting for unfinished jobs....
make[2]: *** [scripts/Makefile.build:490: drivers/gpu/drm] Error 2
make[1]: *** [scripts/Makefile.build:490: drivers/gpu] Error 2
make: *** [Makefile:1080: drivers] Error 2

Alex

> ---
>  drivers/gpu/drm/amd/display/dc/dcn21/Makefile | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/Makefile b/drivers/gpu/=
drm/amd/display/dc/dcn21/Makefile
> index 8cd9de8b1a7a..ef673bffc241 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn21/Makefile
> +++ b/drivers/gpu/drm/amd/display/dc/dcn21/Makefile
> @@ -3,7 +3,17 @@
>
>  DCN21 =3D dcn21_hubp.o dcn21_hubbub.o dcn21_resource.o
>
> -CFLAGS_$(AMDDALPATH)/dc/dcn21/dcn21_resource.o :=3D -mhard-float -msse -=
mpreferred-stack-boundary=3D4
> +ifneq ($(call cc-option, -mpreferred-stack-boundary=3D4),)
> +       cc_stack_align :=3D -mpreferred-stack-boundary=3D4
> +else ifneq ($(call cc-option, -mstack-alignment=3D16),)
> +       cc_stack_align :=3D -mstack-alignment=3D16
> +endif
> +
> +CFLAGS_$(AMDDALPATH)/dc/dcn21/dcn21_resource.o :=3D -mhard-float -msse $=
(cc_stack_align)
> +
> +ifdef CONFIG_CC_IS_CLANG
> +CFLAGS_$(AMDDALPATH)/dc/dcn21/dcn21_resource.o +=3D -msse2
> +endif
>
>  AMD_DAL_DCN21 =3D $(addprefix $(AMDDALPATH)/dc/dcn21/,$(DCN21))
>
> --
> 2.20.0
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
