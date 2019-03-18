Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3069BC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 15:13:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E09C420872
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 15:13:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qc/aEsNH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbfCRPNP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 11:13:15 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:44833 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726740AbfCRPNO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 11:13:14 -0400
Received: by mail-qt1-f195.google.com with SMTP id w5so10011031qtb.11;
        Mon, 18 Mar 2019 08:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=sKidVpAOhewGsB9TPSJeQvBkvYX0qRIsHJQDqzf4dP4=;
        b=qc/aEsNHZOxNqtM6C4W8h9eeO+VVfLt7aPo05L0osM4nRvQXOO1XdBSTnNCTDbhg+n
         D07Wz7LyJ46vEHBq08YO4RkR/TiDSLmGIyDsU5YaCxYhGFSyvWH/X48IrCzziwGiBwHk
         46J6KlDLCBblratKhwFd3+3EeTy/frf540PgCrgqU/c3QAOYSvu16ZbIhll1qjoD8g2V
         1yR0uUBJjLwhE+kzpLdp6IDlfm+6AWIkjozFUddpJDM9SiVtxBElxjfdnIH0MPADZ6vl
         FQO6UNk9H5oa8OHv25WRc3fc7+Es1tFkjN3wnwzlki/w5SDn9KcM0P8VkO0F2DJDQCj5
         E+gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=sKidVpAOhewGsB9TPSJeQvBkvYX0qRIsHJQDqzf4dP4=;
        b=HvnLUw94/QOJLRSD48Ur/hvdEfa6IY3TMFInp2HYl5sJTYEyFgZl5LlN1AX+rI+yEs
         F4y9NwwVRP74SVWV1Hl2RiLEiYpfLj+iHeeVDKyIQVPvL7Ckl9L/uPCB5RFM3E2hzZLn
         4XloX4GAtugPAsVdhvT1rbCnDuxX/An8aIC2N1JeGhQB9nx537IzRv/dGfNAtfsAtAY3
         5X2gQfESn4dComfFnX6VT7FLVay4NRG2s8EZoexpCzGrF8M2L6y4a/97zj3wnbXbzZej
         CuMaCqntN8GI52X/NxP1r8+xu0dugp03oOU/aakcVs5vDnmfil2L4iwxty4c4NyveZAO
         /HPA==
X-Gm-Message-State: APjAAAXSadwRPQSQuK0Em16Pig40xSXReD9nIJ9+ftPJjJahZCz9XdSs
        5ozzC/IR7h7UPtAy4vEQvtU/ww6ONh92HWPBTxU=
X-Google-Smtp-Source: APXvYqxj+qdZulTGNDLhjcTfQgxAu91LOD05ITEekBmfWdYfFXcnckDwXXVC96FyFpmUF+ZjyNsJttDMaN47jJZRUDo=
X-Received: by 2002:ac8:3f26:: with SMTP id c35mr5208861qtk.252.1552921992933;
 Mon, 18 Mar 2019 08:13:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190313222124.229371-1-rajatja@google.com> <20190313222124.229371-2-rajatja@google.com>
 <20190316083024.GB21812@raj-desk2.iind.intel.com>
In-Reply-To: <20190316083024.GB21812@raj-desk2.iind.intel.com>
Reply-To: rajatxjain@gmail.com
From:   Rajat Jain <rajatxjain@gmail.com>
Date:   Mon, 18 Mar 2019 08:13:01 -0700
Message-ID: <CAA93t1o5mEUxzJ6yi0Hay1wQP1xgnRw9tEvMhAHKVX3Wvi=OWQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] platform/x86: intel_pmc_core: Allow to dump debug
 registers on S0ix failure
To:     Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>
Cc:     Rajat Jain <rajatja@google.com>,
        Vishwanath Somayaji <vishwanath.somayaji@intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        platform-driver-x86@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Furquan Shaikh <furquan@google.com>, evgreen@google.com,
        rajneesh.bhardwaj@linux.intel.com,
        srinivas.pandruvada@linux.intel.com, david.e.box@intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 16, 2019 at 1:43 AM Rajneesh Bhardwaj
