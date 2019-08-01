Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9062C32751
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 03:30:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCC6F214DA
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 03:30:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WgBWrKZa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729536AbfHADaf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 23:30:35 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:42226 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729454AbfHADad (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 23:30:33 -0400
Received: by mail-pl1-f195.google.com with SMTP id ay6so31524647plb.9;
        Wed, 31 Jul 2019 20:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yi1exxOESZzEycuHqysD1gM72+t7zQj2sGD0fd3bGxo=;
        b=WgBWrKZaLmBTaX24JiBvKUKx7PQpnV2Eul0GiwAhK3ZH9enQM5V7htJwd8Vv5XsZtO
         bGHNooihQQjFoXxasvPnI++UueyCREWT6vPLJGb592F5YejmHk21BjMQf/VZs5nWjIDq
         9ebsDepEaqi2a0KNouAOD6mO0HoYxNttmCB3MGgcF84iR9+DSXCGKuaHAUrkhyOXBj2t
         G82lSOMdxAgQBA2BL6DBRSIBgASBN+pdCBpUuhVvlOKU6RFdmN4MuZJN6FBlamEzks6q
         Wwy1kGXsjj+t1VGc7YEDIvD/cuYg3p/yup6rcgJ/J99C4NGCBDJS+04azSkTv0EbIEh4
         QPPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yi1exxOESZzEycuHqysD1gM72+t7zQj2sGD0fd3bGxo=;
        b=SiO7eWU/lBbWvMEIh/8pTwkENSYSSm4t4A826W67Vaz9qQkcb6QtZ+KRjbyIQ8W3Dc
         wqmUkIBP8ySw+uWWoTxb4zXxNo70IXSENu+WEmo/FkI4Jobf8mlSvmYj5WafIfPzYSPW
         iFFwEhsA095iXSCLzqRTqVbe7gC5GkTF8rhGFKHo6/jD2zirFI6m1UzrHy7yoHEmpN89
         fORDbydg8eHVehaCquuOatdGPgh+xt9RvMWeU6r5AF8IIfIvBxIwES8kJ6un7xxk6Pkt
         GnPyEgDLfwchPbV757dwEJZFqUIbjp6D5nsnJYXe9P/d1JNRhr3E6wxnH1V5Z1i5Hh+k
         2+6w==
X-Gm-Message-State: APjAAAW/wB0xn7zN66rwH8bKNEa9v6ys4UxzQPN5iiqVRPzMJfl+rYNK
        KkmzvFI1CGcA90bTe5JPNG068qmU0d8=
X-Google-Smtp-Source: APXvYqwOn+Gh45VcjomgcGYGqPzbg5aUZP4hCLrhQtoQlTTJBOvBqxErP0KkfU6WXVM8k22o5+Yeug==
X-Received: by 2002:a17:902:6a2:: with SMTP id 31mr117261254plh.296.1564630233098;
        Wed, 31 Jul 2019 20:30:33 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.123])
        by smtp.googlemail.com with ESMTPSA id d14sm86158055pfo.154.2019.07.31.20.30.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 31 Jul 2019 20:30:32 -0700 (PDT)
From:   Wanpeng Li <kernellwp@gmail.com>
X-Google-Original-From: Wanpeng Li <wanpengli@tencent.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Subject: [PATCH v3 3/3] KVM: Check preempted_in_kernel for involuntary preemption
Date:   Thu,  1 Aug 2019 11:30:14 +0800
Message-Id: <1564630214-28442-3-git-send-email-wanpengli@tencent.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1564630214-28442-1-git-send-email-wanpengli@tencent.com>
References: <1564630214-28442-1-git-send-email-wanpengli@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wanpeng Li <wanpengli@tencent.com>

preempted_in_kernel is updated in preempt_notifier when involuntary preemption 
ocurrs, it can be stale when the voluntarily preempted vCPUs are taken into 
account by kvm_vcpu_on_spin() loop. This patch lets it just check preempted_in_kernel 
for involuntary preemption.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
---
 virt/kvm/kvm_main.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 3e1a509..58b9590 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -2519,7 +2519,8 @@ void kvm_vcpu_on_spin(struct kvm_vcpu *me, bool yield_to_kernel_mode)
 				continue;
 			if (swait_active(&vcpu->wq) && !vcpu_runnable(vcpu))
 				continue;
-			if (yield_to_kernel_mode && !kvm_arch_vcpu_in_kernel(vcpu))
+			if (READ_ONCE(vcpu->preempted) && yield_to_kernel_mode &&
+				!kvm_arch_vcpu_in_kernel(vcpu))
 				continue;
 			if (!kvm_vcpu_eligible_for_directed_yield(vcpu))
 				continue;
@@ -4216,7 +4217,7 @@ static void kvm_sched_in(struct preempt_notifier *pn, int cpu)
 {
 	struct kvm_vcpu *vcpu = preempt_notifier_to_vcpu(pn);
 
-	vcpu->preempted = false;
+	WRITE_ONCE(vcpu->preempted, false);
 	WRITE_ONCE(vcpu->ready, false);
 
 	kvm_arch_sched_in(vcpu, cpu);
@@ -4230,7 +4231,7 @@ static void kvm_sched_out(struct preempt_notifier *pn,
 	struct kvm_vcpu *vcpu = preempt_notifier_to_vcpu(pn);
 
 	if (current->state == TASK_RUNNING) {
-		vcpu->preempted = true;
+		WRITE_ONCE(vcpu->preempted, true);
 		WRITE_ONCE(vcpu->ready, true);
 	}
 	kvm_arch_vcpu_put(vcpu);
-- 
2.7.4

