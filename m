Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11D3EC31E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 16:57:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D84A920679
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 16:57:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LRLHdT3Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729952AbfFRQ51 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 12:57:27 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:38053 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729472AbfFRQ50 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 12:57:26 -0400
Received: by mail-io1-f68.google.com with SMTP id j6so1835404ioa.5
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2019 09:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xrJsxZ/IfKMP1AFfySPNnocTESP3c3IM1WrlKO+7sJo=;
        b=LRLHdT3Zc0vxsuSpsMh7E6xAiPxdYfHeiWb7tew+JOx8kBFp0kWayPKaQFnGUTr2UR
         sQ4zZxKO4lf17j7Et3Er6szcshZ8xZvpJ/dubyd9UwN5nuTqgZJ+Oe+aDOwpResrEs5I
         X20R0Ukbi7TYIax2IcOCn7p5yLF+xhCssXWp0wNLuIJl7Blfzqtk+31WT0glFpzcaEhw
         rcRwWIIzWVpqCK5iOguSh4ruorGDmM/YWwIWQIacgaqTPbDxiOLExFEQIWangupFPsKW
         AdqiOKnMzmcDPhRqqHFH7XI/nyX2LflNeH6119EsYU+BPfEjGjlEYDyP0npDFxH76fRC
         VS6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xrJsxZ/IfKMP1AFfySPNnocTESP3c3IM1WrlKO+7sJo=;
        b=WZiBbylhqUIFz/cD9EV+kGMvaMBwM+ddaF3v5BjoS+BwnA+5UEwVkcoqw43Jh4k/sH
         9rRR8UMVAo8MdDk3xMhx+6yupUFd7jFAehFPnDKoDJbglmGAv+aKL52onhBR4Fbxn0Pa
         SKqXJpr6Niyj4sDLBFYUaFkfkxRdldqe+0CD4m9LmhVkBUjSDuA6Yssbxw1wXOzzWH7C
         JFqd36uBwah248iu6WkGADlp9ht06ZpBTM5bToDytNch2uSy2Z5oRqtRwUvHAJrPetXi
         VQQ7oTcgHYNtZEivtUOv4F4fhf1rs54vYgbndOdLRKmPo2CyoKkAYfuVqQIIHCzZ5aNB
         72Xg==
X-Gm-Message-State: APjAAAVyBFxDJbzBPVhQblzKsEdc4CjynqpfX33R9vPF8IvyxPHMCqL3
        b6pvQihraLcTmgIfFK7mk6l3aK6/DhMSZq2y7n+GXw==
X-Google-Smtp-Source: APXvYqyMZYgvkSgpjFYOYSD97Cjv1smwGOaNuCjsiFCWLy9P3EJDPKS7jGPSryG4ENqREkBd2GGzHG5tw909R8LYTNI=
X-Received: by 2002:a02:7642:: with SMTP id z63mr3888157jab.36.1560877046081;
 Tue, 18 Jun 2019 09:57:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190615104440.94149-1-weiyongjun1@huawei.com> <20190617092253.167231-1-weiyongjun1@huawei.com>
In-Reply-To: <20190617092253.167231-1-weiyongjun1@huawei.com>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Tue, 18 Jun 2019 10:57:14 -0600
Message-ID: <CANLsYkyQMB5q9kavLLBwGjhq7sXLNBPPpWaaEip+6DnRahA4oQ@mail.gmail.com>
Subject: Re: [PATCH -next v2] coresight: replicator: Add terminate entry for
 acpi_device_id tables
To:     Wei Yongjun <weiyongjun1@huawei.com>
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Jun 2019 at 03:15, Wei Yongjun <weiyongjun1@huawei.com> wrote:
>
> Make sure acpi_device_id tables have terminate entry.
>
> Fixes: fe446287ec9f ("coresight: acpi: Support for platform devices")
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  drivers/hwtracing/coresight/coresight-replicator.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/hwtracing/coresight/coresight-replicator.c b/drivers/hwtracing/coresight/coresight-replicator.c
> index 542952759941..b7d6d59d56db 100644
> --- a/drivers/hwtracing/coresight/coresight-replicator.c
> +++ b/drivers/hwtracing/coresight/coresight-replicator.c
> @@ -300,6 +300,7 @@ static const struct of_device_id static_replicator_match[] = {
>  #ifdef CONFIG_ACPI
>  static const struct acpi_device_id static_replicator_acpi_ids[] = {
>         {"ARMHC985", 0}, /* ARM CoreSight Static Replicator */
> +       {}

Applied - thanks

>  };
>  #endif
>
>
>
