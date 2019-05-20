Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9217EC04AB4
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 00:58:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6538220675
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 00:58:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ndTocvTf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729708AbfETA6a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 May 2019 20:58:30 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:38615 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728931AbfETA6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 May 2019 20:58:30 -0400
Received: by mail-ua1-f67.google.com with SMTP id r19so4074831uap.5
        for <linux-kernel@vger.kernel.org>; Sun, 19 May 2019 17:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iUpSk0u5fKNrtbowvgPCMeUohiETj5dnbtiTjnfmoSQ=;
        b=ndTocvTfGGCMlMrb4iCQwCHUVsSdGuIiocTk5H7o65Yb6SS92Jqzw27dXrTLTIcEsQ
         uVka+o94gmdsaQ5GLSRTnL+4GMB13c7MLe6ADwFJBrzYg8s0D21wVL0njfjUncvQa5fS
         rC8xpHc6hjGXyZtx5KJi6HOvEIBkYVh9de29JSjrO+RkPZ7uaowZFxdTQuCxgY3DJyje
         klGUeFsXZIRDOXaa0bOT1MGDpHWpdNb/n6V2CAQ9PNt4Ux5TXF+tImw25/5krzmL6Q4b
         Lo0vwa/VFj42EvhmeQFn9BurBG6O01SrMa4AwwCXcUr1EGZbLnVDs75JiLSpS56XmeOX
         X0dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iUpSk0u5fKNrtbowvgPCMeUohiETj5dnbtiTjnfmoSQ=;
        b=NS2lKg9FOsoQlEUZJ7nMYaerdg6QKDTytcq3iAoRz0XQYKp1boSQjKVTqJPkXUgoFG
         FCzf6+3ZF5+UnYqv5hZhW01NuVwAmbFZU6II3eAtpsaUeR1PJ24ppQzedvZ/8CdocBPa
         o6glwTKhgtZPECIZXABljD4AQCs5IIHUR0RmQuEtLkAe57YGkCGnGLbylS/FMfzf0u8j
         JOXRkmA4GRcqw2PbUdrsAQuH9sZYlb0zTOXuXZnDtxnqtfgRwIOyGGT8nJVcPxO0h5pf
         dXTnbC/or/l4ze/1NYHFBRYWXvgXWAwMQxC4gSvbyQTMOOGYjtW6ficsyUGaLJV4ICC0
         cj+w==
X-Gm-Message-State: APjAAAXt3840prwk9GRydwyGq2PB8Q6DiMHwewhStLzvdXznf4FMM65m
        mtz46+0Yi6y4WXqrKC4jF7NC1LlcaIgTOqfvZuU=
X-Google-Smtp-Source: APXvYqxGEJ1+TX4APILyMUXhSvjAX1FQbtbcKC1ysdjajUbV2sHiu8j76mEpa+kR4zXTwRNM6EDpVrXtr8wiA2A5WtU=
X-Received: by 2002:ab0:3406:: with SMTP id z6mr4044555uap.102.1558313909128;
 Sun, 19 May 2019 17:58:29 -0700 (PDT)
MIME-Version: 1.0
References: <20190315161142.23gfu32lueyqrmyq@smtp.gmail.com>
In-Reply-To: <20190315161142.23gfu32lueyqrmyq@smtp.gmail.com>
From:   Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
Date:   Sun, 19 May 2019 21:58:17 -0300
Message-ID: <CADKXj+4ixRrfZC9FRShEf7=L__0qk-uYNXvtwCs_tuUhgrQhEQ@mail.gmail.com>
Subject: Re: [PATCH V2] drm/vkms: Remove useless call to drm_connector_register/unregister()
To:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>,
        Haneen Mohammed <hamohammed.sa@gmail.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

I forgot to apply this patch. Is it ok for you if I apply it?


On Fri, Mar 15, 2019 at 1:11 PM Rodrigo Siqueira
<rodrigosiqueiramelo@gmail.com> wrote:
>
> The function vkms_output_init() is invoked during the module
> initialization, and it handles the creation/configuration of the vkms
> essential elements (e.g., connectors, encoder, etc). Among the
> initializations, this function tries to initialize a connector and
> register it by calling drm_connector_register(). However, inside the
> drm_connector_register(), at the beginning of this function there is the
> following validation:
>
>  if (!connector->dev->registered)
>    return 0;
>
> In this sense, invoke drm_connector_register() after initializing the
> connector has no effect because the register field is false. The
> connector register happens when drm_dev_register() is invoked; the same
> issue exists with drm_connector_unregister(). Therefore, this commit
> removes the unnecessary call to drm_connector_register() and
> drm_connector_unregister().
>
> Changes since v2:
> * Remove unnecessary call to drm_connector_unregister()
> * Remove unused label
>
> Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
> Reviewed-by: Daniel Vetter <daniel@ffwll.ch>
> ---
>  drivers/gpu/drm/vkms/vkms_output.c | 10 ----------
>  1 file changed, 10 deletions(-)
>
> diff --git a/drivers/gpu/drm/vkms/vkms_output.c b/drivers/gpu/drm/vkms/vkms_output.c
> index 3b162b25312e..56fb5c2a2315 100644
> --- a/drivers/gpu/drm/vkms/vkms_output.c
> +++ b/drivers/gpu/drm/vkms/vkms_output.c
> @@ -6,7 +6,6 @@
>
>  static void vkms_connector_destroy(struct drm_connector *connector)
>  {
> -       drm_connector_unregister(connector);
>         drm_connector_cleanup(connector);
>  }
>
> @@ -71,12 +70,6 @@ int vkms_output_init(struct vkms_device *vkmsdev)
>
>         drm_connector_helper_add(connector, &vkms_conn_helper_funcs);
>
> -       ret = drm_connector_register(connector);
> -       if (ret) {
> -               DRM_ERROR("Failed to register connector\n");
> -               goto err_connector_register;
> -       }
> -
>         ret = drm_encoder_init(dev, encoder, &vkms_encoder_funcs,
>                                DRM_MODE_ENCODER_VIRTUAL, NULL);
>         if (ret) {
> @@ -99,9 +92,6 @@ int vkms_output_init(struct vkms_device *vkmsdev)
>         drm_encoder_cleanup(encoder);
>
>  err_encoder:
> -       drm_connector_unregister(connector);
> -
> -err_connector_register:
>         drm_connector_cleanup(connector);
>
>  err_connector:
> --
> 2.21.0



-- 

Rodrigo Siqueira
https://siqueira.tech
