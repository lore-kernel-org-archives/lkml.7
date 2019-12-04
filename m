Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E0DBC43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 19:07:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E0762073B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 19:07:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FC9f1fOa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729032AbfLDTHo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 14:07:44 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:51903 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728902AbfLDTHf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 14:07:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575486454;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uQ4VjfIYrglflf3rJiON69ppSn0JgIlW3dfwal7bm4Y=;
        b=FC9f1fOaqdUgUzVhMtE1qFNBHdWpMXGExkViZIgqj2rWMg/Grt6XyORigHb6d7j2exSQLW
        Tv8JsXNYI8DbShN+GQ9M6INr89pFDQ8V0cNwbzRz5dFsk1viXCp702Vv1i7WPNHKqTdiy9
        Upv/m16kZD6+qtnTLyNRuMlWLYNHvu0=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-313-Tg5ztKzeM2K4ZiFzTq0ZDQ-1; Wed, 04 Dec 2019 14:07:33 -0500
Received: by mail-qt1-f200.google.com with SMTP id g13so605795qtq.16
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2019 11:07:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wqX1WpDnk793hPGykZVwJa0dz2ySQCsCHFOl+w7F7+Q=;
        b=JaslevRnA+WAy1S+CX53p9JNxgLHpYBHY4LN3mnh7v9IPgM37/bzIp6LTmQG68MXFm
         SR/kAuyejfcBKOLRmiNsdPJYAfAO9/vZefyIQ8HhnhUgnIOI77aaaYUG+Uf9SnHpavj+
         4d1/8Q3dzUTsDE+xkV/S/nQOzYChID/FsUz1yMl4+DN7FyIsznqEtXRnYuc2eSfMzNqj
         8QCuUTDGYQoo5wsxJ75LQNCPa7AhVCst4Ol5RklUn6CaXo5Rk5ffVN5VHtDxf2HCeaAp
         k0KL/c4RT/OFz/X7Cz422l7nTrV86/KUzvDGgI0eLs39SsSaYHUgAWrS3ab3jWgXYN45
         t7ww==
X-Gm-Message-State: APjAAAWM/GK/SYHcJ4qsC9L6FuqZAbJWhWtXBfHp6bX94BOdKxARQnJP
        eXd7L0qeAQW+5S6NIqA4N+wfMn6TcanobeJUnw4g7U0QeulyVd+Eu8w8X8m30/QugD7T6VnpSSf
        6YzDEHxbwriCLfDHUmYvFgmDf
X-Received: by 2002:ad4:4908:: with SMTP id bh8mr4161473qvb.251.1575486452788;
        Wed, 04 Dec 2019 11:07:32 -0800 (PST)
X-Google-Smtp-Source: APXvYqwEvT/Ded38f7safdU21KIFiL1aXou5MYGRU1P1kBbugrZwGKwljjsV/vT2lZcdGelzIUricw==
X-Received: by 2002:ad4:4908:: with SMTP id bh8mr4161445qvb.251.1575486452527;
        Wed, 04 Dec 2019 11:07:32 -0800 (PST)
Received: from xz-x1.yyz.redhat.com ([104.156.64.74])
        by smtp.gmail.com with ESMTPSA id y18sm4072126qtn.11.2019.12.04.11.07.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2019 11:07:31 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Nitesh Narayan Lal <nitesh@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        peterx@redhat.com, Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: [PATCH v5 6/6] KVM: X86: Conert the last users of "shorthand = 0" to use macros
Date:   Wed,  4 Dec 2019 14:07:21 -0500
Message-Id: <20191204190721.29480-7-peterx@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191204190721.29480-1-peterx@redhat.com>
References: <20191204190721.29480-1-peterx@redhat.com>
MIME-Version: 1.0
X-MC-Unique: Tg5ztKzeM2K4ZiFzTq0ZDQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change the last users of "shorthand =3D 0" to use APIC_DEST_NOSHORT.

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/x86/kvm/ioapic.c   | 4 ++--
 arch/x86/kvm/irq_comm.c | 2 +-
 arch/x86/kvm/x86.c      | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/ioapic.c b/arch/x86/kvm/ioapic.c
index f53daeaaeb37..77538fd77dc2 100644
--- a/arch/x86/kvm/ioapic.c
+++ b/arch/x86/kvm/ioapic.c
@@ -330,7 +330,7 @@ static void ioapic_write_indirect(struct kvm_ioapic *io=
apic, u32 val)
 =09=09if (e->fields.delivery_mode =3D=3D APIC_DM_FIXED) {
 =09=09=09struct kvm_lapic_irq irq;
=20
-=09=09=09irq.shorthand =3D 0;
+=09=09=09irq.shorthand =3D APIC_DEST_NOSHORT;
 =09=09=09irq.vector =3D e->fields.vector;
 =09=09=09irq.delivery_mode =3D e->fields.delivery_mode << 8;
 =09=09=09irq.dest_id =3D e->fields.dest_id;
@@ -379,7 +379,7 @@ static int ioapic_service(struct kvm_ioapic *ioapic, in=
t irq, bool line_status)
 =09irqe.trig_mode =3D entry->fields.trig_mode;
 =09irqe.delivery_mode =3D entry->fields.delivery_mode << 8;
 =09irqe.level =3D 1;
-=09irqe.shorthand =3D 0;
+=09irqe.shorthand =3D APIC_DEST_NOSHORT;
 =09irqe.msi_redir_hint =3D false;
=20
 =09if (irqe.trig_mode =3D=3D IOAPIC_EDGE_TRIG)
diff --git a/arch/x86/kvm/irq_comm.c b/arch/x86/kvm/irq_comm.c
index 7d083f71fc8e..9d711c2451c7 100644
--- a/arch/x86/kvm/irq_comm.c
+++ b/arch/x86/kvm/irq_comm.c
@@ -121,7 +121,7 @@ void kvm_set_msi_irq(struct kvm *kvm, struct kvm_kernel=
_irq_routing_entry *e,
 =09irq->msi_redir_hint =3D ((e->msi.address_lo
 =09=09& MSI_ADDR_REDIRECTION_LOWPRI) > 0);
 =09irq->level =3D 1;
-=09irq->shorthand =3D 0;
+=09irq->shorthand =3D APIC_DEST_NOSHORT;
 }
 EXPORT_SYMBOL_GPL(kvm_set_msi_irq);
=20
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 3b00d662dc14..f6d778436e15 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -7355,7 +7355,7 @@ static void kvm_pv_kick_cpu_op(struct kvm *kvm, unsig=
ned long flags, int apicid)
 {
 =09struct kvm_lapic_irq lapic_irq;
=20
-=09lapic_irq.shorthand =3D 0;
+=09lapic_irq.shorthand =3D APIC_DEST_NOSHORT;
 =09lapic_irq.dest_mode =3D APIC_DEST_PHYSICAL;
 =09lapic_irq.level =3D 0;
 =09lapic_irq.dest_id =3D apicid;
--=20
2.21.0

