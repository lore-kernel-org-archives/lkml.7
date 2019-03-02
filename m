Return-Path: <SRS0=OfNL=RF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6AA8C43381
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 02:53:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BF362075B
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 02:53:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728075AbfCBCw4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 21:52:56 -0500
Received: from mga04.intel.com ([192.55.52.120]:49778 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727898AbfCBCwd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 21:52:33 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Mar 2019 18:52:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,430,1544515200"; 
   d="scan'208";a="148572628"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by fmsmga004.fm.intel.com with ESMTP; 01 Mar 2019 18:52:29 -0800
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        "H Peter Anvin" <hpa@zytor.com>,
        "Paolo Bonzini" <pbonzini@redhat.com>,
        "Dave Hansen" <dave.hansen@intel.com>,
        "Ashok Raj" <ashok.raj@intel.com>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Ravi V Shankar" <ravi.v.shankar@intel.com>,
        "Xiaoyao Li " <xiaoyao.li@intel.com>
Cc:     "linux-kernel" <linux-kernel@vger.kernel.org>,
        "x86" <x86@kernel.org>, kvm@vger.kernel.org,
        Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH v4 14/17] x86/split_lock: Add a sysfs interface to allow user to enable or disable split lock detection on all CPUs during run time
Date:   Fri,  1 Mar 2019 18:45:08 -0800
Message-Id: <1551494711-213533-15-git-send-email-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1551494711-213533-1-git-send-email-fenghua.yu@intel.com>
References: <1551494711-213533-1-git-send-email-fenghua.yu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The interface /sys/device/system/cpu/split_lock_detect is added
to allow user to control split lock detection and show current split
lock detection setting.

Writing 1 to the file enables split lock detection and writing 0
disables split lock detection. Split lock detection is enabled or
disabled on all CPUs.

Reading the file shows current global split lock detection setting:
disabled when 0 and enabled when 1.

Please note the interface only shows global setting. During run time,
split lock detection on one CPU may be disabled if split lock
in kernel code happens on the CPU. The interface doesn't show split
lock detection status on individual CPU. User can run rdmsr on 0x33
to check split lock detection on each CPU.

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
---
 arch/x86/kernel/cpu/intel.c | 96 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 95 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index 1c1ec413a9a9..1512e96287b8 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -33,6 +33,12 @@
 #include <asm/apic.h>
 #endif
 
+#define DISABLE_SPLIT_LOCK_DETECT 0
+#define ENABLE_SPLIT_LOCK_DETECT  1
+
+static DEFINE_MUTEX(split_lock_detect_mutex);
+static int split_lock_detect_val;
+
 /*
  * Just in case our CPU detection goes bad, or you have a weird system,
  * allow a way to override the automatic disabling of MPX.
@@ -163,10 +169,35 @@ static bool bad_spectre_microcode(struct cpuinfo_x86 *c)
 	return false;
 }
 
+static u32 new_sp_test_ctl_val(u32 test_ctl_val)
+{
+	/* Change the split lock setting. */
+	if (split_lock_detect_val == DISABLE_SPLIT_LOCK_DETECT)
+		test_ctl_val &= ~TEST_CTL_ENABLE_SPLIT_LOCK_DETECT;
+	else
+		test_ctl_val |= TEST_CTL_ENABLE_SPLIT_LOCK_DETECT;
+
+	return test_ctl_val;
+}
+
+static void init_split_lock_detect(struct cpuinfo_x86 *c)
+{
+	if (cpu_has(c, X86_FEATURE_SPLIT_LOCK_DETECT)) {
+		u32 l, h;
+
+		rdmsr(MSR_TEST_CTL, l, h);
+		l = new_sp_test_ctl_val(l);
+		wrmsr(MSR_TEST_CTL, l, h);
+		pr_info_once("#AC for split lock is enabled\n");
+	}
+}
+
 static void early_init_intel(struct cpuinfo_x86 *c)
 {
 	u64 misc_enable;
 
+	init_split_lock_detect(c);
+
 	/* Unmask CPUID levels if masked: */
 	if (c->x86 > 6 || (c->x86 == 6 && c->x86_model >= 0xd)) {
 		if (msr_clear_bit(MSR_IA32_MISC_ENABLE,
@@ -1095,7 +1126,70 @@ void init_core_capability(struct cpuinfo_x86 *c)
 
 		rdmsrl(MSR_IA32_CORE_CAPABILITY, val);
 
-		if (val & CORE_CAP_SPLIT_LOCK_DETECT)
+		if (val & CORE_CAP_SPLIT_LOCK_DETECT) {
 			setup_force_cpu_cap(X86_FEATURE_SPLIT_LOCK_DETECT);
+			split_lock_detect_val = 1;
+		}
 	}
 }
+
+static ssize_t
+split_lock_detect_show(struct device *dev, struct device_attribute *attr,
+		       char *buf)
+{
+	return sprintf(buf, "%u\n", READ_ONCE(split_lock_detect_val));
+}
+
+static ssize_t
+split_lock_detect_store(struct device *dev, struct device_attribute *attr,
+			const char *buf, size_t count)
+{
+	u32 val, l, h;
+	int cpu, ret;
+
+	ret = kstrtou32(buf, 10, &val);
+	if (ret)
+		return ret;
+
+	if (val != DISABLE_SPLIT_LOCK_DETECT && val != ENABLE_SPLIT_LOCK_DETECT)
+		return -EINVAL;
+
+	/* No need to update MSR if new setting is the same as old one. */
+	if (val == split_lock_detect_val)
+		return count;
+
+	/* Only one write can happen at the same time. */
+	mutex_lock(&split_lock_detect_mutex);
+
+	WRITE_ONCE(split_lock_detect_val, val);
+
+	/* Get MSR_TEST_CTL on this CPU, assuming all CPUs have same value. */
+	rdmsr(MSR_TEST_CTL, l, h);
+	l = new_sp_test_ctl_val(l);
+	/* Update the split lock detection setting on all online CPUs. */
+	for_each_online_cpu(cpu)
+		wrmsr_on_cpu(cpu, MSR_TEST_CTL, l, h);
+
+	mutex_unlock(&split_lock_detect_mutex);
+
+	return count;
+}
+
+static DEVICE_ATTR_RW(split_lock_detect);
+
+static int __init split_lock_init(void)
+{
+	int ret;
+
+	if (!boot_cpu_has(X86_FEATURE_SPLIT_LOCK_DETECT))
+		return -ENODEV;
+
+	ret = device_create_file(cpu_subsys.dev_root,
+				 &dev_attr_split_lock_detect);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+subsys_initcall(split_lock_init);
-- 
2.7.4

