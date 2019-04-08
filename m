Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D609AC10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 18:36:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9897C20855
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 18:36:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h1XTfxUM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727273AbfDHSg4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 14:36:56 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:37759 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726369AbfDHSgz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 14:36:55 -0400
Received: by mail-lj1-f194.google.com with SMTP id v13so12189949ljk.4
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2019 11:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pYRDyIkEqmVC9oW4qAFujNVNCZfTEsyj7q+UIxB7Wy8=;
        b=h1XTfxUM25v3TL4rIfr6EgQPQLYer2qJuyM31nUw6IYN1POMSOvyGCYbhnejTmVI3d
         TAiza3ImnAwbH0eo/Tl6xIbkVbi2PwJIjAV1lyUYswmwsrWDPnOFIZ0AfvRjPYwJK6yS
         feB/d8/wRcCbq510XDX0D8wg3YDhT3HSseWh50V0v3kF/CLWiYhx3BxOxQgOw0b9ZUEq
         ajwClMxn7GQ30Ax59ezLpP44RRz15YxWJ5n5Y3L/sN/qwM+4RKZFP+fqKvUdOXKiGhmr
         uYSm8DOfjmX1dJiALDC77pQWml0wMh3SLadVAovjRX6BukKt5mNEApDs4Kogr3qaD1hs
         tdZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pYRDyIkEqmVC9oW4qAFujNVNCZfTEsyj7q+UIxB7Wy8=;
        b=K4NOcE4Eslq97pws7Y/BbzuQJ19GmoNW1i+wQqROAci41JSnhumIbXmf8NbYlowcJX
         m4/VhE5xbEsM8uJ5z+aNjU4RfRdJcAtR6e6oppGvRQpIt6BzFuYkDLKsjHEsrucd1Op/
         MRrUBLcWiHCzGPeeXm0s2G8smTj+FDPMArnEwxSJ4OMPPqRuhYOS0CZ2NW98RusYmj+z
         fYrCEE1xL1ZWeBEc/QzZ2W9+bJir2oR7ha1eVnQclSUyEc85qjdZdevL9yVB8z55+uZ7
         B5scLYlPR4S/A0GAPpG6Io1GzCNvOYnLDAUuysZLHNwbPyawk5Fn67rPybMlsiP3xX0s
         Sbow==
X-Gm-Message-State: APjAAAUC92UHz+Diz2i6oizKvxMBknrAQEY2ZvvbgMH7hddAp0leebUN
        XksesBl+Yds41cWRWXB0ygAYE3rGPvEmwAREblC9jQ==
X-Google-Smtp-Source: APXvYqzqTkXd9+kmayIYfKxzc6Qu9J1rTwgo0IC4f8x5jV/0gXUlu6kaPnEabwzveANPw+0ePTgF1610Vn0KugRa16o=
X-Received: by 2002:a2e:884a:: with SMTP id z10mr16620904ljj.21.1554748612610;
 Mon, 08 Apr 2019 11:36:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190313222124.229371-1-rajatja@google.com> <20190405203558.19160-1-rajatja@google.com>
 <20190405203558.19160-2-rajatja@google.com> <CAHp75VehpYPm1ApFozisSsNi1g0EtbKBm3C97jxXC2u04tpt0A@mail.gmail.com>
In-Reply-To: <CAHp75VehpYPm1ApFozisSsNi1g0EtbKBm3C97jxXC2u04tpt0A@mail.gmail.com>
From:   Rajat Jain <rajatja@google.com>
Date:   Mon, 8 Apr 2019 11:36:15 -0700
Message-ID: <CACK8Z6FGFiS_jN_5ctWmjKbrcUyjGkV0MsVs7_2TsaS7UAoydA@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] platform/x86: intel_pmc_core: Allow to dump debug
 registers on S0ix failure
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

