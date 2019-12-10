Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F2EFC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 16:13:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB8952077B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 16:13:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727619AbfLJQNy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 11:13:54 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2172 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727436AbfLJQNx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 11:13:53 -0500
Received: from lhreml705-cah.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id BD22162A92049AE7E041;
        Tue, 10 Dec 2019 16:13:51 +0000 (GMT)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 lhreml705-cah.china.huawei.com (10.201.108.46) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 10 Dec 2019 16:13:51 +0000
Received: from [127.0.0.1] (10.202.226.46) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 10 Dec
 2019 16:13:51 +0000
Subject: perf top for arm64?
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        <peterz@infradead.org>, <mingo@redhat.com>,
        <alexander.shishkin@linux.intel.com>, <jolsa@redhat.com>,
        <namhyung@kernel.org>, <mark.rutland@arm.com>, <will@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Linuxarm <linuxarm@huawei.com>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>
References: <1573045254-39833-1-git-send-email-john.garry@huawei.com>
 <20191106140036.GA6259@kernel.org>
From:   John Garry <john.garry@huawei.com>
Message-ID: <418023e7-a50d-cb6f-989f-2e6d114ce5d8@huawei.com>
Date:   Tue, 10 Dec 2019 16:13:49 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20191106140036.GA6259@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.46]
X-ClientProxiedBy: lhreml728-chm.china.huawei.com (10.201.108.79) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I find to my surprise that "perf top" does not work for arm64:

root@ubuntu:/home/john/linux# tools/perf/perf top
Couldn't read the cpuid for this machine: No such file or directory

That's v5.5-rc1 release.

It seems that we are just missing an arm64 version of get_cpuid() - with 
the patch below, I now get as hoped:

    PerfTop:   32857 irqs/sec  kernel:85.0%  exact:  0.0% lost: 0/0 
drop: 0/0 [4000Hz cycles],  (all, 64 CPUs)
-------------------------------------------------------------------------------

      8.99%  [kernel]          [k] arm_smmu_cmdq_issue_cmdlist
      5.80%  [kernel]          [k] __softirqentry_text_start
      4.49%  [kernel]          [k] _raw_spin_unlock_irqrestore
      3.48%  [kernel]          [k] el0_svc_common.constprop.2
      3.37%  [kernel]          [k] _raw_write_lock_irqsave
      3.28%  [kernel]          [k] __local_bh_enable_ip
      3.05%  [kernel]          [k] __blk_complete_request
      2.07%  [kernel]          [k] queued_spin_lock_slowpath
      1.93%  [vdso]            [.] 0x0000000000000484


Was this just missed? Or is there a good reason to omit?

Thanks,
John

--->8---

Subject: [PATCH] perf: Add perf top support for arm64

Copied from get_cpuid_str() essentially...

Signed-off-by: John Garry <john.garry@huawei.com>

diff --git a/tools/perf/arch/arm64/util/header.c 
b/tools/perf/arch/arm64/util/header.c
index a32e4b72a98f..ecd1f86e29cc 100644
--- a/tools/perf/arch/arm64/util/header.c
+++ b/tools/perf/arch/arm64/util/header.c
@@ -1,10 +1,12 @@
  #include <stdio.h>
  #include <stdlib.h>
  #include <perf/cpumap.h>
+#include <util/cpumap.h>
  #include <internal/cpumap.h>
  #include <api/fs/fs.h>
  #include "debug.h"
  #include "header.h"
+#include <errno.h>

  #define MIDR "/regs/identification/midr_el1"
  #define MIDR_SIZE 19
@@ -12,6 +14,59 @@
  #define MIDR_VARIANT_SHIFT      20
  #define MIDR_VARIANT_MASK       (0xf << MIDR_VARIANT_SHIFT)

+int
+get_cpuid(char *buffer, size_t sz)
+{
+	char *buf = NULL;
+	char path[PATH_MAX];
+	const char *sysfs = sysfs__mountpoint();
+	int cpu;
+	u64 midr = 0;
+	FILE *file;
+
+	if (!sysfs)
+		return EINVAL;
+
+	buf = malloc(MIDR_SIZE);
+	if (!buf)
+		return EINVAL;
+
+	/* read midr from list of cpus mapped to this pmu */
+	for (cpu = 0; cpu < cpu__max_present_cpu(); cpu++) {
+		scnprintf(path, sz, "%s/devices/system/cpu/cpu%d"MIDR,
+				sysfs, cpu);
+
+		file = fopen(path, "r");
+		if (!file) {
+			pr_debug("fopen failed for file %s\n", path);
+			continue;
+		}
+
+		if (!fgets(buf, MIDR_SIZE, file)) {
+			fclose(file);
+			continue;
+		}
+		fclose(file);
+
+		/* Ignore/clear Variant[23:20] and
+		 * Revision[3:0] of MIDR
+		 */
+		midr = strtoul(buf, NULL, 16);
+		midr &= (~(MIDR_VARIANT_MASK | MIDR_REVISION_MASK));
+		scnprintf(buffer, MIDR_SIZE, "0x%016lx", midr);
+		/* got midr break loop */
+		break;
+	}
+
+	if (!midr) {
+		pr_err("failed to get cpuid string\n");
+		free(buf);
+		return EINVAL;
+	}
+	return 0;
+}
+
