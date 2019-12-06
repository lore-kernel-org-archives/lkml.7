Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B84E7C43603
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 02:54:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DC3C2173E
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 02:54:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbfLFCyW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 21:54:22 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:51760 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726242AbfLFCyK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 21:54:10 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id CA5636AB5C36FC74BA5A;
        Fri,  6 Dec 2019 10:54:07 +0800 (CST)
Received: from huawei.com (10.175.105.18) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.439.0; Fri, 6 Dec 2019
 10:54:00 +0800
From:   linmiaohe <linmiaohe@huawei.com>
To:     <pbonzini@redhat.com>, <alex.williamson@redhat.com>
CC:     <linmiaohe@huawei.com>, <kvm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] KVM: lib: use jump label to handle resource release in irq_bypass_register_producer()
Date:   Fri, 6 Dec 2019 10:53:53 +0800
Message-ID: <1575600833-12839-3-git-send-email-linmiaohe@huawei.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1575600833-12839-1-git-send-email-linmiaohe@huawei.com>
References: <1575600833-12839-1-git-send-email-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.105.18]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Miaohe Lin <linmiaohe@huawei.com>

Use out_err jump label to handle resource release. It's a
good practice to release resource in one place and help
eliminate some duplicated code.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 virt/lib/irqbypass.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/virt/lib/irqbypass.c b/virt/lib/irqbypass.c
index cb0c801b3bc2..28fda42e471b 100644
--- a/virt/lib/irqbypass.c
+++ b/virt/lib/irqbypass.c
@@ -85,6 +85,7 @@ int irq_bypass_register_producer(struct irq_bypass_producer *producer)
 {
 	struct irq_bypass_producer *tmp;
 	struct irq_bypass_consumer *consumer;
+	int ret;
 
 	if (!producer->token)
 		return -EINVAL;
@@ -98,20 +99,16 @@ int irq_bypass_register_producer(struct irq_bypass_producer *producer)
 
 	list_for_each_entry(tmp, &producers, node) {
 		if (tmp->token == producer->token) {
-			mutex_unlock(&lock);
-			module_put(THIS_MODULE);
-			return -EBUSY;
+			ret = -EBUSY;
+			goto out_err;
 		}
 	}
 
 	list_for_each_entry(consumer, &consumers, node) {
 		if (consumer->token == producer->token) {
-			int ret = __connect(producer, consumer);
-			if (ret) {
-				mutex_unlock(&lock);
-				module_put(THIS_MODULE);
-				return ret;
-			}
+			ret = __connect(producer, consumer);
+			if (ret)
+				goto out_err;
 			break;
 		}
 	}
@@ -121,6 +118,10 @@ int irq_bypass_register_producer(struct irq_bypass_producer *producer)
 	mutex_unlock(&lock);
 
 	return 0;
+out_err:
+	mutex_unlock(&lock);
+	module_put(THIS_MODULE);
+	return ret;
 }
 EXPORT_SYMBOL_GPL(irq_bypass_register_producer);
 
-- 
2.19.1

