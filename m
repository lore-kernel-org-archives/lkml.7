Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99EA5C3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 16:40:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7289F206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 16:40:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732953AbfHZQkh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 12:40:37 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:60288 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732900AbfHZQkg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 12:40:36 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 52465C224D703FD301BC;
        Tue, 27 Aug 2019 00:40:29 +0800 (CST)
Received: from linux-lLwqrf.huawei.com (10.175.104.237) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.439.0; Tue, 27 Aug 2019 00:40:20 +0800
From:   Heyi Guo <guoheyi@huawei.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        <kvmarm@lists.cs.columbia.edu>, <linux-kernel@vger.kernel.org>
CC:     <wanghaibin.wang@huawei.com>, Heyi Guo <guoheyi@huawei.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        "Suzuki K Poulose" <suzuki.poulose@arm.com>
Subject: [PATCH] kvm/arm/vgic: fix potential deadlock when ap_list is long
Date:   Tue, 27 Aug 2019 00:39:12 +0800
Message-ID: <1566837552-127854-1-git-send-email-guoheyi@huawei.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.104.237]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If ap_list is longer than 256, merge_final() in sort_list() will call
comparison function with the same element just as below:

    do {
        /*
         * If the merge is highly unbalanced (e.g. the input is
         * already sorted), this loop may run many iterations.
         * Continue callbacks to the client even though no
         * element comparison is needed, so the client's cmp()
         * routine can invoke cond_resched() periodically.
         */
        if (unlikely(!++count))
            cmp(priv, b, b);

This will definitely cause deadlock in vgic_irq_cmp() and the call trace
is:

[ 2667.130283] Call trace:
[ 2667.130284] queued_spin_lock_slowpath+0x64/0x2a8
[ 2667.130284] vgic_irq_cmp+0xfc/0x130
[ 2667.130284] list_sort.part.0+0x1c0/0x268
[ 2667.130285] list_sort+0x18/0x28
[ 2667.130285] vgic_flush_lr_state+0x158/0x518
[ 2667.130285] kvm_vgic_flush_hwstate+0x70/0x108
[ 2667.130286] kvm_arch_vcpu_ioctl_run+0x114/0xa50
[ 2667.130286] kvm_vcpu_ioctl+0x490/0x8c8
[ 2667.130286] do_vfs_ioctl+0xc4/0x8c0
[ 2667.130287] ksys_ioctl+0x8c/0xa0
[ 2667.130287] __arm64_sys_ioctl+0x28/0x38
[ 2667.130287] el0_svc_common+0x78/0x130
[ 2667.130288] el0_svc_handler+0x38/0x78
[ 2667.130288] el0_svc+0x8/0xc

So return 0 immediately when a==b.

Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
Signed-off-by: Heyi Guo <guoheyi@huawei.com>
Cc: Marc Zyngier <maz@kernel.org>
Cc: James Morse <james.morse@arm.com>
Cc: Julien Thierry <julien.thierry.kdev@gmail.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 virt/kvm/arm/vgic/vgic.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/virt/kvm/arm/vgic/vgic.c b/virt/kvm/arm/vgic/vgic.c
index 13d4b38..64ed0dc 100644
--- a/virt/kvm/arm/vgic/vgic.c
+++ b/virt/kvm/arm/vgic/vgic.c
@@ -254,6 +254,13 @@ static int vgic_irq_cmp(void *priv, struct list_head *a, struct list_head *b)
 	bool penda, pendb;
 	int ret;
 
+	/*
+	 * list_sort may call this function with the same element when the list
+	 * is farely long.
+	 */
+	if (unlikely(a == b))
+		return 0;
+
 	raw_spin_lock(&irqa->irq_lock);
 	raw_spin_lock_nested(&irqb->irq_lock, SINGLE_DEPTH_NESTING);
 
-- 
1.8.3.1

