Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ACA6C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 19:32:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBA3721774
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 19:32:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hLcSWRs/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbfK1TcS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 14:32:18 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:59315 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726401AbfK1TcS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 14:32:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574969536;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=XMgsSwZQeQUSGV+wli5DvraayuJweYcClot3naZXyqM=;
        b=hLcSWRs/n1CdxLodM7SxyCgkHCxx1D5x0WHnUgzavxQkp+GGWu1LnUHYInTLd+0j5OjCA0
        iM24ABE73V/DSa6E8nVzYKgu70dk33tRKzS6dONCNr/xL74n4IaYZ4sQubBWvePC+CE6HV
        gFH61NBJofk3hl06UNxHZImPdaeZz+4=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-322-ohE4txYTMCOZV-f2npVddA-1; Thu, 28 Nov 2019 14:32:15 -0500
Received: by mail-qt1-f198.google.com with SMTP id x8so15793278qtq.14
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2019 11:32:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UsdxgTYnGq5qlzCPxK2R/zyMAt8PsfASdePTB4mVfio=;
        b=nS+XgUDTnq5KuBFiIST+6hg1aQownuHFqckhD9ljQHXu8ZE95x13475j1EE1iJGzxT
         4PfBMEvzVs/v+2ucVs6gYlWjFyZ7NGvzhR/k8A8wjPaKV7/VzqPW8T4rhn0GxzLUN2J6
         gDpauD9lsNDvBuc4/+s5S2wfJMkxUv1R10TDtA/J223UA7yppKsQc6fVT4+K1GcxyqG1
         sZmsd2sDuc/WqqzKmmnsQm1mDuWmnyVZsy34H7WQ1HBaCPKnhvFwoe/0+pbCUzytzPuk
         28nxu3q9DZSNcRWwz7p7AqFKKUACeHGg9BbiUdC9kbPosQaLsc6+KHVOGmfKQadihVK/
         TNGQ==
X-Gm-Message-State: APjAAAVKJIU7+fh310zKgkpsx1xTGz+F6dz2fc+nGv/X4DMiNuzt5wc+
        z6YzJdEb5zluFs+F6XtNNE8JS3HvDualyf0GZ0vfjK0NafB+vKwk3OHlHgMnIu33D8B8Nbv2HFt
        JNr6sud+4Z3rNUMdZG3xPSavc
X-Received: by 2002:a37:5942:: with SMTP id n63mr11663945qkb.432.1574969534100;
        Thu, 28 Nov 2019 11:32:14 -0800 (PST)
X-Google-Smtp-Source: APXvYqx2kY7sAyhyavXxVXch1pzKTwKJrrOIiaxnEiIEDCsPRfNWlBYZUpXZzMOMBRn088FhlV7mjA==
X-Received: by 2002:a37:5942:: with SMTP id n63mr11663920qkb.432.1574969533797;
        Thu, 28 Nov 2019 11:32:13 -0800 (PST)
Received: from xz-x1.yyz.redhat.com ([104.156.64.74])
        by smtp.gmail.com with ESMTPSA id x6sm2273178qke.127.2019.11.28.11.32.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2019 11:32:12 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     peterx@redhat.com, Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Nitesh Narayan Lal <nitesh@redhat.com>
Subject: [PATCH] KVM: X86: Use APIC_DEST_* macros properly
Date:   Thu, 28 Nov 2019 14:32:11 -0500
Message-Id: <20191128193211.32684-1-peterx@redhat.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
X-MC-Unique: ohE4txYTMCOZV-f2npVddA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previously we were using either APIC_DEST_PHYSICAL|APIC_DEST_LOGICAL
or 0|1 to fill in kvm_lapic_irq.dest_mode, and it's done in an adhoc
way.  It's fine imho only because in most cases when we check against
dest_mode it's against APIC_DEST_PHYSICAL (which equals to 0).
However, that's not consistent, majorly because APIC_DEST_LOGICAL does
not equals to 1, so if one day we check irq.dest_mode against
APIC_DEST_LOGICAL we'll probably always get a false returned.

This patch replaces the 0/1 settings of irq.dest_mode with the macros
to make them consistent.

CC: Paolo Bonzini <pbonzini@redhat.com>
CC: Sean Christopherson <sean.j.christopherson@intel.com>
CC: Vitaly Kuznetsov <vkuznets@redhat.com>
CC: Nitesh Narayan Lal <nitesh@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/x86/kvm/ioapic.c   | 9 ++++++---
 arch/x86/kvm/irq_comm.c | 7 ++++---
 arch/x86/kvm/x86.c      | 2 +-
 3 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kvm/ioapic.c b/arch/x86/kvm/ioapic.c
index 9fd2dd89a1c5..1e091637d5d5 100644
--- a/arch/x86/kvm/ioapic.c
+++ b/arch/x86/kvm/ioapic.c
@@ -331,7 +331,8 @@ static void ioapic_write_indirect(struct kvm_ioapic *io=
apic, u32 val)
 =09=09=09irq.vector =3D e->fields.vector;
 =09=09=09irq.delivery_mode =3D e->fields.delivery_mode << 8;
 =09=09=09irq.dest_id =3D e->fields.dest_id;
-=09=09=09irq.dest_mode =3D e->fields.dest_mode;
+=09=09=09irq.dest_mode =3D e->fields.dest_mode ?
+=09=09=09    APIC_DEST_LOGICAL : APIC_DEST_PHYSICAL;
 =09=09=09bitmap_zero(&vcpu_bitmap, 16);
 =09=09=09kvm_bitmap_or_dest_vcpus(ioapic->kvm, &irq,
 =09=09=09=09=09=09 &vcpu_bitmap);
@@ -343,7 +344,8 @@ static void ioapic_write_indirect(struct kvm_ioapic *io=
apic, u32 val)
 =09=09=09=09 * keep ioapic_handled_vectors synchronized.
 =09=09=09=09 */
 =09=09=09=09irq.dest_id =3D old_dest_id;
-=09=09=09=09irq.dest_mode =3D old_dest_mode;
+=09=09=09=09irq.dest_mode =3D old_dest_mode ?
+=09=09=09=09    APIC_DEST_LOGICAL : APIC_DEST_PHYSICAL;
 =09=09=09=09kvm_bitmap_or_dest_vcpus(ioapic->kvm, &irq,
 =09=09=09=09=09=09=09 &vcpu_bitmap);
 =09=09=09}
@@ -369,7 +371,8 @@ static int ioapic_service(struct kvm_ioapic *ioapic, in=
t irq, bool line_status)
=20
 =09irqe.dest_id =3D entry->fields.dest_id;
 =09irqe.vector =3D entry->fields.vector;
-=09irqe.dest_mode =3D entry->fields.dest_mode;
+=09irqe.dest_mode =3D entry->fields.dest_mode ?
+=09    APIC_DEST_LOGICAL : APIC_DEST_PHYSICAL;
 =09irqe.trig_mode =3D entry->fields.trig_mode;
 =09irqe.delivery_mode =3D entry->fields.delivery_mode << 8;
 =09irqe.level =3D 1;
diff --git a/arch/x86/kvm/irq_comm.c b/arch/x86/kvm/irq_comm.c
index 8ecd48d31800..673b6afd6dbf 100644
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
+=09irq->dest_mode =3D (1 << MSI_ADDR_DEST_MODE_SHIFT) & e->msi.address_lo =
?
+=09    APIC_DEST_LOGICAL : APIC_DEST_PHYSICAL;
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

