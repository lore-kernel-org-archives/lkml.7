Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 995A2C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 18:25:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67E4B20857
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 18:25:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h4YiSACt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729036AbfDHSZv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 14:25:51 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:44341 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726753AbfDHSZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 14:25:51 -0400
Received: by mail-lf1-f66.google.com with SMTP id h18so1825886lfj.11
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2019 11:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ioqyPLefu+BxB1btErZNPPP2b3rtWQsxHiixDIGWVt4=;
        b=h4YiSACtJBsNh7Jvj89f7neW5IkZPq958jVyhsS2NijiF6A9qUA6TNXCPinetgPuOb
         9lIpDvgzQkcc8ArhIf3T/rN4NMPKkNGmPkj6HfKtYKfmc3zMqZSmjOd1dQY0H+kGb8Gz
         efEOfQSfh6J47l/xGVkUfyJRwBWtFCSVyMPAjKhldXatyk6NufjKbvUB1p1O7q5cVipI
         9qc5r1xL/OSRbOR8fsJcHQX4CGtYBoFiqhZjuSVXgygJdvo7IOlIYRrAnF8Xsu8znZtT
         TgtCzjvEHahWW8Sf+P9SXKuY1hqqKCnKKmmfVk8yozsJWnVVs1ONlf1tunDdBtT1LLgT
         cbBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ioqyPLefu+BxB1btErZNPPP2b3rtWQsxHiixDIGWVt4=;
        b=V47GXqvXCSPnNK6mjyZAR08Qo6IAPRH16ER7dzRLN8wDP9FEkndOUcpJ9A4LK5Oo4E
         D36osa5jxOcb1zEY96TELUpEOkbCYfp9YbkBbA725LQVz/hRaQLxJvXWghZYGJGYstTZ
         8146Qqrjotrrnqg3wrpXX7xVNowIufOiN0ehnB/uqILKQm7Ay1adcqaZImQb/8DKonxz
         48VJRzDgpvJr29HKJUZjTIDsM2atzP5wz069CmkNO/DqBhFD5+7vfB2gFxQ2EKM6AUI2
         Pn27qdDMdERlTrDenLUV+cCJbfmWg74k1ud/KkWkRtK0Zd7v82kO+X/yVcQlF4I4rHsE
         QlgQ==
X-Gm-Message-State: APjAAAW+jy6AguKxnPUEEHmAHFS1b+SV++kCoUYdxyrOGaQkZ3pvSS9S
        7F1imIOPol5EAJFvoxUQ66TTCAWIRfWZALE/powxOQ==
X-Google-Smtp-Source: APXvYqziy+M7NqBSUSb2fp9Ot1OZ6k7q3BZk1q76XggElb2Wmh/r4DQ076XrYvU70Ek2QeM2GERf8uLTHIbZr2+uLHc=
X-Received: by 2002:ac2:50d8:: with SMTP id h24mr16224439lfm.7.1554747949091;
 Mon, 08 Apr 2019 11:25:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190313222124.229371-1-rajatja@google.com> <20190405203558.19160-1-rajatja@google.com>
 <20190405203558.19160-3-rajatja@google.com> <CAHp75VcB=gBa01UJLYVzApZ-2g745zX=mEtE9nJUyfzFdk3-pw@mail.gmail.com>
In-Reply-To: <CAHp75VcB=gBa01UJLYVzApZ-2g745zX=mEtE9nJUyfzFdk3-pw@mail.gmail.com>
From:   Rajat Jain <rajatja@google.com>
Date:   Mon, 8 Apr 2019 11:25:12 -0700
Message-ID: <CACK8Z6FHE75PO9i9vOgj4-_EFh=TvjEgub-BYPjB6JrV5B0DYw@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] platform/x86: intel_pmc_core: Instantiate pmc_core
 device on legacy platforms
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>,
        Vishwanath Somayaji <vishwanath.somayaji@intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Wysocki@google.com, Rafael J <rafael.j.wysocki@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Furquan Shaikh <furquan@google.com>,
        Evan Green <evgreen@google.com>,
        Rajat Jain <rajatxjain@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 8, 2019 at 10:07 AM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Fri, Apr 5, 2019 at 11:36 PM Rajat Jain <rajatja@google.com> wrote:
> >
> > Add code to instantiate the pmc_core platform device and thus attach to
> > the driver, if the ACPI device for the same ("INT33A1") is not present
> > in a system where it should be. This was discussed here:
> > https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1966991.html
> >
>
>
>
> > +#include <linux/acpi.h>
> > +#include <linux/platform_device.h>
> > +
> > +#include <asm/cpu_device_id.h>
> > +#include <asm/intel-family.h>
> > +
> > +static struct platform_device pmc_core_device = {
> > +       .name = "pmc_core",
> > +};
> > +
>
> > +static int dummy;
> > +/*
> > + * INTEL_CPU_FAM6 macro won't take NULL for driver_data (uses &driver_data),
> > + * thus provide a dummy driver_data.
> > + */
>
> You may use pmc_core_device instead, right?

sure, will do.

>
> > +static const struct x86_cpu_id intel_pmc_core_ids[] = {
> > +       INTEL_CPU_FAM6(SKYLAKE_MOBILE, dummy),
> > +       INTEL_CPU_FAM6(SKYLAKE_DESKTOP, dummy),
> > +       INTEL_CPU_FAM6(KABYLAKE_MOBILE, dummy),
> > +       INTEL_CPU_FAM6(KABYLAKE_DESKTOP, dummy),
> > +       INTEL_CPU_FAM6(CANNONLAKE_MOBILE, dummy),
> > +       INTEL_CPU_FAM6(ICELAKE_MOBILE, dummy),
> > +       {}
> > +};
> > +MODULE_DEVICE_TABLE(x86cpu, intel_pmc_core_ids);
> > +
> > +static int __init pmc_core_platform_init(void)
> > +{
> > +       int ret;
> > +
> > +       /* Skip creating the platform device if ACPI already has a device */
> > +       if (acpi_dev_present("INT33A1", NULL, -1) ||
> > +           !x86_match_cpu(intel_pmc_core_ids))
> > +               return -ENODEV;
>
> Split it to one conditional per line.

sure, will do.

>
> > +
> > +       ret = platform_device_register(&pmc_core_device);
> > +       if (ret)
> > +               return ret;
> > +
> > +       return 0;
> > +}
> > +
> > +static void __exit pmc_core_platform_exit(void)
> > +{
>
> > +       if (!acpi_dev_present("INT33A1", NULL, -1) &&
> > +           x86_match_cpu(intel_pmc_core_ids))
>
> Redundant check.

will fix.

>
> > +               platform_device_unregister(&pmc_core_device);
> > +}
>
> --
> With Best Regards,
> Andy Shevchenko
