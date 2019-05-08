Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2487AC04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 13:26:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E74BB20644
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 13:26:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GOs3Uazw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727272AbfEHN0B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 09:26:01 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45164 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726600AbfEHN0B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 09:26:01 -0400
Received: by mail-pg1-f196.google.com with SMTP id i21so10096378pgi.12;
        Wed, 08 May 2019 06:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RMhJ9x36R3gdVTT73uZINt5ih7RyEduBXnV9LO7/Mfo=;
        b=GOs3UazwyohF899j7o+bxl2A+D9tyQu2g0HE0TfEsi6cqi6qos6fyWneCG53ElOFCL
         PTrPf6L/7V6G90PSt1LuU4KptzIVB5Boj8yBZj76IofDS8shQHZ2rILeB+MgFjSzz5CI
         HlZUour78mIn54ZbbQ5fORqfC6nu4n6ETrXXBgkRHj9iJ4yfqBEB7h5UUy5Zoz0o1ZAN
         yqOXpEmlUfvOZQW+b/mEydYE7943mIhVZpGNxhazScu9ZFJ90BNkym4k6G/lvQBv+T4z
         ykZ4btBmWGouEkRfWziOxVRMozJXE/9iWYptNhs5t5BE4vaDelLMu9ri7mhzeKpAJErG
         OLsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RMhJ9x36R3gdVTT73uZINt5ih7RyEduBXnV9LO7/Mfo=;
        b=kL4HM4n4fNp3Cx2J7CSbuLNwgKALfIFlg+eLhOr1ak8SnTS4oyoRou6CZ4RVEPE5cY
         7z0c1GBfzY062Nt+mRGJV2kMd+OdnOdNZqDiWkgwvsFD9c3ir4ZoOHkdSucnVb5d4+UZ
         QsqXVdAQavqJ33FgRwlkVAEInXkjAUYMW6xmWqYuOqZU9IMV9AuXvJJPMdlkTPc+jMxK
         8b2IuS9/qXEOX1AtArsHUivzQ355UMeAcQUoS0ENhlY6xQnzPdbd/IG+g6Hk/IPCUqdF
         zqt1Q0gZmncULPrt4cfno24VKVbMTuaOChtTtWQzUy33qtKtLqjuNuo9wpl0zLUp7EIo
         gWTQ==
X-Gm-Message-State: APjAAAVyAO9MTwYD0reIYGOdVdicQfymumcq/nK/TCLAdtLDxEwEiGGR
        i+KFzm4NyL/O1KHIT3nHx3A+xBqX5roeueMDVNc=
X-Google-Smtp-Source: APXvYqx3nJR0axM9U3dMtsXTiI+kVbLrSnBN9zG+3G7GpDhgvYXizTk7QydOGv9vvFa1aK2qnb05vyk7ovjOJhRL3nc=
X-Received: by 2002:a63:8e4b:: with SMTP id k72mr15123716pge.428.1557321960027;
 Wed, 08 May 2019 06:26:00 -0700 (PDT)
MIME-Version: 1.0
References: <7acd57fe-604a-a96a-4ca2-a25bc88d6405@gmail.com> <a548ce35-5bbc-1c61-2a52-808462000091@gmail.com>
In-Reply-To: <a548ce35-5bbc-1c61-2a52-808462000091@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 8 May 2019 16:25:49 +0300
Message-ID: <CAHp75VeNSUniQtEmf9z1EGPun_3p1DZ_viXYXiAyDouU0s3uHg@mail.gmail.com>
Subject: Re: [PATCH v3 01/11] platform/x86: asus-wmi: Fix hwmon device cleanup
To:     Yurii Pavlovskyi <yurii.pavlovskyi@gmail.com>
Cc:     Corentin Chary <corentin.chary@gmail.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Daniel Drake <drake@endlessm.com>,
        acpi4asus-user <acpi4asus-user@lists.sourceforge.net>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 19, 2019 at 1:00 PM Yurii Pavlovskyi
<yurii.pavlovskyi@gmail.com> wrote:
>
> The driver does not clean up the hwmon device on exit or error. To
> reproduce the bug, repeat rmmod, insmod to verify that device number
> /sys/devices/platform/asus-nb-wmi/hwmon/hwmon?? grows every time. Replace
> call for registering device with devm_* version that unregisters it
> automatically.

>         struct device *hwmon;
>
> -       hwmon = hwmon_device_register_with_groups(&asus->platform_device->dev,
> -                                                 "asus", asus,
> -                                                 hwmon_attribute_groups);
> +       hwmon = devm_hwmon_device_register_with_groups(
> +                       &asus->platform_device->dev, "asus", asus,
> +                       hwmon_attribute_groups);
> +

Temporary variable would help with readability, i.e.

struct device *dev = &asus->platform_device->dev;
...

-- 
With Best Regards,
Andy Shevchenko
