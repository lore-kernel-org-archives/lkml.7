Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05B4BC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 17:51:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C566D20823
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 17:51:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553536280;
	bh=YXo5aNrKEK0EVlMeYrxPR4GBMUR8+qdSey7Xzlh+O/U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Mo8nUHs2y5ailsA7UoMyXhMHPLfLImVp+ujlQf41/WgBX3BEyIpiXow1MLfv+YqSm
	 UNFgbCnHOaO+nRcmgoTjv1jp6BZGtFsbBsOSsOnZ0HFlZaNAi0dlOpdnQS3YZ2Pwey
	 SyDkll45//MrQd7vWF0+SC7aaXL2dBGVAIz13Ndk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729829AbfCYRvT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 13:51:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:40982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726024AbfCYRvT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 13:51:19 -0400
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5BCAF2087E;
        Mon, 25 Mar 2019 17:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553536278;
        bh=YXo5aNrKEK0EVlMeYrxPR4GBMUR8+qdSey7Xzlh+O/U=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=QYEofgxwTNcuoA3hpYeV20JlMdKEOorB1Q7ctsVKuJytn7Fgxs/AiISFgF+5Lv/gC
         oWo1EBEWre+153b1fOBv4ioOZmkzrWSWIaHQuM2LJy9NZwqBldcg7rpsLMiCOwlAnF
         bbXr4kcD/Oa6BVTm0Q0zMv9G2L/zqkGec38tWUpE=
Received: by mail-ed1-f45.google.com with SMTP id x14so5693888eds.1;
        Mon, 25 Mar 2019 10:51:18 -0700 (PDT)
X-Gm-Message-State: APjAAAU6tdyt77lOoRBBTy7oueUMSYawVQcYuphldd6SEqgN40Zf5/5K
        QjeluU2VL32iUq43Jlqs/zvvXBSkNyX9YcXFJOk=
X-Google-Smtp-Source: APXvYqyz5f/froJTIgktYkNmr58HIacuDbVwRCfWQPPNZ0ymy3ueB/f/3N4ixNahUuXNy4ScWUinxmK5qCeD1t79/sw=
X-Received: by 2002:a17:906:5949:: with SMTP id g9mr14883618ejr.15.1553536276904;
 Mon, 25 Mar 2019 10:51:16 -0700 (PDT)
MIME-Version: 1.0
References: <1553483264-5379-1-git-send-email-hao.wu@intel.com> <1553483264-5379-3-git-send-email-hao.wu@intel.com>
In-Reply-To: <1553483264-5379-3-git-send-email-hao.wu@intel.com>
From:   Alan Tull <atull@kernel.org>
Date:   Mon, 25 Mar 2019 12:50:40 -0500
X-Gmail-Original-Message-ID: <CANk1AXSUMkfQu8QnN-T0B5qeA4vaGxDTvGur9EGyLbGsBFBeKQ@mail.gmail.com>
Message-ID: <CANk1AXSUMkfQu8QnN-T0B5qeA4vaGxDTvGur9EGyLbGsBFBeKQ@mail.gmail.com>
Subject: Re: [PATCH 02/17] fpga: dfl: fme: align PR buffer size per PR datawidth
To:     Wu Hao <hao.wu@intel.com>
Cc:     Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api@vger.kernel.org, Xu Yilun <yilun.xu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 24, 2019 at 10:23 PM Wu Hao <hao.wu@intel.com> wrote:

Hi Hao,

Looks good, one question below.

>
> Current driver checks if input bitstream file size is aligned or
> not per PR data width (default 32bits). It requires one additional
> step for end user when they generate the bitstream file, padding
> extra zeros to bitstream file to align its size per PR data width,
> but they don't have to as hardware will drop extra padding bytes
> automatically.
>
> In order to simplify the user steps, this patch aligns PR buffer
> size per PR data width in driver, to allow user to pass unaligned
> size bitstream files to driver.
>
> Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> Signed-off-by: Wu Hao <hao.wu@intel.com>
> ---
>  drivers/fpga/dfl-fme-pr.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/fpga/dfl-fme-pr.c b/drivers/fpga/dfl-fme-pr.c
> index d9ca955..c1fb1fe 100644
> --- a/drivers/fpga/dfl-fme-pr.c
> +++ b/drivers/fpga/dfl-fme-pr.c
> @@ -74,6 +74,7 @@ static int fme_pr(struct platform_device *pdev, unsigned long arg)
>         struct dfl_fme *fme;
>         unsigned long minsz;
>         void *buf = NULL;
> +       size_t length;
>         int ret = 0;
>         u64 v;
>
> @@ -85,9 +86,6 @@ static int fme_pr(struct platform_device *pdev, unsigned long arg)
>         if (port_pr.argsz < minsz || port_pr.flags)
>                 return -EINVAL;
>
> -       if (!IS_ALIGNED(port_pr.buffer_size, 4))
> -               return -EINVAL;
> -
>         /* get fme header region */
>         fme_hdr = dfl_get_feature_ioaddr_by_id(&pdev->dev,
>                                                FME_FEATURE_ID_HEADER);
> @@ -103,7 +101,13 @@ static int fme_pr(struct platform_device *pdev, unsigned long arg)
>                        port_pr.buffer_size))
>                 return -EFAULT;
>
> -       buf = vmalloc(port_pr.buffer_size);
> +       /*
> +        * align PR buffer per PR bandwidth, as HW ignores the extra padding
> +        * data automatically.
> +        */
> +       length = ALIGN(port_pr.buffer_size, 4);
> +
> +       buf = vmalloc(length);

Since it may not be completely filled, would it be worthwhile to alloc
a zero'ed buff?

Alan

>         if (!buf)
>                 return -ENOMEM;
>
> @@ -140,7 +144,7 @@ static int fme_pr(struct platform_device *pdev, unsigned long arg)
>         fpga_image_info_free(region->info);
>
>         info->buf = buf;
> -       info->count = port_pr.buffer_size;
> +       info->count = length;
>         info->region_id = port_pr.port_id;
>         region->info = info;
>
> --
> 2.7.4
>
