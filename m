Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8295CC04AAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 14:49:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FCAF20815
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 14:49:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="GdKjPMDs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727331AbfEPOtq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 10:49:46 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:40636 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726736AbfEPOtq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 10:49:46 -0400
Received: by mail-lf1-f67.google.com with SMTP id h13so2871205lfc.7
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2019 07:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qjZQlCzu2t8W/LkwSwB00HBVAWZggkqa93LRrf5NZtI=;
        b=GdKjPMDsSoATJWP1Ia9+PMcmTBa33BHAggYE60cJYtN6Qp1uM5d3dIfuwgo1u2C8EZ
         761KUdU0gfNj0OV+KHjQyRxgP8OgmnoU4gBjhozqT3zDagSllIu5XtnV6VOZuiWsoMp0
         hTwDkFk2GdKqWOv0Uhi4XUpLPjUvMB2UePiz0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qjZQlCzu2t8W/LkwSwB00HBVAWZggkqa93LRrf5NZtI=;
        b=nVn+hv3bJ26oO8C+fXFvn2jh7oZjyvt6Nh97aWApTfbiW0ZOSVKwGErl+JIz7hiCnj
         Dh0mHuTUr/z0EBRAQuOcLi2XcnsKrMn1Zw6pCeh6lLUGmXiBpM0rovjtHtyugVLEUfL3
         ok7iazswLbxT5EtbOYstmGAyAAwFWeHFDXAyJgJr9u06rwQ0a3BkjLMiPlm9Lckfp7s0
         IBtA/BjDwbhBJUXoG1fduywP0NrQMPDusakZoKG21C9j9tN6mbvUD0l8qSyaOqpKSLCC
         GxkchsgwYgETm0jfSd5XrJk/b3z8qVsngp5kprZ0kpPzxRra3EVMCgZcpxaDWs0WpdSf
         7wpg==
X-Gm-Message-State: APjAAAWJZoMraPomW4i1ROzPBhrBbbaUQAknoPwoNfKM1Ti3oLPsrqDy
        EMTEJzJehmqUm4fa3NjhMfwM8Q==
X-Google-Smtp-Source: APXvYqwj+mkrjgz1L4n4rgTNCZbk6GiCuZORoZzW1Y1erkuGOKZSEqlpMY8+9g/v5bVsQDLDy/Iwyw==
X-Received: by 2002:ac2:4d07:: with SMTP id r7mr8819441lfi.142.1558018183530;
        Thu, 16 May 2019 07:49:43 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id h10sm1058445ljm.9.2019.05.16.07.49.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 May 2019 07:49:42 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] RFC: genirq: allow userspace to set default priority of irq threads
Date:   Thu, 16 May 2019 16:49:37 +0200
Message-Id: <20190516144937.20101-1-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On -rt kernels, it is sometimes desirable to be able to prioritize
some hardware interrupts over others, i.e. being able to set the
priorities of the irq threads different from the default of 50. While
chrt(1) can be used after the threads are created, there are at least
two problems with that: (1) threads are created and destroyed as
devices are brought up and down, making it necessary to continuously
monitor /proc for new irq threads, leading to (2) a device may run for
a while with its irq thread(s) at the wrong priority.

This is just a quick POC to start some discussion. Probably the
locking is all wrong. But this at least gives userspace a way
of assigning a priority to a specific hardware interrupt by
matching on the chip_name and hwirq - unfortunately, chip_name is not
necessarily unique, so it doesn't work for all cases.

This would probably be a better fit in /proc alongside the affinity
settings, but the problem with that is that the /proc entries don't
exist until __setup_irq() is called the first time. [Btw, why are
the sysfs files dependent on CONFIG_SPARSE_IRQ?]

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 include/linux/irqdesc.h |  2 ++
 kernel/irq/irqdesc.c    | 57 +++++++++++++++++++++++++++++++++++++++++
 kernel/irq/manage.c     | 11 ++++----
 3 files changed, 64 insertions(+), 6 deletions(-)

diff --git a/include/linux/irqdesc.h b/include/linux/irqdesc.h
index d6e2ab538ef2..29cf7ff99cf3 100644
--- a/include/linux/irqdesc.h
+++ b/include/linux/irqdesc.h
@@ -5,6 +5,7 @@
 #include <linux/rcupdate.h>
 #include <linux/kobject.h>
 #include <linux/mutex.h>
