Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F589C33CA2
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 14:57:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 760ED2072A
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 14:57:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ifvsF29A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731974AbgAIO55 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 09:57:57 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:47551 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731943AbgAIO5w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 09:57:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578581871;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aRATN7sKWcZdWDij4U02uLG0iob0fByx2e0Dt2ueT/w=;
        b=ifvsF29AAoPaNiAHGjmliWV+BCppV20kafRoHF6alACjBXV07bNOtoAzxGDXao2nxE2uSi
        iU6iq9Xa5yRnDTFiH3vuPbizJJjwZfw+u64FmA7Z8GVnJSz1zw1FqfNt6FO6Ai9bVxdZzE
        1Ci4jtQ1pGzBw4wOHGmqJsAF3OFmwIc=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-358-EAjB-O8FM-qXNnANpdX_mg-1; Thu, 09 Jan 2020 09:57:48 -0500
X-MC-Unique: EAjB-O8FM-qXNnANpdX_mg-1
Received: by mail-qt1-f199.google.com with SMTP id m30so4364742qtb.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 06:57:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aRATN7sKWcZdWDij4U02uLG0iob0fByx2e0Dt2ueT/w=;
        b=BPj0xRucAOYAZla5sKlXW2rg+EDAaC0kswvJR+39BJaodfPRT08yoELpVva8VnfRhZ
         Ti6rLEwQ/a3y25XZWNS8nUIbYDpRaVXtdYXY6Av1zLYWn+x/AChoETZFH/ipGbEEo9Vb
         R9xUzMTzgwpm3BLlrH9Kt/Da9bKuBLMrWwvhTKhYztd4X7EdqaazXO65VEYojO/xAxHd
         l7Kphkz3IKNF9TDDkfWRT2ziGqnmvy5ChYkVltzOFPXVzPeSKZHPA/vfsiYZfI+pY5AN
         PYHjtBVYefXV+z+JdyqpJLpzmNFsx+ZWCe2CU6AWVrmBkTqYw8USx3C0J7lNvI2UiklU
         lVyw==
X-Gm-Message-State: APjAAAUD43qMidavFVwsn120t1lSMeC/IKFJ6qs47b70pYS/rAZSfVzU
        /dED69SEpQ6G7TOJpFfT/J2IFuZR7W6mEBGeWv8I8IfNdlyUiIrCEcb4ampWACZZpIok2TF7JFP
        OuGypOAgQOPF8H5RiWNq3ljeV
X-Received: by 2002:a05:620a:102e:: with SMTP id a14mr9511642qkk.159.1578581868294;
        Thu, 09 Jan 2020 06:57:48 -0800 (PST)
X-Google-Smtp-Source: APXvYqyRbVnZp1vzZ6tL+7JcD0WsY8mA3XV8L6qTwZsx0HCnJl+m4kcc+RK3EtswtsJg3qtmZCifYA==
X-Received: by 2002:a05:620a:102e:: with SMTP id a14mr9511621qkk.159.1578581868090;
        Thu, 09 Jan 2020 06:57:48 -0800 (PST)
Received: from xz-x1.yyz.redhat.com ([104.156.64.74])
        by smtp.gmail.com with ESMTPSA id q2sm3124179qkm.5.2020.01.09.06.57.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 06:57:46 -0800 (PST)
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
Subject: [PATCH v3 05/21] KVM: X86: Change parameter for fast_page_fault tracepoint
Date:   Thu,  9 Jan 2020 09:57:13 -0500
Message-Id: <20200109145729.32898-6-peterx@redhat.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200109145729.32898-1-peterx@redhat.com>
References: <20200109145729.32898-1-peterx@redhat.com>
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
index 3c6522b84ff1..456371406d2a 100644
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
 	TP_PROTO(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa, u32 error_code,
@@ -274,12 +271,10 @@ TRACE_EVENT(
 	),
 
 	TP_printk("vcpu %d gva %llx error_code %s sptep %p old %#llx"
-		  " new %llx spurious %d fixed %d", __entry->vcpu_id,
+		  " new %llx ret %d", __entry->vcpu_id,
 		  __entry->cr2_or_gpa, __print_flags(__entry->error_code, "|",
 		  kvm_mmu_trace_pferr_flags), __entry->sptep,
-		  __entry->old_spte, __entry->new_spte,
-		  __spte_satisfied(old_spte), __spte_satisfied(new_spte)
-	)
+		  __entry->old_spte, __entry->new_spte, __entry->retry)
 );
 
 TRACE_EVENT(
-- 
2.24.1

