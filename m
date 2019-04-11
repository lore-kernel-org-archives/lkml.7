Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E07DC10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 13:44:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41A632184E
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 13:44:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RWsWREFs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbfDKNox (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 09:44:53 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36237 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726629AbfDKNow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 09:44:52 -0400
Received: by mail-pf1-f193.google.com with SMTP id z5so3496010pfn.3;
        Thu, 11 Apr 2019 06:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OQgjGvRFXYx192kJ2MT8Ee7tSO38gssau7hWJK/zzFE=;
        b=RWsWREFsT246W7R7rmVANTvshyNZ0Iz5TY2rlkzmPWshVmRHcpIY0C6cEsOxtyYyTN
         WLAiS5Kx9pJhBiWNm6UXCrG7UAPifEnAuv8V5XW4/J8dkhn9eVosLvE/vuYciH++Opmx
         XUZIGM908tM0yYaZ/i4ar5uKpzBSAMgXC2iT+hv8HrqXTAq4acKoL0XijpRmCmztpoUi
         4R7dacbRx5RJ4bC8m6ieF4FQfsQ4ZoYNCqYxVaW1tSBeYbg5aUZjixBB4WHNJVCCnX6c
         ihO5M/sOSzTDfaFru2GU7GTblsE3qGP0kZR2RubO+omOH3Ypv+YU9/R8+JWqHOvMZh7e
         hrFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OQgjGvRFXYx192kJ2MT8Ee7tSO38gssau7hWJK/zzFE=;
        b=sBwButYC6bpUQv5IEIta6oujOdj5ABRWb/H7EJ+9w1bpwtJ0OJ83eo3NzjBnPO/Qg7
         Y6u7P/np604iwW1eF4p//e4TtI6Th4VUURjrXSdAFZkdo2Pzh9uCd5Lrofz56edJTtKr
         YLhljHCMoWbktM7V3+LyaGAKzOoJz1s/n7uijS4O9r0LxmaS8Hid0MwTpvP2h1KMdo3z
         0zttoNQ6FPodJPHQ4aM9Bl+tneFkEWgYfTXIiw+Lfb4L2RIo6RUTYgcmZeqfUIRwtzTt
         cDF4RbP9DuxPVsbjfDj1uu5MCuVu+g1VhWNivWXV+X3RIp+NjOHB7fnvlYEXod/LV9tz
         tA8w==
X-Gm-Message-State: APjAAAXndXorpVuWCD3RyWZX2Fz7roUKsZUK3nWP+Q1SHnCle2MomFOP
        JEmXTai4Yad3041S/JMpwkJjXhj3kokex+Say2h8gia/
X-Google-Smtp-Source: APXvYqzfLdyilQYaghSL/PtStxNMmhsVrmAHQzyOVpxzyye1UrcXEEufYY9mT1p006SsEbiCKjHFNSVGJ8RrZZhdDE4=
X-Received: by 2002:a63:fd49:: with SMTP id m9mr47441971pgj.16.1554990292193;
 Thu, 11 Apr 2019 06:44:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190313222124.229371-1-rajatja@google.com> <20190411003738.55073-1-rajatja@google.com>
In-Reply-To: <20190411003738.55073-1-rajatja@google.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 11 Apr 2019 16:44:40 +0300
Message-ID: <CAHp75VceZ7w33U=2Ly_qp58E=xEf4vUBEYgfHHHKgvSg2Q+yMw@mail.gmail.com>
Subject: Re: [PATCH v5 1/3] platform/x86: intel_pmc_core: Convert to a platform_driver
To:     Rajat Jain <rajatja@google.com>
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

On Thu, Apr 11, 2019 at 3:37 AM Rajat Jain <rajatja@google.com> wrote:
>
> Convert the intel_pmc_core driver to a platform driver, and attach using
> the ACPI enumeration method (via the ACPI device "INT33A1").

>         cpu_id = x86_match_cpu(intel_pmc_core_ids);
>         if (!cpu_id)
>                 return -ENODEV;
> @@ -888,28 +893,49 @@ static int __init pmc_core_probe(void)
>         mutex_init(&pmcdev->lock);
>         pmcdev->pmc_xram_read_bit = pmc_core_check_read_lock_bit();
>
> +       dmi_check_system(pmc_core_dmi_table);
> +       platform_set_drvdata(pdev, pmcdev);
> +
>         err = pmc_core_dbgfs_register(pmcdev);
>         if (err < 0) {
> -               pr_warn(" debugfs register failed.\n");
> +               dev_warn(&pdev->dev, "debugfs register failed.\n");
>                 iounmap(pmcdev->regbase);
>                 return err;
>         }
>
> -       dmi_check_system(pmc_core_dmi_table);
> -       pr_info(" initialized\n");

> +       dev_info(&pdev->dev, " initialized\n");
> +       device_initialized = true;

First you do something, then print it's done, and not other way around.

> +
>         return 0;
>  }
> -module_init(pmc_core_probe)
>
> -static void __exit pmc_core_remove(void)
> +static int pmc_core_remove(struct platform_device *pdev)
>  {
> -       struct pmc_dev *pmcdev = &pmc;
> +       struct pmc_dev *pmcdev = platform_get_drvdata(pdev);
>
> +       platform_set_drvdata(pdev, NULL);
>         pmc_core_dbgfs_unregister(pmcdev);
>         mutex_destroy(&pmcdev->lock);
>         iounmap(pmcdev->regbase);
> +       return 0;
>  }
> -module_exit(pmc_core_remove)
> +
> +static const struct acpi_device_id pmc_core_acpi_ids[] = {
> +       {"INT33A1", 0}, /* _HID for Intel Power Engine, _CID PNP0D80*/
> +       { }
> +};
> +MODULE_DEVICE_TABLE(acpi, pmc_core_acpi_ids);
> +
> +static struct platform_driver pmc_core_driver = {
> +       .driver = {
> +               .name = "pmc_core",
> +               .acpi_match_table = ACPI_PTR(pmc_core_acpi_ids),
> +       },
> +       .probe = pmc_core_probe,
> +       .remove = pmc_core_remove,
> +};
> +
> +module_platform_driver(pmc_core_driver);

So, this patch has a bisectability issue. After it AFAIU some
platforms will not be able to enumerate the device.

To avoid such you have to reconsider logic behind this conversion, i.e.
1. Split the driver to core part and current initialization mechanism
2. Add platform driver as a separate module.

-- 
With Best Regards,
Andy Shevchenko
