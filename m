Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C29C8C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 17:15:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91938206BA
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 17:15:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZJC2AhdO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729997AbfKGRPl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 12:15:41 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44215 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727132AbfKGRPl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 12:15:41 -0500
Received: by mail-pf1-f195.google.com with SMTP id q26so2973873pfn.11;
        Thu, 07 Nov 2019 09:15:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZrnrvjovC3aqTNqak27aggWsYvWoIu3bYN3JGt2+Qt4=;
        b=ZJC2AhdOvajdEQiS/g9J8KcfeyC1oD39dC+iDACNSo9jPZxqnzoRVVRnS9jjzIjaXY
         Ct5ZtGZscwAisnIvyUzl12jmx8Cg9sCmH2cXvGciB1mhXrUOOTA4chkRHz1Xdns+4ZvD
         AkS7itR+lLy9JNw3eRkQbO8oS0CVrndlKu9nKnT6wBQjBMQWg4gv2NVhYPhOxkLrlfxM
         AOaU+eNIcdBGjHTXYwuA40c4mR2GxW4sdYOAjU/wqoS4OH2ozq8pvHw/mopbMX9fXVDV
         xHh97lKBbBTd7/zdKW69sLkSIJTSUMqkRhycN8AL6VkMDQUlDfvV2y6YEIDQKC7gPbdz
         KSow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZrnrvjovC3aqTNqak27aggWsYvWoIu3bYN3JGt2+Qt4=;
        b=Bshz0HDbfGjx5/wFT1Mb5hSCUOrV9V0ubNO549Src24WkbKgpkWrgJyktMBsI6846r
         F6AM2CZw940NCjvaR7qQkudbqT6wm92ImlULp0PnPRTDyJRmfy0DeD4ghNzWLo3ziDRb
         UiA1tXzR+4n3PoEhklvPDIOl+WYeYFyaMjcG7snUaX7rDXHGomdO0z7u8GOBcWW59NYL
         +tMwrTFluFk/uJI10SfkCSrm38Qs4gNh0+A/pupb1qUw6AGV82p6tDlEAHkGlNBNmAyh
         MCFHLsujo+kwUIGjoj3RmYta6met7TCLID0PsNLL/MQRJhkDNa9S0nc3itH2WdMrHlIf
         O1gw==
X-Gm-Message-State: APjAAAVqAUK1X+HYOketY4pP7DCCkAzM5ojlAk92TWQJ3W5WUzcrUxkC
        FW5OpkfsleoF/YydzCuLwKf/E3DOzFFVOvYTxA8=
X-Google-Smtp-Source: APXvYqx2MfX6bvc66zcIX6xz7d5ceVYWDNE71sT4bWbHByywkg7iCaDjU4nirf9pMBFHXquBEV26c0HPS5K7yN5YyEk=
X-Received: by 2002:a63:3c6:: with SMTP id 189mr5749899pgd.4.1573146938852;
 Thu, 07 Nov 2019 09:15:38 -0800 (PST)
MIME-Version: 1.0
References: <20191104213417.18036-1-leonmaxx@gmail.com> <20191104213828.18278-1-leonmaxx@gmail.com>
In-Reply-To: <20191104213828.18278-1-leonmaxx@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 7 Nov 2019 19:15:28 +0200
Message-ID: <CAHp75VfNu_G7zzaCV9JF+Ua9otSTftJgtgr9N4qhQNR0o+QHtA@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] platform/x86: asus_wmi: Support fan boost mode on FX505DY/FX705DY
To:     Leonid Maksymchuk <leonmaxx@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        acpi4asus-user <acpi4asus-user@lists.sourceforge.net>,
        Chris Chiu <chiu@endlessm.com>,
        Yurii Pavlovskyi <yurii.pavlovskyi@gmail.com>,
        Kristian Klausen <kristian@klausen.dk>,
        Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Corentin Chary <corentin.chary@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 4, 2019 at 11:38 PM Leonid Maksymchuk <leonmaxx@gmail.com> wrote:
> On ASUS FX505DY/FX705DY laptops fan boost mode is same as in other
> TUF laptop models but have different ACPI device ID and different key
> code.

> +       if (err == 0 &&
> +                       (result & ASUS_WMI_DSTS_PRESENCE_BIT) &&
> +                       (result & ASUS_FAN_BOOST_MODES_MASK)) {
> +               asus->fan_boost_mode_available = 1;
> +               asus->fan_boost_mode_mask = result & ASUS_FAN_BOOST_MODES_MASK;
> +               return 0;
>         }
>
> -       if ((result & ASUS_WMI_DSTS_PRESENCE_BIT) &&
> +       err = asus_wmi_get_devstate(asus, ASUS_WMI_DEVID_FAN_BOOST_MODE_2,
> +                                   &result);
> +
> +       if (err == 0 &&
> +                       (result & ASUS_WMI_DSTS_PRESENCE_BIT) &&
>                         (result & ASUS_FAN_BOOST_MODES_MASK)) {
> -               asus->fan_boost_mode_available = true;
> +               asus->fan_boost_mode_available = 2;
>                 asus->fan_boost_mode_mask = result & ASUS_FAN_BOOST_MODES_MASK;
>         }

The above differs only in one value to give and one value to set, I
suppose you may introduce an additional helper to it

> +       if (err == -ENODEV)
> +               return 0;

This should be explained or even separated to another patch. It
changes behaviour of the original code, why?

> +       u32 dev_id = asus->fan_boost_mode_available == 1 ?
> +                       ASUS_WMI_DEVID_FAN_BOOST_MODE :
> +                       ASUS_WMI_DEVID_FAN_BOOST_MODE_2;

I would prefer to see
 if (...)
  call with mode
else
  call with mode_2

below.

> -       err = asus_wmi_set_devstate(ASUS_WMI_DEVID_FAN_BOOST_MODE, value,
> -                                   &retval);
> +       err = asus_wmi_set_devstate(dev_id, value, &retval);

-- 
With Best Regards,
Andy Shevchenko
