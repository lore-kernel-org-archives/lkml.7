Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7375CC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 19:38:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39E3220821
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 19:38:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="R5HkoXic"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729370AbfDPTiq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 15:38:46 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:40595 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726860AbfDPTip (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 15:38:45 -0400
Received: by mail-qt1-f193.google.com with SMTP id x12so24702895qts.7
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 12:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=7zPKiVYOMRb/49Gawr5s9BcvpDsRJmbTU2NXG9M4u58=;
        b=R5HkoXicNriQA4sS21/zLRZ/Tn7RE9z2wwl/dmPd+FF8h1mG2SzVeDR8MHCsaOH1Hb
         P8MekTTtWfPtCSSPlfmYkIc5uXhES1Cn88X4lMxE6epeMfT+zxpUhiA7xZ4BUm+BDRxM
         TTUMeIRhJcIVS8V+JfeoUhE8u+asdbBQa0AtiQ4rt2GUm9HVcfNhqBSd4vyyI7I9q8r/
         wjOFVinSOdeGgaviqNrZYqYCj+bHNztdTEPtzyGs0ID6Mhxf7crAUHJ+x5LIepbj2PXD
         515U5xF4ouR0VfaJt5j/adMFTH67hgD9sgiXp8sRtegXQHL88f5gp4EP5LzIOAHQeJb5
         vCRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=7zPKiVYOMRb/49Gawr5s9BcvpDsRJmbTU2NXG9M4u58=;
        b=pa/BVw9ONScb7os5sRvZmbhudCd9FOnZViDOEjSY2Gs6ebYRKyIiRGsEYl/wuasNYc
         Uv1r+B16cKnZUifzhEw9Ldc+uIyb5Imux9kYzTVsyFPVIHfqAj9+V47TjpqTQxn9wh1Y
         zTfmTIxIWRCD0lekAAC6xX2ZJzzA8cVA86qiw/uuImM9ckJ+7Idajx1wntC99Utza9nO
         da9qDgkdeD+eJLVz8E4+Lu1OuPtUC3ckwJRMugo8G4IvirQvPswLJgoRFs7UA8wI6612
         bqNXnrwdbQBydvbRAhz/jXf+8cYd5vlAlRS5im8CbOhD1riXHk2DykiqXF0nwbPgezF/
         jd8w==
X-Gm-Message-State: APjAAAVOZyaCeXayYPrT1HYSK88qUwfKz7VrWw0vxgdw124Vy5MRpFgn
        xEQfwlvcsCMcOVGbzGIqe5VxYw==
X-Google-Smtp-Source: APXvYqwzM0SGqcVZnwQSc0kZ+/IshoeR7crK9Kp2wkNonYAIDSAR8MjkpZ1vjQlqbDwz5xODsyPOJA==
X-Received: by 2002:ad4:42cb:: with SMTP id f11mr67836908qvr.53.1555443524512;
        Tue, 16 Apr 2019 12:38:44 -0700 (PDT)
Received: from Thara-Work-Ubuntu.fios-router.home (pool-71-255-245-97.washdc.fios.verizon.net. [71.255.245.97])
        by smtp.googlemail.com with ESMTPSA id k41sm46150797qtc.89.2019.04.16.12.38.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 16 Apr 2019 12:38:43 -0700 (PDT)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, rui.zhang@intel.com
Cc:     linux-kernel@vger.kernel.org, amit.kachhap@gmail.com,
        viresh.kumar@linaro.org, javi.merino@kernel.org,
        edubezval@gmail.com, daniel.lezcano@linaro.org,
        vincent.guittot@linaro.org, nicolas.dechesne@linaro.org,
        bjorn.andersson@linaro.org, dietmar.eggemann@arm.com
Subject: [PATCH V2 0/3] Introduce Thermal Pressure
Date:   Tue, 16 Apr 2019 15:38:38 -0400
Message-Id: <1555443521-579-1-git-send-email-thara.gopinath@linaro.org>
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
an average, it must be decayed periodically. To this extent, this
patch series defines a configurable decay period.

Regarding testing, basic build, boot and sanity testing have been
performed on hikey960 mainline kernel with debian file system.
Further, aobench (An occlusion renderer for benchmarking realworld
floating point performance), dhrystone and hackbench test have been
run with the thermal pressure algorithm. During testing, due to
constraints of step wise governor in dealing with big little systems,
cpu cooling was disabled on little core, the idea being that
big core will heat up and cpu cooling device will throttle the
frequency of the big cores there by limiting the maximum available
capacity and the scheduler will spread out tasks to little cores as well.
Finally, this patch series has been boot tested on db410C running v5.1-rc4
kernel.

During the course of development various methods of capturing
and reflecting thermal pressure were implemented.

The first method to be evaluated was to convert the
capped max frequency into capacity and have the scheduler use the
instantaneous value when updating cpu_capacity.
This method is referenced as "Instantaneous Thermal Pressure" in the
test results below. 

The next two methods employs different methods of averaging the
thermal pressure before applying it when updating cpu_capacity.
The first of these methods re-used the PELT algorithm already present
in the kernel that does the averaging of rt and dl load and utilization.
This method is referenced as "Thermal Pressure Averaging using PELT fmwk"
in the test results below.

The final method employs an averaging algorithm that collects and
decays thermal pressure based on the decay period. In this method,
the decay period is configurable. This method is referenced as
"Thermal Pressure Averaging non-PELT Algo. Decay : XXX ms" in the
test results below.

The test results below shows 3-5% improvement in performance when
using the third solution compared to the default system today where
scheduler is unware of cpu capacity limitations due to thermal events.


			Hackbench: (1 group , 30000 loops, 10 runs)
				Result            Standard Deviation
				(Time Secs)        (% of mean)

No Thermal Pressure             10.21                   7.99%

Instantaneous thermal pressure  10.16                   5.36%

Thermal Pressure Averaging
using PELT fmwk                 9.88                    3.94%

Thermal Pressure Averaging
non-PELT Algo. Decay : 500 ms   9.94                    4.59%

Thermal Pressure Averaging
non-PELT Algo. Decay : 250 ms   7.52                    5.42%

Thermal Pressure Averaging
non-PELT Algo. Decay : 125 ms   9.87                    3.94%



			Aobench: Size 2048 *  2048
				Result            Standard Deviation
				(Time Secs)        (% of mean)

No Thermal Pressure             141.58          15.85%

Instantaneous thermal pressure  141.63          15.03%

Thermal Pressure Averaging
using PELT fmwk                 134.48          13.16%

Thermal Pressure Averaging
non-PELT Algo. Decay : 500 ms   133.62          13.00%

Thermal Pressure Averaging
non-PELT Algo. Decay : 250 ms   137.22          15.30%

Thermal Pressure Averaging
non-PELT Algo. Decay : 125 ms   137.55          13.26%

Dhrystone was run 10 times with each run spawning 20 threads of
500 MLOOPS.The idea here is to measure the Total dhrystone run
time and not look at individual processor performance.

			Dhrystone Run Time
				Result            Standard Deviation
				(Time Secs)        (% of mean)

No Thermal Pressure		1.14                    10.04%

Instantaneous thermal pressure  1.15                    9%

Thermal Pressure Averaging
using PELT fmwk                 1.19                    11.60%

Thermal Pressure Averaging
non-PELT Algo. Decay : 500 ms   1.09                    7.51%

Thermal Pressure Averaging
non-PELT Algo. Decay : 250 ms   1.012                   7.02%

Thermal Pressure Averaging
non-PELT Algo. Decay : 125 ms   1.12                    9.02%

V1->V2: Removed using Pelt framework for thermal pressure accumulation
	and averaging. Instead implemented a weighted average algorithm.

Thara Gopinath (3):
  Calculate Thermal Pressure
  sched/fair: update cpu_capcity to reflect thermal pressure
  thermal/cpu-cooling: Update thermal pressure in case of a maximum
    frequency capping

 drivers/thermal/cpu_cooling.c |   4 +
 include/linux/sched/thermal.h |  11 +++
 kernel/sched/Makefile         |   2 +-
 kernel/sched/fair.c           |   4 +
 kernel/sched/thermal.c        | 220 ++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 240 insertions(+), 1 deletion(-)
 create mode 100644 include/linux/sched/thermal.h
 create mode 100644 kernel/sched/thermal.c
-- 
2.1.4

