Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A02DC282DD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 14:59:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E4C42072E
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 14:59:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PllpM14t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731965AbgAIO54 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 09:57:56 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:54494 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731944AbgAIO5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 09:57:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578581872;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iOwBnRfuU+D9l17RCY4C+mlVimy3V5B0lUjjJ1K6zlg=;
        b=PllpM14tI8Vewo7CphHSE9UQGVwNboRdzi0MRZkd46Au29wGLMXho6Z5PDoDvHs2z96Ngo
        1M9qFoo9QCdpqhsGBL/wR/XU5b9czPnk56U8matgYCNSw+UfwaLA0/KFZLRSzjbTJ3qijC
        svv8g3/F/bWpftlmjFIpp7f5bWyPRoo=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-341-CzqlwK-xO_uhKj8NxhYbjQ-1; Thu, 09 Jan 2020 09:57:51 -0500
X-MC-Unique: CzqlwK-xO_uhKj8NxhYbjQ-1
Received: by mail-qk1-f198.google.com with SMTP id s9so4250968qkg.21
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 06:57:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iOwBnRfuU+D9l17RCY4C+mlVimy3V5B0lUjjJ1K6zlg=;
        b=lENA2Nv9QTLIsG7dY7rdUUvvQVS7zPqMHxEyJrBRZLC7/Qszp10Vf5qylVeVkgIj3i
         L/hMa4me8LU92s8f3PsSoe33s0gRnMpHMFYY5iaXj3ZZKjOJEPPXytlIaDXbFntn9bzx
         siihsoyI1W4/XVz85aOK95XCnXshotAPMFzeq0vn3hkup3rCmiZ1aemN6zSrizCjZQy2
         aJvI3nvCx9P5VLR7Vp53APqIir/nuQNmBIbYFMFcsYruyxQwQqckwv0Iqn39MefE2dPF
         wsIX9CTcUckKNUYkHyNe9File0I1dJWFeZWxhpJZywSqoznOejo4g4kfSGUIhOxqdo/i
         2Kgw==
X-Gm-Message-State: APjAAAX3Oq/2a4x2J/3Qa3HdOJvimGWuRvkyyFAlN2kLo+hDGOO5X3V9
        e12XH0bm2YZWAOqniNesdM4TkKBIDoxa936IGaLLjI51O2yQEccg4vdMh3OwXYZgt7WBARuNIZS
        wgIj/EESeyKvqPALT30F0a+7w
X-Received: by 2002:a05:6214:903:: with SMTP id dj3mr9256929qvb.27.1578581871205;
        Thu, 09 Jan 2020 06:57:51 -0800 (PST)
X-Google-Smtp-Source: APXvYqyjzq+Zf7itjTFb9hX/DEDGZiDvjZ55SpaSIA4PVTPWagLi4h5EO3WDSjPMFAcJ3UFk0noDsw==
X-Received: by 2002:a05:6214:903:: with SMTP id dj3mr9256894qvb.27.1578581870928;
        Thu, 09 Jan 2020 06:57:50 -0800 (PST)
Received: from xz-x1.yyz.redhat.com ([104.156.64.74])
        by smtp.gmail.com with ESMTPSA id q2sm3124179qkm.5.2020.01.09.06.57.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 06:57:50 -0800 (PST)
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
Subject: [PATCH v3 06/21] KVM: X86: Don't take srcu lock in init_rmode_identity_map()
Date:   Thu,  9 Jan 2020 09:57:14 -0500
Message-Id: <20200109145729.32898-7-peterx@redhat.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200109145729.32898-1-peterx@redhat.com>
References: <20200109145729.32898-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We've already got the slots_lock, so we should be safe.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/x86/kvm/vmx/vmx.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index b5a0c2e05825..7add2fc8d8e9 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -3475,7 +3475,7 @@ static int init_rmode_tss(struct kvm *kvm)
 static int init_rmode_identity_map(struct kvm *kvm)
 {
 	struct kvm_vmx *kvm_vmx = to_kvm_vmx(kvm);
-	int i, idx, r = 0;
+	int i, r = 0;
 	kvm_pfn_t identity_map_pfn;
 	u32 tmp;
 
@@ -3483,7 +3483,7 @@ static int init_rmode_identity_map(struct kvm *kvm)
 	mutex_lock(&kvm->slots_lock);
 
 	if (likely(kvm_vmx->ept_identity_pagetable_done))
-		goto out2;
+		goto out;
 
 	if (!kvm_vmx->ept_identity_map_addr)
 		kvm_vmx->ept_identity_map_addr = VMX_EPT_IDENTITY_PAGETABLE_ADDR;
@@ -3492,9 +3492,8 @@ static int init_rmode_identity_map(struct kvm *kvm)
 	r = __x86_set_memory_region(kvm, IDENTITY_PAGETABLE_PRIVATE_MEMSLOT,
 				    kvm_vmx->ept_identity_map_addr, PAGE_SIZE);
 	if (r < 0)
-		goto out2;
+		goto out;
 
-	idx = srcu_read_lock(&kvm->srcu);
 	r = kvm_clear_guest_page(kvm, identity_map_pfn, 0, PAGE_SIZE);
 	if (r < 0)
 		goto out;
@@ -3510,9 +3509,6 @@ static int init_rmode_identity_map(struct kvm *kvm)
 	kvm_vmx->ept_identity_pagetable_done = true;
 
 out:
-	srcu_read_unlock(&kvm->srcu, idx);
-
-out2:
 	mutex_unlock(&kvm->slots_lock);
 	return r;
 }
-- 
2.24.1

