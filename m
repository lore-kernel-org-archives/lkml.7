Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1627C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 09:35:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C6D82087E
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 09:35:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551432900;
	bh=DcgWiPzBMqmRxP3NMyW6y4zIvcd4lDSy5SwJgFqhfHA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=InXyWYK1OQnK3L3EPYLUmWo8k7ODYntyerqJhLI5nsnzZ5zDpqotRE1XTIoy296g7
	 ZqRgoL44ppA/Lns+HdLHWZEcDCd4SYBP1KuuoLnLZvQGm2xYYfLQ2IOHNiOIJgFWyv
	 WU6g1tD1fpTv18V3DRdEBblw5PhQ+SxbUQ/Y6l+c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732989AbfCAJe7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 04:34:59 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:33457 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727697AbfCAJe6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 04:34:58 -0500
Received: by mail-oi1-f194.google.com with SMTP id z14so19019831oid.0;
        Fri, 01 Mar 2019 01:34:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CVkzXAURgF0vppqfid2IWSkU56STvkIxlzLOS99PQIM=;
        b=hsZCSRbF4iJ157fd/bbpf8YokZn4bHgEyT5358YcQT2vnG5c2oPgIakampPSu0Jm2v
         +QGDyhDgqSiuQWnMAm/5jFLq8rjRPfwDE1Dx8o15O13Ov5XOS+2LeX+I6QJgEXVqTsYX
         iReaOlNmrLl2GF09std/dwVr+AuERONKoaUxUYQ/7coCFg1/O4SZBupsAQQFv4YLEMRT
         ydXVYFyqPN11x7Bf8M/BBWJ8+d6jj38MdtjNo53oHriiM4U7owE0vTX98Ik/K7dz/V7m
         bK1dtx+qC7wfmjo3qcnsa5h+dztm2vMFkbZSHA3XDbXIpiFYDThzpEcr+tWhQFtnCgfg
         0bYg==
X-Gm-Message-State: AHQUAuZizch4t+wY1hiKiwt9W8tL8tZmVCuq468/DpPVjkJevCgWijGb
        XPrnQw1s1PY+IbbZ+hABRQ0C0AtCxL/ZNcfBPjOd7kDa
X-Google-Smtp-Source: APXvYqwutM7ahGDEu5tBym2f63REUKomTT/U2Ts6tv7ikT/Vu8BCsYq1QRAk8lYZShpaHDLiYvv9iGlN5BVFLUQScQI=
X-Received: by 2002:aca:88b:: with SMTP id 133mr2733715oii.95.1551432897782;
 Fri, 01 Mar 2019 01:34:57 -0800 (PST)
MIME-Version: 1.0
References: <cover.1551375162.git.yu.c.chen@intel.com> <ee0250bfc7709ce0a0cc93bf83336133d5e248c4.1551375162.git.yu.c.chen@intel.com>
 <CAJZ5v0iw=THw4Cr7asFoNdUaAu7tG0nz0S4NWzqxGEDvyS11ng@mail.gmail.com>
In-Reply-To: <CAJZ5v0iw=THw4Cr7asFoNdUaAu7tG0nz0S4NWzqxGEDvyS11ng@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 1 Mar 2019 10:34:46 +0100
Message-ID: <CAJZ5v0gW_KW9J2q=s3PqjY8C4otP51NuEPkTQKvYvr=ce6556g@mail.gmail.com>
Subject: Re: [PATCH 1/2][RFC v2] ACPI: add "processor.broadcast_ppc" hook to
 broadcast _PPC
To:     Chen Yu <yu.c.chen@intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Len Brown <len.brown@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yu Chen <yu.chen.surf@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 28, 2019 at 11:18 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Thu, Feb 28, 2019 at 6:59 PM Chen Yu <yu.c.chen@intel.com> wrote:
> >
> > On some problematic platforms, the _PPC notifier is
> > only delivered to one CPU, which might cause information
> > inconsistent between CPUs within the package. Thus introduce a boot up parameter to broadcast this _PPC notifier onto all
> > online CPUs.
> >
> > Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> > ---
> >  drivers/acpi/processor_perflib.c | 16 ++++++++++++++--
> >  1 file changed, 14 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/acpi/processor_perflib.c b/drivers/acpi/processor_perflib.c
> > index a303fd0e108c..737dbf5aa7f7 100644
> > --- a/drivers/acpi/processor_perflib.c
> > +++ b/drivers/acpi/processor_perflib.c
> > @@ -63,6 +63,10 @@ module_param(ignore_ppc, int, 0644);
> >  MODULE_PARM_DESC(ignore_ppc, "If the frequency of your machine gets wrongly" \
> >                  "limited by BIOS, this should help");
> >
> > +static int broadcast_ppc;
> > +module_param(broadcast_ppc, int, 0644);
> > +MODULE_PARM_DESC(broadcast_ppc, "Broadcast the ppc to all online CPUs");
> > +
> >  #define PPC_REGISTERED   1
> >  #define PPC_IN_USE       2
> >
> > @@ -180,8 +184,16 @@ void acpi_processor_ppc_has_changed(struct acpi_processor *pr, int event_flag)
> >                 else
> >                         acpi_processor_ppc_ost(pr->handle, 0);
> >         }
> > -       if (ret >= 0)
> > -               cpufreq_update_policy(pr->id);
> > +       if (ret >= 0) {
> > +               if (broadcast_ppc) {
> > +                       int cpu;
> > +
> > +                       for_each_possible_cpu(cpu)
> > +                               cpufreq_update_policy(cpu);
>
> This doesn't actually help AFAICS, because it only causes
> acpi_processor_ppc_notifier() to be called for all policies, but
> pr->performance_platform_limit is re-computed for the target CPU only
> anyway, so the limit will only be applied to that one.
>
> What happens in the BZ is that invoking cpufreq_update_policy() for
> all CPUs causes ->verify() to run on all of them which triggers
> update_turbo_state() and cpuinfo.max_freq update, because
> global.turbo_disabled has changed.
>
> That is rather less than straightforward and intel_pstate really
> doesn't need any _PPC change notifications to notice that the
> MSR_IA32_MISC_ENABLE_TURBO_DISABLE bit has changed as it checks that
> bit on every P-state update.

Which admittedly may not be necessary if notifications are delivered.

I still don't think that updating all policies from
acpi_processor_ppc_has_changed() is a good idea, but yes, there is a
problem that if MSR_IA32_MISC_ENABLE_TURBO_DISABLE goes from set to
unset, all policies need to be updated to update policy->max
accordingly, so looking at MSR_IA32_MISC_ENABLE_TURBO_DISABLE from
within the driver without triggering a policy update is not
sufficient.
