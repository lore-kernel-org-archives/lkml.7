Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A1B7C48BE4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 01:42:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9CFF22CF4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 01:42:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="cnnlY5N8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726985AbfFXBmV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Jun 2019 21:42:21 -0400
Received: from terminus.zytor.com ([198.137.202.136]:51211 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726480AbfFXBkx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jun 2019 21:40:53 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5O02ZCb2861575
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sun, 23 Jun 2019 17:02:35 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5O02ZCb2861575
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1561334555;
        bh=JZSeG1u5h0T0nprNh99y6oUWMwodjBXaBR6Vp8PAKLc=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=cnnlY5N8lhFpoemtosdxT9dprvrrTAnIW+8inmECX+rozkrSAmw2djM8OjCh3/UgU
         jI5jGOqp7PrQM4m9GLgkQ8S1TVM2hvEisu/Zq0ugVfOyuDB5D6XtXdOit7hocefcTL
         6y25tPvMBgQRdCFhimrl1Y5h0BaLOtrAjYCApk+E+VMAXR0d9QIc8ckoAJ/30sRuuA
         zRIi1nPPooRMxOsHiI+iCBT9jIfrfQp7NErUswuQdRJ71fAcoOow9jz8egSHepLwQY
         6at6E65Cm9T9eqdAcnoWdXRV7sUXPUv7yuDei6SQyznCIUfIT2YQ89xmQBnAtbIyKv
         X6xhNdn2b5HwA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5O02Y2m2861572;
        Sun, 23 Jun 2019 17:02:34 -0700
Date:   Sun, 23 Jun 2019 17:02:34 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Fenghua Yu <tipbot@zytor.com>
Message-ID: <tip-ff4b353f2ef9dc8e396d7cb9572801e34a8c7374@git.kernel.org>
Cc:     peterz@infradead.org, mingo@kernel.org, tglx@linutronix.de,
        tony.luck@intel.com, ravi.v.shankar@intel.com, bp@alien8.de,
        fenghua.yu@intel.com, hpa@zytor.com, linux-kernel@vger.kernel.org,
        luto@kernel.org, ashok.raj@intel.com
Reply-To: linux-kernel@vger.kernel.org, ravi.v.shankar@intel.com,
          tony.luck@intel.com, mingo@kernel.org, peterz@infradead.org,
          ashok.raj@intel.com, luto@kernel.org, fenghua.yu@intel.com,
          hpa@zytor.com, bp@alien8.de, tglx@linutronix.de
In-Reply-To: <1560994438-235698-4-git-send-email-fenghua.yu@intel.com>
References: <1560994438-235698-4-git-send-email-fenghua.yu@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/cpu] x86/umwait: Add sysfs interface to control umwait
 C0.2 state
Git-Commit-ID: ff4b353f2ef9dc8e396d7cb9572801e34a8c7374
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

Commit-ID:  ff4b353f2ef9dc8e396d7cb9572801e34a8c7374
Gitweb:     https://git.kernel.org/tip/ff4b353f2ef9dc8e396d7cb9572801e34a8c7374
Author:     Fenghua Yu <fenghua.yu@intel.com>
AuthorDate: Wed, 19 Jun 2019 18:33:56 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Mon, 24 Jun 2019 01:44:20 +0200

x86/umwait: Add sysfs interface to control umwait C0.2 state

C0.2 state in umwait and tpause instructions can be enabled or disabled
on a processor through IA32_UMWAIT_CONTROL MSR register.

By default, C0.2 is enabled and the user wait instructions results in
lower power consumption with slower wakeup time.

But in real time systems which require faster wakeup time although power
savings could be smaller, the administrator needs to disable C0.2 and all
umwait invocations from user applications use C0.1.

Create a sysfs interface which allows the administrator to control C0.2
state during run time.

Andy Lutomirski suggested to turn off local irqs before writing the MSR to
ensure the cached control value is not changed by a concurrent sysfs write
from a different CPU via IPI.

[ tglx: Simplified the update logic in the write function and got rid of
  	all the convoluted type casts. Added a shared update function and
	made the namespace consistent. Moved the sysfs create invocation.
	Massaged changelog ]

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Ashok Raj <ashok.raj@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Cc: "Borislav Petkov" <bp@alien8.de>
Cc: "H Peter Anvin" <hpa@zytor.com>
Cc: "Andy Lutomirski" <luto@kernel.org>
Cc: "Peter Zijlstra" <peterz@infradead.org>
Cc: "Ravi V Shankar" <ravi.v.shankar@intel.com>
Link: https://lkml.kernel.org/r/1560994438-235698-4-git-send-email-fenghua.yu@intel.com

---
 arch/x86/kernel/cpu/umwait.c | 118 ++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 110 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kernel/cpu/umwait.c b/arch/x86/kernel/cpu/umwait.c
index 0a113c731df3..56149d630e35 100644
--- a/arch/x86/kernel/cpu/umwait.c
+++ b/arch/x86/kernel/cpu/umwait.c
@@ -7,8 +7,8 @@
 
 #define UMWAIT_C02_ENABLE	0
 
