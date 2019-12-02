Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E1D1C43215
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 20:13:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35D3D21774
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 20:13:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aO+chg+i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728238AbfLBUNo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 15:13:44 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:26069 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728150AbfLBUN3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 15:13:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575317609;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hGyv0HcV61jwW8d05G9E2IdyBpBV7NLYzlcgkoWtE1A=;
        b=aO+chg+ijsWPtKjp7zVXqrI2PKwa5lqc/bOWKgQBrXbq7v1z2/QIVWK1J9rjYe0NPneNyf
        R4OjAgIOI8qf22DTqplK3yfSHVK+KyhGvCYcus5gVMqQnAnAegtdsuSH1YzaQwO4tNOBEV
        GBuHBJAUu7CAxABFaRZEkmRdkmAG308=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-257-frWkKpoUM6efzHCu7mA3XA-1; Mon, 02 Dec 2019 15:13:28 -0500
Received: by mail-qv1-f71.google.com with SMTP id g6so554998qvp.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2019 12:13:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=D/FzhMnEoda/8HIh8/dn3z8Z/X2H7yZOxK6TY6H8n7g=;
        b=CPO7rsvRGo3M1i/8zP++e2ePKBPXkMjMh/GFNsFbn+FxgIhDydc6H52RZYFyAy9cej
         FpTbOIDv7BlxIIqfwIgXClyH2TsMk1yQzhRcBhvhF0fMYIrJCe75+lko/PI6RA0+Wupu
         2UutV2ngutSvii1HA8rZ+K7uJjpKgDYzuf7VmDmrweBv0VmdBkVkvBKsUWaJ9cnjpN0+
         FzNnnoZEvSjEamEd50wzHj8oOiCkfUdWEDCr/KfnLDlmDKO1r6QaaPIYj61ywLPQt9Jk
         5jp9sn7+EUiFO5Yzzz5xAUDfQW6qM6Dvk9TgdvOlnRElfr3ydM/mayizX97QCLg8acyh
         pvHg==
X-Gm-Message-State: APjAAAVD9Ww6Rns60vV1izWKSGR3aA8N7OF3xVaHU+/UaRzh7ue736An
        Wnrgem+/svBPTaAi1UXnEiy6amCLcJFb2pmRCUrubvyZgXjSLtrpJWL7zTGY5UXZkfTnyDoayu0
        xnOWAMUR8f5/C+sicddc0LvSH
X-Received: by 2002:ac8:4a8a:: with SMTP id l10mr1303332qtq.198.1575317607420;
        Mon, 02 Dec 2019 12:13:27 -0800 (PST)
X-Google-Smtp-Source: APXvYqyJIT5O2PIq2hBfIXIZv6d47L3iz/6K6nfkU3HOvroWZken45053jQWJDbUYGB3TtnE632I4A==
X-Received: by 2002:ac8:4a8a:: with SMTP id l10mr1303310qtq.198.1575317607172;
        Mon, 02 Dec 2019 12:13:27 -0800 (PST)
Received: from xz-x1.yyz.redhat.com ([104.156.64.74])
        by smtp.gmail.com with ESMTPSA id b6sm342410qtp.5.2019.12.02.12.13.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2019 12:13:26 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Nitesh Narayan Lal <nitesh@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        peterx@redhat.com, Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: [PATCH v3 5/5] KVM: X86: Fix callers of kvm_apic_match_dest() to use correct macros
Date:   Mon,  2 Dec 2019 15:13:14 -0500
Message-Id: <20191202201314.543-6-peterx@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191202201314.543-1-peterx@redhat.com>
References: <20191202201314.543-1-peterx@redhat.com>
MIME-Version: 1.0
X-MC-Unique: frWkKpoUM6efzHCu7mA3XA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Callers of kvm_apic_match_dest() should always pass in APIC_DEST_*
macros for either dest_mode and short_hand parameters.  Fix up all the
callers of kvm_apic_match_dest() that are not following the rule.

