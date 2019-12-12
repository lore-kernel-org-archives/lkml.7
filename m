Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DC93C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 04:11:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 549E52464B
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 04:11:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wfeTxdx0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727879AbfLLELw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 23:11:52 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:33434 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727793AbfLLELv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 23:11:51 -0500
Received: by mail-qt1-f195.google.com with SMTP id d5so1151039qto.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2019 20:11:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=NoYBywhpuKimSGwin3C7a9q598Qx6aFDiJR0OAgeQsE=;
        b=wfeTxdx079Fe51mZcPs1dZwhq8xrTS5gUotCWLzdKwphWY7vT3BBwZv26wQy0zODnl
         +HWPHkIXGMwax4ysK8eAZ6LPknjfwLQahEjS0xtz4qHwb6Mt3HlwXTSq5whZvCGF5qX4
         guZQgYKdHcxEoZOxkgTgTSWgDtKq2h6EfqZc/if2XwJu6dQk7CmSvQ1y79Ne8Mbc0Jp1
         mJsnPIJAhMfL8D0dsSgg7wKf9x61sZHX6Rt0nK07QufXbwBvYEtb9HfADBS6rZYg4AnP
         6akdPp8WlHcZuTZZtof1evvephpGlGi/vF0czXrpSigMzHJPqDCbmTUdrwayPLzcDqve
         9Qnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=NoYBywhpuKimSGwin3C7a9q598Qx6aFDiJR0OAgeQsE=;
        b=pis/Z+8xU+sWUmVLs0mV/9xWYfieuK3y8RuXN9KOvh+P7sXt/kHm1D9fXdsEe6WrFP
         QsJkkZBVedW/A0WAHvrSUPX0AXWMSU3RllpAnp3kph15HWQTgPsZ3mXv9fxFdEl5XCaq
         UjKWe3bk/EGVpQrNPcO4quoOsMllizWZyFa6+YnFMhLY2F6ajgWrX2B0xZ5nz3GJZx0w
         7PUzPNFoYVYrygOMOsR+0sv3NFLZRjcClYc5g1I6QmqsozrW1x2ZSBN+MKvVPaO8UGih
         Gt9JjBZVE6ZevEkQrAIgqLs0K2I2Unt9MmE5eVh4YTym45WG/wzNwmz1swLbmHcDQqCz
         labQ==
X-Gm-Message-State: APjAAAVb9vCbWULg1owEWgjlpbqsKnqPYhMD6AtEyfmDLtPeUwHkzbqn
        k3qQOSbxTwyoCyU/YwW506eWuw==
X-Google-Smtp-Source: APXvYqwOwkOUiwmU+lCXRKBHb6svrN9ugZb7IIaZhooLdFfD+KKEoFGhritlvRMCeWrMX+yekAvdxw==
X-Received: by 2002:ac8:7b9b:: with SMTP id p27mr6004108qtu.2.1576123910680;
        Wed, 11 Dec 2019 20:11:50 -0800 (PST)
Received: from Thara-Work-Ubuntu.fios-router.home (pool-71-255-246-27.washdc.fios.verizon.net. [71.255.246.27])
        by smtp.googlemail.com with ESMTPSA id s11sm1364126qkg.99.2019.12.11.20.11.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 11 Dec 2019 20:11:49 -0800 (PST)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, ionela.voinescu@arm.com,
        vincent.guittot@linaro.org, rui.zhang@intel.com,
        qperret@google.com, daniel.lezcano@linaro.org,
        viresh.kumar@linaro.org
Cc:     linux-kernel@vger.kernel.org, amit.kachhap@gmail.com,
        javi.merino@kernel.org, amit.kucheria@verdurent.com
Subject: [Patch v6 0/7] Introduce Thermal Pressure
Date:   Wed, 11 Dec 2019 23:11:41 -0500
Message-Id: <1576123908-12105-1-git-send-email-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.1.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thermal governors can respond to an overheat event of a cpu by
capping the cpu's maximum possible frequency. This in turn
means that the maximum available compute capacity of the
cpu is restricted. But today in the kernel, task scheduler is
not notified of capping of maximum frequency of a cpu.
In other words, scheduler is unaware of maximum capacity
restrictions placed on a cpu due to thermal activity.
This patch series attempts to address this issue.
The benefits identified are better task placement among available
cpus in event of overheating which in turn leads to better
performance numbers.

The reduction in the maximum possible capacity of a cpu due to a
thermal event can be considered as thermal pressure. Instantaneous
thermal pressure is hard to record and can sometime be erroneous
as there can be mismatch between the actual capping of capacity
and scheduler recording it. Thus solution is to have a weighted
average per cpu value for thermal pressure over time.
The weight reflects the amount of time the cpu has spent at a
capped maximum frequency. Since thermal pressure is recorded as
an average, it must be decayed periodically. Exisiting algorithm
in the kernel scheduler pelt framework is re-used to calculate
the weighted average. This patch series also defines a sysctl
inerface to allow for a configurable decay period.

