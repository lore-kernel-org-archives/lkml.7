Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1091AC432C3
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 16:59:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8D252073F
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 16:59:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WWUihS3+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727308AbfLCQ7U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 11:59:20 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:45663 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727254AbfLCQ7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 11:59:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575392354;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EbbDA8eBzmrrmvpNYXesODqmal32f0agXVmci0jBwiY=;
        b=WWUihS3+FbM84emteup784ANuWqQR/6Dn/+94P7F9FH9t3qZ3CgCHRaDdH+O6qIHmBMu7n
        Znihz96exwCo8qdzHneZG+2JNaVysIM2Ceu7ew7RWuuu8JH78C8+3O0fSNA0D1NkjdYMUa
        YyjheS+ooBG33dVhOgTA2d/+wvP+rFs=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-119-LuWvLcqJMo-qrv8NS0jq4Q-1; Tue, 03 Dec 2019 11:59:13 -0500
Received: by mail-qt1-f200.google.com with SMTP id a20so1423657qtp.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2019 08:59:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X1aOoFKR3ey7vYZ+BVQXR0mg8IAiU6yM63K4W6de1EU=;
        b=HwoTW8RHSaz7CcfjDY2iVAtnyjvn0m2DUxWJK0/QaCAFjRkPGfLd/jHvl2GM8i5g7x
         gMx8psouSnVg063ChbhrcMmgkKT+/DZTIbi/P7itjOlO+Vq2DWptKjDDbUfQi588UCB7
         r7MZGOW7nmsQeR1Fz5fSUUo9JV3qXzZEFOV4NgEkDO8/6u49ofrAwKuKvH+3oEUPpdYS
         0ae34X8DNyqaR3diy07SRXXQz3zRz+QjxuoyC6ljd98o8Hixaw1aQ6wn9dc7jMxzyXlL
         +QzKiKmX0nFKBt+1SF5P8x+K/w4QRDhtYXeE4eaVtQs/CPlzD9rR0sVgod72A12Pgx+J
         b0lw==
X-Gm-Message-State: APjAAAVdSnC5lQ3hbW0JguBjgxgOgszrN7lvvxGKsyf2AWz7xWzbumRr
        eLeVs1V9XO5g4KuEfAVg5et5Dsisz61e07Ce0E7d3g6u1ZVAWjHW8KCJVdLu6lPY3w8T7/bcR1a
        1d3frE03ypbv3NBIznMDgldFy
X-Received: by 2002:a05:6214:6ad:: with SMTP id s13mr6005918qvz.208.1575392352969;
        Tue, 03 Dec 2019 08:59:12 -0800 (PST)
X-Google-Smtp-Source: APXvYqzGh7RoR7bXUGd1EORpILas9d+Vrxhpz2zfR0xOT0S88RHqKjgS/dHqRB0sUoTvPCbET7czXw==
X-Received: by 2002:a05:6214:6ad:: with SMTP id s13mr6005894qvz.208.1575392352740;
        Tue, 03 Dec 2019 08:59:12 -0800 (PST)
Received: from xz-x1.yyz.redhat.com ([104.156.64.74])
        by smtp.gmail.com with ESMTPSA id a16sm482585qkn.48.2019.12.03.08.59.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2019 08:59:11 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Nitesh Narayan Lal <nitesh@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        peterx@redhat.com, Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: [PATCH v4 5/6] KVM: X86: Fix callers of kvm_apic_match_dest() to use correct macros
Date:   Tue,  3 Dec 2019 11:59:02 -0500
Message-Id: <20191203165903.22917-6-peterx@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191203165903.22917-1-peterx@redhat.com>
References: <20191203165903.22917-1-peterx@redhat.com>
MIME-Version: 1.0
X-MC-Unique: LuWvLcqJMo-qrv8NS0jq4Q-1
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
Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/x86/kvm/ioapic.c   | 11 +++++++----
 arch/x86/kvm/irq_comm.c |  3 ++-
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/ioapic.c b/arch/x86/kvm/ioapic.c
index e623a4f8d27e..f53daeaaeb37 100644
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
+=09=09=09=09 kvm_lapic_irq_dest_mode(!!e->fields.dest_mode)))
 =09=09return;
=20
 =09new_val =3D kvm_apic_pending_eoi(vcpu, e->fields.vector);
@@ -250,8 +251,10 @@ void kvm_ioapic_scan_entry(struct kvm_vcpu *vcpu, ulon=
g *ioapic_handled_vectors)
 =09=09if (e->fields.trig_mode =3D=3D IOAPIC_LEVEL_TRIG ||
 =09=09    kvm_irq_has_notifier(ioapic->kvm, KVM_IRQCHIP_IOAPIC, index) ||
 =09=09    index =3D=3D RTC_GSI) {
-=09=09=09if (kvm_apic_match_dest(vcpu, NULL, 0,
-=09=09=09             e->fields.dest_id, e->fields.dest_mode) ||
+=09=09=09u16 dm =3D kvm_lapic_irq_dest_mode(!!e->fields.dest_mode);
+
+=09=09=09if (kvm_apic_match_dest(vcpu, NULL, APIC_DEST_NOSHORT,
+=09=09=09=09=09=09e->fields.dest_id, dm) ||
 =09=09=09    kvm_apic_pending_eoi(vcpu, e->fields.vector))
 =09=09=09=09__set_bit(e->fields.vector,
 =09=09=09=09=09  ioapic_handled_vectors);
diff --git a/arch/x86/kvm/irq_comm.c b/arch/x86/kvm/irq_comm.c
index 22108ed66a76..7d083f71fc8e 100644
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

