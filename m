Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DDE7C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 13:06:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1B602173C
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 13:06:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tNPNt9Ww"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732157AbfDQNGY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 09:06:24 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:56289 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729395AbfDQNGY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 09:06:24 -0400
Received: by mail-it1-f193.google.com with SMTP id y134so4385275itc.5
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 06:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hBjREtF6unCqrtvjKNwmKX4QtKipDGDtbHNiyhQu1zI=;
        b=tNPNt9WwPLnvglhbGL0/WNtAQ/FB1kHbnCOlRqO28EPZez0BoXp96b/jYpmXEffm2r
         0myrVZouUQVVU+mUXNB4kL3tKMs2Zo/fkJhgwTJ+dffOYuf+d4Qe4xZjM2L5zOVbCKk4
         FFeHqBjAdIMm+bsv0eJmyLGevd7UD/tHHxUbpSHZkj609nkbihtNWinZZFeMcoJjl8wd
         hOl1fo76lr32E5ZOgOAvIltopx3/k69BrChJKW/wuSaRwf3MT9tR8THnJHK7Iy5IL9Nv
         4vwbBlJAkFarfMnAkfpfB4eZrwujr9xfCy2XVgqo8Mn4yxlQyIJdGPWheMisvE5mh1m4
         EuEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hBjREtF6unCqrtvjKNwmKX4QtKipDGDtbHNiyhQu1zI=;
        b=qObqZxz7L/OON/spZq7t45e9GvzNo3vbybHPbc/ASiHjcpjjycjKznB53+W0IjB0+5
         cr/bhwXJ12jMWCJjbOSR/WKzrc4u8QlpCZNhf1Gha+GZ8z6RRGP16XIg6TLtI0eQp8h3
         jdWZ4EAuhs9YvcpJ4NG/RxB6UMsnx4avBGmSlmOZgNTSYhud1q+cM19Eymr16STNk8f1
         ve6KnZh/rNC9++MkL5gPXscCX1N/p4GTKVH+2eBAaCfNdcOEDp+0ZahXPW1BDbMyMQv+
         4hySyQA9kmVB5K5BEaET5+im+40Da692MefcgkqqpnVIXc0zRKiNAH0QnICw5g8x3DRw
         1/Hg==
X-Gm-Message-State: APjAAAU0jui61ffYyeUPSmgQd5h1mBKVqxxXHudxKbDYSN357AbKovQn
        wMRlHCiPIZy6cUHdtoI3eNgZd3/6nKi8c6vUrGjiSg==
X-Google-Smtp-Source: APXvYqx/kEHDKPiUcc+s3e/Na3elcKJbEO/BSMJSOuCRdblRsKUFdNKB0VLg0eSfmDaP4XQSrjdT/MD2XAlbVljZxJw=
X-Received: by 2002:a02:924d:: with SMTP id y13mr57913507jag.24.1555506383238;
 Wed, 17 Apr 2019 06:06:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190416144353.34024-1-yuehaibing@huawei.com>
In-Reply-To: <20190416144353.34024-1-yuehaibing@huawei.com>
From:   Qiang Yu <yuq825@gmail.com>
Date:   Wed, 17 Apr 2019 21:06:07 +0800
Message-ID: <CAKGbVbv0NBP=bMznWmb+RLz+ndCQY6eLQ4_vmGTsBkC-0L4dAQ@mail.gmail.com>
Subject: Re: [PATCH -next] drm/lima: Make lima_sched_ops static
To:     Yue Haibing <yuehaibing@huawei.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        lima@lists.freedesktop.org,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pushed to drm-misc-next.

Thanks,
Qiang

On Tue, Apr 16, 2019 at 10:44 PM Yue Haibing <yuehaibing@huawei.com> wrote:
>
> From: YueHaibing <yuehaibing@huawei.com>
>
> Fix sparse warning:
>
> drivers/gpu/drm/lima/lima_sched.c:356:36: warning:
>  symbol 'lima_sched_ops' was not declared. Should it be static?
>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/gpu/drm/lima/lima_sched.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/lima/lima_sched.c b/drivers/gpu/drm/lima/lima_sched.c
> index 97bd9c1..569f0a95 100644
> --- a/drivers/gpu/drm/lima/lima_sched.c
> +++ b/drivers/gpu/drm/lima/lima_sched.c
> @@ -353,7 +353,7 @@ static void lima_sched_free_job(struct drm_sched_job *job)
>         kmem_cache_free(pipe->task_slab, task);
>  }
>
> -const struct drm_sched_backend_ops lima_sched_ops = {
> +static const struct drm_sched_backend_ops lima_sched_ops = {
>         .dependency = lima_sched_dependency,
>         .run_job = lima_sched_run_job,
>         .timedout_job = lima_sched_timedout_job,
> --
> 2.7.4
>
>
