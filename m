Return-Path: <SRS0=Dr8o=U4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B414C4321A
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Jun 2019 13:24:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C5FF2086D
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Jun 2019 13:24:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WQm+cBYM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726859AbfF2NYX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Jun 2019 09:24:23 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41134 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726731AbfF2NYX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jun 2019 09:24:23 -0400
Received: by mail-pg1-f193.google.com with SMTP id q4so2363482pgj.8;
        Sat, 29 Jun 2019 06:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GyjmIieAkSvtFPJ2RM/QvCR+edPTBd5UDZcV9pbUH70=;
        b=WQm+cBYM3gl/LV62mWMLGd48RbcRoNGivwXmtpu2+hj4KHy0nqlFBNV/ulHzrlXtaB
         xEVFcniaStIOW6xti2blE5qT62ejR4HIwE5BBytIrro/L4dbLrgrUAMMiGLIgJeZx8z6
         O6JKMjiMPvvm8PQc+F2MQ2MhnmgzCuEcWsYfBbLTOqmHgH/oRrJ3R6M9dgm2f+9OjuYt
         s9XalmOQI9c6qfz4833Tvf2Xj2pQ2Hm4KdUTxVwlTbCXYULATavJmzZ7kVlS83fnO4DB
         aZZDlJpTYxeGNH/LUXi48CbIThFvCpAc4em7ijai2Wq9J42PsX3RpSS8UcG1xQyUkAgE
         iYeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GyjmIieAkSvtFPJ2RM/QvCR+edPTBd5UDZcV9pbUH70=;
        b=WXm0QoZflbCVh9H/nOAVdDGPZY1TBktFkvzq1JfJfI6HIk5L9w/u6Eu+yXfSoj/sq5
         axp1duAMo1beMzy45YPWzTWl7Bggko77uAo44tUVyR4liH6WjtLl4g1ig4HMb4Qrqikq
         NUMx3atGLRZo73pin5CgbVwrMYwUFKpM4lqcqvZSvkzSmKvvKkmrD5maUlBM31hzBK4n
         e64uiE+a+9Hhb1QKB7l6KtVyFZd5Z5E7b0OPnHFhtnltO3WuTP7ROPvfCN6ZMOZq87GM
         ithrl/R5MxyY4fDgHZ9pe2/ZuyGGZklW2f3PzP6dmfR22ghLmGmRySF1AiDZ/VtKw0G+
         xWfQ==
X-Gm-Message-State: APjAAAWU30lIObUMfgX6F5QuSHB8QVYE/0ginRdxftbp8b+R8P26jmBQ
        M4ODHeh0JVmOUutDPK2G2nkbVfSbAhCcfok2psc=
X-Google-Smtp-Source: APXvYqz7AKBOSLAxjwKqdOQSXA9EF+XcoSJ++b/3XkGy9KzHMgJ8weg1o+idfwinPqCrqBEY/WfZvjF01mK2EO4qnZE=
X-Received: by 2002:a17:90b:8d2:: with SMTP id ds18mr19791419pjb.132.1561814662655;
 Sat, 29 Jun 2019 06:24:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190528025727.6014-1-harry.pan@intel.com> <20190619082801.21699-1-harry.pan@intel.com>
In-Reply-To: <20190619082801.21699-1-harry.pan@intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 29 Jun 2019 16:24:11 +0300
Message-ID: <CAHp75VdnL1CHvbo+JWwKVhCaqnT45GVVjtLKppnvnbOPfvbURw@mail.gmail.com>
Subject: Re: [PATCH v3] platform/x86: intel_pmc_core: transform Pkg C-state
 residency from TSC ticks into microseconds
To:     Harry Pan <harry.pan@intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, gs0622@gmail.com,
        Vishwanath Somayaji <vishwanath.somayaji@intel.com>,
        Andy Shevchenko <andy@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>,
        Darren Hart <dvhart@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 19, 2019 at 11:29 AM Harry Pan <harry.pan@intel.com> wrote:
>
> Refer to the Intel SDM Vol.4, the package C-state residency counters
> of modern IA micro-architecture are all ticking in TSC frequency,
> hence we can apply simple math to transform the ticks into microseconds.
> i.e.,
> residency (ms) = count / tsc_khz
> residency (us) = count / tsc_khz * 1000
>
> This also aligns to other sysfs debug entries of residency counter in
> the same metric in microseconds, benefits reading and scripting.
>
> v2: restore the accidentally deleted newline, no function change.
> v3: apply kernel do_div() macro to calculate division
>
> Signed-off-by: Harry Pan <harry.pan@intel.com>
>

Pushed to my review and testing queue, thanks!

> ---
>
>  drivers/platform/x86/intel_pmc_core.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/platform/x86/intel_pmc_core.c b/drivers/platform/x86/intel_pmc_core.c
> index f2c621b55f49..ab798efacc85 100644
> --- a/drivers/platform/x86/intel_pmc_core.c
> +++ b/drivers/platform/x86/intel_pmc_core.c
> @@ -24,6 +24,7 @@
>  #include <asm/cpu_device_id.h>
>  #include <asm/intel-family.h>
>  #include <asm/msr.h>
> +#include <asm/tsc.h>
>
>  #include "intel_pmc_core.h"
>
> @@ -738,7 +739,9 @@ static int pmc_core_pkgc_show(struct seq_file *s, void *unused)
>                 if (rdmsrl_safe(map[index].bit_mask, &pcstate_count))
>                         continue;
>
> -               seq_printf(s, "%-8s : 0x%llx\n", map[index].name,
> +               pcstate_count *= 1000;
> +               do_div(pcstate_count, tsc_khz);
> +               seq_printf(s, "%-8s : %llu\n", map[index].name,
>                            pcstate_count);
>         }
>
> --
> 2.20.1
>


-- 
With Best Regards,
Andy Shevchenko
