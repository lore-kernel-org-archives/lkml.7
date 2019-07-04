Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB24CC0650E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 05:50:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8366521882
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 05:50:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ph2soGqA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727160AbfGDFuW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 01:50:22 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:35790 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbfGDFuW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 01:50:22 -0400
Received: by mail-vs1-f66.google.com with SMTP id u124so1264418vsu.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2019 22:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TNj8Am5UXGLoiXxYPyOV6TXKP3Pj9OzQjZH9m5seI/U=;
        b=Ph2soGqAZJYBe073IIotpxCUKWW0L9T5aeVan9RW3PwIV1hYcJCDktWMeUWEHn6t2L
         DcjAide/x/YaaLHihXcmq5oc6BKu9gGxRGp9h13RPs3rILxjI2fPD80SSQ7S1uXatYSA
         hfmmN0F0LS1AcJ0Xce/8mM9jMeSPqtLGtvlp0rR3gUZOydxmGw6m2VKccXt9HpTcVL+W
         QQsLiclXhfSpk9WUAunywdQlv7gn5SCfwfPXStlT/pjmU6SVaRk5BeaLayH3QqsV9laY
         fYe3IjjUXaKZ+DWU0GgL2kDDGEbttfH7tDZcUmm4hoY+fVn75jOdGVvIi3x52o05HKjG
         GD0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TNj8Am5UXGLoiXxYPyOV6TXKP3Pj9OzQjZH9m5seI/U=;
        b=S1UBMyIugzRmwNb55UNzrgH046PZ3tzeJA3f33d77UVuTDRpmqjS7TDqOhVPt/rukN
         YJFg9NZgIpTUia1GISpugYwBMbug5NDmX8+js7YqqFI4LzFqMwyFpXrqUc3q1GM5ysmq
         2r++PxCtmBT6laSZsle+Y0IbFu/49MV3lLtUUHd/yQhEuzPlVeBcMZZclZrcicdyF//S
         OYqmKWuYJO6PmnW3mAOMu81c1ugX1Y8S9nAIFtyQwyCLLXUkbFbx1LuIAbqa135Zu+8d
         XU2F3pnsTbdP+LdA4nbxdgvATl8GSEqneGv7yQKtsw+JVQBHLQxUPHgxITUc4KCSJbsm
         Pdhw==
X-Gm-Message-State: APjAAAWPhUfQsXUyT/Pi6uZ5487rZgDz2+1SIHhABAC2BHDQANC7U2t4
        upDrv9cGvKUMMqsNt1Xsxea53P//+Dqhwow5DsQ=
X-Google-Smtp-Source: APXvYqzzCr04x1Z85t6PbnuGJpYy2/K3hgA93DC+JpgDZ8qLSkOiq+Xv1YXShYOs6qw8i6YHBftvD73Q8gmNHgnH0VA=
X-Received: by 2002:a67:bb03:: with SMTP id m3mr20897325vsn.84.1562219421096;
 Wed, 03 Jul 2019 22:50:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190701014622.13199-1-yongxin.liu@windriver.com>
In-Reply-To: <20190701014622.13199-1-yongxin.liu@windriver.com>
From:   Ben Skeggs <skeggsb@gmail.com>
Date:   Thu, 4 Jul 2019 15:50:10 +1000
Message-ID: <CACAvsv5b2D4SSz0OTWS6gygs5+guc5cdWeBWCiJ2bqXu-RP=wA@mail.gmail.com>
Subject: Re: [Nouveau] [PATCH] drm/nouveau: fix memory leak in nouveau_conn_reset()
To:     Yongxin Liu <yongxin.liu@windriver.com>
Cc:     ML dri-devel <dri-devel@lists.freedesktop.org>,
        ML nouveau <nouveau@lists.freedesktop.org>,
        Ben Skeggs <bskeggs@redhat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Jul 2019 at 12:37, Yongxin Liu <yongxin.liu@windriver.com> wrote:
>
> In nouveau_conn_reset(), if connector->state is true,
> __drm_atomic_helper_connector_destroy_state() will be called,
> but the memory pointed by asyc isn't freed. Memory leak happens
> in the following function __drm_atomic_helper_connector_reset(),
> where newly allocated asyc->state will be assigned to connector->state.
>
> So using nouveau_conn_atomic_destroy_state() instead of
> __drm_atomic_helper_connector_destroy_state to free the "old" asyc.
>
> Here the is the log showing memory leak.
>
> unreferenced object 0xffff8c5480483c80 (size 192):
>   comm "kworker/0:2", pid 188, jiffies 4294695279 (age 53.179s)
>   hex dump (first 32 bytes):
>     00 f0 ba 7b 54 8c ff ff 00 00 00 00 00 00 00 00  ...{T...........
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace:
>     [<000000005005c0d0>] kmem_cache_alloc_trace+0x195/0x2c0
>     [<00000000a122baed>] nouveau_conn_reset+0x25/0xc0 [nouveau]
>     [<000000004fd189a2>] nouveau_connector_create+0x3a7/0x610 [nouveau]
>     [<00000000c73343a8>] nv50_display_create+0x343/0x980 [nouveau]
>     [<000000002e2b03c3>] nouveau_display_create+0x51f/0x660 [nouveau]
>     [<00000000c924699b>] nouveau_drm_device_init+0x182/0x7f0 [nouveau]
>     [<00000000cc029436>] nouveau_drm_probe+0x20c/0x2c0 [nouveau]
>     [<000000007e961c3e>] local_pci_probe+0x47/0xa0
>     [<00000000da14d569>] work_for_cpu_fn+0x1a/0x30
>     [<0000000028da4805>] process_one_work+0x27c/0x660
>     [<000000001d415b04>] worker_thread+0x22b/0x3f0
>     [<0000000003b69f1f>] kthread+0x12f/0x150
>     [<00000000c94c29b7>] ret_from_fork+0x3a/0x50
>
> Signed-off-by: Yongxin Liu <yongxin.liu@windriver.com>
Thanks!  Got it.

> ---
>  drivers/gpu/drm/nouveau/nouveau_connector.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/nouveau/nouveau_connector.c b/drivers/gpu/drm/nouveau/nouveau_connector.c
> index 4116ee62adaf..f69ff22beee0 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_connector.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_connector.c
> @@ -252,7 +252,7 @@ nouveau_conn_reset(struct drm_connector *connector)
>                 return;
>
>         if (connector->state)
> -               __drm_atomic_helper_connector_destroy_state(connector->state);
> +               nouveau_conn_atomic_destroy_state(connector, connector->state);
>         __drm_atomic_helper_connector_reset(connector, &asyc->state);
>         asyc->dither.mode = DITHERING_MODE_AUTO;
>         asyc->dither.depth = DITHERING_DEPTH_AUTO;
> --
> 2.14.4
>
> _______________________________________________
> Nouveau mailing list
> Nouveau@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/nouveau
