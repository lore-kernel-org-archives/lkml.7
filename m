Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFA26C2D0DE
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 02:19:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84E7521734
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 02:19:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727558AbgABCTN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jan 2020 21:19:13 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:8657 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727511AbgABCTN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jan 2020 21:19:13 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 4477357E9891A67129BA;
        Thu,  2 Jan 2020 10:19:10 +0800 (CST)
Received: from huawei.com (10.175.105.18) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.439.0; Thu, 2 Jan 2020
 10:19:03 +0800
From:   linmiaohe <linmiaohe@huawei.com>
To:     <pbonzini@redhat.com>, <rkrcmar@redhat.com>,
        <sean.j.christopherson@intel.com>, <vkuznets@redhat.com>,
        <wanpengli@tencent.com>, <jmattson@google.com>, <joro@8bytes.org>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <hpa@zytor.com>
CC:     <linmiaohe@huawei.com>, <liran.alon@oracle.com>,
        <kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <x86@kernel.org>
Subject: [PATCH] KVM: SVM: Fix potential memory leak in svm_cpu_init()
Date:   Thu, 2 Jan 2020 10:20:40 +0800
Message-ID: <1577931640-29420-1-git-send-email-linmiaohe@huawei.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.105.18]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Miaohe Lin <linmiaohe@huawei.com>

When kmalloc memory for sd->sev_vmcbs failed, we forget to free the page
held by sd->save_area.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 arch/x86/kvm/svm.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
index 8f1b715dfde8..89eb382e8580 100644
--- a/arch/x86/kvm/svm.c
+++ b/arch/x86/kvm/svm.c
@@ -1012,7 +1012,7 @@ static int svm_cpu_init(int cpu)
 	r = -ENOMEM;
 	sd->save_area = alloc_page(GFP_KERNEL);
 	if (!sd->save_area)
-		goto err_1;
+		goto free_cpu_data;
 
 	if (svm_sev_enabled()) {
 		r = -ENOMEM;
@@ -1020,14 +1020,16 @@ static int svm_cpu_init(int cpu)
 					      sizeof(void *),
 					      GFP_KERNEL);
 		if (!sd->sev_vmcbs)
-			goto err_1;
+			goto free_save_area;
 	}
 
 	per_cpu(svm_data, cpu) = sd;
 
 	return 0;
 
-err_1:
+free_save_area:
+	__free_page(sd->save_area);
+free_cpu_data:
 	kfree(sd);
 	return r;
 
-- 
2.19.1

