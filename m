Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18F0EC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 14:35:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3EB52146F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 14:35:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lekRZFQ3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728385AbfC0Of5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 10:35:57 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:34411 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727729AbfC0Of4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 10:35:56 -0400
Received: by mail-lf1-f66.google.com with SMTP id y18so11629933lfe.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2019 07:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=tTP4WXtvUVNuaj15IAHE9v9jeKlaPu5z60ek326J1pE=;
        b=lekRZFQ3GVWA9DKIshAekuOafvfVdDPwrpH8Vfx73XGldYcbORLXPuHlmxD+kqljA9
         zzZxwSIqzKs4wTKSWyXjtkGkamZ0n+YdX0QIcXPG7uJindtbdqEvSjAnVwHKCaFQ+X7a
         NW/rS4HUF4fm3dkrNpi3vP3dApXHGx3l168uHHEb+bt9if5pX7WmLp0dP2kUhnHOiCZT
         ZMN9QXzzahf1cZy/RkywPi1A6JYx7Ouvao6xhkjnDa5nTyu5+am5yenkrrxqMOc0JUMP
         05LJ2aSPgAsfTqtDV7EEVehwFNE8EiQ/nRDdcCl0ipxe64NTWb/SzK9LjxRFu7Aj6n2y
         AIQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=tTP4WXtvUVNuaj15IAHE9v9jeKlaPu5z60ek326J1pE=;
        b=doMKaXFdMTROXyWc6CycnWgFRob5EAWRUpSVavfXazgXBaXZAX6A0IzQpiL4mM+YKI
         rLB5h7MVH5sRgnRjNbaq3F+duEwV2SlNo1E0rlHQyK8fTeb5kaxf5Vug7AXtuEVs0ELM
         LaJHc8RMfI+NHO6zBG+igVgExxKPWvpl8//2bRej2uPDkxhzGRzAvzMWn3U6/2TNnPAC
         DKz/qmqqF8OR9F3KgIp1M+lOy1VOTQO7epM8iPGRgO/CT3WqINCVX/U8duwSSf1o+dJf
         yN3bpLUJegduaY0ueKRGkwfxLYRZpAlUTclVAwBETG3rqYpOJdbXg32gmF/JK4fXZtrl
         54sA==
X-Gm-Message-State: APjAAAXv1raMWHcRju7D/lhtQq155AUuyVeNXuVfvGRg5gXSkjrifQXK
        tEb6P23hG8R6uNbCwz1oU/i3Lw==
X-Google-Smtp-Source: APXvYqwjzHeBHi/UZ85e+8kLqzktdRv5C3LeC3sTk/wqNmq1s2CI3cJbf2pBIjwOHo8gO18kRCLtkQ==
X-Received: by 2002:ac2:5638:: with SMTP id b24mr5036135lff.18.1553697354848;
        Wed, 27 Mar 2019 07:35:54 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id q2sm4548789lfj.58.2019.03.27.07.35.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Mar 2019 07:35:54 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
Cc:     Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Raju P . L . S . S . S . N" <rplsssn@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Kevin Hilman <khilman@kernel.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v13 0/4] PM / Domains: Support hierarchical CPU arrangement (PSCI/ARM)
Date:   Wed, 27 Mar 2019 15:35:44 +0100
Message-Id: <20190327143548.25305-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes in v13:
 - Use WRITE|READ_ONCE when reading/writing the "next_hrtimer" variable in the
struct cpuidle_device. Also reset the same variable after resumed from idle to
avoid it from containing a stale value.
 - Added acks from Daniel Lezcano.
 - The entire v13 series, including the PSCI/ARM changes are available in a
git branch [3].

Changes in v12:
 - Drop the patches for restructuring tick_nohz_get_sleep_length(). Instead
replace them all with a new timer/cpuidle patch, according to suggestions by
Rafael.
 - The entire v12 series, including the PSCI/ARM changes are available in a
git branch [2].

Changes in v11:
 - This version contains only the infrastructure changes that is needed for
