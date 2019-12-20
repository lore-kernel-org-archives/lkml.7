Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7E49C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 21:02:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D6C420866
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 21:02:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PXlGxfu3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727669AbfLTVCL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 16:02:11 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:60671 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727631AbfLTVCH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 16:02:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576875726;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=G5ujQPtmC0gFSTE7FNk323KNrK3wygZRxxl448+O6gM=;
        b=PXlGxfu3WHBm/XwI2YUnXvpXL3U/2T/MAkVb9en3Hhc9W8Q23UPyWsqinl2RIX/wQgjbd9
        8X1bUjUUt/yHquo0Vimxu6VAAffg0LreXSBH/cDibPRerkXSvd7hkKnP/rVbncIOw9yF11
        ZOIt7+CjWU+yAwNoP0hob8sxISDnvvo=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-94-nLU6cv1kN8CyHWoQvyrZSw-1; Fri, 20 Dec 2019 16:02:05 -0500
X-MC-Unique: nLU6cv1kN8CyHWoQvyrZSw-1
Received: by mail-qk1-f198.google.com with SMTP id a73so6765329qkg.5
        for <linux-kernel@vger.kernel.org>; Fri, 20 Dec 2019 13:02:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=G5ujQPtmC0gFSTE7FNk323KNrK3wygZRxxl448+O6gM=;
        b=C7m0KDEQxWdSwl7A44jHUHhZun2xG3RS/r4d004jHBg4ExtJtDRTyywca14sGDoJBR
         r5N3T6TZspHAw5GjSKTf/nx1dhqzHAjQhOVLVy51YMqyIwbneMdps5UvN0ZPimb/vk0U
         YTFUa/QwIsGDdNqCHretNQQ76+D5HihhIi280/d+6csrHRY/DRbmxdlJ7JZdxyCnfCxh
         3TrMaPJ+Fp1hZGj7eM25x3ECndPW+fHlBJ7DTvN909x8o69OKSRFVlbjtkV4DsbxN3Uo
         rZokbacL3RIhnQ+6Pkocq9W36A3C1DAQsDtfXB+TmN4wCDd643oC+mziZJPIfBmrkgxq
         UzUA==
X-Gm-Message-State: APjAAAXOw9v8nLn5S3i+GQbC4fl5ZTQyH250QiOBaCMOMu/b0OIqNP1R
        WVBUuI7NW5D7rDveqAqfAz2MQH4oDpGVdQTJfh6WjJt2uX+KM3nUPgJ3XatDBXHny0FpEw8ZR3s
        zFWUbpgeIqnib0cCdr2yOdeAO
X-Received: by 2002:a37:a00b:: with SMTP id j11mr15296025qke.268.1576875724804;
        Fri, 20 Dec 2019 13:02:04 -0800 (PST)
X-Google-Smtp-Source: APXvYqyPYw38tftza/eiCRksgBlotjNaedZkoJuSdav/RZKZYcqAteHsuJrRYX9aYbSMnU9GxoyFwg==
X-Received: by 2002:a37:a00b:: with SMTP id j11mr15295997qke.268.1576875724543;
        Fri, 20 Dec 2019 13:02:04 -0800 (PST)
Received: from xz-x1.redhat.com ([104.156.64.74])
        by smtp.gmail.com with ESMTPSA id q25sm3243836qkq.88.2019.12.20.13.02.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2019 13:02:03 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jason Wang <jasowang@redhat.com>, peterx@redhat.com,
        Paolo Bonzini <pbonzini@redhat.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Christophe de Dinechin <dinechin@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        "Michael S . Tsirkin" <mst@redhat.com>
Subject: [PATCH v2 09/17] KVM: Make dirty ring exclusive to dirty bitmap log
Date:   Fri, 20 Dec 2019 16:01:39 -0500
Message-Id: <20191220210147.49617-10-peterx@redhat.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191220210147.49617-1-peterx@redhat.com>
References: <20191220210147.49617-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's no good reason to use both the dirty bitmap logging and the
new dirty ring buffer to track dirty bits.  We should be able to even
support both of them at the same time, but it could complicate things
which could actually help little.  Let's simply make it the rule
before we enable dirty ring on any arch, that we don't allow these two
interfaces to be used together.

The big world switch would be KVM_CAP_DIRTY_LOG_RING capability
enablement.  That's where we'll switch from the default dirty logging
way to the dirty ring way.  As long as kvm->dirty_ring_size is setup
correctly, we'll once and for all switch to the dirty ring buffer mode
for the current virtual machine.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 Documentation/virt/kvm/api.txt |  7 +++++++
 virt/kvm/kvm_main.c            | 12 ++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/Documentation/virt/kvm/api.txt b/Documentation/virt/kvm/api.txt
index c141b285e673..b507b966f9f1 100644
--- a/Documentation/virt/kvm/api.txt
+++ b/Documentation/virt/kvm/api.txt
@@ -5411,3 +5411,10 @@ all the existing dirty gfns are flushed to the dirty rings.
 If one of the ring buffers is full, the guest will exit to userspace
 with the exit reason set to KVM_EXIT_DIRTY_LOG_FULL, and the KVM_RUN
 ioctl will return to userspace with zero.
+
+NOTE: the KVM_CAP_DIRTY_LOG_RING capability and the new ioctl
+KVM_RESET_DIRTY_RINGS are exclusive to the existing KVM_GET_DIRTY_LOG
+interface.  After enabling KVM_CAP_DIRTY_LOG_RING with an acceptable
+dirty ring size, the virtual machine will switch to the dirty ring
+tracking mode, and KVM_GET_DIRTY_LOG, KVM_CLEAR_DIRTY_LOG ioctls will
+stop working.
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 4050631d05f3..b69d34425f8d 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -1204,6 +1204,10 @@ int kvm_get_dirty_log(struct kvm *kvm,
 	unsigned long n;
 	unsigned long any = 0;
 
+	/* Dirty ring tracking is exclusive to dirty log tracking */
+	if (kvm->dirty_ring_size)
+		return -EINVAL;
+
 	as_id = log->slot >> 16;
 	id = (u16)log->slot;
 	if (as_id >= KVM_ADDRESS_SPACE_NUM || id >= KVM_USER_MEM_SLOTS)
@@ -1261,6 +1265,10 @@ int kvm_get_dirty_log_protect(struct kvm *kvm,
 	unsigned long *dirty_bitmap;
 	unsigned long *dirty_bitmap_buffer;
 
+	/* Dirty ring tracking is exclusive to dirty log tracking */
+	if (kvm->dirty_ring_size)
+		return -EINVAL;
+
 	as_id = log->slot >> 16;
 	id = (u16)log->slot;
 	if (as_id >= KVM_ADDRESS_SPACE_NUM || id >= KVM_USER_MEM_SLOTS)
@@ -1332,6 +1340,10 @@ int kvm_clear_dirty_log_protect(struct kvm *kvm,
 	unsigned long *dirty_bitmap;
 	unsigned long *dirty_bitmap_buffer;
 
+	/* Dirty ring tracking is exclusive to dirty log tracking */
+	if (kvm->dirty_ring_size)
+		return -EINVAL;
+
 	as_id = log->slot >> 16;
 	id = (u16)log->slot;
 	if (as_id >= KVM_ADDRESS_SPACE_NUM || id >= KVM_USER_MEM_SLOTS)
-- 
2.24.1

