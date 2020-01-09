Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 008A8C282DD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 14:59:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7B862072A
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 14:59:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XoqMRlwK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731091AbgAIO70 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 09:59:26 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:56179 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731961AbgAIO55 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 09:57:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578581875;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EWV08i+y09T0shEQm4Du/cNi7j67EsBakky7HQM3iHM=;
        b=XoqMRlwKNuy1kh5HFK3GTjotAYxQSPD6ZXUydHAmmbS5nTouHc3aO0UhhmL2lxbCrqXzRQ
        XTsasPjEujaErIKF9NXOldLlSyatvLsZoRNPa2taTmHaFagqQWLN33XeV0S+XgNLt89pCS
        JxhWH/w78y+k6pZb+4JOizG3QveqVDE=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-262-8c9ykytWOGaebDisxP5hAw-1; Thu, 09 Jan 2020 09:57:53 -0500
X-MC-Unique: 8c9ykytWOGaebDisxP5hAw-1
Received: by mail-qv1-f71.google.com with SMTP id z9so4242195qvo.10
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 06:57:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EWV08i+y09T0shEQm4Du/cNi7j67EsBakky7HQM3iHM=;
        b=W3CTTRzkwdC/1HhS1tjLDT8Tm1I/JKjsXgqWJWlQ9XWGD57nuagYb3F7VTVWysv/42
         ZDXokqr3EjbEalmMn3Sx9t81nrUxWqv5mYInENZh7yrAEn9ipohHIw4hRJpF6PoOBeMY
         Go5Af3trUeTVycI2WdRr4SrOKX5bwE/gc96pNuSt4scIC2prCV8kquYkVaBxRxiwbjww
         RwLNYbmauEsJNCptjIstwLELrEFz/gMKKJQa/0cp03wKbo3O4ozyXM3FcvreZu2z3Ehx
         UUhMati1k9bq2iCnSrcR7JnQVrDLyTov/OJd0qhTZmEV/PsxrrmAh0w0oOw4LdzIJu+7
         KoeQ==
X-Gm-Message-State: APjAAAWFgzWuJrentEzR5ktEkZZn7eEUGu1LUzMGNNGZQQzx2+lJ6OoT
        9bUEJwxj51OD8qrocd14OMFQoLbIrA2eIXwppnzQ2LXG9k1Lf9eCRPcUk9phJ7iL5pvhhlgDohj
        BiBImV8Vf5FIMrg8C+FodD9sP
X-Received: by 2002:a05:620a:136e:: with SMTP id d14mr9774126qkl.342.1578581873442;
        Thu, 09 Jan 2020 06:57:53 -0800 (PST)
X-Google-Smtp-Source: APXvYqxCvoe5Ap6+5M5ORKV7xt2P5nsc1tcHZco1QoU+FUiuKNxmacCYbTCTEN1X9W8lMsTu+hLsCQ==
X-Received: by 2002:a05:620a:136e:: with SMTP id d14mr9774109qkl.342.1578581873235;
        Thu, 09 Jan 2020 06:57:53 -0800 (PST)
Received: from xz-x1.yyz.redhat.com ([104.156.64.74])
        by smtp.gmail.com with ESMTPSA id q2sm3124179qkm.5.2020.01.09.06.57.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 06:57:52 -0800 (PST)
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
Subject: [PATCH v3 07/21] KVM: Cache as_id in kvm_memory_slot
Date:   Thu,  9 Jan 2020 09:57:15 -0500
Message-Id: <20200109145729.32898-8-peterx@redhat.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200109145729.32898-1-peterx@redhat.com>
References: <20200109145729.32898-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cache the address space ID just like the slot ID.  It will be used in
order to fill in the dirty ring entries.

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Suggested-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/linux/kvm_host.h | 1 +
 virt/kvm/kvm_main.c      | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 2337f9b6112c..763adf8c47b0 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -348,6 +348,7 @@ struct kvm_memory_slot {
 	unsigned long userspace_addr;
 	u32 flags;
 	short id;
+	u8 as_id;
 };
 
 static inline unsigned long kvm_dirty_bitmap_bytes(struct kvm_memory_slot *memslot)
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 70b78ccaf3b5..1fd204f27028 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -1040,6 +1040,8 @@ int __kvm_set_memory_region(struct kvm *kvm,
 
 	new = old = *slot;
 
+	BUILD_BUG_ON(U8_MAX < KVM_ADDRESS_SPACE_NUM);
+	new.as_id = as_id;
 	new.id = id;
 	new.base_gfn = base_gfn;
 	new.npages = npages;
-- 
2.24.1

