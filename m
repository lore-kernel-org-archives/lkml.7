Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDC31CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 10:59:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C883220700
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 10:59:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iHwCtDtv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633207AbfJRK7J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 06:59:09 -0400
Received: from mail-vk1-f194.google.com ([209.85.221.194]:32935 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2442509AbfJRK7I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 06:59:08 -0400
Received: by mail-vk1-f194.google.com with SMTP id s21so1253762vkm.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 03:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WtA3V2IALA0Xv78U/72cjyEnqj42CR5j6kkzonbGR5Y=;
        b=iHwCtDtvN+KTXn/RwtvNwQGCGKUyAd9aSM5/gYvWV7+3et8OyYvGeQSXmjhj+GR2sd
         DW5uJ+OFJKkG0er6TA1lKGXqY1nTjTi0KRvfqzTCvKcmvj5skk1j+unOkMnnfsYP7GqE
         pC73iToVAVQTkOafuvqHysNZ9qi27d3sPQFeLo5TZpOQSAbAKLVv1vBArHqQOom4Eyim
         8D5nZeKcjdDvNjm83dU/jbLg0sRXvoDzCDSk4tJbmu+nGMLBaiSZdnKxnSwwcyaeR69U
         U5NGxqzclWg2VBwa6cqBYN+5eBmJQ02OiNWkHshFEX5BgoR+gelMXdE+oilY1XvjmTl9
         66EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WtA3V2IALA0Xv78U/72cjyEnqj42CR5j6kkzonbGR5Y=;
        b=T5itGIhfq/RgzW/nr/Rx4dJQoMLExH8Tds9wThdAT+aKnpamqYOtmRBl2Fu+0mmwt0
         ryQlRA4CzjNVJEWRJc0B+iH660WUXwGWgLDa/xFc0XxjYUxC3famdL9a5IxVIk0L70hk
         G2vcLWElkGs0QbqvY8Fd9XUNEdDwKu/gmK7RoO9qOi707qf6O0+J0YS4KsRR63NN0eby
         C6sts35khOzIWLK7t3SJb4fsFW0ZWP9Diq084INoeQms6BS1i1eMIWAG3BbB60RHMDKK
         AWAbT4Hz7wS3JcUIWTZOykCiMuNQCb7zr4a/5vP0e55C7qYXo5hDQUXheh3A/uxSY0zF
         fiuw==
X-Gm-Message-State: APjAAAXBfJdFNCM6BLEZ9jAq8WNhGYHEjz73OPSyvqxBMM15nHFRIYYH
        47tbekC4V2bhnpsbch/1ZlkTMYkXnv/pdx5M8Z3mPQ==
X-Google-Smtp-Source: APXvYqw84njAK+3ljeXxfcyBQy775MIu35Bex1hH0yoREoalNLM4JFsVxJK4C23Ifc2BtdFfQ1Qf7RJmFlC3FEimVwU=
X-Received: by 2002:a1f:a293:: with SMTP id l141mr4939018vke.43.1571396347472;
 Fri, 18 Oct 2019 03:59:07 -0700 (PDT)
MIME-Version: 1.0
References: <20191014183849.14864-1-faiz_abbas@ti.com>
In-Reply-To: <20191014183849.14864-1-faiz_abbas@ti.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 18 Oct 2019 12:58:30 +0200
Message-ID: <CAPDyKFqbRNXaNVEACFQkKEymaY=Jm8L65-Ne_LbAmqFUkY1zcw@mail.gmail.com>
Subject: Re: [RFC] mmc: cqhci: commit descriptors before setting the doorbell
To:     Faiz Abbas <faiz_abbas@ti.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Asutosh Das <asutoshd@codeaurora.org>,
        Harjani Ritesh <riteshh@codeaurora.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Oct 2019 at 20:37, Faiz Abbas <faiz_abbas@ti.com> wrote:
>
> Add a write memory barrier to make sure that descriptors are actually
> written to memory before ringing the doorbell.
>
> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>

Applied for fixes and by adding a stable tag, thanks!

BTW, do you have a valid commit that it fixes?

Kind regards
Uffe


> ---
>
> This patch fixes a very infrequent ADMA error (1 out of 100 times) that
> I have been seeing after enabling command queuing for J721e.
> Also looking at memory-barriers.txt and this commit[1],
> it looks like we should be doing this before any descriptor write
> followed by a doorbell ring operation. It'll be nice if someone with more
> expertise in memory barriers can comment.
>
> [1] ad1a1b9cd67a ("scsi: ufs: commit descriptors before setting the
>     doorbell")
>
>  drivers/mmc/host/cqhci.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/cqhci.c b/drivers/mmc/host/cqhci.c
> index f7bdae5354c3..5047f7343ffc 100644
> --- a/drivers/mmc/host/cqhci.c
> +++ b/drivers/mmc/host/cqhci.c
> @@ -611,7 +611,8 @@ static int cqhci_request(struct mmc_host *mmc, struct mmc_request *mrq)
>         cq_host->slot[tag].flags = 0;
>
>         cq_host->qcnt += 1;
> -
> +       /* Make sure descriptors are ready before ringing the doorbell */
> +       wmb();
>         cqhci_writel(cq_host, 1 << tag, CQHCI_TDBR);
>         if (!(cqhci_readl(cq_host, CQHCI_TDBR) & (1 << tag)))
>                 pr_debug("%s: cqhci: doorbell not set for tag %d\n",
> --
> 2.19.2
>
