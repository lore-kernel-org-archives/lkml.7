Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49961C48BE4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 01:42:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FDE522CF4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 01:42:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="owJTfDKF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726503AbfFXBkx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Jun 2019 21:40:53 -0400
Received: from terminus.zytor.com ([198.137.202.136]:51211 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726399AbfFXBkw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jun 2019 21:40:52 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5O03Hlu2861852
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sun, 23 Jun 2019 17:03:17 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5O03Hlu2861852
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1561334598;
        bh=+18Ntd0kE6dvp136tT6pwfJGGmQfcDsEk531Ot6zEhQ=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=owJTfDKFojYlabt2eYFt/+S0EqL8E/bPTpg7iG5np0HT9zdpcEFNuqTJOadDR15M0
         JtfzmYBqR1tnWmPg4Foj5njZqvVilEtt5IM+YcTBTBlGNb5VZFpqTRCzekIJbvclas
         L3JdWijsios9F0NKLKngGJp5kxQRzWoqeirr1KmkEAHHz6M6lUWe8BsIyRHWz1z0iC
         /ASX+oPEEUuQat2qUn2FH0JF5QKDnJfhf/QaPvADKdv//kTwc55tYTvTvNyuNrR05n
         QZ3+2Up4UzXUk8i3LmntlKHE04ErRnYzMK3Gu88EWwBqUbjW3bE6JA5WqaGx6sGCh1
         rVcs7gRu6WF9Q==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5O03HOp2861849;
        Sun, 23 Jun 2019 17:03:17 -0700
Date:   Sun, 23 Jun 2019 17:03:17 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Fenghua Yu <tipbot@zytor.com>
Message-ID: <tip-bd9a0c97e53c3d7a56b2751179903ddc5da42683@git.kernel.org>
Cc:     ravi.v.shankar@intel.com, hpa@zytor.com, mingo@kernel.org,
        bp@alien8.de, luto@kernel.org, fenghua.yu@intel.com,
        ashok.raj@intel.com, tony.luck@intel.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de
Reply-To: peterz@infradead.org, tglx@linutronix.de, bp@alien8.de,
          linux-kernel@vger.kernel.org, tony.luck@intel.com,
          ashok.raj@intel.com, hpa@zytor.com, mingo@kernel.org,
          ravi.v.shankar@intel.com, luto@kernel.org, fenghua.yu@intel.com
In-Reply-To: <1560994438-235698-5-git-send-email-fenghua.yu@intel.com>
References: <1560994438-235698-5-git-send-email-fenghua.yu@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/cpu] x86/umwait: Add sysfs interface to control umwait
 maximum time
Git-Commit-ID: bd9a0c97e53c3d7a56b2751179903ddc5da42683
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

Commit-ID:  bd9a0c97e53c3d7a56b2751179903ddc5da42683
Gitweb:     https://git.kernel.org/tip/bd9a0c97e53c3d7a56b2751179903ddc5da42683
Author:     Fenghua Yu <fenghua.yu@intel.com>
AuthorDate: Wed, 19 Jun 2019 18:33:57 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Mon, 24 Jun 2019 01:44:20 +0200

x86/umwait: Add sysfs interface to control umwait maximum time

IA32_UMWAIT_CONTROL[31:2] determines the maximum time in TSC-quanta
that processor can stay in C0.1 or C0.2. A zero value means no maximum
time.

Each instruction sets its own deadline in the instruction's implicit
input EDX:EAX value. The instruction wakes up if the time-stamp counter
reaches or exceeds the specified deadline, or the umwait maximum time
expires, or a store happens in the monitored address range in umwait.

The administrator can write an unsigned 32-bit number to
/sys/devices/system/cpu/umwait_control/max_time to change the default
value. Note that a value of zero means there is no limit. The lower two
bits of the value must be zero.

[ tglx: Simplify the write function. Massage changelog ]

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Ashok Raj <ashok.raj@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Cc: "Borislav Petkov" <bp@alien8.de>
Cc: "H Peter Anvin" <hpa@zytor.com>
Cc: "Andy Lutomirski" <luto@kernel.org>
Cc: "Peter Zijlstra" <peterz@infradead.org>
Cc: "Ravi V Shankar" <ravi.v.shankar@intel.com>
Link: https://lkml.kernel.org/r/1560994438-235698-5-git-send-email-fenghua.yu@intel.com

---
 arch/x86/kernel/cpu/umwait.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/x86/kernel/cpu/umwait.c b/arch/x86/kernel/cpu/umwait.c
index 56149d630e35..6a204e7336c1 100644
--- a/arch/x86/kernel/cpu/umwait.c
+++ b/arch/x86/kernel/cpu/umwait.c
@@ -131,8 +131,44 @@ static ssize_t enable_c02_store(struct device *dev,
 }
 static DEVICE_ATTR_RW(enable_c02);
 
+static ssize_t
+max_time_show(struct device *kobj, struct device_attribute *attr, char *buf)
+{
+	u32 ctrl = READ_ONCE(umwait_control_cached);
+
+	return sprintf(buf, "%u\n", umwait_ctrl_max_time(ctrl));
+}
+
+static ssize_t max_time_store(struct device *kobj,
+			      struct device_attribute *attr,
+			      const char *buf, size_t count)
+{
+	u32 max_time, ctrl;
+	int ret;
+
+	ret = kstrtou32(buf, 0, &max_time);
+	if (ret)
+		return ret;
+
+	/* bits[1:0] must be zero */
+	if (max_time & ~MSR_IA32_UMWAIT_CONTROL_TIME_MASK)
+		return -EINVAL;
+
+	mutex_lock(&umwait_lock);
+
+	ctrl = READ_ONCE(umwait_control_cached);
+	if (max_time != umwait_ctrl_max_time(ctrl))
+		umwait_update_control(max_time, umwait_ctrl_c02_enabled(ctrl));
+
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
 
