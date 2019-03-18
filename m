Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D1DAC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 15:19:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 628FE2085A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 15:19:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lS2Vw9vE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727183AbfCRPTL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 11:19:11 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:36591 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726730AbfCRPTJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 11:19:09 -0400
Received: by mail-qt1-f194.google.com with SMTP id y36so8549240qtb.3;
        Mon, 18 Mar 2019 08:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=fkgtIWEIn2k3jmg3cj/wx/Ct/XYnzgOpK+yZ/hxfmYA=;
        b=lS2Vw9vEm/qUC37Z89ZXHmtHDP8wLQNCIhiQ0OseRSunNhUZl7SQG/HeosXi2rpRvF
         LMfa5igkSOB/tIbUXlYgxg2B41ceG1lmFJZQfJA4WHuaBr/Nrh9F92+qyBh2Lztqd0QY
         XXBWkZ7WxSB2IYCewo/UrZbqxn8t67NtKL/iywYW2tSEgaGOf2EiPOH2tMVFW+YiZ4s2
         d11dvbgaEXWj8f6YmTdprDWTqdXwOO3B3l7nf5UV3VyLQ9cp3ohH0oEj0cOtSMREdgHR
         uZ0m+VIEdheskk1o5UzaVFAUdqHqdb0xGBI2L9yGq6FmGVlQv+CY4D0HXi4gyywgwB5x
         nMiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=fkgtIWEIn2k3jmg3cj/wx/Ct/XYnzgOpK+yZ/hxfmYA=;
        b=uPZ6T9Oj5up951kEszPoc0sdD4JxuQyg9Ak0PVo8TKq6VdtT12JxnRkdjcavzAR9sd
         ee1cc0iHsCIMeYEBoQ1eopS0Z03C7TEnMmOSSlu0vqCWt+D8FtzIBM54WNi+ldP7a4cp
         GynWWsTC6hTehzA+7V4HpmdkYGsRDAXDWBCS4kximOaTQnuRTHVxNrOUgPeDBqbYOqDB
         kdkH3UVv36B4rWt8oVhGQi+ZS3SXoNB8Zfvg+D4bQ2cOiB/GejXC3mHsgnxo6EaTb3Dg
         cDhn2Tb4DESRxh+t91gV4VpDlIAGu9qYuVDT69OU8RwQVExJL4ID/4476HF/615pUo93
         H5cg==
X-Gm-Message-State: APjAAAXGz5fB4kPIfxvr5tYgDpz3If3tmlRbDn0fZRZtEZoV1iUywV5p
        +n6inJ3+NOhS0pGq0rNlPVBNxwZcXkFZem1XSDk=
X-Google-Smtp-Source: APXvYqx8QAXdeN3M8vqKkPFJJVh7qZvCeEzsgWt9Z7OL14cnR1FWeyC6m5z3FTedtkEGDmP0FFWLhYmxJttyHWvRIF8=
X-Received: by 2002:aed:2572:: with SMTP id w47mr2153949qtc.21.1552922347745;
 Mon, 18 Mar 2019 08:19:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190313222124.229371-1-rajatja@google.com> <20190313222124.229371-2-rajatja@google.com>
 <219AAEFC072D3A42B064BBBC1181F9BF65C25C8E@BGSMSX102.gar.corp.intel.com>
In-Reply-To: <219AAEFC072D3A42B064BBBC1181F9BF65C25C8E@BGSMSX102.gar.corp.intel.com>
Reply-To: rajatxjain@gmail.com
From:   Rajat Jain <rajatxjain@gmail.com>
Date:   Mon, 18 Mar 2019 08:18:56 -0700
Message-ID: <CAA93t1o=Yd8_kUQ=AjXPBF-vFXEPN_E6ij7EjbC7jAXUrQ+xNw@mail.gmail.com>
Subject: Re: [PATCH 2/2] platform/x86: intel_pmc_core: Allow to dump debug
 registers on S0ix failure
To:     "Somayaji, Vishwanath" <vishwanath.somayaji@intel.com>
Cc:     Rajat Jain <rajatja@google.com>,
        "Bhardwaj, Rajneesh" <rajneesh.bhardwaj@intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "furquan@google.com" <furquan@google.com>,
        "evgreen@google.com" <evgreen@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 18, 2019 at 2:31 AM Somayaji, Vishwanath
