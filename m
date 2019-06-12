Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94D7FC31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 09:36:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F6FA21773
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 09:36:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BArrchFG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437507AbfFLJgT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 05:36:19 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40601 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437492AbfFLJgR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 05:36:17 -0400
Received: by mail-pf1-f195.google.com with SMTP id p184so6028137pfp.7;
        Wed, 12 Jun 2019 02:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wj3VoxcHtEUUOCOJDV3/IkQEZy74zBF0y5Hje4ka4G0=;
        b=BArrchFGj6F74ig6hTmStuzxFhPJZ6KsJshUxbEvyOuupxfYrF/zBfR30N0pk4xOcc
         teBMuzm0l1m45daeHUX3burBPW8WV0zQUWK2fXvQgPo9W4h9BO4PCQ1Ia/PGZ2hN03jf
         s7DQeahfa7guryuQtUJFgjNrVF6oVMTYGZKmpI8Yn5Ki75NW+mVqh++1OSJWj4TDbBma
         l3zs/7tK+4xiQBcdlaV5wZTIbEfSsP3BBMvaWYqDjjrurbWA7xnZE7F7YC4Tx6ThqCfi
         dhvILUbH7Lrk+zjxMD063GWv/UXtJXrQzxkQJZ6K2zFVPWMJsGg3Tqx9JYAIVdu1xIc3
         Ptrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wj3VoxcHtEUUOCOJDV3/IkQEZy74zBF0y5Hje4ka4G0=;
        b=Sqev87SSwkejeclVkIx3S3CO69wFcjAys7uHrOfDnwkOqscVpkI59aTnyhGKNIym68
         GAN8yftrvJcDDg0uTvXTaMlJB0D2SvvYS8twjZz5ONXJCm1cccg2rfWGHBjnVz9eDgvz
         NDgyxOabAiGW4on/M530LZ4tCbZu33rver2rKxjOQ0DnZn4f4aikdLNJT2G97rskpr/1
         FmiWJCHeg2AmbbTEeHBML0oFvqezJVUOrYWhD0R+6KIhW+Y9uee1ILJgh5mMfhQ9MGbn
         OFOfMPbr020CF1uQ6iKfivebmHLbbfg70Ssi2NUL+95Rsus0u1qzC18p5FUYTmecI0Aa
         HuDg==
X-Gm-Message-State: APjAAAXgTi7vRcM/Fi3tyv8mezsvIhvVL7QnmGxg3pPI2XPMqJYZG2U5
        sNSff1ErdcEh+pIGJSmIJLaVRCsD
X-Google-Smtp-Source: APXvYqxTtyS104EAy9EwtxxJYRYGAk5uwX2n69Tncivk7HrW3qgfKd4Wufam3aLANzkOY2bRbu3MuQ==
X-Received: by 2002:a63:6105:: with SMTP id v5mr24291696pgb.312.1560332176123;
        Wed, 12 Jun 2019 02:36:16 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.123])
        by smtp.googlemail.com with ESMTPSA id 27sm6148936pgl.82.2019.06.12.02.36.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 12 Jun 2019 02:36:15 -0700 (PDT)
From:   Wanpeng Li <kernellwp@gmail.com>
X-Google-Original-From: Wanpeng Li <wanpengli@tencent.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Liran Alon <liran.alon@oracle.com>
Subject: [PATCH v3 3/5] KVM: LAPIC: Expose per-vCPU timer_advance_ns to userspace
Date:   Wed, 12 Jun 2019 17:35:58 +0800
Message-Id: <1560332160-17050-4-git-send-email-wanpengli@tencent.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1560332160-17050-1-git-send-email-wanpengli@tencent.com>
References: <1560332160-17050-1-git-send-email-wanpengli@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wanpeng Li <wanpengli@tencent.com>

Expose per-vCPU timer_advance_ns to userspace, so it is able to 
query the auto-adjusted value.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: Sean Christopherson <sean.j.christopherson@intel.com>
Cc: Liran Alon <liran.alon@oracle.com>
Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
---
 arch/x86/kvm/debugfs.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/x86/kvm/debugfs.c b/arch/x86/kvm/debugfs.c
index c19c7ed..a6f1f93 100644
--- a/arch/x86/kvm/debugfs.c
+++ b/arch/x86/kvm/debugfs.c
@@ -9,12 +9,22 @@
  */
 #include <linux/kvm_host.h>
 #include <linux/debugfs.h>
+#include "lapic.h"
 
 bool kvm_arch_has_vcpu_debugfs(void)
 {
 	return true;
 }
 
+static int vcpu_get_timer_advance_ns(void *data, u64 *val)
+{
+	struct kvm_vcpu *vcpu = (struct kvm_vcpu *) data;
+	*val = vcpu->arch.apic->lapic_timer.timer_advance_ns;
+	return 0;
+}
+
+DEFINE_SIMPLE_ATTRIBUTE(vcpu_timer_advance_ns_fops, vcpu_get_timer_advance_ns, NULL, "%llu\n");
+
 static int vcpu_get_tsc_offset(void *data, u64 *val)
 {
 	struct kvm_vcpu *vcpu = (struct kvm_vcpu *) data;
@@ -51,6 +61,12 @@ int kvm_arch_create_vcpu_debugfs(struct kvm_vcpu *vcpu)
 	if (!ret)
 		return -ENOMEM;
 
+	ret = debugfs_create_file("lapic_timer_advance_ns", 0444,
+							vcpu->debugfs_dentry,
+							vcpu, &vcpu_timer_advance_ns_fops);
+	if (!ret)
+		return -ENOMEM;
+
 	if (kvm_has_tsc_control) {
 		ret = debugfs_create_file("tsc-scaling-ratio", 0444,
 							vcpu->debugfs_dentry,
-- 
2.7.4

