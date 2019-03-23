Return-Path: <SRS0=q9dy=R2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACE84C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 04:45:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 859C2218E2
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 04:45:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727434AbfCWEp3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Mar 2019 00:45:29 -0400
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:34001 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727103AbfCWEpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Mar 2019 00:45:14 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R231e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07488;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0TNPuxAM_1553316293;
Received: from e19h19392.et15sqa.tbsite.net(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0TNPuxAM_1553316293)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 23 Mar 2019 12:45:04 +0800
From:   Yang Shi <yang.shi@linux.alibaba.com>
To:     mhocko@suse.com, mgorman@techsingularity.net, riel@surriel.com,
        hannes@cmpxchg.org, akpm@linux-foundation.org,
        dave.hansen@intel.com, keith.busch@intel.com,
        dan.j.williams@intel.com, fengguang.wu@intel.com, fan.du@intel.com,
        ying.huang@intel.com
Cc:     yang.shi@linux.alibaba.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 10/10] doc: elaborate the PMEM allocation rule
Date:   Sat, 23 Mar 2019 12:44:35 +0800
Message-Id: <1553316275-21985-11-git-send-email-yang.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1553316275-21985-1-git-send-email-yang.shi@linux.alibaba.com>
References: <1553316275-21985-1-git-send-email-yang.shi@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

non-DRAM nodes are excluded from default allocation node mask, elaborate
the rules.

Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
---
 Documentation/vm/numa.rst | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/vm/numa.rst b/Documentation/vm/numa.rst
index 185d8a5..8c2fd5c 100644
--- a/Documentation/vm/numa.rst
+++ b/Documentation/vm/numa.rst
@@ -133,7 +133,7 @@ a subsystem allocates per CPU memory resources, for example.
 
 A typical model for making such an allocation is to obtain the node id of the
 node to which the "current CPU" is attached using one of the kernel's
-numa_node_id() or CPU_to_node() functions and then request memory from only
+numa_node_id() or cpu_to_node() functions and then request memory from only
 the node id returned.  When such an allocation fails, the requesting subsystem
 may revert to its own fallback path.  The slab kernel memory allocator is an
 example of this.  Or, the subsystem may choose to disable or not to enable
@@ -148,3 +148,8 @@ architectures transparently, kernel subsystems can use the numa_mem_id()
 or cpu_to_mem() function to locate the "local memory node" for the calling or
 specified CPU.  Again, this is the same node from which default, local page
 allocations will be attempted.
+
+If the architecture supports non-regular DRAM nodes, i.e. NVDIMM on x86, the
+non-DRAM nodes are hidden from default mode, IOWs the default allocation
+would not end up on non-DRAM nodes, unless thoes nodes are specified
+explicity by mempolicy. [see Documentation/vm/numa_memory_policy.txt.]
-- 
1.8.3.1

