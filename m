Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FF26C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 02:42:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FABC2075B
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 02:42:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dN0SwqMO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731034AbfDQCmZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 22:42:25 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:35010 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728108AbfDQCmY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 22:42:24 -0400
Received: by mail-it1-f196.google.com with SMTP id w15so2088135itc.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 19:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qnGx+7684eAFRW7SlWLhhsj9k/GSxSFnEr2CP+sGGGQ=;
        b=dN0SwqMOuhUzMzZZPCz2HDl6oy6o7Xq+AywL7EZcBAmG/9GwdBJuR9FRLKAesNFxZx
         sdNQE5vT9ISdraFuu6/n8roQPwx3Qx2NYbf9oIw3bD7v3vwZCkfkcq+m4MHcLRNbsYZd
         j+M9IXIY+EuUjatzkAI7KyC84EiKkCI9XgM6KfeOMRZS+dUUYgqnG51yVifL8nlT2s8A
         kmozne3CsW0afUmeXuzrTtid75X/JVmQ+GybgRJ++DBQcK5+VSFGPCztwqTNY4ekiDUU
         70f4abp1ZaFiU0Exo9CPCYNfc735m3VptWZwU87GwwINU0DkTjJrvPOpjXXk6+Ygo3P8
         A0Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qnGx+7684eAFRW7SlWLhhsj9k/GSxSFnEr2CP+sGGGQ=;
        b=M5dv6UqekETmyB4B60oyCYAlB+c6/XPFQHJ/wHWpBf64a4sflR7DAQNrJfxgX+as/j
         mp12cr45fW7r1I5vc5cnSw49H1uDdUcB6t/Vkb2ZD1axOl8hEUFSxmrmEMeu0TR8SWmB
         Uld9NcpUsQx7/2BNT6UYhIUXblIGHBc80AZXFe9RUqobI9EA9DNyXjjsRKtWtPZmuNAF
         yDog+nEp13zpNaW37C6phVMn1s4zTDi27uKmb8fBYMX8NkAiYWqy9t1/OzQtKaN2AgDv
         XxCWO3A5CollnpAvQtK5zuMEY5dRmqcJNI4W7noQXLqxh9vwmG62PnUr97lJ0GEarD0Q
         PcDA==
X-Gm-Message-State: APjAAAUZ0qURkgYI5MDNhg3TFcyrzZs4ZZiThK9s4iug9dQwY+ONPlyK
        SvRMowcN2UnXH6YJIx5CknHj35oHCgh/N4DZkEY=
X-Google-Smtp-Source: APXvYqwCO3z++7DU3EBPgVyxcl8TU2oF0T/3n9FzuELK03VKHRm6fbVg8ouRv2a4Z0h69f4QuWVjodTDWMZbFoz9/ps=
X-Received: by 2002:a02:90c6:: with SMTP id c6mr55903739jag.117.1555468943784;
 Tue, 16 Apr 2019 19:42:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190416144353.34024-1-yuehaibing@huawei.com>
In-Reply-To: <20190416144353.34024-1-yuehaibing@huawei.com>
From:   Qiang Yu <yuq825@gmail.com>
Date:   Wed, 17 Apr 2019 10:42:12 +0800
Message-ID: <CAKGbVbu9GZeuLo1bjaT9cRqyR=bVU1GNLqJef0OKHq7pB9CZrg@mail.gmail.com>
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

Thanks, patch is:
Reviewed-by: Qiang Yu <yuq825@gmail.com>

I'll add a "Fix" tag and push it to drm-misc-next.

Regards,
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
