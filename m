Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22B0BCA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 12:39:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E95A12084C
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 12:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571920754;
	bh=mmazZYdk5a6LhHAGNiJ4hLIx0tAfhGRJnKAr4K7eECY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=AUr6ljPVZm03huXKM0awRfQGbg8oYgD/IWWyJR9TB+zB5Ro9YsNGDAo+PcE6CSPUW
	 sAGsEn6cAGw/rGzAqHK/xud37DJJzy9XMZ57e0BTIjZc6CMuixIty/71Gb/trJkpFE
	 wMhr6Z7g/z5l+Pad/Hlgz4aDW+lJQEPhAkbn11QA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2501973AbfJXMjM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 08:39:12 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:45830 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726659AbfJXMjM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 08:39:12 -0400
Received: by mail-ot1-f67.google.com with SMTP id 41so20478255oti.12
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 05:39:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h/Ozpin6WAJYhCs7IuxGEPTaFDrBNPxT2ybsEoTgZa8=;
        b=VRa08cahs+XeKWz1yxbvfYDYbyCZuchC1Gqd+ykGczLQhf2jcdZQTetjFMWFylZ2EC
         RVnM4L15fI06E9ZYj85Ui21VImiCIb1r5DYCRq4E+XN8/Pwg9npcZWV120ZwoiuCIxRu
         QSCplAgfe1psaL85jdwfCmUpoRsMSYsfU8PHWG4g+cYT7AYld9nBT5mr9LrEn7G6LeNI
         Z09oXxecaFHwq2xcjwbs0Y6WB+iTRn7mtPxFeXcVt+C5RJJgZ+cZz0/h06eKBJTF25Gt
         mJgBZr4hxwazgymiUNnBf5yu7vaeVqRCdHAiE3Z23YdT/AL4sAWCkJ6hHXgPPJ9Jui0M
         ut4g==
X-Gm-Message-State: APjAAAXZnspAntKiunIs65C6olNwDDP7Y/zpJhh4N4EFJP2mDl5x6Pqu
        FOgsoyp65Aeu4lxrTnzAoUUeuQTNOvhThMKGyXM=
X-Google-Smtp-Source: APXvYqw0Ig2z1uuW9alu3vhqiC0nMabAO0elG1y20TV13hU8hqVTNjUIi4wsceW9yCuJQGS6MLGKCernIca5rkJjg6w=
X-Received: by 2002:a9d:459b:: with SMTP id x27mr10908377ote.167.1571920749753;
 Thu, 24 Oct 2019 05:39:09 -0700 (PDT)
MIME-Version: 1.0
References: <20191023122505.64684-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20191023122505.64684-1-andriy.shevchenko@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 24 Oct 2019 14:38:57 +0200
Message-ID: <CAJZ5v0j5UH52ze=wL_kc394ojaudkaAKGp5=x6-bq4dEnPHp-g@mail.gmail.com>
Subject: Re: [PATCH v1] driver core: platform: Declare ret variable only once
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 23, 2019 at 2:25 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> We may define ret variable only once and avoid adding it each time
> platform_get_irq_optional() get extended.
>
> For the sake of consistency do the same in __platform_get_irq_byname().
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Fine by me:

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  drivers/base/platform.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/base/platform.c b/drivers/base/platform.c
> index e0ca682a756d..dad9806875f7 100644
> --- a/drivers/base/platform.c
> +++ b/drivers/base/platform.c
> @@ -106,9 +106,9 @@ int platform_get_irq_optional(struct platform_device *dev, unsigned int num)
>         return dev->archdata.irqs[num];
>  #else
>         struct resource *r;
> -       if (IS_ENABLED(CONFIG_OF_IRQ) && dev->dev.of_node) {
> -               int ret;
> +       int ret;
>
> +       if (IS_ENABLED(CONFIG_OF_IRQ) && dev->dev.of_node) {
>                 ret = of_irq_get(dev->dev.of_node, num);
>                 if (ret > 0 || ret == -EPROBE_DEFER)
>                         return ret;
> @@ -117,8 +117,6 @@ int platform_get_irq_optional(struct platform_device *dev, unsigned int num)
>         r = platform_get_resource(dev, IORESOURCE_IRQ, num);
>         if (has_acpi_companion(&dev->dev)) {
>                 if (r && r->flags & IORESOURCE_DISABLED) {
> -                       int ret;
> -
>                         ret = acpi_irq_get(ACPI_HANDLE(&dev->dev), num, r);
>                         if (ret)
>                                 return ret;
> @@ -151,8 +149,7 @@ int platform_get_irq_optional(struct platform_device *dev, unsigned int num)
>          * allows a common code path across either kind of resource.
>          */
>         if (num == 0 && has_acpi_companion(&dev->dev)) {
> -               int ret = acpi_dev_gpio_irq_get(ACPI_COMPANION(&dev->dev), num);
> -
> +               ret = acpi_dev_gpio_irq_get(ACPI_COMPANION(&dev->dev), num);
>                 /* Our callers expect -ENXIO for missing IRQs. */
>                 if (ret >= 0 || ret == -EPROBE_DEFER)
>                         return ret;
> @@ -240,10 +237,9 @@ static int __platform_get_irq_byname(struct platform_device *dev,
>                                      const char *name)
>  {
>         struct resource *r;
> +       int ret;
>
>         if (IS_ENABLED(CONFIG_OF_IRQ) && dev->dev.of_node) {
> -               int ret;
> -
>                 ret = of_irq_get_byname(dev->dev.of_node, name);
>                 if (ret > 0 || ret == -EPROBE_DEFER)
>                         return ret;
> --
> 2.23.0
>
