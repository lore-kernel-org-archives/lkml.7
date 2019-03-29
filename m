Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 424EBC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 20:41:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0074D2184C
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 20:41:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730251AbfC2Ulh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 16:41:37 -0400
Received: from terminus.zytor.com ([198.137.202.136]:44705 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730150AbfC2Ulh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 16:41:37 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x2TKfI1Q3938528
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 29 Mar 2019 13:41:18 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x2TKfHaN3938525;
        Fri, 29 Mar 2019 13:41:17 -0700
Date:   Fri, 29 Mar 2019 13:41:17 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Wei Li <tipbot@zytor.com>
Message-ID: <tip-977c7a6d1e263ff1d755f28595b99e4bc0c48a9f@git.kernel.org>
Cc:     mingo@kernel.org, namhyung@kernel.org, jolsa@kernel.org,
        huawei.libin@huawei.com, guohanjun@huawei.com,
        alexander.shishkin@linux.intel.com, liwei391@huawei.com,
        kim.phillips@arm.com, tglx@linutronix.de, hpa@zytor.com,
        dsahern@gmail.com, linux-kernel@vger.kernel.org,
        peterz@infradead.org, acme@redhat.com
Reply-To: mingo@kernel.org, huawei.libin@huawei.com, jolsa@kernel.org,
          namhyung@kernel.org, alexander.shishkin@linux.intel.com,
          guohanjun@huawei.com, kim.phillips@arm.com, liwei391@huawei.com,
          hpa@zytor.com, tglx@linutronix.de, peterz@infradead.org,
          acme@redhat.com, linux-kernel@vger.kernel.org, dsahern@gmail.com
In-Reply-To: <20190228092003.34071-1-liwei391@huawei.com>
References: <20190228092003.34071-1-liwei391@huawei.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf machine: Update kernel map address and
 re-order properly
Git-Commit-ID: 977c7a6d1e263ff1d755f28595b99e4bc0c48a9f
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  977c7a6d1e263ff1d755f28595b99e4bc0c48a9f
Gitweb:     https://git.kernel.org/tip/977c7a6d1e263ff1d755f28595b99e4bc0c48a9f
Author:     Wei Li <liwei391@huawei.com>
AuthorDate: Thu, 28 Feb 2019 17:20:03 +0800
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 28 Mar 2019 14:41:21 -0300

perf machine: Update kernel map address and re-order properly

Since commit 1fb87b8e9599 ("perf machine: Don't search for active kernel
start in __machine__create_kernel_maps"), the __machine__create_kernel_maps()
just create a map what start and end are both zero. Though the address will be
updated later, the order of map in the rbtree may be incorrect.

The commit ee05d21791db ("perf machine: Set main kernel end address properly")
fixed the logic in machine__create_kernel_maps(), but it's still wrong in
function machine__process_kernel_mmap_event().

To reproduce this issue, we need an environment which the module address
is before the kernel text segment. I tested it on an aarch64 machine with
kernel 4.19.25:

  [root@localhost hulk]# grep _stext /proc/kallsyms
  ffff000008081000 T _stext
  [root@localhost hulk]# grep _etext /proc/kallsyms
  ffff000009780000 R _etext
  [root@localhost hulk]# tail /proc/modules
  hisi_sas_v2_hw 77824 0 - Live 0xffff00000191d000
  nvme_core 126976 7 nvme, Live 0xffff0000018b6000
  mdio 20480 1 ixgbe, Live 0xffff0000018ab000
  hisi_sas_main 106496 1 hisi_sas_v2_hw, Live 0xffff000001861000
  hns_mdio 20480 2 - Live 0xffff000001822000
  hnae 28672 3 hns_dsaf,hns_enet_drv, Live 0xffff000001815000
  dm_mirror 40960 0 - Live 0xffff000001804000
  dm_region_hash 32768 1 dm_mirror, Live 0xffff0000017f5000
  dm_log 32768 2 dm_mirror,dm_region_hash, Live 0xffff0000017e7000
  dm_mod 315392 17 dm_mirror,dm_log, Live 0xffff000001780000
  [root@localhost hulk]#

Before fix:

  [root@localhost bin]# perf record sleep 3
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0.011 MB perf.data (9 samples) ]
  [root@localhost bin]# perf buildid-list -i perf.data
  4c4e46c971ca935f781e603a09b52a92e8bdfee8 [vdso]
  [root@localhost bin]# perf buildid-list -i perf.data -H
  0000000000000000000000000000000000000000 /proc/kcore
  [root@localhost bin]#

After fix:

  [root@localhost tools]# ./perf/perf record sleep 3
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0.011 MB perf.data (9 samples) ]
  [root@localhost tools]# ./perf/perf buildid-list -i perf.data
  28a6c690262896dbd1b5e1011ed81623e6db0610 [kernel.kallsyms]
  106c14ce6e4acea3453e484dc604d66666f08a2f [vdso]
  [root@localhost tools]# ./perf/perf buildid-list -i perf.data -H
  28a6c690262896dbd1b5e1011ed81623e6db0610 /proc/kcore

Signed-off-by: Wei Li <liwei391@huawei.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Acked-by: Namhyung Kim <namhyung@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Hanjun Guo <guohanjun@huawei.com>
Cc: Kim Phillips <kim.phillips@arm.com>
Cc: Li Bin <huawei.libin@huawei.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190228092003.34071-1-liwei391@huawei.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/machine.c | 32 ++++++++++++++++++++------------
 1 file changed, 20 insertions(+), 12 deletions(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 61959aba7e27..3c520baa198c 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -1421,6 +1421,20 @@ static void machine__set_kernel_mmap(struct machine *machine,
 		machine->vmlinux_map->end = ~0ULL;
 }
 
+static void machine__update_kernel_mmap(struct machine *machine,
+				     u64 start, u64 end)
+{
+	struct map *map = machine__kernel_map(machine);
+
+	map__get(map);
+	map_groups__remove(&machine->kmaps, map);
+
+	machine__set_kernel_mmap(machine, start, end);
+
+	map_groups__insert(&machine->kmaps, map);
+	map__put(map);
+}
+
 int machine__create_kernel_maps(struct machine *machine)
 {
 	struct dso *kernel = machine__get_kernel(machine);
@@ -1453,17 +1467,11 @@ int machine__create_kernel_maps(struct machine *machine)
 			goto out_put;
 		}
 
-		/* we have a real start address now, so re-order the kmaps */
-		map = machine__kernel_map(machine);
-
-		map__get(map);
-		map_groups__remove(&machine->kmaps, map);
-
-		/* assume it's the last in the kmaps */
-		machine__set_kernel_mmap(machine, addr, ~0ULL);
-
-		map_groups__insert(&machine->kmaps, map);
-		map__put(map);
+		/*
+		 * we have a real start address now, so re-order the kmaps
+		 * assume it's the last in the kmaps
+		 */
+		machine__update_kernel_mmap(machine, addr, ~0ULL);
 	}
 
 	if (machine__create_extra_kernel_maps(machine, kernel))
@@ -1599,7 +1607,7 @@ static int machine__process_kernel_mmap_event(struct machine *machine,
 		if (strstr(kernel->long_name, "vmlinux"))
 			dso__set_short_name(kernel, "[kernel.vmlinux]", false);
 
-		machine__set_kernel_mmap(machine, event->mmap.start,
+		machine__update_kernel_mmap(machine, event->mmap.start,
 					 event->mmap.start + event->mmap.len);
 
 		/*