Reported-by: Sean Christopherson <sean.j.christopherson@intel.com>
Reported-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/x86/kvm/ioapic.c   | 11 +++++++----
 arch/x86/kvm/irq_comm.c |  3 ++-
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/ioapic.c b/arch/x86/kvm/ioapic.c
index 901d85237d1c..1082ca8d11e5 100644
--- a/arch/x86/kvm/ioapic.c
+++ b/arch/x86/kvm/ioapic.c
@@ -108,8 +108,9 @@ static void __rtc_irq_eoi_tracking_restore_one(struct k=
vm_vcpu *vcpu)
 =09union kvm_ioapic_redirect_entry *e;
=20
 =09e =3D &ioapic->redirtbl[RTC_GSI];
-=09if (!kvm_apic_match_dest(vcpu, NULL, 0,=09e->fields.dest_id,
-=09=09=09=09e->fields.dest_mode))
+=09if (!kvm_apic_match_dest(vcpu, NULL, APIC_DEST_NOSHORT,
+=09=09=09=09 e->fields.dest_id,
+=09=09=09=09 kvm_lapic_irq_dest_mode(e->fields.dest_mode)))
 =09=09return;
=20
 =09new_val =3D kvm_apic_pending_eoi(vcpu, e->fields.vector);
@@ -237,6 +238,7 @@ void kvm_ioapic_scan_entry(struct kvm_vcpu *vcpu, ulong=
 *ioapic_handled_vectors)
 =09struct dest_map *dest_map =3D &ioapic->rtc_status.dest_map;
 =09union kvm_ioapic_redirect_entry *e;
 =09int index;
+=09u16 dm;
=20
 =09spin_lock(&ioapic->lock);
=20
@@ -250,8 +252,9 @@ void kvm_ioapic_scan_entry(struct kvm_vcpu *vcpu, ulong=
 *ioapic_handled_vectors)
 =09=09if (e->fields.trig_mode =3D=3D IOAPIC_LEVEL_TRIG ||
 =09=09    kvm_irq_has_notifier(ioapic->kvm, KVM_IRQCHIP_IOAPIC, index) ||
 =09=09    index =3D=3D RTC_GSI) {
-=09=09=09if (kvm_apic_match_dest(vcpu, NULL, 0,
-=09=09=09             e->fields.dest_id, e->fields.dest_mode) ||
+=09=09=09dm =3D kvm_lapic_irq_dest_mode(e->fields.dest_mode);
+=09=09=09if (kvm_apic_match_dest(vcpu, NULL, APIC_DEST_NOSHORT,
+=09=09=09=09=09=09e->fields.dest_id, dm) ||
 =09=09=09    kvm_apic_pending_eoi(vcpu, e->fields.vector))
 =09=09=09=09__set_bit(e->fields.vector,
 =09=09=09=09=09  ioapic_handled_vectors);
diff --git a/arch/x86/kvm/irq_comm.c b/arch/x86/kvm/irq_comm.c
index 5f59e5ebdbed..e89c2160b39f 100644
--- a/arch/x86/kvm/irq_comm.c
+++ b/arch/x86/kvm/irq_comm.c
@@ -417,7 +417,8 @@ void kvm_scan_ioapic_routes(struct kvm_vcpu *vcpu,
=20
 =09=09=09kvm_set_msi_irq(vcpu->kvm, entry, &irq);
=20
-=09=09=09if (irq.level && kvm_apic_match_dest(vcpu, NULL, 0,
+=09=09=09if (irq.level &&
+=09=09=09    kvm_apic_match_dest(vcpu, NULL, APIC_DEST_NOSHORT,
 =09=09=09=09=09=09irq.dest_id, irq.dest_mode))
 =09=09=09=09__set_bit(irq.vector, ioapic_handled_vectors);
 =09=09}
--=20
2.21.0

