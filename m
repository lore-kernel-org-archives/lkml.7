Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C807C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 08:51:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 003E32133F
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 08:51:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QOFKgChJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726606AbfF1Ivr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 04:51:47 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44165 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726505AbfF1Ivr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 04:51:47 -0400
Received: by mail-pg1-f194.google.com with SMTP id n2so2279451pgp.11
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2019 01:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=fJTmrCokXbjmZFp/LR2WwicDJ0KtvnswEsVLYTi/oZE=;
        b=QOFKgChJ22QqPS5WE1mjZWteERr9V/4D6CcVGPxaGxMCwA4xs2zFhPLADc6G2EP/LY
         08pzDrbHA3RU7rqWA2UgMUt3WHhhMJYirapVNWeFoHVPbO80ftKX9E3WxP3BHOEzN5Kr
         RFqbtvNwMgb3G0m01RaCllCkXfUdXo0Rw/zI32PwV9m8D4TfR2EQLQ1S09YonkXGwztz
         pHOt3CMuqvgDkLuw5fh9IyHduK0OwwbXRdtStDILmS4/rIB8YyW+KY5qfIjInHch22YX
         gwUepfr/tseMZtNKyn+xBku6xd4e//5QL1KBJLy41o9NRSMj7WwtzbgQtf9AfCJKsaMD
         8n7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=fJTmrCokXbjmZFp/LR2WwicDJ0KtvnswEsVLYTi/oZE=;
        b=S11ofGgWwNaglyDlw66dJwm0pn+XHzaNAU2wJxVIxnYHk8ufj/W1UNeIS11+PyhtXC
         ghU82lO02ssm337Gz71QynaTkxnvI6z9LaD4FCfSUlJUTyucK6iq/UhUitPHBXIa8fcB
         UP8E9qmaAxPFhWgOUoB7B7ZATDtxgkS+kRy7cOsVx6vDPQLlB/A3rs56jCTsl/zISUQY
         5XQBCEi2BqU1Nv7fa3dJo9OTsPsjwxm0edNLhjqael1FkP+nhnnZWPNVBJTR67YXJpuk
         14FiTELOSZthyUAhIRthaTuHvSihWkiosJRg9YYFlnXEPdXNHK6vPekBruWbFRDNvZoM
         MzEA==
X-Gm-Message-State: APjAAAV7uw/JH0aKolofQDC8dboWUl82Cp7eG2hp9/5IZ/Fr1M9yPNED
        Ij+Vgwjh5xPGVts00w02jAIIFgRCjF4=
X-Google-Smtp-Source: APXvYqxqxqMX1LqlhpdxC+q/I3LSwqRPRKQ3mC7Ff3+t6JhmHcmmc8Ekw/mOLP54CKTp9C4NAXh13g==
X-Received: by 2002:a63:4103:: with SMTP id o3mr8155006pga.385.1561711906345;
        Fri, 28 Jun 2019 01:51:46 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.123])
        by smtp.googlemail.com with ESMTPSA id 27sm1344076pgt.6.2019.06.28.01.51.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 28 Jun 2019 01:51:45 -0700 (PDT)
From:   Wanpeng Li <kernellwp@gmail.com>
X-Google-Original-From: Wanpeng Li <wanpengli@tencent.com>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v4 2/2] sched/nohz: Optimize get_nohz_timer_target()
Date:   Fri, 28 Jun 2019 16:51:40 +0800
Message-Id: <1561711901-4755-1-git-send-email-wanpengli@tencent.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wanpeng Li <wanpengli@tencent.com>

On a machine, cpu 0 is used for housekeeping, the other 39 cpus in the 
same socket are in nohz_full mode. We can observe huge time burn in the 
loop for seaching nearest busy housekeeper cpu by ftrace.

  2)               |       get_nohz_timer_target() {
  2)   0.240 us    |         housekeeping_test_cpu();
  2)   0.458 us    |         housekeeping_test_cpu();

  ...

  2)   0.292 us    |         housekeeping_test_cpu();
  2)   0.240 us    |         housekeeping_test_cpu();
  2)   0.227 us    |         housekeeping_any_cpu();
  2) + 43.460 us   |       }
  
This patch optimizes the searching logic by finding a nearest housekeeper
cpu in the housekeeping cpumask, it can minimize the worst searching time 
from ~44us to < 10us in my testing. In addition, the last iterated busy 
housekeeper can become a random candidate while current CPU is a better 
fallback if it is a housekeeper.

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com> 
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Frederic Weisbecker <frederic@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
---
v1 -> v2:
 * current CPU is a better fallback if it is a housekeeper

 kernel/sched/core.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 102dfcf..04a0f6a 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -539,27 +539,32 @@ void resched_cpu(int cpu)
  */
 int get_nohz_timer_target(void)
 {
-	int i, cpu = smp_processor_id();
+	int i, cpu = smp_processor_id(), default_cpu = -1;
 	struct sched_domain *sd;
 
-	if (!idle_cpu(cpu) && housekeeping_cpu(cpu, HK_FLAG_TIMER))
-		return cpu;
+	if (housekeeping_cpu(cpu, HK_FLAG_TIMER)) {
+		if (!idle_cpu(cpu))
+			return cpu;
+		default_cpu = cpu;
+	}
 
 	rcu_read_lock();
 	for_each_domain(cpu, sd) {
-		for_each_cpu(i, sched_domain_span(sd)) {
+		for_each_cpu_and(i, sched_domain_span(sd),
+			housekeeping_cpumask(HK_FLAG_TIMER)) {
 			if (cpu == i)
 				continue;
 
-			if (!idle_cpu(i) && housekeeping_cpu(i, HK_FLAG_TIMER)) {
+			if (!idle_cpu(i)) {
 				cpu = i;
 				goto unlock;
 			}
 		}
 	}
 
-	if (!housekeeping_cpu(cpu, HK_FLAG_TIMER))
-		cpu = housekeeping_any_cpu(HK_FLAG_TIMER);
+	if (default_cpu == -1)
+		default_cpu = housekeeping_any_cpu(HK_FLAG_TIMER);
+	cpu = default_cpu;
 unlock:
 	rcu_read_unlock();
 	return cpu;
-- 
1.8.3.1

