Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E804C31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 10:42:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 483A42085A
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 10:42:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728028AbfHLKmg convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 06:42:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39666 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727678AbfHLKmf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 06:42:35 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 38FE1C05E740;
        Mon, 12 Aug 2019 10:42:35 +0000 (UTC)
Received: from krava (unknown [10.43.17.33])
        by smtp.corp.redhat.com (Postfix) with SMTP id 8EF727CD84;
        Mon, 12 Aug 2019 10:42:33 +0000 (UTC)
Date:   Mon, 12 Aug 2019 12:42:32 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Mukesh Ojha <mojha@codeaurora.org>
Cc:     linux-kernel@vger.kernel.org,
        Raghavendra Rao Ananta <rananta@codeaurora.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Alexei Starovoitov <ast@kernel.org>
Subject: Re: [PATCH V5 1/1] perf: event preserve and create across cpu hotplug
Message-ID: <20190812104232.GA17441@krava>
References: <1564685213-8180-1-git-send-email-mojha@codeaurora.org>
 <1564685213-8180-2-git-send-email-mojha@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <1564685213-8180-2-git-send-email-mojha@codeaurora.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Mon, 12 Aug 2019 10:42:35 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 02, 2019 at 12:16:53AM +0530, Mukesh Ojha wrote:
> Perf framework doesn't allow preserving CPU events across
> CPU hotplugs. The events are scheduled out as and when the
> CPU walks offline. Moreover, the framework also doesn't
> allow the clients to create events on an offline CPU. As
> a result, the clients have to keep on monitoring the CPU
> state until it comes back online.
> 
> Therefore, introducing the perf framework to support creation
> and preserving of (CPU) events for offline CPUs. Through
> this, the CPU's online state would be transparent to the
> client and it not have to worry about monitoring the CPU's
> state. Success would be returned to the client even while
> creating the event on an offline CPU. If during the lifetime
> of the event the CPU walks offline, the event would be
> preserved and would continue to count as soon as (and if) the
> CPU comes back online.
> 
> Co-authored-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Raghavendra Rao Ananta <rananta@codeaurora.org>
> Signed-off-by: Mukesh Ojha <mojha@codeaurora.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Jiri Olsa <jolsa@redhat.com>
> Cc: Alexei Starovoitov <ast@kernel.org>
> ---
> Change in V5:
> =============
> - Rebased it.

note that we might need to change how we store cpu topology,
now that it can change during the sampling.. like below it's
the comparison of header data with and without cpu 1

I think some of the report code checks on topology or caches
and it might get confused

perhaps we could watch cpu topology in record and update the
data as we see it changing.. future TODO list ;-)

perf stat is probably fine

jirka


---
-# nrcpus online : 39
+# nrcpus online : 40
 # nrcpus avail : 40
 # cpudesc : Intel(R) Xeon(R) Silver 4114 CPU @ 2.20GHz
 # cpuid : GenuineIntel,6,85,4
...
 # sibling sockets : 0,2,4,6,8,10,12,14,16,18,20,22,24,26,28,30,32,34,36,38
-# sibling sockets : 3,5,7,9,11,13,15,17,19,21,23,25,27,29,31,33,35,37,39
+# sibling sockets : 1,3,5,7,9,11,13,15,17,19,21,23,25,27,29,31,33,35,37,39
 # sibling dies    : 0,2,4,6,8,10,12,14,16,18,20,22,24,26,28,30,32,34,36,38
-# sibling dies    : 3,5,7,9,11,13,15,17,19,21,23,25,27,29,31,33,35,37,39
+# sibling dies    : 1,3,5,7,9,11,13,15,17,19,21,23,25,27,29,31,33,35,37,39
 # sibling threads : 0,20
+# sibling threads : 1,21
 # sibling threads : 2,22
 # sibling threads : 3,23
 # sibling threads : 4,24
@@ -38,9 +39,8 @@
 # sibling threads : 17,37
 # sibling threads : 18,38
 # sibling threads : 19,39
-# sibling threads : 21
 # CPU 0: Core ID 0, Die ID 0, Socket ID 0
