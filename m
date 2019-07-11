Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 449C6C74A35
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 12:32:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 212C421019
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 12:32:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728745AbfGKMct (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 08:32:49 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:46096 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726016AbfGKMct (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 08:32:49 -0400
Received: by mail-yb1-f195.google.com with SMTP id a5so2350587ybo.13
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2019 05:32:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lkQSW2h0iXLjTSd5ILkhnZgCGuqtxkGt45lWjKrJ0P8=;
        b=c2l+ZdyqtT8erB8ILKURVf/BAV6MfNQuQhF/AjI6mJyLMbrOgSgUcwqkFWA8FBa3nz
         JCXP3UwJ7rk79FAhIRxgbj+s3JsL6zhqxsrU5FCbF4zVdxF90NdH5mUdKPZbw4RBDufq
         vfTs+JDl4KYi6/xjjSHJYaDQW1PQD0P8vAH2SkcyoLFbjWFJQER56a9TkJndlWTKs9dt
         8LJ6kynTylDBbtrICKG955EdK4IZh9ZFHbYlG0L3rVJ4yXQcVrlgYyZTOURDd18FtehB
         XGFLierpHDZdE4zWvVAtbp/JdeZIB7mWpU7HpWT6p35KdY2YJrD5YWypiot6h/tFz2eQ
         G0gg==
X-Gm-Message-State: APjAAAVah3fAnVkUeZ1+u/qIuEpOTHAmiFoRASN+4Du4vd1cXWXemMCy
        lbEi07D+exmYICrlMtGe4x7tP0SB6ddMfDwRYgc=
X-Google-Smtp-Source: APXvYqynY8RMZ9Wxy9Rwh28rwHMVMIpmQmLHEAoQlPw9FDnKFSiCzIcdGWSJcxulJB/Dpu+m1RGmtYXPP9usyK10Fyw=
X-Received: by 2002:a0c:b88e:: with SMTP id y14mr1844541qvf.93.1562848368471;
 Thu, 11 Jul 2019 05:32:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190711112619.57256-1-wangkefeng.wang@huawei.com>
In-Reply-To: <20190711112619.57256-1-wangkefeng.wang@huawei.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 11 Jul 2019 14:32:31 +0200
Message-ID: <CAK8P3a3M3cNZm4meO+_vPkJcjtq7Fu5SrnJ11FAkOtGW3WBvNw@mail.gmail.com>
Subject: Re: [PATCH] hpet: Fix division by zero in hpet_time_div()
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Clemens Ladisch <clemens@ladisch.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 11, 2019 at 1:20 PM Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
> The base value in do_div() called by hpet_time_div() is truncated from
> unsigned long to uint32_t, resulting in a divide-by-zero exception.

Good catch!

> --- a/drivers/char/hpet.c
> +++ b/drivers/char/hpet.c
> @@ -567,7 +567,7 @@ static inline unsigned long hpet_time_div(struct hpets *hpets,
>         unsigned long long m;
>
>         m = hpets->hp_tick_freq + (dis >> 1);
> -       do_div(m, dis);
> +       div64_ul(m, dis);
>         return (unsigned long)m;
>  }

This still looks wrong to me: div64_ul() unlike do_div() does not
modify its argument, so you have to assign the output like

       return div64_ul(m, dis);

       Arnd
