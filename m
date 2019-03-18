Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C90ECC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 15:06:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EA1620854
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 15:06:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rcmu/aIV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727169AbfCRPG0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 11:06:26 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:46698 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726435AbfCRPGY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 11:06:24 -0400
Received: by mail-qt1-f193.google.com with SMTP id z25so18225976qti.13;
        Mon, 18 Mar 2019 08:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=Wa4YHcBQjVKWbRqIdvlucoVbWi8rACNIcU7mqVNQKrY=;
        b=Rcmu/aIVIn6wxfMxeZvB/lm4mdNi3tPJesTftKRsMgNLBAhAaJj1miy3+hy0ohGvPt
         gni3q+pV2lqpFAAtgVo0/lX2vxKp0DjduDXsj/n3mgpBR1FMfHJ7qD3RE2OpVqRG0RiL
         RQ9t4R9ImNOzWwZbUXOcb14q0B3d2yoQoSCvOkIEzwOCDk2SKymGrPXH21van5A6Z4XI
         iiEB7g3MJ9PmDlHf3UXUBk16go9GGM6SGB56ba3hd5/iQmqal6VAAZYW18IbmevR2uZq
         wHaLbgK6P63zQIF8CfEqaINgGvbfKd2EkIC8/j9z/aNQyta+wKaxkscZWKUALMCiyEon
         bOpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=Wa4YHcBQjVKWbRqIdvlucoVbWi8rACNIcU7mqVNQKrY=;
        b=LU4En6qN4MPuOsTqpF4PzZcZBJxYT1FueH86oadGQT2hw17p0d4I4cPPjNj1zW2JhV
         +E2Lk/YklqB7Rd8HxFlgwazocxEQRrPc3W4YdWtqYEKIU2fPNOV4QPzbpzQgYfLv+n5l
         fSpC/HD5DagCr2RU2a54DZGfDnkMdn8SgyeWXRia74FAGVRkTxF3JUp8yfYYchCMZWjd
         byj8lJ+Svw7WHuhTxz6JtghZYA7KPAZlxOTx9At3NMIpeq6MPoMrTK83cm5nR6AetUk5
         Zz6CVcI3XtgTq9cxZH/7p5xxwhnaOj0RglXkcpaSolEr1amBHksDjQlKKydzvtIFZ3rd
         Tj4Q==
X-Gm-Message-State: APjAAAWkUmNqvYNwm2UjNcHBhK27u2WmQc9CDH+sCyk84shDVinaxVgU
        we+gcZ2qmD2G+j0OdrUNs4pF6DHunKdid0o6UzA=
X-Google-Smtp-Source: APXvYqwTSdPvJmJVrAWZx50yXKxBVBXR0sdAYuoS73R1S7BsPOWxQlNo1r/kOE3bvhx67s1JFVAIPX9hN0oyBltE9T4=
X-Received: by 2002:ac8:2269:: with SMTP id p38mr13878886qtp.340.1552921582050;
 Mon, 18 Mar 2019 08:06:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190313222124.229371-1-rajatja@google.com> <20190316081752.GA21812@raj-desk2.iind.intel.com>
In-Reply-To: <20190316081752.GA21812@raj-desk2.iind.intel.com>
Reply-To: rajatxjain@gmail.com
From:   Rajat Jain <rajatxjain@gmail.com>
Date:   Mon, 18 Mar 2019 08:06:09 -0700
Message-ID: <CAA93t1qoQx2B9=KuNpuXL_PvdpgGJPzZk8N-KWqS4XyO8qrS5g@mail.gmail.com>
Subject: Re: [PATCH 1/2] platform/x86: intel_pmc_core: Convert to a platform_driver
To:     Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>
Cc:     Rajat Jain <rajatja@google.com>,
        Vishwanath Somayaji <vishwanath.somayaji@intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        platform-driver-x86@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Furquan Shaikh <furquan@google.com>, evgreen@google.com,
        rajneesh.bhardwaj@linux.intel.com,
        srinivas.pandruvada@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 16, 2019 at 1:30 AM Rajneesh Bhardwaj
<rajneesh.bhardwaj@intel.com> wrote:
>
> On Wed, Mar 13, 2019 at 03:21:23PM -0700, Rajat Jain wrote:
> > Convert the intel_pmc_core driver to a platform driver. There is no
> > functional change. Some code that tries to determine what kind of
> > CPU this is, has been moved code is moved from pmc_core_probe() to
>
> Possible typo here.

Ummm, you mean grammar error I guess? Sure, I will rephrase.

>
> > pmc_core_init().
> >
> > Signed-off-by: Rajat Jain <rajatja@google.com>
>
> Thanks for sending this. This is certainly useful to support suspend-resume
> functionality for this driver which is otherwise only possible with PM
> notifiers otherwise and that is not desirable. Initially this was a PCI
> driver and after design discussion it was converted to module. I would like
> to consult Andy and Srinivas for their opinion about binding it to actual
> platform bus instead of the virtual bus as in its current form. In one of the
> internal versions, we used a known acpi PNP HID.

Sure, if there is an established ACPI PNP HID, then we could bind it
using that, on platforms where we are still developing BIOS /
coreboot. However, this might not be possible for shipping systems
(Kabylake / skylake) where there is no plan to change the BIOS.

