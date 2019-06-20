Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A97DCC43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 01:44:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CB49214AF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 01:44:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731282AbfFTBoE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 21:44:04 -0400
Received: from mga01.intel.com ([192.55.52.88]:60109 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731193AbfFTBnv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 21:43:51 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Jun 2019 18:43:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,394,1557212400"; 
   d="scan'208";a="243484929"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by orsmga001.jf.intel.com with ESMTP; 19 Jun 2019 18:43:50 -0700
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
Subject: [PATCH v5 4/5] x86/umwait: Add sysfs interface to control umwait maximum time
Date:   Wed, 19 Jun 2019 18:33:57 -0700
Message-Id: <1560994438-235698-5-git-send-email-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1560994438-235698-1-git-send-email-fenghua.yu@intel.com>
References: <1560994438-235698-1-git-send-email-fenghua.yu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IA32_UMWAIT_CONTROL[31:2] determines the maximum time in TSC-quanta
that processor can stay in C0.1 or C0.2. A zero value means no maximum
time.

Each instruction sets its own deadline in the instruction's implicit
input EDX:EAX value. The instruction wakes up if the time-stamp counter
reaches or exceeds the specified deadline, or the umwait maximum time
expires, or a store happens in the monitored address range in umwait.

Users can write an unsigned 32-bit number to
/sys/devices/system/cpu/umwait_control/max_time to change the default
value. Note that a value of zero means there is no limit. Low order
two bits must be zero.

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Reviewed-by: Ashok Raj <ashok.raj@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/kernel/cpu/umwait.c | 40 ++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/x86/kernel/cpu/umwait.c b/arch/x86/kernel/cpu/umwait.c
index 3bd6d37a7b2c..4b2aff7b2d4d 100644
--- a/arch/x86/kernel/cpu/umwait.c
+++ b/arch/x86/kernel/cpu/umwait.c
@@ -126,8 +126,48 @@ static ssize_t enable_c02_store(struct device *dev,
 }
 static DEVICE_ATTR_RW(enable_c02);
 
+static ssize_t
+max_time_show(struct device *kobj, struct device_attribute *attr, char *buf)
+{
+	return sprintf(buf, "%u\n", get_umwait_ctrl_max_time());
+}
+
+static ssize_t max_time_store(struct device *kobj,
+			      struct device_attribute *attr,
+			      const char *buf, size_t count)
+{
+	u32 max_time;
+	int ret;
+
+	ret = kstrtou32(buf, 0, &max_time);
+	if (ret)
+		return ret;
+
+	/* bits[1:0] must be zero */
+	if (max_time & ~MSR_IA32_UMWAIT_CONTROL_MAX_TIME)
+		return -EINVAL;
+
+	mutex_lock(&umwait_lock);
+
+	if (max_time == get_umwait_ctrl_max_time())
+		goto out_unlock;
+
+	WRITE_ONCE(umwait_control_cached,
+		   UMWAIT_CTRL_VAL(max_time, get_umwait_ctrl_c02()));
+
+	/* Update umwait max time on all CPUs */
+	on_each_cpu(umwait_control_msr_update, NULL, 1);
+
+out_unlock:
+	mutex_unlock(&umwait_lock);
+
+	return count;
+}
+static DEVICE_ATTR_RW(max_time);
+
 static struct attribute *umwait_attrs[] = {
 	&dev_attr_enable_c02.attr,
+	&dev_attr_max_time.attr,
 	NULL
 };
 
-- 
2.19.1

