Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23727C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 18:32:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E56E520657
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 18:32:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HZ9Mj6kr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727362AbfCKSc0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 14:32:26 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33460 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726641AbfCKScZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 14:32:25 -0400
Received: by mail-wr1-f68.google.com with SMTP id i8so16461wrm.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 11:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FFJcWlvldHTmrlLPlzcIYgOszRXJkvCIhv8XHtPEruQ=;
        b=HZ9Mj6krz57s8G7uD+uO5HFkG/G8hfOqNuSFBog1yIJzT8RAhOq0XUh6dY+ok4iNfl
         W7h5tfqsvloH+p5NKcY8GnptDqJuWq+WPE5OD0MKQnwh8Blp7OsLmZMq6Ctyudw9ZdH9
         FVu6NnML0fhRcz5s5sy1DO9JA+3LpdGaypUaNu7swd8rCCVVW+G+QNSb3whTq1u+gVFy
         jH8E7QSIiB5zI+7FUspeeQgRmKLEplrVVddGYsKMZksyulfOVy7mJF2GUMJFo4X3RVRt
         9+D1tmiHaRBqXJI12NIfZJDEvWxz1jT59A2TIYrL0WMWOnoa9+54suEVu2oPCmGBlZgG
         bnzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FFJcWlvldHTmrlLPlzcIYgOszRXJkvCIhv8XHtPEruQ=;
        b=hWFBpd2V4xbWI++3htVe1WRqJVe4trkoo8UFAofmTTZUT3ENaZttxIR1GKtf4TyL2F
         sRnhjeTPzLmNTXxIrpb18DpgLHsNIs2F4B/vl4c7fKrpyXV+mLF9Vq413zus+59r74/R
         YHZfSutOcmsi53EZMgRg0aaIeUgwhFU0Ifue1Qw6FUCr5Iz0aVQBaDPNi/aa1r/xqAKe
         Vywg1r9wFgzDOpV9ezb8uf9bYJ0H8TWdBc++cAV7l4nYfPKXN8I9WI5YEWzRZJ5HsGdZ
         GQLhp7t3IwUxMDRzlEgF3oWAG+oLB76ZE2mKvsuAzBHm0OV5ztZZiTTcZXbTpB9ZP4D3
         Q/YQ==
X-Gm-Message-State: APjAAAWHR0KNg16Y740SVxsuXDQF+O+5HxgrWoyNWMeJTDWESxx6vj53
        M4+zHa+zu9lE9I2XLbyR0GH7+mUA06Cy3TLm+VI=
X-Google-Smtp-Source: APXvYqyXBtN3KhtnvCk+rGNkx06i80eIHigKztUlVTCpuJ1oE3S8LGRUOQUGwkVbuTc8lwGd7dlSd3d1hb6L/IqS7VE=
X-Received: by 2002:adf:e548:: with SMTP id z8mr21787507wrm.52.1552329143965;
 Mon, 11 Mar 2019 11:32:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190226193609.9862-1-andrew.smirnov@gmail.com>
 <20190226193609.9862-7-andrew.smirnov@gmail.com> <20190304123300.GH6325@pendragon.ideasonboard.com>
In-Reply-To: <20190304123300.GH6325@pendragon.ideasonboard.com>
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
Date:   Mon, 11 Mar 2019 11:32:12 -0700
Message-ID: <CAHQ1cqGF8P=GukzGpHz3u=m0nXbrQk1_7qpZZSa=j36MDvv7TA@mail.gmail.com>
Subject: Re: [PATCH 6/9] drm/bridge: tc358767: Simplify error check in tc_aux_linx_setup()
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     dri-devel@lists.freedesktop.org,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 4, 2019 at 4:33 AM Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> Hi Andrey,
>
> Thank you for the patch.
>
> On Tue, Feb 26, 2019 at 11:36:06AM -0800, Andrey Smirnov wrote:
> > Tc_poll_timeout() can only return -ETIMEDOUT, so checking for other
> > errors is not necessary. Drop it. No functional change intended.
>
> Is that true given patch 1/9 in this series ? regmap_read_poll_timeout()
> can also return an error from regmap_read().
>

Ugh, I misread "?:" in regmap_read_poll_timeout() code as "?", this
patch is incorrect. Sorry about that, will drop in v2.

Thanks,
Andrey Smirnov
