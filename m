Return-Path: <SRS0=ztpy=2L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5479C43603
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Dec 2019 01:50:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98A7420866
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Dec 2019 01:50:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LPLfdvPz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbfLUBt4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 20:49:56 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:42830 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726874AbfLUBtx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 20:49:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576892991;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5JYh7n3fhb27PXs/bYUs6lzlcg1ya8dgcofIlxRo1Jg=;
        b=LPLfdvPzD198EzFY0geRsZqH77rhruNUd/NniHeOr+rAKMggN2sQ0N0PgY79uNMtMucIwQ
        0sPZQ1CBp+XCR5GO1SvGAMb6Wl/kxAs2mmzGNa7sv2cQ0VgsoFxbZ7ESosNLAvAPJcOBid
        ElaQBYXeSoUQbBFmbuq8XD15akuQVOA=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-399-fsc3O1PHMgeYwDUID_77wA-1; Fri, 20 Dec 2019 20:49:50 -0500
X-MC-Unique: fsc3O1PHMgeYwDUID_77wA-1
Received: by mail-qt1-f198.google.com with SMTP id m8so7164465qta.20
        for <linux-kernel@vger.kernel.org>; Fri, 20 Dec 2019 17:49:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5JYh7n3fhb27PXs/bYUs6lzlcg1ya8dgcofIlxRo1Jg=;
        b=ZL5it+gMA7eUlKc+hJqsAjJDKsg3MvmsNe4LSmTsCwWPevQdJlIMcYHJm+AJ9E+Kqd
         dIP6wASJjX6hMYxWIrfunsFa4Cgd1JF/zX3ZhDihzOQI3GX8Lm+cTCpF+2ll6YH1A0F3
         enCzg38AWynFPn6P5gPsvnMUdvW3YZjnCfSeSb0xQG2wwkuwpSc925qRelf3SSk22db8
         zCW+aklPN8kcq11Ktb6ax55b6dt6MTuFB5eDhzhkG/LZ/m3dMNcVc2jQwSUOCJKN38Td
         EDJ17V61n477l1A4pQ0gVVOPUGteR62saeXT3yuLHVfOlNqVxSdShxDtA8JQmTxuG+Ya
         /BMw==
X-Gm-Message-State: APjAAAWdjnVZZEKZjkjBHTF7cKXtjfFROknW6Mj2fwAWEWbSmnhDtNQo
        811eZj5esEvr4Qx1Bz2W4poUYfb1RcZtLbCkKE8m2E2ME2z9tWbzljQsR00ro0bXfwYMXRaT8x/
        isa6ZnCCmvfizYOfQIewQryXj
X-Received: by 2002:a0c:e2d1:: with SMTP id t17mr15471481qvl.25.1576892990175;
        Fri, 20 Dec 2019 17:49:50 -0800 (PST)
X-Google-Smtp-Source: APXvYqz2f4YaxCbKnooBeaquHpX/lFhmLSfHle1bIaMFZ+SWobZuOjXMIOyhSsfc14XqKr1XMbX83A==
X-Received: by 2002:a0c:e2d1:: with SMTP id t17mr15471464qvl.25.1576892989964;
        Fri, 20 Dec 2019 17:49:49 -0800 (PST)
Received: from xz-x1.hitronhub.home (CPEf81d0fb19163-CMf81d0fb19160.cpe.net.fido.ca. [72.137.123.47])
        by smtp.gmail.com with ESMTPSA id e21sm3396932qkm.55.2019.12.20.17.49.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2019 17:49:49 -0800 (PST)
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
Subject: [PATCH RESEND v2 04/17] KVM: Cache as_id in kvm_memory_slot
Date:   Fri, 20 Dec 2019 20:49:25 -0500
Message-Id: <20191221014938.58831-5-peterx@redhat.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191221014938.58831-1-peterx@redhat.com>
References: <20191221014938.58831-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's cache the address space ID just like the slot ID.

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Suggested-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/linux/kvm_host.h | 1 +
 virt/kvm/kvm_main.c      | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 4e34cf97ca90..24854c9e3717 100644
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
index b1047173d78e..cea4b8dd4ac9 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -1027,6 +1027,8 @@ int __kvm_set_memory_region(struct kvm *kvm,
 
 	new = old = *slot;
 
+	BUILD_BUG_ON(U8_MAX < KVM_ADDRESS_SPACE_NUM);
+	new.as_id = as_id;
 	new.id = id;
 	new.base_gfn = base_gfn;
 	new.npages = npages;
-- 
2.24.1

