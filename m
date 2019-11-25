Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 876D9C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 11:12:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A2E42082F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 11:12:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SkDbl5Ee"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727572AbfKYLMy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 06:12:54 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42151 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727395AbfKYLMx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 06:12:53 -0500
Received: by mail-pg1-f194.google.com with SMTP id q17so7015892pgt.9;
        Mon, 25 Nov 2019 03:12:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QfpO6+VriHjE6MTSEfJjnPs1DI4xFhz3n8jBm6AClVA=;
        b=SkDbl5EejLsawhQGIGbP5LNRgzNCp6dbSmbcvdoE77wCHVXh0MJ9OWgW+NA6YYmYvJ
         LXpTHhTDg5q4kC/VwCe2tUo5rBRUBPd7P5szZwLZDV0bAWSwFjWIjUs1JZp2K77jbLUX
         hXpurxr6KhK7y3douqB8NpWhhXKvxYh6InayiDiNeY9JW0RienG94z6GPp3lXqa0beCJ
         xqRAsU2UHHROtBrcHSeK52RW88MSjIll5B7wLPTdh+8ObkaF1H6EYM0ci9Pn6MNJ5ZRa
         IMn2Mzdr7SslIsudVbO7NJ3R8SXJeDwfFmTeIhMCOVHboA138y5t3Ep9nipx8I9LKKAE
         xodw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QfpO6+VriHjE6MTSEfJjnPs1DI4xFhz3n8jBm6AClVA=;
        b=TmBII9kkwaMAcJAaihntdp/GesuS2D2PC95lRUJkaTk/n8s3nUlsX+0G7uPz5mU3XJ
         Xxs/uynwLk8lNiAeeTVgVKf8W31/dkggmP1bqQDEqunMMNM1jCuKkqn8DzmjQUcJJJuV
         ht3zpoHxJliPtW863yGrS0OJPV1HBNllB9PaVsQFSs92WUA9QYKybp4lKdyfSEko4+KZ
         aIfwuo6ChkVVsDULcGqxIgJkl7/KKJVn1sMJLfh0uN0KyElN2+5Q5ojetuNNyZI1H+y+
         yeSck6WiRdwVZT/GAburWELdCbDiCiLHD4CcKX8EOpxlpmYWv2ryqCRu0zEkYDUWq2pN
         fxNg==
X-Gm-Message-State: APjAAAX0VGv0Ok6KQvODS9EeCrDn13aMuDt6dOf138QwzlXo+wq1zE0Q
        7Xmn7VcPdzVUVqADo1dkJhckkrOWh4jLYSWfwLA=
X-Google-Smtp-Source: APXvYqwOuqlvoScFSmIKOVDPZRulf63cB+znh4uPuBAVEUyd0Cj+R4rO9PNf5PXr0+IewxRhcl5Jl13BPejaBtMiOsw=
X-Received: by 2002:a65:5542:: with SMTP id t2mr30988775pgr.74.1574680373146;
 Mon, 25 Nov 2019 03:12:53 -0800 (PST)
MIME-Version: 1.0
References: <20191124140625.20736-1-leonmaxx@gmail.com> <20191124140744.20830-1-leonmaxx@gmail.com>
In-Reply-To: <20191124140744.20830-1-leonmaxx@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 25 Nov 2019 13:12:43 +0200
Message-ID: <CAHp75VcVj5=DQ8faTtC2CWk86-VMPGroQ+aCK+tLpkFEyPe-MQ@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] platform/x86 asus_wmi: Support throttle thermal policy
To:     Leonid Maksymchuk <leonmaxx@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        acpi4asus-user <acpi4asus-user@lists.sourceforge.net>,
        Chris Chiu <chiu@endlessm.com>,
        Kristian Klausen <kristian@klausen.dk>,
        Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Corentin Chary <corentin.chary@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 24, 2019 at 4:07 PM Leonid Maksymchuk <leonmaxx@gmail.com> wrote:
>
> Throttle thermal policy ACPI device is used to control CPU cooling and

> throttling. This patch adds sysfs entry for setting current mode and
> Fn+F5 hotkey that switches to next.

sysfs means ABI. ABI must be documented.

> Policy modes:
> * 0x00 - default
> * 0x01 - overboost
> * 0x02 - silent

> +static int throttle_thermal_policy_check_present(struct asus_wmi *asus)
> +{
> +       u32 result;
> +       int err;
> +
> +       asus->throttle_thermal_policy_available = false;
> +
> +       err = asus_wmi_get_devstate(asus,
> +                                   ASUS_WMI_DEVID_THROTTLE_THERMAL_POLICY,
> +                                   &result);
> +       if (err) {
> +               if (err == -ENODEV)
> +                       return 0;

> +               else

Redundant.

> +                       return err;
> +       }
> +

> +       if ((result & ASUS_WMI_DSTS_PRESENCE_BIT))

Too many parentheses.

> +               asus->throttle_thermal_policy_available = true;
> +
> +       return 0;
> +}

> +       pr_info("Set throttle thermal policy: %u\n", value);

Do we really need this message?

> +       return scnprintf(buf, PAGE_SIZE, "%d\n",
> +                        asus->throttle_thermal_policy_mode);

Can it be one line?

> +       result = kstrtou8(buf, 10, &new_mode);
> +       if (result < 0) {

> +               pr_warn("Trying to store invalid value\n");

Redundant. By error code user space will get a message.

> +               return result;
> +       }



-- 
With Best Regards,
Andy Shevchenko
