Return-Path: <SRS0=q9dy=R2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2436AC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 15:45:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E34E921902
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 15:45:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727713AbfCWPpY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Mar 2019 11:45:24 -0400
Received: from [110.188.70.11] ([110.188.70.11]:20953 "EHLO spam2.hygon.cn"
        rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726649AbfCWPpY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Mar 2019 11:45:24 -0400
Received: from MK-FE.hygon.cn ([172.23.18.61])
        by spam2.hygon.cn with ESMTP id x2NFgUCn087385;
        Sat, 23 Mar 2019 23:42:30 +0800 (GMT-8)
        (envelope-from puwen@hygon.cn)
Received: from cncheex01.Hygon.cn ([172.23.18.10])
        by MK-FE.hygon.cn with ESMTP id x2NFgRIP083306;
        Sat, 23 Mar 2019 23:42:27 +0800 (GMT-8)
        (envelope-from puwen@hygon.cn)
Received: from localhost.localdomain (172.23.18.44) by cncheex01.Hygon.cn
 (172.23.18.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1466.3; Sat, 23 Mar
 2019 23:42:28 +0800
From:   Pu Wen <puwen@hygon.cn>
To:     <bp@alien8.de>, <tglx@linutronix.de>, <mingo@redhat.com>,
        <hpa@zytor.com>, <x86@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, Pu Wen <puwen@hygon.cn>
Subject: [RFC PATCH v2] x86/cpu/hygon: Fix phys_proc_id calculation logic for multi-die processor
Date:   Sat, 23 Mar 2019 23:42:20 +0800
Message-ID: <1553355740-19999-1-git-send-email-puwen@hygon.cn>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.23.18.44]
X-ClientProxiedBy: cncheex02.Hygon.cn (172.23.18.12) To cncheex01.Hygon.cn
 (172.23.18.10)
X-MAIL: spam2.hygon.cn x2NFgUCn087385
X-DNSRBL: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


v1->v2:
  - Define bit 6 of ApicId with a descriptive name.
  - Add description about why Hygon need to do something different than
    what AMD does.


For Hygon family 18h multi-die processor platform, which support 1-Die/
2-Die/4-Die per socket, the system view is shown in the following system
topology.

System View (with 1-Die 2-Socket):
           |------------|
         ------       -----
 SOCKET0 | D0 |       | D1 |  SOCKET1
         ------       -----

System View (with 2-Die 2-socket):
           --------------------
           |     -------------|------
           |     |            |     |
         ------------       ------------
 SOCKET0 | D1 -- D0 |       | D3 -- D2 | SOCKET1
         ------------       ------------

System View (with 4-Die 2-Socket) :
           --------------------
           |     -------------|------
           |     |            |     |
         ------------       ------------
         | D1 -- D0 |       | D7 -- D6 |
         | |  \/ |  |       | |  \/ |  |
 SOCKET0 | |  /\ |  |       | |  /\ |  | SOCKET1
         | D2 -- D3 |       | D4 -- D5 |
         ------------       ------------
           |     |            |     |
           ------|------------|     |
                 --------------------

Current code direct use "phys_proc_id = initial_apicid >> bits", which
calculate phys_proc_id from initial_apicid by shifting *bits*, will get
wrong phys_proc_id for Hygon family 18h 1-Die/2-Die 2-socket system.

According to document [1] section 2.1.11.1, the *bits* is the value of
CPUID_Fn80000008_ECX[12:15]. The value may be 4, 5 or 6. The definitions
are: 4 - 1 die, 5 - 2 die, 6 - 3/4 die.

Hygon programs the initial ApicId in the same way as AMD. The ApicId is
read from CPUID_Fn00000001_EBX (see section 2.1.11.1 of referrence [1])
and the definition is as below (see section 2.1.10.2.1.3 of [1]):
             -------------------------------------------------
         Bit |     6     |   5  4  |    3   |    2   1   0   |
             |-----------|---------|--------|----------------|
         IDs | Socket ID | Node ID | CCX ID | Core/Thread ID |
             -------------------------------------------------

So for 3/4-Die CPU the *bits* is 6, which is same to ApicID definition
field, which still can get correct socket ID for 2-socket system. But
for 1-Die or 2-Die CPU the *bits* is 4 or 5, which will cause the right
shifted result is not exactly the value of socket ID.

For Hygon family 18h CPU the socket ID should be obtained from ApicId[6].
To fix the problem and match ApicID field definition, adjust the shift
bits to 6 for all Hygon family 18h multi-die CPUs.

Because AMD doesn't have 2-Socket system with 1-Die/2-Die processors(see
reference [2]), so it will return the right result when getting physical
ID in AMD system. Therefore this doesn't need to be changed in AMD code
but only for Hygon.

Reference:
[1] https://www.amd.com/system/files/TechDocs/54945_PPR_Family_17h_Models_00h-0Fh.pdf
[2] https://www.amd.com/en/products/specifications/processors

Signed-off-by: Pu Wen <puwen@hygon.cn>
---
 arch/x86/kernel/cpu/hygon.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/kernel/cpu/hygon.c b/arch/x86/kernel/cpu/hygon.c
index cf25405..415621d 100644
--- a/arch/x86/kernel/cpu/hygon.c
+++ b/arch/x86/kernel/cpu/hygon.c
@@ -19,6 +19,8 @@
 
 #include "cpu.h"
 
+#define APICID_SOCKET_ID_BIT 6
+
 /*
  * nodes_per_socket: Stores the number of nodes per socket.
  * Refer to CPUID Fn8000_001E_ECX Node Identifiers[10:8]
@@ -87,6 +89,9 @@ static void hygon_get_topology(struct cpuinfo_x86 *c)
 		if (!err)
 			c->x86_coreid_bits = get_count_order(c->x86_max_cores);
 
+		/* Socket ID is ApicId[6] for these processors. */
+		c->phys_proc_id = c->apicid >> APICID_SOCKET_ID_BIT;
+
 		cacheinfo_hygon_init_llc_id(c, cpu, node_id);
 	} else if (cpu_has(c, X86_FEATURE_NODEID_MSR)) {
 		u64 value;
-- 
2.7.4

