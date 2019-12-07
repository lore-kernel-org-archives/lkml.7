Return-Path: <SRS0=Iet2=Z5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 014A3C43603
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Dec 2019 09:25:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D22E821835
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Dec 2019 09:25:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbfLGJZ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Dec 2019 04:25:56 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:59274 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726000AbfLGJZx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Dec 2019 04:25:53 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 05F8A166F9C2EF584C38;
        Sat,  7 Dec 2019 17:25:47 +0800 (CST)
Received: from huawei.com (10.175.105.18) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.439.0; Sat, 7 Dec 2019
 17:25:36 +0800
From:   linmiaohe <linmiaohe@huawei.com>
To:     <pbonzini@redhat.com>, <rkrcmar@redhat.com>,
        <sean.j.christopherson@intel.com>, <vkuznets@redhat.com>,
        <wanpengli@tencent.com>, <jmattson@google.com>, <joro@8bytes.org>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <hpa@zytor.com>
CC:     <linmiaohe@huawei.com>, <kvm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <x86@kernel.org>
Subject: [PATCH 5/6] KVM: x86: check kvm_pit outside kvm_vm_ioctl_reinject()
Date:   Sat, 7 Dec 2019 17:25:22 +0800
Message-ID: <1575710723-32094-6-git-send-email-linmiaohe@huawei.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1575710723-32094-1-git-send-email-linmiaohe@huawei.com>
References: <1575710723-32094-1-git-send-email-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.105.18]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Miaohe Lin <linmiaohe@huawei.com>

check kvm_pit outside kvm_vm_ioctl_reinject() to keep codestyle consistent
with other kvm_pit func and prepare for futher cleanups.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 arch/x86/kvm/x86.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 2d4e3a2dfec6..00b5d4ace383 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -4662,9 +4662,6 @@ static int kvm_vm_ioctl_reinject(struct kvm *kvm,
 {
 	struct kvm_pit *pit = kvm->arch.vpit;
 
-	if (!pit)
-		return -ENXIO;
-
 	/* pit->pit_state.lock was overloaded to prevent userspace from getting
 	 * an inconsistent state after running multiple KVM_REINJECT_CONTROL
 	 * ioctls in parallel.  Use a separate lock if that ioctl isn't rare.
@@ -5029,6 +5026,9 @@ long kvm_arch_vm_ioctl(struct file *filp,
 		r =  -EFAULT;
 		if (copy_from_user(&control, argp, sizeof(control)))
 			goto out;
+		r = -ENXIO;
+		if (!kvm->arch.vpit)
+			goto out;
 		r = kvm_vm_ioctl_reinject(kvm, &control);
 		break;
 	}
-- 
2.19.1

