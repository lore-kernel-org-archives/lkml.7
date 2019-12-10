Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CC7BC00454
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 22:18:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E46AB2053B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 22:18:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B1QR3m2H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727324AbfLJWSr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 17:18:47 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37901 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726598AbfLJWSr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 17:18:47 -0500
Received: by mail-wm1-f66.google.com with SMTP id p17so4907280wmi.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2019 14:18:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/xeSJ1vVQGbd+lIc7YdzwAZ3r9lP4F35wcBj4c6Z8vM=;
        b=B1QR3m2HFzPOE0yEbMaZ1Sv5w1g+5+FM6cKF0BpNVupNgtuHvgoHSP7I3Ziag9IEx1
         nSVN5CjtjtmnmRmVAxT0qR1PQBTISWoP5nlGxR/74CBAwLEX4RLUCUSjKS0HZ6qS4ybG
         vew9E7FQWm5s6CIZnCYXKkrVaYcaYteviw9EajeSB26BxomxoMM0kJSvZugp8yj15Lu5
         fyuej3mOWV8JZDG8Evb4K2KwBo/i78gQ3qjzTw7OedgXfxux3nv7MBeG00X5+hIrC3uB
         SjgBDVMv5v15UTvH+HkbnSNLb1Dk+kJcuJdLPYH+SlRYf87GGIlcViMdZ3gRriu3pw9Q
         PxNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/xeSJ1vVQGbd+lIc7YdzwAZ3r9lP4F35wcBj4c6Z8vM=;
        b=aiqE1pmGQqrn1Io9jEVYmJY6pS+t2tf7p7ITTkf6YP4/BUfQk1Dn7UlN5wDeSN/3MB
         VB2gqkYtMCHPYrTZ9Zcph61eSCfG9So4VCTTakiiVEJNfY6fz/36aOS2EdbE8pfjRM87
         dDsNcvCWntG3+Tv4ZThs+8r+722Q1Wu10RCAgKNyDfcxtDL9QZodi5Qkr4udXZGIuzq2
         W1QyToX/D+VTk68vd1xlyEWBrcLQE+Fv/pOtr+d9v7A9DCiuUAf4vaI5pjkwBFtqOkQl
         gK2VZOfoWQkKHh/YFI6BbiPKusKhP0QqT/Cef1jJAo1J/0796kYEZhD4CpvoOLa0ZzwJ
         zlgg==
X-Gm-Message-State: APjAAAUENceEIkAb3DOBjiEcHQ/p3sHfPKNj9z3oks5WlHX9Y0NOLKcf
        VSuatJtMJfw3gGKXSrCKmydn5LEhXFoIF4guzdc=
X-Google-Smtp-Source: APXvYqzLcz+L/kcYgFcxP6XewiOkpSfkoPwGQbtDouaQraSVktzlPiRm+eotTeS8npUt7k71bLFPIMThugyJTYeKi8M=
X-Received: by 2002:a1c:4454:: with SMTP id r81mr7591380wma.143.1576016324848;
 Tue, 10 Dec 2019 14:18:44 -0800 (PST)
MIME-Version: 1.0
References: <20191210195941.931745-1-arnd@arndb.de>
In-Reply-To: <20191210195941.931745-1-arnd@arndb.de>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 10 Dec 2019 17:18:31 -0500
Message-ID: <CADnq5_Ou91nmzTc6mAugpbML4XqrYfSg0jcx7U9yb=X3LSmZiA@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: include linux/slab.h where needed
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Eric Yang <Eric.Yang2@amd.com>, Roman Li <Roman.Li@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Michael Strauss <michael.strauss@amd.com>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

Alex

On Tue, Dec 10, 2019 at 2:59 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> Calling kzalloc() and related functions requires the
> linux/slab.h header to be included:
>
> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn21/dcn21_resource.c: In function 'dcn21_ipp_create':
> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn21/dcn21_resource.c:679:3: error: implicit declaration of function 'kzalloc'; did you mean 'd_alloc'? [-Werror=implicit-function-declaration]
>    kzalloc(sizeof(struct dcn10_ipp), GFP_KERNEL);
>
> A lot of other headers also miss a direct include in this file,
> but this is the only one that causes a problem for now.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
> index 906c84e6b49b..af57885bbff2 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
> @@ -23,6 +23,8 @@
>   *
>   */
>
> +#include <linux/slab.h>
> +
>  #include "dm_services.h"
>  #include "dc.h"
>
> --
> 2.20.0
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
