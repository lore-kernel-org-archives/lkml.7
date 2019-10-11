Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E4F1ECE58C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 13:45:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3E05214AF
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 13:45:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728625AbfJKNp3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 09:45:29 -0400
Received: from foss.arm.com ([217.140.110.172]:60848 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728573AbfJKNp1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 09:45:27 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D840B337;
        Fri, 11 Oct 2019 06:45:26 -0700 (PDT)
Received: from e107049-lin.arm.com (e107049-lin.cambridge.arm.com [10.1.195.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 32FFC3F68E;
        Fri, 11 Oct 2019 06:45:25 -0700 (PDT)
From:   Douglas RAILLARD <douglas.raillard@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-pm@vger.kernel.org, mingo@redhat.com, peterz@infradead.org,
        rjw@rjwysocki.net, viresh.kumar@linaro.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, douglas.raillard@arm.com,
        dietmar.eggemann@arm.com, qperret@qperret.net,
        patrick.bellasi@matbug.net, dh.han@samsung.com
Subject: [RFC PATCH v3 0/6] sched/cpufreq: Make schedutil energy aware
Date:   Fri, 11 Oct 2019 14:44:54 +0100
Message-Id: <20191011134500.235736-1-douglas.raillard@arm.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make schedutil cpufreq governor energy-aware.

- patch 1 introduces a function to retrieve a frequency given a base
  frequency and an energy cost margin.
- patch 2 links Energy Model perf_domain to sugov_policy.
- patch 3 updates get_next_freq() to make use of the Energy Model.
- patch 4 adds sugov_cpu_ramp_boost() function.
- patch 5 updates sugov_update_(single|shared)() to make use of
  sugov_cpu_ramp_boost().
- patch 6 introduces a tracepoint in get_next_freq() for
  testing/debugging. Since it's not a trace event, it's not exposed to
  userspace in a directly usable way, allowing for painless future
  updates/removal.

The benefits of using the EM in schedutil are twofold:

1) Selecting the highest possible frequency for a given cost. Some
   platforms can have lower frequencies that are less efficient than
   higher ones, in which case they should be skipped for most purposes.
   They can still be useful to give more freedom to thermal throttling
   mechanisms, but not under normal circumstances.
   note: the EM framework will warn about such OPPs "hertz/watts ratio
   non-monotonically decreasing"

2) Driving the frequency selection with power in mind, in addition to
   maximizing the utilization of the non-idle CPUs in the system.

Point 1) is implemented in "PM: Introduce em_pd_get_higher_freq()" and
enabled in schedutil by
"sched/cpufreq: Hook em_pd_get_higher_power() into get_next_freq()".

Point 2) is enabled in
"sched/cpufreq: Boost schedutil frequency ramp up". It allows using
higher frequencies when it is known that the true utilization of
currently running tasks is exceeding their previous stable point.
The benefits are:

* Boosting the frequency when the behavior of a runnable task changes,
  leading to an increase in utilization. That shortens the frequency
  ramp up duration, which in turns allows the utilization signal to
  reach stable values quicker.  Since the allowed frequency boost is
  bounded in energy, it will behave consistently across platforms,
  regardless of the OPP cost range.

* The boost is only transient, and should not impact a lot the energy
  consumed of workloads with very stable utilization signals.

This has been ligthly tested with a rtapp task ramping from 10% to 75%
utilisation on a big core. Results are improved by fast ramp-up
EWMA [1], since it greatly reduces the oscillation in frequency at first
idle when ramping up.

[1] [PATCH] sched/fair: util_est: fast ramp-up EWMA on utilization increases
    Message-ID: <20190620150555.15717-1-patrick.bellasi@arm.com>
    https://lore.kernel.org/lkml/20190620150555.15717-1-patrick.bellasi@arm.com/


v1 -> v2:

  * Split the new sugov_cpu_ramp_boost() from the existing
    sugov_cpu_is_busy() as they seem to seek a different goal.

  * Implement sugov_cpu_ramp_boost() based on CFS util_avg and
    util_est_enqueued signals, rather than using idle calls count.
    This makes the ramp boost much more accurate in finding boost
    opportunities, and give a "continuous" output rather than a boolean.

  * Add EM_COST_MARGIN_SCALE=1024 to represent the
    margin values of em_pd_get_higher_freq().

v2 -> v3:

  * Check util_avg >= sg_cpu->util_avg in sugov_cpu_ramp_boost_update()
    to avoid boosting when the utilization is decreasing.

  * Add a tracepoint for testing. 

Douglas RAILLARD (6):
  PM: Introduce em_pd_get_higher_freq()
  sched/cpufreq: Attach perf domain to sugov policy
  sched/cpufreq: Hook em_pd_get_higher_power() into get_next_freq()
  sched/cpufreq: Introduce sugov_cpu_ramp_boost
  sched/cpufreq: Boost schedutil frequency ramp up
  sched/cpufreq: Add schedutil_em_tp tracepoint

 include/linux/energy_model.h     |  53 ++++++++++++++
 include/trace/events/power.h     |   9 +++
 kernel/sched/cpufreq_schedutil.c | 122 +++++++++++++++++++++++++++++--
 3 files changed, 178 insertions(+), 6 deletions(-)

-- 
2.23.0


