Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F0AFCA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 08:52:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C410206C2
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 08:52:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727170AbfJUIw1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 04:52:27 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:4739 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726181AbfJUIw0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 04:52:26 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 85CC1A26E84D34BABAC3;
        Mon, 21 Oct 2019 16:52:24 +0800 (CST)
Received: from huawei.com (10.175.105.18) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.439.0; Mon, 21 Oct 2019
 16:52:14 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <pbonzini@redhat.com>, <rkrcmar@redhat.com>,
        <sean.j.christopherson@intel.com>, <vkuznets@redhat.com>,
        <wanpengli@tencent.com>, <jmattson@google.com>, <joro@8bytes.org>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <hpa@zytor.com>
CC:     <x86@kernel.org>, <kvm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linmiaohe@huawei.com>
Subject: [PATCH v2] KVM: remove redundant code in kvm_arch_vm_ioctl
Date:   Mon, 21 Oct 2019 16:52:53 +0800
Message-ID: <1571647973-18657-1-git-send-email-linmiaohe@huawei.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.105.18]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If we reach here with r = 0, we will reassign r = 0
unnecesarry, then do the label set_irqchip_out work.
If we reach here with r != 0, then we will do the label
work directly. So this if statement and r = 0 assignment
is redundant. We remove them and therefore we can get rid
of odd set_irqchip_out lable further pointed out by tglx.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 arch/x86/kvm/x86.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 661e2bf38526..cd4ca8c2f7de 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -4913,13 +4913,8 @@ long kvm_arch_vm_ioctl(struct file *filp,
 		}
 
 		r = -ENXIO;
-		if (!irqchip_kernel(kvm))
-			goto set_irqchip_out;
-		r = kvm_vm_ioctl_set_irqchip(kvm, chip);
-		if (r)
-			goto set_irqchip_out;
-		r = 0;
-	set_irqchip_out:
+		if (irqchip_kernel(kvm))
+			r = kvm_vm_ioctl_set_irqchip(kvm, chip);
 		kfree(chip);
 		break;
 	}
-- 
2.19.1