-#define UMWAIT_CTRL_VAL(maxtime, c02_disable)				\
-	(((maxtime) & MSR_IA32_UMWAIT_CONTROL_TIME_MASK) |		\
+#define UMWAIT_CTRL_VAL(max_time, c02_disable)				\
+	(((max_time) & MSR_IA32_UMWAIT_CONTROL_TIME_MASK) |		\
 	((c02_disable) & MSR_IA32_UMWAIT_CONTROL_C02_DISABLE))
 
 /*
@@ -17,10 +17,38 @@
  */
 static u32 umwait_control_cached = UMWAIT_CTRL_VAL(100000, UMWAIT_C02_ENABLE);
 
-/* Set IA32_UMWAIT_CONTROL MSR on this CPU to the current global setting. */
+/*
+ * Serialize access to umwait_control_cached and IA32_UMWAIT_CONTROL MSR in
+ * the sysfs write functions.
+ */
+static DEFINE_MUTEX(umwait_lock);
+
+static void umwait_update_control_msr(void * unused)
+{
+	lockdep_assert_irqs_disabled();
+	wrmsr(MSR_IA32_UMWAIT_CONTROL, READ_ONCE(umwait_control_cached), 0);
+}
+
+/*
+ * The CPU hotplug callback sets the control MSR to the global control
+ * value.
+ *
+ * Disable interrupts so the read of umwait_control_cached and the WRMSR
+ * are protected against a concurrent sysfs write. Otherwise the sysfs
+ * write could update the cached value after it had been read on this CPU
+ * and issue the IPI before the old value had been written. The IPI would
+ * interrupt, write the new value and after return from IPI the previous
+ * value would be written by this CPU.
+ *
+ * With interrupts disabled the upcoming CPU either sees the new control
+ * value or the IPI is updating this CPU to the new control value after
+ * interrupts have been reenabled.
+ */
 static int umwait_cpu_online(unsigned int cpu)
 {
-	wrmsr(MSR_IA32_UMWAIT_CONTROL, umwait_control_cached, 0);
+	local_irq_disable();
+	umwait_update_control_msr(NULL);
+	local_irq_enable();
 	return 0;
 }
 
@@ -36,15 +64,86 @@ static int umwait_cpu_online(unsigned int cpu)
  */
 static void umwait_syscore_resume(void)
 {
-	wrmsr(MSR_IA32_UMWAIT_CONTROL, umwait_control_cached, 0);
+	umwait_update_control_msr(NULL);
 }
 
 static struct syscore_ops umwait_syscore_ops = {
 	.resume	= umwait_syscore_resume,
 };
 
+/* sysfs interface */
+
+/*
+ * When bit 0 in IA32_UMWAIT_CONTROL MSR is 1, C0.2 is disabled.
+ * Otherwise, C0.2 is enabled.
+ */
+static inline bool umwait_ctrl_c02_enabled(u32 ctrl)
+{
+	return !(ctrl & MSR_IA32_UMWAIT_CONTROL_C02_DISABLE);
+}
+
+static inline u32 umwait_ctrl_max_time(u32 ctrl)
+{
+	return ctrl & MSR_IA32_UMWAIT_CONTROL_TIME_MASK;
+}
+
+static inline void umwait_update_control(u32 maxtime, bool c02_enable)
+{
+	u32 ctrl = maxtime & MSR_IA32_UMWAIT_CONTROL_TIME_MASK;
+
+	if (!c02_enable)
+		ctrl |= MSR_IA32_UMWAIT_CONTROL_C02_DISABLE;
+
+	WRITE_ONCE(umwait_control_cached, ctrl);
+	/* Propagate to all CPUs */
+	on_each_cpu(umwait_update_control_msr, NULL, 1);
+}
+
+static ssize_t
+enable_c02_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	u32 ctrl = READ_ONCE(umwait_control_cached);
+
+	return sprintf(buf, "%d\n", umwait_ctrl_c02_enabled(ctrl));
+}
+
+static ssize_t enable_c02_store(struct device *dev,
+				struct device_attribute *attr,
+				const char *buf, size_t count)
+{
+	bool c02_enable;
+	u32 ctrl;
+	int ret;
+
+	ret = kstrtobool(buf, &c02_enable);
+	if (ret)
+		return ret;
+
+	mutex_lock(&umwait_lock);
+
+	ctrl = READ_ONCE(umwait_control_cached);
+	if (c02_enable != umwait_ctrl_c02_enabled(ctrl))
+		umwait_update_control(ctrl, c02_enable);
+
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
@@ -52,11 +151,14 @@ static int __init umwait_init(void)
 
 	ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "umwait:online",
 				umwait_cpu_online, NULL);
-	if (ret < 0)
-		return ret;
 
 	register_syscore_ops(&umwait_syscore_ops);
 
-	return 0;
+	/*
+	 * Add umwait control interface. Ignore failure, so at least the
+	 * default values are set up in case the machine manages to boot.
+	 */
+	dev = cpu_subsys.dev_root;
+	return sysfs_create_group(&dev->kobj, &umwait_attr_group);
 }
 device_initcall(umwait_init);
