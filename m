Return-Path: <SRS0=ztpy=2L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F6B5C43603
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Dec 2019 01:49:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6A692082E
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Dec 2019 01:49:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iguSVwnw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726634AbfLUBtu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 20:49:50 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:24201 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726598AbfLUBtt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 20:49:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576892987;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=m4Ydwgp5PpMnSage4lUP1t9xcFgD9PS/bCLMno8IgRs=;
        b=iguSVwnwRHcjEklnlNRXZ0jG3Vf9gps6wk6oEMLwU0p2TEd1G/X2eEgy7uC47tv8ZK+lPs
        KqCNm5htbzwu+wyrDLEbD2S8r2YVwJgS3/TCKc6mKsbcrgkU16m0B3sTa9ZZGskMgzxmnu
        z/KlRjU5deXFBjfyZVVpCae+ZvgTfc4=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-32-yg5_Yo21MtKW40lZimV1MQ-1; Fri, 20 Dec 2019 20:49:46 -0500
X-MC-Unique: yg5_Yo21MtKW40lZimV1MQ-1
Received: by mail-qt1-f198.google.com with SMTP id d18so7212138qtp.16
        for <linux-kernel@vger.kernel.org>; Fri, 20 Dec 2019 17:49:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=m4Ydwgp5PpMnSage4lUP1t9xcFgD9PS/bCLMno8IgRs=;
        b=iXo4G24N05ic4xPmWYkFqYApRIj6RSUhfnuBvdZwJSfoqsqC5Rv3Ylc0v7Xw/h5DAO
         qKlk4w7Mui6FNyWeYNUb4xk+1wWfYxYDryJ8vLNz2SgkrZeD067Ae10c9WSdeI0kaACL
         lebNa2SGatcPtpXqpRNTDXU5aYvm7kTYJY91QUgckVD+vr2vmbzakqLPxtZwXILAJXXF
         gWD035N/5baUExe3PpJVmvxyORukfhhWJSjUl7iz1hclqNKTjpjynSI9kycRYkF4kaCt
         B6nvbv9O2Qlzno4dLYDEG/JVgpOhLcejjjL81jNxICNf+gbPOzbHJP/A0PupTKSotrk5
         fiew==
X-Gm-Message-State: APjAAAXhEsfFqjyeKzhIlwQe9KuGFLKTav0gnQ6LVqa1vI7fTc/4p0kz
        OiEUGCAosAe/sLv9cKpstSNcSbGagJTgrKPsLayRUwXLG8ZGEnNqcWGfCXxc20er2n+UO4ws2Px
        XyCER7m/KuAujw58B72mF7nqI
X-Received: by 2002:ac8:7a6c:: with SMTP id w12mr14482171qtt.35.1576892986490;
        Fri, 20 Dec 2019 17:49:46 -0800 (PST)
X-Google-Smtp-Source: APXvYqy0xIujDWM8kEgYMZtJXBmHq7FpeBe6JthzaDGA1ivGB+9bq1sOU49m4a67oz82Pg8AlQmsnA==
X-Received: by 2002:ac8:7a6c:: with SMTP id w12mr14482162qtt.35.1576892986329;
        Fri, 20 Dec 2019 17:49:46 -0800 (PST)
Received: from xz-x1.hitronhub.home (CPEf81d0fb19163-CMf81d0fb19160.cpe.net.fido.ca. [72.137.123.47])
        by smtp.gmail.com with ESMTPSA id e21sm3396932qkm.55.2019.12.20.17.49.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2019 17:49:45 -0800 (PST)
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
Subject: [PATCH RESEND v2 02/17] KVM: X86: Change parameter for fast_page_fault tracepoint
Date:   Fri, 20 Dec 2019 20:49:23 -0500
Message-Id: <20191221014938.58831-3-peterx@redhat.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191221014938.58831-1-peterx@redhat.com>
References: <20191221014938.58831-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It would be clearer to dump the return value to know easily on whether
did we go through the fast path for handling current page fault.
Remove the old two last parameters because after all the old/new sptes
were dumped in the same line.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/x86/kvm/mmutrace.h | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kvm/mmutrace.h b/arch/x86/kvm/mmutrace.h
index 7ca8831c7d1a..09bdc5c91650 100644
--- a/arch/x86/kvm/mmutrace.h
+++ b/arch/x86/kvm/mmutrace.h
@@ -244,9 +244,6 @@ TRACE_EVENT(
 		  __entry->access)
 );
 
-#define __spte_satisfied(__spte)				\
-	(__entry->retry && is_writable_pte(__entry->__spte))
-
 TRACE_EVENT(
 	fast_page_fault,
 	TP_PROTO(struct kvm_vcpu *vcpu, gva_t gva, u32 error_code,
@@ -274,12 +271,10 @@ TRACE_EVENT(
 	),
 
 	TP_printk("vcpu %d gva %lx error_code %s sptep %p old %#llx"
-		  " new %llx spurious %d fixed %d", __entry->vcpu_id,
+		  " new %llx ret %d", __entry->vcpu_id,
 		  __entry->gva, __print_flags(__entry->error_code, "|",
 		  kvm_mmu_trace_pferr_flags), __entry->sptep,
-		  __entry->old_spte, __entry->new_spte,
-		  __spte_satisfied(old_spte), __spte_satisfied(new_spte)
-	)
+		  __entry->old_spte, __entry->new_spte, __entry->retry)
 );
 
 TRACE_EVENT(
-- 
2.24.1

