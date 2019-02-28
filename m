Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEA52C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 09:16:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94D202184A
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 09:16:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732131AbfB1JQJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 04:16:09 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:58488 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731379AbfB1JQJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 04:16:09 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 950203C66BE75D268DEB;
        Thu, 28 Feb 2019 17:16:06 +0800 (CST)
Received: from euler.huawei.com (10.175.104.193) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.408.0; Thu, 28 Feb 2019 17:15:57 +0800
From:   Wei Li <liwei391@huawei.com>
To:     <jolsa@kernel.org>, <alexander.shishkin@linux.intel.com>,
        <dsahern@gmail.com>, <namhyung@kernel.org>, <peterz@infradead.org>,
        <acme@redhat.com>
CC:     <linux-kernel@vger.kernel.org>, <kim.phillips@arm.com>,
        <guohanjun@huawei.com>, <huawei.libin@huawei.com>
Subject: [PATCH] perf machine: Update kernel map address and re-order properly
Date:   Thu, 28 Feb 2019 17:20:03 +0800
Message-ID: <20190228092003.34071-1-liwei391@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.104.193]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---
 tools/perf/util/machine.c | 32 ++++++++++++++++++++------------
 1 file changed, 20 insertions(+), 12 deletions(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index b1508ce3e412..076718a7b3ea 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -1358,6 +1358,20 @@ static void machine__set_kernel_mmap(struct machine *machine,
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
@@ -1390,17 +1404,11 @@ int machine__create_kernel_maps(struct machine *machine)
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
@@ -1536,7 +1544,7 @@ static int machine__process_kernel_mmap_event(struct machine *machine,
 		if (strstr(kernel->long_name, "vmlinux"))
 			dso__set_short_name(kernel, "[kernel.vmlinux]", false);
 
-		machine__set_kernel_mmap(machine, event->mmap.start,
+		machine__update_kernel_mmap(machine, event->mmap.start,
 					 event->mmap.start + event->mmap.len);
 
 		/*
-- 
2.17.1

