Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCC36C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 10:37:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E3412184E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 10:37:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727708AbfCTKhP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 06:37:15 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:49980 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbfCTKhO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 06:37:14 -0400
Received: from 79.184.255.210.ipv4.supernova.orange.pl (79.184.255.210) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.213)
 id c667f092d1442b86; Wed, 20 Mar 2019 11:37:10 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>,
        Rajat Jain <rajatxjain@gmail.com>
Cc:     "Somayaji, Vishwanath" <vishwanath.somayaji@intel.com>,
        Rajat Jain <rajatja@google.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "furquan@google.com" <furquan@google.com>,
        "evgreen@google.com" <evgreen@google.com>,
        rajneesh.bhardwaj@linux.intel.com,
        srinivas.pandruvada@linux.intel.com, david.e.box@intel.com,
        rafael.j.wysocki@intel.com
Subject: Re: [PATCH 2/2] platform/x86: intel_pmc_core: Allow to dump debug registers on S0ix failure
Date:   Wed, 20 Mar 2019 11:35:19 +0100
Message-ID: <1958671.nZbISSljmY@aspire.rjw.lan>
In-Reply-To: <20190318160106.GA31964@raj-desk2.iind.intel.com>
References: <20190313222124.229371-1-rajatja@google.com> <CAA93t1o=Yd8_kUQ=AjXPBF-vFXEPN_E6ij7EjbC7jAXUrQ+xNw@mail.gmail.com> <20190318160106.GA31964@raj-desk2.iind.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, March 18, 2019 5:01:06 PM CET Rajneesh Bhardwaj wrote:
> On Mon, Mar 18, 2019 at 08:18:56AM -0700, Rajat Jain wrote:
> > On Mon, Mar 18, 2019 at 2:31 AM Somayaji, Vishwanath
> > <vishwanath.somayaji@intel.com> wrote:
> > >
> > >
> > >
> > > >-----Original Message-----
> > > >From: Rajat Jain <rajatja@google.com>
> > > >Sent: Thursday, March 14, 2019 3:51 AM
> > > >To: Bhardwaj, Rajneesh <rajneesh.bhardwaj@intel.com>; Somayaji, Vishwanath
> > > ><vishwanath.somayaji@intel.com>; Darren Hart <dvhart@infradead.org>; Andy
> > > >Shevchenko <andy@infradead.org>; platform-driver-x86@vger.kernel.org; linux-
> > > >kernel@vger.kernel.org
> > > >Cc: Rajat Jain <rajatja@google.com>; furquan@google.com;
> > > >evgreen@google.com; rajatxjain@gmail.com
> > > >Subject: [PATCH 2/2] platform/x86: intel_pmc_core: Allow to dump debug
> > > >registers on S0ix failure
> > > >
> > > >Add a module parameter which when enabled, will check on resume, if the
> > > >last S0ix attempt was successful. If not, the driver would provide
> > > >helpful debug information (which gets latched during the failed suspend
> > > >attempt) to debug the S0ix failure.
> > > >
> > > >This information is very useful to debug S0ix failures. Specially since
> > > >the latched debug information will be lost (over-written) if the system
> > > >attempts to go into runtime (or imminent) S0ix again after that failed
> > > >suspend attempt.
> > > >
> > > >Signed-off-by: Rajat Jain <rajatja@google.com>
> > > >---
> > > > drivers/platform/x86/intel_pmc_core.c | 86 +++++++++++++++++++++++++++
> > > > drivers/platform/x86/intel_pmc_core.h |  7 +++
> > > > 2 files changed, 93 insertions(+)
> > > >
> > > >diff --git a/drivers/platform/x86/intel_pmc_core.c
> > > >b/drivers/platform/x86/intel_pmc_core.c
> > > >index 55578d07610c..b1f4405a27ce 100644
> > > >--- a/drivers/platform/x86/intel_pmc_core.c
> > > >+++ b/drivers/platform/x86/intel_pmc_core.c
> > > >@@ -20,6 +20,7 @@
> > > > #include <linux/module.h>
> > > > #include <linux/pci.h>
> > > > #include <linux/platform_device.h>
> > > >+#include <linux/suspend.h>
> > > > #include <linux/uaccess.h>
> > > >
> > > > #include <asm/cpu_device_id.h>
> > > >@@ -890,9 +891,94 @@ static int pmc_core_remove(struct platform_device
> > > >*pdev)
> > > >       return 0;
> > > > }
> > > >
> > > >+#ifdef CONFIG_PM_SLEEP
> > > >+
> > > >+static bool warn_on_s0ix_failures;
> > > >+module_param(warn_on_s0ix_failures, bool, 0644);
> > > >+MODULE_PARM_DESC(warn_on_s0ix_failures, "Check and warn for S0ix
> > > >failures");
> > > >+
> > > >+static int pmc_core_suspend(struct device *dev)
> > > >+{
> > > >+      struct pmc_dev *pmcdev = dev_get_drvdata(dev);
> > > >+
> > > >+      /* Save PC10 and S0ix residency for checking later */
> > > >+      if (warn_on_s0ix_failures &&
> > > >+          !rdmsrl_safe(MSR_PKG_C10_RESIDENCY, &pmcdev->pc10_counter)
> > > >&&
> > > >+          !pmc_core_dev_state_get(pmcdev, &pmcdev->s0ix_counter))
> > > >+              pmcdev->check_counters = true;
> > > >+      else
> > > >+              pmcdev->check_counters = false;
> > > >+
> > > >+      return 0;
> > > >+}
> > > >+
> > > >+static inline bool pc10_failed(struct pmc_dev *pmcdev)
> > > >+{
> > > >+      u64 pc10_counter;
> > > >+
> > > >+      if (!rdmsrl_safe(MSR_PKG_C10_RESIDENCY, &pc10_counter) &&
> > > >+          pc10_counter == pmcdev->pc10_counter)
> > > >+              return true;
> > > >+      else
> > > >+              return false;
> > > >+}
> > > >+
> > > >+static inline bool s0ix_failed(struct pmc_dev *pmcdev)
> > > >+{
> > > >+      u64 s0ix_counter;
> > > >+
> > > >+      if (!pmc_core_dev_state_get(pmcdev, &s0ix_counter) &&
> > > >+          s0ix_counter == pmcdev->s0ix_counter)
> > > >+              return true;
> > > >+      else
> > > >+              return false;
> > > >+}
> > > >+
> > > >+static int pmc_core_resume(struct device *dev)
> > > >+{
> > > >+      struct pmc_dev *pmcdev = dev_get_drvdata(dev);
> > > >+
> > > >+      if (!pmcdev->check_counters)
> > > >+              return 0;
> > > >+
> > > >+      if (pc10_failed(pmcdev)) {
> > > >+              dev_info(dev, "PC10 entry had failed (PC10 cnt=0x%llx)\n",
> > > >+                       pmcdev->pc10_counter);
> > > >+      } else if (s0ix_failed(pmcdev)) {
> > > >+
> > > >+              const struct pmc_bit_map **maps = pmcdev->map-
> > > >>slps0_dbg_maps;
> > > >+              const struct pmc_bit_map *map;
> > > >+              int offset = pmcdev->map->slps0_dbg_offset;
> > > >+              u32 data;
> > > >+
> > > >+              dev_warn(dev, "S0ix entry had failed (S0ix cnt=%llu)\n",
> > > >+                       pmcdev->s0ix_counter);
> > > >+              while (*maps) {
> > > >+                      map = *maps;
> > > >+                      data = pmc_core_reg_read(pmcdev, offset);
> > > >+                      offset += 4;
> > > >+                      while (map->name) {
> > > >+                              dev_warn(dev, "SLP_S0_DBG: %-32s\tState:
> > > >%s\n",
> > > >+                                       map->name,
> > > >+                                       data & map->bit_mask ? "Yes" : "No");
> > > >+                              ++map;
> > > >+                      }
> > > >+                      ++maps;
> > > >+              }
> > > >+      }
> > > >+      return 0;
> > > >+}
> > > >+
> > > >+#endif
> > > >+
> > > >+const struct dev_pm_ops pmc_core_pm_ops = {
> > > >+      SET_LATE_SYSTEM_SLEEP_PM_OPS(pmc_core_suspend,
> > > >pmc_core_resume)
> > > These PM Ops routines will be called not just in s2idle scenario, but also in other suspend scenarios like s2ram, s2disk. However actual functionalities served by these routines are relevant only for s2idle.
> > > That means we will end up having false errors in s2ram/s2disk scenarios as PC10/s0ix counters wont increment in those scenarios.
> > 
> > Yes, you are right. Currently there is no API for a driver to know
> > whether the *current suspend* attempt is targeting S0ix or S3.

As a matter of fact, if pm_suspend_via_firmware() returns "true", then
S0ix cannot be the target.

However, you cannot say whether or not S0ix is the target if
pm_suspend_via_firmware() returns "false".

I guess that is the problem here?

> > I was hoping that the pm_suspend_via_s2idle() might tell us that but
> > that is not true. Note that this issue is mitigated by the expectation
> > that this parameter (warn_on_s0ix_failures) will only be enabled only on
> > platforms that use S0ix.
> 
> Maybe we can use ACPI_FADT_LOW_POWER_S0 also as a condition to dump this
> data though callback is best way to check in my opinion.
> 
> Adding Srinivas, David and Rafael.

You cannot really say whether or not a platform is going to use S0ix, as
S0ix technically is an extension of the idle path.

What happens is that the last non-idle CPU requests C10 and the SoC
decides how to handle that request.  There are many possible things it
may do then.

AFAICS, ACPI_FADT_LOW_POWER_S0 set doesn't need to mean that S0ix is possible
(user space may disable C10 via sysfs, for example), but at least it shouldn't
be unset in that case, so it can be used as an indicator of S0ix availability.

> > However, if this is a concern and there is a string sentiment around
> > it, I am happy to throw in a patch that adds such an API in the pm
> > core and uses it (I have a patch ready).

That API is there already AFAICS.

