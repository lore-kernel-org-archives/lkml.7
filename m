Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA702C04E30
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 20:52:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABBAE205C9
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 20:52:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BMWEse7d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbfLIUwx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 15:52:53 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46035 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726408AbfLIUwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 15:52:53 -0500
Received: by mail-pf1-f195.google.com with SMTP id 2so7810840pfg.12
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2019 12:52:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AvjOGQmItdmAy3vt51SLf/vsbTcB+aY7zT7fuJp4dP4=;
        b=BMWEse7d1vmm4hcRPwoeetEsOJYLiI4dgw9xLiplO0kcQPQGJTWcCySVk/dxpgEIjD
         aKuwxgkKhpRzsNinYeQ6WaeRPPQmSUj7TOmGQMOUgD+fgRMu6zW+lWsT1kEJAA8lbRZJ
         YRiyUsGtUoDgz4LdpMB563SEhOIhgoz0+7Kcc2aw6rUJp0mOgAPM5Q3WBm7i9sZsfiHW
         0sqil7OCE6YPGohvE/BdFR055EKas3ushjKPqXVqq8BjMOiavvdM0iDBkPajR8FSGpC4
         naLDsMfafXdYWwxdcVl6JR2dBsXK6xLG8XlXJaqxvUyWFtncztTKGy53J38WMbqh8i+a
         vQsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AvjOGQmItdmAy3vt51SLf/vsbTcB+aY7zT7fuJp4dP4=;
        b=tPWA5O8MgI5Nquf2vlunshUBRx2uhbBhr2/Pp+43KuXqkJOzJihJjI5j+hXr9JRZvf
         Srm3Eg6nhs0iXCTHIAERTQO4WlW5es6YgqGKS0fXh9IqSrkTdivwBoEfMVh9daPaKjQl
         wMKtO4bmmqw1A2gsxWnWf9jHOM3fZU/+KB6HXkT/CDZPxe/X+35adjQ5NHysqt1muT98
         UuA1Kb+PdSm8pov4g6x6RGGpOIgGTEK8MwXV+K3uJDvEzwdKyttxUh+XTPl0ZBwEeK5h
         5eWT5ERr63IhqVoyQJf5jJs3QAIKNBm1/M/aidr3YRM6SvQ0axvhQJ10doKUOT1QGSyi
         +gNQ==
X-Gm-Message-State: APjAAAU6YWOp0ATLPnn52kq4ce8Z6LWJxzKUAYPNQt17Dv9ToU4pO9YG
        dHVngTteEQlCQuhzUftwWpo1RoqJSwJTtchAZJnxwg==
X-Google-Smtp-Source: APXvYqz8Ve5gTEe1GJWo8d+hmU7g5Xc1hhSGGDWsktmPt0CbWvIadFurW+S41A/AyyWjRjToxNxMLj9v6BgHAqXJmZU=
X-Received: by 2002:a65:590f:: with SMTP id f15mr20415804pgu.381.1575924772395;
 Mon, 09 Dec 2019 12:52:52 -0800 (PST)
MIME-Version: 1.0
References: <20191209203230.1593-1-natechancellor@gmail.com>
In-Reply-To: <20191209203230.1593-1-natechancellor@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 9 Dec 2019 12:52:40 -0800
Message-ID: <CAKwvOdkeCCuYDWQFHitFczFX1-R1LjWoJ2gAfLuQAqvGz0ymPg@mail.gmail.com>
Subject: Re: [PATCH] drm: msm: mdp4: Adjust indentation in mdp4_dsi_encoder_enable
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        freedreno@lists.freedesktop.org,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 9, 2019 at 12:32 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> Clang warns:
>
> ../drivers/gpu/drm/msm/disp/mdp4/mdp4_dsi_encoder.c:124:3: warning:
> misleading indentation; statement is not part of the previous 'if'
> [-Wmisleading-indentation]
>          mdp4_crtc_set_config(encoder->crtc,
>          ^
> ../drivers/gpu/drm/msm/disp/mdp4/mdp4_dsi_encoder.c:121:2: note:
> previous statement is here
>         if (mdp4_dsi_encoder->enabled)
>         ^
>
> This warning occurs because there is a space after the tab on this line.
> Remove it so that the indentation is consistent with the Linux kernel
> coding style and clang no longer warns.

Thanks for the cleanup. Nothing to see here, but should help us find
more interesting cases.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
(If there are other instances in drivers/gpu/drm/msm, they should be
rolled up into this commit)

>
> Fixes: 776638e73a19 ("drm/msm/dsi: Add a mdp4 encoder for DSI")
> Link: https://github.com/ClangBuiltLinux/linux/issues/792
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>  drivers/gpu/drm/msm/disp/mdp4/mdp4_dsi_encoder.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/msm/disp/mdp4/mdp4_dsi_encoder.c b/drivers/gpu/drm/msm/disp/mdp4/mdp4_dsi_encoder.c
> index 772f0753ed38..aaf2f26f8505 100644
> --- a/drivers/gpu/drm/msm/disp/mdp4/mdp4_dsi_encoder.c
> +++ b/drivers/gpu/drm/msm/disp/mdp4/mdp4_dsi_encoder.c
> @@ -121,7 +121,7 @@ static void mdp4_dsi_encoder_enable(struct drm_encoder *encoder)
>         if (mdp4_dsi_encoder->enabled)
>                 return;
>
> -        mdp4_crtc_set_config(encoder->crtc,
> +       mdp4_crtc_set_config(encoder->crtc,
>                         MDP4_DMA_CONFIG_PACK_ALIGN_MSB |
>                         MDP4_DMA_CONFIG_DEFLKR_EN |
>                         MDP4_DMA_CONFIG_DITHER_EN |
> --
> 2.24.0
>
> --
> You received this message because you are subscribed to the Google Groups "Clang Built Linux" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to clang-built-linux+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/clang-built-linux/20191209203230.1593-1-natechancellor%40gmail.com.



-- 
Thanks,
~Nick Desaulniers
