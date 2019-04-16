Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67963C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 09:34:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35E6E20651
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 09:34:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555407264;
	bh=BwsK6tHQlEHxToZB/b5bYAwxSeOf9ZOOaQcBBnlfSFQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=IkJSgZKvb5MAFJCyMZIzbLgrKlc3wkemafOwkE6s1JNHvL9spjy96c854N7hMIkcz
	 DWw1L5lYeO3d6nqXZ7bOIpcaVN0d+UZw9U7UAZbWlBhCWcDSV3O4z4ArW/VHsKsegg
	 hTFIMA6bbjoL5xOJnKHDIp7MD7pl68oivC5DDTcI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728944AbfDPJeX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 05:34:23 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:44802 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728230AbfDPJeT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 05:34:19 -0400
Received: by mail-ot1-f67.google.com with SMTP id d24so16996021otl.11;
        Tue, 16 Apr 2019 02:34:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8qw/OL5mJ45U4+FG/qyIj2foiwTJOtRvVs5qYVtrnvk=;
        b=UzeJuUdt6dSythzI4sp+wCC75nm87K3e3BnIF7NsLXdki3iQb6OLjoLcjnRkrOX/Dp
         ma23MtVXaiD+U0OBckFfZKEaK2tAUAVrbW9x7pKQZFYpWnQWfIHYcSrHiUEjU573EVTI
         rsS3XF0CEp8cyqmlSnBFhl5Y09DSN+NXTSWkx2YVVPj5UZsP42/F/grra6f9xSezXEnu
         nYeN1ldORhr3ge0WItcztVOKunuXI9wUbx8A90GLl++corTeP8mezq7UUF4ps5YW24a3
         tE1AcVEIvrirrhf6yPoyKH79BjoMzJJxxuCXNaF6S+6hePWhT6ACuGQglbhH3Jsax354
         1TMA==
X-Gm-Message-State: APjAAAXfqH7FR4eyili56TDkB27R0ZcoCqC9v+Uzr+XK/cMJGMCjPAMV
        dthpQ6OYy0tXRHUFifdO9x25SDZYTifTNRFkcGo=
X-Google-Smtp-Source: APXvYqwYtYTUAnB1lJPdFjUKvGtpqOw1r5d2T/iAKpJXuWq+TFdNM1EompniSRRjuPPGPV9ab7LvT8OW6mNyoV6gziA=
X-Received: by 2002:a9d:4b11:: with SMTP id q17mr14587035otf.272.1555407258468;
 Tue, 16 Apr 2019 02:34:18 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1554410643.git.Janakarajan.Natarajan@amd.com> <d44f4893-0b67-4993-2942-6e03d29dffa1@amd.com>
In-Reply-To: <d44f4893-0b67-4993-2942-6e03d29dffa1@amd.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 16 Apr 2019 11:34:07 +0200
Message-ID: <CAJZ5v0jh0Yn1fy5bO3wett5AsjBA55_Z-8L_M8eRyy5cePqwaw@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] CPPC optional registers AMD support
To:     Janakarajan Natarajan <jnataraj@amd.com>
Cc:     "Natarajan, Janakarajan" <Janakarajan.Natarajan@amd.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "devel@acpica.org" <devel@acpica.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Robert Moore <robert.moore@intel.com>,
        Erik Schmauss <erik.schmauss@intel.com>,
        "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2019 at 12:35 AM Janakarajan Natarajan <jnataraj@amd.com> wrote:
>
> On 4/4/19 4:25 PM, Natarajan, Janakarajan wrote:
> > CPPC (Collaborative Processor Performance Control) offers optional
> > registers which can be used to tune the system based on energy and/or
> > performance requirements.
> >
> > Newer AMD processors add support for a subset of these optional CPPC
> > registers, based on ACPI v6.1.
> >
> > The following are the supported CPPC registers for which sysfs entries
> > are created:
> > * enable                (NEW)
> > * max_perf              (NEW)
> > * min_perf              (NEW)
> > * energy_perf
> > * lowest_perf
> > * nominal_perf
> > * desired_perf          (NEW)
> > * feedback_ctrs
> > * auto_sel_enable       (NEW)
> > * lowest_nonlinear_perf
> >
> > The CPPC driver is updated to enable the OSPM and the userspace to
> > access
> > the newly supported registers.
> >
> > The purpose of exposing the registers via the sysfs entries is to allow
> > the userspace to:
> > * Tweak the values to fit its workload.
> > * Apply a profile from AMD's optimization guides.
> >
> > Profiles will be documented in the performance/optimization guides.
> >
> > Note:
> > * AMD systems will not have a policy applied in the kernel at this time.
> > * By default, acpi_cpufreq will still be used.
> >
> > TODO:
> > * Create a linux userspace tool that will help users generate a CPPC
> > * profile
> >    for their target workload.
> > * Create or update a driver to apply a general CPPC policy in the
> > * kernel.
> >
> > v1->v2:
> > * Add macro to ensure BUFFER only registers have BUFFER type.
> > * Add support macro to make the right check based on register type.
> > * Remove support checks for registers which are mandatory.
>
>
> Are there any concerns regarding this patchset?

Yes, there are.

Unfortunately, it is generally problematic.

First off, the behavior of existing sysfs files cannot be changed at
will, as there may be users of them out there already depending on the
current behavior.

Second, at least some CPPC control registers are used by cpufreq
drivers (cppc_cpufreq and intel_pstate), so modifying them behind the
drivers' backs is not a good idea in general.  For this reason, adding
new sysfs attributes to allow user space to do that is quite
questionable.

Thanks,
Rafael
