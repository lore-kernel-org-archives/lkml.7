Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CE3FC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 17:33:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB62D218AC
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 17:33:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R2NhIdEX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729712AbfCORdb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 13:33:31 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35271 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727075AbfCORdb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 13:33:31 -0400
Received: by mail-pf1-f194.google.com with SMTP id j5so6837904pfa.2;
        Fri, 15 Mar 2019 10:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6VCuodCempRHMpLXtLwjzz17Sk36fzzR84+o7soKbUc=;
        b=R2NhIdEX0zHNt9ysaaAeebXBBiDYJI9QqlUMMFFg1IuTqf08z98TTVSZBK5rGyRxIT
         qFD9a/V2PADbPwa1mwvZTCcb4ynR2nEYprjY4vQkKP5ZkLD+FswKrxAAxzj4vZ0hkRIu
         EED1Kj/JzLOfMl3kI9M8Dpx+kDG1CPwlQnsEvNUsV8NBYBTb4V4k8onIPMJ6vvtU+U+H
         +6sd2XqJ/OrqV7eMB7qP9LTigLUnbu27mo7Kj6OdpGOnK/CguTMaPBc/WUSalLk6ziqz
         YSWjlolvaab1YOTjXFt0PYeRBX4DF1Ppd6GPVUiPJhOysk6e1RBm4eqPuVO8GLdzp90/
         sfYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6VCuodCempRHMpLXtLwjzz17Sk36fzzR84+o7soKbUc=;
        b=RQOJLKKnamfaH8WPg+GEfkJxExTZA5u1BPyIWDbC2P9LwYYxE4RGu+vBmRoCu3S53+
         hFv/OH8O9eIFI5S8wmsiJWvr9l1JhaK6e5ck27S3MDji8YhjXvoi7Eg6YRSbtuNgXCzQ
         S/usOkqKdOxrO+de99IanP5Rinoc29t+2kSs/TfqdT9jyw058uPM/O1aB58IeC5ba2Es
         xLhS3KndVXzn4BM1wpSlC74Xjmb96RA2A2XjDLMgDGTQSc47hfw6NkouSrzGar7PMF8m
         hKpJvpKnuY7R3DWN2BZx3ZsdXPjNYrT+UQ8AHkwz0+VXFG+8Lg8pjpFXRHJWUnN9FqQ7
         1R/w==
X-Gm-Message-State: APjAAAUvoXr8Z7S2O8NyhF8zE5JXNzzNHLcLjWq+d6J0df4XT3tQZCcj
        5CGMlQZxfGYnZ5mMIgYMd2ovuHBxMNyzjRHIXjFUUEtE
X-Google-Smtp-Source: APXvYqydkeoB1FsjQRgHSmySQy5Th/XxU709gEcmU5Xl+UdVxd93bhQpq92crMQ91b9xpUOEgXGJnZqQUpWIgGzvAlA=
X-Received: by 2002:a17:902:7289:: with SMTP id d9mr5455742pll.314.1552671210426;
 Fri, 15 Mar 2019 10:33:30 -0700 (PDT)
MIME-Version: 1.0
References: <20190315133113.21215-1-gabriel.lazar@com.utcluj.ro>
In-Reply-To: <20190315133113.21215-1-gabriel.lazar@com.utcluj.ro>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 15 Mar 2019 19:33:18 +0200
Message-ID: <CAHp75VeQ=6zD5tVV_gVE4S3CDWaYgQ0Lpqq57bxjQjqJYerUAQ@mail.gmail.com>
Subject: Re: [PATCH] platform/x86: touchscreen_dmi: Add info for Myria MY8307 2-in-1
To:     Gabriel Lazar <gabriel.lazar@com.utcluj.ro>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        linux-input <linux-input@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 15, 2019 at 3:31 PM Gabriel Lazar
<gabriel.lazar@com.utcluj.ro> wrote:
>
> Add touchscreen platform data for the Myrya MY8307 2-in-1 laptop.

You sent one patch twice or two patches?
Please, clarify this by sending v2 with correct subject line(s) and
amount of patches.

>
> Signed-off-by: Gabriel Lazar <gabriel.lazar@com.utcluj.ro>
> ---
>  drivers/platform/x86/touchscreen_dmi.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
>
> diff --git a/drivers/platform/x86/touchscreen_dmi.c b/drivers/platform/x86/touchscreen_dmi.c
> index 2d56ff7c8230..3319f0cbb558 100644
> --- a/drivers/platform/x86/touchscreen_dmi.c
> +++ b/drivers/platform/x86/touchscreen_dmi.c
> @@ -265,6 +265,23 @@ static const struct ts_dmi_data jumper_ezpad_mini3_data = {
>         .properties     = jumper_ezpad_mini3_props,
>  };
>
> +static const struct property_entry myria_my8307_props[] = {
> +       PROPERTY_ENTRY_U32("touchscreen-size-x", 1720),
> +       PROPERTY_ENTRY_U32("touchscreen-size-y", 1140),
> +       PROPERTY_ENTRY_BOOL("touchscreen-inverted-x"),
> +       PROPERTY_ENTRY_BOOL("touchscreen-inverted-y"),
> +       PROPERTY_ENTRY_BOOL("touchscreen-swapped-x-y"),
> +       PROPERTY_ENTRY_STRING("firmware-name", "gsl1680-myria-my8307.fw"),
> +       PROPERTY_ENTRY_U32("silead,max-fingers", 10),
> +       PROPERTY_ENTRY_BOOL("silead,home-button"),
> +       { }
> +};
> +
> +static const struct ts_dmi_data myria_my8307_data = {
> +       .acpi_name      = "MSSL1680:00",
> +       .properties     = myria_my8307_props,
> +};
> +
>  static const struct property_entry onda_obook_20_plus_props[] = {
>         PROPERTY_ENTRY_U32("touchscreen-size-x", 1728),
>         PROPERTY_ENTRY_U32("touchscreen-size-y", 1148),
> @@ -690,6 +707,14 @@ static const struct dmi_system_id touchscreen_dmi_table[] = {
>                         DMI_MATCH(DMI_PRODUCT_NAME, "FlexBook edge11 - M-FBE11"),
>                 },
>         },
> +       {
> +               /* Myria MY8307 */
> +               .driver_data = (void *)&myria_my8307_data,
> +               .matches = {
> +                       DMI_MATCH(DMI_SYS_VENDOR, "Complet Electro Serv"),
> +                       DMI_MATCH(DMI_PRODUCT_NAME, "MY8307"),
> +               },
> +       },
>         {
>                 /* Onda oBook 20 Plus */
>                 .driver_data = (void *)&onda_obook_20_plus_data,
> --
> 2.21.0
>


-- 
With Best Regards,
Andy Shevchenko
