Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8961FC072B1
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 10:34:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C435208CA
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 10:34:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PyYO+5b1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726985AbfE0Ke1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 06:34:27 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33421 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726946AbfE0KeY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 06:34:24 -0400
Received: by mail-pg1-f194.google.com with SMTP id h17so8910348pgv.0;
        Mon, 27 May 2019 03:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Vpg2cDctWQejTN0F0qGalNdJQTFib3kHrQ/n0YmUAdw=;
        b=PyYO+5b16GmfOefyscRtRj3Z2WjyjUIpS+UlV0KmTktn6t90oEM4gQdAcdXGGBhvwX
         kH7+OFk1XLfQ2izT57PzI7xA64olkk58wHc49BoTNDVKWrk/LX5IJM8lUESeLJW9yfuF
         3+/kaqqHvb4ZQC3UBjczm/vz5Ox1Boho4/46wFWPlTSgZuhbDJl2JZkG7/2BCtWoH8K3
         mTPRA9HQoSaUckfDymaTuGGNBHasI7Fg65z5YsdhsV7emO0hhPjDDEP7h62Gd3ulQR2+
         9hn6TsOdwTlIUHlG77VK2yJvvgsVjWitydeVqNzpWgSsBxtHqR3h8l+A7v53o4o+0kap
         h8iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Vpg2cDctWQejTN0F0qGalNdJQTFib3kHrQ/n0YmUAdw=;
        b=HlP77IDgA4c3ANnalZYl726tLWbdqqGTkcQLnwEYiuflJCiIuq5J0abesPBLINekZ5
         /Phuj9QXl3SuYFVAGjmtLB6Py4nrJtlvlipiQrp2sDiKagViZNDpPZxIa5xmLASkh2ZO
         hns9j1iZuYCrbPWNnwWcI/D+Ibi9mv6q8A8PrtA3UpDsg3DCbq3zPbPZ+oGNOcZ5Vusa
         lSswl3gf+lXqinSGnN1CVc2tCZUSqv2qh+fkzbPI+g7UcBYE0wo5Tjv7tc0DqqHn/JZf
         0uen8KE6x5tFcI3dDCefUmSZ5Ij8hy5+XH6Ms3gLvDOMgfngI0I9LY0g3VrjAbjDdKS1
         cyLw==
X-Gm-Message-State: APjAAAXSIILCB2o9k5L3hq7iM5AqL5gf6+U/EafFhB5l3sqSrmbn6cOe
        CcP2t8W6kCyGu81iWLbzGGAfU00l
X-Google-Smtp-Source: APXvYqzt5TabbzEZfV9CZ9lZOdRVBBWybF9uBxkoZ3l8vJUzsPlArc0kJGvmPyJ2PznDqBjKthgyjw==
X-Received: by 2002:a62:1846:: with SMTP id 67mr116709452pfy.33.1558953264163;
        Mon, 27 May 2019 03:34:24 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.123])
        by smtp.googlemail.com with ESMTPSA id y16sm19216452pfo.133.2019.05.27.03.34.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 27 May 2019 03:34:23 -0700 (PDT)
From:   Wanpeng Li <kernellwp@gmail.com>
X-Google-Original-From: Wanpeng Li <wanpengli@tencent.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Subject: [PATCH 2/3] KVM: X86: Implement PV sched yield hypercall
Date:   Mon, 27 May 2019 18:34:14 +0800
Message-Id: <1558953255-9432-3-git-send-email-wanpengli@tencent.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1558953255-9432-1-git-send-email-wanpengli@tencent.com>
References: <1558953255-9432-1-git-send-email-wanpengli@tencent.com>
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
 arch/x86/kvm/x86.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index e7e57de..45403a6 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -7172,6 +7172,19 @@ void kvm_vcpu_deactivate_apicv(struct kvm_vcpu *vcpu)
 	kvm_x86_ops->refresh_apicv_exec_ctrl(vcpu);
 }
 
+void kvm_sched_yield(struct kvm *kvm, u64 dest_id)
+{
+	struct kvm_vcpu *target;
+	struct kvm_apic_map *map;
+
+	rcu_read_lock();
+	map = rcu_dereference(kvm->arch.apic_map);
+	target = map->phys_map[dest_id]->vcpu;
+	rcu_read_unlock();
+
+	kvm_vcpu_yield_to(target);
+}
+
 int kvm_emulate_hypercall(struct kvm_vcpu *vcpu)
 {
 	unsigned long nr, a0, a1, a2, a3, ret;
@@ -7218,6 +7231,10 @@ int kvm_emulate_hypercall(struct kvm_vcpu *vcpu)
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

