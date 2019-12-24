Return-Path: <SRS0=+gZy=2O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2113C2D0C0
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 01:34:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EF3E20643
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 01:34:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727141AbfLXBeT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Dec 2019 20:34:19 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:7732 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727005AbfLXBeT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 20:34:19 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 89A462307CBA837A735A;
        Tue, 24 Dec 2019 09:34:16 +0800 (CST)
Received: from localhost.localdomain (10.90.53.225) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.439.0; Tue, 24 Dec 2019 09:34:08 +0800
From:   Chen Wandun <chenwandun@huawei.com>
To:     <pbonzini@redhat.com>, <rkrcmar@redhat.com>, <tglx@linutronix.de>,
        <mingo@redhat.com>, <bp@alien8.de>, <hpa@zytor.com>,
        <x86@kernel.org>, <kvm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <chenwandun@huawei.com>
Subject: [PATCH next] KVM: Fix debugfs_simple_attr.cocci warnings
Date:   Tue, 24 Dec 2019 09:41:14 +0800
Message-ID: <1577151674-67949-1-git-send-email-chenwandun@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use DEFINE_DEBUGFS_ATTRIBUTE rather than DEFINE_SIMPLE_ATTRIBUTE
for debugfs files.

Semantic patch information:
Rationale: DEFINE_SIMPLE_ATTRIBUTE + debugfs_create_file()
imposes some significant overhead as compared to
DEFINE_DEBUGFS_ATTRIBUTE + debugfs_create_file_unsafe().

Signed-off-by: Chen Wandun <chenwandun@huawei.com>
---
 arch/x86/kvm/debugfs.c | 34 +++++++++++++++++++---------------
 1 file changed, 19 insertions(+), 15 deletions(-)

diff --git a/arch/x86/kvm/debugfs.c b/arch/x86/kvm/debugfs.c
index 018aebc..0867d7d 100644
--- a/arch/x86/kvm/debugfs.c
+++ b/arch/x86/kvm/debugfs.c
@@ -15,7 +15,8 @@ static int vcpu_get_timer_advance_ns(void *data, u64 *val)
 	return 0;
 }
 
-DEFINE_SIMPLE_ATTRIBUTE(vcpu_timer_advance_ns_fops, vcpu_get_timer_advance_ns, NULL, "%llu\n");
+DEFINE_DEBUGFS_ATTRIBUTE(vcpu_timer_advance_ns_fops,
+			 vcpu_get_timer_advance_ns, NULL, "%llu\n");
 
 static int vcpu_get_tsc_offset(void *data, u64 *val)
 {
@@ -24,7 +25,8 @@ static int vcpu_get_tsc_offset(void *data, u64 *val)
 	return 0;
 }
 
-DEFINE_SIMPLE_ATTRIBUTE(vcpu_tsc_offset_fops, vcpu_get_tsc_offset, NULL, "%lld\n");
+DEFINE_DEBUGFS_ATTRIBUTE(vcpu_tsc_offset_fops, vcpu_get_tsc_offset, NULL,
+			 "%lld\n");
 
 static int vcpu_get_tsc_scaling_ratio(void *data, u64 *val)
 {
@@ -33,7 +35,8 @@ static int vcpu_get_tsc_scaling_ratio(void *data, u64 *val)
 	return 0;
 }
 
-DEFINE_SIMPLE_ATTRIBUTE(vcpu_tsc_scaling_fops, vcpu_get_tsc_scaling_ratio, NULL, "%llu\n");
+DEFINE_DEBUGFS_ATTRIBUTE(vcpu_tsc_scaling_fops, vcpu_get_tsc_scaling_ratio,
+			 NULL, "%llu\n");
 
 static int vcpu_get_tsc_scaling_frac_bits(void *data, u64 *val)
 {
@@ -41,24 +44,25 @@ static int vcpu_get_tsc_scaling_frac_bits(void *data, u64 *val)
 	return 0;
 }
 
-DEFINE_SIMPLE_ATTRIBUTE(vcpu_tsc_scaling_frac_fops, vcpu_get_tsc_scaling_frac_bits, NULL, "%llu\n");
+DEFINE_DEBUGFS_ATTRIBUTE(vcpu_tsc_scaling_frac_fops,
+			 vcpu_get_tsc_scaling_frac_bits, NULL, "%llu\n");
 
 void kvm_arch_create_vcpu_debugfs(struct kvm_vcpu *vcpu)
 {
-	debugfs_create_file("tsc-offset", 0444, vcpu->debugfs_dentry, vcpu,
-			    &vcpu_tsc_offset_fops);
+	debugfs_create_file_unsafe("tsc-offset", 0444, vcpu->debugfs_dentry,
+				   vcpu, &vcpu_tsc_offset_fops);
 
 	if (lapic_in_kernel(vcpu))
-		debugfs_create_file("lapic_timer_advance_ns", 0444,
-				    vcpu->debugfs_dentry, vcpu,
-				    &vcpu_timer_advance_ns_fops);
+		debugfs_create_file_unsafe("lapic_timer_advance_ns", 0444,
+					   vcpu->debugfs_dentry, vcpu,
+					   &vcpu_timer_advance_ns_fops);
 
 	if (kvm_has_tsc_control) {
-		debugfs_create_file("tsc-scaling-ratio", 0444,
-				    vcpu->debugfs_dentry, vcpu,
-				    &vcpu_tsc_scaling_fops);
-		debugfs_create_file("tsc-scaling-ratio-frac-bits", 0444,
-				    vcpu->debugfs_dentry, vcpu,
-				    &vcpu_tsc_scaling_frac_fops);
+		debugfs_create_file_unsafe("tsc-scaling-ratio", 0444,
+					   vcpu->debugfs_dentry, vcpu,
+					   &vcpu_tsc_scaling_fops);
+		debugfs_create_file_unsafe("tsc-scaling-ratio-frac-bits", 0444,
+					   vcpu->debugfs_dentry, vcpu,
+					   &vcpu_tsc_scaling_frac_fops);
 	}
 }
-- 
2.7.4

