Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDB68C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:27:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBCB020836
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:27:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551688078;
	bh=RNe4baonLWuMO5KYV8SbSF73kRxzIolx7gsTF4nxbv4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=T+byoZRC7EPh3X6uBD3hM3w26KsHpRNgeyKR9eN6yNrhnkIPSKbamRVeE+hKVWscp
	 w+TjBP1qCZHFK7SlUjnoElFhXfnHCMN4KwG+6i0sB1dqMlD9V7p+0g8eUO65IoFcCH
	 RdM75syiQrQzrafgxucpJM6X5EpKhbk/5rJbImwQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727337AbfCDI15 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 03:27:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:52420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727325AbfCDI1y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 03:27:54 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 070FC20823;
        Mon,  4 Mar 2019 08:27:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551688073;
        bh=RNe4baonLWuMO5KYV8SbSF73kRxzIolx7gsTF4nxbv4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bYRm7lJm9Gkv6LVdfAW8srSB1lG0xWZdqhOff//0Rs+Qjq85+ALKliuVgSZ5u7YGr
         6OYndnD9m21n99aeK4Eqlvv1fOZXiGCL+qGE9Z/2u5KmdX5nwhl5jTELinNC/QUJM6
         boMYrzFuouohQJvkQCJawBhV6Yz4c7S8wPWtxxSU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dou Liyang <douly.fnst@cn.fujitsu.com>,
        Thomas Gleixner <tglx@linutronix.de>, hpa@zytor.com,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 01/78] irq/matrix: Split out the CPU selection code into a helper
Date:   Mon,  4 Mar 2019 09:21:44 +0100
Message-Id: <20190304081625.570790978@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190304081625.508788074@linuxfoundation.org>
References: <20190304081625.508788074@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 8ffe4e61c06a48324cfd97f1199bb9838acce2f2 ]

Linux finds the CPU which has the lowest vector allocation count to spread
out the non managed interrupts across the possible target CPUs, but does
not do so for managed interrupts.

Split out the CPU selection code into a helper function for reuse. No
functional change.

Signed-off-by: Dou Liyang <douly.fnst@cn.fujitsu.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: hpa@zytor.com
Link: https://lkml.kernel.org/r/20180908175838.14450-1-dou_liyang@163.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/irq/matrix.c |   65 ++++++++++++++++++++++++++++++----------------------
 1 file changed, 38 insertions(+), 27 deletions(-)

--- a/kernel/irq/matrix.c
+++ b/kernel/irq/matrix.c
@@ -124,6 +124,27 @@ static unsigned int matrix_alloc_area(st
 	return area;
 }
 
+/* Find the best CPU which has the lowest vector allocation count */
+static unsigned int matrix_find_best_cpu(struct irq_matrix *m,
+					const struct cpumask *msk)
+{
+	unsigned int cpu, best_cpu, maxavl = 0;
+	struct cpumap *cm;
+
+	best_cpu = UINT_MAX;
+
+	for_each_cpu(cpu, msk) {
+		cm = per_cpu_ptr(m->maps, cpu);
+
+		if (!cm->online || cm->available <= maxavl)
+			continue;
+
+		best_cpu = cpu;
+		maxavl = cm->available;
+	}
+	return best_cpu;
+}
+
 /**
  * irq_matrix_assign_system - Assign system wide entry in the matrix
  * @m:		Matrix pointer
@@ -322,37 +343,27 @@ void irq_matrix_remove_reserved(struct i
 int irq_matrix_alloc(struct irq_matrix *m, const struct cpumask *msk,
 		     bool reserved, unsigned int *mapped_cpu)
 {
-	unsigned int cpu, best_cpu, maxavl = 0;
+	unsigned int cpu, bit;
 	struct cpumap *cm;
-	unsigned int bit;
 
-	best_cpu = UINT_MAX;
-	for_each_cpu(cpu, msk) {
-		cm = per_cpu_ptr(m->maps, cpu);
-
-		if (!cm->online || cm->available <= maxavl)
-			continue;
+	cpu = matrix_find_best_cpu(m, msk);
+	if (cpu == UINT_MAX)
+		return -ENOSPC;
 
-		best_cpu = cpu;
-		maxavl = cm->available;
-	}
+	cm = per_cpu_ptr(m->maps, cpu);
+	bit = matrix_alloc_area(m, cm, 1, false);
+	if (bit >= m->alloc_end)
+		return -ENOSPC;
+	cm->allocated++;
+	cm->available--;
+	m->total_allocated++;
+	m->global_available--;
+	if (reserved)
+		m->global_reserved--;
+	*mapped_cpu = cpu;
+	trace_irq_matrix_alloc(bit, cpu, m, cm);
+	return bit;
 
-	if (maxavl) {
-		cm = per_cpu_ptr(m->maps, best_cpu);
-		bit = matrix_alloc_area(m, cm, 1, false);
-		if (bit < m->alloc_end) {
-			cm->allocated++;
-			cm->available--;
-			m->total_allocated++;
-			m->global_available--;
-			if (reserved)
-				m->global_reserved--;
-			*mapped_cpu = best_cpu;
-			trace_irq_matrix_alloc(bit, best_cpu, m, cm);
-			return bit;
-		}
-	}
-	return -ENOSPC;
 }
 
 /**


