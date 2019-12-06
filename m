Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EC7FC43603
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 14:38:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BE0420706
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 14:38:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726328AbfLFOiu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 09:38:50 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:49562 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726195AbfLFOiu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 09:38:50 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 13E2F424AEAD2B2EE89B;
        Fri,  6 Dec 2019 22:38:42 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.439.0; Fri, 6 Dec 2019 22:38:34 +0800
From:   John Garry <john.garry@huawei.com>
To:     <tglx@linutronix.de>
CC:     <chenxiang66@hisilicon.com>, <bigeasy@linutronix.de>,
        <linux-kernel@vger.kernel.org>, <maz@kernel.org>, <hare@suse.com>,
        <ming.lei@redhat.com>, <hch@lst.de>, <axboe@kernel.dk>,
        <bvanassche@acm.org>, <peterz@infradead.org>, <mingo@redhat.com>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH RFC 1/1] genirq: Make threaded handler use irq affinity for managed interrupt
Date:   Fri, 6 Dec 2019 22:35:04 +0800
Message-ID: <1575642904-58295-2-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1575642904-58295-1-git-send-email-john.garry@huawei.com>
References: <1575642904-58295-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the cpu allowed mask for the threaded part of a threaded irq
handler will be set to the effective affinity of the hard irq.

Typically the effective affinity of the hard irq will be for a single cpu. As such,
the threaded handler would always run on the same cpu as the hard irq.

We have seen scenarios in high data-rate throughput testing that the cpu
handling the interrupt can be totally saturated handling both the hard
interrupt and threaded handler parts, limiting throughput.

For when the interrupt is managed, allow the threaded part to run on all
cpus in the irq affinity mask.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 kernel/irq/manage.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 1753486b440c..8e7f8e758a88 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -968,7 +968,11 @@ irq_thread_check_affinity(struct irq_desc *desc, struct irqaction *action)
 	if (cpumask_available(desc->irq_common_data.affinity)) {
 		const struct cpumask *m;
 
-		m = irq_data_get_effective_affinity_mask(&desc->irq_data);
+		if (irqd_affinity_is_managed(&desc->irq_data))
+			m = desc->irq_common_data.affinity;
+		else
+			m = irq_data_get_effective_affinity_mask(
+					&desc->irq_data);
 		cpumask_copy(mask, m);
 	} else {
 		valid = false;
-- 
2.17.1

