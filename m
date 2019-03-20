Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB9A9C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 19:05:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BDD620850
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 19:05:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WDKKlued"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726611AbfCTTFH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 15:05:07 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:33512 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726119AbfCTTFG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 15:05:06 -0400
Received: by mail-lj1-f193.google.com with SMTP id f23so3272662ljc.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 12:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5NxuJ9bZ6a6GrHoOK+1K2u7C3vXCjf5837mrgbAB4qE=;
        b=WDKKluedpOdU+wUMK/1HZBwx1GGZSOBEVlsB9F29KwpUKWS85CLWbasAsQEWfFyNfU
         NtUvuR52IxIdGHlvYk19Cdi4BwResEgID8op8rBFZT7fGVjxZJE3AolvX4Hot7bRg5RN
         eMFuHzaMlX18wxaI/Br1feIlnr9DFQV4ExGDyKSusSqfOD0UuDyQi2LEhxLmUg1/ipjc
         V8tC1d1YoKa4CaZc4/9IdXJzAUGksWUK8+vz1sAKXjEzDLx87kU1N5at5F0VyxSuNGEE
         SkXBD7OJbBK1FC1Ar9Fn4FulxhyHp49xQlvaYfQl89w/0wnxsaCnqhpYa062FzZ09UpO
         QsyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5NxuJ9bZ6a6GrHoOK+1K2u7C3vXCjf5837mrgbAB4qE=;
        b=lVtQ7qk6AC3ZoG1QNLI8Kt6w6vQmfMkm81xir9PTdqJgF8P3QPaullQJBN1RZ7xV/2
         m43ZKgvC+mTbuJDxWwm0vjVXC3O1SffZw8Rd1qMYO5KeBIFCQNPFeNayqW8cowlrXs2V
         EY06lInQXDIJXEQCIi9NB7GtvWsH2Mdz+V/1TGXFlFY/EwumveDlU9RkCB1ceTiBoIPR
         KrAnQVPDiugeqfsFFzZepIC8WrEtV9djO9lvQjVllslS3BRAsKwOFem3Z0pNDwz654u/
         vylXEunF/0FkHAqb1DtO5GK7brpBWZJKjUIOuLGjzHfPDhxAWRHuBGuYwL1PaPKk1JKS
         KNVw==
X-Gm-Message-State: APjAAAWov7xU3OIOrfWjSfPWkPJWTK4pnpj3KSSrKn5baGgjQNWB72Rz
        ni+BaAv/iKVC37PNWZZbguJ+SXICzJIWiQl2Ek+HyZ5Cnh0=
X-Google-Smtp-Source: APXvYqx0frUWdDq4NmHmz5x3+BsOs3KO59GKGAgHLOYYhvQPE9sJmdPDoQsfxD3ulXC/qQOwK37sFCiq5Q9+rjpWl9Y=
X-Received: by 2002:a2e:90c9:: with SMTP id o9mr13034732ljg.102.1553108703773;
 Wed, 20 Mar 2019 12:05:03 -0700 (PDT)
MIME-Version: 1.0
References: <20190313222124.229371-1-rajatja@google.com> <CAA93t1o=Yd8_kUQ=AjXPBF-vFXEPN_E6ij7EjbC7jAXUrQ+xNw@mail.gmail.com>
 <20190318160106.GA31964@raj-desk2.iind.intel.com> <1958671.nZbISSljmY@aspire.rjw.lan>
In-Reply-To: <1958671.nZbISSljmY@aspire.rjw.lan>
From:   Rajat Jain <rajatja@google.com>
Date:   Wed, 20 Mar 2019 12:04:26 -0700
Message-ID: <CACK8Z6GWsm1dXb92_3tDXWSOBMDbHsWyQiT+ANJCky3YLxh-KQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] platform/x86: intel_pmc_core: Allow to dump debug
 registers on S0ix failure
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>,
        Rajat Jain <rajatxjain@gmail.com>,
        "Somayaji, Vishwanath" <vishwanath.somayaji@intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "furquan@google.com" <furquan@google.com>,
        "evgreen@google.com" <evgreen@google.com>,
        rajneesh.bhardwaj@linux.intel.com,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        david.e.box@intel.com,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rafael,
