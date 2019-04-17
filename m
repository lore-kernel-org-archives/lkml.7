Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4097C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 23:05:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EF532183F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 23:05:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Lm6m18D7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387729AbfDQXFh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 19:05:37 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:42672 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387678AbfDQXFg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 19:05:36 -0400
Received: by mail-lf1-f68.google.com with SMTP id w23so68307lfc.9
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 16:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lsbUj33t0gvsr22SOjy5oOx+euNA0zyjnMbm0MoFT28=;
        b=Lm6m18D7DDLxGW4pE/oVKUWBxtkwVpAhoiG0u+nt2CWjHjnCRil59cTQhP7ctWxWfB
         llpokaf87CTT/uuVnY2BfjPG5EMdVTf6PynjKbcGVLLJmRA5Am1sPG+vL9CrhOjEATHF
         upZAjB4Cy8U+D1qKKaVLfffEDCi9sl9MPO0kXlaxzYSsME79qLHkjuelCL4qbh5yzo1r
         shMoJ27CpZN1unYrM/1yWDBOHRYEYcri09mleCpaiL9ODAMEjFeMISI/j1UsY0DlZ9Uu
         pQBq+RmtKdZjyq8Xc+8CEDSh+YUz7AzGfOTrySfiw5uc/UQAPBL3qI89MUsjyccCN1YR
         oGvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lsbUj33t0gvsr22SOjy5oOx+euNA0zyjnMbm0MoFT28=;
        b=qW/jvG1EBnmx6W6J2xIOoPRtjzUPq7Jj1x3/ic4nxS7qrKDAHMnePcOD49tnMeu52O
         Wn6EBCyyStiIvh9zcEUR8tuGr7HVzMcoy2DG9z0zfB2TolwYHNdQWKyOMVBDc7NP2EA2
         dObVFgHN8NWvP5Ze5qXcVHhILFbbmTFIEX36CmwRWkwtyhrUvD4vXaWGoGX5kCe6RP/7
         5wuFYVUCMBGUsSTPyCNcvOGU/7x+RmB10zNPl7fio/Bj6wWYl9st0/XDC+s04wOKjwec
         +t/d17SnjRTaioM6QSbqeP+VQA8lNaKNG6mlHntQ1Vc6FUVQlL1ihGURArbboHDnGMTQ
         jdbA==
X-Gm-Message-State: APjAAAWAci3FgE1SAMg0mOMzLKUKD5qjUpXlCkiObmHEOQD/gk+pg+EQ
        Z1upIhn2yWJoTmBfeFkgedlDNiRvY2kuMntq96HldQ==
X-Google-Smtp-Source: APXvYqxqkq3F6+1EvDLG61w59or1bkG0FDpMZ/OUVPo7BaZGGzGboJAexHvSYCvAxGx4PzKyDNrJh0jxAJjgtoqa7G4=
X-Received: by 2002:a19:e619:: with SMTP id d25mr21178562lfh.66.1555542333025;
 Wed, 17 Apr 2019 16:05:33 -0700 (PDT)
MIME-Version: 1.0
References: <20190313222124.229371-1-rajatja@google.com> <20190411003738.55073-1-rajatja@google.com>
 <20190411003738.55073-2-rajatja@google.com> <CAHp75Vd9xTB90GMra10VxQkR-fVY7NxxY_w6gGEGvD0XOF_xSA@mail.gmail.com>
In-Reply-To: <CAHp75Vd9xTB90GMra10VxQkR-fVY7NxxY_w6gGEGvD0XOF_xSA@mail.gmail.com>
From:   Rajat Jain <rajatja@google.com>
Date:   Wed, 17 Apr 2019 16:04:56 -0700
Message-ID: <CACK8Z6G=vT_tk3W95DJVg12VsH9d0smAKpCq3_oUOzgBr3nMvQ@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] platform/x86: intel_pmc_core: Allow to dump debug
 registers on S0ix failure
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>,
        Vishwanath Somayaji <vishwanath.somayaji@intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rafael J Wysocki <rafael.j.wysocki@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Furquan Shaikh <furquan@google.com>,
        Evan Green <evgreen@google.com>,
        Rajat Jain <rajatxjain@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 11, 2019 at 6:40 AM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Thu, Apr 11, 2019 at 3:38 AM Rajat Jain <rajatja@google.com> wrote:
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
> > +static int pmc_core_suspend(struct device *dev)
> > +{
> > +       struct pmc_dev *pmcdev = dev_get_drvdata(dev);
> > +
> > +       pmcdev->check_counters = false;
> > +
> > +       /* No warnings on S0ix failures */
> > +       if (!warn_on_s0ix_failures)
> > +               return 0;
> > +
> > +       /* Check if the syspend will actually use S0ix */
> > +       if (pm_suspend_via_firmware())
> > +               return 0;
> > +
> > +       /* Save PC10 and S0ix residency for checking later */
>
> > +       if (!rdmsrl_safe(MSR_PKG_C10_RESIDENCY, &pmcdev->pc10_counter) &&
> > +           !pmc_core_dev_state_get(pmcdev, &pmcdev->s0ix_counter))
>
> Split it.

done

>
> > +               pmcdev->check_counters = true;
> > +
> > +       return 0;
> > +}
> > +
> > +static inline bool pmc_core_is_pc10_failed(struct pmc_dev *pmcdev)
> > +{
> > +       u64 pc10_counter;
> > +
> > +       if (!rdmsrl_safe(MSR_PKG_C10_RESIDENCY, &pc10_counter) &&
> > +           pc10_counter == pmcdev->pc10_counter)
> > +               return true;
>
> Split this as well.

done
>
> > +
> > +       return false;
> > +}
> > +
> > +static inline bool pmc_core_is_s0ix_failed(struct pmc_dev *pmcdev)
> > +{
> > +       u64 s0ix_counter;
> > +
> > +       if (!pmc_core_dev_state_get(pmcdev, &s0ix_counter) &&
> > +           s0ix_counter == pmcdev->s0ix_counter)
> > +               return true;
>
> And this.

done
>
> > +
> > +       return false;
> > +}
> > +
> > +static int pmc_core_resume(struct device *dev)
> > +{
> > +       struct pmc_dev *pmcdev = dev_get_drvdata(dev);
> > +
> > +       if (!pmcdev->check_counters)
> > +               return 0;
> > +
> > +       if (pmc_core_is_pc10_failed(pmcdev)) {
> > +               dev_info(dev, "PC10 entry had failed (PC10 cnt=0x%llx)\n",
> > +                        pmcdev->pc10_counter);
> > +       } else if (pmc_core_is_s0ix_failed(pmcdev)) {
>
> > +
>
> Redundant.

I did not quite understand the comment, but I have restructured this
and I think this concerned will be addressed.

>
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
>
> > +                               ++map;
>
> map++;

done
>
> > +                       }
> > +                       ++maps;
>
> maps++;

done
>
> > +               }
>
> This is quite noisy. You need to print only what is important. I don't
> think polluting dmesg with piles of these kind of messages is a good
> idea.
> Also, it is more likely should be done on debug level (except may be
> one or two messages with really important information).

Changed it to dev_dbg in my latest patch. I do not know if a subset of
this information will be helpful to Intel to debug S0ix failures. This
is something I'd like to defer to Rajneesh. I'd be happy to cut it
short if it can still get the info Intel needs to debug S0ix failures.




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
