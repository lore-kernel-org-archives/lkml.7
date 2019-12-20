Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9543AC2D0D2
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 21:17:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66120218AC
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 21:17:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DxzNelQO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727731AbfLTVRM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 16:17:12 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:31619 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727618AbfLTVQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 16:16:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576876606;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vtGsufOEBQRYi5aVidxZ4SgIBK6STwpDg+qKmGEtjBY=;
        b=DxzNelQOJ/DytsZMSSzvL1ZvBjp7XSTkuODS14r8qDAtLGxOn+x95ktrduvrnCohBtkC+6
        GXq+XSfJTDNFhKTbHqmrfcZnh44ytvo6u8ez+xJEmzktEWfPCAi0GzJhiH+wrRGbqAphMZ
        D5AAZqqZpNoypN38REyBcnlHzTcC1SU=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-164-1qh3DpPgOYKa3u0u2Q7t9g-1; Fri, 20 Dec 2019 16:16:45 -0500
X-MC-Unique: 1qh3DpPgOYKa3u0u2Q7t9g-1
Received: by mail-qt1-f198.google.com with SMTP id b14so6869181qtt.1
        for <linux-kernel@vger.kernel.org>; Fri, 20 Dec 2019 13:16:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vtGsufOEBQRYi5aVidxZ4SgIBK6STwpDg+qKmGEtjBY=;
        b=VAnrXhflTcVOKDncWxj0f+MfLK4GCHgehaH5GKtJgE9O4y+1+c5UQIBhFYHrdv2cID
         vSdbBDYWqHtkPrN/BHUND1cWWJDh01nTUo/No6f3TkeodP1PeEeWpjhGNdXS5dO+PtXS
         v52bq1P9hOFoVFKZ+OARyA6rjvXUQ6ClIwbjIqJcxPBkGZzJmrZ5GEZv9nZZ0PmBpfjJ
         j2djZ6GbTPdWkM6iepPFwtbN2Eyn9HeObfqTKIkaMmWUUPd6zB2FKocqp9bS9/m/df51
         yhUiPIlxdlenkEEEzhEhLhn8vHSxW8fdGFZy+274J5SBuLlUONO1Qa6rqrQ504d6eXfM
         3brQ==
X-Gm-Message-State: APjAAAVzMF6i2sZuPBG2wlKpvk9UQmiBe3ymxk6Ju4/pEibntmTgPOl0
        gw+UP353/ja+8H9grkljd32fgoZYA5Y35roN0QUmkld4SVwmj/oFNQ5PiD/0bXlg30Q0lzRjM1M
        cWOWkqTSUhNUEfungW3QjkvmZ
X-Received: by 2002:ac8:21ad:: with SMTP id 42mr13496922qty.109.1576876605300;
        Fri, 20 Dec 2019 13:16:45 -0800 (PST)
X-Google-Smtp-Source: APXvYqyxJfdY2npnw+WJJ9LGUDhDJ3GdAKvxfRcNwnEPLa3VNxEWmU6aap1rDqvacndG3g4E/rZL+Q==
X-Received: by 2002:ac8:21ad:: with SMTP id 42mr13496910qty.109.1576876605131;
        Fri, 20 Dec 2019 13:16:45 -0800 (PST)
Received: from xz-x1.redhat.com ([104.156.64.74])
        by smtp.gmail.com with ESMTPSA id d25sm3385231qtq.11.2019.12.20.13.16.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2019 13:16:44 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Michael S . Tsirkin" <mst@redhat.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>, peterx@redhat.com,
        Jason Wang <jasowang@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Christophe de Dinechin <dinechin@redhat.com>
Subject: [PATCH v2 05/17] KVM: Add build-time error check on kvm_run size
Date:   Fri, 20 Dec 2019 16:16:22 -0500
Message-Id: <20191220211634.51231-6-peterx@redhat.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191220211634.51231-1-peterx@redhat.com>
References: <20191220211634.51231-1-peterx@redhat.com>
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

