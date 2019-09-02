Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58E0FC3A59E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 22:05:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27E7121883
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 22:05:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kJNxvgSJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727802AbfIBWF3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 18:05:29 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44906 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727775AbfIBWF3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 18:05:29 -0400
Received: by mail-pg1-f195.google.com with SMTP id i18so7981365pgl.11;
        Mon, 02 Sep 2019 15:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qheEaqbo7JPkZrd6C0f084OuMiH7jmWGMxuDz2HD13Q=;
        b=kJNxvgSJhbmsCH9tyXj23F4iPNyvuMKdcr8FWc6ZElFc18oDscBjGvhUJ3PDIDa9iU
         CWGMW8m0sfdiBv6oQKDmlHwGdaRrbDDsSk1fiYkdJiljmZ8bD7aeFxodRED39OPOciID
         kLhBZ/GpY30Oz0enJF9Tbps8pXSxb2zZa/a+7X25NXaJIwMhskAZpads3GF8jKVbCzfF
         UG8UVILu8KHtxM6J0I7uiUfloT06mcdkspYdZgQ0xGhU8fL+/BZx9oHrTNHxNAeR7vBX
         A5nGgwQHMq09NTH3jOsTZQ+wYO2v2VcMfL9uUY6cVdKftHC1eM0ubd/k8F27n+hIQ6NZ
         NMUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qheEaqbo7JPkZrd6C0f084OuMiH7jmWGMxuDz2HD13Q=;
        b=X37D1YaYWRl4XNzEi9PGkRIIwE92izMHJz/fcZ7ybEaegTPueofKx8nuNt81YV+KDu
         naCCjQ1N0jyySaNg5CMz6r2fzn70B0oL523fR1oNHGEKCseDTlTwrR5MDQDg1w+VJk6d
         +VY1NIU5NV+SMCf67/dKOtbqR82aL5UPjbK3Tsw07NwPi/LGLoyjCu9yV7KLccleOJI1
         bIAlcqtkTGvQsu4tg/CoH7qbVXLtCRvHMcg9OgV7SwwjrdkQD5S2fvUqB+lJjrhBJ/tt
         sdio1vQmikcXMNRzBjhagCUOFdI2Q+FKOMV0n6b0gJWx26ZSSG0r20DgQauzDgy0dJRU
         C1DQ==
X-Gm-Message-State: APjAAAVxm4w3Xd2pxQmY9avLINSRPkQnXffNRMOS1rw2TBOfVmXP0y+Z
        X9JPWKZf341gqbNJKh5AqpGjPr1NFXtve+Sa3zU=
X-Google-Smtp-Source: APXvYqyasWDR1xLzwKeqcueQCv5COBd18dK6l6Wtf8Qyqbkz2ADCtnVUtROABP8V561xswifjBnUL/RTRzK3s2Ew4Qs=
X-Received: by 2002:a17:90a:bf01:: with SMTP id c1mr15294811pjs.30.1567461928498;
 Mon, 02 Sep 2019 15:05:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190830022542.8571-1-benchuanggli@gmail.com>
In-Reply-To: <20190830022542.8571-1-benchuanggli@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 3 Sep 2019 01:05:16 +0300
Message-ID: <CAHp75Vfx4FukybSjQjiNNQpHUNQrUsvwOen4ibqxOONKTJNxww@mail.gmail.com>
Subject: Re: [PATCH V7 5/5] mmc: host: sdhci-pci: Add Genesys Logic GL975x support
To:     Ben Chuang <benchuanggli@gmail.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        johnsonm@danlj.org, ben.chuang@genesyslogic.com.tw
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 30, 2019 at 5:28 AM Ben Chuang <benchuanggli@gmail.com> wrote:
>
> From: Ben Chuang <ben.chuang@genesyslogic.com.tw>
>
> Add support for the GL9750 and GL9755 chipsets.
>
> Enable v4 mode and wait 5ms after set 1.8V signal enable for GL9750/
> GL9755. Fix the value of SDHCI_MAX_CURRENT register and use the vendor
> tuning flow for GL9750.
>

> Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>

Usually last one for latest developer / submitter goes on.

> Co-developed-by: Michael K Johnson <johnsonm@danlj.org>
> Signed-off-by: Michael K Johnson <johnsonm@danlj.org>


> +#define GLI_MAX_TUNING_LOOP 40


> +static void gli_set_9750(struct sdhci_host *host)
> +{
> +       u32 driving_value = 0;
> +       u32 pll_value = 0;
> +       u32 sw_ctrl_value = 0;
> +       u32 misc_value = 0;
> +       u32 parameter_value = 0;
> +       u32 control_value = 0;

> +

Redundant blank line.

> +       u16 ctrl2 = 0;

Do you need these all assignments above?

> +       driving_value = sdhci_readl(host, SDHCI_GLI_9750_DRIVING);
> +       pll_value = sdhci_readl(host, SDHCI_GLI_9750_PLL);
> +       sw_ctrl_value = sdhci_readl(host, SDHCI_GLI_9750_SW_CTRL);
> +       misc_value = sdhci_readl(host, SDHCI_GLI_9750_MISC);
> +       parameter_value = sdhci_readl(host, SDHCI_GLI_9750_TUNING_PARAMETERS);
> +       control_value = sdhci_readl(host, SDHCI_GLI_9750_TUNING_CONTROL);



> +
> +       udelay(1);

This misses the answer to question why. Why this is needed and why
timeout is this long?

> +
> +       gl9750_wt_off(host);
> +}

> +static int __sdhci_execute_tuning_9750(struct sdhci_host *host, u32 opcode)
> +{
> +       int i;

> +       int rx_inv = 0;

Duplicate assignment.

> +
> +       for (rx_inv = 0; rx_inv < 2; rx_inv++) {

> +               if (rx_inv & 0x1)
> +                       gli_set_9750_rx_inv(host, true);
> +               else
> +                       gli_set_9750_rx_inv(host, false);

gli_set_...(host, !!rx_inv);

> +
> +               sdhci_start_tuning(host);
> +
> +               for (i = 0; i < GLI_MAX_TUNING_LOOP; i++) {
> +                       u16 ctrl;
> +
> +                       sdhci_send_tuning(host, opcode);
> +
> +                       if (!host->tuning_done) {

> +                               if (rx_inv == 1) {

It's an invariant to the loop. So, you may do this check after outter loop.

> +                                       pr_info("%s: Tuning timeout, falling back to fixed sampling clock\n",
> +                                               mmc_hostname(host->mmc));

> +                                       sdhci_abort_tuning(host, opcode);

It will also de-duplicates this call.

> +                                       return -ETIMEDOUT;
> +                               }
> +                               sdhci_abort_tuning(host, opcode);
> +                               break;
> +                       }

> +               }
> +       }
> +
> +       pr_info("%s: Tuning failed, falling back to fixed sampling clock\n",
> +               mmc_hostname(host->mmc));
> +       sdhci_reset_tuning(host);
> +       return -EAGAIN;
> +}

> +static void sdhci_gli_voltage_switch(struct sdhci_host *host)
> +{

Any comment why?

> +       usleep_range(5000, 5500);
> +}

> +static u32 sdhci_gl9750_readl(struct sdhci_host *host, int reg)
> +{
> +       u32 value;
> +
> +       value = readl(host->ioaddr + reg);

> +       if (unlikely(reg == SDHCI_MAX_CURRENT)) {
> +               if (!(value & 0xff))
> +                       value |= 0xc8;
> +       }

if (a) {
 if (b) {
   ...
 }
}

is the same as

if (a && b) {
 ...
}

> +       return value;
> +}

> +#define PCI_DEVICE_ID_GLI_9755         0x9755
> +#define PCI_DEVICE_ID_GLI_9750         0x9750

-- 
With Best Regards,
Andy Shevchenko
