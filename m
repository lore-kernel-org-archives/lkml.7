Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8581DC432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 10:50:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A37C2071B
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 10:50:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ayd31pqB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726705AbfKRKuh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 05:50:37 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:32821 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726460AbfKRKuh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 05:50:37 -0500
Received: by mail-pg1-f195.google.com with SMTP id h27so9483548pgn.0;
        Mon, 18 Nov 2019 02:50:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BqVjvVnUcZVnJi0dFDzKzL0XCvYGeHQtLWoFBVaIgfo=;
        b=Ayd31pqBaEduLCLyuo+QyEWMnJQ72tXZwKpOgnwKvmrmi695Dg4D5uuzLw1axs5LWx
         IQvvoJeKa1+z13ptdS53J6AUQ6vmi1/mMSstg7H4P1Z+LApMSl63sgxlekurJiZudrf1
         0mBBUwBfwlwu0n5NZEGdqRnYfE8MDs5NPPmYipfKHyUoo+239+nDoxgOb5YeDEKMhPT1
         9YnuJFXnL1wPgacF6+ShP5kJBsLEx88mGG0o+Bl9o89rkvz0pFcZqUYijrlpHbxKshep
         25C+3Y3ms3aKXVKZ29ZqFsp9Yrnc4KpoqtkEAOv7cecfW9g9SSpxqrZGcCbPYbPdi1MA
         Xvqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BqVjvVnUcZVnJi0dFDzKzL0XCvYGeHQtLWoFBVaIgfo=;
        b=UjYc9pG1/jy6l3yqCYKkObiSmi3h8TferuzAiULDpbggYe1EDz3UfrCBQOYWJ1TRcv
         5I6137aAb4dXETwpe+BXGIpkyajf7EB6hMqpPKQ6bkOjEHZ/MMpfKf2LvclKb9usk/pm
         NuXKcJ8Fs96QtRDd/WnKxcrxKRHyPcHDdbCvzhKGxfCJ6hN7x/eKbCEcnIjYK9NRpMIJ
         +ewD7LCUxUeTE9+BZvr7jrmGIEso8R4yVCPcB8eYiCxjbWp6RbNEyR66TWPmuv/pCE/J
         m5mmK4YrIzwnw+Pz3caiFxtSgL4PTcxc2jptQsFpmhUIeXT98vqIoBl4RMkjFcAt2miH
         o3Ug==
X-Gm-Message-State: APjAAAWGTfZicta4vZBL/Sy0TK/Z8g/8vb3yqipAmznzV7eal3e5Bv8R
        ElTIS3ccdGXHIo6Z4v6Uq5HX9UWImOFFHXpW8GS2CXVd
X-Google-Smtp-Source: APXvYqx++lSD0HGf3aeWI/TZZso98LiZGfaZQBYI7l2ELIoaZlK9QvdQ8UzpW+1TSyFj8i3ZyS+GjVEf044dpDgAgz8=
X-Received: by 2002:a65:5542:: with SMTP id t2mr14406631pgr.74.1574074235201;
 Mon, 18 Nov 2019 02:50:35 -0800 (PST)
MIME-Version: 1.0
References: <cover.1573750525.git.gayatri.kammela@intel.com>
In-Reply-To: <cover.1573750525.git.gayatri.kammela@intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 18 Nov 2019 12:50:25 +0200
Message-ID: <CAHp75Vfrd-BAZ7H_LuQfz32yaap1X3gEnqZ2-9EPQ+j_b0f93g@mail.gmail.com>
Subject: Re: [PATCH v3 0/7] x86/intel_pmc_core: Add Tiger Lake, Elkhart Lake
To:     Gayatri Kammela <gayatri.kammela@intel.com>
Cc:     Platform Driver <platform-driver-x86@vger.kernel.org>,
        Vishwanath Somayaji <vishwanath.somayaji@intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Prestopine, Charles D" <charles.d.prestopine@intel.com>,
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

On Thu, Nov 14, 2019 at 7:02 PM Gayatri Kammela
<gayatri.kammela@intel.com> wrote:
>
> Hi,
>
> Patch 1: Fix SoC naming inconsistency
> Patch 2: Cleans up termination lines
> Patch 3: Refactor driver for ease of adding new SoCs
> Patch 4: Add debugfs entry for PCH IPs only if platform supports
> Patch 5: Add Tiger Lake legacy support to pmc_core
> Patch 6: Add Elkhart Lake legacy support to pmc_core
> patch 7: Add Comet Lake legacy support to pmc_core
>
> All the information regarding the PCH IPs and names of IPs will be
> available in Intel's Platform Controller Hub (PCH) External Design
> Specification (EDS) document expected to be released in 2020 before
> product launch.

Thanks, though you forgot to fix all prefixes in the mails. We have
platform/x86: $DRIVER_NAME: ...

Also consider Mario's comment (I didn't hear back from you on it).

>
> Changes since v1:
> 1) Added a patch that fixes the naming inconsistency.
> 2) Fixed the prefix of all the patches.
>
> Changes since v2:
> 1) Add Comet Lake legacy support to pmc_core up on Dell's request
>
> Gayatri Kammela (7):
>   x86/intel_pmc_core: Fix the SoC naming inconsistency
>   x86/intel_pmc_core: Clean up: Remove comma after the termination line
>   x86/intel_pmc_core: Create platform dependent pmc bitmap structs
>   x86/intel_pmc_core: Make debugfs entry for pch_ip_power_gating_status
>     conditional
>   platform/x86: Add Tiger Lake (TGL) platform support to intel_pmc_core
>     driver
>   platform/x86: Add Atom based Elkhart Lake (EHL) platform support to
>     intel_pmc_core driver
>   platform/x86: Add Comet Lake (CML) platform support to intel_pmc_core
>     driver
>
>  drivers/platform/x86/intel_pmc_core.c | 121 ++++++++++++++++++++------
>  drivers/platform/x86/intel_pmc_core.h |   2 +-
>  2 files changed, 96 insertions(+), 27 deletions(-)
>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Srinivas Pandruvada <srinivas.pandruvada@intel.com>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Kan Liang <kan.liang@intel.com>
> Cc: David E. Box <david.e.box@intel.com>
> Cc: Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>
> Cc: Tony Luck <tony.luck@intel.com>
>
> --
> 2.17.1
>


-- 
With Best Regards,
Andy Shevchenko
