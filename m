Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B631C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 23:04:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05FCF2184B
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 23:04:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Vu06x774"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387624AbfDQXEc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 19:04:32 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:33467 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729079AbfDQXEc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 19:04:32 -0400
Received: by mail-lj1-f196.google.com with SMTP id f23so220389ljc.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 16:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jC2Jn+LpFd0JnUIlQRM35BrQxEoioUtdtP0up1XOsQQ=;
        b=Vu06x774zxETdVg4hvGZi9ihg8a5g7BUV3mk3HWv7inaK5nBSwbOxIy8pIFLtIy5SO
         6CeD6Cvfidd0b9kPG23LGfsT0ZCxeSAADEKTx5xIjlmKAQNT6Fi0FKkc39EhY+HDSZKj
         OBMuPVy77nMWgrY+y5MmdHNMzj/V8kz+DSa1FxnDws1uWbRfpdZIfR3alCDHf7fGdTCx
         uIg5e3FhoOPILdlIYo1Mn81I++UbKUskzrMbQcOq8WOxdAuCCn9Bb/7RfbLNFDWYe1ok
         VeAyec4nFUa8UFoFuZuqMIsx4SpZd7o6sT1CyEhwhL8cQcHbMQ1oXZuRA/aWgcAmS02T
         FbDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jC2Jn+LpFd0JnUIlQRM35BrQxEoioUtdtP0up1XOsQQ=;
        b=Xkd96j4Vm53xGQODpHgOIU7DrNkdp/g6l+zDc+vM62g0/pBWeivtkK54pkwSajG7Qi
         e2L2SeJ/gwap1JNiPDqTlBBnWm3fpKtUzIPtOMK9r+oD2LnKc6mT7/JE4tcRTaFmKLnn
         dZX++UaHciyUwqGkTBWPk1JKEJf8iY55u4wQTys3CnsaWKj19Tk6ikf430xGN4F7AhIx
         CgIsip9lxP2LGHdOEeo46xJLDt0TyeiGYImRQmSQlbgirijM7eisZx8dHAoMf9LMlFuz
         d06sjaGua2DMq+ljpr/pXkeeLu7kR7kMqDRvWjrcpl7uEBP9COwh5epYzxLaFPYYpwAw
         6Bxw==
X-Gm-Message-State: APjAAAXQzHyFgzp9HQ6N6spbvS18movK8Nrb1bEvbxoPMhXMpzhj6t4O
        Oe9VBRboucJ8ro1+WthZFIEr8eREyLeHrSzQ6xZu+w==
X-Google-Smtp-Source: APXvYqzVQkynzxZFzcjEfjargJ6OipV9mFH/kBbiCbMqtadDjAWpw4dpx2hXuTEzQgUGz8QQqPvcGCVOHZlryJQ8uZo=
X-Received: by 2002:a2e:90c9:: with SMTP id o9mr10826061ljg.102.1555542269313;
 Wed, 17 Apr 2019 16:04:29 -0700 (PDT)
MIME-Version: 1.0
References: <20190313222124.229371-1-rajatja@google.com> <20190411003738.55073-1-rajatja@google.com>
 <CAHp75VceZ7w33U=2Ly_qp58E=xEf4vUBEYgfHHHKgvSg2Q+yMw@mail.gmail.com>
In-Reply-To: <CAHp75VceZ7w33U=2Ly_qp58E=xEf4vUBEYgfHHHKgvSg2Q+yMw@mail.gmail.com>
From:   Rajat Jain <rajatja@google.com>
Date:   Wed, 17 Apr 2019 16:03:52 -0700
Message-ID: <CACK8Z6G6o5RGKp3OzSED8KJ6SA=YGhJDrefxduQjHSjGvEa-9Q@mail.gmail.com>
Subject: Re: [PATCH v5 1/3] platform/x86: intel_pmc_core: Convert to a platform_driver
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>,
        Vishwanath Somayaji <vishwanath.somayaji@intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rafael J Wysocki <rafael.j.wysocki@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Furquan Shaikh <furquan@google.com>,
        Evan Green <evgreen@google.com>,
        Rajat Jain <rajatxjain@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 11, 2019 at 6:44 AM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Thu, Apr 11, 2019 at 3:37 AM Rajat Jain <rajatja@google.com> wrote:
> >
> > Convert the intel_pmc_core driver to a platform driver, and attach using
> > the ACPI enumeration method (via the ACPI device "INT33A1").
>
> >         cpu_id = x86_match_cpu(intel_pmc_core_ids);
> >         if (!cpu_id)
> >                 return -ENODEV;
> > @@ -888,28 +893,49 @@ static int __init pmc_core_probe(void)
> >         mutex_init(&pmcdev->lock);
> >         pmcdev->pmc_xram_read_bit = pmc_core_check_read_lock_bit();
> >
> > +       dmi_check_system(pmc_core_dmi_table);
> > +       platform_set_drvdata(pdev, pmcdev);
> > +
> >         err = pmc_core_dbgfs_register(pmcdev);
> >         if (err < 0) {
> > -               pr_warn(" debugfs register failed.\n");
> > +               dev_warn(&pdev->dev, "debugfs register failed.\n");
> >                 iounmap(pmcdev->regbase);
> >                 return err;
> >         }
> >
> > -       dmi_check_system(pmc_core_dmi_table);
> > -       pr_info(" initialized\n");
>
> > +       dev_info(&pdev->dev, " initialized\n");
> > +       device_initialized = true;
>
> First you do something, then print it's done, and not other way around.

done

>
> > +
> >         return 0;
> >  }
> > -module_init(pmc_core_probe)
> >
> > -static void __exit pmc_core_remove(void)
> > +static int pmc_core_remove(struct platform_device *pdev)
> >  {
> > -       struct pmc_dev *pmcdev = &pmc;
> > +       struct pmc_dev *pmcdev = platform_get_drvdata(pdev);
> >
> > +       platform_set_drvdata(pdev, NULL);
> >         pmc_core_dbgfs_unregister(pmcdev);
> >         mutex_destroy(&pmcdev->lock);
> >         iounmap(pmcdev->regbase);
> > +       return 0;
> >  }
> > -module_exit(pmc_core_remove)
> > +
> > +static const struct acpi_device_id pmc_core_acpi_ids[] = {
> > +       {"INT33A1", 0}, /* _HID for Intel Power Engine, _CID PNP0D80*/
> > +       { }
> > +};
> > +MODULE_DEVICE_TABLE(acpi, pmc_core_acpi_ids);
> > +
> > +static struct platform_driver pmc_core_driver = {
> > +       .driver = {
> > +               .name = "pmc_core",
> > +               .acpi_match_table = ACPI_PTR(pmc_core_acpi_ids),
> > +       },
> > +       .probe = pmc_core_probe,
> > +       .remove = pmc_core_remove,
> > +};
> > +
> > +module_platform_driver(pmc_core_driver);
>
> So, this patch has a bisectability issue. After it AFAIU some
> platforms will not be able to enumerate the device.
>
> To avoid such you have to reconsider logic behind this conversion, i.e.
> 1. Split the driver to core part and current initialization mechanism
> 2. Add platform driver as a separate module.

done.


>
> --
> With Best Regards,
> Andy Shevchenko
