Return-Path: <SRS0=q9dy=R2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90268C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 16:46:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CFA220880
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 16:46:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727702AbfCWQqm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Mar 2019 12:46:42 -0400
Received: from terminus.zytor.com ([198.137.202.136]:58697 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727298AbfCWQql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Mar 2019 12:46:41 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x2NGkGOj1093679
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 23 Mar 2019 09:46:16 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x2NGkEUr1093675;
        Sat, 23 Mar 2019 09:46:14 -0700
Date:   Sat, 23 Mar 2019 09:46:14 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Pu Wen <tipbot@zytor.com>
Message-ID: <tip-e0ceeae708cebf22c990c3d703a4ca187dc837f5@git.kernel.org>
Cc:     tglx@linutronix.de, x86@kernel.org, Thomas.Lendacky@amd.com,
        hpa@zytor.com, yazen.ghannam@amd.com, mingo@redhat.com,
        linux-kernel@vger.kernel.org, mingo@kernel.org, bp@suse.de,
        puwen@hygon.cn
Reply-To: yazen.ghannam@amd.com, Thomas.Lendacky@amd.com, hpa@zytor.com,
          x86@kernel.org, tglx@linutronix.de, bp@suse.de, puwen@hygon.cn,
          mingo@kernel.org, linux-kernel@vger.kernel.org, mingo@redhat.com
In-Reply-To: <1553355740-19999-1-git-send-email-puwen@hygon.cn>
References: <1553355740-19999-1-git-send-email-puwen@hygon.cn>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/cpu] x86/CPU/hygon: Fix phys_proc_id calculation logic for
 multi-die processors
Git-Commit-ID: e0ceeae708cebf22c990c3d703a4ca187dc837f5
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

Commit-ID:  e0ceeae708cebf22c990c3d703a4ca187dc837f5
Gitweb:     https://git.kernel.org/tip/e0ceeae708cebf22c990c3d703a4ca187dc837f5
Author:     Pu Wen <puwen@hygon.cn>
AuthorDate: Sat, 23 Mar 2019 23:42:20 +0800
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Sat, 23 Mar 2019 17:41:09 +0100

x86/CPU/hygon: Fix phys_proc_id calculation logic for multi-die processors

The Hygon family 18h multi-die processor platform supports 1, 2 or
4-Dies per socket. The topology looks like this:

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

Currently

  phys_proc_id = initial_apicid >> bits

calculates the physical processor ID from the initial_apicid by shifting
*bits*.

However, this does not work for 1-Die and 2-Die 2-socket systems.

According to document [1] section 2.1.11.1, the bits is the value of
CPUID_Fn80000008_ECX[12:15]. The possible values are 4, 5 or 6 which
mean:

  4 - 1 die
  5 - 2 dies
  6 - 3/4 dies.

Hygon programs the initial ApicId the same way as AMD. The ApicId is
read from CPUID_Fn00000001_EBX (see section 2.1.11.1 of referrence [1])
and the definition is as below (see section 2.1.10.2.1.3 of [1]):

      -------------------------------------------------
  Bit |     6     |   5  4  |    3   |    2   1   0   |
      |-----------|---------|--------|----------------|
  IDs | Socket ID | Node ID | CCX ID | Core/Thread ID |
      -------------------------------------------------

So for 3/4-Die configurations, the bits variable is 6, which is the same
as the ApicID definition field.

For 1-Die and 2-Die configurations, bits is 4 or 5, which will cause the
right shifted result to not be exactly the value of socket ID.

However, the socket ID should be obtained from ApicId[6]. To fix the
problem and match the ApicID field definition, set the shift bits to 6
for all Hygon family 18h multi-die CPUs.

Because AMD doesn't have 2-Socket systems with 1-Die/2-Die processors
(see reference [2]), this doesn't need to be changed on the AMD side but
only for Hygon.

References:
[1] https://www.amd.com/system/files/TechDocs/54945_PPR_Family_17h_Models_00h-0Fh.pdf
[2] https://www.amd.com/en/products/specifications/processors

 [bp: heavily massage commit message. ]

Signed-off-by: Pu Wen <puwen@hygon.cn>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Thomas Lendacky <Thomas.Lendacky@amd.com>
Cc: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/1553355740-19999-1-git-send-email-puwen@hygon.cn
---
 arch/x86/kernel/cpu/hygon.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/kernel/cpu/hygon.c b/arch/x86/kernel/cpu/hygon.c
index cf25405444ab..415621ddb8a2 100644
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