Regarding testing, basic build, boot and sanity testing have been
performed on db845c platform with debian file system.
Further, dhrystone and hackbench tests have been
run with the thermal pressure algorithm. During testing, due to
constraints of step wise governor in dealing with big little systems,
trip point 0 temperature was made assymetric between cpus in little
cluster and big cluster; the idea being that
big core will heat up and cpu cooling device will throttle the
frequency of the big cores faster, there by limiting the maximum available
capacity and the scheduler will spread out tasks to little cores as well.

Test Results

Hackbench: 1 group , 30000 loops, 10 runs
                                               Result         SD
                                               (Secs)     (% of mean)
 No Thermal Pressure                            14.03       2.69%
 Thermal Pressure PELT Algo. Decay : 32 ms      13.29       0.56%
 Thermal Pressure PELT Algo. Decay : 64 ms      12.57       1.56%
 Thermal Pressure PELT Algo. Decay : 128 ms     12.71       1.04%
 Thermal Pressure PELT Algo. Decay : 256 ms     12.29       1.42%
 Thermal Pressure PELT Algo. Decay : 512 ms     12.42       1.15%

Dhrystone Run Time  : 20 threads, 3000 MLOOPS
                                                 Result      SD
                                                 (Secs)    (% of mean)
 No Thermal Pressure                              9.452      4.49%
 Thermal Pressure PELT Algo. Decay : 32 ms        8.793      5.30%
 Thermal Pressure PELT Algo. Decay : 64 ms        8.981      5.29%
 Thermal Pressure PELT Algo. Decay : 128 ms       8.647      6.62%
 Thermal Pressure PELT Algo. Decay : 256 ms       8.774      6.45%
 Thermal Pressure PELT Algo. Decay : 512 ms       8.603      5.41%

A Brief History

The first version of this patch-series was posted with resuing
PELT algorithm to decay thermal pressure signal. The discussions
that followed were around whether intanteneous thermal pressure
solution is better and whether a stand-alone algortihm to accumulate
and decay thermal pressure is more appropriate than re-using the
PELT framework.
Tests on Hikey960 showed the stand-alone algorithm performing slightly
better than resuing PELT algorithm and V2 was posted with the stand
alone algorithm. Test results were shared as part of this series.
Discussions were around re-using PELT algorithm and running
further tests with more granular decay period.

For some time after this development was impeded due to hardware
unavailability, some other unforseen and possibly unfortunate events.
For this version, h/w was switched from hikey960 to db845c.
Also Instantaneous thermal pressure was never tested as part of this
cycle as it is clear that weighted average is a better implementation.
The non-PELT algorithm never gave any conclusive results to prove that it
is better than reusing PELT algorithm, in this round of testing.
Also reusing PELT algorithm means thermal pressure tracks the
other utilization signals in the scheduler.

v3->v4:
        - "Patch 3/7:sched: Initialize per cpu thermal pressure structure"
           is dropped as it is no longer needed following changes in other
           other patches.
        - rest of the change log mentioned in specific patches.

v5->v6:
	- "Added arch_ interface APIs to access and update thermal pressure.
	   Moved declaration of per cpu thermal_pressure valriable and
	   infrastructure to update the variable to topology files.

Thara Gopinath (6):
  sched/pelt.c: Add support to track thermal pressure
  sched/fair: Add infrastructure to store and update  instantaneous
    thermal pressure
  sched/fair: Enable periodic update of thermal pressure
  sched/fair: update cpu_capcity to reflect thermal pressure
  thermal/cpu-cooling: Update thermal pressure in case of a maximum
    frequency capping
  sched/fair: Enable tuning of decay period


Thara Gopinath (7):
  sched/pelt.c: Add support to track thermal pressure
  sched: Add hook to read per cpu thermal pressure.
  Add infrastructure to store and update instantaneous thermal pressure
  sched/fair: Enable periodic update of average thermal pressure
  sched/fair: update cpu_capacity to reflect thermal pressure
  thermal/cpu-cooling: Update thermal pressure in case of a maximum
    frequency capping
  sched/fair: Enable tuning of decay period

 Documentation/admin-guide/kernel-parameters.txt |  5 +++
 arch/arm/include/asm/topology.h                 |  3 ++
 arch/arm64/include/asm/topology.h               |  3 ++
 drivers/base/arch_topology.c                    | 13 +++++++
 drivers/thermal/cpu_cooling.c                   | 19 +++++++++--
 include/linux/arch_topology.h                   | 11 ++++++
 include/linux/sched/topology.h                  |  8 +++++
 include/trace/events/sched.h                    |  4 +++
 kernel/sched/fair.c                             | 45 +++++++++++++++++++++++++
 kernel/sched/pelt.c                             | 22 ++++++++++++
 kernel/sched/pelt.h                             |  7 ++++
 kernel/sched/sched.h                            |  1 +
 12 files changed, 139 insertions(+), 2 deletions(-)

-- 
2.1.4

