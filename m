Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCCFEC43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 21:04:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B2BA21655
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 21:04:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tm7a1GkV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727832AbfLTVEA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 16:04:00 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:32678 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727763AbfLTVDp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 16:03:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576875824;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vtGsufOEBQRYi5aVidxZ4SgIBK6STwpDg+qKmGEtjBY=;
        b=Tm7a1GkVSDkNmrWQl5WmAGUw/J4BAkBFkeG7OsTKRvltwfOkFttqEtnHsQeP3Uk0SYf4QI
        rF4xhJ/yO5A1XLkdwMpurc/NCJmUKpL59EQ2Pnt/sy/7niwWScf25fmRKZvTvv9iz/WW1h
        p1+YVjEifGn/xZ1u+Oqjz8v/03rr/SY=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-6-0GAfLp5-NISy3Unh2ok-Iw-1; Fri, 20 Dec 2019 16:03:39 -0500
X-MC-Unique: 0GAfLp5-NISy3Unh2ok-Iw-1
Received: by mail-qk1-f197.google.com with SMTP id 24so6689261qka.16
        for <linux-kernel@vger.kernel.org>; Fri, 20 Dec 2019 13:03:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vtGsufOEBQRYi5aVidxZ4SgIBK6STwpDg+qKmGEtjBY=;
        b=pAK3GdpY7uiQb32ptdtN1tHkXqrUwaIN4Nl82Ek8sjPM5x15rUVgWcmHbkoQ49MPHB
         uYw1ecuo4BQ7xy4dbcGmliUHbktbgOd4OH7kDjoZ6g7IO+wJXLWXPv4RnxHcUnRfyk+D
         a9RWkovRxYHCwHp3LPEmsHaDtN3mfZOR1lKE24pW5xbEvYhQ19dk8Qpt33N5HF4J8AQy
         D8KmSs1tb0HsvVsW/e3jlNNkGVjpQqF3Qh5AXXIvHvTMS4M4Z0w2DKB8cbFX46Id8MV3
         GaVxdHhQreeApH/Lma3H5vUuSOFWNexYZNw67SJJ+5c07fDRvm7AL4FsoiihmYeZ7Oge
         puqg==
X-Gm-Message-State: APjAAAW00qoFi0H2U+wi+fleaoMcnihuKp4r3wjPAur8XVVo1ESCeW2U
        IseB9FPtzrcSyTEv5z6gmcydCFMsIRDpb9iucHcvXiNUJqmp7VEsG9f2xD9JPy3PrNEergF4QU8
        yV9o1ZfBnu3JW9Pj4522S1AHs
X-Received: by 2002:ac8:21b5:: with SMTP id 50mr13151564qty.10.1576875818729;
        Fri, 20 Dec 2019 13:03:38 -0800 (PST)
X-Google-Smtp-Source: APXvYqxlRImFhrwNawCgIAgsSOJ1EXj2A5IDQwkpl6IsO1iQYvfDSTKLXH5QiQ2SH4/hegAbB9Mfzg==
X-Received: by 2002:ac8:21b5:: with SMTP id 50mr13151548qty.10.1576875818573;
        Fri, 20 Dec 2019 13:03:38 -0800 (PST)
Received: from xz-x1.redhat.com ([104.156.64.74])
        by smtp.gmail.com with ESMTPSA id a9sm3061018qtb.36.2019.12.20.13.03.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2019 13:03:36 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     peterx@redhat.com,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Christophe de Dinechin <dinechin@redhat.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Jason Wang <jasowang@redhat.com>
Subject: [PATCH v2 05/17] KVM: Add build-time error check on kvm_run size
Date:   Fri, 20 Dec 2019 16:03:14 -0500
Message-Id: <20191220210326.49949-6-peterx@redhat.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191220210326.49949-1-peterx@redhat.com>
References: <20191220210326.49949-1-peterx@redhat.com>
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

