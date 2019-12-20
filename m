Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC63CC43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 21:16:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B60F206DA
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 21:16:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XKfypzCn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727536AbfLTVQl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 16:16:41 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:27502 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727506AbfLTVQl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 16:16:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576876600;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5u+NdTdcxJqnd4CDcK36kvrGYVN4B69rZJAB5gjRDOQ=;
        b=XKfypzCnnuG8ym16HqYjIAMV/6Jx0su0I62m3jXSoXXerZSvjEZzMVNCXlmqg0eShinQFt
        ckNZZ+StSvBoPDLVM8ubNPXRudfz+8BkTCIpJ5VbRJRrdNCXdV2uahWkFXuNJPB1r+c7U0
        +9ukiSVntmtl6EQAhXGg+3NdcDFGK24=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-63-t_SmpKo-MGqV-NIlXBbArw-1; Fri, 20 Dec 2019 16:16:39 -0500
X-MC-Unique: t_SmpKo-MGqV-NIlXBbArw-1
Received: by mail-qv1-f70.google.com with SMTP id k2so6716565qvu.22
        for <linux-kernel@vger.kernel.org>; Fri, 20 Dec 2019 13:16:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5u+NdTdcxJqnd4CDcK36kvrGYVN4B69rZJAB5gjRDOQ=;
        b=Zvo8t7Nrse1mFY5w/kSLoNN3cHQKEtV8BwwVLzkP/1LRUZ3SAvYwURAX1MpsQPOiZO
         uXKcs9jDlivNQ0yMhKTbY+Ln1rwlf3YQQnX9RKW8h+n6Sm9rw2+HAd4KUFGa5zluiTjU
         SjsdKfoU3MHWh39Eyq28qAr0NgRlrcxXu3/SP0OXoUPRtTeoqFDL/cTxUtN3MsHJ00PK
         mB0ZhhKfwZcKhcY3g0yLIugx66QTgaf2E4KwgxfN4QNMWsnDpn4TmD1int9kjCxEjDyL
         EbXIuW0Y9XP62cQ5vh5HEASBavbanwTTgLQ8LtyihfcUtRMVJ2qW9r0SbLRACUBijsDa
         4lQg==
X-Gm-Message-State: APjAAAVvc9Shmr/HR4fWZKFw7mtkVGUpKwTM/YL7GJIEEOtpUYXsn7tW
        A/zQTICbe/1ylSfLGUtjc8bpfGx32FHXMMXKjoipJXLuj5mthCwAMmlYVOIBvt/CL0QEJPT0b9S
        2p/XOQQ+vPi4GDbRGp4Mxv0WX
X-Received: by 2002:ad4:478b:: with SMTP id z11mr14206443qvy.185.1576876598687;
        Fri, 20 Dec 2019 13:16:38 -0800 (PST)
X-Google-Smtp-Source: APXvYqxoKvokYa9wz/VYk7DXc6sLhq1nQIWkintnAX/rU5VixNiHjfptm5B8929S8w9MKyIcQEcPLA==
X-Received: by 2002:ad4:478b:: with SMTP id z11mr14206426qvy.185.1576876598497;
        Fri, 20 Dec 2019 13:16:38 -0800 (PST)
Received: from xz-x1.redhat.com ([104.156.64.74])
        by smtp.gmail.com with ESMTPSA id d25sm3385231qtq.11.2019.12.20.13.16.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2019 13:16:37 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Michael S . Tsirkin" <mst@redhat.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>, peterx@redhat.com,
        Jason Wang <jasowang@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Christophe de Dinechin <dinechin@redhat.com>
Subject: [PATCH v2 01/17] KVM: Remove kvm_read_guest_atomic()
Date:   Fri, 20 Dec 2019 16:16:18 -0500
Message-Id: <20191220211634.51231-2-peterx@redhat.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191220211634.51231-1-peterx@redhat.com>
References: <20191220211634.51231-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove kvm_read_guest_atomic() because it's not used anywhere.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/linux/kvm_host.h |  2 --
 virt/kvm/kvm_main.c      | 11 -----------
 2 files changed, 13 deletions(-)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index d41c521a39da..2ea1ea79befd 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -730,8 +730,6 @@ void kvm_get_pfn(kvm_pfn_t pfn);
 
 int kvm_read_guest_page(struct kvm *kvm, gfn_t gfn, void *data, int offset,
 			int len);
-int kvm_read_guest_atomic(struct kvm *kvm, gpa_t gpa, void *data,
-			  unsigned long len);
 int kvm_read_guest(struct kvm *kvm, gpa_t gpa, void *data, unsigned long len);
 int kvm_read_guest_cached(struct kvm *kvm, struct gfn_to_hva_cache *ghc,
 			   void *data, unsigned long len);
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 13efc291b1c7..7ee28af9eb48 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -2039,17 +2039,6 @@ static int __kvm_read_guest_atomic(struct kvm_memory_slot *slot, gfn_t gfn,
 	return 0;
 }
 
-int kvm_read_guest_atomic(struct kvm *kvm, gpa_t gpa, void *data,
-			  unsigned long len)
-{
-	gfn_t gfn = gpa >> PAGE_SHIFT;
-	struct kvm_memory_slot *slot = gfn_to_memslot(kvm, gfn);
-	int offset = offset_in_page(gpa);
-
-	return __kvm_read_guest_atomic(slot, gfn, data, offset, len);
-}
-EXPORT_SYMBOL_GPL(kvm_read_guest_atomic);
-
 int kvm_vcpu_read_guest_atomic(struct kvm_vcpu *vcpu, gpa_t gpa,
 			       void *data, unsigned long len)
 {
-- 
2.24.1

