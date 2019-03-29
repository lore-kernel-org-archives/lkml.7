Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D9F6C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 13:38:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FEC62184D
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 13:38:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553866732;
	bh=kpX4c4XieS7ifnCt5ngHpLht6+pyVt2pTHDWOgb6Mfo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tCTBSxSknkcb9KqEVX1s+gHnIIAqPQJXi82Lw9KKMYr7j6d1H74AOEusgA6uKGhLr
	 J1v99WB0Ykka0N59szWkBAVViK/EtyGJ4yVpHt7AO4IwDiMT1MOXmouXzbbL0z02QZ
	 Mt0iCai1L6WztPeuAsqys0QOuOEJKA6woZ9UF9aU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729862AbfC2Niv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 09:38:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:34080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729834AbfC2Nis (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 09:38:48 -0400
Received: from quaco.ghostprotocols.net (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 802362184E;
        Fri, 29 Mar 2019 13:38:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553866727;
        bh=kpX4c4XieS7ifnCt5ngHpLht6+pyVt2pTHDWOgb6Mfo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=L6zwUDocvNZ9Jl1jvo2ak/PaIZIeUtOLOSr8Cx4KSFsfz/nzgNUvWzahuqf/rVBoY
         YRjUd9j1qA5xDmMeuPX0qQzctoNr/l5C/zHMTN+up3swfRQOE7pcuCJMdQ0XZfGkGp
         DNzoHz4xzYwscpvm36O5yr71JCqR3ceClhuZe13c=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Wei Li <liwei391@huawei.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        David Ahern <dsahern@gmail.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        Kim Phillips <kim.phillips@arm.com>,
        Li Bin <huawei.libin@huawei.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 10/13] perf machine: Update kernel map address and re-order properly
Date:   Fri, 29 Mar 2019 10:37:58 -0300
Message-Id: <20190329133801.21004-11-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190329133801.21004-1-acme@kernel.org>
References: <20190329133801.21004-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wei Li <liwei391@huawei.com>

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
-- 
2.20.1

