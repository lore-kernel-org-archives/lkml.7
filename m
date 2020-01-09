Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4B17C282DD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 14:57:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BFA520721
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 14:57:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I0nKfyeg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731927AbgAIO5p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 09:57:45 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:20110 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731917AbgAIO5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 09:57:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578581863;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TtlFeY7HzyndokCyv32BVKkuZLgrN4WwINmZ03zf3D4=;
        b=I0nKfyegxLClTZD0J6TXbIiz35mLWY8iOcviNVsjKu7Nb62wluJpdHbIcyfMdb45cjCj79
        UT9DtO4Mt1Qp0e7LSt+2xn0+c5GtWKZHRvgK1xqovlwLBFo4eheJDQPGl1yeZzhvFxyccz
        dYntLxB4i10gcgQqv/NIyriqcmafGxU=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-252-QiLJ5__ZN164uAPHJE-XHw-1; Thu, 09 Jan 2020 09:57:42 -0500
X-MC-Unique: QiLJ5__ZN164uAPHJE-XHw-1
Received: by mail-qv1-f70.google.com with SMTP id e10so4234470qvq.18
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 06:57:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TtlFeY7HzyndokCyv32BVKkuZLgrN4WwINmZ03zf3D4=;
        b=dpi7cW88bRxN1E2Kz2kaJb1My4vzVLkS1aqFzDSjLuLgEadcha0G8dWl8drbHx/8su
         XL5BjaCNKh8G6hdWxwDHl3VMR/D+kW+dwIjVolmp+GHVIEvpiFVyWk5d4xu3Js+8Jak/
         WtQ9w74TeCiP/P1+9SzQgIIwwLbG+z+IXnvWOuUjynn5qNH1jXM6Lhpl0FaeF58ihYQC
         o/lKJlx7KnS+wuxzeX6MLnm7yF8iZ3mr0dDF60p1LnQ9Gklamr+ti7P32RhB0Eu9oLuY
         wKAmA7tGw0CSRFvi4JIy3ZuPzNKNPREPsRP3RTyf6EQnpwGMySpSZC9rr0xvKKqSIuoJ
         ceNw==
X-Gm-Message-State: APjAAAVRL+h2XfAVKTJLlcb5x/s68m5ziU6aQU2kJdv6+gxbJFEb+Hyv
        bcQjyLe+RcV+Hyq6IcUPBlsyaz90+HZGXd88byrgn0CNWRUu5fANp9aTXUmSRUafnw+Mwa6lqBe
        nRFJos4hyHV7yyDbiZukNm72B
X-Received: by 2002:a37:52d5:: with SMTP id g204mr10243294qkb.215.1578581862081;
        Thu, 09 Jan 2020 06:57:42 -0800 (PST)
X-Google-Smtp-Source: APXvYqwGbU0IaY9Ud+rTAWvjCd+8O9eQGTqr/fi0Y9HIplgcF1WCujVwGE+E2M6bfObjr+FYycncdQ==
X-Received: by 2002:a37:52d5:: with SMTP id g204mr10243271qkb.215.1578581861864;
        Thu, 09 Jan 2020 06:57:41 -0800 (PST)
Received: from xz-x1.yyz.redhat.com ([104.156.64.74])
        by smtp.gmail.com with ESMTPSA id q2sm3124179qkm.5.2020.01.09.06.57.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 06:57:40 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Christophe de Dinechin <dinechin@redhat.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Yan Zhao <yan.y.zhao@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Kevin Kevin <kevin.tian@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>, peterx@redhat.com,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Subject: [PATCH v3 03/21] KVM: Remove kvm_read_guest_atomic()
Date:   Thu,  9 Jan 2020 09:57:11 -0500
Message-Id: <20200109145729.32898-4-peterx@redhat.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200109145729.32898-1-peterx@redhat.com>
References: <20200109145729.32898-1-peterx@redhat.com>
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
index 528ab7a814ab..2337f9b6112c 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -725,8 +725,6 @@ void kvm_get_pfn(kvm_pfn_t pfn);
 
 int kvm_read_guest_page(struct kvm *kvm, gfn_t gfn, void *data, int offset,
 			int len);
-int kvm_read_guest_atomic(struct kvm *kvm, gpa_t gpa, void *data,
-			  unsigned long len);
 int kvm_read_guest(struct kvm *kvm, gpa_t gpa, void *data, unsigned long len);
 int kvm_read_guest_cached(struct kvm *kvm, struct gfn_to_hva_cache *ghc,
 			   void *data, unsigned long len);
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 3aa21bec028d..24c9cf4c8a52 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -2048,17 +2048,6 @@ static int __kvm_read_guest_atomic(struct kvm_memory_slot *slot, gfn_t gfn,
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

