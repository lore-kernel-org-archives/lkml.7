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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82928C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 00:43:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 526AC2086D
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 00:43:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="upp295eE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbfF1AnU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 20:43:20 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:34824 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726579AbfF1AnT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 20:43:19 -0400
Received: by mail-pl1-f193.google.com with SMTP id w24so2203721plp.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2019 17:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=XK5NFZh7pG1K+u3GPFcGObWPOefyWYFPM8I5XfkBG/8=;
        b=upp295eE4zrZ2rfDBy6cAlytz9+pNGthZTHLKTr1OO9dTOiMZf6JwjuEq8ekcHwklm
         cZv7vb8Oym6r76qlAR2DGFlE+Fbgscpula7GgOLKLeBbiFxjKOlKf23bv6QUIvRVWaHE
         Ea+r/DyVrIdjoJq+E65Gw199EVyBXO2RUkgTDAb6ac+RO8yV6feWGc6NCWESOj4QnZ+6
         wxVgJDAGElxaJAHNExlL90/amJQsDPcePEhhadmUwuhv9YNJvTpqQWp/tp7mCG/2hSjS
         b/Zb6zy2r9GhjEZ8w8H3xBiCMMbqthMSoge28/XS+uZd9P1/BJZP4YQ0MGL2gbG8GElv
         DoPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=XK5NFZh7pG1K+u3GPFcGObWPOefyWYFPM8I5XfkBG/8=;
        b=pCYNhtpDZmyG2w8gicLTFCqtROKa95I27aTD4QS2QGf9KstgohyIET0V/EsruKZuqk
         MEUItpRa9GSdpt4Oq5AKlhe5/OjRTk9kMAp7+Yc+qXRak4WoBNiWMuZ0L5ZYpdDuI2aJ
         Rm9AIOQJexnjtCi8fMs7+/jMGFtmSO8pB4736S1sUDEr4riaPFtA6RYzs4RMZvEIKmeZ
         j8IIRmCF3R6OS+noOM0tV2QJhYpaSCN2HUbCrDLkzIabEwXUuyfE+GrA2Uzr+m5Tx9tG
         Bc60dGOVYHXM8x32W7fHC3iHQ/xHw6yASWnpGSDr+LeeuGZAMng+WiIQ8TJTVvK+sTNr
         5dTQ==
X-Gm-Message-State: APjAAAV5GUlN1XThNezL0Ll1uJLEJOnmX2YA7kvulCQYLeBYQ5OZE6nP
        Ocz/z0AkOXzP++Z1rKPaR2fbpfclEj4=
X-Google-Smtp-Source: APXvYqxegHsYVbbcs7Qa6pW5xQvySaMtUe0xaNM73KyiAwlrJT2OfQixsRUUai9jwK7wPOKdbdO+NA==
X-Received: by 2002:a17:902:7b84:: with SMTP id w4mr7879007pll.22.1561682598960;
        Thu, 27 Jun 2019 17:43:18 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.123])
        by smtp.googlemail.com with ESMTPSA id n89sm11927802pjc.0.2019.06.27.17.43.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 27 Jun 2019 17:43:18 -0700 (PDT)
From:   Wanpeng Li <kernellwp@gmail.com>
X-Google-Original-From: Wanpeng Li <wanpengli@tencent.com>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v2] sched/nohz: Optimize get_nohz_timer_target()
Date:   Fri, 28 Jun 2019 08:43:12 +0800
Message-Id: <1561682593-12071-1-git-send-email-wanpengli@tencent.com>
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

