Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77D26C43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 19:07:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4227E2073B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 19:07:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gs1qW1TU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729059AbfLDTHt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 14:07:49 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:49099 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728895AbfLDTHd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 14:07:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575486452;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gWYRCGS0//yIHflQIbqt67u02lc6zBx08hdFYmA1GAk=;
        b=gs1qW1TUrfh8C/THwY2fSNXCLbGG6oKsjq6PhhCcqbLBvhMAEjtIC3NQe3yAfE7s5Gij8m
        mt8BmfP8jfa7RKtRfJOx3EXbEujPoZpjshzexmyYV5B1botpknKmVjkAb7XKUYaxm8JtdX
        qBcQThYTCmmzNGT39bAobpLKiyaBbDY=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-15-9KIEEVWbOs-mln-wj2QCbQ-1; Wed, 04 Dec 2019 14:07:28 -0500
Received: by mail-qv1-f69.google.com with SMTP id c22so488152qvc.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2019 11:07:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eAtukvvxHZFb5VfwsHBqC9apLrG0d1NIt4uAdArUNm4=;
        b=FWnxK8cMcqXMc5L8GZwe5eT+uAq3I4+CsDEAftFGBfoQ7+/4NBIoYdhiOU67nspQud
         pBQm20fNk8y30Jmg5Um6gefOBPgRJ1IoeVEVLUTnNqKJmMl+z5kk9TPb37698fDGOFFo
         6W8aRN7Ylasd//ID9x0BUQEyto0bAG3TQ1xmGtjw7wAaAGMM/O9FEs5ILL8r1SJtA4PQ
         t/HychzeeZIheq7Hi0HhTV763sq3NtK6KmgLniTZy9FAfx/uwIZ33ctgwKUaeKJ/2CKE
         Eycpfy/mab5pt4h8snnhTILHWNVMLb2qFdTieEJOrnR79PGIRCn88YqSgU2oMpDpXx20
         an9Q==
X-Gm-Message-State: APjAAAWAqmBLw8zgEPfUps8rB+mw4aJgZu3/ISgEdObgSks9zyyBG+4W
        O1ZVh+Yn7Gnz0WFhQcRcaLqydd3KHxyGU9zQz/R8MgIBbNmeUExQisRIyMP028NwVBw7PR0Pjjp
        TXOhopQ0uI33lxRMt2NYbzfSA
X-Received: by 2002:a05:620a:14bc:: with SMTP id x28mr4687586qkj.494.1575486447919;
        Wed, 04 Dec 2019 11:07:27 -0800 (PST)
X-Google-Smtp-Source: APXvYqxW8R5iCT8mNJ0NFxLhS+5m2yw8n1xSpxtGhj4i8JeVRP3YpcplU7Q1uOA3EQltVVXpat/Y6Q==
X-Received: by 2002:a05:620a:14bc:: with SMTP id x28mr4687547qkj.494.1575486447611;
        Wed, 04 Dec 2019 11:07:27 -0800 (PST)
Received: from xz-x1.yyz.redhat.com ([104.156.64.74])
        by smtp.gmail.com with ESMTPSA id y18sm4072126qtn.11.2019.12.04.11.07.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2019 11:07:26 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Nitesh Narayan Lal <nitesh@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        peterx@redhat.com, Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: [PATCH v5 3/6] KVM: X86: Use APIC_DEST_* macros properly in kvm_lapic_irq.dest_mode
Date:   Wed,  4 Dec 2019 14:07:18 -0500
Message-Id: <20191204190721.29480-4-peterx@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191204190721.29480-1-peterx@redhat.com>
References: <20191204190721.29480-1-peterx@redhat.com>
MIME-Version: 1.0
X-MC-Unique: 9KIEEVWbOs-mln-wj2QCbQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We were using either APIC_DEST_PHYSICAL|APIC_DEST_LOGICAL or 0|1 to
fill in kvm_lapic_irq.dest_mode.  It's fine only because in most cases
when we check against dest_mode it's against APIC_DEST_PHYSICAL (which
equals to 0).  However, that's not consistent.  We'll have problem
when we want to start checking against APIC_DEST_LOGICAL, which does
not equals to 1.

This patch firstly introduces kvm_lapic_irq_dest_mode() helper to take
any boolean of destination mode and return the APIC_DEST_* macro.
Then, it replaces the 0|1 settings of irq.dest_mode with the helper.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/x86/include/asm/kvm_host.h | 5 +++++
 arch/x86/kvm/ioapic.c           | 9 ++++++---
 arch/x86/kvm/irq_comm.c         | 7 ++++---
 arch/x86/kvm/x86.c              | 2 +-
 4 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_hos=
t.h
index b79cd6aa4075..2893eae5df9f 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1022,6 +1022,11 @@ struct kvm_lapic_irq {
 =09bool msi_redir_hint;
 };
