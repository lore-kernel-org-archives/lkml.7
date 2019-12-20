Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E1E4C2D0C8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 21:01:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 022F720866
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 21:01:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e7lpG53K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727536AbfLTVBz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 16:01:55 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:41239 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727413AbfLTVBy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 16:01:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576875712;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5u+NdTdcxJqnd4CDcK36kvrGYVN4B69rZJAB5gjRDOQ=;
        b=e7lpG53KqlV6conebAcaRlzT30AbUhYRl5pzErRN/VO05Z/cIlq/6Y85y34HbGCz9Lq/rZ
        3MCXelfhNRgJdqPgkkCaBr82ZzkfvuS0Uz4ofeI/d1dQBN5XO2Qz2NwML/8hH8ZCc+XFDm
        h/BQRPG+UVrtYONf96rOEcsnrVFd/To=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-420-e41o1tWXO-CaEpgPMs6Zfg-1; Fri, 20 Dec 2019 16:01:50 -0500
X-MC-Unique: e41o1tWXO-CaEpgPMs6Zfg-1
Received: by mail-qk1-f200.google.com with SMTP id a200so6725903qkc.18
        for <linux-kernel@vger.kernel.org>; Fri, 20 Dec 2019 13:01:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5u+NdTdcxJqnd4CDcK36kvrGYVN4B69rZJAB5gjRDOQ=;
        b=iQhStRhrNzr3mzcj0whCNGYilN8B91zx28gUo2qg+RPIy9bDYP3H26A6G1ysPdnUCx
         /lDpSw/msVnGYA9UhP3ExOfB1afW6SQg/T1Jsw+lXEBFV7JooLF4WpFt8n6pLgb0C9BR
         7yaI8irw/Ocwpl+ySTMKUedoQU781hFhIuBKvp8FkoWPjbFPsdkamKSElh+ma88wBXVe
         nIbLJc9qEfz+lwM+YM8XSzEdgVcaQik4FmKO/c6g94Xy1ueDwbOSpnElEEaJxmpdJixx
         mKDakLfjXVrEcSR4vsihd/5ijPxx0xqIcqsiHX4FpNYjNkLZP8t9/p1p2KerKqiNC5ho
         sqaw==
X-Gm-Message-State: APjAAAWY7ELd25prGoqPwujfY5ocODpc4O1sSGy3eW6/8sjN4mTgtXPh
        n2WxUvYpl5ZSU05aF19LOXtIIl7eAuigSM1IUkr4A7NaEDuc0G3LKCUDXDhEfAGW7w2PnzojiWy
        ivxyt6WU5S3UU4qFoWDGQF9Jk
X-Received: by 2002:ac8:7201:: with SMTP id a1mr13291511qtp.51.1576875710500;
        Fri, 20 Dec 2019 13:01:50 -0800 (PST)
X-Google-Smtp-Source: APXvYqwRoak70ZtDSXTrsL5BKFgZ8eU8b8vS29Tx8wICbfjkV/PqQRqigL5g2qPUrK/6ZAtRLM0GFw==
X-Received: by 2002:ac8:7201:: with SMTP id a1mr13291492qtp.51.1576875710346;
        Fri, 20 Dec 2019 13:01:50 -0800 (PST)
Received: from xz-x1.redhat.com ([104.156.64.74])
        by smtp.gmail.com with ESMTPSA id q25sm3243836qkq.88.2019.12.20.13.01.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2019 13:01:49 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jason Wang <jasowang@redhat.com>, peterx@redhat.com,
        Paolo Bonzini <pbonzini@redhat.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Christophe de Dinechin <dinechin@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        "Michael S . Tsirkin" <mst@redhat.com>
Subject: [PATCH v2 01/17] KVM: Remove kvm_read_guest_atomic()
Date:   Fri, 20 Dec 2019 16:01:31 -0500
Message-Id: <20191220210147.49617-2-peterx@redhat.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191220210147.49617-1-peterx@redhat.com>
References: <20191220210147.49617-1-peterx@redhat.com>
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

