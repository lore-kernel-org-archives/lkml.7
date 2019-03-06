Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB97FC43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 16:58:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87F5120684
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 16:58:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CzXIGeNw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730156AbfCFQ6S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 11:58:18 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:40737 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726805AbfCFQ6R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 11:58:17 -0500
Received: by mail-qt1-f195.google.com with SMTP id j36so13609231qta.7;
        Wed, 06 Mar 2019 08:58:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5WKxlespnozNwXXzrZIVyTtNdvgIQi6IivB4otClv/o=;
        b=CzXIGeNwCfiTrnHw7jMvU3bYn3thd0okwLi1ReH0MkYO1xnpgyY/XBG28qbpRCF9xJ
         aGagHc/cFD5pZgAUhxTmaVQOoAwjqeetWitnp471tWB3eohbOHxTnhbp01cImJzwdY80
         7NUJW/ZMo5P+7C1AbsH2FLdTPXWkSqgHj9i6KNR+qfBY8CQP3QYDGI2omAorEhaxqBZL
         mqCfIB0e7TFvBK9hu5YHyq9nE20r41HluYSiRyeGUS12UFq+MvNbb2tD3T/qqoRovMiO
         E8II6lMNkTHtzpW8r3u+9EFlv/kD2heft03/tzLt+JKzk/0pPMmXpcpFJeZ4cU5yMqd9
         nH6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5WKxlespnozNwXXzrZIVyTtNdvgIQi6IivB4otClv/o=;
        b=lZEksiy2PPTjEwU0kTlV/88plY1ufRokhbSa6h8qlPclDMyVt9G6rP3bWEeJnMLoii
         57zw0ebpukB1FEXBLrg6os/xiaFvsvcxzMPRDHyg5N7bPrj8qOd56FcFdhqo/W+QqvLd
         ixKp8OnKzJFlm6uw0xbwL4EAamwB5DR1UHx8f0hVfOmAn0CK7cCngkATgHNNEd9to6LS
         ACBuCxEMxNsTKFB4y1AfjS/e7pI0v/MyxmT1CFcYfuZFfcYj+r1sT7GzX+ERhZEuX19G
         rTcpm8idXCh5I5NZFaFX0TUszrJndt5jtwHkztTRi+EOVjjQ5CNcHAkVrmSzNN6vkab2
         5qUg==
X-Gm-Message-State: APjAAAV3RPA8b80yty7XVMGjvqldr80kv360R4dNIgAkU85WiTDSoGUR
        L2s8RcWSw1L9KFMrpklFFBphEw1KPXzMgNGRdvQ=
X-Google-Smtp-Source: APXvYqzH49CVqPdcmlb1xI5roqdq3t5OpqZq0Cg4UpMZtBXxip+eNELM3yp+/Xijy0EwanKkqceo7XVAGSh6PrAGg90=
X-Received: by 2002:a0c:ad67:: with SMTP id v36mr7080548qvc.5.1551891496427;
 Wed, 06 Mar 2019 08:58:16 -0800 (PST)
MIME-Version: 1.0
References: <20190304224854.12494-1-pakki001@umn.edu>
In-Reply-To: <20190304224854.12494-1-pakki001@umn.edu>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Wed, 6 Mar 2019 08:58:04 -0800
Message-ID: <CAPhsuW4+2r+CV71JGL6_0Cxn0aDeuLDg7Bhma51tS7RpR9fZpg@mail.gmail.com>
Subject: Re: [PATCH] md: Fix failed allocation of md_register_thread
To:     Aditya Pakki <pakki001@umn.edu>
Cc:     kjlu@umn.edu, Shaohua Li <shli@kernel.org>,
        linux-raid <linux-raid@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 4, 2019 at 2:50 PM Aditya Pakki <pakki001@umn.edu> wrote:
>
> mddev->sync_thread can be set to NULL on kzalloc failure downstream.
> The patch checks for such a scenario and frees allocated resources.
>
> Signed-off-by: Aditya Pakki <pakki001@umn.edu>

This looks good. Could you please add a "Fixed:" tag?

Thanks,
Song

> ---
>  drivers/md/raid10.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
> index abb5d382f64d..f52b4d9bcd24 100644
> --- a/drivers/md/raid10.c
> +++ b/drivers/md/raid10.c
> @@ -3939,6 +3939,8 @@ static int raid10_run(struct mddev *mddev)
>                 set_bit(MD_RECOVERY_RUNNING, &mddev->recovery);
>                 mddev->sync_thread = md_register_thread(md_do_sync, mddev,
>                                                         "reshape");
> +               if (!mddev->sync_thread)
> +                       goto out_free_conf;
>         }
>
>         return 0;
> --
> 2.17.1
>