On Wed, Mar 20, 2019 at 3:37 AM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> On Monday, March 18, 2019 5:01:06 PM CET Rajneesh Bhardwaj wrote:
> > On Mon, Mar 18, 2019 at 08:18:56AM -0700, Rajat Jain wrote:
> > > On Mon, Mar 18, 2019 at 2:31 AM Somayaji, Vishwanath
> > > <vishwanath.somayaji@intel.com> wrote:
> > > >
> > > >
> > > >
> > > > >-----Original Message-----
> > > > >From: Rajat Jain <rajatja@google.com>
> > > > >Sent: Thursday, March 14, 2019 3:51 AM
> > > > >To: Bhardwaj, Rajneesh <rajneesh.bhardwaj@intel.com>; Somayaji, Vishwanath
> > > > ><vishwanath.somayaji@intel.com>; Darren Hart <dvhart@infradead.org>; Andy
> > > > >Shevchenko <andy@infradead.org>; platform-driver-x86@vger.kernel.org; linux-
> > > > >kernel@vger.kernel.org
> > > > >Cc: Rajat Jain <rajatja@google.com>; furquan@google.com;
> > > > >evgreen@google.com; rajatxjain@gmail.com
> > > > >Subject: [PATCH 2/2] platform/x86: intel_pmc_core: Allow to dump debug
> > > > >registers on S0ix failure
> > > > >
> > > > >Add a module parameter which when enabled, will check on resume, if the
> > > > >last S0ix attempt was successful. If not, the driver would provide
> > > > >helpful debug information (which gets latched during the failed suspend
> > > > >attempt) to debug the S0ix failure.
> > > > >
> > > > >This information is very useful to debug S0ix failures. Specially since
> > > > >the latched debug information will be lost (over-written) if the system
> > > > >attempts to go into runtime (or imminent) S0ix again after that failed
> > > > >suspend attempt.
> > > > >
> > > > >Signed-off-by: Rajat Jain <rajatja@google.com>
> > > > >---
> > > > > drivers/platform/x86/intel_pmc_core.c | 86 +++++++++++++++++++++++++++
> > > > > drivers/platform/x86/intel_pmc_core.h |  7 +++
> > > > > 2 files changed, 93 insertions(+)
> > > > >
> > > > >diff --git a/drivers/platform/x86/intel_pmc_core.c
> > > > >b/drivers/platform/x86/intel_pmc_core.c
> > > > >index 55578d07610c..b1f4405a27ce 100644
> > > > >--- a/drivers/platform/x86/intel_pmc_core.c
> > > > >+++ b/drivers/platform/x86/intel_pmc_core.c
> > > > >@@ -20,6 +20,7 @@
> > > > > #include <linux/module.h>
> > > > > #include <linux/pci.h>
> > > > > #include <linux/platform_device.h>
> > > > >+#include <linux/suspend.h>
> > > > > #include <linux/uaccess.h>
> > > > >
> > > > > #include <asm/cpu_device_id.h>
> > > > >@@ -890,9 +891,94 @@ static int pmc_core_remove(struct platform_device
> > > > >*pdev)
> > > > >       return 0;
> > > > > }
> > > > >
> > > > >+#ifdef CONFIG_PM_SLEEP
> > > > >+
> > > > >+static bool warn_on_s0ix_failures;
> > > > >+module_param(warn_on_s0ix_failures, bool, 0644);
> > > > >+MODULE_PARM_DESC(warn_on_s0ix_failures, "Check and warn for S0ix
> > > > >failures");
> > > > >+
> > > > >+static int pmc_core_suspend(struct device *dev)
> > > > >+{
> > > > >+      struct pmc_dev *pmcdev = dev_get_drvdata(dev);
> > > > >+
> > > > >+      /* Save PC10 and S0ix residency for checking later */
> > > > >+      if (warn_on_s0ix_failures &&
> > > > >+          !rdmsrl_safe(MSR_PKG_C10_RESIDENCY, &pmcdev->pc10_counter)
> > > > >&&
> > > > >+          !pmc_core_dev_state_get(pmcdev, &pmcdev->s0ix_counter))
> > > > >+              pmcdev->check_counters = true;
> > > > >+      else
> > > > >+              pmcdev->check_counters = false;
> > > > >+
> > > > >+      return 0;
> > > > >+}
> > > > >+
> > > > >+static inline bool pc10_failed(struct pmc_dev *pmcdev)
> > > > >+{
> > > > >+      u64 pc10_counter;
> > > > >+
> > > > >+      if (!rdmsrl_safe(MSR_PKG_C10_RESIDENCY, &pc10_counter) &&
> > > > >+          pc10_counter == pmcdev->pc10_counter)
> > > > >+              return true;
> > > > >+      else
> > > > >+              return false;
> > > > >+}
> > > > >+
> > > > >+static inline bool s0ix_failed(struct pmc_dev *pmcdev)
> > > > >+{
> > > > >+      u64 s0ix_counter;
> > > > >+
> > > > >+      if (!pmc_core_dev_state_get(pmcdev, &s0ix_counter) &&
> > > > >+          s0ix_counter == pmcdev->s0ix_counter)
> > > > >+              return true;
> > > > >+      else
> > > > >+              return false;
> > > > >+}
> > > > >+
> > > > >+static int pmc_core_resume(struct device *dev)
> > > > >+{
> > > > >+      struct pmc_dev *pmcdev = dev_get_drvdata(dev);
> > > > >+
> > > > >+      if (!pmcdev->check_counters)
> > > > >+              return 0;
> > > > >+
> > > > >+      if (pc10_failed(pmcdev)) {
> > > > >+              dev_info(dev, "PC10 entry had failed (PC10 cnt=0x%llx)\n",
> > > > >+                       pmcdev->pc10_counter);
> > > > >+      } else if (s0ix_failed(pmcdev)) {
> > > > >+
> > > > >+              const struct pmc_bit_map **maps = pmcdev->map-
> > > > >>slps0_dbg_maps;
> > > > >+              const struct pmc_bit_map *map;
> > > > >+              int offset = pmcdev->map->slps0_dbg_offset;
> > > > >+              u32 data;
> > > > >+
> > > > >+              dev_warn(dev, "S0ix entry had failed (S0ix cnt=%llu)\n",
> > > > >+                       pmcdev->s0ix_counter);
> > > > >+              while (*maps) {
> > > > >+                      map = *maps;
> > > > >+                      data = pmc_core_reg_read(pmcdev, offset);
> > > > >+                      offset += 4;
> > > > >+                      while (map->name) {
> > > > >+                              dev_warn(dev, "SLP_S0_DBG: %-32s\tState:
> > > > >%s\n",
> > > > >+                                       map->name,
> > > > >+                                       data & map->bit_mask ? "Yes" : "No");
> > > > >+                              ++map;
> > > > >+                      }
> > > > >+                      ++maps;
> > > > >+              }
> > > > >+      }
> > > > >+      return 0;
> > > > >+}
> > > > >+
> > > > >+#endif
> > > > >+
> > > > >+const struct dev_pm_ops pmc_core_pm_ops = {
> > > > >+      SET_LATE_SYSTEM_SLEEP_PM_OPS(pmc_core_suspend,
> > > > >pmc_core_resume)
> > > > These PM Ops routines will be called not just in s2idle scenario, but also in other suspend scenarios like s2ram, s2disk. However actual functionalities served by these routines are relevant only for s2idle.
> > > > That means we will end up having false errors in s2ram/s2disk scenarios as PC10/s0ix counters wont increment in those scenarios.
> > >
> > > Yes, you are right. Currently there is no API for a driver to know
> > > whether the *current suspend* attempt is targeting S0ix or S3.
>
> As a matter of fact, if pm_suspend_via_firmware() returns "true", then
> S0ix cannot be the target.
>
> However, you cannot say whether or not S0ix is the target if
> pm_suspend_via_firmware() returns "false".
>
> I guess that is the problem here?

Yes, I had sent in a v2 yesterday using pm_suspend_via_firmware() but
I forgot to copy you. Can you please take a look at if this is better:
https://patchwork.kernel.org/patch/10860657/

>
> > > I was hoping that the pm_suspend_via_s2idle() might tell us that but
> > > that is not true. Note that this issue is mitigated by the expectation
> > > that this parameter (warn_on_s0ix_failures) will only be enabled only on
> > > platforms that use S0ix.
> >
> > Maybe we can use ACPI_FADT_LOW_POWER_S0 also as a condition to dump this
> > data though callback is best way to check in my opinion.
> >
> > Adding Srinivas, David and Rafael.
>
> You cannot really say whether or not a platform is going to use S0ix, as
> S0ix technically is an extension of the idle path.
>
> What happens is that the last non-idle CPU requests C10 and the SoC
> decides how to handle that request.  There are many possible things it
> may do then.
>
> AFAICS, ACPI_FADT_LOW_POWER_S0 set doesn't need to mean that S0ix is possible
> (user space may disable C10 via sysfs, for example), but at least it shouldn't
> be unset in that case, so it can be used as an indicator of S0ix availability.

So, it seems to be the suggestion is to check for
ACPI_FADT_LOW_POWER_S0 in addition to pm_suspend_via_firmware()? If I
understand it right, the ACPI_FADT_LOW_POWER_S0 indicates the platform
capability of going into S0ix. So may be it makes more sense to check
for that flag at the init time. Does anyone feel that this driver
needs to be loaded on systems that do not have ACPI_FADT_LOW_POWER_S0?

>
> > > However, if this is a concern and there is a string sentiment around
> > > it, I am happy to throw in a patch that adds such an API in the pm
> > > core and uses it (I have a patch ready).
>
> That API is there already AFAICS.
>

I assume you mean pm_suspend_via_firmware()? I've used that in my v2,
can you please see if that makes it more acceptable?

Thanks,

Rajat
