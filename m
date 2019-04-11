Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7752DC10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 13:40:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D28C217F4
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 13:40:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ppC6bO0u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbfDKNkt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 09:40:49 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39644 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726264AbfDKNks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 09:40:48 -0400
Received: by mail-pg1-f196.google.com with SMTP id k3so3540153pga.6;
        Thu, 11 Apr 2019 06:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Qr5ItuNMMRfnKTC8qofK6VXacrruJnPxHB8CJe/qgMY=;
        b=ppC6bO0uOErcH1ubEDV5XICbR77zwx26wxp+hZKDRbWnpVCHWod0jJcy+zxa948fLJ
         /1TwuSGOQwb5N1ULbWbfkytSj/pdL+aODldgqkc3XH1elpn1HpJfmS1atEbkWIUc99y6
         pGaWS5w9pzfYJaJTN1a2MFblD78PXHl8NfwDwZ2dhwVuENnEg4Bt73jSldfOHpM35E2P
         X597lR2loq9W4pjEtIjWL2TAiw8CPZPFbbVchSmwHDcSIhju+yo0FQmXjvrsnQsSFrAm
         dPSgzgkgEX1Wp4Z2hc8cQAh5swBA1ODcNDW4BnWOE6g1oYjj9btWJ1C/I9eVchdySed4
         VEzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Qr5ItuNMMRfnKTC8qofK6VXacrruJnPxHB8CJe/qgMY=;
        b=FuLZ/QDThkvrjK7kwb2iP+RupSEuKTlNgFp9Br7Ki23tUPqzVMKPXAdmoe5AzoCYMC
         wJgiyexRwXikjayvcI1qlzTdMfd6N8m+7h+mpWjMHVVunoLJCQhEBe6ibfHibVrgNwTw
         i/d9PCK7Gwj9/zk/NolQ32D8+S82VsRPbLpcnIhCW2ch7pw7hyPezHV7XvZfflBxhrVV
         UVeWN1IxYn4qh98XCVQWc1Sg+ORsb9AGio1jW24pED0dWQJKjQyULlNAXVm8EuVQn31U
         OKGFUPb4iFrJpXsAryzv4qH1gNs3C3+c5zE0uqYrEXEoLEIaVec8IBOmsXYa0rHNoikv
         6UsQ==
X-Gm-Message-State: APjAAAUehaRj6nybfREtsqXnXOqEz0mM39RMs5ri2N2jalKbwVBP/E/n
        x0cHSxknkkFjLSoB+VA2phfYvR27VDBjB4eNHyE=
X-Google-Smtp-Source: APXvYqy1mtnIaSYx4K6HKy0he3Spy/TDMj8R9NQQ8raQu+af3GQZ5zsR361nOe0NtXfIb+hKpgo/eu2fIsQdvFNfcZA=
X-Received: by 2002:a65:6210:: with SMTP id d16mr45710904pgv.110.1554990048186;
 Thu, 11 Apr 2019 06:40:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190313222124.229371-1-rajatja@google.com> <20190411003738.55073-1-rajatja@google.com>
 <20190411003738.55073-2-rajatja@google.com>
In-Reply-To: <20190411003738.55073-2-rajatja@google.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 11 Apr 2019 16:40:37 +0300
Message-ID: <CAHp75Vd9xTB90GMra10VxQkR-fVY7NxxY_w6gGEGvD0XOF_xSA@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] platform/x86: intel_pmc_core: Allow to dump debug
 registers on S0ix failure
To:     Rajat Jain <rajatja@google.com>
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

On Thu, Apr 11, 2019 at 3:38 AM Rajat Jain <rajatja@google.com> wrote:
>
> Add a module parameter which when enabled, will check on resume, if the
> last S0ix attempt was successful. If not, the driver would warn and provide
> helpful debug information (which gets latched during the failed suspend
> attempt) to debug the S0ix failure.
>
> This information is very useful to debug S0ix failures. Specially since
> the latched debug information will be lost (over-written) if the system
> attempts to go into runtime (or imminent) S0ix again after that failed
> suspend attempt.

> +static int pmc_core_suspend(struct device *dev)
> +{
> +       struct pmc_dev *pmcdev = dev_get_drvdata(dev);
> +
> +       pmcdev->check_counters = false;
> +
> +       /* No warnings on S0ix failures */
> +       if (!warn_on_s0ix_failures)
> +               return 0;
> +
> +       /* Check if the syspend will actually use S0ix */
> +       if (pm_suspend_via_firmware())
> +               return 0;
> +
> +       /* Save PC10 and S0ix residency for checking later */

> +       if (!rdmsrl_safe(MSR_PKG_C10_RESIDENCY, &pmcdev->pc10_counter) &&
> +           !pmc_core_dev_state_get(pmcdev, &pmcdev->s0ix_counter))

Split it.

> +               pmcdev->check_counters = true;
> +
> +       return 0;
> +}
> +
> +static inline bool pmc_core_is_pc10_failed(struct pmc_dev *pmcdev)
> +{
> +       u64 pc10_counter;
> +
> +       if (!rdmsrl_safe(MSR_PKG_C10_RESIDENCY, &pc10_counter) &&
> +           pc10_counter == pmcdev->pc10_counter)
> +               return true;

Split this as well.

> +
> +       return false;
> +}
> +
> +static inline bool pmc_core_is_s0ix_failed(struct pmc_dev *pmcdev)
> +{
> +       u64 s0ix_counter;
> +
> +       if (!pmc_core_dev_state_get(pmcdev, &s0ix_counter) &&
> +           s0ix_counter == pmcdev->s0ix_counter)
> +               return true;

And this.

> +
> +       return false;
> +}
> +
> +static int pmc_core_resume(struct device *dev)
> +{
> +       struct pmc_dev *pmcdev = dev_get_drvdata(dev);
> +
> +       if (!pmcdev->check_counters)
> +               return 0;
> +
> +       if (pmc_core_is_pc10_failed(pmcdev)) {
> +               dev_info(dev, "PC10 entry had failed (PC10 cnt=0x%llx)\n",
> +                        pmcdev->pc10_counter);
> +       } else if (pmc_core_is_s0ix_failed(pmcdev)) {

> +

Redundant.

> +               const struct pmc_bit_map **maps = pmcdev->map->slps0_dbg_maps;
> +               const struct pmc_bit_map *map;
> +               int offset = pmcdev->map->slps0_dbg_offset;
> +               u32 data;
> +
> +               dev_warn(dev, "S0ix entry had failed (S0ix cnt=%llu)\n",
> +                        pmcdev->s0ix_counter);
> +               while (*maps) {
> +                       map = *maps;
> +                       data = pmc_core_reg_read(pmcdev, offset);
> +                       offset += 4;
> +                       while (map->name) {
> +                               dev_warn(dev, "SLP_S0_DBG: %-32s\tState: %s\n",
> +                                        map->name,
> +                                        data & map->bit_mask ? "Yes" : "No");

> +                               ++map;

map++;

> +                       }
> +                       ++maps;

maps++;

> +               }

This is quite noisy. You need to print only what is important. I don't
think polluting dmesg with piles of these kind of messages is a good
idea.
Also, it is more likely should be done on debug level (except may be
one or two messages with really important information).

> +       }
> +       return 0;
> +}
> +
> +#endif

-- 
With Best Regards,
Andy Shevchenko
