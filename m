Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C779CCA9EA0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 03:23:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F2B8207FC
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 03:23:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732582AbfJWDXJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 23:23:09 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:53690 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727140AbfJWDXJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 23:23:09 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 962BE2CD66F9CF476FA8;
        Wed, 23 Oct 2019 11:23:05 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.439.0; Wed, 23 Oct 2019 11:22:59 +0800
From:   Mao Wenan <maowenan@huawei.com>
To:     <maz@kernel.org>, <james.morse@arm.com>,
        <julien.thierry.kdev@gmail.com>, <suzuki.poulose@arm.com>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <steven.price@arm.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <kvmarm@lists.cs.columbia.edu>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>, Mao Wenan <maowenan@huawei.com>
Subject: [PATCH] KVM: arm64: Select SCHED_INFO before SCHEDSTATS
Date:   Wed, 23 Oct 2019 11:22:54 +0800
Message-ID: <20191023032254.159510-1-maowenan@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If KVM=y, it will select SCHEDSTATS, below erros can
be seen:
kernel/sched/stats.h: In function rq_sched_info_arrive:
kernel/sched/stats.h:12:20: error: struct sched_info
has no member named run_delay
   rq->rq_sched_info.run_delay += delta;
                    ^
kernel/sched/stats.h:13:20: error: struct sched_info
has no member named pcount
   rq->rq_sched_info.pcount++;
                    ^
kernel/sched/stats.h: In function rq_sched_info_dequeued:
kernel/sched/stats.h:31:20: error: struct sched_info has
no member named run_delay
   rq->rq_sched_info.run_delay += delta;

These are because CONFIG_SCHED_INFO is not set, This patch 
is to select SCHED_INFO before SCHEDSTATS.

Fixes: 8564d6372a7d ("KVM: arm64: Support stolen time reporting via shared structure")
Signed-off-by: Mao Wenan <maowenan@huawei.com>
---
 arch/arm64/kvm/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/kvm/Kconfig b/arch/arm64/kvm/Kconfig
index d8b88e4..3c46eac 100644
--- a/arch/arm64/kvm/Kconfig
+++ b/arch/arm64/kvm/Kconfig
@@ -39,6 +39,7 @@ config KVM
 	select IRQ_BYPASS_MANAGER
 	select HAVE_KVM_IRQ_BYPASS
 	select HAVE_KVM_VCPU_RUN_PID_CHANGE
+	select SCHED_INFO
 	select SCHEDSTATS
 	---help---
 	  Support hosting virtualized guest machines.
-- 
2.7.4

