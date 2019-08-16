Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0ADDC3A59C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 09:59:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B23F1206C2
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 09:59:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L40do2f9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727094AbfHPJ7v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 05:59:51 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40182 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726952AbfHPJ7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 05:59:50 -0400
Received: by mail-pg1-f196.google.com with SMTP id w10so2704309pgj.7;
        Fri, 16 Aug 2019 02:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3RJ868aXiPHULJtcDv/VZQGfR90IvOiVqFEipy9b2xc=;
        b=L40do2f9ImqUPtdVc6pnbgQHQgzZrgWZ39+TvoGzv0EqJVMK0KxOpZbXEyB1z6jRdg
         G4bc2BHnntvBcfkAOhs4IFErqYoXcWa/s4gWqhzhlNu5HNHnV4G7C9ceLqDMKXrnk5uS
         oExTx9VtLHUelOjCBTvIIlIDl33t2HvZxl0T0H9iw0sMS8uaiG3IhJ+lZcp/IjytAdrT
         DoRT7mh+rHgaMmYT32eRgYKzMMQvluW6uoNj5N4C8Y9A6vfVFRK5iFEfzmJMqsg04jB+
         7uPHbM6uZ6+UXezRqP/GUJIQqF3iRdHIht8sGcSlv2QUhCyjNCUN8BjdHNYoKZNXQJaS
         Jjww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3RJ868aXiPHULJtcDv/VZQGfR90IvOiVqFEipy9b2xc=;
        b=Ah0+65WB5SqQr7SZw+bRKqZUIYudAVor1F7pzdohhwEoe+Zqb005UH5D3NgbuMHMqx
         IsnCFrVjNZylHhPMVz6WOT5iyhqKJNVrUTYSHu2lz+/ik6r2hXnGvXhtST9f79IB3mZx
         flv6o1a4YccJKPpGHOmwzgd6oWxRWdNKY+TxnJjdyONWNHMOyg7qngl536h3aRC9ZJz/
         hSiBHB+l3RYgx1IE1cWXCG8Onl+GZGuuUjXgdKb4XDAgWh+wHEZY5e+Lcl4HqnnDCoTJ
         SzWQuXavVR8HigyLjnN9LaNOUa/zf49CWu3wPXo35vLvBTti4bM3HyVJ+yBK5Y0jC/Kh
         hoDg==
X-Gm-Message-State: APjAAAX77NbPTekWKln66+3M+CygDE+ejMa+1FMWfs9sGzNmJikPl01T
        lwC2JDwuULkxCcxnpJlTTiwMlUYILawngRZup78=
X-Google-Smtp-Source: APXvYqz/jejcp/XKd4st6yncAqLqt1NZT2rPWWBrnrERF2jUHt6XO6g6ViKqt+2EuXU0IW4/S8+3fzV40UVPsV+nEps=
X-Received: by 2002:a63:6eca:: with SMTP id j193mr6914701pgc.74.1565949589768;
 Fri, 16 Aug 2019 02:59:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190804134023.3495-1-hdegoede@redhat.com>
In-Reply-To: <20190804134023.3495-1-hdegoede@redhat.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 16 Aug 2019 12:59:38 +0300
Message-ID: <CAHp75VcmBdO8Wr95-p7xOfdhG4KwfSyCwQOUQnrThLhw_h7Yjw@mail.gmail.com>
Subject: Re: [PATCH] platform/x86: touchscreen_dmi: Add info for the Irbis
 TW90 tablet
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "russianneuromancer @ ya . ru" <russianneuromancer@ya.ru>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 4, 2019 at 4:40 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Add touchscreen info for the Irbis TW90 tablet.
>

Pushed to my review and testing queue, thanks!

> Reported-by: russianneuromancer@ya.ru
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/platform/x86/touchscreen_dmi.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>
> diff --git a/drivers/platform/x86/touchscreen_dmi.c b/drivers/platform/x86/touchscreen_dmi.c
> index 83dd6df674e8..20a943f519dd 100644
> --- a/drivers/platform/x86/touchscreen_dmi.c
> +++ b/drivers/platform/x86/touchscreen_dmi.c
> @@ -273,6 +273,24 @@ static const struct ts_dmi_data gp_electronic_t701_data = {
>         .properties     = gp_electronic_t701_props,
>  };
>
> +static const struct property_entry irbis_tw90_props[] = {
> +       PROPERTY_ENTRY_U32("touchscreen-size-x", 1720),
> +       PROPERTY_ENTRY_U32("touchscreen-size-y", 1138),
> +       PROPERTY_ENTRY_U32("touchscreen-min-x", 8),
> +       PROPERTY_ENTRY_U32("touchscreen-min-y", 14),
> +       PROPERTY_ENTRY_BOOL("touchscreen-inverted-y"),
> +       PROPERTY_ENTRY_BOOL("touchscreen-swapped-x-y"),
> +       PROPERTY_ENTRY_STRING("firmware-name", "gsl3680-irbis_tw90.fw"),
> +       PROPERTY_ENTRY_U32("silead,max-fingers", 10),
> +       PROPERTY_ENTRY_BOOL("silead,home-button"),
> +       { }
> +};
> +
> +static const struct ts_dmi_data irbis_tw90_data = {
> +       .acpi_name      = "MSSL1680:00",
> +       .properties     = irbis_tw90_props,
> +};
> +
>  static const struct property_entry itworks_tw891_props[] = {
>         PROPERTY_ENTRY_U32("touchscreen-min-x", 1),
>         PROPERTY_ENTRY_U32("touchscreen-min-y", 5),
> @@ -780,6 +798,14 @@ const struct dmi_system_id touchscreen_dmi_table[] = {
>                         DMI_MATCH(DMI_BIOS_VERSION, "itWORKS.G.WI71C.JGBMRB"),
>                 },
>         },
> +       {
> +               /* Irbis TW90 */
> +               .driver_data = (void *)&irbis_tw90_data,
> +               .matches = {
> +                       DMI_MATCH(DMI_SYS_VENDOR, "IRBIS"),
> +                       DMI_MATCH(DMI_PRODUCT_NAME, "TW90"),
> +               },
> +       },
>         {
>                 /* I.T.Works TW891 */
>                 .driver_data = (void *)&itworks_tw891_data,
> --
> 2.22.0
>


-- 
With Best Regards,
Andy Shevchenko
