Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18FE5C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 00:28:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6DE420840
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 00:28:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AdjE0Jhe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726367AbfCHA20 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 19:28:26 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35206 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726249AbfCHA2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 19:28:25 -0500
Received: by mail-pf1-f194.google.com with SMTP id j5so12758133pfa.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2019 16:28:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5aMcC2e3BRQ8MRf8jt7V0HNINMgwvCC+sL+z9DPUXa0=;
        b=AdjE0Jhe/W8RMuzX16dGstwkm5owLC3kBObuSKcmTNAKrznDmH9HvVUiQhOQmhBQC/
         tfM6bEnZKO5tAv7X3HtrvHvW6FtdMbGGT2LzHor94c/9FysgbEU2Sz+V6kkQijaDR5ER
         yXbSfczGGPSieziqaCgFUuZQhkgKWjnLpDXx2l4U9wQ+kVaf3ciiH0Asj58mOMb5lBvA
         1CPzjh2K3BHJXB6D2DBwRaqj+NTrt2n00CKGHXilOz5G7i4DDi0l0vJFpkdK9rkaf5BC
         01OI/EO42I42hzzlqgydH10w5Rei5pUUuipOD3+LEF4QQyGBvx+YMv9PaEiHlgjKqm3p
         zytA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5aMcC2e3BRQ8MRf8jt7V0HNINMgwvCC+sL+z9DPUXa0=;
        b=oBvetzOw26LSjc05UxxFBdQReUgKFBMZVsX2C+UriTAo1oBr2w1LDUglvNRCiTTh9j
         +A3gH1pf04OqNPvC3k3rABqNcHL7GwP1s/SAt8+2e8/j7IRZBvWYVgvTjZaw2+4hXjKx
         XzfPXVnf9RBc+87bCGbFBccRfaZfYzYRAKIJ3Ubz3IWHX2zijkdn9U4W2wW8aUVxWp4H
         OeGdLr0GPoGiV0YqXwtOWbMRqGzxn+9l3HbRwAfZvyY/0EIJY+NnHbIJOwrnoWIAYV9W
         8lHbDrAqzDbrOh9Yv380y2tw0KuQQDI2nq6VLyy1iDW+PYfKgTUbWxc9jVtp+HU1n/oO
         KnqA==
X-Gm-Message-State: APjAAAUiRdGo/iS4krlR8tnqoPyXur3VcMdq1ZiKFplvMeomvjpo9aHm
        IXgA3P+GqQZ33LR82tEwl1+I/07QyCTW2ECfwKm3YA==
X-Google-Smtp-Source: APXvYqz8C8r70r0KeTZ7YIUrd6RMV44hIv7t234JWXMEU8TVol8TlPepCyoL7c2/aUvZMSXjx029rvaRMZueMZrN4Cw=
X-Received: by 2002:a17:902:56a:: with SMTP id 97mr15649767plf.320.1552004904690;
 Thu, 07 Mar 2019 16:28:24 -0800 (PST)
MIME-Version: 1.0
References: <20190307222611.18100-1-natechancellor@gmail.com>
In-Reply-To: <20190307222611.18100-1-natechancellor@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 7 Mar 2019 16:28:13 -0800
Message-ID: <CAKwvOd=4AT4AEkmVLi+sxCwKMCFgpx=AVsJ-ajhnSWOH=xFy4Q@mail.gmail.com>
Subject: Re: [PATCH] drm/vmwgfx: Zero initialize handle in vmw_execbuf_process
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     VMware Graphics <linux-graphics-maintainer@vmware.com>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 7, 2019 at 2:26 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> When building with -Wsometimes-uninitialized, Clang warns:
>
> drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c:3964:7: warning: variable
> 'handle' is used uninitialized whenever '?:' condition is false
> [-Wsometimes-uninitialized]
>
> It's not wrong; however, in practice, this is never an issue because
> the value of handle isn't used when user_fence_rep is NULL because
> vmw_execbuf_copy_fence_user returns immediately when that is the case.

Still, it's better not to conditionally pass unitialized memory to
functions.  Invariants like "don't touch this possibly unitialized
memory in THIS case" don't always pass from maintainer to maintainer.
Thanks for the patch.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> Just zero initialize this variable so that Clang no longer warns.
>
> Link: https://github.com/ClangBuiltLinux/linux/issues/397
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>  drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c b/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
> index 88b8178d4687..4ba06c2828a1 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
> @@ -3829,7 +3829,7 @@ int vmw_execbuf_process(struct drm_file *file_priv,
>         struct vmw_sw_context *sw_context = &dev_priv->ctx;
>         struct vmw_fence_obj *fence = NULL;
>         struct vmw_cmdbuf_header *header;
> -       uint32_t handle;
> +       uint32_t handle = 0;
>         int ret;
>         int32_t out_fence_fd = -1;
>         struct sync_file *sync_file = NULL;
> --
> 2.21.0
>
> --
> You received this message because you are subscribed to the Google Groups "Clang Built Linux" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to clang-built-linux+unsubscribe@googlegroups.com.
> To post to this group, send email to clang-built-linux@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/clang-built-linux/20190307222611.18100-1-natechancellor%40gmail.com.
> For more options, visit https://groups.google.com/d/optout.



-- 
Thanks,
~Nick Desaulniers
