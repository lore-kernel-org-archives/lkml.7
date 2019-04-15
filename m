Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0028C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 12:40:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71E4020693
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 12:40:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sDL2UCg4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727503AbfDOMkk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 08:40:40 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:46645 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727340AbfDOMkj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 08:40:39 -0400
Received: by mail-pl1-f195.google.com with SMTP id y6so8491749pll.13;
        Mon, 15 Apr 2019 05:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rqjDra9Z8ZZjdfdEEHy9+0DZZNk7lWtx+s5+aHr2WKU=;
        b=sDL2UCg49qdgAmLv0PLGQaomQhifbud08OPB3x0oUMFl8vf4sELZ3Phg6IMrJQW1a3
         8HLqE0EVuWCBW5DiC25u4YePdf3rDlMj2k23qvx4VgIM1fDpYOos8iUnIF+yeo+IMme4
         IXbTPRfViABRHd/1h9TsZ6sPrukHsEpulVYpfahqSnZ9mElmMbaBPscEnXQi8bzfeO4L
         4ujux1rVwoLVQHajTf8bIwj8VRh087DasaJRK5XFWxI2emxKgwjunMfuUkB6EbUTzc06
         k209xlxAwwGnWv0KD/x4snhSiLoQzrwLd9xjgWwcGL7U1q8DQ9plXEmpYcTHShbhH7Dh
         htKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rqjDra9Z8ZZjdfdEEHy9+0DZZNk7lWtx+s5+aHr2WKU=;
        b=ZyStvOQWb8rUnjSnBiRcwDt9lLNAvkGCkRde+BfvQ5FXuwA0sPVXBSf/YH2vsHtoyb
         yq/Zn8xfG6cCYD0zkiJQ3yy+BKjS6jsKKaXR3QPuxMnyT9q3OGkIO6L8r7Cr9NaBAQ5o
         cex++TOLo2GTC+TA5BBfG3FAyJ9Bmf6/FsVyrQknTe7cjUQa+gxDMxXyQ+r0JR/udbNw
         OVMNA0MNxxmF8hRvrnw0PMoeivm2phjtGMTn054FeSt8ZoBB0prUIAx24cQ5ZY+xcVmL
         YadAgQBHFLRVjKdUkOUk15RA5hoZ1N7bGFSVMvYkPYD8c3cpdMRqoZL2zKHxc88JWetl
         Waqg==
X-Gm-Message-State: APjAAAUMXKLzqmBDKjHdhcWw7cWLJ5bFW7KlwoM+zA+atq+OZEX+pOut
        Ahd/qtp41H1eaGzrmg5/lpaDIYJc4HKQjkqowR8=
X-Google-Smtp-Source: APXvYqwUBhiJzlfIj31N8i1ReF0zWC78OJIfwdNgl7yRvbIEykeIt+1sK3JbxfV/iNtm7qSJuyKJ5jHeR4jk9Wb/XN8=
X-Received: by 2002:a17:902:9686:: with SMTP id n6mr32474933plp.282.1555332038331;
 Mon, 15 Apr 2019 05:40:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190403124019.8947-1-wsa+renesas@sang-engineering.com> <20190403124019.8947-2-wsa+renesas@sang-engineering.com>
In-Reply-To: <20190403124019.8947-2-wsa+renesas@sang-engineering.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 15 Apr 2019 15:40:27 +0300
Message-ID: <CAHp75VcDxjTm2Wxuwpj6vMPvhW3TvfZp_aR9TqxbjzZ=TRSvyQ@mail.gmail.com>
Subject: Re: [PATCH 01/12] i2c: remove use of in_atomic()
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-i2c <linux-i2c@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Peter Rosin <peda@axentia.se>,
        Stefan Lengfeld <contact@stefanchrist.eu>,
        Linux OMAP Mailing List <linux-omap@vger.kernel.org>,
        linux-tegra@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 3, 2019 at 3:43 PM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
> Commit cea443a81c9c ("i2c: Support i2c_transfer in atomic contexts")
> added in_atomic() to the I2C core. However, the use of in_atomic()
> outside of core kernel code is discouraged and was already[1] when this
> code was added in early 2008. The above commit was a preparation for
> commit b7a3670131c7 ("i2c-pxa: Add polling transfer"). Its commit
> message says explicitly it was added "for cases where I2C transactions
> have to occur at times interrup[t]s are disabled". So, the intention was
> 'disabled interrupts'. This matches the use cases for atomic I2C
> transfers I have seen so far: very late communication (mostly to a PMIC)
> to powerdown or reboot the system. For those cases, interrupts are
> disabled then. It doesn't seem that in_atomic() adds value.
>
> After a discussion with Peter Zijlstra[2], we came up with a better set
> of conditionals to match the use case.
>
> The I2C core will soon gain an extra callback into bus drivers
> especially for atomic transfers to make them more generic. The code
> deciding which transfer to use (atomic/non-atomic) should mimic the
> behaviour which locking to use (trylock/lock). This is why we add a
> helper for it.
>
> [1] https://lwn.net/Articles/274695/
> [2] http://patchwork.ozlabs.org/patch/1067437/
>

Reviewed-by Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>  drivers/i2c/i2c-core-base.c |  2 +-
>  drivers/i2c/i2c-core.h      | 10 ++++++++++
>  2 files changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
> index 38af18645133..f8502064cd6b 100644
> --- a/drivers/i2c/i2c-core-base.c
> +++ b/drivers/i2c/i2c-core-base.c
> @@ -1946,7 +1946,7 @@ int i2c_transfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
>          *    one (discarding status on the second message) or errno
>          *    (discarding status on the first one).
>          */
> -       if (in_atomic() || irqs_disabled()) {
> +       if (i2c_in_atomic_xfer_mode()) {
>                 ret = i2c_trylock_bus(adap, I2C_LOCK_SEGMENT);
>                 if (!ret)
>                         /* I2C activity is ongoing. */
> diff --git a/drivers/i2c/i2c-core.h b/drivers/i2c/i2c-core.h
> index 37576f50fe20..9d8526415b26 100644
> --- a/drivers/i2c/i2c-core.h
> +++ b/drivers/i2c/i2c-core.h
> @@ -29,6 +29,16 @@ extern int           __i2c_first_dynamic_bus_num;
>
>  int i2c_check_7bit_addr_validity_strict(unsigned short addr);
>
> +/*
> + * We only allow atomic transfers for very late communication, e.g. to send
> + * the powerdown command to a PMIC. Atomic transfers are a corner case and not
> + * for generic use!
> + */
> +static inline bool i2c_in_atomic_xfer_mode(void)
> +{
> +       return system_state > SYSTEM_RUNNING && irqs_disabled();
> +}
> +
>  #ifdef CONFIG_ACPI
>  const struct acpi_device_id *
>  i2c_acpi_match_device(const struct acpi_device_id *matches,
> --
> 2.11.0
>


-- 
With Best Regards,
Andy Shevchenko
