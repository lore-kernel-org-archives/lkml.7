Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E6C2C432C0
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 20:13:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53B2921774
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 20:13:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RwaROu+D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728156AbfLBUN1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 15:13:27 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:43957 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728003AbfLBUNZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 15:13:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575317604;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=G1gckXauaeL8jMmVmxWpREojol2bGewDKqT8ZgknTb0=;
        b=RwaROu+DkszlEluMLpSlNTqN/rkLverpnqm81gQSN6DmycHXZEHIgwAZ6av2n7ugoDZdnS
        lZFvggyzTK/HaznwhKna2zP4AWLgbC/HKrFv0fucNocj50I1g6/84xwAVqv12crFiDoe5q
        /ivAWBi+sB6TfczPukpfdMAA4e1w1oY=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-102-0uiaUSasOWiq0dDutSs8Cg-1; Mon, 02 Dec 2019 15:13:23 -0500
Received: by mail-qk1-f198.google.com with SMTP id j192so506948qke.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2019 12:13:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Utq3zcNfSThC/9BbVCBXGvAcYurXVWxw0oLvhkumJ1Q=;
        b=iZy3MXYJHbEpYXzIpMQPjwit/fb16rPcQp1JtdB+DPCFdQ0UOVMiTIYZ65JEel+x7+
         qdkdhSfoHK4Y7FlkWIPX0oz5ZaOHBrzTUpxCGlB7G73JhzgFbKVsh0UWuuvR/5MI3dCc
         YjlaBxcbEgaZwlgiX+EyJi4Oy40h9Aw6lvZmuDA3uUczLTmAhy2yTaDwNnsXydyY6Tki
         EZ8W64oH1vMrxhvA+n/c75Lb+Ybu2RkAHnCoFDaIy/a2yS5dIzchvdej7GtulUVccq4L
         iiEcAx7+94khb94pY8K5fVChMtbWqU6tHyBL6znONFI3MyjUHS2f9/ARUCBejIbr8cdK
         PhlQ==
X-Gm-Message-State: APjAAAUgX4xgr0h1mGwoJJy/XKGqG1JRCFbMamHmOUdwW/eIrnIuYpvl
        40pNEjU/peHzEal26vG6Umga+/BGhnXj60l2VVcSujU0lEH9/RVyYiNSy75BsgOS1xLHWwXdS1n
        +sQjmFErXAmFRhwE5wiy6aR18
X-Received: by 2002:ac8:1098:: with SMTP id a24mr1392397qtj.62.1575317603055;
        Mon, 02 Dec 2019 12:13:23 -0800 (PST)
X-Google-Smtp-Source: APXvYqw9F5bzoR4DI4qH8h+a0GB9RfB7ylXfBVEuQobgvwjzKT5mNcRRe56CqIEbnF0GkoUXl/xK8A==
X-Received: by 2002:ac8:1098:: with SMTP id a24mr1392376qtj.62.1575317602808;
        Mon, 02 Dec 2019 12:13:22 -0800 (PST)
Received: from xz-x1.yyz.redhat.com ([104.156.64.74])
        by smtp.gmail.com with ESMTPSA id b6sm342410qtp.5.2019.12.02.12.13.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2019 12:13:18 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Nitesh Narayan Lal <nitesh@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        peterx@redhat.com, Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: [PATCH v3 2/5] KVM: X86: Move irrelevant declarations out of ioapic.h
Date:   Mon,  2 Dec 2019 15:13:11 -0500
Message-Id: <20191202201314.543-3-peterx@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191202201314.543-1-peterx@redhat.com>
References: <20191202201314.543-1-peterx@redhat.com>
MIME-Version: 1.0
X-MC-Unique: 0uiaUSasOWiq0dDutSs8Cg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kvm_apic_match_dest() is declared in both ioapic.h and lapic.h.
Removing the declaration in ioapic.h.

kvm_apic_compare_prio() is declared in ioapic.h but defined in
lapic.c.  Moving the declaration to lapic.h.

kvm_irq_delivery_to_apic() is declared in ioapic.h but defined in
irq_comm.c.  Moving the declaration to irq.h.

