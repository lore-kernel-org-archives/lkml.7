Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CCA2C432C1
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 23:33:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CDB12190F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 23:33:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408369AbfIWXdr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 19:33:47 -0400
Received: from mga04.intel.com ([192.55.52.120]:54857 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2408303AbfIWXdq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 19:33:46 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Sep 2019 16:33:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,542,1559545200"; 
   d="scan'208";a="188285744"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.137])
  by fmsmga008.fm.intel.com with ESMTP; 23 Sep 2019 16:33:45 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 6AB6A301B06; Mon, 23 Sep 2019 16:33:45 -0700 (PDT)
From:   Andi Kleen <andi@firstfloor.org>
To:     acme@kernel.org
Cc:     jolsa@kernel.org, linux-kernel@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>
Subject: [PATCH 1/3] perf, evlist: Fix access of freed id arrays
Date:   Mon, 23 Sep 2019 16:33:37 -0700
Message-Id: <20190923233339.25326-1-andi@firstfloor.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

I'm not fully sure if this is the correct fix, but without this
I get crashes on more complex perf stat metric usages. The problem
is that part of the state gets freed when a weak group fails,
but then is later still used. Just don't free the ids, we're
going to reuse them anyways on the weak group retry.

For example:

% perf stat -M IpB,IpCall,IpTB,IPC,Retiring_SMT,Frontend_Bound_SMT,Kernel_Utilization,CPU_Utilization --metric-only -a -I 1000 sleep 2

crashes and gives in valgrind:

=21527== Invalid write of size 8
==21527==    at 0x4EE582: hlist_add_head (list.h:644)
==21527==    by 0x4EFD3C: perf_evlist__id_hash (evlist.c:477)
==21527==    by 0x4EFD99: perf_evlist__id_add (evlist.c:483)
==21527==    by 0x4EFF15: perf_evlist__id_add_fd (evlist.c:524)
==21527==    by 0x4FC693: store_evsel_ids (evsel.c:2969)
==21527==    by 0x4FC76C: perf_evsel__store_ids (evsel.c:2986)
==21527==    by 0x450DA7: __run_perf_stat (builtin-stat.c:519)
==21527==    by 0x451285: run_perf_stat (builtin-stat.c:636)
==21527==    by 0x454619: cmd_stat (builtin-stat.c:1966)
==21527==    by 0x4D557D: run_builtin (perf.c:310)
==21527==    by 0x4D57EA: handle_internal_command (perf.c:362)
==21527==    by 0x4D5931: run_argv (perf.c:406)
==21527==  Address 0x12e3f008 is 104 bytes inside a block of size 2,056 free'd
==21527==    at 0x4839A0C: free (vg_replace_malloc.c:540)
==21527==    by 0x627139: xyarray__delete (xyarray.c:32)
==21527==    by 0x4F6BE4: perf_evsel__free_id (evsel.c:1253)
==21527==    by 0x4FA11F: evsel__close (evsel.c:1994)
==21527==    by 0x4F30A3: perf_evlist__reset_weak_group (evlist.c:1783)
==21527==    by 0x450B47: __run_perf_stat (builtin-stat.c:466)
==21527==    by 0x451285: run_perf_stat (builtin-stat.c:636)
==21527==    by 0x454619: cmd_stat (builtin-stat.c:1966)
==21527==    by 0x4D557D: run_builtin (perf.c:310)
==21527==    by 0x4D57EA: handle_internal_command (perf.c:362)
==21527==    by 0x4D5931: run_argv (perf.c:406)
==21527==    by 0x4D5CAE: main (perf.c:531)
==21527==  Block was alloc'd at
==21527==    at 0x483AB1A: calloc (vg_replace_malloc.c:762)
==21527==    by 0x627024: zalloc (zalloc.c:8)
==21527==    by 0x627088: xyarray__new (xyarray.c:10)
==21527==    by 0x4F6B20: perf_evsel__alloc_id (evsel.c:1237)
==21527==    by 0x4FC74E: perf_evsel__store_ids (evsel.c:2983)
==21527==    by 0x450DA7: __run_perf_stat (builtin-stat.c:519)
==21527==    by 0x451285: run_perf_stat (builtin-stat.c:636)
==21527==    by 0x454619: cmd_stat (builtin-stat.c:1966)
==21527==    by 0x4D557D: run_builtin (perf.c:310)
==21527==    by 0x4D57EA: handle_internal_command (perf.c:362)
==21527==    by 0x4D5931: run_argv (perf.c:406)
==21527==    by 0x4D5CAE: main (perf.c:531)

Signed-off-by: Andi Kleen <ak@linux.intel.com>
---
 tools/perf/util/evlist.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 095924aa186b..765303553041 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -1780,7 +1780,7 @@ struct evsel *perf_evlist__reset_weak_group(struct evlist *evsel_list,
 			is_open = false;
 		if (c2->leader == leader) {
 			if (is_open)
-				evsel__close(c2);
+				perf_evsel__close(&evsel->core);
 			c2->leader = c2;
 			c2->core.nr_members = 0;
 		}
-- 
2.21.0

