Return-Path: <SRS0=ztpy=2L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DD58C43603
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Dec 2019 01:49:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17EFD2082E
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Dec 2019 01:49:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gvGicvQj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726726AbfLUBts (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 20:49:48 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:45275 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726598AbfLUBtr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 20:49:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576892986;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5u+NdTdcxJqnd4CDcK36kvrGYVN4B69rZJAB5gjRDOQ=;
        b=gvGicvQjbuqEeaL0fZ+IX0/0vUHCTKl4ikEYU34Fd2/AD6VbMEKDOUBFzk4A7ig1DUI25w
        ImIDjGDmpgNiz66JsWy3QOZGkHdv6v/m16OhPkFGhKDfPFDZir2oZJPlArl7AkdYCnp9Rq
        9MuKP+0FJMrPGWUlSgpE031syyZT3+o=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-243-4nKOWEpbMWWdNoU_ldLFjw-1; Fri, 20 Dec 2019 20:49:45 -0500
X-MC-Unique: 4nKOWEpbMWWdNoU_ldLFjw-1
Received: by mail-qv1-f72.google.com with SMTP id k2so7095863qvu.22
        for <linux-kernel@vger.kernel.org>; Fri, 20 Dec 2019 17:49:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5u+NdTdcxJqnd4CDcK36kvrGYVN4B69rZJAB5gjRDOQ=;
        b=toGeIxVpQDwaNcyLJG+qADFL03m/0tO1ofQ7UjQWTOF6H1w1MOI4iZMpDwclKsHIsp
         FzA+NY6agmT1LEXDohfnOkIY03/kDUG/wWo6w1cgyp/KX98eBsFygh0r/WwSMThmEuHy
         EGwhWzc7uTNm9fpYhImwh44eAOKbHkgh65X1B6ecS4xOnmuJISL3GjS/8nVUW8RzS5so
         DPXWaBE885lclRmrwBwJf1wQ+Kej1vKnk47hdHk5uup1Q3ELmfOSlStCtQ+a6FXsG5ru
         4CsD+tPiImjPaHNzaYonq0NxTCvcSHLjpQY5E7dhsXPHLtAlS7HTk6oPbx2zGl4HbO6/
         Sptg==
X-Gm-Message-State: APjAAAUJt4XimdAg0430FWOjtlnmBC63oU9U4MSRTVcfLMSR5VasFWpB
        FnJDQd0Mm0Gz1btWA63vlpMTrnlggoKiB9O0EOpozbny+aVYc5tVEtHkko6WtKTrN8BZTRlcK6Z
        A2ploeM9VRdKRrdKPP0o8C5Ws
X-Received: by 2002:a05:620a:634:: with SMTP id 20mr7129946qkv.269.1576892984497;
        Fri, 20 Dec 2019 17:49:44 -0800 (PST)
X-Google-Smtp-Source: APXvYqzi7/gDaYgNg0pHa+V7FOPwTChgJ98Acb8wMgEHent4TmIHneaBgF7FVuz9dNugS/zXI4cUAw==
X-Received: by 2002:a05:620a:634:: with SMTP id 20mr7129928qkv.269.1576892984288;
        Fri, 20 Dec 2019 17:49:44 -0800 (PST)
Received: from xz-x1.hitronhub.home (CPEf81d0fb19163-CMf81d0fb19160.cpe.net.fido.ca. [72.137.123.47])
        by smtp.gmail.com with ESMTPSA id e21sm3396932qkm.55.2019.12.20.17.49.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2019 17:49:43 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Christophe de Dinechin <dinechin@redhat.com>,
        peterx@redhat.com,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: [PATCH RESEND v2 01/17] KVM: Remove kvm_read_guest_atomic()
Date:   Fri, 20 Dec 2019 20:49:22 -0500
Message-Id: <20191221014938.58831-2-peterx@redhat.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191221014938.58831-1-peterx@redhat.com>
References: <20191221014938.58831-1-peterx@redhat.com>
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

