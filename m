Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FFE0C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 13:48:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FBB22082C
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 13:48:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WY3RjWX6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728497AbfCENsM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 08:48:12 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46795 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727879AbfCENsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 08:48:12 -0500
Received: by mail-pf1-f195.google.com with SMTP id g6so5736396pfh.13;
        Tue, 05 Mar 2019 05:48:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B+D5XhN5s0MfTAN4ukLHZWqs3VDiDahZYvFB7Q5VuAg=;
        b=WY3RjWX6Z2BcW8DzwxuWPvTOUfB7MhkchcaTP93PBcmzt+k6UzTflOV6Uz82CRm5xk
         h4nDpmFj3M5S2mtOHmWdWBcDU3uRe3XhrqCy6kCUhy18EKen7fqgEQUBwUUYdYe42PM+
         9hX6UoE4a+RQP3DlANaaGoL7zFN6aZ06xqLYgfwZ29S/7P0zJ0dDKds9zfVe4TWiask/
         K7w8o2RRT3G5e1hu1B9ioDyqtBac2draIwUN5kKtZy6xlzqwr6IWV73SltIaH1xclWoC
         EYyaaf4ju12LrnihjUbLATyizE7onn93D629APoZMItZ3xe8XZ4z/p2yGb05vIQPAx0d
         FFuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B+D5XhN5s0MfTAN4ukLHZWqs3VDiDahZYvFB7Q5VuAg=;
        b=QZCaKIndRoQwx91r5I07DIePxa5vdWZOHgsSwSr3A95k83kcONwOAx9k7kNcAtdL7P
         GaRW1X+zZ2gK/kPXpYJ5oGP5Xlp+c/AAcsSuiMI1mOtbEmSOchglhIi/C0smxT5k0I57
         utiueCP4FhcsgEmLeYX/N0M0KMqiXRgbF/I9APsHuEGO+zwRY3xQjOe+G9XUVPigUbkd
         WQzRIRsKADnLlZa/7d1zxPqz7QNL9ESPJkE8yj+N2oaxjSXRrPeoenAduomGrjTD9Mi+
         jv5St7l9iIbA3gqd29Zkn65J009X3zGZ09bI5WXBNhAhiFDoqG5H+dNK7nN0xZwlngUC
         bgbw==
X-Gm-Message-State: APjAAAVBOQf+kUvCakPXdtzdWdRcT6JhZ42dQmg/mQps9tQYqKml2imO
        aCWNnwhJPUYqDyM03mQfzytaAGuroVWxI/CHS2A=
X-Google-Smtp-Source: APXvYqyfwE1fEDr8dYFn/x+nDE2eJILCR8FYXgoLI5tUkE/EGZFFJ79yGqRxbllbQpzleIiV2N7eT+JsrxD2HE7v2Zw=
X-Received: by 2002:a63:2907:: with SMTP id p7mr1464885pgp.161.1551793691471;
 Tue, 05 Mar 2019 05:48:11 -0800 (PST)
MIME-Version: 1.0
References: <20190305085521.25304-1-kai.heng.feng@canonical.com>
In-Reply-To: <20190305085521.25304-1-kai.heng.feng@canonical.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 5 Mar 2019 15:48:00 +0200
Message-ID: <CAHp75VfRGeJnggyMonVaUo-pEZV9zN-JV1rBU+ZtajDtOrAD1w@mail.gmail.com>
Subject: Re: [PATCH] platform/x86: ideapad-laptop: Add Ideapad 530S-14ARR to
 no_hw_rfkill list
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     Ike Panhc <ike.pan@canonical.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 5, 2019 at 10:55 AM Kai-Heng Feng
<kai.heng.feng@canonical.com> wrote:
>
> This platform doesn't have hardware switch for rfkill, so add it to
> no_hw_rfkill list to prevent wireless gets hard-blocked.
>
> https://bugs.launchpad.net/bugs/1818204
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

Pushed to my review and testing queue, thanks!

> ---
>  drivers/platform/x86/ideapad-laptop.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/platform/x86/ideapad-laptop.c b/drivers/platform/x86/ideapad-laptop.c
> index 1589dffab9fa..037970a1800a 100644
> --- a/drivers/platform/x86/ideapad-laptop.c
> +++ b/drivers/platform/x86/ideapad-laptop.c
> @@ -1090,6 +1090,13 @@ static const struct dmi_system_id no_hw_rfkill_list[] = {
>                         DMI_MATCH(DMI_PRODUCT_VERSION, "Lenovo ideapad 310-15ISK"),
>                 },
>         },
> +       {
> +               .ident = "Lenovo ideapad 530S-14ARR",
> +               .matches = {
> +                       DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> +                       DMI_MATCH(DMI_PRODUCT_VERSION, "Lenovo ideapad 530S-14ARR"),
> +               },
> +       },
>         {
>                 .ident = "Lenovo ideapad Y700-14ISK",
>                 .matches = {
> --
> 2.17.1
>


-- 
With Best Regards,
Andy Shevchenko
