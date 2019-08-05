Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17413C0650F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 17:15:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD3CC216F4
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 17:15:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JjTRgPB+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729608AbfHERPA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 13:15:00 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:38584 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728843AbfHERO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 13:14:59 -0400
Received: by mail-io1-f68.google.com with SMTP id j6so1209411ioa.5
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2019 10:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BaGEBCCvHgLEeEM0jkTTKpXw1mRgMNiOlwrLO1Ss3pE=;
        b=JjTRgPB+SGUpcW+V3EtO6gL93HfTBnpBBM2vny9l8TcyUi5UkRHiDr4pq4BfGTxDm9
         6qlTZ0bf4iNdZYF/tA9gMQDaHOKsCk0kkQ7sG+UIrccFLU970xNtlgGQHFVJcps/j+6g
         pqTNufrlLPZqx2gH19poXxTiOgxkMlpjPxz6BtEWFFxrBwuZh6iaB1o3V6sVX56+ylGU
         2pszfJRnRuLfd3ez1yKDNCqpKFzfIMt7ScpsAppPN5dSa1UtA4JwMl67ZKOiCjpjyKH8
         E+W9yaFIGavidj9gdLW170u1mu/Nq9jerve9QF+3GHtgQvR1fhS0D2sNraatYXX5C9Xm
         FQIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BaGEBCCvHgLEeEM0jkTTKpXw1mRgMNiOlwrLO1Ss3pE=;
        b=if/MtYLHMlt7SLEd/COlCWsKQPZxLNzl/WuCzTIlYEtsiGRa+jPU+pD77l+2mDavAl
         uC0lNXWAH3IWnf61N80Ub9tCwfkSuGr9lSIPSYE9nLz+ewa6UExHf+9dOF8ZxQH26ilN
         fmJZ+pNKqw1Q58UBZjzmghY8tJnFMNlZJRz9VJHVMgTQF25t2LRBQzpIVMhWvMnsvykU
         7Bkg2fok0cUOEum3WG/82C6MUSFZeXc4QRIXDekh7tasZ1zKdSYqngr971XuSwtk0Opx
         L6fT8jsGO6S4r2/vew0yvDjSfIFY4C0ID3Nh0YTU/0D+K/JVhuYGJV/juCTfjpFHmLiq
         VUCQ==
X-Gm-Message-State: APjAAAVtpF2puS48sBy8VmR/1U9jva+T0FcaKEAY+qkNh2NP2y/rsKBQ
        FmRdwXs8nXYxtdClP2hyX1WUJbDj/JTlXU58yAjrBGWAS+Zx8w==
X-Google-Smtp-Source: APXvYqyYq8Rtn/DMdIS94LKA7/HHkb6Gd4UKz+pVmoP+PdIkZvkKoQxrBDinOQiL8GBtZH952dHVKUmsuGzP5lURYG4=
X-Received: by 2002:a02:1607:: with SMTP id a7mr623447jaa.123.1565025298399;
 Mon, 05 Aug 2019 10:14:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190805032114.8740-1-hdanton@sina.com>
In-Reply-To: <20190805032114.8740-1-hdanton@sina.com>
From:   Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date:   Mon, 5 Aug 2019 22:14:47 +0500
Message-ID: <CABXGCsM3-Ax0jsLS=QCM6m331onGXLEcfmmc_kLdqgOLzMSj9Q@mail.gmail.com>
Subject: Re: The issue with page allocation 5.3 rc1-rc2 (seems drm culprit here)
To:     Hillf Danton <hdanton@sina.com>
Cc:     Dave Airlie <airlied@gmail.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        Harry Wentland <harry.wentland@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Aug 2019 at 08:21, Hillf Danton <hdanton@sina.com> wrote:
>
>
>
> Try to fix the failure above using vmalloc + kmalloc.
>
> --- a/drivers/gpu/drm/amd/display/dc/core/dc.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
> @@ -1174,8 +1174,12 @@ struct dc_state *dc_create_state(struct
>         struct dc_state *context = kzalloc(sizeof(struct dc_state),
>                                            GFP_KERNEL);
>
> -       if (!context)
> -               return NULL;
> +       if (!context) {
> +               context = kvzalloc(sizeof(struct dc_state),
> +                                          GFP_KERNEL);
> +               if (!context)
> +                       return NULL;
> +       }
>         /* Each context must have their own instance of VBA and in order to
>          * initialize and obtain IP and SOC the base DML instance from DC is
>          * initially copied into every context
> @@ -1195,8 +1199,13 @@ struct dc_state *dc_copy_state(struct dc
>         struct dc_state *new_ctx = kmemdup(src_ctx,
>                         sizeof(struct dc_state), GFP_KERNEL);
>
> -       if (!new_ctx)
> -               return NULL;
> +       if (!new_ctx) {
> +               new_ctx = kvmalloc(sizeof(*new_ctx), GFP_KERNEL);
> +               if (new_ctx)
> +                       *new_ctx = *src_ctx;
> +               else
> +                       return NULL;
> +       }
>
>         for (i = 0; i < MAX_PIPES; i++) {
>                         struct pipe_ctx *cur_pipe = &new_ctx->res_ctx.pipe_ctx[i];
> @@ -1230,7 +1239,7 @@ static void dc_state_free(struct kref *k
>  {
>         struct dc_state *context = container_of(kref, struct dc_state, refcount);
>         dc_resource_state_destruct(context);
> -       kfree(context);
> +       kvfree(context);
>  }
>
>  void dc_release_state(struct dc_state *context)
> --

Unfortunately couldn't check this patch because, with the patch, the
kernel did not compile.
Here is compile error messages:

drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc.c: In function
'dc_create_state':
drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc.c:1178:13: error:
implicit declaration of function 'kvzalloc'; did you mean 'kzalloc'?
[-Werror=implicit-function-declaration]
 1178 |   context = kvzalloc(sizeof(struct dc_state),
      |             ^~~~~~~~
      |             kzalloc
drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc.c:1178:11: warning:
assignment to 'struct dc_state *' from 'int' makes pointer from
integer without a cast [-Wint-conversion]
 1178 |   context = kvzalloc(sizeof(struct dc_state),
      |           ^
drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc.c: In function 'dc_copy_state':
drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc.c:1203:13: error:
implicit declaration of function 'kvmalloc'; did you mean 'kmalloc'?
[-Werror=implicit-function-declaration]
 1203 |   new_ctx = kvmalloc(sizeof(*new_ctx), GFP_KERNEL);
      |             ^~~~~~~~
      |             kmalloc
drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc.c:1203:11: warning:
assignment to 'struct dc_state *' from 'int' makes pointer from
integer without a cast [-Wint-conversion]
 1203 |   new_ctx = kvmalloc(sizeof(*new_ctx), GFP_KERNEL);
      |           ^
drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc.c: In function 'dc_state_free':
drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc.c:1242:2: error:
implicit declaration of function 'kvfree'; did you mean 'kzfree'?
[-Werror=implicit-function-declaration]
 1242 |  kvfree(context);
      |  ^~~~~~
      |  kzfree
cc1: some warnings being treated as errors
make[4]: *** [scripts/Makefile.build:274:
drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc.o] Error 1
make[4]: *** Waiting for unfinished jobs....
make[3]: *** [scripts/Makefile.build:490: drivers/gpu/drm/amd/amdgpu] Error 2
make[3]: *** Waiting for unfinished jobs....
make: *** [Makefile:1084: drivers] Error 2


--
Best Regards,
Mike Gavrilov.