+#include <uapi/linux/sched/types.h>
 
 /*
  * Core internal functions to deal with irq descriptors
@@ -106,6 +107,7 @@ struct irq_desc {
 	int			parent_irq;
 	struct module		*owner;
 	const char		*name;
+	struct sched_param	sched_param;
 } ____cacheline_internodealigned_in_smp;
 
 #ifdef CONFIG_SPARSE_IRQ
diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index c52b737ab8e3..42f72bf6f046 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -125,6 +125,7 @@ static void desc_set_defaults(unsigned int irq, struct irq_desc *desc, int node,
 	for_each_possible_cpu(cpu)
 		*per_cpu_ptr(desc->kstat_irqs, cpu) = 0;
 	desc_smp_init(desc, node, affinity);
+	desc->sched_param.sched_priority = MAX_USER_RT_PRIO/2;
 }
 
 int nr_irqs = NR_IRQS;
@@ -143,6 +144,9 @@ static struct kobject *irq_kobj_base;
 #define IRQ_ATTR_RO(_name) \
 static struct kobj_attribute _name##_attr = __ATTR_RO(_name)
 
+#define IRQ_ATTR_RW(_name) \
+static struct kobj_attribute _name##_attr = __ATTR_RW(_name)
+
 static ssize_t per_cpu_count_show(struct kobject *kobj,
 				  struct kobj_attribute *attr, char *buf)
 {
@@ -265,6 +269,58 @@ static ssize_t actions_show(struct kobject *kobj,
 }
 IRQ_ATTR_RO(actions);
 
+static ssize_t prio_show(struct kobject *kobj,
+			 struct kobj_attribute *attr, char *buf)
+{
+	struct irq_desc *desc = container_of(kobj, struct irq_desc, kobj);
+	int prio;
+
+	mutex_lock(&desc->request_mutex);
+	prio = desc->sched_param.sched_priority;
+	mutex_unlock(&desc->request_mutex);
+
+	return scnprintf(buf, PAGE_SIZE, "%d\n", prio);
+}
+
+static ssize_t prio_store(struct kobject *kobj, struct kobj_attribute *attr,
+			  const char *buf, size_t n)
+{
+	struct irq_desc *desc = container_of(kobj, struct irq_desc, kobj);
+	struct task_struct *thread;
+	struct irqaction *action;
+	ssize_t ret;
+	int prio;
+
+	ret = kstrtoint(buf, 10, &prio);
+	if (ret)
+		return ret;
+	if (prio < 1 || prio > MAX_USER_RT_PRIO - 1)
+		return -ERANGE;
+
+	mutex_lock(&desc->request_mutex);
+
+	desc->sched_param.sched_priority = prio;
+	for (action = desc->action; action; action = action->next) {
+		struct sched_param sp = desc->sched_param;
+
+		thread = action->thread;
+		if (thread)
+			sched_setscheduler_nocheck(thread, SCHED_FIFO, &sp);
+		if (action->secondary) {
+			thread = action->secondary->thread;
+			if (thread) {
+				sp.sched_priority -= 1;
+				sched_setscheduler_nocheck(thread, SCHED_FIFO, &sp);
+			}
+		}
+	}
+
+	mutex_unlock(&desc->request_mutex);
+
+	return n;
+}
+IRQ_ATTR_RW(prio);
+
 static struct attribute *irq_attrs[] = {
 	&per_cpu_count_attr.attr,
 	&chip_name_attr.attr,
@@ -273,6 +329,7 @@ static struct attribute *irq_attrs[] = {
 	&wakeup_attr.attr,
 	&name_attr.attr,
 	&actions_attr.attr,
+	&prio_attr.attr,
 	NULL
 };
 ATTRIBUTE_GROUPS(irq);
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 78f3ddeb7fe4..a915c5128211 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -1203,12 +1203,11 @@ static void irq_nmi_teardown(struct irq_desc *desc)
 }
 
 static int
-setup_irq_thread(struct irqaction *new, unsigned int irq, bool secondary)
+setup_irq_thread(struct irqaction *new, struct irq_desc *desc, bool secondary)
 {
+	struct sched_param param = desc->sched_param;
+	unsigned int irq = irq_desc_get_irq(desc);
 	struct task_struct *t;
-	struct sched_param param = {
-		.sched_priority = MAX_USER_RT_PRIO/2,
-	};
 
 	if (!secondary) {
 		t = kthread_create(irq_thread, new, "irq/%d-%s", irq,
@@ -1312,11 +1311,11 @@ __setup_irq(unsigned int irq, struct irq_desc *desc, struct irqaction *new)
 	 * thread.
 	 */
 	if (new->thread_fn && !nested) {
-		ret = setup_irq_thread(new, irq, false);
+		ret = setup_irq_thread(new, desc, false);
 		if (ret)
 			goto out_mput;
 		if (new->secondary) {
-			ret = setup_irq_thread(new->secondary, irq, true);
+			ret = setup_irq_thread(new->secondary, desc, true);
 			if (ret)
 				goto out_thread;
 		}
-- 
2.20.1

