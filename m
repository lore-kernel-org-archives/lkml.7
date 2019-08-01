Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3F8BC433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 14:59:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0C132080C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 14:59:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="POeIR6JC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730020AbfHAO7M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 10:59:12 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:45271 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbfHAO7L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 10:59:11 -0400
Received: by mail-vs1-f68.google.com with SMTP id h28so49054713vsl.12
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2019 07:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HZi73lGQN00R4hLz2SVQy1XpIlUHoTiGbhTsmJxfUN8=;
        b=POeIR6JCB3hi2tCwSY/8k8k78LXYZFkW02y+yCkooOHKQZaL5n9fDzcIaw7qL/x0bD
         0Sbx+pPs7pTMc3jTpV21rcdiVVVxFUAZSCtlN/j5xXrafdAQeqfFiNkYSnIYlRDvsybM
         /y6eVD8EkSdPv9LifZJWRMOm9+eZYQtfxaB1lcuuFDdL4+cHLqcATf2OkLCRvuVvVKZv
         68h5AwChuIp+WLxSvn7qnl+OypnyQ5mhMwgL0jhQJfPG/0roBFo50us7gS6KIl8qTVSU
         DlWRgh4kVtvo3CMbLNj8mJj+jxJhIhfBu0dUs0NXGurVRbTvB9NqdrRAUkzeRgi4QF1a
         AgsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HZi73lGQN00R4hLz2SVQy1XpIlUHoTiGbhTsmJxfUN8=;
        b=bfGS/p3GvXL849fqlqs93NhDmeZ3gNFpTulNcwxyECoNQmxrsOsmzE+WMoaDvw0xgh
         agC1YQlM8i76f9M1ty31LfkfVQ3Q/+BOwo2FujFsaPPZFlRTG1A9M/CFY5ivGtUAXe8A
         7fAm+Jnvcqo67tTHJ6f66MqMV209AnOx01fV7ZqWoL53KEJ1Tib845m2FelMLDLJ/yJr
         1lYdNeAmlaDsg3sAoURGCbGAI2guGzLFuWcDG1NZ6klUobUJzJZwJTfKWM8WP4zFdq8U
         rJekfTPeJi2rrKeTk5CYmWyXlvAhv3gn5PSV87WsLJKW7Ca27gnZ21H6ywTPjPABMdwk
         s9hg==
X-Gm-Message-State: APjAAAUrFeEK2/GzHof2ZcXutJyvCSD+pW9aZl2HA5qYNQeUG208IpBs
        DMn1cQuTtPLDhlzhx12zF2ETjvBE9F503ARvnY2dVQ==
X-Google-Smtp-Source: APXvYqw68dvHKKu6qAXsBV19hf2DA1P86szVyTw40C4W7t9cyo/4LZT8SwE7GgzcSXNYEBQomzRstucQfJn/G7Oz0S8=
X-Received: by 2002:a67:ee16:: with SMTP id f22mr82204826vsp.191.1564671550796;
 Thu, 01 Aug 2019 07:59:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190726142252.9654-1-baijiaju1990@gmail.com>
In-Reply-To: <20190726142252.9654-1-baijiaju1990@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 1 Aug 2019 16:58:34 +0200
Message-ID: <CAPDyKFp7z3uXws4+jL=-U6cZekVX+QeJNKmqegmap8ZWhbgRoA@mail.gmail.com>
Subject: Re: [PATCH] mmc: host: dw_mmc: Fix possible null-pointer dereferences
 in dw_mci_runtime_resume()
To:     Jia-Ju Bai <baijiaju1990@gmail.com>
Cc:     Jaehoon Chung <jh80.chung@samsung.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Jul 2019 at 16:23, Jia-Ju Bai <baijiaju1990@gmail.com> wrote:
>
> In dw_mci_runtime_resume(), there is an if statement on line 3420
> to check whether host->slot is NULL:
>     if (host->slot && ...)
>
> When host->slot is NULL, it is used on line 3458:
>     if (host->slot->mmc->pm_flags & MMC_PM_KEEP_POWER)
> and on line 3462:
>     dw_mci_setup_bus(host->slot, true);
>         struct dw_mci *host = slot->host;
>
> Thus, possible null-pointer dereferences may occur.
>
> To fix these bugs, host->slot is checked before being used.
>
> These bugs are found by a static analysis tool STCheck written by us.

I fully respect these kind of tools and they for sure find lots of
problems for us.

However, in this case I think the fix should be made a bit
differently, see more below.

>
> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
> ---
>  drivers/mmc/host/dw_mmc.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index faaaf52a46d2..91bd6c3ccf50 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -3455,11 +3455,12 @@ int dw_mci_runtime_resume(struct device *dev)
>         mci_writel(host, CTRL, SDMMC_CTRL_INT_ENABLE);
>
>
> -       if (host->slot->mmc->pm_flags & MMC_PM_KEEP_POWER)
> +       if (host->slot && (host->slot->mmc->pm_flags & MMC_PM_KEEP_POWER))
>                 dw_mci_set_ios(host->slot->mmc, &host->slot->mmc->ios);

Unless I missing something (still in "slow mode" due to holidays),
dw_mci_runtime_suspend|resume() should only be called when there is a
slot (host->slot) initialized for the host. This is guaranteed by the
the driver when it runs ->probe().

>
>         /* Force setup bus to guarantee available clock output */
> -       dw_mci_setup_bus(host->slot, true);
> +       if (host->slot)
> +               dw_mci_setup_bus(host->slot, true);

Ditto.

>
>         /* Now that slots are all setup, we can enable card detect */
>         dw_mci_enable_cd(host);

So, I am thinking that there is really no need to check for host->slot
at all. And if there really were, I am sure there would have been bug
reports already about it.

Kind regards
Uffe
