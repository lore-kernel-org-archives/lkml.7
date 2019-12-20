Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 106E0C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 21:02:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D47C820866
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 21:02:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yrq0kOdV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727682AbfLTVCP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 16:02:15 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:60940 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727670AbfLTVCN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 16:02:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576875732;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vtGsufOEBQRYi5aVidxZ4SgIBK6STwpDg+qKmGEtjBY=;
        b=Yrq0kOdVbDiFr5Y/j7ATUwKA6I8N2zvGldFxt6fRrtlAu7ngH9D0YO4otnrtBhtEYvJmJ+
        OFEXG7eWvrEE4PFLKZvxRIg4IM5dTIJPXDCc1tAiT/47WWzh8aqJ8ojZmW6A0YTQxRa56u
        MHZkqaAA7JGz3Iem1JJUECrYUP8uCG0=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-419-7V8oYVszNf67MSNaiasc5g-1; Fri, 20 Dec 2019 16:02:00 -0500
X-MC-Unique: 7V8oYVszNf67MSNaiasc5g-1
Received: by mail-qt1-f199.google.com with SMTP id b7so3780312qtg.23
        for <linux-kernel@vger.kernel.org>; Fri, 20 Dec 2019 13:01:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vtGsufOEBQRYi5aVidxZ4SgIBK6STwpDg+qKmGEtjBY=;
        b=j8w2X/hkoXcROjk+jkSK+xxTxLGwqTm1pVjBarKIsvxViHSUKY6hwWGlekFiRN6X1x
         rXuRa53vVcxkh2dk3M+bh9JeFM4G7/mAUPSwmOP3BlI/pFw5mkf9BtZ3hCDKzFg7w9uE
         7GjkMn7FvSqOX+wnkWTEkx7c5i1D5VhiwThwY8R6PAVNWvPjkylhrRc3olUEryHQZ7L6
         AkYCOm3lHX9iQOAgJtCfpOzl69o84NxyF0FGgo6L1jc6CEn79MhakzzXpgIyl+pjf1Bz
         mhvy4RjOit8aWJTKF8BQ1FlvdkgR5dyHFaMgSQRzQdvF6eMnNdVz0Pw8xGMsvuIt6MiC
         mn1Q==
X-Gm-Message-State: APjAAAVEEu4S1uTBYjaLVChkz84qKIJWQNvDhriYh0Q88qOyVy/fFJ1+
        thu0K1cKsRf2wL7XFCGqAGIITjirFrwaO4o0hJ/RzSZ3PLWUCS9MeKQF/jaBWhq6fYv9A307VkH
        Nt/86l498YmsYxh9Ks79sWNvE
X-Received: by 2002:aed:2f01:: with SMTP id l1mr13185485qtd.391.1576875717090;
        Fri, 20 Dec 2019 13:01:57 -0800 (PST)
X-Google-Smtp-Source: APXvYqwUjglzhpKCa6NEkGoo+WgRdTpi2Yj49KnA848sGtgvwu9B6qCZKB1sG+DNQuHerE0WraffwA==
X-Received: by 2002:aed:2f01:: with SMTP id l1mr13185466qtd.391.1576875716921;
        Fri, 20 Dec 2019 13:01:56 -0800 (PST)
Received: from xz-x1.redhat.com ([104.156.64.74])
        by smtp.gmail.com with ESMTPSA id q25sm3243836qkq.88.2019.12.20.13.01.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2019 13:01:56 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jason Wang <jasowang@redhat.com>, peterx@redhat.com,
        Paolo Bonzini <pbonzini@redhat.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Christophe de Dinechin <dinechin@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        "Michael S . Tsirkin" <mst@redhat.com>
Subject: [PATCH v2 05/17] KVM: Add build-time error check on kvm_run size
Date:   Fri, 20 Dec 2019 16:01:35 -0500
Message-Id: <20191220210147.49617-6-peterx@redhat.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191220210147.49617-1-peterx@redhat.com>
References: <20191220210147.49617-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's already going to reach 2400 Bytes (which is over half of page
size on 4K page archs), so maybe it's good to have this build-time
check in case it overflows when adding new fields.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 virt/kvm/kvm_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index cea4b8dd4ac9..c80a363831ae 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -338,6 +338,7 @@ int kvm_vcpu_init(struct kvm_vcpu *vcpu, struct kvm *kvm, unsigned id)
 	vcpu->pre_pcpu = -1;
 	INIT_LIST_HEAD(&vcpu->blocked_vcpu_list);
 
+	BUILD_BUG_ON(sizeof(struct kvm_run) > PAGE_SIZE);
 	page = alloc_page(GFP_KERNEL | __GFP_ZERO);
 	if (!page) {
 		r = -ENOMEM;
-- 
2.24.1

