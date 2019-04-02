Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CAB6C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 01:30:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB01220857
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 01:30:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cuPzSY91"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728706AbfDBBau (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 21:30:50 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:35580 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726269AbfDBBau (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 21:30:50 -0400
Received: by mail-yb1-f196.google.com with SMTP id e12so2971545ybq.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2019 18:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LMmHnsyk1uzErZTal3hpzoJ7pmyomf/Ka/UtU2wsd0o=;
        b=cuPzSY91m+js46LcvwGX0n1oIZqplsgZtmeAIXgpdgZ3C0mGIOOkTjXeVND8OnWYkk
         RImlPbyVN8MEWDlrto7av4GppIivPvntrKhA7dLmfkpoRCB+eUlptIF+50a6LHLMI9oN
         Q06j8c0n1lch5bV2IDshN1NCQBxoJT+OkZOzfjEixw7ISNNJwcW1Tu04IbNgvVCm0EAo
         gYjU7sRjzVd/a/4q5XupAMftB3PY8G9UsE+HgPp8dX41IOk30AUC2YHECK4VLvP9xE+P
         LcIB1//o0mg+6rBFsuOSsu3jc43iGKSCJf8RgqjuZMsBxcKca2qFRslZguX+WnH3hF9A
         M+Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LMmHnsyk1uzErZTal3hpzoJ7pmyomf/Ka/UtU2wsd0o=;
        b=NpJ+/vom6rzq4xUDyuS5G7Urtg3qgxHbPhRgc2y/1OgY9Cy/Fr9admQhrn/MZE7Hbd
         Wd+OSmYMLQ49b0UJBxlZSNBt0NgBVaMif379L2dE7C0/dYlmJS6Gt/Y9aIVZVlBBFSZ2
         zNXgGN3xEBmy7QzLQBA6umMe+qZFfboICir2qkeDOKbLdoXEB04csv/7JtU8Q8nu56Lh
         QczUP5eB7gHGk0GIaAd60yiJuqYbUIsIY0fFMK8CCJa+LBKCPVbhBL0a+CIVNy1X5tTw
         8N9PFxhdKMY5QLDbOrhZ6yoBrW2FxpCcH9EgvAtUiL6b077lbb6j1tJOQo7eleeGhqp3
         fDDg==
X-Gm-Message-State: APjAAAW7q6zWYjO+95koyeVtXoguAqkebrHpq06+l7bLDrOlw8cfyhyc
        Cxf+O3MEWJulFn3tcOlu+XqpQxNa07EEyCCHdGc=
X-Google-Smtp-Source: APXvYqzPvU3Af9M5tFKfdGatYA3rSJUZUkQQB4Tqm4TWz7SramheZWAFIKLqxn645U34ReO20G+QjXzqP3a80Rs0vDc=
X-Received: by 2002:a25:e601:: with SMTP id d1mr12610571ybh.265.1554168649437;
 Mon, 01 Apr 2019 18:30:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190328080918.9290-1-tsu.yubo@gmail.com>
In-Reply-To: <20190328080918.9290-1-tsu.yubo@gmail.com>
From:   Bo YU <tsu.yubo@gmail.com>
Date:   Tue, 2 Apr 2019 09:30:38 +0800
Message-ID: <CAKq8=3KUFgVzTbaQhSHbKQGPDafHPt28rHW=+D+2CDZeDsfSnQ@mail.gmail.com>
Subject: Re: [PATCH v2] drm: etnaviv: fix strncpy sizeof argument
To:     l.stach@pengutronix.de, linux+etnaviv@armlinux.org.uk,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        airlied@linux.ie, Daniel Vetter <daniel@ffwll.ch>,
        open list <linux-kernel@vger.kernel.org>
Cc:     etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        =?UTF-8?B?5LqO5rOi?= <yuzibode@126.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 28, 2019 at 4:09 PM Bo YU <tsu.yubo@gmail.com> wrote:
>
> Calling strncpy with a maximum size argument of 64 bytes on destination
> array "domain->name" of size 64 bytes might leave the destination string
> unterminated.
>
> Detected by CoverityScan, CID# 1443992:  Memory - illegal accesses (BUFFER_SIZE_WARNING)
>
> Fixes: 9e2c2e2730126 (drm/etnaviv: add infrastructure to query perf counter)
> Signed-off-by: Bo YU <tsu.yubo@gmail.com>
> ---
> v2: accroding to Russell's suggestion, replace strncpy with strlcpy
> ---
>  drivers/gpu/drm/etnaviv/etnaviv_perfmon.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_perfmon.c b/drivers/gpu/drm/etnaviv/etnaviv_perfmon.c
> index 4227a4006c34..ce178f23e86a 100644
> --- a/drivers/gpu/drm/etnaviv/etnaviv_perfmon.c
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_perfmon.c
> @@ -414,7 +414,7 @@ int etnaviv_pm_query_dom(struct etnaviv_gpu *gpu,
>
>         domain->id = domain->iter;
>         domain->nr_signals = dom->nr_signals;
> -       strncpy(domain->name, dom->name, sizeof(domain->name));
> +       strlcpy(domain->name, dom->name, sizeof(domain->name));
>
>         domain->iter++;
>         if (domain->iter == meta->nr_domains)
> --
> 2.11.0
>
Ping?
