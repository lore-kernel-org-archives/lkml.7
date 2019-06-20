Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA666C48BDF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 01:43:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBE0221537
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 01:43:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731243AbfFTBnx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 21:43:53 -0400
Received: from mga01.intel.com ([192.55.52.88]:60105 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726349AbfFTBnu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 21:43:50 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Jun 2019 18:43:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,394,1557212400"; 
   d="scan'208";a="243484925"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by orsmga001.jf.intel.com with ESMTP; 19 Jun 2019 18:43:49 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        "H Peter Anvin" <hpa@zytor.com>,
        "Andy Lutomirski" <luto@kernel.org>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Ashok Raj" <ashok.raj@intel.com>,
        "Tony Luck" <tony.luck@intel.com>,
        "Ravi V Shankar" <ravi.v.shankar@intel.com>
Cc:     "linux-kernel" <linux-kernel@vger.kernel.org>,
        "x86" <x86@kernel.org>, Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH v5 3/5] x86/umwait: Add sysfs interface to control umwait C0.2 state
Date:   Wed, 19 Jun 2019 18:33:56 -0700
Message-Id: <1560994438-235698-4-git-send-email-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1560994438-235698-1-git-send-email-fenghua.yu@intel.com>
References: <1560994438-235698-1-git-send-email-fenghua.yu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

C0.2 state in umwait and tpause instructions can be enabled or disabled
on a processor through IA32_UMWAIT_CONTROL MSR register.

By default, C0.2 is enabled and the user wait instructions result in
lower power consumption with slower wakeup time.

But in real time systems which require faster wakeup time although power
savings could be smaller, the administrator needs to disable C0.2 and all
C0.2 requests from user applications revert to C0.1.

A sysfs interface "/sys/devices/system/cpu/umwait_control/enable_c02" is
created to allow the administrator to control C0.2 state during run time.

Andy Lutomirski suggests to turn off local irqs before writing
MSR_TEST_CTL to ensure msr_test_ctl_cached is not changed by sysfs write
on this CPU or by any concurrent sysfs write from a different CPU via IPI
until we're done.

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Reviewed-by: Ashok Raj <ashok.raj@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/kernel/cpu/umwait.c | 109 ++++++++++++++++++++++++++++++++++-
 1 file changed, 106 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/umwait.c b/arch/x86/kernel/cpu/umwait.c
index b0bf7adde36f..3bd6d37a7b2c 100644
--- a/arch/x86/kernel/cpu/umwait.c
+++ b/arch/x86/kernel/cpu/umwait.c
@@ -17,10 +17,34 @@
  */
 static u32 umwait_control_cached = UMWAIT_CTRL_VAL(100000, UMWAIT_C02_ENABLED);
 
+/*
+ * Serialize access to umwait_control_cached and IA32_UMWAIT_CONTROL MSR
+ * in writing sysfs to ensure all CPUs have the same MSR value.
+ */
+static DEFINE_MUTEX(umwait_lock);
+
+static void update_this_cpu_umwait_control_msr(void)
+{
+	unsigned long flags;
+
+	/*
+	 * We need to prevent umwait_control_cached from being changed *and*
+	 * completing its WRMSR between our read and our WRMSR. By turning
+	 * IRQs off here, ensure that no sysfs write happens on this CPU
+	 * and we also make sure that any concurrent sysfs write from a
+	 * different CPU will not finish updating us via IPI until we're done.
+	 */
+	local_irq_save(flags);
+
+	wrmsr(MSR_IA32_UMWAIT_CONTROL, READ_ONCE(umwait_control_cached), 0);
+
+	local_irq_restore(flags);
+}
+
 /* Set up IA32_UMWAIT_CONTROL MSR on CPU using the current global setting. */
 static int umwait_cpu_online(unsigned int cpu)
 {
-	wrmsr(MSR_IA32_UMWAIT_CONTROL, umwait_control_cached, 0);
+	update_this_cpu_umwait_control_msr();
 
 	return 0;
 }
@@ -36,24 +60,103 @@ static int umwait_cpu_online(unsigned int cpu)
  */
 static void umwait_syscore_resume(void)
 {
-	wrmsr(MSR_IA32_UMWAIT_CONTROL, umwait_control_cached, 0);
+	update_this_cpu_umwait_control_msr();
 }
 
 static struct syscore_ops umwait_syscore_ops = {
 	.resume	= umwait_syscore_resume,
 };
 
+static void umwait_control_msr_update(void *unused)
+{
+	update_this_cpu_umwait_control_msr();
+}
+
+static u32 get_umwait_ctrl_c02(void)
+{
+	return READ_ONCE(umwait_control_cached) & MSR_IA32_UMWAIT_CONTROL_C02_DISABLED;
+}
+
+static u32 get_umwait_ctrl_max_time(void)
+{
+	return READ_ONCE(umwait_control_cached) & MSR_IA32_UMWAIT_CONTROL_MAX_TIME;
+}
+
+static ssize_t
+enable_c02_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	 /*
+	  * When bit 0 in IA32_UMWAIT_CONTROL MSR is 1, C0.2 is disabled.
+	  * Otherwise, C0.2 is enabled. Show the opposite of bit 0.
+	  */
+	return sprintf(buf, "%d\n", !(bool)get_umwait_ctrl_c02());
+}
+
+static ssize_t enable_c02_store(struct device *dev,
+				struct device_attribute *attr,
+				const char *buf, size_t count)
+{
+	u32 umwait_c02;
+	bool c02_enabled;
+	int ret;
+
+	ret = kstrtobool(buf, &c02_enabled);
+	if (ret)
+		return ret;
+
+	mutex_lock(&umwait_lock);
+
+	/*
+	 * The value of bit 0 in IA32_UMWAIT_CONTROL MSR is opposite of
+	 * c02_enabled.
+	 */
+	umwait_c02 = (u32)!c02_enabled;
+	if (umwait_c02 == get_umwait_ctrl_c02())
+		goto out_unlock;
+
+	WRITE_ONCE(umwait_control_cached,
+		   UMWAIT_CTRL_VAL(get_umwait_ctrl_max_time(), umwait_c02));
+	/* Enable/disable C0.2 state on all CPUs */
+	on_each_cpu(umwait_control_msr_update, NULL, 1);
+
+out_unlock:
+	mutex_unlock(&umwait_lock);
+
+	return count;
+}
+static DEVICE_ATTR_RW(enable_c02);
+
+static struct attribute *umwait_attrs[] = {
+	&dev_attr_enable_c02.attr,
+	NULL
+};
+
+static struct attribute_group umwait_attr_group = {
+	.attrs = umwait_attrs,
+	.name = "umwait_control",
+};
+
 static int __init umwait_init(void)
 {
+	struct device *dev;
 	int ret;
 
 	if (!boot_cpu_has(X86_FEATURE_WAITPKG))
 		return -ENODEV;
 
+	/* Add umwait control interface. */
+	dev = cpu_subsys.dev_root;
+	ret = sysfs_create_group(&dev->kobj, &umwait_attr_group);
+	if (ret)
+		return ret;
+
 	ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "umwait/intel:online",
 				umwait_cpu_online, NULL);
-	if (ret < 0)
+	if (ret < 0) {
+		sysfs_remove_group(&dev->kobj, &umwait_attr_group);
+
 		return ret;
+	}
 
 	register_syscore_ops(&umwait_syscore_ops);
 
-- 
2.19.1

