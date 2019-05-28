Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D953C04AB3
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 00:53:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32BA320717
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 00:53:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y9efBHL1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727721AbfE1Ax2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 20:53:28 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36465 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727664AbfE1AxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 20:53:25 -0400
Received: by mail-pg1-f194.google.com with SMTP id a3so9875192pgb.3;
        Mon, 27 May 2019 17:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=w8tUpsjD0B/4WL1DERytRNOwP/commCoNxPwnBn5zTA=;
        b=Y9efBHL1idqJJbpd4k+zpV0kKqxJK85rAnjYxrWO90ZC+ya0zUvj3OHPDSOyVpL5F9
         B4bquLWQe1mljjTxcCgUeXYnMafiKmPYHYjB/ZD8cE+k49b3rYOO7qmTSoCd2lZLrBnq
         X8PDWWKvHHzPn1DmfXUPkZJ/yf/i/FQyjrI258y1PPoN9Y+3Bu/KFwb+QdvC/tJzw1CL
         H4gNhiVBvKjfcBlgeDjhCj5qiEwcYfTJ+z5HbEMFb9SqVUZgDbhhihycsOzRYrvN+x18
         byUJZ6rH1cABfjVVra2fBEdJE5KyYVxeDZW4Yrj4aF3sz7Nq1oMrPdIb1YVeJplUoM6O
         eKBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=w8tUpsjD0B/4WL1DERytRNOwP/commCoNxPwnBn5zTA=;
        b=J/JPt9+O5jQMu3btrXzNJ50HjZ2Vw/NyQP6PfDdMzvGEMQsIh2edjKVoj00HdPJe7G
         5MEjFV6XmxlMQKri2zQWFkzrgtUIFzR62c40oIv6WlMLElnp7JVC123DIxiDAnJAAaqy
         98j1RxAzaeS+JU+oRfrNwO1e+x1MUqwT5oJeVv62etoEFzHSdQVQspJTo5J1lU1elFDb
         k9c+CuWAP29IqLOI+AtGlVbjdEKm3m7PYKsmPxYdRaKfSAApMpvyqCUr5DD5tAXpjdTf
         VvNJQFs6sj53JATIlPmFajvxr6RybD+Kx4jZNhWD7eqZjftvhlGdzmWPdTUG6OgaF+OJ
         z6LQ==
X-Gm-Message-State: APjAAAWDOWXZwD3CNxAlCRuxQvubeJFx3azwr977yxGKmJHQfGy7THOE
        Hi/oRubeWQPDP2a16MxnZWmynpj8
X-Google-Smtp-Source: APXvYqykkcUUw6dSx8dtH+UZDXoHUR1zvFvZFS4DdVEzlpqNotfThAKvLiHbbcM27naL30g02GdKZw==
X-Received: by 2002:a17:90a:db4d:: with SMTP id u13mr1972079pjx.43.1559004804650;
        Mon, 27 May 2019 17:53:24 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.123])
        by smtp.googlemail.com with ESMTPSA id f16sm622085pja.18.2019.05.27.17.53.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 27 May 2019 17:53:24 -0700 (PDT)
From:   Wanpeng Li <kernellwp@gmail.com>
X-Google-Original-From: Wanpeng Li <wanpengli@tencent.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Subject: [PATCH v2 2/3] KVM: X86: Implement PV sched yield hypercall
Date:   Tue, 28 May 2019 08:53:14 +0800
Message-Id: <1559004795-19927-3-git-send-email-wanpengli@tencent.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1559004795-19927-1-git-send-email-wanpengli@tencent.com>
References: <1559004795-19927-1-git-send-email-wanpengli@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wanpeng Li <wanpengli@tencent.com>

The target vCPUs are in runnable state after vcpu_kick and suitable 
as a yield target. This patch implements the sched yield hypercall.

17% performace increase of ebizzy benchmark can be observed in an 
over-subscribe environment. (w/ kvm-pv-tlb disabled, testing TLB flush 
call-function IPI-many since call-function is not easy to be trigged 
by userspace workload).

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
---
 arch/x86/kvm/x86.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index e7e57de..2ceef51 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -7172,6 +7172,26 @@ void kvm_vcpu_deactivate_apicv(struct kvm_vcpu *vcpu)
 	kvm_x86_ops->refresh_apicv_exec_ctrl(vcpu);
 }
 
+void kvm_sched_yield(struct kvm *kvm, u64 dest_id)
+{
+	struct kvm_vcpu *target;
+	struct kvm_apic_map *map;
+
+	rcu_read_lock();
+	map = rcu_dereference(kvm->arch.apic_map);
+
+	if (unlikely(!map))
+		goto out;
+
+	if (map->phys_map[dest_id]->vcpu) {
+		target = map->phys_map[dest_id]->vcpu;
+		kvm_vcpu_yield_to(target);
+	}
+
+out:
+	rcu_read_unlock();
+}
+
 int kvm_emulate_hypercall(struct kvm_vcpu *vcpu)
 {
 	unsigned long nr, a0, a1, a2, a3, ret;
@@ -7218,6 +7238,10 @@ int kvm_emulate_hypercall(struct kvm_vcpu *vcpu)
 	case KVM_HC_SEND_IPI:
 		ret = kvm_pv_send_ipi(vcpu->kvm, a0, a1, a2, a3, op_64_bit);
 		break;
+	case KVM_HC_SCHED_YIELD:
+		kvm_sched_yield(vcpu->kvm, a0);
+		ret = 0;
+		break;
 	default:
 		ret = -KVM_ENOSYS;
 		break;
-- 
2.7.4

