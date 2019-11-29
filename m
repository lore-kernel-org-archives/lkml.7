Return-Path: <SRS0=nTU8=ZV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C0ECC432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 21:35:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B425207FA
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 21:35:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RXYlRi5V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727386AbfK2VfS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Nov 2019 16:35:18 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:49160 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727166AbfK2VfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Nov 2019 16:35:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575063313;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nk+AMYp/B5018WGXHd+pNlZDxGbWGzQP/gZBrdpp4/w=;
        b=RXYlRi5Vi7FJBblKszuB+gFkuACRyUc+e72wvBOZb4pUqwli9scpTosUJHltulONaCwyv8
        z2F5aanWkP1U/rwLTbVO0H1bC5Wtr8W5SPTV/Sz1++4IS+k71vAFyzvYZuRDuQDMCHqtLP
        ojHkO4VM+uA/rbnxNBr7sgCr8jEYQeY=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-253-vKRijHkbP0yJaLTTe0pxgQ-1; Fri, 29 Nov 2019 16:35:11 -0500
Received: by mail-qt1-f200.google.com with SMTP id v92so19635997qtd.18
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2019 13:35:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZBxIG8UMSN4DcK848hz6hNmhnmdyT63k+9vVPNH+Rtk=;
        b=l4/qjvd5kMvVPw8S0EvP8DFsI3EkYWleViETKI5BDk4QeH0m5AP+Y/aBAxThqEZ+B3
         87xmTHzclXLxKD/sbFeP5fjqXR/qxZ2qiiWQRvCeVUMDUtBVddAQw1KGOIpo8IYs25/Y
         G3a3F+ZMZtZsxz1ZfYtwGOCw/nZopC/CCuWNZCss6LrNd6AECkMvSxHWMm3QrusP6e+g
         VFtgnjwX0CjQruuNrse99l7mFv0L5Ou7b/Ii8uSz/zfKXDfaxq6hmOJoELRzws1fkarQ
         Jt+JL81PtSxBag30a3/0o4hZz5XQJ1uSJa5fo7/DAZsk+jcoXN9wCn/axOGhaA063CMt
         fiYg==
X-Gm-Message-State: APjAAAVcj0Vuj22wsOgNpl9PV066/yqtLwfTaIdWVBAL6e/s4J/1ot+L
        mbGiBXVSa56/RXpaVd+8EFrQlRg8tpXuR7PAUbVQblpuEb2IEmP2OIPSk1QtZouwN2e7YtMmNeI
        y8ZtXcf7Q+30nCNmlKdYOe1XG
X-Received: by 2002:ad4:4bc2:: with SMTP id l2mr9372706qvw.50.1575063311142;
        Fri, 29 Nov 2019 13:35:11 -0800 (PST)
X-Google-Smtp-Source: APXvYqxotUIlHNSr/8iS+DZ+KTBCqLO8S5vzYAHxSYPZIcfOoaZ/NoLxHiCXQAhCdpl46tcNdIw+/g==
X-Received: by 2002:ad4:4bc2:: with SMTP id l2mr9372678qvw.50.1575063310867;
        Fri, 29 Nov 2019 13:35:10 -0800 (PST)
Received: from xz-x1.yyz.redhat.com ([104.156.64.74])
        by smtp.gmail.com with ESMTPSA id h186sm10679046qkf.64.2019.11.29.13.35.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2019 13:35:09 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: [PATCH RFC 02/15] KVM: Add kvm/vcpu argument to mark_dirty_page_in_slot
Date:   Fri, 29 Nov 2019 16:34:52 -0500
Message-Id: <20191129213505.18472-3-peterx@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191129213505.18472-1-peterx@redhat.com>
References: <20191129213505.18472-1-peterx@redhat.com>
MIME-Version: 1.0
X-MC-Unique: vKRijHkbP0yJaLTTe0pxgQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Cao, Lei" <Lei.Cao@stratus.com>

Signed-off-by: Cao, Lei <Lei.Cao@stratus.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 virt/kvm/kvm_main.c | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index fac0760c870e..8f8940cc4b84 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -145,7 +145,10 @@ static void hardware_disable_all(void);
=20
 static void kvm_io_bus_destroy(struct kvm_io_bus *bus);
=20
-static void mark_page_dirty_in_slot(struct kvm_memory_slot *memslot, gfn_t=
 gfn);
+static void mark_page_dirty_in_slot(struct kvm *kvm,
+=09=09=09=09    struct kvm_vcpu *vcpu,
+=09=09=09=09    struct kvm_memory_slot *memslot,
+=09=09=09=09    gfn_t gfn);
=20
 __visible bool kvm_rebooting;
 EXPORT_SYMBOL_GPL(kvm_rebooting);
