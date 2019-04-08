Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24CF0C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 21:46:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D86572084F
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 21:46:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="gA/4vzU7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727361AbfDHVqA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 17:46:00 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:54980 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726228AbfDHVp7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 17:45:59 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x38LYbkh022638
        for <linux-kernel@vger.kernel.org>; Mon, 8 Apr 2019 14:45:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=Lda407tzy0QrkTDuDiLFajccdK/+kFpQXvexYOQkGmM=;
 b=gA/4vzU7U80/me8oxLR3p007NYKHqjhc3SETgOoBJ/rI9Cqd+gfYd7Tbw8kk4JItZWk2
 PQXJ5B4/CTDKFIjFaCP0lKN05iJ3BgOOR8U/RHR0G0LAX68xLbwcp0Iu7lLBzD0+0tyu
 ocTNF++ZexercrzwuOT1LtHyOS9Qwq0ahXQ= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2rr7kbhvkj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2019 14:45:58 -0700
Received: from mx-out.facebook.com (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::125) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Mon, 8 Apr 2019 14:45:54 -0700
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id 9E0EC62E1F66; Mon,  8 Apr 2019 14:45:54 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Song Liu <songliubraving@fb.com>
Smtp-Origin-Hostname: devbig006.ftw2.facebook.com
To:     <linux-kernel@vger.kernel.org>, <cgroups@vger.kernel.org>
CC:     <mingo@redhat.com>, <peterz@infradead.org>,
        <vincent.guittot@linaro.org>, <tglx@linutronix.de>,
        <morten.rasmussen@arm.com>, <kernel-team@fb.com>,
        Song Liu <songliubraving@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH 0/7] introduce cpu.headroom knob to cpu controller
Date:   Mon, 8 Apr 2019 14:45:32 -0700
Message-ID: <20190408214539.2705660-1-songliubraving@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-08_09:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Servers running latency sensitive workload usually aren't fully loaded for 
various reasons including disaster readiness. The machines running our 
interactive workloads (referred as main workload) have a lot of spare CPU 
cycles that we would like to use for optimistic side jobs like video 
encoding. However, our experiments show that the side workload has strong
impact on the latency of main workload:

  side-job   main-load-level   main-avg-latency
     none          1.0              1.00
     none          1.1              1.10
     none          1.2              1.10 
     none          1.3              1.10
     none          1.4              1.15
     none          1.5              1.24
     none          1.6              1.74

     ffmpeg        1.0              1.82
     ffmpeg        1.1              2.74

Note: both the main-load-level and the main-avg-latency numbers are
 _normalized_.

In these experiments, ffmpeg is put in a cgroup with cpu.weight of 1 
(lowest priority). However, it consumes all idle CPU cycles in the 
system and causes high latency for the main workload. Further experiments
and analysis (more details below) shows that, for the main workload to meet
its latency targets, it is necessary to limit the CPU usage of the side
workload so that there are some _idle_ CPU. There are various reasons
behind the need of idle CPU time. First, shared CPU resouce saturation 
starts to happen way before time-measured utilization reaches 100%. 
Secondly, scheduling latency starts to impact the main workload as CPU 
reaches full utilization. 

Currently, the cpu controller provides two mechanisms to protect the main 
workload: cpu.weight and cpu.max. However, neither of them is sufficient 
in these use cases. As shown in the experiments above, side workload with 
cpu.weight of 1 (lowest priority) would still consume all idle CPU and add 
unacceptable latency to the main workload. cpu.max can throttle the CPU 
usage of the side workload and preserve some idle CPU. However, cpu.max 
cannot react to changes in load levels. For example, when the main 
workload uses 40% of CPU, cpu.max of 30% for the side workload would yield 
good latencies for the main workload. However, when the workload 
experiences higher load levels and uses more CPU, the same setting (cpu.max 
of 30%) would cause the interactive workload to miss its latency target. 

These experiments demonstrated the need for a mechanism to effectively 
throttle CPU usage of the side workload and preserve idle CPU cycles. 
The mechanism should be able to adjust the level of throttling based on
the load level of the main workload. 

This patchset introduces a new knob for cpu controller: cpu.headroom. 
cgroup of the main workload uses cpu.headroom to ensure side workload to 
use limited CPU cycles. For example, if a main workload has a cpu.headroom 
of 30%. The side workload will be throttled to give 30% overall idle CPU. 
If the main workload uses more than 70% of CPU, the side workload will only 
run with configurable minimal cycles. This configurable minimal cycles is
referred as "tolerance" of the main workload. 

The following is a detailed example:

 main/cpu.headroom    main-cpu-load    low-pri-cpu-cycle   idle-cpu
      30%                 30%                40%              30%
      30%                 40%                30%              30%
      30%                 50%                20%              30%
      30%                 60%                10%              30%
      30%                 70%                minimal          ~30%
      30%                 80%                minimal          ~20%

In the example, we use a constant cpu.headroom setting of 30%. As main job
experiences different level of load, the cpu controller adjusts CPU cycles
used by the low-pri jobs.

We experiemented with a web server as the main workload and ffmpeg as the 
side workload. The following table compares latency impact on the main 
workload under different cpu.headroom settings and load levels. In all 
tests, the side workload cgroup is configured with cpu.weight of 1. When 
throttled, the side workload can only run 1ms per 100ms period.

                               average-latency
main-load-level   w/o-side    w/-side-      w/-side-       w/-side-
                            no-headroom   30%-headroom   20%-headroom
     1.0            1.00       1.82          1.26           1.14                      
     1.1            1.10       2.74          1.26           1.32                      
     1.2            1.10                     1.29           1.38                      
     1.3            1.10                     1.32           1.49                      
     1.4            1.15                     1.29           1.85                      
     1.5            1.24                     1.32                                
     1.6            1.74                     1.50                              

Each row of the table shows a normalized load level and average latencies 
for 4 scenarios: w/o side workload, w/ side workload but no headroom; w/ 
side workload and 30% headroom; with side workload and 20% headroom. 


When there is no side workload, average latency of main job falls in the 
0.7x range, except the very high load scenarios. When there is side 
workload but no headroom, latency of the main job goes very high at 
moderate load levels. With 30% headroom, the average latency falls in the 
0.8x range. With 20% headroom, the average latency falls in the 0.9x to 
1.x range. We didn't finish tests in some cases with high load, because 
the latency is too high. 

This experiment demonstrated cpu.headroom is an effective and efficient
knob to control the latency of the main job.

Thanks!

Song Liu (7):
  sched: refactor tg_set_cfs_bandwidth()
  cgroup: introduce hook css_has_tasks_changed
  cgroup: introduce cgroup_parse_percentage
  sched, cgroup: add entry cpu.headroom
  sched/fair: global idleness counter for cpu.headroom
  sched/fair: throttle task runtime based on cpu.headroom
  Documentation: cgroup-v2: add information for cpu.headroom

 Documentation/admin-guide/cgroup-v2.rst |  18 +
 fs/proc/stat.c                          |   4 +-
 include/linux/cgroup-defs.h             |   2 +
 include/linux/cgroup.h                  |   1 +
 include/linux/kernel_stat.h             |   2 +
 kernel/cgroup/cgroup.c                  |  51 +++
 kernel/sched/core.c                     | 425 ++++++++++++++++++++++--
 kernel/sched/fair.c                     | 143 +++++++-
 kernel/sched/sched.h                    |  30 ++
 9 files changed, 634 insertions(+), 42 deletions(-)

-- 
2.17.1

