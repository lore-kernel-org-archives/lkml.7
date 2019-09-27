Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59866C4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 06:01:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2914320863
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 06:01:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s6P7A9Y4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725975AbfI0GBU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 02:01:20 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40867 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725769AbfI0GBU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 02:01:20 -0400
Received: by mail-pg1-f195.google.com with SMTP id w10so2856580pgj.7;
        Thu, 26 Sep 2019 23:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cJMu35fWVskaN7wUhAIYd6yUy7R5h61oLGNi6VYauuo=;
        b=s6P7A9Y4hGrbwsqhE7oSqitLL1hRexC7TD7nbC+Qpgwb9dvSAjvhUD4HxRjFt3AEbA
         fHrJY9v2+vLic7gMo8z1b2VQa7qNyE5TpNTUe1J0Qx3tmDTXCMhZIb1sy0pRACIsU8UA
         48TOOAf/E07FsJJ+br0+dOvTwC6c+52g9sa0ZBjI4CA3vMrJjAU6I5yCRycWjBFJyl5a
         OMQgYG/COmklzhQKDHK4C8dM1DNrc8jg4xxx6EjonF2HyWK7e4/XKUFac2sGrwzenpht
         Tnl0UcXFIuYvb8ar9/EEnz98sGkznMYpIZ1xfO9gXuQ+cZ0KtW+CYXRCr/vPzgwwX1BK
         Okdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cJMu35fWVskaN7wUhAIYd6yUy7R5h61oLGNi6VYauuo=;
        b=uVP5FQ6ikM9vSwxoT8PI1Nt25F/ZKQ7rxK1emx0as2LOw+91ubLPd92xwaOMVHa9z8
         ZMFqZYgxagj8nCjB5nHvSftFeoTlWC4zIbshV7SCaTHHVgLduVrPE3yNemI+rqxFeNkm
         SQJEN9aBqMUTWTfLo5Q8B27w9eawNIWviruLbMEqd1Thd+j9h2cxctu3TobRogkLz3Vs
         GEM3J8pZCBnfIfxgahhCUEWZohR8Ozt2nCXoEr4XA3D5Jj2rjXdIIamsHfg8KDyZcIXY
         D6cB+UAMR+mLtbxW4BjBUkv0jWnNLd0CHIBNmi1NAY1mrjW9wQqs2zTC491Yg11fwEfQ
         zZTw==
X-Gm-Message-State: APjAAAU94amRVjwSajsy5frma7yVlrU+xrXRnOcDri1pMLIhm2hvXl4b
        MGQSiWRUqHgm/qNtnj/3uwr/sytiHn0HvQOTNsg=
X-Google-Smtp-Source: APXvYqyF4GvyoxQRtLPT6AfvFn4Oa1VSEbUSSbBgGHqBIH9Xb4W6SfG3Lwgz9vNRxfPTrLstjIrxqEQJPjvhQD1X23M=
X-Received: by 2002:a63:170e:: with SMTP id x14mr7415254pgl.4.1569564079182;
 Thu, 26 Sep 2019 23:01:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190926192603.18647-1-gayatri.kammela@intel.com>
In-Reply-To: <20190926192603.18647-1-gayatri.kammela@intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 27 Sep 2019 09:01:07 +0300
Message-ID: <CAHp75Vcrp2ffDCE=tm2dwSEhwfPCPWGhb-Nw0v-7ga2y=_dL8w@mail.gmail.com>
Subject: Re: [PATCH v1 0/5] Add Tiger Lake/Elkhart Lake support to pmc_core driver
To:     Gayatri Kammela <gayatri.kammela@intel.com>
Cc:     Platform Driver <platform-driver-x86@vger.kernel.org>,
        Vishwanath Somayaji <vishwanath.somayaji@intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        charles.d.prestopine@intel.com,
        Peter Zijlstra <peterz@infradead.org>,
        Srinivas Pandruvada <srinivas.pandruvada@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kan Liang <kan.liang@intel.com>,
        "David E . Box" <david.e.box@intel.com>,
        Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>,
        Tony Luck <tony.luck@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 26, 2019 at 9:43 PM Gayatri Kammela
<gayatri.kammela@intel.com> wrote:

Thank you for the series, I'll comment them later.

For now, check how to properly setup prefix for all patches. The Title
all broken.

> Patch 1: Cleans up termination lines
> Patch 2: Refactor driver for ease of adding new SoCs
> Patch 3: Refactor debugfs entry for PCH IPs power gating status
> Patch 4: Add Tiger Lake legacy support to pmc_core
> Patch 5: Add Elkhart Lake legacy support to pmc_core
>
> All the information regarding the PCH IPs and names of IPs will be available
> in *future* Intel's Platform Controller Hub (PCH) External Design Specification
> (EDS) document.

When?

> Gayatri Kammela (5):
>   x86/intel_pmc_core: Clean up: Remove comma after the termination line
>   x86/intel_pmc_core: Create platform dependent pmc bitmap structs
>   x86/intel_pmc_core: Make debugfs entry for pch_ip_power_gating_status
>     conditional
>   platform/x86: Add Tiger Lake(TGL) platform support to intel_pmc_core
>     driver
>   platform/x86: Add Atom based Elkhart Lake(EHL) platform support to
>     intel_pmc_core driver
>
>  drivers/platform/x86/intel_pmc_core.c | 108 +++++++++++++++++++++-----
>  drivers/platform/x86/intel_pmc_core.h |   2 +-
>  2 files changed, 88 insertions(+), 22 deletions(-)
>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Srinivas Pandruvada <srinivas.pandruvada@intel.com>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Kan Liang <kan.liang@intel.com>
> Cc: David E. Box <david.e.box@intel.com>
> Cc: Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>
> Cc: Tony Luck <tony.luck@intel.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> --
> 2.17.1
>


-- 
With Best Regards,
Andy Shevchenko