@@ -2077,7 +2080,8 @@ int kvm_vcpu_read_guest_atomic(struct kvm_vcpu *vcpu,=
 gpa_t gpa,
 }
 EXPORT_SYMBOL_GPL(kvm_vcpu_read_guest_atomic);
=20
-static int __kvm_write_guest_page(struct kvm_memory_slot *memslot, gfn_t g=
fn,
+static int __kvm_write_guest_page(struct kvm *kvm, struct kvm_vcpu *vcpu,
+=09=09=09=09  struct kvm_memory_slot *memslot, gfn_t gfn,
 =09=09=09          const void *data, int offset, int len)
 {
 =09int r;
@@ -2089,7 +2093,7 @@ static int __kvm_write_guest_page(struct kvm_memory_s=
lot *memslot, gfn_t gfn,
 =09r =3D __copy_to_user((void __user *)addr + offset, data, len);
 =09if (r)
 =09=09return -EFAULT;
-=09mark_page_dirty_in_slot(memslot, gfn);
+=09mark_page_dirty_in_slot(kvm, vcpu, memslot, gfn);
 =09return 0;
 }
=20
@@ -2098,7 +2102,8 @@ int kvm_write_guest_page(struct kvm *kvm, gfn_t gfn,
 {
 =09struct kvm_memory_slot *slot =3D gfn_to_memslot(kvm, gfn);
=20
-=09return __kvm_write_guest_page(slot, gfn, data, offset, len);
+=09return __kvm_write_guest_page(kvm, NULL, slot, gfn, data,
+=09=09=09=09      offset, len);
 }
 EXPORT_SYMBOL_GPL(kvm_write_guest_page);
=20
@@ -2107,7 +2112,8 @@ int kvm_vcpu_write_guest_page(struct kvm_vcpu *vcpu, =
gfn_t gfn,
 {
 =09struct kvm_memory_slot *slot =3D kvm_vcpu_gfn_to_memslot(vcpu, gfn);
=20
-=09return __kvm_write_guest_page(slot, gfn, data, offset, len);
+=09return __kvm_write_guest_page(vcpu->kvm, vcpu, slot, gfn, data,
+=09=09=09=09      offset, len);
 }
 EXPORT_SYMBOL_GPL(kvm_vcpu_write_guest_page);
=20
@@ -2221,7 +2227,7 @@ int kvm_write_guest_offset_cached(struct kvm *kvm, st=
ruct gfn_to_hva_cache *ghc,
 =09r =3D __copy_to_user((void __user *)ghc->hva + offset, data, len);
 =09if (r)
 =09=09return -EFAULT;
-=09mark_page_dirty_in_slot(ghc->memslot, gpa >> PAGE_SHIFT);
+=09mark_page_dirty_in_slot(kvm, NULL, ghc->memslot, gpa >> PAGE_SHIFT);
=20
 =09return 0;
 }
@@ -2286,7 +2292,9 @@ int kvm_clear_guest(struct kvm *kvm, gpa_t gpa, unsig=
ned long len)
 }
 EXPORT_SYMBOL_GPL(kvm_clear_guest);
=20
-static void mark_page_dirty_in_slot(struct kvm_memory_slot *memslot,
+static void mark_page_dirty_in_slot(struct kvm *kvm,
+=09=09=09=09    struct kvm_vcpu *vcpu,
+=09=09=09=09    struct kvm_memory_slot *memslot,
 =09=09=09=09    gfn_t gfn)
 {
 =09if (memslot && memslot->dirty_bitmap) {
@@ -2301,7 +2309,7 @@ void mark_page_dirty(struct kvm *kvm, gfn_t gfn)
 =09struct kvm_memory_slot *memslot;
=20
 =09memslot =3D gfn_to_memslot(kvm, gfn);
-=09mark_page_dirty_in_slot(memslot, gfn);
+=09mark_page_dirty_in_slot(kvm, NULL, memslot, gfn);
 }
 EXPORT_SYMBOL_GPL(mark_page_dirty);
=20
@@ -2310,7 +2318,7 @@ void kvm_vcpu_mark_page_dirty(struct kvm_vcpu *vcpu, =
gfn_t gfn)
 =09struct kvm_memory_slot *memslot;
=20
 =09memslot =3D kvm_vcpu_gfn_to_memslot(vcpu, gfn);
-=09mark_page_dirty_in_slot(memslot, gfn);
+=09mark_page_dirty_in_slot(vcpu->kvm, vcpu, memslot, gfn);
 }
 EXPORT_SYMBOL_GPL(kvm_vcpu_mark_page_dirty);
=20
--=20
2.21.0

