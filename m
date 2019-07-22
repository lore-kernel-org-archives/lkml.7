Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53BA2C76188
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 07:59:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BCCB21BF6
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 07:59:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="wOJxCxgk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727892AbfGVH7S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 03:59:18 -0400
Received: from terminus.zytor.com ([198.137.202.136]:49091 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726595AbfGVH7S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 03:59:18 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6M7wu903731236
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 22 Jul 2019 00:58:56 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6M7wu903731236
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1563782336;
        bh=CzzuaM5KTsTa7pGd4DpJrQnLe4uNu9wxHmOTODrybJU=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=wOJxCxgkyV2CxI3FtNObDvSYGtZ0OQeGrkZ77Tg8EJYsD0MAhT6/cxVE5UjVfj3UB
         PRlCD94AvmAQ8JQcbDu1H64HuloakJhoyIgzzBOh3l4PFxSLUqSrpz21sqBhVWNyKa
         YUeaYKW9Bqas1sbPXNEoJ7YWnzYfJgg4zc0bDzlAIU74XKzfADmeobtYglZYZsIzDW
         +j15QNWLRWS8/fxNkPGK8iPQvxuJBY/1U9a7unSxio7uASDfbbABtTCUrADDt6VEEu
         YOZ0uxV3/acTZBSdAzlRvvAie/ZDuOSPLwzUcJHBornOpsLMwc2o9BdXLAkNz2ACpH
         TIKKiaINmngiw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6M7wteL3731225;
        Mon, 22 Jul 2019 00:58:55 -0700
Date:   Mon, 22 Jul 2019 00:58:55 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-3f70915f5be935a145d11b5f46a26627066b6261@git.kernel.org>
Cc:     mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org,
        mingo@kernel.org, tglx@linutronix.de, hpa@zytor.com
Reply-To: mingo@kernel.org, linux-kernel@vger.kernel.org,
          mathieu.desnoyers@efficios.com, tglx@linutronix.de, hpa@zytor.com
In-Reply-To: <alpine.DEB.2.21.1907091622590.1634@nanos.tec.linutronix.de>
References: <alpine.DEB.2.21.1907091622590.1634@nanos.tec.linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:smp/hotplug] cpu/hotplug: Cache number of online CPUs
Git-Commit-ID: 3f70915f5be935a145d11b5f46a26627066b6261
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

Commit-ID:  3f70915f5be935a145d11b5f46a26627066b6261
Gitweb:     https://git.kernel.org/tip/3f70915f5be935a145d11b5f46a26627066b6261
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Tue, 9 Jul 2019 16:23:40 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Mon, 22 Jul 2019 09:52:21 +0200

cpu/hotplug: Cache number of online CPUs

Re-evaluating the bitmap wheight of the online cpus bitmap in every
invocation of num_online_cpus() over and over is a pretty useless
exercise. Especially when num_online_cpus() is used in code paths
like the IPI delivery of x86 or the membarrier code.

Cache the number of online CPUs in the core and just return the cached
variable. The accessor function provides only a snapshot when used without
protection against concurrent CPU hotplug.

The storage needs to use an atomic_t because the kexec and reboot code
(ab)use set_cpu_online() in their 'shutdown' handlers without any form of
serialization as pointed out by Mathieu. Regular CPU hotplug usage is
properly serialized.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Link: https://lkml.kernel.org/r/alpine.DEB.2.21.1907091622590.1634@nanos.tec.linutronix.de

---
 include/linux/cpumask.h | 25 ++++++++++++++++---------
 kernel/cpu.c            | 24 ++++++++++++++++++++++++
 2 files changed, 40 insertions(+), 9 deletions(-)

diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
index 21755471b1c3..fdd627dbfa3a 100644
--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -10,6 +10,7 @@
 #include <linux/kernel.h>
 #include <linux/threads.h>
 #include <linux/bitmap.h>
+#include <linux/atomic.h>
 #include <linux/bug.h>
 
 /* Don't assign or return these: may not be this big! */
@@ -95,8 +96,21 @@ extern struct cpumask __cpu_active_mask;
 #define cpu_present_mask  ((const struct cpumask *)&__cpu_present_mask)
 #define cpu_active_mask   ((const struct cpumask *)&__cpu_active_mask)
 
+extern atomic_t __num_online_cpus;
+
 #if NR_CPUS > 1
-#define num_online_cpus()	cpumask_weight(cpu_online_mask)
+/**
+ * num_online_cpus() - Read the number of online CPUs
+ *
+ * Despite the fact that __num_online_cpus is of type atomic_t, this
+ * interface gives only a momentary snapshot and is not protected against
+ * concurrent CPU hotplug operations unless invoked from a cpuhp_lock held
+ * region.
+ */
+static inline unsigned int num_online_cpus(void)
+{
+	return atomic_read(&__num_online_cpus);
+}
 #define num_possible_cpus()	cpumask_weight(cpu_possible_mask)
 #define num_present_cpus()	cpumask_weight(cpu_present_mask)
 #define num_active_cpus()	cpumask_weight(cpu_active_mask)
@@ -805,14 +819,7 @@ set_cpu_present(unsigned int cpu, bool present)
 		cpumask_clear_cpu(cpu, &__cpu_present_mask);
 }
 
-static inline void
-set_cpu_online(unsigned int cpu, bool online)
-{
-	if (online)
-		cpumask_set_cpu(cpu, &__cpu_online_mask);
-	else
-		cpumask_clear_cpu(cpu, &__cpu_online_mask);
-}
+void set_cpu_online(unsigned int cpu, bool online);
 
 static inline void
 set_cpu_active(unsigned int cpu, bool active)
diff --git a/kernel/cpu.c b/kernel/cpu.c
index e84c0873559e..3bf9881a3be5 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -2295,6 +2295,9 @@ EXPORT_SYMBOL(__cpu_present_mask);
 struct cpumask __cpu_active_mask __read_mostly;
 EXPORT_SYMBOL(__cpu_active_mask);
 
+atomic_t __num_online_cpus __read_mostly;
+EXPORT_SYMBOL(__num_online_cpus);
+
 void init_cpu_present(const struct cpumask *src)
 {
 	cpumask_copy(&__cpu_present_mask, src);
@@ -2310,6 +2313,27 @@ void init_cpu_online(const struct cpumask *src)
 	cpumask_copy(&__cpu_online_mask, src);
 }
 
+void set_cpu_online(unsigned int cpu, bool online)
+{
+	/*
+	 * atomic_inc/dec() is required to handle the horrid abuse of this
+	 * function by the reboot and kexec code which invoke it from
+	 * IPI/NMI broadcasts when shutting down CPUs. Invocation from
+	 * regular CPU hotplug is properly serialized.
+	 *
+	 * Note, that the fact that __num_online_cpus is of type atomic_t
+	 * does not protect readers which are not serialized against
+	 * concurrent hotplug operations.
+	 */
+	if (online) {
+		if (!cpumask_test_and_set_cpu(cpu, &__cpu_online_mask))
+			atomic_inc(&__num_online_cpus);
+	} else {
+		if (cpumask_test_and_clear_cpu(cpu, &__cpu_online_mask))
+			atomic_dec(&__num_online_cpus);
+	}
+}
+
 /*
  * Activate the first processor.
  */
