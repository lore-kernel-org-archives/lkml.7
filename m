Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D37D8C31E5C
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 02:41:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B07B72085A
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 02:41:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727540AbfFRCly (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 22:41:54 -0400
Received: from mga02.intel.com ([134.134.136.20]:9457 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725870AbfFRCly (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 22:41:54 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Jun 2019 19:41:53 -0700
X-ExtLoop1: 1
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by fmsmga006.fm.intel.com with ESMTP; 17 Jun 2019 19:41:53 -0700
Date:   Mon, 17 Jun 2019 19:32:22 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: Re: [PATCH v4 3/5] x86/umwait: Add sysfs interface to control umwait
 C0.2 state
Message-ID: <20190618023222.GI217081@romley-ivt3.sc.intel.com>
References: <20190610035302.GA162238@romley-ivt3.sc.intel.com>
 <CALCETrUSpk+_FDaPpA3a-duajUdF8kOK64AQJjsr7Pm0Gi04OA@mail.gmail.com>
 <20190610060234.GD162238@romley-ivt3.sc.intel.com>
 <F021B947-90E9-450A-9196-531B7EE965F1@amacapital.net>
 <20190617202702.GB217081@romley-ivt3.sc.intel.com>
 <CALCETrVENokx8VUCxdUzGeMA2oMOZ0kHRiP_O0KygyrAhf07Rg@mail.gmail.com>
 <20190617231104.GF217081@romley-ivt3.sc.intel.com>
 <CALCETrXpB+3TjHacjfUZK6pu_L54upe+JHKKRs4x1HaHOeGbzA@mail.gmail.com>
 <20190618000014.GH217081@romley-ivt3.sc.intel.com>
 <CALCETrUqPC5wzg9vUUHuUCYv-FeJdxPbe2t2F4_-9jauijeT1Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrUqPC5wzg9vUUHuUCYv-FeJdxPbe2t2F4_-9jauijeT1Q@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 17, 2019 at 05:19:02PM -0700, Andy Lutomirski wrote:
> On Mon, Jun 17, 2019 at 5:09 PM Fenghua Yu <fenghua.yu@intel.com> wrote:
> But you're already using a mutex and a comment.  And you're hoping
> that the syscore resume callback reads something sensible despite the
> lack of READ_ONCE / WRITE_ONCE.  The compiler is unlikely to butcher
> this too badly, but still.

You are right, syscore_resume will be wrong if suspend in middle of
sysfs writing.

Ok. I change this patch based on your proposed locking. Is this patch
right? Should I use WRITE_ONCE/READ_ONCE on each access of
umwait_control_cached?

Thanks.

-Fenghua

diff --git a/arch/x86/power/umwait.c b/arch/x86/power/umwait.c
index 9594af9f657e..d17572605c1a 100644
--- a/arch/x86/power/umwait.c
+++ b/arch/x86/power/umwait.c
@@ -11,10 +11,34 @@
  */
 static u32 umwait_control_cached = 100000 & ~MSR_IA32_UMWAIT_CONTROL_C02_DISABLED;
 
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
@@ -30,24 +54,102 @@ static int umwait_cpu_online(unsigned int cpu)
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
+static u32 get_umwait_control_c02(void)
+{
+	return READ_ONCE(umwait_control_cached) & MSR_IA32_UMWAIT_CONTROL_C02_DISABLED;
+}
+
+static u32 get_umwait_control_max_time(void)
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
+	WRITE_ONCE(umwait_control_cached, umwait_control_c02 | get_umwait_control_max_time());
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


