Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD1CBC4CEC4
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 06:19:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE09B218AF
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 06:19:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727343AbfIRGTt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 02:19:49 -0400
Received: from ZXSHCAS2.zhaoxin.com ([203.148.12.82]:39983 "EHLO
        ZXSHCAS2.zhaoxin.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727179AbfIRGTq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 02:19:46 -0400
Received: from zxbjmbx2.zhaoxin.com (10.29.252.164) by ZXSHCAS2.zhaoxin.com
 (10.28.252.162) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1261.35; Wed, 18 Sep
 2019 14:19:43 +0800
Received: from tony-HX002EA.zhaoxin.com (10.32.64.46) by zxbjmbx2.zhaoxin.com
 (10.29.252.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1261.35; Wed, 18 Sep
 2019 14:19:41 +0800
From:   Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
To:     <tony.luck@intel.com>, <bp@alien8.de>, <tglx@linutronix.de>,
        <mingo@redhat.com>, <hpa@zytor.com>, <x86@kernel.org>,
        <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yazen.ghannam@amd.com>, <vishal.l.verma@intel.com>,
        <qiuxu.zhuo@intel.com>
CC:     <DavidWang@zhaoxin.com>, <CooperYan@zhaoxin.com>,
        <QiyuanWang@zhaoxin.com>, <HerryYang@zhaoxin.com>
Subject: [PATCH v4 4/4] x86/mce: Add Zhaoxin LMCE support
Date:   Wed, 18 Sep 2019 14:19:33 +0800
Message-ID: <1568787573-1297-5-git-send-email-TonyWWang-oc@zhaoxin.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1568787573-1297-4-git-send-email-TonyWWang-oc@zhaoxin.com>
References: <1568787573-1297-1-git-send-email-TonyWWang-oc@zhaoxin.com>
 <1568787573-1297-2-git-send-email-TonyWWang-oc@zhaoxin.com>
 <1568787573-1297-3-git-send-email-TonyWWang-oc@zhaoxin.com>
 <1568787573-1297-4-git-send-email-TonyWWang-oc@zhaoxin.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.32.64.46]
X-ClientProxiedBy: zxbjmbx1.zhaoxin.com (10.29.252.163) To
 zxbjmbx2.zhaoxin.com (10.29.252.164)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Zhaoxin newer CPUs support LMCE that compatible with Intel's
"Machine-Check Architecture", so add support for Zhaoxin LMCE
in mce/core.c.

Signed-off-by: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
---
 arch/x86/kernel/cpu/mce/core.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 65c5a1f..88a9622 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1132,6 +1132,12 @@ static bool __mc_check_crashing_cpu(int cpu)
 		u64 mcgstatus;
 
 		mcgstatus = mce_rdmsrl(MSR_IA32_MCG_STATUS);
+
+		if (boot_cpu_data.x86_vendor == X86_VENDOR_ZHAOXIN) {
+			if (mcgstatus & MCG_STATUS_LMCES)
+				return false;
+		}
+
 		if (mcgstatus & MCG_STATUS_RIPV) {
 			mce_wrmsrl(MSR_IA32_MCG_STATUS, 0);
 			return true;
@@ -1282,9 +1288,10 @@ void do_machine_check(struct pt_regs *regs, long error_code)
 
 	/*
 	 * Check if this MCE is signaled to only this logical processor,
-	 * on Intel only.
+	 * on Intel, Zhaoxin only.
 	 */
-	if (m.cpuvendor == X86_VENDOR_INTEL)
+	if (m.cpuvendor == X86_VENDOR_INTEL ||
+	    m.cpuvendor == X86_VENDOR_ZHAOXIN)
 		lmce = m.mcgstatus & MCG_STATUS_LMCES;
 
 	/*
@@ -1795,9 +1802,15 @@ static void mce_zhaoxin_feature_init(struct cpuinfo_x86 *c)
 	}
 
 	intel_init_cmci();
+	intel_init_lmce();
 	mce_adjust_timer = cmci_intel_adjust_timer;
 }
 
+static void mce_zhaoxin_feature_clear(struct cpuinfo_x86 *c)
+{
+	intel_clear_lmce();
+}
+
 static void __mcheck_cpu_init_vendor(struct cpuinfo_x86 *c)
 {
 	switch (c->x86_vendor) {
@@ -1834,6 +1847,9 @@ static void __mcheck_cpu_clear_vendor(struct cpuinfo_x86 *c)
 	case X86_VENDOR_INTEL:
 		mce_intel_feature_clear(c);
 		break;
+	case X86_VENDOR_ZHAOXIN:
+		mce_zhaoxin_feature_clear(c);
+		break;
 	default:
 		break;
 	}
-- 
2.7.4

