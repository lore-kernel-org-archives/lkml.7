Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E95EFC4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 11:57:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACB732083D
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 11:57:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dMhcgLXP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732307AbfB1L5B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 06:57:01 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:33936 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730976AbfB1L5B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 06:57:01 -0500
Received: by mail-lf1-f66.google.com with SMTP id u21so15055787lfu.1;
        Thu, 28 Feb 2019 03:56:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L8fcmR+rQmEReDcuYpUYxW0tKYPUtWoev1VscFLxHis=;
        b=dMhcgLXPtaIJ8dCC63OVyx+y559roriUbGChDiEyK76D9mm2mvpV+Mr47Uzk5F5zBs
         V79QA6AXgTBm3/Ww/X0wjRbY6VmTWxxftRvCDpAk7zBPU2BXSGgkwd1hYK04SUoFKST6
         M/Qt5bDlNhN07ksiqepq8iSHE2zJGTK+IagegRaVbteW3txRORTNC9u1GFiBBE/iM0Hb
         QcCzKZKLj1dHRkjUh4tRAu5Qmu/tmLb6SGUAKqrxPOX5rOltee5eSX0J5u/tHAGLby/z
         VGgC7v+aZIqB4j0LdHlVwBw0IRklfOgpgW5TxMI9bdSRjYfdjwUaIAS89bu9kHfh+rDh
         PRRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L8fcmR+rQmEReDcuYpUYxW0tKYPUtWoev1VscFLxHis=;
        b=fqVFGUPC4K1/kefFDKuu5XdikIhU+PJJ5qPwZHscOxyUD973SeH0gsJ+h2c6nboVvz
         Fxfds6lvKdLBvIoB1LSGATH+RNFDO+hwbCc5sAJXCxGMC3zja/L0y2LYbqY9wszWVZEX
         /LkZbGKX6UQwhefOF8mCXIC+5rxRjecfBafaKV6B1Fk2dBK59OP9JEGmwmhX1XEOfLKs
         7fdpSF1WOtBL1dNl/vM5Buvf5phTTsjECAeIaAyx1iimCs8gsiK/R1MYRUaCaSWiX8Df
         P5iugIA+5uGG/VkUGuSKYgcjiO7OuUE0dpyC+Z00Kns1sYXx15KCG4MCfbjbQYhJBP/C
         3KiQ==
X-Gm-Message-State: AHQUAuZNhDwnBgknZrp5qocuZYnGBMbGu7N8wlskAFrptx08XMIjqLGT
        /NcOj6qtYpvh365nTPq1nFJAHSr2kUMGlRM3Vw/PFw==
X-Google-Smtp-Source: AHgI3IZo8k///89/y1o5lt4Dv2UZF+8R6z+ujfCV+8pMmu7ktTjftmdf3Qt0yw7jC+Wn+++nskhpoD55vdAj2sX3Luk=
X-Received: by 2002:a19:ab19:: with SMTP id u25mr3993927lfe.64.1551355018788;
 Thu, 28 Feb 2019 03:56:58 -0800 (PST)
MIME-Version: 1.0
References: <20190227205242.77355-1-cai@lca.pw>
In-Reply-To: <20190227205242.77355-1-cai@lca.pw>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Thu, 28 Feb 2019 17:26:47 +0530
Message-ID: <CAFqt6za55vjCHvmk3smZYQ2cGLTsTyAcs6B1SLwCoYcm+XSiSA@mail.gmail.com>
Subject: Re: [PATCH] memcg: fix a bad line
To:     Qian Cai <cai@lca.pw>
Cc:     hannes@cmpxchg.org, Michal Hocko <mhocko@kernel.org>,
        vdavydov.dev@gmail.com, cgroups@vger.kernel.org,
        Linux-MM <linux-mm@kvack.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 28, 2019 at 2:22 AM Qian Cai <cai@lca.pw> wrote:
>
> Miss a star.
>
> Signed-off-by: Qian Cai <cai@lca.pw>

I think, the change log is too short and could be little more. Otherwise,
Acked-by: Souptick Joarder <jrdr.linux@gmail.com>

> ---
>  mm/memcontrol.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index af7f18b32389..d4b96dc4bd8a 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -5747,7 +5747,7 @@ struct cgroup_subsys memory_cgrp_subsys = {
>   *
>   *             | memory.current, if memory.current < memory.low
>   * low_usage = |
> -              | 0, otherwise.
> + *            | 0, otherwise.
>   *
>   *
>   * Such definition of the effective memory.low provides the expected
> --
> 2.17.2 (Apple Git-113)
>
