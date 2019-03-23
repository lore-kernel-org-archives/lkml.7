Return-Path: <SRS0=q9dy=R2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5EF5C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 00:30:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4306921925
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 00:30:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VOoeoDMn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727544AbfCWAap (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 20:30:45 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:35829 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727154AbfCWAap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 20:30:45 -0400
Received: by mail-lj1-f195.google.com with SMTP id t13so3460351lji.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 17:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Kxm2P14Ya3p08NYozBwoqS+iXcVwimijMy+diTMeuzs=;
        b=VOoeoDMnfYKOBacdNMAyAUPjXlOmairOyckV1CID7tvhnSsIgKY8ng51gvAbR97S+n
         /eLIFhLxQAoOo2Ho2UTUyq/Ef+yLkx2rQAMG65BP3YKVtGEF4N2E/zZSPwq8+Pqb42hT
         fDroBguf/o6chXaY71YZ+m51h2T1Bwk2JETmlRYj37yCYpRrM3lUz2kNkixNvcBXBpHK
         U0PfC96nse0ZAK2CT46q7b1+Y+MZJ6uUuFU+xl1avVP+InXIbOqZhq+tkrxXpa7xy7K4
         UVYgFbWSwEr6niqSGTP7WFKIUDimgPpK7XNUeNKxoaJZh0xonggTQGit73qQuhy7mCNk
         yx8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Kxm2P14Ya3p08NYozBwoqS+iXcVwimijMy+diTMeuzs=;
        b=BPr0qv3M91wprNqbk0qCORxHjwms5hKKA0gVZgNUxtPfZ3876GZMkrofqXow+nSLkm
         Fr7K7YxSLNtn74N/40IdQ94JTupFZKTBhrygdEDH3lWklRZteBT0AC4pXr1WUA58ebjP
         ztdgWZHb1RgWFwDo0CVywHnnHHvai5Nb2olQXUkrU343oSJ8ZODfp4JOo5Szdd/2r43c
         pTW51H36CTUWfpoyFEKsiek976xpoTHmnss1e32h6H9fdelvhli5lnXLzdLUjneupect
         +YJkAwWOI/IdzMbT1EfRord7P6cmU+AXhzrLkp7V9jaMZp8aSZSJ4DXL3uPCmN+ylomr
         MWdg==
X-Gm-Message-State: APjAAAVJDKkQTv22qcb218icRYkVeAm0ON3bIp8m51DFN+exB8mbtD8n
        oBAcvivIww0TJ17NJ6K/n9SwvxHIfUD7Q2DEgR9YaA==
X-Google-Smtp-Source: APXvYqwqwrzC3QmvrzRKfUqXni5O0PuM+0FDYOmPbssX0G01GCWVWjH4j8E4xUe4fAZuXuMIeQUdZ6Hsnt0jApFeSyA=
X-Received: by 2002:a2e:9013:: with SMTP id h19mr7095794ljg.136.1553301041966;
 Fri, 22 Mar 2019 17:30:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190313222124.229371-1-rajatja@google.com> <20190316081752.GA21812@raj-desk2.iind.intel.com>
 <CAA93t1qoQx2B9=KuNpuXL_PvdpgGJPzZk8N-KWqS4XyO8qrS5g@mail.gmail.com> <3fc03e60-492a-e9b5-ac9b-caa17f8a8e27@linux.intel.com>
In-Reply-To: <3fc03e60-492a-e9b5-ac9b-caa17f8a8e27@linux.intel.com>
From:   Rajat Jain <rajatja@google.com>
Date:   Fri, 22 Mar 2019 17:30:05 -0700
Message-ID: <CACK8Z6HGEeM_0AnM1eJcUgNPwFz6_wsT8oFAG2rkV4UZczDi3g@mail.gmail.com>
Subject: Re: [PATCH 1/2] platform/x86: intel_pmc_core: Convert to a platform_driver
To:     "Bhardwaj, Rajneesh" <rajneesh.bhardwaj@linux.intel.com>
Cc:     Rajat Jain <rajatxjain@gmail.com>,
        Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        Vishwanath Somayaji <vishwanath.somayaji@intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Furquan Shaikh <furquan@google.com>,
        Evan Green <evgreen@google.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        "Box, David E" <david.e.box@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rajneesh,



On Fri, Mar 22, 2019 at 12:56 PM Bhardwaj, Rajneesh
<rajneesh.bhardwaj@linux.intel.com> wrote:
>
> Some suggestions below
>
> On 18-Mar-19 8:36 PM, Rajat Jain wrote:
>
> On Sat, Mar 16, 2019 at 1:30 AM Rajneesh Bhardwaj
> <rajneesh.bhardwaj@intel.com> wrote:
>
> On Wed, Mar 13, 2019 at 03:21:23PM -0700, Rajat Jain wrote:
>
> Convert the intel_pmc_core driver to a platform driver. There is no
> functional change. Some code that tries to determine what kind of
> CPU this is, has been moved code is moved from pmc_core_probe() to
>
> Possible typo here.
>
> Ummm, you mean grammar error I guess? Sure, I will rephrase.
>
> pmc_core_init().
>
> Signed-off-by: Rajat Jain <rajatja@google.com>
>
> Thanks for sending this. This is certainly useful to support suspend-resume
> functionality for this driver which is otherwise only possible with PM
> notifiers otherwise and that is not desirable. Initially this was a PCI
> driver and after design discussion it was converted to module. I would like
> to consult Andy and Srinivas for their opinion about binding it to actual
> platform bus instead of the virtual bus as in its current form. In one of the
> internal versions, we used a known acpi PNP HID.
>
> Sure, if there is an established ACPI PNP HID, then we could bind it
> using that, on platforms where we are still developing BIOS /
> coreboot. However, this might not be possible for shipping systems
> (Kabylake / skylake) where there is no plan to change the BIOS.
>
> In one of our internal patches, i had used HID of power engine plugin. IIRC, During my testing it was working on KBL, CNL with UEFI BIOS but i highly recommend testing it.
>
> ---8<----8<-----
>
> +static const struct acpi_device_id pmc_acpi_ids[] = {
>
> +             {"INT33A1", 0}, /* _HID for Intel Power Engine, _CID PNP0D80*/
>
> +             { }
>
>  };

We do not have this device in any of our ACPI tables today. If Intel
can confirm that this is a well known HID to be used for attaching
this driver, we can start putting it on our platform's ACPI going
forward (Whiskeylake, Cometlake, Cannonlake, Icelake ...). But I
believe we also need to have this driver attach with the device on
older platforms (Skylake, Kabylake, Amberlake) that are already
shipping, and running a Non UEFI BIOS (that may not have this HID
since it is not published).

Currently the intel_pmc_core driver attaches itself to the following
table of CPU families, without regard to whether it has that HID in
the ACPI or not:

static const struct x86_cpu_id intel_pmc_core_ids[] = {
        INTEL_CPU_FAM6(SKYLAKE_MOBILE, spt_reg_map),
        INTEL_CPU_FAM6(SKYLAKE_DESKTOP, spt_reg_map),
        INTEL_CPU_FAM6(KABYLAKE_MOBILE, spt_reg_map),
        INTEL_CPU_FAM6(KABYLAKE_DESKTOP, spt_reg_map),
        INTEL_CPU_FAM6(CANNONLAKE_MOBILE, cnp_reg_map),
        INTEL_CPU_FAM6(ICELAKE_MOBILE, icl_reg_map),
        {}
};

So to avoid a regression, I suggest that we still maintain the above
table (may be eliminate few entries) and always attach if the CPU is
among the table, and if the CPU is not among the table, use the ACPI
HID to attach. I propose to attach to at least Skylake and Kabylake
systems using the table above, and for Canonlake and Icelake and
newer, we can rely on BIOS providing the ACPI HID. Of course I do not
know if all non-Google Canonlake/Icelake platforms will have this HID
in their BIOS. If we are not sure, we can include Canonlake and
Icelake also in that list, an. Please let me know what do you think.

Thanks,

Rajat

>
>
>
> -builtin_pci_driver(intel_pmc_core_driver);
>
> +static struct platform_driver pmc_plat_driver = {
>
> +             .remove = pmc_plat_remove,
>
> +             .probe = pmc_plat_probe,
>
> +             .driver = {
>
> +                             .name = "pmc_core_driver",
>
> +                             .acpi_match_table = ACPI_PTR(pmc_acpi_ids),
>
> +             },
>
> +};
>
> ---
> This is rebased off
> git://git.infradead.org/linux-platform-drivers-x86.git/for-next
>
>  drivers/platform/x86/intel_pmc_core.c | 93 ++++++++++++++++++++-------
>  1 file changed, 68 insertions(+), 25 deletions(-)
>
> diff --git a/drivers/platform/x86/intel_pmc_core.c b/drivers/platform/x86/intel_pmc_core.c
> index f2c621b55f49..55578d07610c 100644
> --- a/drivers/platform/x86/intel_pmc_core.c
> +++ b/drivers/platform/x86/intel_pmc_core.c
> @@ -19,6 +19,7 @@
>  #include <linux/io.h>
>  #include <linux/module.h>
>  #include <linux/pci.h>
> +#include <linux/platform_device.h>
>  #include <linux/uaccess.h>
>
>  #include <asm/cpu_device_id.h>
> @@ -854,12 +855,59 @@ static const struct dmi_system_id pmc_core_dmi_table[]  = {
>       {}
>  };
>
> -static int __init pmc_core_probe(void)
> +static int pmc_core_probe(struct platform_device *pdev)
>  {
> -     struct pmc_dev *pmcdev = &pmc;
> +     struct pmc_dev *pmcdev = platform_get_drvdata(pdev);
> +     int err;
> +
> +     pmcdev->regbase = ioremap(pmcdev->base_addr,
> +                               pmcdev->map->regmap_length);
> +     if (!pmcdev->regbase)
> +             return -ENOMEM;
> +
> +     mutex_init(&pmcdev->lock);
> +     pmcdev->pmc_xram_read_bit = pmc_core_check_read_lock_bit();
> +
> +     err = pmc_core_dbgfs_register(pmcdev);
> +     if (err < 0) {
> +             dev_warn(&pdev->dev, "debugfs register failed.\n");
> +             iounmap(pmcdev->regbase);
> +             return err;
> +     }
> +
> +     dmi_check_system(pmc_core_dmi_table);
> +     dev_info(&pdev->dev, " initialized\n");
> +     return 0;
> +}
> +
> +static int pmc_core_remove(struct platform_device *pdev)
> +{
> +     struct pmc_dev *pmcdev = platform_get_drvdata(pdev);
> +
> +     pmc_core_dbgfs_unregister(pmcdev);
> +     mutex_destroy(&pmcdev->lock);
> +     iounmap(pmcdev->regbase);
> +     return 0;
> +}
> +
> +static struct platform_driver pmc_core_driver = {
> +     .driver = {
> +             .name = "pmc_core",
> +     },
> +     .probe = pmc_core_probe,
> +     .remove = pmc_core_remove,
> +};
> +
> +static struct platform_device pmc_core_device = {
> +     .name           = "pmc_core",
> +};
> +
> +static int __init pmc_core_init(void)
> +{
> +     int ret;
>
> Please use reverse x-mas tree style.
>
> OK, will do.
>
>       const struct x86_cpu_id *cpu_id;
> +     struct pmc_dev *pmcdev = &pmc;
>       u64 slp_s0_addr;
> -     int err;
>
>       cpu_id = x86_match_cpu(intel_pmc_core_ids);
>       if (!cpu_id)
> @@ -880,36 +928,31 @@ static int __init pmc_core_probe(void)
>       else
>               pmcdev->base_addr = slp_s0_addr - pmcdev->map->slp_s0_offset;
>
> -     pmcdev->regbase = ioremap(pmcdev->base_addr,
> -                               pmcdev->map->regmap_length);
> -     if (!pmcdev->regbase)
> -             return -ENOMEM;
> +     platform_set_drvdata(&pmc_core_device, pmcdev);
>
> -     mutex_init(&pmcdev->lock);
> -     pmcdev->pmc_xram_read_bit = pmc_core_check_read_lock_bit();
> +     ret = platform_device_register(&pmc_core_device);
> +     if (ret)
> +             return ret;
>
> -     err = pmc_core_dbgfs_register(pmcdev);
> -     if (err < 0) {
> -             pr_warn(" debugfs register failed.\n");
> -             iounmap(pmcdev->regbase);
> -             return err;
> -     }
> +     ret = platform_driver_register(&pmc_core_driver);
> +     if (ret)
> +             goto out_remove_dev;
>
> -     dmi_check_system(pmc_core_dmi_table);
> -     pr_info(" initialized\n");
>       return 0;
> +
> +out_remove_dev:
> +     platform_device_unregister(&pmc_core_device);
> +     return ret;
>  }
> -module_init(pmc_core_probe)
>
> -static void __exit pmc_core_remove(void)
> +static void __init pmc_core_exit(void)
>  {
> -     struct pmc_dev *pmcdev = &pmc;
> -
> -     pmc_core_dbgfs_unregister(pmcdev);
> -     mutex_destroy(&pmcdev->lock);
> -     iounmap(pmcdev->regbase);
> +     platform_driver_unregister(&pmc_core_driver);
> +     platform_device_unregister(&pmc_core_device);
>  }
> -module_exit(pmc_core_remove)
> +
> +module_init(pmc_core_init);
> +module_exit(pmc_core_exit);
>
>  MODULE_LICENSE("GPL v2");
>  MODULE_DESCRIPTION("Intel PMC Core Driver");
> --
> 2.21.0.360.g471c308f928-goog
>
> --
> Best Regards,
> Rajneesh
