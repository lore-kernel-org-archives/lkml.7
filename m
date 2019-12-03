Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D47CC432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 16:59:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2FD820866
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 16:59:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O8TkP7Tz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727286AbfLCQ7R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 11:59:17 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:40333 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727217AbfLCQ7O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 11:59:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575392353;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=14g8RaA5piWvH+2ustd/wNI5q+TQc8KxgzZhf+/2kiM=;
        b=O8TkP7TzvUkieVIYs5OP/ipt/NZJSwaZbus02oYAdqvRQryZlMMfpYulm1zqOlfraVqA0W
        zJKVa/hRxoDekOVKmx8U6LhVBmGMMbYd+Mzn2MgkjKZmqqjvm2xdIfHypaBa0YLGEJs9Nb
        6AWHQ8ZUvhvO6sBPK/kHB+qRU79YAX0=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-405-AbNR-k8BPpaEYCm2lrtlrA-1; Tue, 03 Dec 2019 11:59:12 -0500
Received: by mail-qt1-f198.google.com with SMTP id l4so2840369qte.18
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2019 08:59:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dMSAhkBc+XDUp7X0JKW/OfiFquvplAZgCqXULfdRF2I=;
        b=FaXt/RA+vYyKU/sQYnUcVGANPAw0+WenS2c7biNbPFfYUke3o0p3wEx6aUr1LXlCt0
         E48eX5eXU3G6c4mlodLHlpwj5jT5edNgJQdA2U4tPfY5w5gHorpLGZD4+Aa8hTAMNZic
         wp/PmFi2ec5/vETcw75UUY6lPfXXzNKng6kkSWhgMxd+i58kPUDlt47jkqOFmUai8vjZ
         SSFizZrHR0dl07ypTj5R1KaaxPhCl+wU8oVRx6vuPy7FZnfaQBbNFOcbDPilBZn9akDV
         PmWgHYYZpqsWyOufxbvNxnWKYkN3r0cFEF7oI038ZmTS0kGO0M69jdiv9GLLd4b65jc7
         R78w==
X-Gm-Message-State: APjAAAXYfjXlffzMpy3slGIe4inysAJ/EXsDprAsysHs7mu3P6c3xQpV
        AamBngWyxlKGAxtaq+hWBoikhH1K8RXF/8os5jS/1TnNsrEZHa3EYy02AdUj+mHfgysm/33XJXW
        j4fyCzBVbn/O7lmsQsLYq2qrQ
X-Received: by 2002:ac8:4813:: with SMTP id g19mr6086867qtq.165.1575392351671;
        Tue, 03 Dec 2019 08:59:11 -0800 (PST)
X-Google-Smtp-Source: APXvYqwhOExZF/82Calck5ed4HtF0UB8ns8wW9p0mAS3lY9jroDNugbV1+DN2S5djA6t1ZB7YgfJ5A==
X-Received: by 2002:ac8:4813:: with SMTP id g19mr6086847qtq.165.1575392351452;
        Tue, 03 Dec 2019 08:59:11 -0800 (PST)
Received: from xz-x1.yyz.redhat.com ([104.156.64.74])
        by smtp.gmail.com with ESMTPSA id a16sm482585qkn.48.2019.12.03.08.59.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2019 08:59:10 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Nitesh Narayan Lal <nitesh@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        peterx@redhat.com, Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: [PATCH v4 4/6] KVM: X86: Drop KVM_APIC_SHORT_MASK and KVM_APIC_DEST_MASK
Date:   Tue,  3 Dec 2019 11:59:01 -0500
Message-Id: <20191203165903.22917-5-peterx@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191203165903.22917-1-peterx@redhat.com>
References: <20191203165903.22917-1-peterx@redhat.com>
MIME-Version: 1.0
X-MC-Unique: AbNR-k8BPpaEYCm2lrtlrA-1
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

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>
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

