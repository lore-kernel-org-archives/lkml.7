Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 928EAC31E47
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 15:12:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7681920874
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 15:12:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbfFLPME (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 11:12:04 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:35408 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408635AbfFLPME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 11:12:04 -0400
Received: by mail-qk1-f195.google.com with SMTP id l128so10508087qke.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 08:12:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w6yEZrHOYLo+3p9iSZ2w8TKW5Sdr4j5I7ju6ZqEBMcc=;
        b=djyOLQZNJqxyDl2mm8By1aW85Z2bA0RWMBD96dzJS5+6eiaJsHbuEzNlB68fAbkwGK
         dyy/SCE3ED1KObGPA7c5kGt/8Qkqw/ljfvcdl72WyHclxDuNI7Msxfa88BWhilGFO8Ts
         UOGUkU8482q4m3qvEAvzH3kakBJ/gCX5EPu5mF2L2Hn/75C9BdTvZDVsLnz856m3Pv/d
         gMvXKqvhQXX/+5CyBFFmvPxksLtx2RPWX2pH4dHANLAA0oatj4Ip4UDEv1+y6ijdtLvj
         HgqYSU452KzQVbTJx6iLOMHyIJbzRrMqYcb8cRJYFdZfeAgETAWdia1uto10cS4yJzTC
         oP7A==
X-Gm-Message-State: APjAAAWOs+fRZs1P/9rJQ/WWTXiSE6obnNBkepXuVSbrMYW56jds7zii
        YxBf9iXDZe9DaNdhoDzbmnJjR3CmRMj0DLDO+AV3DA==
X-Google-Smtp-Source: APXvYqxKeBWTjJVI0i84baN2jdhQPmMHHmytl1Q8GlFj+zSh7Zf24ZUb6OAIY6TwL9A1Fmm77xJcFxV+24MQRLPaAXM=
X-Received: by 2002:a05:620a:1497:: with SMTP id w23mr67415173qkj.49.1560352323294;
 Wed, 12 Jun 2019 08:12:03 -0700 (PDT)
MIME-Version: 1.0
References: <20190611123101.25264-1-ckeepax@opensource.cirrus.com> <20190611123101.25264-5-ckeepax@opensource.cirrus.com>
In-Reply-To: <20190611123101.25264-5-ckeepax@opensource.cirrus.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Wed, 12 Jun 2019 17:11:51 +0200
Message-ID: <CAO-hwJLz1TE5RcBJwVCxa9vWzNk9-mX=4quaWtrXv33kegqRrA@mail.gmail.com>
Subject: Re: [PATCH v4 4/7] i2c: core: Make i2c_acpi_get_irq available to the
 rest of the I2C core
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     Wolfram Sang <wsa@the-dreams.de>, mika.westerberg@linux.intel.com,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux I2C <linux-i2c@vger.kernel.org>,
        linux-acpi@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>,
        Jim Broadus <jbroadus@gmail.com>, patches@opensource.cirrus.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 11, 2019 at 2:31 PM Charles Keepax
<ckeepax@opensource.cirrus.com> wrote:
>
> In preparation for more refactoring make i2c_acpi_get_irq available
> outside i2c-core-acpi.c.
>
> Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> ---

So, my bisect fails here: when I recompile the vmlinuz image, it fails
after loading the initrd. There is no boot up message, so not sure,
but the problem with the non working touchpad is either this one or
the next one.

Cheers,
Benjamin

>
> Changes since v3:
>  - Move the change to use the helper function from i2c-core-base into its own patch.
>
> Thanks,
> Charles
>
>  drivers/i2c/i2c-core-acpi.c | 15 +++++++++++++--
>  drivers/i2c/i2c-core.h      |  7 +++++++
>  2 files changed, 20 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/i2c/i2c-core-acpi.c b/drivers/i2c/i2c-core-acpi.c
> index 7d4d66ba752d4..35966cc337dde 100644
> --- a/drivers/i2c/i2c-core-acpi.c
> +++ b/drivers/i2c/i2c-core-acpi.c
> @@ -144,8 +144,17 @@ static int i2c_acpi_add_resource(struct acpi_resource *ares, void *data)
>         return 1; /* No need to add resource to the list */
>  }
>
> -static int i2c_acpi_get_irq(struct acpi_device *adev)
> +/**
> + * i2c_acpi_get_irq - get device IRQ number from ACPI
> + * @client: Pointer to the I2C client device
> + *
> + * Find the IRQ number used by a specific client device.
> + *
> + * Return: The IRQ number or an error code.
> + */
> +int i2c_acpi_get_irq(struct i2c_client *client)
>  {
> +       struct acpi_device *adev = ACPI_COMPANION(&client->adapter->dev);
>         struct list_head resource_list;
>         int irq = -ENOENT;
>         int ret;
> @@ -162,6 +171,8 @@ static int i2c_acpi_get_irq(struct acpi_device *adev)
>         return irq;
>  }
>
> +static struct i2c_client *i2c_acpi_find_client_by_adev(struct acpi_device *adev);
> +
>  static int i2c_acpi_get_info(struct acpi_device *adev,
>                              struct i2c_board_info *info,
>                              struct i2c_adapter *adapter,
> @@ -198,7 +209,7 @@ static int i2c_acpi_get_info(struct acpi_device *adev,
>                 *adapter_handle = lookup.adapter_handle;
>
>         /* Then fill IRQ number if any */
> -       ret = i2c_acpi_get_irq(adev);
> +       ret = i2c_acpi_get_irq(i2c_acpi_find_client_by_adev(adev));
>         if (ret > 0)
>                 info->irq = ret;
>
> diff --git a/drivers/i2c/i2c-core.h b/drivers/i2c/i2c-core.h
> index 2a3b28bf826b1..517d98be68d25 100644
> --- a/drivers/i2c/i2c-core.h
> +++ b/drivers/i2c/i2c-core.h
> @@ -63,6 +63,8 @@ const struct acpi_device_id *
>  i2c_acpi_match_device(const struct acpi_device_id *matches,
>                       struct i2c_client *client);
>  void i2c_acpi_register_devices(struct i2c_adapter *adap);
> +
> +int i2c_acpi_get_irq(struct i2c_client *client);
>  #else /* CONFIG_ACPI */
>  static inline void i2c_acpi_register_devices(struct i2c_adapter *adap) { }
>  static inline const struct acpi_device_id *
> @@ -71,6 +73,11 @@ i2c_acpi_match_device(const struct acpi_device_id *matches,
>  {
>         return NULL;
>  }
> +
> +static inline int i2c_acpi_get_irq(struct i2c_client *client)
> +{
> +       return 0;
> +}
>  #endif /* CONFIG_ACPI */
>  extern struct notifier_block i2c_acpi_notifier;
>
> --
> 2.11.0
>