<rajneesh.bhardwaj@intel.com> wrote:
>
> On Wed, Mar 13, 2019 at 03:21:24PM -0700, Rajat Jain wrote:
> > Add a module parameter which when enabled, will check on resume, if the
> > last S0ix attempt was successful. If not, the driver would provide
> > helpful debug information (which gets latched during the failed suspend
> > attempt) to debug the S0ix failure.
>
> + Srinivas and David.
>
> >
> > This information is very useful to debug S0ix failures. Specially since
> > the latched debug information will be lost (over-written) if the system
> > attempts to go into runtime (or imminent) S0ix again after that failed
> > suspend attempt.
> >
> > Signed-off-by: Rajat Jain <rajatja@google.com>
> > ---
> >  drivers/platform/x86/intel_pmc_core.c | 86 +++++++++++++++++++++++++++
> >  drivers/platform/x86/intel_pmc_core.h |  7 +++
> >  2 files changed, 93 insertions(+)
> >
> > diff --git a/drivers/platform/x86/intel_pmc_core.c b/drivers/platform/x86/intel_pmc_core.c
> > index 55578d07610c..b1f4405a27ce 100644
> > --- a/drivers/platform/x86/intel_pmc_core.c
> > +++ b/drivers/platform/x86/intel_pmc_core.c
> > @@ -20,6 +20,7 @@
> >  #include <linux/module.h>
> >  #include <linux/pci.h>
> >  #include <linux/platform_device.h>
> > +#include <linux/suspend.h>
> >  #include <linux/uaccess.h>
> >
> >  #include <asm/cpu_device_id.h>
> > @@ -890,9 +891,94 @@ static int pmc_core_remove(struct platform_device *pdev)
> >       return 0;
> >  }
> >
> > +#ifdef CONFIG_PM_SLEEP
> > +
> > +static bool warn_on_s0ix_failures;
> > +module_param(warn_on_s0ix_failures, bool, 0644);
> > +MODULE_PARM_DESC(warn_on_s0ix_failures, "Check and warn for S0ix failures");
> > +
> > +static int pmc_core_suspend(struct device *dev)
> > +{
> > +     struct pmc_dev *pmcdev = dev_get_drvdata(dev);
> > +
> > +     /* Save PC10 and S0ix residency for checking later */
> > +     if (warn_on_s0ix_failures &&
> > +         !rdmsrl_safe(MSR_PKG_C10_RESIDENCY, &pmcdev->pc10_counter) &&
> > +         !pmc_core_dev_state_get(pmcdev, &pmcdev->s0ix_counter))
> > +             pmcdev->check_counters = true;
> > +     else
> > +             pmcdev->check_counters = false;
> > +
> > +     return 0;
> > +}
> > +
> > +static inline bool pc10_failed(struct pmc_dev *pmcdev)
> > +{
> > +     u64 pc10_counter;
> > +
> > +     if (!rdmsrl_safe(MSR_PKG_C10_RESIDENCY, &pc10_counter) &&
> > +         pc10_counter == pmcdev->pc10_counter)
> > +             return true;
> > +     else
> > +             return false;
> > +}
> > +
> > +static inline bool s0ix_failed(struct pmc_dev *pmcdev)
> > +{
> > +     u64 s0ix_counter;
> > +
> > +     if (!pmc_core_dev_state_get(pmcdev, &s0ix_counter) &&
> > +         s0ix_counter == pmcdev->s0ix_counter)
> > +             return true;
> > +     else
> > +             return false;
> > +}
> > +
> > +static int pmc_core_resume(struct device *dev)
> > +{
> > +     struct pmc_dev *pmcdev = dev_get_drvdata(dev);
> > +
> > +     if (!pmcdev->check_counters)
> > +             return 0;
> > +
> > +     if (pc10_failed(pmcdev)) {
> > +             dev_info(dev, "PC10 entry had failed (PC10 cnt=0x%llx)\n",
> > +                      pmcdev->pc10_counter);
> > +     } else if (s0ix_failed(pmcdev)) {
> > +
> > +             const struct pmc_bit_map **maps = pmcdev->map->slps0_dbg_maps;
>
> slps0_dbg feature is not available on Skylake and Kabylake. PCH IP power
> gating status is available on all.

Right, so the slps0_dbg_maps field is only populated for the platforms
that have the slps0_dbg feature. So it seems like the below code would
work well for both kind of platforms.

>
> > +             const struct pmc_bit_map *map;
> > +             int offset = pmcdev->map->slps0_dbg_offset;
> > +             u32 data;
> > +
> > +             dev_warn(dev, "S0ix entry had failed (S0ix cnt=%llu)\n",
> > +                      pmcdev->s0ix_counter);
>
> I feel this dev_warn may be frowned upon and should be possible kept behind
> something like pm_debug_messages_on though module param helps mitigate it.

Right, in my mind, as the parameter name suggests, the whole intent of
the "warn_on_s0ix_failures" is to generate noticable warnings. Since
these warnings are off by default, and thus will only be generated
some one turns on the parameter, thus indicating he is interested in
being warned for failures.

Thanks,

Rajat

>
> > +             while (*maps) {
> > +                     map = *maps;
> > +                     data = pmc_core_reg_read(pmcdev, offset);
> > +                     offset += 4;
> > +                     while (map->name) {
> > +                             dev_warn(dev, "SLP_S0_DBG: %-32s\tState: %s\n",
> > +                                      map->name,
> > +                                      data & map->bit_mask ? "Yes" : "No");
> > +                             ++map;
> > +                     }
> > +                     ++maps;
> > +             }
> > +     }
> > +     return 0;
> > +}
> > +
> > +#endif
> > +
> > +const struct dev_pm_ops pmc_core_pm_ops = {
> > +     SET_LATE_SYSTEM_SLEEP_PM_OPS(pmc_core_suspend, pmc_core_resume)
> > +};
> > +
> >  static struct platform_driver pmc_core_driver = {
> >       .driver = {
> >               .name = "pmc_core",
> > +             .pm = &pmc_core_pm_ops
> >       },
> >       .probe = pmc_core_probe,
> >       .remove = pmc_core_remove,
> > diff --git a/drivers/platform/x86/intel_pmc_core.h b/drivers/platform/x86/intel_pmc_core.h
> > index 88d9c0653a5f..fdee5772e532 100644
> > --- a/drivers/platform/x86/intel_pmc_core.h
> > +++ b/drivers/platform/x86/intel_pmc_core.h
> > @@ -241,6 +241,9 @@ struct pmc_reg_map {
> >   * @pmc_xram_read_bit:       flag to indicate whether PMC XRAM shadow registers
> >   *                   used to read MPHY PG and PLL status are available
> >   * @mutex_lock:              mutex to complete one transcation
> > + * @check_counters:  On resume, check if counters are getting incremented
> > + * @pc10_counter:    PC10 residency counter
> > + * @s0ix_counter:    S0ix residency (step adjusted)
> >   *
> >   * pmc_dev contains info about power management controller device.
> >   */
> > @@ -253,6 +256,10 @@ struct pmc_dev {
> >  #endif /* CONFIG_DEBUG_FS */
> >       int pmc_xram_read_bit;
> >       struct mutex lock; /* generic mutex lock for PMC Core */
> > +
> > +     bool check_counters; /* Check for counter increments on resume */
> > +     u64 pc10_counter;
> > +     u64 s0ix_counter;
> >  };
> >
> >  #endif /* PMC_CORE_H */
> > --
> > 2.21.0.360.g471c308f928-goog
> >
>
> --
> Best Regards,
> Rajneesh
