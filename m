Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A52B7C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 11:09:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7058620857
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 11:09:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T+Od9APY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727623AbfCSLJT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 07:09:19 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:32914 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726573AbfCSLJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 07:09:18 -0400
Received: by mail-yw1-f66.google.com with SMTP id a199so15517800ywa.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 04:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xoYjlvnioKJdWjqh1fvscub8avvNRWXM6KyaAxS+5ew=;
        b=T+Od9APYbZT9h/NEKbYlrQhou6AMOsZa/xmnW11fAy0KEOadOuBQH2SaA6+A3zQzGG
         c0EpmwMryptK8xs/grj4Onw8qlfnDv3wtJac3o14Isjcb8bR6sODgbA9FSMPjrEthOhC
         CxiVnyq9lrYrorvxcQQvShoiVbBDzQuporOZQztCraT38jkF8uvPr4ueXUDYEshU+G08
         vKc+1ckrrkBQ8rt4qU1S2MegT94p8mh9YmwgkobF3lU/4FahbXNTUp3KTX5qKdh+qhHq
         uCYpsIFZkQKsZuWBPtQH5a1JDSj78tWfVp5dUsRReRBZKhY+QcoH+wWk+NLH6RMbxv/8
         O6Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xoYjlvnioKJdWjqh1fvscub8avvNRWXM6KyaAxS+5ew=;
        b=YyCBKRmJgbifxq0jNiXmEIdZFYGApvDxs7MdWbyGZfwKx+xloWVx9Dp74xkYKf8eiu
         jtky4Vb52WIguX5WE8sgqJ0EYxmJJSuv/W2r9t0mmOtG2rwZm3bWzGQZU7nei+RJvyjc
         E4TNirRV+viF16uMV1j6/0OaBGI3xbyEdeLo9OL4zaA58O/2vY/xZcgH/kykocxx8qI4
         iKJn8rs+yhQ8QSxPQVmjrGP98gae4YFBjMgQTvwKpgltIs6p8POEpTvLqyuQLLYAaJCD
         /X4P2htSz+PXtv3WBWc2XyNVmj/FwLSDnjQmdTL4AY0XVWswXrmS0LChGmFX76ghD5tX
         svhQ==
X-Gm-Message-State: APjAAAVteiqTqRvR7qD/NFGpGupL5u6D3RvaYk60fzIFB9clHWK9vOD2
        M8Ue7wj2uuc+WTwp9RPwKH4hRhp7VXXHNxa4Fn0=
X-Google-Smtp-Source: APXvYqytYlM3MCbBRqXUC3DiS+Lax0NJ8O7bmJLdVp7nj5h0ct5OMV7jdBzpel8C5dG2JQe7AcGDsfJCFQ2TS184hdU=
X-Received: by 2002:a25:2d6b:: with SMTP id s43mr1359991ybe.68.1552993757842;
 Tue, 19 Mar 2019 04:09:17 -0700 (PDT)
MIME-Version: 1.0
References: <20190319025755.15394-1-tsu.yubo@gmail.com> <20190319102216.ylrkd6vxm77pq553@shell.armlinux.org.uk>
In-Reply-To: <20190319102216.ylrkd6vxm77pq553@shell.armlinux.org.uk>
From:   Bo YU <tsu.yubo@gmail.com>
Date:   Tue, 19 Mar 2019 19:09:06 +0800
Message-ID: <CAKq8=3JYGYWOnJYaQg5eguMjTo2c+dcCdj0WcKp+t4Oy=eYUFA@mail.gmail.com>
Subject: Re: [PATCH] drm: etnaviv: fix strncpy sizeof argument
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     l.stach@pengutronix.de,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        airlied@linux.ie, Daniel Vetter <daniel@ffwll.ch>,
        etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        open list <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?5LqO5rOi?= <yuzibode@126.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 19, 2019 at 6:22 PM Russell King - ARM Linux admin
<linux@armlinux.org.uk> wrote:
>
> On Mon, Mar 18, 2019 at 10:57:55PM -0400, Bo YU wrote:
> > Calling strncpy with a maximum size argument of 64 bytes on destination
> > array "domain->name" of size 64 bytes might leave the destination string
> > unterminated.
> >
> > Detected by CoverityScan, CID# 1443992:  Memory - illegal accesses
> > (BUFFER_SIZE_WARNING)
> >
> > Fixes: 9e2c2e2730126 (drm/etnaviv: add infrastructure to query perf counter)
> > Signed-off-by: Bo YU <tsu.yubo@gmail.com>
> > ---
> >  drivers/gpu/drm/etnaviv/etnaviv_perfmon.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/etnaviv/etnaviv_perfmon.c b/drivers/gpu/drm/etnaviv/etnaviv_perfmon.c
> > index 4227a4006c34..08ca3c44be48 100644
> > --- a/drivers/gpu/drm/etnaviv/etnaviv_perfmon.c
> > +++ b/drivers/gpu/drm/etnaviv/etnaviv_perfmon.c
> > @@ -414,7 +414,7 @@ int etnaviv_pm_query_dom(struct etnaviv_gpu *gpu,
> >
> >       domain->id = domain->iter;
> >       domain->nr_signals = dom->nr_signals;
> > -     strncpy(domain->name, dom->name, sizeof(domain->name));
> > +     strncpy(domain->name, dom->name, sizeof(dom->name));
>
> This introduces an overflow bug if sizeof(dom->name) >
> sizeof(domain->name).  If both sizes are the same, then there is no
> effect.
Oops,It seems more worse than original code.
>
> strlcpy() would be a better replacement, it guarantees that the
> destination will be correctly terminated.
But there are too many strcpy like usage in kernel, Does it matter?
>
> --
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
> According to speedtest.net: 11.9Mbps down 500kbps up
