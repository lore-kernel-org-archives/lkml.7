Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA6CFC0651F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 13:28:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87139218BA
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 13:28:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P0U1d28c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727246AbfGDN2v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 09:28:51 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39062 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727116AbfGDN2v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 09:28:51 -0400
Received: by mail-pf1-f194.google.com with SMTP id j2so2957666pfe.6;
        Thu, 04 Jul 2019 06:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C3bHvTquVsi+QkqeP9kBzeld7vh/G3nOdaz58xEHRUw=;
        b=P0U1d28c4dAUPsJQTBNm+JrpF5GtXpCeRrj4L//7J4ktJUETZQ2XzW2aVDxq9XOqBK
         xir4QnnNsel45AZhoXchJQvks3gb1U/NuVIIh8cmzbqd0BQYVZ4Aa2pZJD8CArI3Y8iQ
         5W4SSWnODZsO8tXXulrcjtcyUBYd1SvwrOXQuvGhN17RJNWPmeBPhuJQioiFJFXEtjPH
         cZIEFOsGG1gyxGfvi5sqhQ1vPQIEOuvGrLRdVVLSiP414lzOMais1uHYfVMEI50LRylj
         tPenhbu19AANqO+bgUUE/kclvyn42yFMW/53k8wL+GzkcWXrck4sbe5dKlZzCpptP7V9
         Ca3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C3bHvTquVsi+QkqeP9kBzeld7vh/G3nOdaz58xEHRUw=;
        b=fvY52GJ5qE2t44coS+ffo6PA0ArgdAejfGzUGeFtJet2mLsrw0FLghBVlyVTR1Tk2n
         vUrimPxIcfMsX8jfpSjKgB0W0e43+ngEG7kwCzHzbSYs0+hPcZTfKhWvivVXcHyWojHh
         uXZhRRgGMw2N9c/qpdI8CJCuaCkFscny3Dlpt4RoCVJYGCrvHtbVPrkTOo56+6ISl7N7
         1tPZAVxVrCr1ls9meldWZGOrfGOndXN5gN49eJAMJxogrpXEcS6UODYe9jnfDZukSjxW
         x+hdTkcY7t38mcA724gTYVlFvJ66e4tTYFjeBO8K2bE7e5pP9a05GZNnI8bNdDkr+FZx
         jh3w==
X-Gm-Message-State: APjAAAV9pMf/SFo1nvhu4srSIT4U9XRpDBrTKjiZiTQKzXfzP5y/wi5p
        HmHLp7gSe4Tmac47qp5YceSfiMps+COybxYtd7M=
X-Google-Smtp-Source: APXvYqyBXRj45MJ/uyjUwIBQviIUhrB6XJ4UUA6ceL6TLExCxn0N3MsOp6KC60LDoS0Kb+G97dzRlhqanQVtRTqM4Zg=
X-Received: by 2002:a17:90a:35e6:: with SMTP id r93mr19948932pjb.20.1562246930294;
 Thu, 04 Jul 2019 06:28:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190704084617.3602-1-gregkh@linuxfoundation.org> <20190704084617.3602-6-gregkh@linuxfoundation.org>
In-Reply-To: <20190704084617.3602-6-gregkh@linuxfoundation.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 4 Jul 2019 16:28:39 +0300
Message-ID: <CAHp75VdLZGM3EY3LeorYLgD-8rXUL_jQ9qdTSAfaRnyvwJp+QA@mail.gmail.com>
Subject: Re: [PATCH 05/11] olpc: x01: convert platform driver to use dev_groups
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 4, 2019 at 11:47 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> Platform drivers now have the option to have the platform core create
> and remove any needed sysfs attribute files.  So take advantage of that
> and do not register "by hand" a lid sysfs file.
>

Acked-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Cc: Darren Hart <dvhart@infradead.org>
> Cc: Andy Shevchenko <andy@infradead.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: x86@kernel.org
> Cc: platform-driver-x86@vger.kernel.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  arch/x86/platform/olpc/olpc-xo1-sci.c | 17 +++++++----------
>  1 file changed, 7 insertions(+), 10 deletions(-)
>
> diff --git a/arch/x86/platform/olpc/olpc-xo1-sci.c b/arch/x86/platform/olpc/olpc-xo1-sci.c
> index 25ce1b3b0732..ce1948918dd2 100644
> --- a/arch/x86/platform/olpc/olpc-xo1-sci.c
> +++ b/arch/x86/platform/olpc/olpc-xo1-sci.c
> @@ -157,6 +157,12 @@ static ssize_t lid_wake_mode_set(struct device *dev,
>  static DEVICE_ATTR(lid_wake_mode, S_IWUSR | S_IRUGO, lid_wake_mode_show,
>                    lid_wake_mode_set);
>
> +static struct attribute *lid_attrs[] = {
> +       &dev_attr_lid_wake_mode.attr,
> +       NULL,
> +};
> +ATTRIBUTE_GROUPS(lid);
> +
>  /*
>   * Process all items in the EC's SCI queue.
>   *
> @@ -510,17 +516,8 @@ static int setup_lid_switch(struct platform_device *pdev)
>                 goto err_register;
>         }
>
> -       r = device_create_file(&lid_switch_idev->dev, &dev_attr_lid_wake_mode);
> -       if (r) {
> -               dev_err(&pdev->dev, "failed to create wake mode attr: %d\n", r);
> -               goto err_create_attr;
> -       }
> -
>         return 0;
>
> -err_create_attr:
> -       input_unregister_device(lid_switch_idev);
> -       lid_switch_idev = NULL;
>  err_register:
>         input_free_device(lid_switch_idev);
>         return r;
> @@ -528,7 +525,6 @@ static int setup_lid_switch(struct platform_device *pdev)
>
>  static void free_lid_switch(void)
>  {
> -       device_remove_file(&lid_switch_idev->dev, &dev_attr_lid_wake_mode);
>         input_unregister_device(lid_switch_idev);
>  }
>
> @@ -629,6 +625,7 @@ static struct platform_driver xo1_sci_driver = {
>         .remove = xo1_sci_remove,
>         .suspend = xo1_sci_suspend,
>         .resume = xo1_sci_resume,
> +       .dev_groups = lid_groups,
>  };
>
>  static int __init xo1_sci_init(void)
> --
> 2.22.0
>


-- 
With Best Regards,
Andy Shevchenko
