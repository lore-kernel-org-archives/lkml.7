Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E16EDC282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 11:57:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3E3420880
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 11:57:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cNcSW/1f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727233AbfDIL5l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 07:57:41 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:43265 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726388AbfDIL5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 07:57:40 -0400
Received: by mail-vs1-f66.google.com with SMTP id i207so9591521vsd.10
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2019 04:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zMhNkHranI20/oIEI+ZxPbQNSavGeJvpDcvvgYrFzws=;
        b=cNcSW/1fjBw6Aj/V/PClH1q46e+mYPVhEwt13DRb1LGT8PM3T1wO4dEo5lL28lldJq
         FFX1iVPNYwdcyrQtUF41CJo3VtDGgoRgloNI4cUmk2IpW9rPQZ1JviTWpnZ6ptOhQda2
         jgJRtrs2R8n/9ZKaC23VXsOLqbYLwvIM1BHSRrxXICrn9Mgh5ACg9k438jxYf24+tYV0
         LkrZWJ2Rx9X6fobv6o1fdB1iWNFa73B2soQJVuupEy/iYrvUkZBYhOAnq79gz/pUHn4F
         jc99sMWAA3CdVrw1VNm5ZpN2gMcvohQkyJGwJ/xU7kMV8c/pgUv6lLfJTky0Ai+pWmWF
         TEeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zMhNkHranI20/oIEI+ZxPbQNSavGeJvpDcvvgYrFzws=;
        b=Q3fXsXb+J6mlvKf2d3KM8aMohyWxIt4owYCqh+3yehTFohXfgzGge+kw6bIkM11Cs4
         D+ZjnQ6qCYbxYgw9GJh5vIcjp8T08/VfWbtB9q/JxmpQPCvC6bKcpHdGwsCzHy09iy3X
         Nj2uUWpScPrVcdYxbEsyQl//rU0EWhnFoPigq0qO8gWmTvgAvcLfpTo75rOSi0TUa8I2
         o5PfxfNS1KG3ss8BUes9Hi/c0OKSI72j5ZbYn1UdnQDX0mMC4VhBxtbv9btt9rnpcbhT
         ue9td9YhCw4KE+w/SOcSzslt7aQ+f/AThYJWR3vvsJ08vpsbf5Ichzx+SHjxLBatPcDA
         It/A==
X-Gm-Message-State: APjAAAWunWOj89QAvwpvycbAuIAofYopHj1Z0epxnr4utCvz+727SBUt
        9D64TJuUmYzRcK60a7q274bY74G8ju+uEFkkplh8cQ==
X-Google-Smtp-Source: APXvYqxwbnqiPl3S8OdcVdyPTE6ZLI/zrKFvlP4kPijBZnRAsn1eG+7GheKUncMrM8IyGfCxstlYv+rhv4oPBKo/zGQ=
X-Received: by 2002:a67:fa95:: with SMTP id f21mr19573541vsq.180.1554811059488;
 Tue, 09 Apr 2019 04:57:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190327143548.25305-1-ulf.hansson@linaro.org>
In-Reply-To: <20190327143548.25305-1-ulf.hansson@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 9 Apr 2019 13:57:03 +0200
Message-ID: <CAPDyKFqc9OeaCGrSu7toMcgZesN2xBqqWNQfqUt+4+FvQ4kmDw@mail.gmail.com>
Subject: Re: [PATCH v13 0/4] PM / Domains: Support hierarchical CPU
 arrangement (PSCI/ARM)
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc:     Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux PM <linux-pm@vger.kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Raju P . L . S . S . S . N" <rplsssn@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Kevin Hilman <khilman@kernel.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Mar 2019 at 15:35, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> Changes in v13:
>  - Use WRITE|READ_ONCE when reading/writing the "next_hrtimer" variable in the
> struct cpuidle_device. Also reset the same variable after resumed from idle to
> avoid it from containing a stale value.
>  - Added acks from Daniel Lezcano.
>  - The entire v13 series, including the PSCI/ARM changes are available in a
> git branch [3].

Rafael, I have address the received comments on this version $subject
series, is there anything that is holding you back from queuing it?

If you like I can send a pull-request, to simplify for you.

Moreover, there is another series which I have pinged you about
earlier, which I would appreciate to queue via your tree. It's acked
by PSCI maintainers and is ready to go. "[PATCH v2 0/5] drivers:
firmware: psci: Some cleanup and refactoring".

Kind regards
Uffe

