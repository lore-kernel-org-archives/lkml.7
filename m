Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACCC3C76190
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 18:00:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 825B4229F3
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 18:00:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hJjvEy0r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730119AbfGYSA3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 14:00:29 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33432 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726470AbfGYSA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 14:00:28 -0400
Received: by mail-pg1-f196.google.com with SMTP id f20so14181848pgj.0;
        Thu, 25 Jul 2019 11:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SDQdIEC5lAFm3yeqFyVPcDyvNShQJnmklTsND46m4Mo=;
        b=hJjvEy0roGRFSuhkDSXa/ul/k1i0vNdVeJloGKhDdynILhOpibQ51mNlZHU/SJ1JR3
         0PcEowfre3uztlefZfVYS2ddRqrM9qMM+xvkSCqZO9XVHeV4rB8gQOhPHIBt6+BdFJbt
         B+TFOJuM4cgtgTQWQH8jIVrpCdsBHshclNNG4yXPpSgp/y82EDNBIGaqg7h8/JXBgEAe
         vhj289uwT9t/W+suUpGkj3mvgIORKJPHoIwu/SniqyuunXAkzj8Y7x7/9Yos3XhN/s0V
         fNpoZLDl5ZwPpOAGaRq+wcYXqnk6FKoptZkgoInhDJIiDExYRG6CLjebPFJW5RBkEBT/
         s8MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SDQdIEC5lAFm3yeqFyVPcDyvNShQJnmklTsND46m4Mo=;
        b=qseCXFYo7z4P2rJUtCndWrSKC1aRsiOv9ti9uiJbQjEgvrcYehXuCjEIBUoQ3wqTV2
         sk3wAaM3eeSV1qRAl6JEfVDtALJouE6bZ18hz5tzeY0nraMdYLBIJLGFjWsDIda4bZkJ
         AKX3zvSpzGnmooNx3WI5f1iQ5DNklUYcJH5LFhKlPebNollPG8lPCHMVQpbrsMazGu19
         Bi5JDs1yqFwmoq+1CgP4KN1d7/zUCV+Db1LQiuIUXuAd2VOWEWWtpG3v4zO9arT2y6ei
         diMTqbXdIDr7p6hT6B/oRVDjO4ajx5Zvb8iwORs4vs/tRF9yrAUXv3UQtCkPLMFmXp1F
         zb4Q==
X-Gm-Message-State: APjAAAX2/QlDJVxswMivW1UqhuGquHE0qOKn2Pg7kibUSS4jBdgB41dn
        KdnFbba1IwWwdONt+6ubXqxpLrOmEYYIxk2ZOGg=
X-Google-Smtp-Source: APXvYqyrE6xLoNR2w/exbD9prsM2fqEzylM0g8hZdXl3D+wr3dd1uBefoy94DYfjr5MdPA0xnmmqKDpX4CxkxaeoJyM=
X-Received: by 2002:a63:6eca:: with SMTP id j193mr12231277pgc.74.1564077627929;
 Thu, 25 Jul 2019 11:00:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190724122320.21802-1-hslester96@gmail.com>
In-Reply-To: <20190724122320.21802-1-hslester96@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 25 Jul 2019 21:00:16 +0300
Message-ID: <CAHp75VdpEZbBTw3vsvreeyWAANo=ZDtooqbChe0fF4ALQsstGw@mail.gmail.com>
Subject: Re: [PATCH] platform/x86: ISST: Use dev_get_drvdata
To:     Chuhong Yuan <hslester96@gmail.com>
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 24, 2019 at 3:23 PM Chuhong Yuan <hslester96@gmail.com> wrote:
>
> Instead of using to_pci_dev + pci_get_drvdata,
> use dev_get_drvdata to make code simpler.
>

Pushed to my review and testing queue, thanks!

> Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
> ---
>  drivers/platform/x86/intel_speed_select_if/isst_if_mmio.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/platform/x86/intel_speed_select_if/isst_if_mmio.c b/drivers/platform/x86/intel_speed_select_if/isst_if_mmio.c
> index f7266a115a08..ad8c7c0df4d9 100644
> --- a/drivers/platform/x86/intel_speed_select_if/isst_if_mmio.c
> +++ b/drivers/platform/x86/intel_speed_select_if/isst_if_mmio.c
> @@ -132,11 +132,9 @@ static void isst_if_remove(struct pci_dev *pdev)
>
>  static int __maybe_unused isst_if_suspend(struct device *device)
>  {
> -       struct pci_dev *pdev = to_pci_dev(device);
> -       struct isst_if_device *punit_dev;
> +       struct isst_if_device *punit_dev = dev_get_drvdata(device);
>         int i;
>
> -       punit_dev = pci_get_drvdata(pdev);
>         for (i = 0; i < ARRAY_SIZE(punit_dev->range_0); ++i)
>                 punit_dev->range_0[i] = readl(punit_dev->punit_mmio +
>                                                 mmio_range[0].beg + 4 * i);
> @@ -149,11 +147,9 @@ static int __maybe_unused isst_if_suspend(struct device *device)
>
>  static int __maybe_unused isst_if_resume(struct device *device)
>  {
> -       struct pci_dev *pdev = to_pci_dev(device);
> -       struct isst_if_device *punit_dev;
> +       struct isst_if_device *punit_dev = dev_get_drvdata(device);
>         int i;
>
> -       punit_dev = pci_get_drvdata(pdev);
>         for (i = 0; i < ARRAY_SIZE(punit_dev->range_0); ++i)
>                 writel(punit_dev->range_0[i], punit_dev->punit_mmio +
>                                                 mmio_range[0].beg + 4 * i);
> --
> 2.20.1
>


-- 
With Best Regards,
Andy Shevchenko
