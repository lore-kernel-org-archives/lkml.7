Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E18A5C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 21:43:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA470205C9
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 21:43:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="cCLg3bRH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730429AbfCYVnL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 17:43:11 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:38735 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730354AbfCYVnK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 17:43:10 -0400
Received: by mail-ot1-f67.google.com with SMTP id e80so9551819ote.5
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 14:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v9f2CUwkY0ehsf5GIhAe8PIU0OAiB6iscR24tZqHS9U=;
        b=cCLg3bRH/Dy3O0z+d50AG1M5DOB/nWHE3BZZ3HHa5R4n4reZu85uIYiHGaD8zve3Ch
         xZSWKRPMXCABbPLm08SNYOQJE6c+582dHw90hmHzgQKvCm4yQA4HzyIN4PW/tJFqnY61
         3Nrb6zATKnI3DnAsIXemyZlXaD2v7awzk4i80AKcFbjBkIV9M2spVewZZwXQckXAoZOY
         ey9IBf9Mexn7YL/5YX09wFO2d3NeDAWLapFGNv+f1tiDk2bBJmfLw1PLljmIV4jLS8+o
         2qjGNP61955Lj/FvX+yoI717svfRKiFljjad67gAfZqYIOq69/CuUpQHpTGh9vUda6qq
         CtaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v9f2CUwkY0ehsf5GIhAe8PIU0OAiB6iscR24tZqHS9U=;
        b=ILVZ+MlJrMvBbe3k7QuDz/dP7GGMJwZSWgx0gLCpgKQl8e8ntijhmNhXYg3+22Q9QI
         vw1CS8RUERBEa11lf+vlgq3tbh1N7pIwAhJxpIrQvRL+M7YtCVD2sr5WQBSNb8RrZXiE
         5Vu9IwmZyuMnoUHwXOyuTqFT84GpAnnw/a0TROsuKOotybXbkmATNzKgH97gEjfI3PyA
         GAPmdqyd5HLYO+GaALm1qs+fz+Aog0g6hfxUtPIgpXiUMzMrNwXK/hDb7mO2q08mJVUh
         rDL22HjMK9qNh4QXzypnkT+nS84e1u9R0j4YYv8OsDXfbbsEuguqvpRqkP0AXCaaJVEk
         vMxQ==
X-Gm-Message-State: APjAAAXd5+8OKaydco+FiaesOb1CBHFJhWF6iGIK5ngBTibIjyd2SeXo
        /BJRx8KDhmB+p5DLSXqv/lQCIywMk7EGSzZgTOkb9w==
X-Google-Smtp-Source: APXvYqy5YaeuqzJk/0uk0tzksj7I/Vhk0P7QPZBmxan9qRap3s6Efg8NYXZQ4v1fftwN1b0oAkddcjOg0RqyYvw2Ov4=
X-Received: by 2002:a9d:224a:: with SMTP id o68mr20484188ota.214.1553550189891;
 Mon, 25 Mar 2019 14:43:09 -0700 (PDT)
MIME-Version: 1.0
References: <20190325213618.12139-1-pakki001@umn.edu>
In-Reply-To: <20190325213618.12139-1-pakki001@umn.edu>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 25 Mar 2019 14:42:58 -0700
Message-ID: <CAPcyv4jEgTsG5eR0siz71qytcEa7crhm4TpfFzUASoJM3bupiA@mail.gmail.com>
Subject: Re: [PATCH v3] nvdimm: btt_devs: fix a NULL pointer dereference
To:     Aditya Pakki <pakki001@umn.edu>
Cc:     Kangjie Lu <kjlu@umn.edu>, Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 25, 2019 at 2:36 PM Aditya Pakki <pakki001@umn.edu> wrote:
>
> In case kmemdup fails, the fix releases resources and returns to
> avoid the NULL pointer dereference.
>
> Signed-off-by: Aditya Pakki <pakki001@umn.edu>
>
> ---
> v2: Replace incorrect kfree with ida_simple_remove, suggested by
> Johannes Thumshirn
> v1: Free nd_btt->id in case of failure and avoid double free, suggested
> by Dan Williams
> ---
>  drivers/nvdimm/btt_devs.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/nvdimm/btt_devs.c b/drivers/nvdimm/btt_devs.c
> index b72a303176c7..f73fb5fdc93f 100644
> --- a/drivers/nvdimm/btt_devs.c
> +++ b/drivers/nvdimm/btt_devs.c
> @@ -204,8 +204,11 @@ static struct device *__nd_btt_create(struct nd_region *nd_region,
>         }
>
>         nd_btt->lbasize = lbasize;
> -       if (uuid)
> +       if (uuid) {
>                 uuid = kmemdup(uuid, 16, GFP_KERNEL);
> +               if (!uuid)
> +                       goto out_put_id;
> +       }
>         nd_btt->uuid = uuid;
>         dev = &nd_btt->dev;
>         dev_set_name(dev, "btt%d.%d", nd_region->id, nd_btt->id);
> @@ -220,6 +223,11 @@ static struct device *__nd_btt_create(struct nd_region *nd_region,
>                 return NULL;
>         }
>         return dev;
> +
> +out_put_id:
> +       ida_simple_remove(&nd_region->btt_ida, nd_btt->id);
> +       kfree(nd_btt);

There's still 2 calls to "kfree(nd_btt)" when only one is needed.
Please route them both to the same call.
