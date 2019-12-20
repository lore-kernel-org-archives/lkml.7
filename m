Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42E64C2D0D2
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 21:02:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01BA420866
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 21:02:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R+EMY2ks"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727610AbfLTVCC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 16:02:02 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:53114 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727555AbfLTVB7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 16:01:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576875718;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5JYh7n3fhb27PXs/bYUs6lzlcg1ya8dgcofIlxRo1Jg=;
        b=R+EMY2ksp6+CtCRlHggj+R/UOMNX3XUsSO1qh/OK6wxB4HF2X5XTqL+TxuLN5tOhZXwyaN
        sZywXxbB6jxBJedQCnkWHWTTS6QS9Y5HU9/4XeQouva7if60UVOwt42VfGwCyUQlK3bRH0
        M36Abg+mwwL5tAwUe0GJO/h21n2BkLw=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-198-FPQ7EM5qO62um1tTkfA1Kw-1; Fri, 20 Dec 2019 16:01:55 -0500
X-MC-Unique: FPQ7EM5qO62um1tTkfA1Kw-1
Received: by mail-qt1-f199.google.com with SMTP id e37so6781907qtk.7
        for <linux-kernel@vger.kernel.org>; Fri, 20 Dec 2019 13:01:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5JYh7n3fhb27PXs/bYUs6lzlcg1ya8dgcofIlxRo1Jg=;
        b=KEBLf2RVH0OjcZ0ocPk48AxqeolWGB7kvBKZZpp2Gp5Ae7AVppy4rSzJNk4bG/YE9u
         0X3YBrS3aevktZuxXxRnfZEa54Iy+T9waobXtio5ac1RB2xuCiuVPUFYBJE5q41S3H+8
         LtaeJOgup1DrifzYe3NcFTDjZH4r8mnbPh39o124AU7Gb4fXo+L0HJlhYbz9IVXdxWjH
         LokxbFXxFaytyOnbBiA9SUfBAvTZ+6S8rAwc48zqRezbr9Klm/yIHiSF07ZUej5IqpNO
         OFAh1PsoU2FkTiNlfszyTbZZNY2Tk8KXSEQsD7c0pQBIT3kf9iwKlzI3DpaXrNn6Frt0
         Unkw==
X-Gm-Message-State: APjAAAWO/WBxBXo43mTFhr0Fwp89XtvvSnxjhIj8mkTrj34r8JZqHYF8
        q/RU0+tDplw8e7JycxyjyHXxozhhc8RDC6m80upeFzjplymr1K5+fcv6uOz9cYwNV8aaHlpLFVM
        UETnSMVSP7hnuYIMOV+77KzgI
X-Received: by 2002:a0c:e790:: with SMTP id x16mr13985282qvn.18.1576875715454;
        Fri, 20 Dec 2019 13:01:55 -0800 (PST)
X-Google-Smtp-Source: APXvYqzxjMbl8dopUvmXOVnU59sQzlQMC13n1sxeg16FHaFklsjTG3gNoJMkd4GKQCJVP7iplYp8CA==
X-Received: by 2002:a0c:e790:: with SMTP id x16mr13985250qvn.18.1576875715239;
        Fri, 20 Dec 2019 13:01:55 -0800 (PST)
Received: from xz-x1.redhat.com ([104.156.64.74])
        by smtp.gmail.com with ESMTPSA id q25sm3243836qkq.88.2019.12.20.13.01.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2019 13:01:54 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jason Wang <jasowang@redhat.com>, peterx@redhat.com,
        Paolo Bonzini <pbonzini@redhat.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Christophe de Dinechin <dinechin@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        "Michael S . Tsirkin" <mst@redhat.com>
Subject: [PATCH v2 04/17] KVM: Cache as_id in kvm_memory_slot
Date:   Fri, 20 Dec 2019 16:01:34 -0500
Message-Id: <20191220210147.49617-5-peterx@redhat.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191220210147.49617-1-peterx@redhat.com>
References: <20191220210147.49617-1-peterx@redhat.com>
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

