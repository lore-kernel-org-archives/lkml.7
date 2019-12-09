Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A40F7C43603
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 17:55:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75FB6207FF
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 17:55:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M0vtoKur"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726584AbfLIRzN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 12:55:13 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:44927 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbfLIRzN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 12:55:13 -0500
Received: by mail-pj1-f68.google.com with SMTP id w5so6196508pjh.11;
        Mon, 09 Dec 2019 09:55:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SsqygZ4YCo4j3CPJutqJnes1g7ycYKj7ltHKReWe+Gs=;
        b=M0vtoKurcQ764RfQwrwT/k/ZKqXKn9Ee1w23DhEgDUZdvdoQspb79L/9bGCi4biZTp
         peoeg6kKsbCddp15JX4SY6C7p8ayogc6zk2BZxPiQjXejKf/DvUzQ16eluUPs6T8LNsT
         wQmXhhoLiwxUIP9Vp1g5AOEbUyno2bQMySZS1AD4zpMr/btwQn3hWx4fAxzH4g4PEtRi
         BGw7dHyItMxguaEw5DVYviiqQcporrm2wHEFHXub9MhqkvnZUCoomF8zT3F465vMTWAs
         ieXcAuF+qT9/XDgxdSo4g3y4L3AyDYGzIgDPISNmLttjPIR0HRaooZE5WpgdEYjaAWFF
         /JzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SsqygZ4YCo4j3CPJutqJnes1g7ycYKj7ltHKReWe+Gs=;
        b=QWs6o6hh4jCm6ijghU6V5xSYVtnW3lqlS/PLm2hoxf18hKIUS/AZJj7Jg4Qu7BVhcC
         YiPsW6G8ywBZY1O+hPPVYHfEUsE3N+WmnpBqFaxGwjliyng/yT0e/MJHEimvmEE60KLJ
         r/F75TML6K8bM4qhQjbyjoCOTJ0kVgEvNuXHGP+T1RMQGIG7u2vdsRLyXcmg5D9w8CF9
         Vsg3TuX5ol6DNgl9TdW0hBjC7E3LJy+l0LCHMO70CxR8vz6JhwPDUs+lDUHo+o5IhnpP
         AHVJHaI5C3bIAReGXV+fOXiN4NXARwLQa+pDnHoLvdMiGcp7OtrIWFFhQx9QgM+9ZAe9
         fRGA==
X-Gm-Message-State: APjAAAUnYo4TWMMuVcM2W0qFsTwtI72a7y1N/YXaxqz4IEMwNsncUgDF
        s9Z3UtU55sMoaDzV4W/ZYqB3TRwwHHGPQFoXj2k=
X-Google-Smtp-Source: APXvYqyaZDb88dg1QjoymH5nyMq7xEnGayvd36T6GyERKX+UHXR+dcnSpoR6IQn+XdeTZQ3xVZosN/08+YuJXOxZYnc=
X-Received: by 2002:a17:90a:2004:: with SMTP id n4mr300754pjc.20.1575914112694;
 Mon, 09 Dec 2019 09:55:12 -0800 (PST)
MIME-Version: 1.0
References: <20191209162230.14991-1-hslester96@gmail.com>
In-Reply-To: <20191209162230.14991-1-hslester96@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 9 Dec 2019 19:55:03 +0200
Message-ID: <CAHp75VfienOzF0NVqS9+YDVSwqCB27E16SWKLy3_Yf4b5Ggbmw@mail.gmail.com>
Subject: Re: [PATCH] x86/platform/goldfish: add a check for platform_device_register_simple
To:     Chuhong Yuan <hslester96@gmail.com>
Cc:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@linux.intel.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Bruce Beare <bruce.j.beare@intel.com>,
        Sheng Yang <sheng@linux.intel.com>,
        Yunhong Jiang <yunhong.jiang@intel.com>,
        Alan Cox <alan@linux.intel.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 9, 2019 at 6:22 PM Chuhong Yuan <hslester96@gmail.com> wrote:
>
> goldfish_init() misses a check for platform_device_register_simple().
> Add a check to fix it.

Thanks for a patch. My comments below.

>  static int __init goldfish_init(void)
>  {
> +       struct platform_device *pdev;
> +
>         if (!goldfish_enable)
>                 return -ENODEV;
>
> -       platform_device_register_simple("goldfish_pdev_bus", -1,
> -                                       goldfish_pdev_bus_resources, 2);

> +       pdev =  platform_device_register_simple("goldfish_pdev_bus", -1,

Perhaps idea for a separate patch or maybe here:
-1 -> PLATFORM_DEVID_NONE

> +                                       goldfish_pdev_bus_resources, 2);

> +       if (IS_ERR(pdev))
> +               return PTR_ERR(pdev);
> +
>         return 0;

This can use PTR_ERR_OR_ZERO() macro instead.

>  }


-- 
With Best Regards,
Andy Shevchenko
