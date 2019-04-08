Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FD21C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 17:02:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39F3B21473
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 17:02:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z+97eb5N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729140AbfDHRCh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 13:02:37 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35055 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728933AbfDHRCh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 13:02:37 -0400
Received: by mail-pg1-f196.google.com with SMTP id g8so7675320pgf.2;
        Mon, 08 Apr 2019 10:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cNVymU67Q9OWVolqOTZRo9qx2gflcB8P7kTX1YrlXIc=;
        b=Z+97eb5N9+y6fJNSsO1y/+cGaGWOtwwcbVnyp1urn0wkVRAODHpbhyYVqr8l/J8IZg
         nsoRIWZ0X5IT8pUV7da4prdjn7YERZnPekRgNQiBOGyvcdTHXCVjtWLoz95pXrbCcXOH
         aHP2bzFW+B/k+xoeyXyQz7ofmFnhcvjxoKS2zEVVfsgHEf+LM1S8BlsOyrywayetPSrw
         hpO32RJdtOBnNnz2p6exnv0s4OemnefCytTW66PlWegGaSLbB83pkIa2WKawC5MpP9lX
         SZpQyud0/qyHkCA1ao3BQa8HtR6XN0Xmoh1UMloFCrOQuqw9xQBOLbzb3mw4SHPbGHiT
         M2+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cNVymU67Q9OWVolqOTZRo9qx2gflcB8P7kTX1YrlXIc=;
        b=DJ08fM4gC6Py5kBoJSmQ2gMEp2PbpdLHgeDp0rSPK6YePNNbOZK5fGb4J8lTwm/51+
         Gf2CGMZ+C9VX8LIW1xHBSZFFQJRGgn4sP5Zut2jPzdrRu11eRVCBN7I7d2/RnKOMQNZd
         C4VJJqu/cgRpaKYZcaeEaOELM/ucYMih0823tCBFPj9w4oPyTKqdC4KzzdvJsJBwkJmm
         pryILkG58YheBCY8Ov95d37CM3ZRN97G/6mtvRw73Qvq869GDAv4rhlCYMnPCCqSVRS9
         bnrGAVNImvb/G6GqsVIwtqBFaSSPwrZWBONw2Y26f4kJPkNSaqUA+0aK6Sl7jzGcsS1a
         N/Dg==
X-Gm-Message-State: APjAAAXJgUydD7pypYZX77uncSGTBCuuVrrzvV99lsPyD5UDoFYoLb6Q
        pAjNw5volrRtlDY1buGJgGWteqNNgXIlSgMMMqt8G49qZ/8=
X-Google-Smtp-Source: APXvYqxHOQYkTnnVLtqGykzU2rfeFYV7KZo5yrANFqUw6gHCjx/1e7LbhE5UXEMnmsUH3j7qqwo1sYFh7TsRI9bh0lI=
X-Received: by 2002:a65:4302:: with SMTP id j2mr28110422pgq.291.1554742956028;
 Mon, 08 Apr 2019 10:02:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190313222124.229371-1-rajatja@google.com> <20190405203558.19160-1-rajatja@google.com>
 <20190405203558.19160-2-rajatja@google.com>
In-Reply-To: <20190405203558.19160-2-rajatja@google.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 8 Apr 2019 20:02:25 +0300
Message-ID: <CAHp75VehpYPm1ApFozisSsNi1g0EtbKBm3C97jxXC2u04tpt0A@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] platform/x86: intel_pmc_core: Allow to dump debug
 registers on S0ix failure
To:     Rajat Jain <rajatja@google.com>
Cc:     Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>,
        Vishwanath Somayaji <vishwanath.somayaji@intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Wysocki@google.com, Rafael J <rafael.j.wysocki@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        furquan@google.com, evgreen@google.com,
        Rajat Jain <rajatxjain@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 5, 2019 at 11:36 PM Rajat Jain <rajatja@google.com> wrote:
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

> +#ifdef CONFIG_PM_SLEEP
> +
> +static bool warn_on_s0ix_failures;
> +module_param(warn_on_s0ix_failures, bool, 0644);
> +MODULE_PARM_DESC(warn_on_s0ix_failures, "Check and warn for S0ix failures");
> +
> +static int pmc_core_suspend(struct device *dev)
> +{
> +       struct pmc_dev *pmcdev = dev_get_drvdata(dev);
> +
> +       /* Save PC10 and S0ix residency for checking later */

> +       if (warn_on_s0ix_failures && !pm_suspend_via_firmware() &&
> +           !rdmsrl_safe(MSR_PKG_C10_RESIDENCY, &pmcdev->pc10_counter) &&
> +           !pmc_core_dev_state_get(pmcdev, &pmcdev->s0ix_counter))
> +               pmcdev->check_counters = true;

Perhaps something like

pmcdev->check_counters = false;
/* User doesn't want to be warned */
if (!warn_on...)
 return 0;
/* We do suspend via firmware */
if (...)
 return 0;
...

?

> +       else
> +               pmcdev->check_counters = false;
> +
> +       return 0;
> +}
> +
> +static inline bool pc10_failed(struct pmc_dev *pmcdev)

To be or not to be? :-)
Perhaps names of the functions should be

pmc_code_is_pc10_failed()

and so on

> +{
> +       u64 pc10_counter;
> +
> +       if (!rdmsrl_safe(MSR_PKG_C10_RESIDENCY, &pc10_counter) &&
> +           pc10_counter == pmcdev->pc10_counter)
> +               return true;

> +       else

Redundant.

> +               return false;
> +}
> +
> +static inline bool s0ix_failed(struct pmc_dev *pmcdev)
> +{
> +       u64 s0ix_counter;
> +
> +       if (!pmc_core_dev_state_get(pmcdev, &s0ix_counter) &&
> +           s0ix_counter == pmcdev->s0ix_counter)
> +               return true;

> +       else

Ditto.

> +               return false;
> +}
> +
> +static int pmc_core_resume(struct device *dev)
> +{
> +       struct pmc_dev *pmcdev = dev_get_drvdata(dev);
> +
> +       if (!pmcdev->check_counters)
> +               return 0;
> +
> +       if (pc10_failed(pmcdev)) {
> +               dev_info(dev, "PC10 entry had failed (PC10 cnt=0x%llx)\n",
> +                        pmcdev->pc10_counter);
> +       } else if (s0ix_failed(pmcdev)) {
> +
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
> +                       }
> +                       ++maps;
> +               }

Can't we utilize existing print helpers?

> +       }
> +       return 0;
> +}
> +
> +#endif

-- 
With Best Regards,
Andy Shevchenko