deployment. The PSCI/ARM changes have also been updated and tested, but I will
post them separately. Still, to provide completeness, I have published a branch
containing everything to a git tree [1], feel free to have a look and test.
 - The v10 series contained a patch, "timer: Export next wakeup time of a CPU",
which has been replaced by a couple of new patches, whom reworks the existing
tick_nohz_get_sleep_length() function, to provide the next timer expiration
instead of the duration.
 - More changelogs are available per patch.

Changes in v10:
 - Quite significant changes have been to the PSCI driver deployment. According
   to an agreement with Lorenzo, the hierarchical CPU layout for PSCI should be
   orthogonal to whether the PSCI FW supports OSI or not. This has been taken
   care of in this version.
 - Drop the generic attach/detach helpers of CPUs to genpd, instead make that
   related code internal to PSCI, for now.
 - Fix "BUG: sleeping for invalid context" for hotplug, as reported by Raju.
 - Addressed various comments from version 8 and 9.
 - Clarified changelogs and re-wrote the cover-letter to better explain the
   motivations behind these changes.

Background:

For ARM64/ARM based platforms CPUs are often arranged in a hierarchical manner.
From a CPU idle state perspective, this means some states may be shared among a
group of CPUs (aka CPU cluster).

To deal with idle management of a group of CPUs, sometimes the kernel needs to
be involved to manage the last-man standing algorithm, simply because it can't
rely solely on power management FWs to deal with this. Depending on the
platform, of course.

There are a couple of typical scenarios for when the kernel needs to be in
control, dealing with synchronization of when the last CPU in a cluster is about
to enter a deep idle state.

1)
The kernel needs to carry out so called last-man activities before the
CPU cluster can enter a deep idle state. This may for example involve to
configure external logics for wakeups, as the GIC may no longer be functional
once a deep cluster idle state have been entered. Likewise, these operations
may need to be restored, when the first CPU wakes up.

2)
Other more generic I/O devices, such as an MMC controller for example, may be a
part of the same power domain as the CPU cluster, due to a shared power-rail.
For these scenarios, when the MMC controller is in use dealing with an MMC
request, a deeper idle state of the CPU cluster may needs to be temporarily
disabled. This is needed to retain the MMC controller in a functional state,
else it may loose its register-context in the middle of serving a request.

In this series, we are extending the generic PM domain (aka genpd) to be used
for also CPU devices. Hence the goal is to re-use much of its current code to
help us manage the last-man standing synchronization. Moreover, as we already
use genpd to model power domains for generic I/O devices, both 1) and 2) can be
address with its help.

Moreover, to address these problems for ARM64 DT based platforms, we are
deploying support for genpd and runtime PM to the PSCI FW driver - and finally
we make some updates to two ARM64 DTBs, as to deploy the new PSCI CPU topology
layout.

The series has been tested on a Qcom 410c dragonboard and on a Hisilicon Hikey
board. The first one uses PSCI OS-initiated mode, while the second uses the PSCI
Platform-Coordinated mode.

Kind regards
Ulf Hansson

[1]
git.linaro.org/people/ulf.hansson/linux-pm.git next_v11
[2]
git.linaro.org/people/ulf.hansson/linux-pm.git next_v12
[2]
git.linaro.org/people/ulf.hansson/linux-pm.git next_v13


Ulf Hansson (4):
  PM / Domains: Add a generic data pointer to the genpd_power_state
    struct
  PM / Domains: Add support for CPU devices to genpd
  cpuidle: Export the next timer/tick expiration for a CPU
  PM / Domains: Add genpd governor for CPUs

 drivers/base/power/domain.c          | 77 ++++++++++++++++++++++++++--
 drivers/base/power/domain_governor.c | 65 ++++++++++++++++++++++-
 drivers/cpuidle/cpuidle.c            | 19 ++++++-
 include/linux/cpuidle.h              |  1 +
 include/linux/pm_domain.h            | 20 +++++++-
 include/linux/tick.h                 |  7 ++-
 kernel/time/tick-sched.c             | 12 +++++
 7 files changed, 193 insertions(+), 8 deletions(-)

-- 
2.17.1

