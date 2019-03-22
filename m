Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7933AC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:14:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53F5921939
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:14:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728170AbfCVLOA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:14:00 -0400
Received: from [110.188.70.11] ([110.188.70.11]:2941 "EHLO spam1.hygon.cn"
        rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726667AbfCVLOA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:14:00 -0400
Received: from spam1.hygon.cn (localhost [127.0.0.2] (may be forged))
        by spam1.hygon.cn with ESMTP id x2MAlAqd043331
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 18:47:10 +0800 (GMT-8)
        (envelope-from puwen@hygon.cn)
Received: from MK-DB.hygon.cn ([172.23.18.60])
        by spam1.hygon.cn with ESMTP id x2MAiOqx042826;
        Fri, 22 Mar 2019 18:44:24 +0800 (GMT-8)
        (envelope-from puwen@hygon.cn)
Received: from cncheex01.Hygon.cn ([172.23.18.10])
        by MK-DB.hygon.cn with ESMTP id x2MAiHGn064391;
        Fri, 22 Mar 2019 18:44:17 +0800 (GMT-8)
        (envelope-from puwen@hygon.cn)
Received: from pw-vbox.hygon.cn (172.23.18.44) by cncheex01.Hygon.cn
 (172.23.18.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1466.3; Fri, 22 Mar
 2019 18:44:21 +0800
From:   Pu Wen <puwen@hygon.cn>
To:     <boris.ostrovsky@oracle.com>, <jgross@suse.com>, <bp@alien8.de>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <hpa@zytor.com>,
        <x86@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <xen-devel@lists.xenproject.org>,
        Pu Wen <puwen@hygon.cn>
Subject: [RFC PATCH] x86/xen/pmu: Use MSRs C001_020X instead of the legacy MSRs for Hygon
Date:   Fri, 22 Mar 2019 18:43:39 +0800
Message-ID: <1553251419-7066-1-git-send-email-puwen@hygon.cn>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.23.18.44]
X-ClientProxiedBy: cncheex02.Hygon.cn (172.23.18.12) To cncheex01.Hygon.cn
 (172.23.18.10)
X-MAIL: spam1.hygon.cn x2MAiOqx042826
X-DNSRBL: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Hygon Dhyana processor supports MSRs C001_020X for the performance
monitor counter(PMC). There are six core performance events counters for
Dhyana but there are only four legacy PMC MSRs. So switching to use MSRs
C001_020X(compatible with the F15H ones) for Xen vPMU infrastructure on
Hygon platform.

Signed-off-by: Pu Wen <puwen@hygon.cn>
---
 arch/x86/xen/pmu.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/xen/pmu.c b/arch/x86/xen/pmu.c
index e13b0b4..6480eed 100644
--- a/arch/x86/xen/pmu.c
+++ b/arch/x86/xen/pmu.c
@@ -92,11 +92,11 @@ static void xen_pmu_arch_init(void)
 			break;
 		}
 	} else if (boot_cpu_data.x86_vendor == X86_VENDOR_HYGON) {
-		amd_num_counters = F10H_NUM_COUNTERS;
-		amd_counters_base = MSR_K7_PERFCTR0;
-		amd_ctrls_base = MSR_K7_EVNTSEL0;
-		amd_msr_step = 1;
-		k7_counters_mirrored = 0;
+		amd_num_counters = F15H_NUM_COUNTERS;
+		amd_counters_base = MSR_F15H_PERF_CTR;
+		amd_ctrls_base = MSR_F15H_PERF_CTL;
+		amd_msr_step = 2;
+		k7_counters_mirrored = 1;
 	} else {
 		uint32_t eax, ebx, ecx, edx;
 
-- 
2.7.4

