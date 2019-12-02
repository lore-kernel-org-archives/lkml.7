Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E8E5C43215
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 20:13:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 396D421774
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 20:13:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fCNDhPja"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728197AbfLBUNd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 15:13:33 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:37432 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728179AbfLBUNb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 15:13:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575317610;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=T7L1QC4sZLzLTqoiJLJWCwYXhhugr76FDNW4JXS4WHg=;
        b=fCNDhPjaDLzqc+6WZtTDik/BSbYCJr9yXB/ocAfR0EIwdtAqRdAftXj/Y0UyojPLLFF8A4
        h8LkbHlVBPR5ARo6kqe9su9BzewroZh+SYIDkKEvLxiEv3E+AmFfnVNhnSk7oqRkOzcKHw
        4FvKrSn/gELIRFmFPwj3oqn+4N5bBEE=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-379-syhaIM6xOneTYFZjuFUW-g-1; Mon, 02 Dec 2019 15:13:26 -0500
Received: by mail-qk1-f198.google.com with SMTP id p68so497361qkf.9
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2019 12:13:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IdAobF5KxkWmSZeeTAl/kA2XqKFNltZufrBJllpURpA=;
        b=MTT9ZiQOuP/BZ2+8MkBBEVmA+cW4Rxv2kZKdkuml1iyzLIMcvrEyB7TWF/nUxzVY+5
         v48SktkON5ECS3XAAH711O6eUdY0rKxCnoS7TaagqYd+NawhUp84fKaxHwUw5RxTZgEk
         AJ1iy2Z9XABuqy6n4wWTyFsMhjhI/NZpBwFg7oOJw5B/Eam0MOzgzB36n0HHp9VjZs1a
         xoGgh2VdzRIzJGRzfOkKbqBLHnI6Vju6Ts9YVCm591hsDPkbEjnBS+Bn9t703Qm2lFbK
         aBYFCndByHvPKBz2wDQ3n10AMMyQMptoYL8E5FSDqOi7aqX4YuNX15mHm9Krkw4PtK3d
         14kg==
X-Gm-Message-State: APjAAAXUd4bcAi5iXk2ksDWYwSXLK5UsQbPSLAFZefSuXNYPTYfsmjfZ
        00ALhgxd+1ThHHiggO+IYV6XZLqkkAAmvQniyq8athTszZDghTfkxlVeZ4dhqpOyCdr/gUJO7s9
        JbgTvEGVoZdmrp96i2BGPFqrH
X-Received: by 2002:a05:620a:102e:: with SMTP id a14mr786095qkk.159.1575317605928;
        Mon, 02 Dec 2019 12:13:25 -0800 (PST)
X-Google-Smtp-Source: APXvYqxEmfH5EcGeAkoaUvzsaIZoBstltQzghSFbzjr38dtpCINdSAr6Gawz4Ylo/zCpRToT4lqTKw==
X-Received: by 2002:a05:620a:102e:: with SMTP id a14mr786063qkk.159.1575317605660;
        Mon, 02 Dec 2019 12:13:25 -0800 (PST)
Received: from xz-x1.yyz.redhat.com ([104.156.64.74])
        by smtp.gmail.com with ESMTPSA id b6sm342410qtp.5.2019.12.02.12.13.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2019 12:13:24 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Nitesh Narayan Lal <nitesh@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        peterx@redhat.com, Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: [PATCH v3 4/5] KVM: X86: Drop KVM_APIC_SHORT_MASK and KVM_APIC_DEST_MASK
Date:   Mon,  2 Dec 2019 15:13:13 -0500
Message-Id: <20191202201314.543-5-peterx@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191202201314.543-1-peterx@redhat.com>
References: <20191202201314.543-1-peterx@redhat.com>
MIME-Version: 1.0
X-MC-Unique: syhaIM6xOneTYFZjuFUW-g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have both APIC_SHORT_MASK and KVM_APIC_SHORT_MASK defined for the
shorthand mask.  Similarly, we have both APIC_DEST_MASK and
KVM_APIC_DEST_MASK defined for the destination mode mask.

Drop the KVM_APIC_* macros and replace the only user of them to use
the APIC_DEST_* macros instead.  At the meantime, move APIC_SHORT_MASK
and APIC_DEST_MASK from lapic.c to lapic.h.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/x86/kvm/lapic.c | 3 ---
 arch/x86/kvm/lapic.h | 5 +++--
 arch/x86/kvm/svm.c   | 4 ++--
 3 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index 1eabe58bb6d5..805c18178bbf 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -56,9 +56,6 @@
 #define APIC_VERSION=09=09=09(0x14UL | ((KVM_APIC_LVT_NUM - 1) << 16))
 #define LAPIC_MMIO_LENGTH=09=09(1 << 12)
 /* followed define is not in apicdef.h */
-#define APIC_SHORT_MASK=09=09=090xc0000
-#define APIC_DEST_NOSHORT=09=090x0
-#define APIC_DEST_MASK=09=09=090x800
 #define MAX_APIC_VECTOR=09=09=09256
 #define APIC_VECTORS_PER_REG=09=0932
=20
diff --git a/arch/x86/kvm/lapic.h b/arch/x86/kvm/lapic.h
index 0b9bbadd1f3c..5a9f29ed9a4b 100644
--- a/arch/x86/kvm/lapic.h
+++ b/arch/x86/kvm/lapic.h
@@ -10,8 +10,9 @@
 #define KVM_APIC_SIPI=09=091
 #define KVM_APIC_LVT_NUM=096
=20
-#define KVM_APIC_SHORT_MASK=090xc0000
-#define KVM_APIC_DEST_MASK=090x800
+#define APIC_SHORT_MASK=09=09=090xc0000
+#define APIC_DEST_NOSHORT=09=090x0
+#define APIC_DEST_MASK=09=09=090x800
=20
 #define APIC_BUS_CYCLE_NS       1
 #define APIC_BUS_FREQUENCY      (1000000000ULL / APIC_BUS_CYCLE_NS)
diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
index 362e874297e4..65a27a7e9cb1 100644
--- a/arch/x86/kvm/svm.c
+++ b/arch/x86/kvm/svm.c
@@ -4519,9 +4519,9 @@ static int avic_incomplete_ipi_interception(struct vc=
pu_svm *svm)
 =09=09 */
 =09=09kvm_for_each_vcpu(i, vcpu, kvm) {
 =09=09=09bool m =3D kvm_apic_match_dest(vcpu, apic,
-=09=09=09=09=09=09     icrl & KVM_APIC_SHORT_MASK,
+=09=09=09=09=09=09     icrl & APIC_SHORT_MASK,
 =09=09=09=09=09=09     GET_APIC_DEST_FIELD(icrh),
-=09=09=09=09=09=09     icrl & KVM_APIC_DEST_MASK);
+=09=09=09=09=09=09     icrl & APIC_DEST_MASK);
=20
 =09=09=09if (m && !avic_vcpu_is_running(vcpu))
 =09=09=09=09kvm_vcpu_wake_up(vcpu);
--=20
2.21.0

