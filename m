Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF082C10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 07:08:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DBD421848
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 07:08:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="nACueev+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727995AbfJCHI4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 03:08:56 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:40700 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725879AbfJCHIz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 03:08:55 -0400
Received: by mail-io1-f66.google.com with SMTP id h144so3104533iof.7
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2019 00:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MJcg8zs78d3rXBpOETE+0j+ZuAl6FfPdDEzxoa0/CIM=;
        b=nACueev+gvO9mg6+kv1iNYsTn/JE4CpNo2ZDPqlFFMewbPYZuyhqh+JsqDzfu+L5Q0
         G+AcFl0zPkVgkkKTRCM+7KwBBBHh02sUORkOzzEY79ofQJI2HdySEGQOecxJIFanfVRk
         L6f6wnSuchiE7pN6azWsIbtOZgr+hYD6XZ1jg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MJcg8zs78d3rXBpOETE+0j+ZuAl6FfPdDEzxoa0/CIM=;
        b=CZszxZjOY+oEgUqhFGdGM21jG/TbPuWJnBarain8PS9i2vRZmtZ6NyakbKPyodMxat
         4boucWCc0PUNV8Qn+z/h1UJqFW1KZWYsUgqjle1EAO7I3ISYPSUH9pbU6KYgq9uQTIIs
         hFboVehIaEt4xFMhLY0HS0DBNtcU/zSZWongBp7fHTFXwKF3I9VJocQdtn8LB4wKJfcy
         GGVKPE0yXLzGvO3FgDDPPRPkKZ99Bkh02i72mcIwC57YqxCynIaxSYeUJFe+FYlDkxA6
         KYMmoJ1SgUkEn8kWHnQdpNlJgcKLrszf78lL6+rbj41g2f+7s9NeNiyws+QoLLjq745T
         UJJA==
X-Gm-Message-State: APjAAAVLGOqk/pbqPnlyPhNeYfh+3i4Xw9ZBZY5abTL3/ifca4g9jHOx
        a2t8s5uNcTyIfaotF+zvEYb1pTBDpTclD8VDWaGtOQ==
X-Google-Smtp-Source: APXvYqyiHoQKtNpYFtcrgyC7ulZRFo5mIyezyvwwYkMn+/z8HGvh/7OVxThakVCi9reOehN1EsA8FIXbO7De8LVxF2E=
X-Received: by 2002:a02:ce5c:: with SMTP id y28mr8189675jar.79.1570086534678;
 Thu, 03 Oct 2019 00:08:54 -0700 (PDT)
MIME-Version: 1.0
References: <20191001080253.6135-1-icenowy@aosc.io> <20191001080253.6135-2-icenowy@aosc.io>
In-Reply-To: <20191001080253.6135-2-icenowy@aosc.io>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Thu, 3 Oct 2019 12:38:43 +0530
Message-ID: <CAMty3ZCjrM4MajJLyLwt-31mNnfVWghwatogtwVOvCt4gY0LZA@mail.gmail.com>
Subject: Re: [linux-sunxi] [PATCH 1/3] Revert "drm/sun4i: dsi: Change the
 start delay calculation"
To:     Icenowy Zheng <icenowy@aosc.io>
Cc:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 1, 2019 at 1:33 PM Icenowy Zheng <icenowy@aosc.io> wrote:
>
> This reverts commit da676c6aa6413d59ab0a80c97bbc273025e640b2.
>
> The original commit adds a start parameter to the calculation of the
> start delay according to some old BSP versions from Allwinner. However,
> there're two ways to add this delay -- add it in DSI controller or add
> it in the TCON. Add it in both controllers won't work.
>
> The code before this commit is picked from new versions of BSP kernel,
> which has a comment for the 1 that says "put start_delay to tcon". By
> checking the sun4i_tcon0_mode_set_cpu() in sun4i_tcon driver, it has
> already added this delay, so we shouldn't repeat to add the delay in DSI
> controller, otherwise the timing won't match.

Thanks for this change. look like this is proper reason for adding +
1. also adding bsp code links here might help for future reference.

Otherwise,

Reviewed-by: Jagan Teki <jagan@amarulasolutions.com>
