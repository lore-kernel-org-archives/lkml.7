Return-Path: <SRS0=ztpy=2L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30EC2C3F68F
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Dec 2019 01:58:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00A1520716
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Dec 2019 01:58:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fWJtMKME"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbfLUB6Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 20:58:24 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:39118 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726613AbfLUB6X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 20:58:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576893501;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aLnceZhQvz4L7d3FILFkZlXmK4gcpiqbWBlsyV3pAtU=;
        b=fWJtMKMEl59VY/FGebcmHcEr5YtDgdoH8zwyO1x4Obleirzs7x1jEqiOP0Oix+7hUhcKC5
        Xuu/Ka+NUMoisNzj6HspbhNGsww5Vq6768NLjAC5ErbIcfmgos3XPiTU1P9muElSnn64l6
        wSb7HzWHdnTASqy9E8+3t3d9Tq3Zugw=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-341-WftzTOPuM8Keg1e-yv0_sQ-1; Fri, 20 Dec 2019 20:58:20 -0500
X-MC-Unique: WftzTOPuM8Keg1e-yv0_sQ-1
Received: by mail-qt1-f199.google.com with SMTP id y7so7239692qto.8
        for <linux-kernel@vger.kernel.org>; Fri, 20 Dec 2019 17:58:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aLnceZhQvz4L7d3FILFkZlXmK4gcpiqbWBlsyV3pAtU=;
        b=PLSwsIclTXJxk7BwVde8rlftZil5FwMdMdNMMlc7AFPj5JW1R5+uINjpTpXgBnOGF8
         F81WqYdcnh+DAwy4r905VIlbR3aSV23NndT0+HQb6XV8fkD0jkI8VQ1FIzcN/QRj27o7
         cJReH6uXQVj4WFZDp1iL4Fhd9AK1Ij2ATI6m3cf1t42iel54pCWFh0t2e9x1zhw+mVGT
         58RvnunzkPMc2uydV06/Bjg3+gfDczfhvCFIOUb4D5RvjWbwPYgattp88+ZJfr7M28xl
         WcXIwABVi17BpWLfWqjxiosmoqDhRHRTP2Y3ObMdbjAUCnw4uUG84SQirK3NRLiCP/w4
         H8EA==
X-Gm-Message-State: APjAAAXwwmYwv1nzwPVZE+OOumDr40/kroZV9afT79A4hIIbvEiWqz+Z
        23hvwgjBeJvL6nDoF28SXPvnCpo7tHFdkyJ1ljhUS4K/p0iG8NCKGv5Hk5fDq+I/dKrrgVc64RO
        b5U+M4bLvjNfo1WJNd90Y2KaQ
X-Received: by 2002:a37:3d8:: with SMTP id 207mr15869149qkd.335.1576893500014;
        Fri, 20 Dec 2019 17:58:20 -0800 (PST)
X-Google-Smtp-Source: APXvYqx5DU0WULLKatVhGXGRGbGlKp19wDJAuuBgK1zQE/iicrZZvmuGD5jchP31zgAGacHyHkw59Q==
X-Received: by 2002:a37:3d8:: with SMTP id 207mr15869137qkd.335.1576893499774;
        Fri, 20 Dec 2019 17:58:19 -0800 (PST)
Received: from xz-x1.hitronhub.home (CPEf81d0fb19163-CMf81d0fb19160.cpe.net.fido.ca. [72.137.123.47])
        by smtp.gmail.com with ESMTPSA id c8sm3660106qtv.61.2019.12.20.17.58.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2019 17:58:19 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Peter Xu <peterx@redhat.com>,
        Dr David Alan Gilbert <dgilbert@redhat.com>,
        Christophe de Dinechin <dinechin@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "Michael S . Tsirkin " <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: [PATCH RESEND v2 10/17] KVM: Don't allocate dirty bitmap if dirty ring is enabled
Date:   Fri, 20 Dec 2019 20:58:17 -0500
Message-Id: <20191221015817.59537-1-peterx@redhat.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191221014938.58831-1-peterx@redhat.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Because kvm dirty rings and kvm dirty log is used in an exclusive way,
Let's avoid creating the dirty_bitmap when kvm dirty ring is enabled.
At the meantime, since the dirty_bitmap will be conditionally created
now, we can't use it as a sign of "whether this memory slot enabled
dirty tracking".  Change users like that to check against the kvm
memory slot flags.

Note that there still can be chances where the kvm memory slot got its
dirty_bitmap allocated, _if_ the memory slots are created before
enabling of the dirty rings and at the same time with the dirty
tracking capability enabled, they'll still with the dirty_bitmap.
However it should not hurt much (e.g., the bitmaps will always be
freed if they are there), and the real users normally won't trigger
this because dirty bit tracking flag should in most cases only be
applied to kvm slots only before migration starts, that should be far
latter than kvm initializes (VM starts).

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/linux/kvm_host.h | 5 +++++
 virt/kvm/kvm_main.c      | 5 +++--
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index dff214ab72eb..725650aac05d 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -353,6 +353,11 @@ struct kvm_memory_slot {
 	u8 as_id;
 };
 
+static inline bool kvm_slot_dirty_track_enabled(struct kvm_memory_slot *slot)
+{
+	return slot->flags & KVM_MEM_LOG_DIRTY_PAGES;
+}
+
 static inline unsigned long kvm_dirty_bitmap_bytes(struct kvm_memory_slot *memslot)
 {
 	return ALIGN(memslot->npages, BITS_PER_LONG) / 8;
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index b69d34425f8d..bb11fec1bf08 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -1113,7 +1113,8 @@ int __kvm_set_memory_region(struct kvm *kvm,
 	}
 
 	/* Allocate page dirty bitmap if needed */
-	if ((new.flags & KVM_MEM_LOG_DIRTY_PAGES) && !new.dirty_bitmap) {
+	if ((new.flags & KVM_MEM_LOG_DIRTY_PAGES) && !new.dirty_bitmap &&
+	    !kvm->dirty_ring_size) {
 		if (kvm_create_dirty_bitmap(&new) < 0)
 			goto out_free;
 	}
@@ -2312,7 +2313,7 @@ static void mark_page_dirty_in_slot(struct kvm *kvm,
 				    struct kvm_memory_slot *memslot,
 				    gfn_t gfn)
 {
-	if (memslot && memslot->dirty_bitmap) {
+	if (memslot && kvm_slot_dirty_track_enabled(memslot)) {
 		unsigned long rel_gfn = gfn - memslot->base_gfn;
 
 		if (kvm->dirty_ring_size)
-- 
2.24.1

