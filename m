Return-Path: <SRS0=ztpy=2L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95006C43603
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Dec 2019 01:50:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B54320866
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Dec 2019 01:50:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iSZ8GIpp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727210AbfLUBuY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 20:50:24 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:54381 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726879AbfLUBty (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 20:49:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576892993;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vtGsufOEBQRYi5aVidxZ4SgIBK6STwpDg+qKmGEtjBY=;
        b=iSZ8GIppd/xgOY+9traGKM22Zlu1sKaYS4nYG/u3HOLpQCf/3fbhNdDKztTlWLt6hr8wgC
        UAiDIn9ALnhSvgPkONFhsm2jvaf/mS5q7YokwDoh0JWFI1haP2dO/u0Icwl8TKa5Hj1eGP
        rqSFdcV9mosCeVwQqxdiu2Soz2nT5AU=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-160-BkXQqxxQOFKphVbUG_WO_w-1; Fri, 20 Dec 2019 20:49:52 -0500
X-MC-Unique: BkXQqxxQOFKphVbUG_WO_w-1
Received: by mail-qv1-f71.google.com with SMTP id dw11so7089516qvb.16
        for <linux-kernel@vger.kernel.org>; Fri, 20 Dec 2019 17:49:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vtGsufOEBQRYi5aVidxZ4SgIBK6STwpDg+qKmGEtjBY=;
        b=Rn8mfCPAOCc1I89O8r+X200/hFyMr5QWOlZsx9KNdTYRITEPaDJ32elMXBtco7Mz7g
         p//exwjSzx6HigqILzZlDD/KO2vj5KKHjFJ8jhyae0TC/XcQZWjvjrEKL+LFWpl0v8U3
         wjNwUkTtElV7nZyvG606viTKJOT+OnlBnHosWVl0z/VeLceMa8y6iOGWLXO6QBSavpFW
         8GUD0I7M2d3nunqsD9qRLEOm52TYiHHVukb9jcRmn27v+ujUTBjGglsgxcFsBP9LYYeQ
         9IjV4CdfTjcxaKEk9QemcibjqnOEgHokdeQ4WxU+q8ZNrOG96v1B0hBqbXdypCWRL51m
         GEfg==
X-Gm-Message-State: APjAAAUksHc32CoCigNuZF/+vYW2Y8RsYcMTdzyCqQaiZisoxfwY1ZW4
        gzh0alpEgSezDTDcRwXYmWcoXzeDnycLNNTRS5+umrvwzjDz+yofjObRlyQ4byK6SUfywsnPixQ
        YyfQ1Td5dAGzznVl3ZTlshbQQ
X-Received: by 2002:a05:620a:1415:: with SMTP id d21mr15599590qkj.17.1576892992029;
        Fri, 20 Dec 2019 17:49:52 -0800 (PST)
X-Google-Smtp-Source: APXvYqzBTIArtN4lEEvPhJ1OsMpqJjIbDkpETEk2hJbP6m1uKORdGncfp8pEiB1fiQ0lbIaC1pBwiQ==
X-Received: by 2002:a05:620a:1415:: with SMTP id d21mr15599581qkj.17.1576892991799;
        Fri, 20 Dec 2019 17:49:51 -0800 (PST)
Received: from xz-x1.hitronhub.home (CPEf81d0fb19163-CMf81d0fb19160.cpe.net.fido.ca. [72.137.123.47])
        by smtp.gmail.com with ESMTPSA id e21sm3396932qkm.55.2019.12.20.17.49.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2019 17:49:51 -0800 (PST)
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
Subject: [PATCH RESEND v2 05/17] KVM: Add build-time error check on kvm_run size
Date:   Fri, 20 Dec 2019 20:49:26 -0500
Message-Id: <20191221014938.58831-6-peterx@redhat.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191221014938.58831-1-peterx@redhat.com>
References: <20191221014938.58831-1-peterx@redhat.com>
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

