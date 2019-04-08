Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=2.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7361EC10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 17:07:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CFAD20880
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 17:07:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cNPTXECW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729233AbfDHRHb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 13:07:31 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40156 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727190AbfDHRHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 13:07:31 -0400
Received: by mail-pg1-f194.google.com with SMTP id d31so3142447pgl.7;
        Mon, 08 Apr 2019 10:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IoEqp9VXr7ZHjWgHuKuuRapGCnmDj5ipp6Qfksvb9Kg=;
        b=cNPTXECWXcmiM+EaSME17AYTqoLm9zu1ecJeONWVJ1SBwpTxWlTucK+W9GIw2S+Dgl
         7m3Owf9EXIhzXNBmXzrYs5Ah5HLnexKtMSaIyBa2+1JF9owZaHpRh1VB02nqLXxhK52N
         3LDsb9NdviMalyTk4AeDCgnl1yTuzybuO0e6aQJQXV2Vdj8GfHRFA14LhhV0aaUfQYaH
         peReTMFZXD5Xg4qlyN3jMNWU45YgI6de/eWQ8ildWhDrilAkkwKofgzPEsKOPieEFymL
         SnsLsjfUCEYdn38yHbOB2oApV9ypWCR26LzdFad1yoO+NYHIPSrsMGa03AUVXzdpMbP0
         rw9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IoEqp9VXr7ZHjWgHuKuuRapGCnmDj5ipp6Qfksvb9Kg=;
        b=UIHmcxsXMFizVmoNNcFPFOHYE2wPMIp8UXyVGAhSqIkgMSqyvHRViLLjU6QRvCgLyA
         gxcCx8iuQH6lU9/ME5c0PhLI+5f3cHKP8o5JOM/5SFuQsMGJ70C2je2F7wRwkTCXEuS7
         p2VYEDJDLrCcbz1h0PM0WG7LidzVgWiuETeypN+ClX3Bsb3dGWAU9FI5ND8zcMn+M4VY
         WYdmGFDHmsWwWguslwdqALNGhTfCxSCW/TjT3TdfjXN+f3bISIbOe0SeCXeacxgJalcb
         DQKAZm1NLKePXuB7IKouq5/OHyQtZMz8HqlJBBp3nwXBDPxncqaH4ch0sNqEHgrjnG2F
         GmBw==
X-Gm-Message-State: APjAAAWF3GcKGK4QkOkoznSjbDN0UoqwyQPNdh6kZNy/cCXdE0775pEv
        S3lx5EALzL/yffPM28FBcqtehliP6EiDf2fkVhY=
X-Google-Smtp-Source: APXvYqxeOTXZ4hXQlak7D3T7syxINgYjh05OGKtWKI1VKHDtHUHrnL3ce3sbNJade9+duyybdEp51jxJW+P+v0PnjgY=
X-Received: by 2002:a65:6210:: with SMTP id d16mr28697627pgv.110.1554743250315;
 Mon, 08 Apr 2019 10:07:30 -0700 (PDT)
MIME-Version: 1.0
References: <20190313222124.229371-1-rajatja@google.com> <20190405203558.19160-1-rajatja@google.com>
 <20190405203558.19160-3-rajatja@google.com>
In-Reply-To: <20190405203558.19160-3-rajatja@google.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 8 Apr 2019 20:07:19 +0300
Message-ID: <CAHp75VcB=gBa01UJLYVzApZ-2g745zX=mEtE9nJUyfzFdk3-pw@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] platform/x86: intel_pmc_core: Instantiate pmc_core
 device on legacy platforms
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
> Add code to instantiate the pmc_core platform device and thus attach to
> the driver, if the ACPI device for the same ("INT33A1") is not present
> in a system where it should be. This was discussed here:
> https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1966991.html
>



> +#include <linux/acpi.h>
> +#include <linux/platform_device.h>
> +
> +#include <asm/cpu_device_id.h>
> +#include <asm/intel-family.h>
> +
> +static struct platform_device pmc_core_device = {
> +       .name = "pmc_core",
> +};
> +

> +static int dummy;
> +/*
> + * INTEL_CPU_FAM6 macro won't take NULL for driver_data (uses &driver_data),
> + * thus provide a dummy driver_data.
> + */

You may use pmc_core_device instead, right?

> +static const struct x86_cpu_id intel_pmc_core_ids[] = {
> +       INTEL_CPU_FAM6(SKYLAKE_MOBILE, dummy),
> +       INTEL_CPU_FAM6(SKYLAKE_DESKTOP, dummy),
> +       INTEL_CPU_FAM6(KABYLAKE_MOBILE, dummy),
> +       INTEL_CPU_FAM6(KABYLAKE_DESKTOP, dummy),
> +       INTEL_CPU_FAM6(CANNONLAKE_MOBILE, dummy),
> +       INTEL_CPU_FAM6(ICELAKE_MOBILE, dummy),
> +       {}
> +};
> +MODULE_DEVICE_TABLE(x86cpu, intel_pmc_core_ids);
> +
> +static int __init pmc_core_platform_init(void)
> +{
> +       int ret;
> +
> +       /* Skip creating the platform device if ACPI already has a device */
> +       if (acpi_dev_present("INT33A1", NULL, -1) ||
> +           !x86_match_cpu(intel_pmc_core_ids))
> +               return -ENODEV;

Split it to one conditional per line.

> +
> +       ret = platform_device_register(&pmc_core_device);
> +       if (ret)
> +               return ret;
> +
> +       return 0;
> +}
> +
> +static void __exit pmc_core_platform_exit(void)
> +{

> +       if (!acpi_dev_present("INT33A1", NULL, -1) &&
> +           x86_match_cpu(intel_pmc_core_ids))

Redundant check.

> +               platform_device_unregister(&pmc_core_device);
> +}

-- 
With Best Regards,
Andy Shevchenko
