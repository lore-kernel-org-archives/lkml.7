Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A886BC10F14
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 16:51:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6657F20880
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 16:51:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hqdpUfv/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729109AbfDHQvz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 12:51:55 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33454 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727023AbfDHQvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 12:51:54 -0400
Received: by mail-pg1-f196.google.com with SMTP id k19so7670017pgh.0;
        Mon, 08 Apr 2019 09:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Arp8gh1Xr6XyymCJiPWyeH2RDVnKUpQtarjO35H+wWU=;
        b=hqdpUfv/nXIL9kWnT2m0sISkxB2zCvdO85QPmBr1UJ4ap8y6Xxki/eNZ6w/VJUJg9T
         Smql4mealjq8xCFXo5Cxvyq+Xgu7wI4jzvfMaspq50aPrTYy5kRfuYu3ihdAW7zVCLDI
         6OQzDpSXM4EG4ykkuuOSU8Nhw/yneIrlYKTVGvKXt9aBZlG03qwjxK4u/vNi/zE1jwBs
         /d+QVdJ2E+FhiC1Pagg7CZnL4u+cLqNu0/iE2ZAopTdkTFNDs3c8f4UV7xE0Zqn1fYO7
         uVyMDV0vwMxAj+pihrcLql6LtVP574WyyRWC+nxDI+j0/X3IirZX9Z4tV5jYos+Di/Y5
         D36Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Arp8gh1Xr6XyymCJiPWyeH2RDVnKUpQtarjO35H+wWU=;
        b=jLOpYcsCzcmY+yEyKentzGZo9vu6VM2Def2R2b9a3H6caaPaTg8cnVDy6Z3fOMMgtI
         LUagYC+kBcdRrtaiBKXy2MQLHydZQj3DIIq11UPuiKnFnGPmypqAInEgoxV39J+Sbm4r
         mlHkDwEEZvHFD2QHvXxv54dAbBzcgX+cMyw48DMPftGLf+QNzoUbpH3MfINZFJdH7a5F
         paEEGrkldQLSXgxQxzg7Tg6kePgHbBSi3dyZyKmjBCn3ZlQJvP/M4vtM8EwpXVsqkdF7
         YTyJ2WYagdMI6ZWGoTJh1+H8KGjG4XouuNHnofk1dtO9zSjZcOoHhqT6YDpwbSp4AOGY
         yCHA==
X-Gm-Message-State: APjAAAXNPEWmFAxIW1vOfnnB6uNI/7dpwhZPHPdy732vlRCnSfVzq/Xk
        eN6/K7JuKn27N8S5vw8iiDwDAUopILrVe6qYXWk=
X-Google-Smtp-Source: APXvYqyHy8wAm8WBRj7x2FhKV2PD4eFyB2j5NITupIPy7i8VKSU082AIou3My5+e7dfyku32yRMZucHhjrAb/pvHEvE=
X-Received: by 2002:a63:fd49:: with SMTP id m9mr29704922pgj.16.1554742313181;
 Mon, 08 Apr 2019 09:51:53 -0700 (PDT)
MIME-Version: 1.0
References: <20190313222124.229371-1-rajatja@google.com> <20190405203558.19160-1-rajatja@google.com>
In-Reply-To: <20190405203558.19160-1-rajatja@google.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 8 Apr 2019 19:51:41 +0300
Message-ID: <CAHp75Vd+_aFxomzPP_-8y5D1p0crbYo6R+=7fGGOKW86D2+=CQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] platform/x86: intel_pmc_core: Convert to a platform_driver
To:     Rajat Jain <rajatja@google.com>
Cc:     Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>,
        Vishwanath Somayaji <vishwanath.somayaji@intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Wysocki@google.com, Rafael J <rafael.j.wysocki@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        furquan@google.com, evgreen@google.com,
        Rajat Jain <rajatxjain@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 5, 2019 at 11:36 PM Rajat Jain <rajatja@google.com> wrote:
>
> Convert the intel_pmc_core driver to a platform driver, and attach using
> the ACPI enumeration method (via the ACPI device "INT33A1").
>
> Signed-off-by: Rajat Jain <rajatja@google.com>

