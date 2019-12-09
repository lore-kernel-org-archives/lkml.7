Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A05C8C43603
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 19:16:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B89220726
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 19:16:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="unKWnoTK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726816AbfLITQo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 14:16:44 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:36889 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726342AbfLITQo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 14:16:44 -0500
Received: by mail-pl1-f193.google.com with SMTP id c23so905169plz.4;
        Mon, 09 Dec 2019 11:16:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g6zkbUlOTbCJgJvtgyfcRvZ9zBUSaegJ3s+RiDC5Ad0=;
        b=unKWnoTKSfnJJm1wX5W0WtEgOJP17vgC3lyn9GZeAwFzEdge0FJEz7VDfikYXfURg3
         rHqFi6fYx/+LvIrg2r674tEKM2b5+LBATNDrrMOy6X/fM6Rki1SGB7CAbG0dc1fIf5KS
         9G40qWgW+zgXlePk+DnyEed9vE95WChckeJjyYUUp46lL97x8hCVqWBsM2/hqPVRRFhj
         1CDqcM5dP9rX4vKmIW1Y/DMiRQ0pf5HlluyGJ5oEKrmrcoi/s3rzmYjqeyV7YO0Zfb0J
         vzgNXlgEBUNZbelb4rUVcEjXjXJQYOHJG+/busl0aM1uwfac0pPwn3SDZRANBJtsP3c7
         Qi0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g6zkbUlOTbCJgJvtgyfcRvZ9zBUSaegJ3s+RiDC5Ad0=;
        b=X0wqtQlO1+fvMMSMOSpAFH4d9KOE6olo/EC46fZhFRPyaUAgMCgDx/TJ6o8f0knViD
         Ua2pSLmjrw7QVGLA6LkDL+yZgMOm24xztNcmBalPZsIxSzpiHI0EtzFmT/YIXHeEoaQy
         ioqqNctTCvCeHjHCN6BXxXvgoxExnZCFesgvLvq3FnoqvaGi6bPFjQX4Ga83NtWoo5AS
         PlRlyXsKBELQ9I/MMpKldUI09qh+J4bISwFkm6ZXpHjp+r2yWDcMAcTf5TdLnmFMZ52o
         4hMRASoaLyz1LEbXH+JA2K42c+FNsX0XSPJ2s/p1Ij8wzCGiYBQsum8lpO1vWbe2j+Yf
         M0iw==
X-Gm-Message-State: APjAAAX7PpCqYnlg5vAKFi7w2hWoOAQS6aQIwcP0COwiWF3ylZSYisDn
        n/dBA+/rAmMsS71eex6OksiI03DTbAyLi1rrvtg=
X-Google-Smtp-Source: APXvYqzmO5ZwJe89134XQysUWnxbYrefIYWkIAKfadLFNeaTKhmTWOJOn2cyMCgxk7sOKdftvlSnleyzvodYcnlnGw4=
X-Received: by 2002:a17:902:8d96:: with SMTP id v22mr10761896plo.262.1575919003068;
 Mon, 09 Dec 2019 11:16:43 -0800 (PST)
MIME-Version: 1.0
References: <20191209185343.215893-1-stephan@gerhold.net>
In-Reply-To: <20191209185343.215893-1-stephan@gerhold.net>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 9 Dec 2019 21:16:33 +0200
Message-ID: <CAHp75VfA89iw1nSp1+zY3huRds0mkM-cEZdtJFdFJK-OXVJjew@mail.gmail.com>
Subject: Re: [PATCH] NFC: nxp-nci: Fix probing without ACPI
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     "David S. Miller" <davem@davemloft.net>,
        =?UTF-8?Q?Cl=C3=A9ment_Perrochaud?= 
        <clement.perrochaud@effinnov.com>,
        Charles Gorand <charles.gorand@effinnov.com>,
        linux-nfc@lists.01.org, netdev <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 9, 2019 at 8:57 PM Stephan Gerhold <stephan@gerhold.net> wrote:
>
> devm_acpi_dev_add_driver_gpios() returns -ENXIO if CONFIG_ACPI
> is disabled (e.g. on device tree platforms).
> In this case, nxp-nci will silently fail to probe.
>
> The other NFC drivers only log a debug message if
> devm_acpi_dev_add_driver_gpios() fails.
> Do the same in nxp-nci to fix this problem.
>

Ah, thanks!
Acked-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Fixes: ad0acfd69add ("NFC: nxp-nci: Get rid of code duplication in ->probe()")
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
> ---
>  drivers/nfc/nxp-nci/i2c.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/nfc/nxp-nci/i2c.c b/drivers/nfc/nxp-nci/i2c.c
> index 4d1909aecd6c..9f60e4dc5a90 100644
> --- a/drivers/nfc/nxp-nci/i2c.c
> +++ b/drivers/nfc/nxp-nci/i2c.c
> @@ -278,7 +278,7 @@ static int nxp_nci_i2c_probe(struct i2c_client *client,
>
>         r = devm_acpi_dev_add_driver_gpios(dev, acpi_nxp_nci_gpios);
>         if (r)
> -               return r;
> +               dev_dbg(dev, "Unable to add GPIO mapping table\n");
>
>         phy->gpiod_en = devm_gpiod_get(dev, "enable", GPIOD_OUT_LOW);
>         if (IS_ERR(phy->gpiod_en)) {
> --
> 2.24.0
>


-- 
With Best Regards,
Andy Shevchenko