-# CPU 1: Core ID -1, Die ID -1, Socket ID -1
+# CPU 1: Core ID 0, Die ID 0, Socket ID 1
 # CPU 2: Core ID 4, Die ID 0, Socket ID 0
 # CPU 3: Core ID 4, Die ID 0, Socket ID 1
 # CPU 4: Core ID 1, Die ID 0, Socket ID 0
@@ -79,14 +79,16 @@
 # CPU 37: Core ID 9, Die ID 0, Socket ID 1
 # CPU 38: Core ID 10, Die ID 0, Socket ID 0
 # CPU 39: Core ID 10, Die ID 0, Socket ID 1
-# node0 meminfo  : total = 47391616 kB, free = 46536844 kB
+# node0 meminfo  : total = 47391616 kB, free = 46548348 kB
 # node0 cpu list : 0,2,4,6,8,10,12,14,16,18,20,22,24,26,28,30,32,34,36,38
-# node1 meminfo  : total = 49539612 kB, free = 48908820 kB
-# node1 cpu list : 3,5,7,9,11,13,15,17,19,21,23,25,27,29,31,33,35,37,39
+# node1 meminfo  : total = 49539612 kB, free = 48897176 kB
+# node1 cpu list : 1,3,5,7,9,11,13,15,17,19,21,23,25,27,29,31,33,35,37,39
 # pmu mappings: intel_pt = 8, uncore_cha_1 = 25, uncore_irp_3 = 49, software = 1, uncore_imc_5 = 18, uncore_m3upi_0 = 21, uncore_iio_free_running_5 = 45, uncore_irp_1 = 47, uncore_m2m_1 = 12, uncore_imc_3 = 16, uncore_cha_8 = 32, uncore_iio_free_running_3 = 43, uncore_imc_1 = 14, uncore_upi_1 = 20, power = 10, uncore_cha_6 = 30, uncore_iio_free_running_1 = 41, uncore_iio_4 = 38, uprobe = 7, cpu = 4, uncore_cha_4 = 28, uncore_iio_2 = 36, cstate_core = 53, breakpoint = 5, uncore_cha_2 = 26, uncore_irp_4 = 50, uncore_m3upi_1 = 22, uncore_iio_0 = 34, tracepoint = 2, uncore_cha_0 = 24, uncore_irp_2 = 48, cstate_pkg = 54, uncore_imc_4 = 17, uncore_cha_9 = 33, uncore_iio_free_running_4 = 44, uncore_ubox = 23, uncore_irp_0 = 46, uncore_m2m_0 = 11, uncore_imc_2 = 15, kprobe = 6, uncore_cha_7 = 31, uncore_iio_free_running_2 = 42, uncore_iio_5 = 39, uncore_imc_0 = 13, uncore_upi_0 = 19, uncore_cha_5 = 29, uncore_iio_free_running_0 = 40, uncore_pcu = 52, msr = 9, uncore_iio_3 = 37, uncore_cha_3
  = 27, uncore_irp_5 = 51, uncore_iio_1 = 35
 # CPU cache info:
 #  L1 Data                 32K [0,20]
 #  L1 Instruction          32K [0,20]
+#  L1 Data                 32K [1,21]
+#  L1 Instruction          32K [1,21]
 #  L1 Data                 32K [2,22]
 #  L1 Instruction          32K [2,22]
 #  L1 Data                 32K [3,23]
@@ -123,9 +125,8 @@
 #  L1 Instruction          32K [18,38]
 #  L1 Data                 32K [19,39]
 #  L1 Instruction          32K [19,39]
-#  L1 Data                 32K [21]
-#  L1 Instruction          32K [21]
 #  L2 Unified            1024K [0,20]
+#  L2 Unified            1024K [1,21]
 #  L2 Unified            1024K [2,22]
 #  L2 Unified            1024K [3,23]
 #  L2 Unified            1024K [4,24]
@@ -144,12 +145,11 @@
 #  L2 Unified            1024K [17,37]
 #  L2 Unified            1024K [18,38]
 #  L2 Unified            1024K [19,39]
-#  L2 Unified            1024K [21]
 #  L3 Unified           14080K [0,2,4,6,8,10,12,14,16,18,20,22,24,26,28,30,32,34,36,38]
-#  L3 Unified           14080K [3,5,7,9,11,13,15,17,19,21,23,25,27,29,31,33,35,37,39]
...
