Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02152C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 17:41:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C59A8206B6
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 17:41:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="frcPfBLa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404028AbfETRlP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 13:41:15 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35098 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730952AbfETRlO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 13:41:14 -0400
Received: by mail-wr1-f67.google.com with SMTP id m3so2600712wrv.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 10:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=SaB/HyT6/oED/ncLmyVItIP9zgJopLUDhT4V1Cn8C8s=;
        b=frcPfBLaCkAw55Tyx6V/dkyb1Dmt0u/f01wtgyBsyWUXbf/vOUNITWX7xPXthtq0xl
         bft0muUuT9iexs2vQ6DlzlFzt4voZf+LvjjC96BVra+o4/eQ/6NNFm6ml2Hf9zFy6YzE
         JDIAM8DK86IRqaDnt4iGFGaI10ic5qzQ4IzjI2HJBMvBq91Im9WWCtGHe/1I5MMDTDuW
         tNJjaUtpCSy+KGiqj8wU1HfSUfMf0FgqnY7t6aySQ/vN+w351CycwNdbRsBZbklhCeW3
         PiQAyp++pVdCmkr8h/Xf6Sx/RdJ37H8FM5mDXNSTsgGvXOIsyd9IntqgI6opnb7PTlAy
         1bkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=SaB/HyT6/oED/ncLmyVItIP9zgJopLUDhT4V1Cn8C8s=;
        b=im1JMF3e5EM+7HBYeue4mXp4rpr7zYZHrmXd587RolyN7j6mNt0xKoCACL9Sw2/bmn
         1+MfC0D9YCKbziZI8OlxpAhVJZXMTUbYMrrRoYfBFhkEbZ2+vt6IkiNFavJ9KO1bwfCV
         5F39FN7huMtfS3erDiGG9NbhzHdMVGtTFLEJNT9PSECogT5lhMqDCn+kH7k8VFIx+nir
         hkc4ubNhpvjkeA0xP/4Xk7WVmwwk1r+QlKN8G+hf11CWTUhqXyUnRVoXvGfmZ/Z/yXr3
         NAJFiqHWBI/T0yQw//3pRa9W1artkD0kDK/YX8baBmOz9UBeaDv94GAZXsPrBcVuVTBz
         wWJg==
X-Gm-Message-State: APjAAAVIIZ8QtUzIKiAUGnorzMF1+6AsRHLE4JyqsZ8GRgmGhFLxfkSn
        cr++Sq2u3044GLG4khfsvjBGYKDGk2HmzC3xucY=
X-Google-Smtp-Source: APXvYqyui4f360e+bz+pu+lDAMTcDkxzvL/eUGo/Z3wwpdBtjdZ27UVuZkcz1Sle0DqxtjFl+Arr1JSFuBerydhsTUw=
X-Received: by 2002:adf:8bc5:: with SMTP id w5mr3818759wra.132.1558374073011;
 Mon, 20 May 2019 10:41:13 -0700 (PDT)
MIME-Version: 1.0
References: <1558082760-4915-1-git-send-email-xiaolinkui@kylinos.cn>
In-Reply-To: <1558082760-4915-1-git-send-email-xiaolinkui@kylinos.cn>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 20 May 2019 13:41:00 -0400
Message-ID: <CADnq5_PE-mvW2zwNeHn6prvTQvh-en9E9F7VE-hCS=a8jJWhAQ@mail.gmail.com>
Subject: Re: [PATCH] gpu: drm: use struct_size() in kmalloc()
To:     xiaolinkui <xiaolinkui@kylinos.cn>
Cc:     "Deucher, Alexander" <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Chunming Zhou <David1.Zhou@amd.com>,
        Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        xinhui pan <xinhui.pan@amd.com>,
        "Quan, Evan" <evan.quan@amd.com>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 17, 2019 at 8:43 AM xiaolinkui <xiaolinkui@kylinos.cn> wrote:
>
> Use struct_size() helper to keep code simple.
>
> Signed-off-by: xiaolinkui <xiaolinkui@kylinos.cn>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

This patch results in the following build error:
  DESCEND  objtool
  CALL    scripts/checksyscalls.sh
  CHK     include/generated/compile.h
  CC [M]  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.o
In file included from ./include/linux/kernel.h:15,
                 from ./include/linux/list.h:9,
                 from ./include/linux/wait.h:7,
                 from ./include/linux/wait_bit.h:8,
                 from ./include/linux/fs.h:6,
                 from ./include/linux/debugfs.h:15,
                 from drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c:24:
drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c: In function =E2=80=98amdgpu_ras_in=
it=E2=80=99:
./include/linux/build_bug.h:16:45: error: negative width in bit-field
=E2=80=98<anonymous>=E2=80=99
 #define BUILD_BUG_ON_ZERO(e) (sizeof(struct { int:(-!!(e)); }))
                                             ^
./include/linux/compiler.h:349:28: note: in expansion of macro
=E2=80=98BUILD_BUG_ON_ZERO=E2=80=99
 #define __must_be_array(a) BUILD_BUG_ON_ZERO(__same_type((a), &(a)[0]))
                            ^~~~~~~~~~~~~~~~~
./include/linux/overflow.h:306:30: note: in expansion of macro =E2=80=98__m=
ust_be_array=E2=80=99
       sizeof(*(p)->member) + __must_be_array((p)->member),\
                              ^~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c:1556:16: note: in expansion of
macro =E2=80=98struct_size=E2=80=99
  con =3D kmalloc(struct_size(con, objs, AMDGPU_RAS_BLOCK_COUNT),
                ^~~~~~~~~~~
make[4]: *** [scripts/Makefile.build:276:
drivers/gpu/drm/amd/amdgpu/amdgpu_ras.o] Error 1
make[4]: *** Waiting for unfinished jobs....
make[3]: *** [scripts/Makefile.build:492: drivers/gpu/drm/amd/amdgpu] Error=
 2
make[3]: *** Waiting for unfinished jobs....
make[2]: *** [scripts/Makefile.build:492: drivers/gpu/drm] Error 2
make[1]: *** [scripts/Makefile.build:492: drivers/gpu] Error 2
make: *** [Makefile:1042: drivers] Error 2

Alex


>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_ras.c
> index 22bd21e..4717a64 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -1375,8 +1375,7 @@ int amdgpu_ras_init(struct amdgpu_device *adev)
>         if (con)
>                 return 0;
>
> -       con =3D kmalloc(sizeof(struct amdgpu_ras) +
> -                       sizeof(struct ras_manager) * AMDGPU_RAS_BLOCK_COU=
NT,
> +       con =3D kmalloc(struct_size(con, objs, AMDGPU_RAS_BLOCK_COUNT),
>                         GFP_KERNEL|__GFP_ZERO);
>         if (!con)
>                 return -ENOMEM;
> --
> 2.7.4
>
>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
