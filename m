Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DB81C33CA1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 14:59:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54E102067D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 14:59:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z4uPLsC4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732142AbgAIO7L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 09:59:11 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:29033 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1732056AbgAIO6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 09:58:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578581895;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qo8B0RRH3HwVIIYkQ204ghyrR8Ipv7FatZgkB5Hr2Ro=;
        b=Z4uPLsC49EbUbc1+JQYZiQKLGLEJJqLNXlaYPjG7ryUkaQzayoeTl71Q91sCRdjeon3rpT
        AF8ErvsAlqHJPnMHJmcTF5y34MzZkFde2R75vJwa1u4S2TGPxJtzMb3TTKzGK3PuxDZdxC
        2IDdIUQ2okMP1WmTGB2LK2MLMC4jP7w=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-253--ZML8bu8PTOVryyZrotvKQ-1; Thu, 09 Jan 2020 09:58:14 -0500
X-MC-Unique: -ZML8bu8PTOVryyZrotvKQ-1
Received: by mail-qk1-f200.google.com with SMTP id u10so4334080qkk.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 06:58:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qo8B0RRH3HwVIIYkQ204ghyrR8Ipv7FatZgkB5Hr2Ro=;
        b=VSocxDUSEpARRYiVsARHb/eIcl/T0cK7aYJU4cL4mn00/wR1dvo+zG42BjYpq8hHsb
         mdjGpGR2mJ627NjWYSDlnLD8ZsNuO2tdQVPnGlCM2AxvCYxU/l987YN9cmasarJjLXa5
         aVjzivT9BzR5ISKJ2lhDT4BRZLCtPD5k0WYfeP8ZlkD6CHxl/P1fYM9MAyp0/hPv6x7s
         41Q19HOQtrMIhtad94KcPiudw7p1lMtoVANcw9p8jf5YWtInQYTbD5ulyUif6snORf4s
         /EQY9zE2i3bNhC9r2ZyxtRjSa8TSgzdtCdrtyOiU+IM/TV4mhpaZitm6e/tVVU1d6vNP
         441g==
X-Gm-Message-State: APjAAAVrjqY6yS4XzeTrqawPANVoxTBU63MhgIUwccibbw72Z3ltiIiE
        WdcBXmOan5voVDXuPffe7pdw9t+z4PoOihj+0tNv6rG6jPOyyRSrU2i5xeT5H7ueK4TXcVl5VIV
        fQHprW34WcUQaSJrKMnk+63cu
X-Received: by 2002:ad4:55ec:: with SMTP id bu12mr9341178qvb.107.1578581894159;
        Thu, 09 Jan 2020 06:58:14 -0800 (PST)
X-Google-Smtp-Source: APXvYqxap7TJb0aJMeIGMtE0Ap5zzFfcOhoJTtDvs6UIukIGtqjETcSsqkFLZb0v4jXm6uqUuxkLFg==
X-Received: by 2002:ad4:55ec:: with SMTP id bu12mr9341162qvb.107.1578581893880;
        Thu, 09 Jan 2020 06:58:13 -0800 (PST)
Received: from xz-x1.yyz.redhat.com ([104.156.64.74])
        by smtp.gmail.com with ESMTPSA id q2sm3124179qkm.5.2020.01.09.06.58.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 06:58:12 -0800 (PST)
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
Subject: [PATCH v3 14/21] KVM: Don't allocate dirty bitmap if dirty ring is enabled
Date:   Thu,  9 Jan 2020 09:57:22 -0500
Message-Id: <20200109145729.32898-15-peterx@redhat.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200109145729.32898-1-peterx@redhat.com>
References: <20200109145729.32898-1-peterx@redhat.com>
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
index c96161c6a0c9..ab2a169b1264 100644
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
index f0f766183cb2..46da3169944f 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -1120,7 +1120,8 @@ int __kvm_set_memory_region(struct kvm *kvm,
 	}
 
 	/* Allocate page dirty bitmap if needed */
-	if ((new.flags & KVM_MEM_LOG_DIRTY_PAGES) && !new.dirty_bitmap) {
+	if ((new.flags & KVM_MEM_LOG_DIRTY_PAGES) && !new.dirty_bitmap &&
+	    !kvm->dirty_ring_size) {
 		if (kvm_create_dirty_bitmap(&new) < 0)
 			goto out_free;
 	}
@@ -2309,7 +2310,7 @@ static void mark_page_dirty_in_slot(struct kvm *kvm,
 				    struct kvm_memory_slot *memslot,
 				    gfn_t gfn)
 {
-	if (memslot && memslot->dirty_bitmap) {
+	if (memslot && kvm_slot_dirty_track_enabled(memslot)) {
 		unsigned long rel_gfn = gfn - memslot->base_gfn;
 		u32 slot = (memslot->as_id << 16) | memslot->id;
 
-- 
2.24.1

