Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66833C49ED9
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 02:35:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4788F222BD
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 02:35:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726756AbfIKCfL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 22:35:11 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2206 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726703AbfIKCfK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 22:35:10 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id D20B835A5F6E36408028;
        Wed, 11 Sep 2019 10:35:06 +0800 (CST)
Received: from HGHY2Y004646261.china.huawei.com (10.184.12.158) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.439.0; Wed, 11 Sep 2019 10:34:59 +0800
From:   Zenghui Yu <yuzenghui@huawei.com>
To:     <maz@kernel.org>, <james.morse@arm.com>,
        <julien.thierry.kdev@gmail.com>, <suzuki.poulose@arm.com>
CC:     <kvmarm@lists.cs.columbia.edu>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <wanghaibin.wang@huawei.com>,
        Zenghui Yu <yuzenghui@huawei.com>
Subject: [PATCH 2/2] KVM: arm/arm64: Print the EC hex value with its exact width
Date:   Wed, 11 Sep 2019 02:33:36 +0000
Message-ID: <1568169216-12632-3-git-send-email-yuzenghui@huawei.com>
X-Mailer: git-send-email 2.6.4.windows.1
In-Reply-To: <1568169216-12632-1-git-send-email-yuzenghui@huawei.com>
References: <1568169216-12632-1-git-send-email-yuzenghui@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.184.12.158]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

EC is the bits [31:26] of ESR_ELx on arm64 (HSR on arm). Print the
hex value with its exact width (8).

Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
---
 virt/kvm/arm/trace.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/virt/kvm/arm/trace.h b/virt/kvm/arm/trace.h
index 204d210d01c2..022b0a060034 100644
--- a/virt/kvm/arm/trace.h
+++ b/virt/kvm/arm/trace.h
@@ -42,7 +42,7 @@ TRACE_EVENT(kvm_exit,
 		__entry->vcpu_pc		= vcpu_pc;
 	),
 
-	TP_printk("%s: HSR_EC: 0x%04x (%s), PC: 0x%08lx",
+	TP_printk("%s: HSR_EC: 0x%02x (%s), PC: 0x%08lx",
 		  __print_symbolic(__entry->ret, kvm_arm_exception_type),
 		  __entry->esr_ec,
 		  __print_symbolic(__entry->esr_ec, kvm_arm_exception_class),
-- 
2.19.1