=20
+static inline u16 kvm_lapic_irq_dest_mode(bool dest_mode_logical)
+{
+=09return dest_mode_logical ? APIC_DEST_LOGICAL : APIC_DEST_PHYSICAL;
+}
+
 struct kvm_x86_ops {
 =09int (*cpu_has_kvm_support)(void);          /* __init */
 =09int (*disabled_by_bios)(void);             /* __init */
diff --git a/arch/x86/kvm/ioapic.c b/arch/x86/kvm/ioapic.c
index 9fd2dd89a1c5..e623a4f8d27e 100644
--- a/arch/x86/kvm/ioapic.c
+++ b/arch/x86/kvm/ioapic.c
@@ -331,7 +331,8 @@ static void ioapic_write_indirect(struct kvm_ioapic *io=
apic, u32 val)
 =09=09=09irq.vector =3D e->fields.vector;
 =09=09=09irq.delivery_mode =3D e->fields.delivery_mode << 8;
 =09=09=09irq.dest_id =3D e->fields.dest_id;
-=09=09=09irq.dest_mode =3D e->fields.dest_mode;
+=09=09=09irq.dest_mode =3D
+=09=09=09    kvm_lapic_irq_dest_mode(!!e->fields.dest_mode);
 =09=09=09bitmap_zero(&vcpu_bitmap, 16);
 =09=09=09kvm_bitmap_or_dest_vcpus(ioapic->kvm, &irq,
 =09=09=09=09=09=09 &vcpu_bitmap);
@@ -343,7 +344,9 @@ static void ioapic_write_indirect(struct kvm_ioapic *io=
apic, u32 val)
 =09=09=09=09 * keep ioapic_handled_vectors synchronized.
 =09=09=09=09 */
 =09=09=09=09irq.dest_id =3D old_dest_id;
-=09=09=09=09irq.dest_mode =3D old_dest_mode;
+=09=09=09=09irq.dest_mode =3D
+=09=09=09=09    kvm_lapic_irq_dest_mode(
+=09=09=09=09=09!!e->fields.dest_mode);
 =09=09=09=09kvm_bitmap_or_dest_vcpus(ioapic->kvm, &irq,
 =09=09=09=09=09=09=09 &vcpu_bitmap);
 =09=09=09}
@@ -369,7 +372,7 @@ static int ioapic_service(struct kvm_ioapic *ioapic, in=
t irq, bool line_status)
=20
 =09irqe.dest_id =3D entry->fields.dest_id;
 =09irqe.vector =3D entry->fields.vector;
-=09irqe.dest_mode =3D entry->fields.dest_mode;
+=09irqe.dest_mode =3D kvm_lapic_irq_dest_mode(!!entry->fields.dest_mode);
 =09irqe.trig_mode =3D entry->fields.trig_mode;
 =09irqe.delivery_mode =3D entry->fields.delivery_mode << 8;
 =09irqe.level =3D 1;
diff --git a/arch/x86/kvm/irq_comm.c b/arch/x86/kvm/irq_comm.c
index 8ecd48d31800..22108ed66a76 100644
--- a/arch/x86/kvm/irq_comm.c
+++ b/arch/x86/kvm/irq_comm.c
@@ -52,8 +52,8 @@ int kvm_irq_delivery_to_apic(struct kvm *kvm, struct kvm_=
lapic *src,
 =09unsigned long dest_vcpu_bitmap[BITS_TO_LONGS(KVM_MAX_VCPUS)];
 =09unsigned int dest_vcpus =3D 0;
=20
-=09if (irq->dest_mode =3D=3D 0 && irq->dest_id =3D=3D 0xff &&
-=09=09=09kvm_lowest_prio_delivery(irq)) {
+=09if (irq->dest_mode =3D=3D APIC_DEST_PHYSICAL &&
+=09    irq->dest_id =3D=3D 0xff && kvm_lowest_prio_delivery(irq)) {
 =09=09printk(KERN_INFO "kvm: apic: phys broadcast and lowest prio\n");
 =09=09irq->delivery_mode =3D APIC_DM_FIXED;
 =09}
@@ -114,7 +114,8 @@ void kvm_set_msi_irq(struct kvm *kvm, struct kvm_kernel=
_irq_routing_entry *e,
 =09=09irq->dest_id |=3D MSI_ADDR_EXT_DEST_ID(e->msi.address_hi);
 =09irq->vector =3D (e->msi.data &
 =09=09=09MSI_DATA_VECTOR_MASK) >> MSI_DATA_VECTOR_SHIFT;
-=09irq->dest_mode =3D (1 << MSI_ADDR_DEST_MODE_SHIFT) & e->msi.address_lo;
+=09irq->dest_mode =3D kvm_lapic_irq_dest_mode(
+=09    !!((1 << MSI_ADDR_DEST_MODE_SHIFT) & e->msi.address_lo));
 =09irq->trig_mode =3D (1 << MSI_DATA_TRIGGER_SHIFT) & e->msi.data;
 =09irq->delivery_mode =3D e->msi.data & 0x700;
 =09irq->msi_redir_hint =3D ((e->msi.address_lo
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 3ed167e039e5..3b00d662dc14 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -7356,7 +7356,7 @@ static void kvm_pv_kick_cpu_op(struct kvm *kvm, unsig=
ned long flags, int apicid)
 =09struct kvm_lapic_irq lapic_irq;
=20
 =09lapic_irq.shorthand =3D 0;
-=09lapic_irq.dest_mode =3D 0;
+=09lapic_irq.dest_mode =3D APIC_DEST_PHYSICAL;
 =09lapic_irq.level =3D 0;
 =09lapic_irq.dest_id =3D apicid;
 =09lapic_irq.msi_redir_hint =3D false;
--=20
2.21.0