On Mon, Apr 8, 2019 at 10:02 AM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Fri, Apr 5, 2019 at 11:36 PM Rajat Jain <rajatja@google.com> wrote:
> >
> > Add a module parameter which when enabled, will check on resume, if the
> > last S0ix attempt was successful. If not, the driver would warn and provide
> > helpful debug information (which gets latched during the failed suspend
> > attempt) to debug the S0ix failure.
> >
> > This information is very useful to debug S0ix failures. Specially since
> > the latched debug information will be lost (over-written) if the system
> > attempts to go into runtime (or imminent) S0ix again after that failed
> > suspend attempt.
>
> > +#ifdef CONFIG_PM_SLEEP
> > +
> > +static bool warn_on_s0ix_failures;
> > +module_param(warn_on_s0ix_failures, bool, 0644);
> > +MODULE_PARM_DESC(warn_on_s0ix_failures, "Check and warn for S0ix failures");
> > +
> > +static int pmc_core_suspend(struct device *dev)
> > +{
> > +       struct pmc_dev *pmcdev = dev_get_drvdata(dev);
> > +
> > +       /* Save PC10 and S0ix residency for checking later */
>
> > +       if (warn_on_s0ix_failures && !pm_suspend_via_firmware() &&
> > +           !rdmsrl_safe(MSR_PKG_C10_RESIDENCY, &pmcdev->pc10_counter) &&
> > +           !pmc_core_dev_state_get(pmcdev, &pmcdev->s0ix_counter))
> > +               pmcdev->check_counters = true;
>
> Perhaps something like
>
> pmcdev->check_counters = false;
> /* User doesn't want to be warned */
> if (!warn_on...)
>  return 0;
> /* We do suspend via firmware */
> if (...)
>  return 0;
> ...
>
> ?

I guess what you mean is one conditional per line. Sure, I will do that.

>
> > +       else
> > +               pmcdev->check_counters = false;
> > +
> > +       return 0;
> > +}
> > +
> > +static inline bool pc10_failed(struct pmc_dev *pmcdev)
>
> To be or not to be? :-)
> Perhaps names of the functions should be
>
> pmc_code_is_pc10_failed()
>
> and so on

I think the suggestion is to use pmc_core_* as the function names. OK,
I will rename the functions to:

pmc_core_pc10_failed()
and
pmc_core_s0ix_failed()


>
> > +{
> > +       u64 pc10_counter;
> > +
> > +       if (!rdmsrl_safe(MSR_PKG_C10_RESIDENCY, &pc10_counter) &&
> > +           pc10_counter == pmcdev->pc10_counter)
> > +               return true;
>
> > +       else
>
> Redundant.

OK, I'll remove the "else" part here.

>
> > +               return false;
> > +}
> > +
> > +static inline bool s0ix_failed(struct pmc_dev *pmcdev)
> > +{
> > +       u64 s0ix_counter;
> > +
> > +       if (!pmc_core_dev_state_get(pmcdev, &s0ix_counter) &&
> > +           s0ix_counter == pmcdev->s0ix_counter)
> > +               return true;
>
> > +       else
>
> Ditto.

OK, I'll remove the "else" part here.

>
> > +               return false;
> > +}
> > +
> > +static int pmc_core_resume(struct device *dev)
> > +{
> > +       struct pmc_dev *pmcdev = dev_get_drvdata(dev);
> > +
> > +       if (!pmcdev->check_counters)
> > +               return 0;
> > +
> > +       if (pc10_failed(pmcdev)) {
> > +               dev_info(dev, "PC10 entry had failed (PC10 cnt=0x%llx)\n",
> > +                        pmcdev->pc10_counter);
> > +       } else if (s0ix_failed(pmcdev)) {
> > +
> > +               const struct pmc_bit_map **maps = pmcdev->map->slps0_dbg_maps;
> > +               const struct pmc_bit_map *map;
> > +               int offset = pmcdev->map->slps0_dbg_offset;
> > +               u32 data;
> > +
> > +               dev_warn(dev, "S0ix entry had failed (S0ix cnt=%llu)\n",
> > +                        pmcdev->s0ix_counter);
> > +               while (*maps) {
> > +                       map = *maps;
> > +                       data = pmc_core_reg_read(pmcdev, offset);
> > +                       offset += 4;
> > +                       while (map->name) {
> > +                               dev_warn(dev, "SLP_S0_DBG: %-32s\tState: %s\n",
> > +                                        map->name,
> > +                                        data & map->bit_mask ? "Yes" : "No");
> > +                               ++map;
> > +                       }
> > +                       ++maps;
> > +               }
>
> Can't we utilize existing print helpers?

I didn't quite see any existing print helpers in this file. I took
this code from pmc_core_slps0_dbg_show(), and I think although I can
abstract out this code into a static function, the calling code need
to use seq_printf(s,...) and dev_warn(dev,...) respectively. - so
might be overkill (did not feel that the benefits were worth it).
Please let me know if you have any suggestions and will be happy to
use them.

Thanks,

Rajat


>
> > +       }
> > +       return 0;
> > +}
> > +
> > +#endif
>
> --
> With Best Regards,
> Andy Shevchenko