While at it, include irq.h in hyperv.c because it needs to use
kvm_irq_delivery_to_apic().

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/x86/kvm/hyperv.c | 1 +
 arch/x86/kvm/ioapic.h | 6 ------
 arch/x86/kvm/irq.h    | 3 +++
 arch/x86/kvm/lapic.h  | 2 +-
 4 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index 23ff65504d7e..c7d4640b7b1c 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -33,6 +33,7 @@
 #include <trace/events/kvm.h>
=20
 #include "trace.h"
+#include "irq.h"
=20
 #define KVM_HV_MAX_SPARSE_VCPU_SET_BITS DIV_ROUND_UP(KVM_MAX_VCPUS, 64)
=20
diff --git a/arch/x86/kvm/ioapic.h b/arch/x86/kvm/ioapic.h
index ea1a4e0297da..2fb2e3c80724 100644
--- a/arch/x86/kvm/ioapic.h
+++ b/arch/x86/kvm/ioapic.h
@@ -116,9 +116,6 @@ static inline int ioapic_in_kernel(struct kvm *kvm)
 }
=20
 void kvm_rtc_eoi_tracking_restore_one(struct kvm_vcpu *vcpu);
-bool kvm_apic_match_dest(struct kvm_vcpu *vcpu, struct kvm_lapic *source,
-=09=09int short_hand, unsigned int dest, int dest_mode);
-int kvm_apic_compare_prio(struct kvm_vcpu *vcpu1, struct kvm_vcpu *vcpu2);
 void kvm_ioapic_update_eoi(struct kvm_vcpu *vcpu, int vector,
 =09=09=09int trigger_mode);
 int kvm_ioapic_init(struct kvm *kvm);
@@ -126,9 +123,6 @@ void kvm_ioapic_destroy(struct kvm *kvm);
 int kvm_ioapic_set_irq(struct kvm_ioapic *ioapic, int irq, int irq_source_=
id,
 =09=09       int level, bool line_status);
 void kvm_ioapic_clear_all(struct kvm_ioapic *ioapic, int irq_source_id);
-int kvm_irq_delivery_to_apic(struct kvm *kvm, struct kvm_lapic *src,
-=09=09=09     struct kvm_lapic_irq *irq,
-=09=09=09     struct dest_map *dest_map);
 void kvm_get_ioapic(struct kvm *kvm, struct kvm_ioapic_state *state);
 void kvm_set_ioapic(struct kvm *kvm, struct kvm_ioapic_state *state);
 void kvm_ioapic_scan_entry(struct kvm_vcpu *vcpu,
diff --git a/arch/x86/kvm/irq.h b/arch/x86/kvm/irq.h
index 7c6233d37c64..f173ab6b407e 100644
--- a/arch/x86/kvm/irq.h
+++ b/arch/x86/kvm/irq.h
@@ -113,5 +113,8 @@ int apic_has_pending_timer(struct kvm_vcpu *vcpu);
=20
 int kvm_setup_default_irq_routing(struct kvm *kvm);
 int kvm_setup_empty_irq_routing(struct kvm *kvm);
+int kvm_irq_delivery_to_apic(struct kvm *kvm, struct kvm_lapic *src,
+=09=09=09     struct kvm_lapic_irq *irq,
+=09=09=09     struct dest_map *dest_map);
=20
 #endif
diff --git a/arch/x86/kvm/lapic.h b/arch/x86/kvm/lapic.h
index 39925afdfcdc..0b9bbadd1f3c 100644
--- a/arch/x86/kvm/lapic.h
+++ b/arch/x86/kvm/lapic.h
@@ -83,7 +83,7 @@ int kvm_lapic_reg_read(struct kvm_lapic *apic, u32 offset=
, int len,
 =09=09       void *data);
 bool kvm_apic_match_dest(struct kvm_vcpu *vcpu, struct kvm_lapic *source,
 =09=09=09   int short_hand, unsigned int dest, int dest_mode);
-
+int kvm_apic_compare_prio(struct kvm_vcpu *vcpu1, struct kvm_vcpu *vcpu2);
 bool __kvm_apic_update_irr(u32 *pir, void *regs, int *max_irr);
 bool kvm_apic_update_irr(struct kvm_vcpu *vcpu, u32 *pir, int *max_irr);
 void kvm_apic_update_ppr(struct kvm_vcpu *vcpu);
--=20
2.21.0

