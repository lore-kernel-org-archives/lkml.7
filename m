Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94F2DC0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 17:40:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A8172087F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 17:40:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QYqMqliM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731373AbfG3Rkm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 13:40:42 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:41220 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728121AbfG3Rkm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 13:40:42 -0400
Received: by mail-io1-f66.google.com with SMTP id j5so125931733ioj.8
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 10:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BFeR4tAU5ONwRxrZH74vD9rAw7q+rir0LAtgn600pQo=;
        b=QYqMqliMOGNxlsIuyMiYTDi/8qLlryHF904OuiWIPby5+f+Zti2FYyn7bGij7xfWSc
         sZxvxYZjN1IgFmeo0Nr8e2FItipeC18I9dpXvWk2QV9e7Y4IEEn88pYVeKFt/J9VYEK8
         60bvc1Ljcp06AS/1bY3KfN39DgfYkIKnHr7zzhAH/Vvid9WNpeXdwIqXxM6SuFZo+wbg
         EvP+R2/sf76vXi55+Ib/CNpKNW4SCqDJg9yk2Dqa/tjnZF/BAl10c//pUbwi7/+TlfgR
         BriluIdEHMp17zMb8ChyGrvo/r2DT7ss5a877gh6nOb3Ht7IpjxiCbdZo3dmVL8FY0tR
         U6Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BFeR4tAU5ONwRxrZH74vD9rAw7q+rir0LAtgn600pQo=;
        b=HNbQVxmM7b9sdbpcrMMrst1ZC6GvbEe2ORtG1Pf5SqHpVGQXr75ACLudwMIy4/R9GF
         1HncoYpjD3ZfCKZd1BnGfNugcSlrWs8hg6RPGfBRT52ndC4HjkRjkVRXJ4Dr7gyE6Mhx
         ffDr96xYyXscR0V4J1vyXsWaNh7XdD3NRO2YOZi+1oN9dhpRfI8pQTXGQDtMw24NbXE5
         g3LCj1VgAVyrh7PPolTRGNA7o9F8K18XWT8KFfRHvcqxfb3lcGmmkZDMGZGR+xS8ohnl
         nq63BBgLSy+ILQPHg2hGtcm41Ywo6sDX+WQyBeXZYXEtiRHgykrEmjezqnS1N1a7yvn9
         H1Cg==
X-Gm-Message-State: APjAAAXHHJHbGCJtXqBe5hYCgdN7W7mP7WMtXK/mcsZPaq5Dmz8fxRs6
        mD7OoyYKQPXGOrzBBacCApq15UPeYMwAKBMnEipMwQ==
X-Google-Smtp-Source: APXvYqyFyzeZEgjdnOHpTCFYjQXdvTAFGxut6M5XUcyeytb3kogaKxVjONsRirs4U6naOSG1mOZAA9EZ8Zq62eP1is4=
X-Received: by 2002:a5e:c241:: with SMTP id w1mr101182344iop.58.1564508441663;
 Tue, 30 Jul 2019 10:40:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190726160839.12478-1-suzuki.poulose@arm.com>
In-Reply-To: <20190726160839.12478-1-suzuki.poulose@arm.com>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Tue, 30 Jul 2019 11:40:30 -0600
Message-ID: <CANLsYkzFY_N=JfgJ2fOcA3SDKHXL1+cGvPN_-3r4hD-_G=49Ow@mail.gmail.com>
Subject: Re: [PATCH] coresight: acpi: Static funnel support
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Coresight ML <coresight@lists.linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Jul 2019 at 10:08, Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
>
> The ACPI bindings for CoreSight has been updated to add the device
> id for non-programmable CoreSight funnels (aka static funnels) as of
> v1.1 [0]. Add the ACPI id for static funnels in the driver.
>
> [0] https://static.docs.arm.com/den0067/a/DEN0067_CoreSight_ACPI_1.1.pdf
>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  drivers/hwtracing/coresight/coresight-funnel.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/drivers/hwtracing/coresight/coresight-funnel.c b/drivers/hwtracing/coresight/coresight-funnel.c
> index fa97cb9ab4f9..0c99848a5d69 100644
> --- a/drivers/hwtracing/coresight/coresight-funnel.c
> +++ b/drivers/hwtracing/coresight/coresight-funnel.c
> @@ -5,6 +5,7 @@
>   * Description: CoreSight Funnel driver
>   */
>
> +#include <linux/acpi.h>
>  #include <linux/kernel.h>
>  #include <linux/init.h>
>  #include <linux/types.h>
> @@ -302,11 +303,19 @@ static const struct of_device_id static_funnel_match[] = {
>         {}
>  };
>
> +#ifdef CONFIG_ACPI
> +static const struct acpi_device_id static_funnel_ids[] = {
> +       {"ARMHC9FE", 0},
> +       {},
> +};
> +#endif
> +
>  static struct platform_driver static_funnel_driver = {
>         .probe          = static_funnel_probe,
>         .driver         = {
>                 .name   = "coresight-static-funnel",
>                 .of_match_table = static_funnel_match,
> +               .acpi_match_table = ACPI_PTR(static_funnel_ids),
>                 .pm     = &funnel_dev_pm_ops,
>                 .suppress_bind_attrs = true,
>         },

I haved also applied this patch.

Mathieu

> --
> 2.21.0
>
