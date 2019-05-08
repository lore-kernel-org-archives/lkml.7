Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 495E4C04AAD
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 13:26:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14D9D21530
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 13:26:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nJ7d5Scr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727686AbfEHN0m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 09:26:42 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44284 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726640AbfEHN0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 09:26:42 -0400
Received: by mail-pg1-f195.google.com with SMTP id z16so10096974pgv.11;
        Wed, 08 May 2019 06:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4/5ziY/KTUNVf1e/P76xlfH5SHuvjTRZGmxcbVkVQTM=;
        b=nJ7d5ScrvsedY+36ug6FouVTx9kKYsDfHOAssRhtqAdwYWGinXnzp9J11PEy5vMm3Y
         jf5haDfZ05MgfEFR2KewhsEqE4EzDtS3HqTV2/Nc3v/YYYxjn2OhcDVfur7+65Ryt1s4
         JXl4f+5f11ZvH+8uYnZKwUIrLgj+ICPKgQFsGMnycQeRgqpr7Qm1asVtzOXOykO4b5eP
         JhbVXiaAJfaY9Gl6niT3FXtzRyQDiPosZX25rzXwDYn401/WtOxppjMfFKAutwGA+1LZ
         VmAd9IL9zx9KpBQLCZRbr0yjPn/hMxFnVPAP5NpaH4INE6yqM0ags71qlrHuAQDYi3y2
         6kmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4/5ziY/KTUNVf1e/P76xlfH5SHuvjTRZGmxcbVkVQTM=;
        b=NuLQ/ad0PIQyokr3uUDBeOWRXdrrEFa9SfxZWnBq0dV4oDmN813JmV3Hm3jCyMQNUM
         CzbRdBzGbJyYO/yirSRdYOqkAQOzQfjs5I7l/tOK0jOHYQDREynOlH3moOONWY0nUKnh
         VlL+2JzTAPPFRD938bOsIVrr4G7LV0x3V2FRjsW9D72mUdksi2olg1fNKoiGGOD1JKu8
         xbv5RvFnK4S8+WoUwSSLw50yeSbdktefQCWy2yEs/tztjMO4+DG5LYdUZ9G1B8Pgm9e5
         C7PWD5Lkz2PmIm1+HUCBU80IBvCzTm3QkCDxe0YQKuGhXM0fix0VKbkKpEf3H/2JGIUN
         qJrA==
X-Gm-Message-State: APjAAAWISgNV/lWm3DCFNAE0Ojk+dhN3GZ2ud8Jjvm+KHN7Itl/E6RZl
        ElBRjq65AquJbx523TBeHLTqiOyobZgCyct5rQQ=
X-Google-Smtp-Source: APXvYqzm8j5RlI2dHv9qpwLIAKh6sDmBT3/e1enS2p1pwsWqd+Isu/pvGlFmeXrVvq/xJsBRd5ONw9a0wrpGGxLWcxg=
X-Received: by 2002:aa7:8212:: with SMTP id k18mr47877115pfi.50.1557322001665;
 Wed, 08 May 2019 06:26:41 -0700 (PDT)
MIME-Version: 1.0
References: <7acd57fe-604a-a96a-4ca2-a25bc88d6405@gmail.com>
In-Reply-To: <7acd57fe-604a-a96a-4ca2-a25bc88d6405@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 8 May 2019 16:26:31 +0300
Message-ID: <CAHp75VdpS_ZX1qKj9PXNhS04C+pEkn7y02CTVshy=4f-42sriQ@mail.gmail.com>
Subject: Re: [PATCH v3 00/11] asus-wmi: Support of ASUS TUF Gaming series laptops
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

On Fri, Apr 19, 2019 at 12:57 PM Yurii Pavlovskyi
<yurii.pavlovskyi@gmail.com> wrote:
>
> Hi,
>
> this is the third version of the patch series.

Doesn't apply to the for-next branch.
Individual comments on the patches are coming as well.

>
> Changelog:
> v3:
>   * Use devm_* function in patch 01
>   * Detect DSTS/DCTS using _UID in patch 04
>   * Detect event queue by _UID as well in patch 05
>   * Rename poll function in patch 05
>   * Fix terminology in patches 09 and 10
>   * Correct commit messages
> v2:
>   * Fix logging
>
> INTRODUCTION
> The support for this laptop series is currently non-existent, as the
> asus-nb-wmi driver (which is essentially configuration for asus-wmi) fails
> to load and multiple ACPI errors are logged in dmesg. This patch series
> adds pretty comprehensive support for these relatively new laptops, adds
> some code organization, and fixes a couple of bugs in the asus-wmi module.
>
> Original message from V1/V2:
> https://lkml.org/lkml/2019/4/10/973
>
> It is really long, so I will not copy it completely here, please refer
> to the original for notes on design decisions and existing minor issues
> (other than quirks, which should be hopefully solved now).
>
> Yurii Pavlovskyi (11):
>   platform/x86: asus-wmi: Fix hwmon device cleanup
>   platform/x86: asus-wmi: Fix preserving keyboard backlight intensity on
>     load
>   platform/x86: asus-wmi: Increase the input buffer size of WMI methods
>   platform/x86: asus-wmi: Improve DSTS WMI method ID detection
>   platform/x86: asus-wmi: Support WMI event queue
>   platform/x86: asus-nb-wmi: Add microphone mute key code
>   platform/x86: asus-wmi: Organize code into sections
>   platform/x86: asus-wmi: Enhance detection of thermal data
>   platform/x86: asus-wmi: Control RGB keyboard backlight
>   platform/x86: asus-wmi: Switch fan boost mode
>   platform/x86: asus-wmi: Do not disable keyboard backlight on unloading
>
>  .../ABI/testing/sysfs-platform-asus-wmi       |  71 ++
>  drivers/platform/x86/asus-nb-wmi.c            |   3 +-
>  drivers/platform/x86/asus-wmi.c               | 797 +++++++++++++++---
>  drivers/platform/x86/wmi.c                    |  19 +
>  include/linux/acpi.h                          |   1 +
>  include/linux/platform_data/x86/asus-wmi.h    |   7 +-
>  6 files changed, 797 insertions(+), 101 deletions(-)
>
> --
> 2.17.1
>


-- 
With Best Regards,
Andy Shevchenko
