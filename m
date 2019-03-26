Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0AF6C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 21:49:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9793620700
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 21:49:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553636984;
	bh=v+HKbO1ok06lJiUV79eBSbe4T2bXO4tAdvDPTy/p/Nk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=nbSpj3ZGKfL2t3kwpUU0EXX7B9p/T/yV2S1rwh5S54L8kOU6N2Ejt0p5F5VYFKDNE
	 dt487q4E+UNk/OS5RdtwYdKBxvG5MF7lrxRvlVh9tXpeFB+pvEjscFthBgoRntu4we
	 lRm8vnLRgVFuZFDAVpW3hQFFT6WaUj10j1h4384g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732436AbfCZVtn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 17:49:43 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:33247 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731589AbfCZVtn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 17:49:43 -0400
Received: by mail-ot1-f68.google.com with SMTP id j10so6511765otq.0;
        Tue, 26 Mar 2019 14:49:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ckZMXmgmcgR8XrCw5AW2X6vn32D44/9t62wX0hdzI64=;
        b=T8z8/hHhc10aEYB3t6+SoIfRsXIx/AEhiOTJRg4Nkyxm91xyzpNmOrH1OGrXRc205/
         KXHjkEQLOra9emSgIGTWx8WCDlu6YJPFFbUY755tsSZSYeiu1WvVfF9CJqkiEkHI/3co
         Ht0jF9o2Z6+LOZhSlP6gC+2ztQbz0AL3ZZNYX8a6DP8Br5HKdcoIVfsoF7m+NaFjvL50
         b4vvjuHT/xF1iNrxCFOVlOHsiyQYjCMVLn+9yFcEiEDSq5wI66qP1Qpv//r9jE9JfhCC
         d8PTaifC0BOD+L6NrJG3ImqErwtAF29qPyKftnMYHnntv78KsEHnB5d36crxGsIpwLPK
         hiWA==
X-Gm-Message-State: APjAAAWdpW98yRJTd6GVEtijnQ29GSgwFkp5n7A3LNjgEr5jutlIiYZd
        nkIpwH4Xv0A0iSoIUYTjExS/i1OP8CJ5bLtlxgg=
X-Google-Smtp-Source: APXvYqwMVrFpkWC0q/izSo0WvL3ml8k5ylijCi2p16CLLSDNhQwt63FEPflO30zUs8BFN3kgQozMfCeRzcxbX/+0uWc=
X-Received: by 2002:a9d:6498:: with SMTP id g24mr24900948otl.343.1553636982407;
 Tue, 26 Mar 2019 14:49:42 -0700 (PDT)
MIME-Version: 1.0
References: <20190304030022.22492-1-hu1.chen@intel.com>
In-Reply-To: <20190304030022.22492-1-hu1.chen@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 26 Mar 2019 22:49:32 +0100
Message-ID: <CAJZ5v0g3+S0vkW0XTzMKA8rYCtgy7yJ+UDc5xG4rRcdTbcJ=Lg@mail.gmail.com>
Subject: Re: [PATCH] ACPI / PM: Propagate KEY_POWER wakeup events to user space
To:     "Chen, Hu" <hu1.chen@intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 4, 2019 at 4:18 AM Chen, Hu <hu1.chen@intel.com> wrote:
>
> When the system is woken from S3 by the ACPI fixed power button, send
> KEY_POWER to user space.
>
> I run Android on x86 PC (it's a NUC). Everytime I press the power button
> to wake the system, it suspends right away. After some debug, I find
> that Android wants to see KEY_POWER at resume. Otherwise, its
> opportunistic suspend will kick in shortly.

Alas that extra button event will cause other (non-Android) systems to
want to power off immediately after resume AFAICS.

Something else needs to be done for the Android case.

> Signed-off-by: Chen, Hu <hu1.chen@intel.com>
> ---
>  drivers/acpi/button.c | 4 +++-
>  drivers/acpi/sleep.c  | 8 ++++++++
>  2 files changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
> index a19ff3977ac4..117718057938 100644
> --- a/drivers/acpi/button.c
> +++ b/drivers/acpi/button.c
> @@ -33,6 +33,7 @@
>  #include <linux/acpi.h>
>  #include <linux/dmi.h>
>  #include <acpi/button.h>
> +#include <linux/suspend.h>
>
>  #define PREFIX "ACPI: "
>
> @@ -417,7 +418,8 @@ static void acpi_button_notify(struct acpi_device *device, u32 event)
>                         int keycode;
>
>                         acpi_pm_wakeup_event(&device->dev);
> -                       if (button->suspended)
> +                       if (button->suspended &&
> +                           mem_sleep_current == PM_SUSPEND_TO_IDLE)
>                                 break;
>
>                         keycode = test_bit(KEY_SLEEP, input->keybit) ?
> diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
> index 403c4ff15349..c5dcee9f5872 100644
> --- a/drivers/acpi/sleep.c
> +++ b/drivers/acpi/sleep.c
> @@ -462,6 +462,13 @@ static int find_powerf_dev(struct device *dev, void *data)
>         return !strcmp(hid, ACPI_BUTTON_HID_POWERF);
>  }
>
> +static void pwr_btn_notify(struct device *dev)
> +{
> +       struct acpi_device *device = to_acpi_device(dev);
> +
> +       device->driver->ops.notify(device, ACPI_FIXED_HARDWARE_EVENT);
> +}
> +
>  /**
>   *     acpi_pm_finish - Instruct the platform to leave a sleep state.
>   *
> @@ -505,6 +512,7 @@ static void acpi_pm_finish(void)
>                                       find_powerf_dev);
>         if (pwr_btn_dev) {
>                 pm_wakeup_event(pwr_btn_dev, 0);
> +               pwr_btn_notify(pwr_btn_dev);
>                 put_device(pwr_btn_dev);
>         }
>  }
> --
> 2.20.1
>