>
> > ---
> > This is rebased off
> > git://git.infradead.org/linux-platform-drivers-x86.git/for-next
> >
> >  drivers/platform/x86/intel_pmc_core.c | 93 ++++++++++++++++++++-------
> >  1 file changed, 68 insertions(+), 25 deletions(-)
> >
> > diff --git a/drivers/platform/x86/intel_pmc_core.c b/drivers/platform/x86/intel_pmc_core.c
> > index f2c621b55f49..55578d07610c 100644
> > --- a/drivers/platform/x86/intel_pmc_core.c
> > +++ b/drivers/platform/x86/intel_pmc_core.c
> > @@ -19,6 +19,7 @@
> >  #include <linux/io.h>
> >  #include <linux/module.h>
> >  #include <linux/pci.h>
> > +#include <linux/platform_device.h>
> >  #include <linux/uaccess.h>
> >
> >  #include <asm/cpu_device_id.h>
> > @@ -854,12 +855,59 @@ static const struct dmi_system_id pmc_core_dmi_table[]  = {
> >       {}
> >  };
> >
> > -static int __init pmc_core_probe(void)
> > +static int pmc_core_probe(struct platform_device *pdev)
> >  {
> > -     struct pmc_dev *pmcdev = &pmc;
> > +     struct pmc_dev *pmcdev = platform_get_drvdata(pdev);
> > +     int err;
> > +
> > +     pmcdev->regbase = ioremap(pmcdev->base_addr,
> > +                               pmcdev->map->regmap_length);
> > +     if (!pmcdev->regbase)
> > +             return -ENOMEM;
> > +
> > +     mutex_init(&pmcdev->lock);
> > +     pmcdev->pmc_xram_read_bit = pmc_core_check_read_lock_bit();
> > +
> > +     err = pmc_core_dbgfs_register(pmcdev);
> > +     if (err < 0) {
> > +             dev_warn(&pdev->dev, "debugfs register failed.\n");
> > +             iounmap(pmcdev->regbase);
> > +             return err;
> > +     }
> > +
> > +     dmi_check_system(pmc_core_dmi_table);
> > +     dev_info(&pdev->dev, " initialized\n");
> > +     return 0;
> > +}
> > +
> > +static int pmc_core_remove(struct platform_device *pdev)
> > +{
> > +     struct pmc_dev *pmcdev = platform_get_drvdata(pdev);
> > +
> > +     pmc_core_dbgfs_unregister(pmcdev);
> > +     mutex_destroy(&pmcdev->lock);
> > +     iounmap(pmcdev->regbase);
> > +     return 0;
> > +}
> > +
> > +static struct platform_driver pmc_core_driver = {
> > +     .driver = {
> > +             .name = "pmc_core",
> > +     },
> > +     .probe = pmc_core_probe,
> > +     .remove = pmc_core_remove,
> > +};
> > +
> > +static struct platform_device pmc_core_device = {
> > +     .name           = "pmc_core",
> > +};
> > +
> > +static int __init pmc_core_init(void)
> > +{
> > +     int ret;
>
> Please use reverse x-mas tree style.

OK, will do.
>
> >       const struct x86_cpu_id *cpu_id;
> > +     struct pmc_dev *pmcdev = &pmc;
> >       u64 slp_s0_addr;
> > -     int err;
> >
> >       cpu_id = x86_match_cpu(intel_pmc_core_ids);
> >       if (!cpu_id)
> > @@ -880,36 +928,31 @@ static int __init pmc_core_probe(void)
> >       else
> >               pmcdev->base_addr = slp_s0_addr - pmcdev->map->slp_s0_offset;
> >
> > -     pmcdev->regbase = ioremap(pmcdev->base_addr,
> > -                               pmcdev->map->regmap_length);
> > -     if (!pmcdev->regbase)
> > -             return -ENOMEM;
> > +     platform_set_drvdata(&pmc_core_device, pmcdev);
> >
> > -     mutex_init(&pmcdev->lock);
> > -     pmcdev->pmc_xram_read_bit = pmc_core_check_read_lock_bit();
> > +     ret = platform_device_register(&pmc_core_device);
> > +     if (ret)
> > +             return ret;
> >
> > -     err = pmc_core_dbgfs_register(pmcdev);
> > -     if (err < 0) {
> > -             pr_warn(" debugfs register failed.\n");
> > -             iounmap(pmcdev->regbase);
> > -             return err;
> > -     }
> > +     ret = platform_driver_register(&pmc_core_driver);
> > +     if (ret)
> > +             goto out_remove_dev;
> >
> > -     dmi_check_system(pmc_core_dmi_table);
> > -     pr_info(" initialized\n");
> >       return 0;
> > +
> > +out_remove_dev:
> > +     platform_device_unregister(&pmc_core_device);
> > +     return ret;
> >  }
> > -module_init(pmc_core_probe)
> >
> > -static void __exit pmc_core_remove(void)
> > +static void __init pmc_core_exit(void)
> >  {
> > -     struct pmc_dev *pmcdev = &pmc;
> > -
> > -     pmc_core_dbgfs_unregister(pmcdev);
> > -     mutex_destroy(&pmcdev->lock);
> > -     iounmap(pmcdev->regbase);
> > +     platform_driver_unregister(&pmc_core_driver);
> > +     platform_device_unregister(&pmc_core_device);
> >  }
> > -module_exit(pmc_core_remove)
> > +
> > +module_init(pmc_core_init);
> > +module_exit(pmc_core_exit);
> >
> >  MODULE_LICENSE("GPL v2");
> >  MODULE_DESCRIPTION("Intel PMC Core Driver");
> > --
> > 2.21.0.360.g471c308f928-goog
> >
>
> --
> Best Regards,
> Rajneesh