>
> Changes in v12:
>  - Drop the patches for restructuring tick_nohz_get_sleep_length(). Instead
> replace them all with a new timer/cpuidle patch, according to suggestions by
> Rafael.
>  - The entire v12 series, including the PSCI/ARM changes are available in a
> git branch [2].
>
> Changes in v11:
>  - This version contains only the infrastructure changes that is needed for
> deployment. The PSCI/ARM changes have also been updated and tested, but I will
> post them separately. Still, to provide completeness, I have published a branch
> containing everything to a git tree [1], feel free to have a look and test.
>  - The v10 series contained a patch, "timer: Export next wakeup time of a CPU",
> which has been replaced by a couple of new patches, whom reworks the existing
> tick_nohz_get_sleep_length() function, to provide the next timer expiration
> instead of the duration.
>  - More changelogs are available per patch.
>
> Changes in v10:
>  - Quite significant changes have been to the PSCI driver deployment. According
>    to an agreement with Lorenzo, the hierarchical CPU layout for PSCI should be
>    orthogonal to whether the PSCI FW supports OSI or not. This has been taken
>    care of in this version.
>  - Drop the generic attach/detach helpers of CPUs to genpd, instead make that
>    related code internal to PSCI, for now.
>  - Fix "BUG: sleeping for invalid context" for hotplug, as reported by Raju.
>  - Addressed various comments from version 8 and 9.
>  - Clarified changelogs and re-wrote the cover-letter to better explain the
>    motivations behind these changes.
>
> Background:
>
> For ARM64/ARM based platforms CPUs are often arranged in a hierarchical manner.
> From a CPU idle state perspective, this means some states may be shared among a
> group of CPUs (aka CPU cluster).
>
> To deal with idle management of a group of CPUs, sometimes the kernel needs to
> be involved to manage the last-man standing algorithm, simply because it can't
> rely solely on power management FWs to deal with this. Depending on the
> platform, of course.
>
> There are a couple of typical scenarios for when the kernel needs to be in
> control, dealing with synchronization of when the last CPU in a cluster is about
> to enter a deep idle state.
>
> 1)
> The kernel needs to carry out so called last-man activities before the
> CPU cluster can enter a deep idle state. This may for example involve to
> configure external logics for wakeups, as the GIC may no longer be functional
> once a deep cluster idle state have been entered. Likewise, these operations
> may need to be restored, when the first CPU wakes up.
>
> 2)
> Other more generic I/O devices, such as an MMC controller for example, may be a
> part of the same power domain as the CPU cluster, due to a shared power-rail.
> For these scenarios, when the MMC controller is in use dealing with an MMC
> request, a deeper idle state of the CPU cluster may needs to be temporarily
> disabled. This is needed to retain the MMC controller in a functional state,
> else it may loose its register-context in the middle of serving a request.
>
> In this series, we are extending the generic PM domain (aka genpd) to be used
> for also CPU devices. Hence the goal is to re-use much of its current code to
> help us manage the last-man standing synchronization. Moreover, as we already
> use genpd to model power domains for generic I/O devices, both 1) and 2) can be
> address with its help.
>
> Moreover, to address these problems for ARM64 DT based platforms, we are
> deploying support for genpd and runtime PM to the PSCI FW driver - and finally
> we make some updates to two ARM64 DTBs, as to deploy the new PSCI CPU topology
> layout.
>
> The series has been tested on a Qcom 410c dragonboard and on a Hisilicon Hikey
> board. The first one uses PSCI OS-initiated mode, while the second uses the PSCI
> Platform-Coordinated mode.
>
> Kind regards
> Ulf Hansson
>
> [1]
> git.linaro.org/people/ulf.hansson/linux-pm.git next_v11
> [2]
> git.linaro.org/people/ulf.hansson/linux-pm.git next_v12
> [2]
> git.linaro.org/people/ulf.hansson/linux-pm.git next_v13
>
>
> Ulf Hansson (4):
>   PM / Domains: Add a generic data pointer to the genpd_power_state
>     struct
>   PM / Domains: Add support for CPU devices to genpd
>   cpuidle: Export the next timer/tick expiration for a CPU
>   PM / Domains: Add genpd governor for CPUs
>
>  drivers/base/power/domain.c          | 77 ++++++++++++++++++++++++++--
>  drivers/base/power/domain_governor.c | 65 ++++++++++++++++++++++-
>  drivers/cpuidle/cpuidle.c            | 19 ++++++-
>  include/linux/cpuidle.h              |  1 +
>  include/linux/pm_domain.h            | 20 +++++++-
>  include/linux/tick.h                 |  7 ++-
>  kernel/time/tick-sched.c             | 12 +++++
>  7 files changed, 193 insertions(+), 8 deletions(-)
>
> --
> 2.17.1
>
