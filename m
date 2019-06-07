Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E05DC2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 22:10:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C852207E0
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 22:10:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731581AbfFGWKV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 18:10:21 -0400
Received: from mga06.intel.com ([134.134.136.31]:58792 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727213AbfFGWKF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 18:10:05 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Jun 2019 15:10:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,564,1557212400"; 
   d="scan'208";a="182814107"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by fmsmga002.fm.intel.com with ESMTP; 07 Jun 2019 15:10:03 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        "H Peter Anvin" <hpa@zytor.com>,
        "Andy Lutomirski" <luto@kernel.org>,
        "Ashok Raj" <ashok.raj@intel.com>,
        "Tony Luck" <tony.luck@intel.com>,
        "Ravi V Shankar" <ravi.v.shankar@intel.com>
Cc:     "linux-kernel" <linux-kernel@vger.kernel.org>,
        "x86" <x86@kernel.org>, Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH v4 3/5] x86/umwait: Add sysfs interface to control umwait C0.2 state
Date:   Fri,  7 Jun 2019 15:00:35 -0700
Message-Id: <1559944837-149589-4-git-send-email-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1559944837-149589-1-git-send-email-fenghua.yu@intel.com>
References: <1559944837-149589-1-git-send-email-fenghua.yu@intel.com>
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

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Reviewed-by: Ashok Raj <ashok.raj@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/power/umwait.c | 89 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 88 insertions(+), 1 deletion(-)

diff --git a/arch/x86/power/umwait.c b/arch/x86/power/umwait.c
index 23151e77c138..9c176f3e59b6 100644
--- a/arch/x86/power/umwait.c
+++ b/arch/x86/power/umwait.c
@@ -11,10 +11,18 @@
  */
 static u32 umwait_control_cached = 100000;
 
+/*
+ * Serialize access to umwait_control_cached and IA32_UMWAIT_CONTROL MSR
+ * to guarantee all CPUs have the same MSR value.
+ */
+static DEFINE_MUTEX(umwait_lock);
+
 /* Set up IA32_UMWAIT_CONTROL MSR on CPU using the current global setting. */
 static int umwait_cpu_online(unsigned int cpu)
 {
+	mutex_lock(&umwait_lock);
 	wrmsr(MSR_IA32_UMWAIT_CONTROL, umwait_control_cached, 0);
+	mutex_unlock(&umwait_lock);
 
 	return 0;
 }
@@ -30,6 +38,7 @@ static int umwait_cpu_online(unsigned int cpu)
  */
 static void umwait_syscore_resume(void)
 {
+	/* No need to lock because only BP is running now. */
 	wrmsr(MSR_IA32_UMWAIT_CONTROL, umwait_control_cached, 0);
 }
 
@@ -37,17 +46,95 @@ static struct syscore_ops umwait_syscore_ops = {
 	.resume	= umwait_syscore_resume,
 };
 
+static void umwait_control_msr_update(void *unused)
+{
+	wrmsr(MSR_IA32_UMWAIT_CONTROL, umwait_control_cached, 0);
+}
+
+static u32 get_umwait_control_c02(void)
+{
+	return umwait_control_cached & MSR_IA32_UMWAIT_CONTROL_C02;
+}
+
+static u32 get_umwait_control_max_time(void)
+{
+	return umwait_control_cached & MSR_IA32_UMWAIT_CONTROL_MAX_TIME;
+}
+
+static ssize_t
+enable_c02_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	 /*
+	  * When bit 0 in IA32_UMWAIT_CONTROL MSR is 1, C0.2 is disabled.
+	  * Otherwise, C0.2 is enabled. Show the opposite of bit 0.
+	  */
+	return sprintf(buf, "%d\n", !(bool)get_umwait_control_c02());
+}
+
+static ssize_t enable_c02_store(struct device *dev,
+				struct device_attribute *attr,
+				const char *buf, size_t count)
+{
+	u32 umwait_control_c02;
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
+	umwait_control_c02 = (u32)!c02_enabled;
+	if (umwait_control_c02 == get_umwait_control_c02())
+		goto out_unlock;
+
+	umwait_control_cached = umwait_control_c02 | get_umwait_control_max_time();
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