<vishwanath.somayaji@intel.com> wrote:
>
>
>
> >-----Original Message-----
> >From: Rajat Jain <rajatja@google.com>
> >Sent: Thursday, March 14, 2019 3:51 AM
> >To: Bhardwaj, Rajneesh <rajneesh.bhardwaj@intel.com>; Somayaji, Vishwanath
> ><vishwanath.somayaji@intel.com>; Darren Hart <dvhart@infradead.org>; Andy
> >Shevchenko <andy@infradead.org>; platform-driver-x86@vger.kernel.org; linux-
> >kernel@vger.kernel.org
> >Cc: Rajat Jain <rajatja@google.com>; furquan@google.com;
> >evgreen@google.com; rajatxjain@gmail.com
> >Subject: [PATCH 2/2] platform/x86: intel_pmc_core: Allow to dump debug
> >registers on S0ix failure
> >
> >Add a module parameter which when enabled, will check on resume, if the
> >last S0ix attempt was successful. If not, the driver would provide
> >helpful debug information (which gets latched during the failed suspend
> >attempt) to debug the S0ix failure.
> >
> >This information is very useful to debug S0ix failures. Specially since
> >the latched debug information will be lost (over-written) if the system
> >attempts to go into runtime (or imminent) S0ix again after that failed
> >suspend attempt.
> >
> >Signed-off-by: Rajat Jain <rajatja@google.com>
> >---
> > drivers/platform/x86/intel_pmc_core.c | 86 +++++++++++++++++++++++++++
> > drivers/platform/x86/intel_pmc_core.h |  7 +++
> > 2 files changed, 93 insertions(+)
> >
> >diff --git a/drivers/platform/x86/intel_pmc_core.c
> >b/drivers/platform/x86/intel_pmc_core.c
> >index 55578d07610c..b1f4405a27ce 100644
> >--- a/drivers/platform/x86/intel_pmc_core.c
> >+++ b/drivers/platform/x86/intel_pmc_core.c
> >@@ -20,6 +20,7 @@
> > #include <linux/module.h>
> > #include <linux/pci.h>
> > #include <linux/platform_device.h>
> >+#include <linux/suspend.h>
> > #include <linux/uaccess.h>
> >
> > #include <asm/cpu_device_id.h>
> >@@ -890,9 +891,94 @@ static int pmc_core_remove(struct platform_device
> >*pdev)
> >       return 0;
> > }
> >
> >+#ifdef CONFIG_PM_SLEEP
> >+
> >+static bool warn_on_s0ix_failures;
> >+module_param(warn_on_s0ix_failures, bool, 0644);
> >+MODULE_PARM_DESC(warn_on_s0ix_failures, "Check and warn for S0ix
> >failures");
> >+
> >+static int pmc_core_suspend(struct device *dev)
> >+{
> >+      struct pmc_dev *pmcdev = dev_get_drvdata(dev);
> >+
> >+      /* Save PC10 and S0ix residency for checking later */
> >+      if (warn_on_s0ix_failures &&
> >+          !rdmsrl_safe(MSR_PKG_C10_RESIDENCY, &pmcdev->pc10_counter)
> >&&
> >+          !pmc_core_dev_state_get(pmcdev, &pmcdev->s0ix_counter))
> >+              pmcdev->check_counters = true;
> >+      else
> >+              pmcdev->check_counters = false;
> >+
> >+      return 0;
> >+}
> >+
> >+static inline bool pc10_failed(struct pmc_dev *pmcdev)
> >+{
> >+      u64 pc10_counter;
> >+
> >+      if (!rdmsrl_safe(MSR_PKG_C10_RESIDENCY, &pc10_counter) &&
> >+          pc10_counter == pmcdev->pc10_counter)
> >+              return true;
> >+      else
> >+              return false;
> >+}
> >+
> >+static inline bool s0ix_failed(struct pmc_dev *pmcdev)
> >+{
> >+      u64 s0ix_counter;
> >+
> >+      if (!pmc_core_dev_state_get(pmcdev, &s0ix_counter) &&
> >+          s0ix_counter == pmcdev->s0ix_counter)
> >+              return true;
> >+      else
> >+              return false;
> >+}
> >+
> >+static int pmc_core_resume(struct device *dev)
> >+{
> >+      struct pmc_dev *pmcdev = dev_get_drvdata(dev);
> >+
> >+      if (!pmcdev->check_counters)
> >+              return 0;
> >+
> >+      if (pc10_failed(pmcdev)) {
> >+              dev_info(dev, "PC10 entry had failed (PC10 cnt=0x%llx)\n",
> >+                       pmcdev->pc10_counter);
> >+      } else if (s0ix_failed(pmcdev)) {
> >+
> >+              const struct pmc_bit_map **maps = pmcdev->map-
> >>slps0_dbg_maps;
> >+              const struct pmc_bit_map *map;
> >+              int offset = pmcdev->map->slps0_dbg_offset;
> >+              u32 data;
> >+
> >+              dev_warn(dev, "S0ix entry had failed (S0ix cnt=%llu)\n",
> >+                       pmcdev->s0ix_counter);
> >+              while (*maps) {
> >+                      map = *maps;
> >+                      data = pmc_core_reg_read(pmcdev, offset);
> >+                      offset += 4;
> >+                      while (map->name) {
> >+                              dev_warn(dev, "SLP_S0_DBG: %-32s\tState:
> >%s\n",
> >+                                       map->name,
> >+                                       data & map->bit_mask ? "Yes" : "No");
> >+                              ++map;
> >+                      }
> >+                      ++maps;
> >+              }
> >+      }
> >+      return 0;
> >+}
> >+
> >+#endif
> >+
> >+const struct dev_pm_ops pmc_core_pm_ops = {
> >+      SET_LATE_SYSTEM_SLEEP_PM_OPS(pmc_core_suspend,
> >pmc_core_resume)
> These PM Ops routines will be called not just in s2idle scenario, but also in other suspend scenarios like s2ram, s2disk. However actual functionalities served by these routines are relevant only for s2idle.
> That means we will end up having false errors in s2ram/s2disk scenarios as PC10/s0ix counters wont increment in those scenarios.

Yes, you are right. Currently there is no API for a driver to know
whether the *current suspend* attempt is targeting S0ix or S3. I was
hoping that the pm_suspend_via_s2idle() might tell us that but that is
not true. Note that this issue is mitigated by the expectation that
this parameter (warn_on_s0ix_failures) will only be enabled only on
platforms that use S0ix.

However, if this is a concern and there is a string sentiment around
it, I am happy to throw in a patch that adds such an API in the pm
core and uses it (I have a patch ready).

Thanks,

Rajat

>
> Vishwa
> >+};
> >+
> > static struct platform_driver pmc_core_driver = {
> >       .driver = {
> >               .name = "pmc_core",
> >+              .pm = &pmc_core_pm_ops
> >       },
> >       .probe = pmc_core_probe,
> >       .remove = pmc_core_remove,
> >diff --git a/drivers/platform/x86/intel_pmc_core.h
> >b/drivers/platform/x86/intel_pmc_core.h
> >index 88d9c0653a5f..fdee5772e532 100644
> >--- a/drivers/platform/x86/intel_pmc_core.h
> >+++ b/drivers/platform/x86/intel_pmc_core.h
> >@@ -241,6 +241,9 @@ struct pmc_reg_map {
> >  * @pmc_xram_read_bit:        flag to indicate whether PMC XRAM shadow
> >registers
> >  *                    used to read MPHY PG and PLL status are available
> >  * @mutex_lock:               mutex to complete one transcation
> >+ * @check_counters:   On resume, check if counters are getting incremented
> >+ * @pc10_counter:     PC10 residency counter
> >+ * @s0ix_counter:     S0ix residency (step adjusted)
> >  *
> >  * pmc_dev contains info about power management controller device.
> >  */
> >@@ -253,6 +256,10 @@ struct pmc_dev {
> > #endif /* CONFIG_DEBUG_FS */
> >       int pmc_xram_read_bit;
> >       struct mutex lock; /* generic mutex lock for PMC Core */
> >+
> >+      bool check_counters; /* Check for counter increments on resume */
> >+      u64 pc10_counter;
> >+      u64 s0ix_counter;
> > };
> >
> > #endif /* PMC_CORE_H */
> >--
> >2.21.0.360.g471c308f928-goog
>
