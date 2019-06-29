Return-Path: <SRS0=Dr8o=U4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A803EC4321A
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Jun 2019 13:17:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77BE12054F
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Jun 2019 13:17:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gfGn8M6c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbfF2NRO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Jun 2019 09:17:14 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38419 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726723AbfF2NRN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jun 2019 09:17:13 -0400
Received: by mail-pl1-f193.google.com with SMTP id 9so4023290ple.5;
        Sat, 29 Jun 2019 06:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uDIV4a0i1z5RBGO8wq6m3SKx8Sgt3IM3RbtpqDU5AZI=;
        b=gfGn8M6cr8R5VydfYKQUZ+DdzJQXzDqvDzKRLpSA552gXQe8/4wkWGoirIbwxk97tO
         B+1B4ufe1y0mhu+hRIdNU/M7dkK5JAsM+OjQRTn3oXZjowtJJ6x0POWUB/rUm6jfpEpW
         KUbt59J2j/iBPjUTb/LxLROlTU2y/kUd4LTRcX2Rm6t4c16cUp+PIrIuyTLG+7XHyF2U
         hTC70RkbX7bhoinJhV4Zxs8gwnreDubS/g/++0w837vV2jCxUI8mKkWc3qUSgrHCLXXE
         2+9lYCcOI1xKoppCHM2nuP36F+qwJbVmPoenAH00vtXrtbbxfR+E3PoAl06cWGkxOGpf
         zyag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uDIV4a0i1z5RBGO8wq6m3SKx8Sgt3IM3RbtpqDU5AZI=;
        b=pb7CH6dwdJms7GJJRYM5aHIk0E6TpZ6MOLh6OfFf2RLVA9H8YrXiCLYqlgGUIyA74T
         hanpimaJNM5Mi50qhs8LbJlZf2EJRd5fAtnUQY7eOQWxE/jkZoMHyRDuk4oiABCPLHxA
         mJU2nP0yWlBZSVeagLh3aunZLneyWjDL3cBv1/bv3G19A7PnBUBidMOn/i1Ga7nX+pvl
         D04jwDPFHMb0g7hXBUua45j5civQoC2l/Elvs+3WW0ud2ruVnYMUMFOVpPojc3xd/llB
         EW8dmaFa0fSWaPWqBi4Ay3eLVj9aeayU1kB77kSh0DRLoePZEaWanOJmwQSmAvFfM7Uk
         NYOw==
X-Gm-Message-State: APjAAAWDUAqtaPWqNrp3Xlw0wNyGtJ+JdctesQzqOep2PMLipmfb3qiv
        u4eB92z4t2otlbZnZSZFJhRJb56oDAMVX1P4D0I=
X-Google-Smtp-Source: APXvYqwF7psoVrgqeU0y6nHrADGyWRXLHg94eI3RU+igsydbwSgstb5K9SHWRVnMPQXxX2FGnhY8ZFL1rw2M/btJYfs=
X-Received: by 2002:a17:902:694a:: with SMTP id k10mr17467364plt.255.1561814232894;
 Sat, 29 Jun 2019 06:17:12 -0700 (PDT)
MIME-Version: 1.0
References: <1559094951-25391-1-git-send-email-92siuyang@gmail.com>
In-Reply-To: <1559094951-25391-1-git-send-email-92siuyang@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 29 Jun 2019 16:17:01 +0300
Message-ID: <CAHp75Vc1gMowXgBPFaTo9_B_4B443+F2XDn_2xGj6chahk1wOg@mail.gmail.com>
Subject: Re: [PATCH] intel_menlow: avoid null pointer deference error
To:     Young Xiao <92siuyang@gmail.com>
Cc:     Sujith Thomas <sujith.thomas@intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 29, 2019 at 4:55 AM Young Xiao <92siuyang@gmail.com> wrote:
>
> Fix a null pointer deference by acpi_driver_data() if device is
> null (dereference before check). We should only set cdev and check
> this is OK after we are sure device is not null.
>

Pushed to my review and testing queue, thanks!

> Signed-off-by: Young Xiao <92siuyang@gmail.com>
> ---
>  drivers/platform/x86/intel_menlow.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/platform/x86/intel_menlow.c b/drivers/platform/x86/intel_menlow.c
> index 77eb870..28feb5c 100644
> --- a/drivers/platform/x86/intel_menlow.c
> +++ b/drivers/platform/x86/intel_menlow.c
> @@ -180,9 +180,13 @@ static int intel_menlow_memory_add(struct acpi_device *device)
>
>  static int intel_menlow_memory_remove(struct acpi_device *device)
>  {
> -       struct thermal_cooling_device *cdev = acpi_driver_data(device);
> +       struct thermal_cooling_device *cdev;
> +
> +       if (!device)
> +               return -EINVAL;
>
> -       if (!device || !cdev)
> +       cdev = acpi_driver_data(device);
> +       if (!cdev)
>                 return -EINVAL;
>
>         sysfs_remove_link(&device->dev.kobj, "thermal_cooling");
> --
> 2.7.4
>


-- 
With Best Regards,
Andy Shevchenko
