Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66D95ECE58C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 16:08:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35C85205C9
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 16:08:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hc6iJa4G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728723AbfJGQIc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 12:08:32 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54589 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727711AbfJGQIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 12:08:32 -0400
Received: by mail-wm1-f66.google.com with SMTP id p7so77815wmp.4;
        Mon, 07 Oct 2019 09:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z1iEZfsz63+hFaflS3INWnySuglWD+I2yD90meQjneg=;
        b=hc6iJa4GVuhNuWWKGTrUwO7QaLE2DMH8tSuKd1N7fa2ey63T4C3Sv79QBeWNYBbDYE
         IBuGrRoyMSkcqqgjaMBcN2U+I5kYsOZmpfe25vJ4AO9sBXoWXaqq0f1F8XeJ3dN6nuCj
         id/bC57fyx6raHUDxh1UvEP2H/ZuD8KWZfDyFRUUAHQRLL8MC+/7k8CaMDbuIb4lr6PY
         r6FfQh4xBIcS0GPcIpDSGfh7pmn7rxiwEW0cgQeJWM//Ojfd1i58lKyL2uopQNa6BE01
         bGR7j88/Vab0pw636IuaEb8mq9eqk79QlZKmvc2fRSb8e+GubGoRijjFLnyJsQATvW04
         539Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z1iEZfsz63+hFaflS3INWnySuglWD+I2yD90meQjneg=;
        b=ZCQPXqjBJlOCfdcK8eRbygK/RSfYKdmKZwp2KN4wCViQ6OB+cFZnhHKZE3VO6PRdJo
         igolQgrNdutiRwTd10otapCpkSqsz82GjquV0zFYszjT42Ttg4yQalyiS4ayLIVkxHp7
         MJqKIjBXrpuqnc0rODxVoRUn/NBOUOGIlmHsV2rRP8GcJP66hAuR7EB5+Bz9Z4fNQYu7
         maEh4kQWVJp5VffVtiBjhQU4Y7Pz7Hay7ZP1qCMZW6KWMAGe9BPgjePYHJzzJLfvkKT5
         hgwFLRDoPWOFt0jXh1QWwRKM/EoqdW5NUzTD0XunYcu1lJfVBxE/DOIaln7CA8d5hOt0
         a47A==
X-Gm-Message-State: APjAAAUoqjDp1OyIwvDEoDImpDDsCftmEV9jNR/AqRBkOcRzwviOIhiq
        NOpCVzI1NHlWsdHy9l3aQGMClWDGH4eZCkokEnNU0A==
X-Google-Smtp-Source: APXvYqyq4efJgRyiW1dhwc+BXSa/rMaGmKzS1bwzST3wnGDfySKyRkkUk67CpkWeFqq/cYJquUmsPhHAH94fVc4ULu0=
X-Received: by 2002:a1c:3908:: with SMTP id g8mr64842wma.34.1570464509638;
 Mon, 07 Oct 2019 09:08:29 -0700 (PDT)
MIME-Version: 1.0
References: <20191005175808.32018-1-colin.king@canonical.com>
In-Reply-To: <20191005175808.32018-1-colin.king@canonical.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 7 Oct 2019 12:08:17 -0400
Message-ID: <CADnq5_PkTbzqNfesJt29SaB7=R0x4BdoNmHiNDXrHwqj02JUGg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdkfd: add missing void argument to function kgd2kfd_init
To:     Colin King <colin.king@canonical.com>
Cc:     Felix Kuehling <Felix.Kuehling@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        David Zhou <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>, kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 5, 2019 at 1:58 PM Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> Function kgd2kfd_init is missing a void argument, add it
> to clean up the non-ANSI function declaration.
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied.  thanks!

Alex

> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_module.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_module.c b/drivers/gpu/drm/amd/amdkfd/kfd_module.c
> index 986ff52d5750..f4b7f7e6c40e 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_module.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_module.c
> @@ -82,7 +82,7 @@ static void kfd_exit(void)
>         kfd_chardev_exit();
>  }
>
> -int kgd2kfd_init()
> +int kgd2kfd_init(void)
>  {
>         return kfd_init();
>  }
> --
> 2.20.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
