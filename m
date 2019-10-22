Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 283F5CA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 20:34:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6FDC21848
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 20:34:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AJR2mIsT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389066AbfJVUe3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 16:34:29 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:44080 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729810AbfJVUe3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 16:34:29 -0400
Received: by mail-qk1-f194.google.com with SMTP id u22so17600103qkk.11
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2019 13:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=1j6EL84WGaCqLsOIVzGT7uSZAM1FKMj8EA1mIvfe7Rk=;
        b=AJR2mIsTxYNL8t0SRBXXWjrux2ZB8m5xp0CGJlkmC8Nj8JNxthnmpo9YPem+7u2phL
         mQDcF1nrPC3llECPboyyAjlsms7FVn4mifKMOe4tQlMfnZhoPE2CzoiX7GxPv3ix54LZ
         J9m3T/fd4kwUgPPOiFuRGxAA6Ys8uTFGZitkmcRwqTA9CUUFZ9DKfLvylE7hrjYzDPSQ
         qGi5Vqc4k+RYrR3mM3w2zauFnf56dpV7IbMRQxLkwASv/Ii37luhWtZBObQMgbmtet9A
         m3QPUlxmhttgrpcdC7SkvbAwbGqyE9DGcPLemWl5cmeonIiCG58+vYD/LVTuzdrlcnNJ
         mJWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=1j6EL84WGaCqLsOIVzGT7uSZAM1FKMj8EA1mIvfe7Rk=;
        b=D7+MjnEvLqGLdf0jur57JO/01YuaClHII0K8JZlmLrePnMHwuas8x9suaXWcRUv3b6
         9CpVuddFHA89yUbFSJZJj+Fy2dc8izYg5PD97I+pdJdThJCU090AOeW9Mq3vJk/UjjJ8
         ty+Ul+cJG5kHpNjWNtMyGEwNjbD3MQHak0Qg70eKZ/Txo1sGLC3tiUYMKevTEGeqcsAB
         MvwoegEnR9VLplFco1QjDrMgCHD8degMnNe4HxdVkxZnL3ge+m1Z0ZB53yzX2egfQcpX
         lMRLp9xK1k9LxoHDPWX6TxCMPxZj26c8xctJvToakCUKKYkctPPgHyS2pqt3XFy+y2vc
         IITg==
X-Gm-Message-State: APjAAAVQ+ZhwCKsO2l7dxAdtC5HcyVBvy9BpdKyuAF5xRzeqAodgv1+y
        ki5mZzTNknUGgman5wxgoZoHPQ==
X-Google-Smtp-Source: APXvYqyRzOD+i5B2tUebdDoTLJ08v6buxeU9L5b5q0cg+wRnvqhl4XnWiwmTwdlmr8DEab4LqL19sg==
X-Received: by 2002:a05:620a:209e:: with SMTP id e30mr4925116qka.440.1571776467519;
        Tue, 22 Oct 2019 13:34:27 -0700 (PDT)
Received: from Thara-Work-Ubuntu.fios-router.home (pool-71-255-246-27.washdc.fios.verizon.net. [71.255.246.27])
        by smtp.googlemail.com with ESMTPSA id r126sm8895038qke.98.2019.10.22.13.34.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 22 Oct 2019 13:34:26 -0700 (PDT)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, ionela.voinescu@arm.com,
        vincent.guittot@linaro.org, rui.zhang@intel.com,
        edubezval@gmail.com, qperret@google.com
Cc:     linux-kernel@vger.kernel.org, amit.kachhap@gmail.com,
        javi.merino@kernel.org, daniel.lezcano@linaro.org
Subject: [Patch v4 0/6] Introduce Thermal Pressure
Date:   Tue, 22 Oct 2019 16:34:19 -0400
Message-Id: <1571776465-29763-1-git-send-email-thara.gopinath@linaro.org>
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

v3->v4:
	- "Patch 3/7:sched: Initialize per cpu thermal pressure structure"
	   is dropped as it is no longer needed following changes in other
	   other patches.
	- rest of the change log mentioned in specific patches.

Thara Gopinath (6):
  sched/pelt.c: Add support to track thermal pressure
  sched: Add infrastructure to store and update instantaneous thermal
    pressure
  sched/fair: Enable CFS periodic tick to update thermal pressure
  sched/fair: update cpu_capcity to reflect thermal pressure
  thermal/cpu-cooling: Update thermal pressure in case of a maximum
    frequency capping
  sched: thermal: Enable tuning of decay period

 Documentation/admin-guide/kernel-parameters.txt |  5 ++
 drivers/thermal/cpu_cooling.c                   | 31 ++++++++++-
 include/linux/sched.h                           |  8 +++
 kernel/sched/Makefile                           |  2 +-
 kernel/sched/fair.c                             |  6 +++
 kernel/sched/pelt.c                             | 13 +++++
 kernel/sched/pelt.h                             |  7 +++
 kernel/sched/sched.h                            |  1 +
 kernel/sched/thermal.c                          | 68 +++++++++++++++++++++++++
 kernel/sched/thermal.h                          | 13 +++++
 10 files changed, 151 insertions(+), 3 deletions(-)
 create mode 100644 kernel/sched/thermal.c
 create mode 100644 kernel/sched/thermal.h

-- 
2.1.4

