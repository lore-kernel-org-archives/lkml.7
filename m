Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3650C282DD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 14:58:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C05412067D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 14:58:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Syekde0L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732053AbgAIO6P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 09:58:15 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:32013 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732021AbgAIO6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 09:58:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578581890;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2hsGT2puS2M7nFUR+/hmDKhyO+EnbA4DSJk9zAXszck=;
        b=Syekde0LnKL9GPrZ1zPqd4oGa2ws4iY8gEXPHgeGv3EcAuITO+xj24mfNf0/XFQ7xV2QP3
        080rUWUAwbty4QMeeWwBHrzqXAOHM6e6VE1PguY5/TKSONAJ9eMzGSBg+yaIbXKsCLGevR
        sIWqMvSwdyUIuJz4X8SWme6jv8HN9ag=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-108-s-c3MAVsMY-1u3mogAfDRg-1; Thu, 09 Jan 2020 09:58:09 -0500
X-MC-Unique: s-c3MAVsMY-1u3mogAfDRg-1
Received: by mail-qk1-f200.google.com with SMTP id 65so4280157qkl.23
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 06:58:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2hsGT2puS2M7nFUR+/hmDKhyO+EnbA4DSJk9zAXszck=;
        b=o6ftEDqkW/Yrmpwp2Vq7ivA4WPFTiFfNQGPxWECSVMH5BiOm7bmwIR3nbRbClLjqN/
         rfA8RORJLF0g9xSFyF95bRqXGrgw6+IURBKLzGDtXP9T8jdNFv7d7k6HvjU8sJhqhmgU
         //d7NeCLjMg7ip4y2FSA7TdSUUl75EyEK6Q8+N1L3SRu7TMXIcZm5Oz6babVOMpy8wL/
         tkOcSi8Z+L2Ie4qwHeTEGRBLbiD7MAX42vtBGkzjnfhYY+QiZhK8UMME+6Qv9aUz0Na2
         RCTDwcnnBdDYNPotCKWxlL6F1oiQahiWPAlHugjfLtrti8c6FR/aHJAkD7qIsFtOyV/h
         pfpw==
X-Gm-Message-State: APjAAAV9b5FWCcyO4pMayBzTrIbVTNTVGy1YMd45EFSMv8G9AQ/ylZ/D
        nArNkLQGI+0lk+t+Bnk//RiVV8lLTDJBBuiVY3SyuX6BhXJqlwa4sBSlVnnCCqVipCgeLZfq/wP
        mJuZxxDCwbVbnOju5OTLMOi1l
X-Received: by 2002:a37:e507:: with SMTP id e7mr10127462qkg.358.1578581888962;
        Thu, 09 Jan 2020 06:58:08 -0800 (PST)
X-Google-Smtp-Source: APXvYqz0H7o6nlbN/ohUkbX/oqc+8r0t97p+EDwDPG2HIfZBZWc9Yu+XnrfPuT1t0LiHOiml2tX/xQ==
X-Received: by 2002:a37:e507:: with SMTP id e7mr10127431qkg.358.1578581888713;
        Thu, 09 Jan 2020 06:58:08 -0800 (PST)
Received: from xz-x1.yyz.redhat.com ([104.156.64.74])
        by smtp.gmail.com with ESMTPSA id q2sm3124179qkm.5.2020.01.09.06.58.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 06:58:07 -0800 (PST)
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
Subject: [PATCH v3 13/21] KVM: Make dirty ring exclusive to dirty bitmap log
Date:   Thu,  9 Jan 2020 09:57:21 -0500
Message-Id: <20200109145729.32898-14-peterx@redhat.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200109145729.32898-1-peterx@redhat.com>
References: <20200109145729.32898-1-peterx@redhat.com>
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
index 708c3e0f7eae..be176d1dd91f 100644
--- a/Documentation/virt/kvm/api.txt
+++ b/Documentation/virt/kvm/api.txt
@@ -5485,3 +5485,10 @@ all the existing dirty gfns are flushed to the dirty rings.
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
index 5e36792e15ae..f0f766183cb2 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -1211,6 +1211,10 @@ int kvm_get_dirty_log(struct kvm *kvm,
 	unsigned long n;
 	unsigned long any = 0;
 
+	/* Dirty ring tracking is exclusive to dirty log tracking */
+	if (kvm->dirty_ring_size)
+		return -EINVAL;
+
 	as_id = log->slot >> 16;
 	id = (u16)log->slot;
 	if (as_id >= KVM_ADDRESS_SPACE_NUM || id >= KVM_USER_MEM_SLOTS)
@@ -1268,6 +1272,10 @@ int kvm_get_dirty_log_protect(struct kvm *kvm,
 	unsigned long *dirty_bitmap;
 	unsigned long *dirty_bitmap_buffer;
 
+	/* Dirty ring tracking is exclusive to dirty log tracking */
+	if (kvm->dirty_ring_size)
+		return -EINVAL;
+
 	as_id = log->slot >> 16;
 	id = (u16)log->slot;
 	if (as_id >= KVM_ADDRESS_SPACE_NUM || id >= KVM_USER_MEM_SLOTS)
@@ -1339,6 +1347,10 @@ int kvm_clear_dirty_log_protect(struct kvm *kvm,
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

