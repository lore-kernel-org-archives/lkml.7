Return-Path: <SRS0=wu79=TZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28E9FC282E1
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 00:05:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05C432184E
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 00:05:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726474AbfEYAF1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 20:05:27 -0400
Received: from mga01.intel.com ([192.55.52.88]:36240 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725996AbfEYAFR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 20:05:17 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 May 2019 17:05:16 -0700
X-ExtLoop1: 1
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by orsmga005.jf.intel.com with ESMTP; 24 May 2019 17:05:16 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        "H Peter Anvin" <hpa@zytor.com>,
        "Andy Lutomirski" <luto@amacapital.net>,
        "Andrew Cooper" <andrew.cooper3@citrix.com>,
        "Ashok Raj" <ashok.raj@intel.com>,
        "Tony Luck" <tony.luck@intel.com>,
        "Ravi V Shankar" <ravi.v.shankar@intel.com>
Cc:     "linux-kernel" <linux-kernel@vger.kernel.org>,
        "x86" <x86@kernel.org>, Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH v3 3/5] x86/umwait: Add sysfs interface to control umwait C0.2 state
Date:   Fri, 24 May 2019 16:56:00 -0700
Message-Id: <1558742162-73402-4-git-send-email-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1558742162-73402-1-git-send-email-fenghua.yu@intel.com>
References: <1558742162-73402-1-git-send-email-fenghua.yu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

C0.2 state in umwait and tpause instructions can be enabled or disabled
on a processor through IA32_UMWAIT_CONTROL MSR register.

By default, C0.2 is enabled and the user wait instructions result in
lower power consumption with slower wakeup time.

But in real time systems which requrie faster wakeup time although power
savings could be smaller, the administrator needs to disable C0.2 and all
C0.2 requests from user applications revert to C0.1.

A sysfs interface "/sys/devices/system/cpu/umwait_control/enable_c0_2" is
created to allow the administrator to control C0.2 state during run time.

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Reviewed-by: Ashok Raj <ashok.raj@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/power/umwait.c | 75 ++++++++++++++++++++++++++++++++++++++---
 1 file changed, 71 insertions(+), 4 deletions(-)

diff --git a/arch/x86/power/umwait.c b/arch/x86/power/umwait.c
index 80cc53a9c2d0..cf5de7e1cc24 100644
--- a/arch/x86/power/umwait.c
+++ b/arch/x86/power/umwait.c
@@ -7,6 +7,7 @@
 static bool umwait_c0_2_enabled = true;
 /* Umwait max time is in TSC-quanta. Bits[1:0] are zero. */
 static u32 umwait_max_time = 100000;
+static DEFINE_MUTEX(umwait_lock);
 
 /* Return value that will be used to set IA32_UMWAIT_CONTROL MSR */
 static u32 umwait_compute_msr_value(void)
@@ -22,7 +23,7 @@ static u32 umwait_compute_msr_value(void)
 	       (umwait_max_time & MSR_IA32_UMWAIT_CONTROL_MAX_TIME);
 }
 
-static void umwait_control_msr_update(void)
+static void umwait_control_msr_update(void *unused)
 {
 	u32 msr_val;
 
@@ -33,7 +34,9 @@ static void umwait_control_msr_update(void)
 /* Set up IA32_UMWAIT_CONTROL MSR on CPU using the current global setting. */
 static int umwait_cpu_online(unsigned int cpu)
 {
-	umwait_control_msr_update();
+	mutex_lock(&umwait_lock);
+	umwait_control_msr_update(NULL);
+	mutex_unlock(&umwait_lock);
 
 	return 0;
 }
@@ -49,24 +52,88 @@ static int umwait_cpu_online(unsigned int cpu)
  */
 static void umwait_syscore_resume(void)
 {
-	umwait_control_msr_update();
+	/* No need to lock because only BP is running now. */
+	umwait_control_msr_update(NULL);
 }
 
 static struct syscore_ops umwait_syscore_ops = {
 	.resume	= umwait_syscore_resume,
 };
 
+static ssize_t
+enable_c0_2_show(struct device *dev, struct device_attribute *attr,
+		 char *buf)
+{
+	return sprintf(buf, "%d\n", umwait_c0_2_enabled);
+}
+
+static void umwait_control_msr_update_all_cpus(void)
+{
+	u32 msr_val;
+
+	msr_val = umwait_compute_msr_value();
+	/* All CPUs have same umwait control setting */
+	on_each_cpu(umwait_control_msr_update, NULL, 1);
+}
+
+static ssize_t enable_c0_2_store(struct device *dev,
+				 struct device_attribute *attr,
+				 const char *buf, size_t count)
+{
+	bool c0_2_enabled;
+	int ret;
+
+	ret = kstrtobool(buf, &c0_2_enabled);
+	if (ret)
+		return ret;
+
+	mutex_lock(&umwait_lock);
+
+	if (umwait_c0_2_enabled == c0_2_enabled)
+		goto out_unlock;
+
+	umwait_c0_2_enabled = c0_2_enabled;
+	/* Enable/disable C0.2 state on all CPUs */
+	umwait_control_msr_update_all_cpus();
+
+out_unlock:
+	mutex_unlock(&umwait_lock);
+
+	return count;
+}
+static DEVICE_ATTR_RW(enable_c0_2);
+
+static struct attribute *umwait_attrs[] = {
+	&dev_attr_enable_c0_2.attr,
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

