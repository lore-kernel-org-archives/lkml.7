Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 697FDC32792
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 10:02:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 423AF21A4C
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 10:02:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kuAvisrb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729891AbfJCKCk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 06:02:40 -0400
Received: from mail-vk1-f195.google.com ([209.85.221.195]:44708 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729870AbfJCKCi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 06:02:38 -0400
Received: by mail-vk1-f195.google.com with SMTP id j21so475623vki.11
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2019 03:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4hTN5hXof2GeuSSClgWGL0co9GQPORmGjn5ytO1C4rQ=;
        b=kuAvisrbiGJNldB6damtdIToQrgJw3+m03ZmkRjensLqLh3IE9sjcJH+06+xKcNmJz
         KuVdX9NnQN4EdNRsVnJXmL5DHjimS37ulpntX/ZTqzJnWvFwy7An+wn2fDl70hp7x/lg
         zwq6sUed+cLzYz+J6hPhAJDvU6a+nG7TI6KrNukLxnXRZuVCWC4ATLhD3gLFBPHsN//y
         2gO7VGVQGkdwL1f157Fy5wAeDhqdaIZeNTA8+pW5XxvkmCP+Z30ypQ2cyycS7uBoDK29
         3m1KCM7piFFHPeVDIgNFtR34RRxEEc670E813H25BfqWdwWXAIxW4WiDbxnmCzpU9PQA
         FqTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4hTN5hXof2GeuSSClgWGL0co9GQPORmGjn5ytO1C4rQ=;
        b=L1X5L0fR2wGAwI7scMSNhrxkWA3AJYO1435YDHbB6sT5dcnHVYLuGo5g7yTm2id9GG
         dyfN29LlGq/an0sPNBRf+nzo53a44i7fOj4Uc8alcrLOt3XToCW++FhijWRiCg/Yxidd
         9cgS/xsssnMx9nZ9K6z1HLwgwqbShXCkBFUGuZn4ov/xl5UgYufq9wBacP3efB/jLFrB
         10gwSuLWpS6FP/3kRefMySbeU+HjYighiRt34rDp8/3oIcL2PtxshSigU7GbjRkODt9k
         dFzlO56apcKIyVNISWME3DWB4yejP8Irc9c3YRHCI4oBGrHW2UFCt8ZE9gFjEzioUNEb
         byTQ==
X-Gm-Message-State: APjAAAVBFtDioVcKTUQ4NmTQ/P/7D74vQUWuoto07OBXkallU/rQ/Ci6
        0lh9DTxsRKPEHK0J9Av6QuhiFvsYhRQBdf4FyuGQBg==
X-Google-Smtp-Source: APXvYqyooxUx5UM4VsemSzYrJ/eZau3LpIq4PKSGS1jZsFBPN38kXKo1d9K+rI9mPE+pJUGBNBD8fvNGRl+5g0gXDNk=
X-Received: by 2002:a1f:8c50:: with SMTP id o77mr4532311vkd.52.1570096957636;
 Thu, 03 Oct 2019 03:02:37 -0700 (PDT)
MIME-Version: 1.0
References: <20190922115443.11693-1-colin.king@canonical.com>
In-Reply-To: <20190922115443.11693-1-colin.king@canonical.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 3 Oct 2019 12:02:01 +0200
Message-ID: <CAPDyKFoHsOJKmQBT05Xqt0H+aeTdy-AWQ8-ej2CUheS2w6_jiA@mail.gmail.com>
Subject: Re: [PATCH] mmc: dw_mmc: fix indentation issue
To:     Colin King <colin.king@canonical.com>
Cc:     Jaehoon Chung <jh80.chung@samsung.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 22 Sep 2019 at 13:54, Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> There are a couple of statements that are indented by an extra
> space, clean this up by remove the extraneous spaces.
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/dw_mmc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 79c55c7b4afd..bf0048ebbda3 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -3441,8 +3441,8 @@ int dw_mci_runtime_resume(struct device *dev)
>          * Restore the initial value at FIFOTH register
>          * And Invalidate the prev_blksz with zero
>          */
> -        mci_writel(host, FIFOTH, host->fifoth_val);
> -        host->prev_blksz = 0;
> +       mci_writel(host, FIFOTH, host->fifoth_val);
> +       host->prev_blksz = 0;
>
>         /* Put in max timeout */
>         mci_writel(host, TMOUT, 0xFFFFFFFF);
> --
> 2.20.1
>
