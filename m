Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16E42C4360C
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 00:58:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE5E72067B
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 00:58:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G7LsScoc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729711AbfJNA62 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Oct 2019 20:58:28 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:40827 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729180AbfJNA62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Oct 2019 20:58:28 -0400
Received: by mail-qk1-f194.google.com with SMTP id y144so14443140qkb.7
        for <linux-kernel@vger.kernel.org>; Sun, 13 Oct 2019 17:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=Ihrs3Pg5HE6QePZaT7iUT0zjNIjsbvtTYiDG5magk4s=;
        b=G7LsScocnkXwBxNsvTBec9ReA/Gd8FscaNKEWxdOF2CZietA8b134hh0NsGqz6qepb
         TGwbfr0ka3i83h6WSkZPK1yEJzgJKPAmxso9QPpZm/dfeVW9O+l6MRoPvP2ow7yfSLyk
         QcJo1dSx9HVS1UDkD+dm3VaalZDr0nL3iNFhjhqOz9IGbGFNLCiRjlR5bkJNElwS5evb
         fPj5mUrQ6x1G5fChgcPHxnXMZDbAvJH0+ASNmKT8tb1JA4CCy4H6wm10j2N4+k+FG47g
         EWHduUEtdX9tCRdLX34G70OZJI7PUdDT1/XHRORBNDzxFNJxnA9BroaXiYNrxvJyaOv0
         k9oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Ihrs3Pg5HE6QePZaT7iUT0zjNIjsbvtTYiDG5magk4s=;
        b=TYcmpkDeH3wrpP0ISRF/9gq5aLf4Rw+dzYxY2JqI72wpNJxlDh879wYkuUcC3203/u
         xzi/39okfL100XDLum5zqNRAxlkZdvb7bhnoQxKAEFGM98V4hR3EJQBOW/YIaCROiQkS
         n9FtH3fY41bcaTYw1WkeSNvVHWxWV609tdJOrdG4nVI5EC7FwgTjDeoxj8SGzoWl2h2Z
         jGL1xlDVqLvmKAs0/PofJqED2iQf54AKR72wqKmf4BGH9WmpN1Gep1WET/BonUBoUgP1
         xe02kyB8MlAtyPfK7H2hWs/lnQ57DaOZK0xACmwob+HDDAFZ4Q99wNBTMvvqQ+2P3kcC
         i+lg==
X-Gm-Message-State: APjAAAX34Orv25w8MiM50LYly56m7E1/ee2DtWvodSWLs1vE8anl0x9S
        T+v8Cicdkn/VFgfWNASCIxTw7w==
X-Google-Smtp-Source: APXvYqxkiH78odMQYBr8ZpKxcq/qtEIUn5E1xdW9ABmsgZ6M4G0Lq/F3OlUjQ64WYpzLUYkB6a7tkQ==
X-Received: by 2002:ae9:f204:: with SMTP id m4mr25117640qkg.300.1571014707191;
        Sun, 13 Oct 2019 17:58:27 -0700 (PDT)
Received: from Thara-Work-Ubuntu.fios-router.home (pool-71-255-246-27.washdc.fios.verizon.net. [71.255.246.27])
        by smtp.googlemail.com with ESMTPSA id c185sm7663901qkf.122.2019.10.13.17.58.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 13 Oct 2019 17:58:26 -0700 (PDT)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, ionela.voinescu@arm.com,
        vincent.guittot@linaro.org, rui.zhang@intel.com,
        edubezval@gmail.com
Cc:     linux-kernel@vger.kernel.org, amit.kachhap@gmail.com,
        javi.merino@kernel.org, daniel.lezcano@linaro.org
Subject: [Patch v3 0/7] Introduce Thermal Pressure
Date:   Sun, 13 Oct 2019 20:58:18 -0400
Message-Id: <1571014705-19646-1-git-send-email-thara.gopinath@linaro.org>
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
In other words, scheduler is unware of maximum capacity
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

Thara Gopinath (7):
  sched/pelt.c: Add support to track thermal pressure
  sched: Add infrastructure to store and update instantaneous thermal
    pressure
  sched: Initialize per cpu thermal pressure structure
  sched/fair: Enable CFS periodic tick to update thermal pressure
  sched/fair: update cpu_capcity to reflect thermal pressure
  thermal/cpu-cooling: Update thermal pressure in case of a maximum
    frequency capping
  sched: thermal: Enable tuning of decay period

 drivers/base/arch_topology.c  |  1 +
 drivers/thermal/cpu_cooling.c | 31 +++++++++++++++--
 include/linux/sched.h         | 14 ++++++++
 include/linux/sched/sysctl.h  |  1 +
 kernel/sched/Makefile         |  2 +-
 kernel/sched/core.c           |  2 ++
 kernel/sched/fair.c           |  6 ++++
 kernel/sched/pelt.c           | 13 +++++++
 kernel/sched/pelt.h           |  7 ++++
 kernel/sched/sched.h          |  1 +
 kernel/sched/thermal.c        | 80 +++++++++++++++++++++++++++++++++++++++++++
 kernel/sched/thermal.h        | 13 +++++++
 kernel/sysctl.c               |  7 ++++
 13 files changed, 175 insertions(+), 3 deletions(-)
 create mode 100644 kernel/sched/thermal.c
 create mode 100644 kernel/sched/thermal.h

-- 
2.1.4