> -static const struct x86_cpu_id intel_pmc_core_ids[] = {
> -       INTEL_CPU_FAM6(SKYLAKE_MOBILE, spt_reg_map),
> -       INTEL_CPU_FAM6(SKYLAKE_DESKTOP, spt_reg_map),
> -       INTEL_CPU_FAM6(KABYLAKE_MOBILE, spt_reg_map),
> -       INTEL_CPU_FAM6(KABYLAKE_DESKTOP, spt_reg_map),
> -       INTEL_CPU_FAM6(CANNONLAKE_MOBILE, cnp_reg_map),
> -       INTEL_CPU_FAM6(ICELAKE_MOBILE, icl_reg_map),
> -       {}
> -};
> -
> -MODULE_DEVICE_TABLE(x86cpu, intel_pmc_core_ids);
> -

> +static int pmc_core_probe(struct platform_device *pdev)
>  {
> +       static bool device_initialized;
>         struct pmc_dev *pmcdev = &pmc;
> -       const struct x86_cpu_id *cpu_id;
>         u64 slp_s0_addr;
>         int err;
>
> -       cpu_id = x86_match_cpu(intel_pmc_core_ids);
> -       if (!cpu_id)
> +       if (device_initialized)
>                 return -ENODEV;
>
> -       pmcdev->map = (struct pmc_reg_map *)cpu_id->driver_data;

> +       switch (boot_cpu_data.x86_model) {

I didn't get why this should be boot CPU?
Otherwise, leave the structure and leave the x86_match_cpu() call.

> +       case INTEL_FAM6_SKYLAKE_MOBILE:
> +       case INTEL_FAM6_SKYLAKE_DESKTOP:
> +       case INTEL_FAM6_KABYLAKE_MOBILE:
> +       case INTEL_FAM6_KABYLAKE_DESKTOP:
>
> -       /*
> -        * Coffeelake has CPU ID of Kabylake and Cannonlake PCH. So here
> -        * Sunrisepoint PCH regmap can't be used. Use Cannonlake PCH regmap
> -        * in this case.
> -        */
> -       if (pmcdev->map == &spt_reg_map && !pci_dev_present(pmc_pci_ids))
> +               pmcdev->map = &spt_reg_map;
> +
> +               /*
> +                * Special case: Coffeelake has CPU ID of Kabylake, but has
> +                * Cannonlake PCH. So need to use cnp_reg_map instead of
> +                * spt_reg_map for this special case. The PMC core PCI device
> +                * on Coffeelake is hidden, so use that as the deciding factor.
> +                */
> +               if (!pci_dev_present(pmc_pci_ids))
> +                       pmcdev->map = &cnp_reg_map;
> +
> +               break;
> +
> +       case INTEL_FAM6_CANNONLAKE_MOBILE:
>                 pmcdev->map = &cnp_reg_map;
> +               break;
> +
> +       case INTEL_FAM6_ICELAKE_MOBILE:
> +               pmcdev->map = &icl_reg_map;
> +               break;
> +       default:
> +               /*
> +                * Which map should we use by default? If not specified
> +                * explicitly, assume Icelake by default for now.
> +                */
> +               pmcdev->map = &icl_reg_map;
> +               break;
> +       }
>
>         if (lpit_read_residency_count_address(&slp_s0_addr))
>                 pmcdev->base_addr = PMC_BASE_ADDR_DEFAULT;
> @@ -890,26 +903,47 @@ static int __init pmc_core_probe(void)
>
>         err = pmc_core_dbgfs_register(pmcdev);
>         if (err < 0) {
> -               pr_warn(" debugfs register failed.\n");
> +               dev_warn(&pdev->dev, "debugfs register failed.\n");
>                 iounmap(pmcdev->regbase);
>                 return err;
>         }
>
>         dmi_check_system(pmc_core_dmi_table);
> -       pr_info(" initialized\n");
> +       platform_set_drvdata(pdev, pmcdev);
> +
> +       dev_info(&pdev->dev, " initialized\n");
> +       device_initialized = true;
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
>
>  MODULE_LICENSE("GPL v2");
>  MODULE_DESCRIPTION("Intel PMC Core Driver");
> --
> 2.21.0.392.gf8f6787159e-goog
>


-- 
With Best Regards,
Andy Shevchenko
