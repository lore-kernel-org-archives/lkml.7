Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1162CC43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 21:04:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3FF820866
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 21:04:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g338PQH4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727750AbfLTVER (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 16:04:17 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:37338 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727743AbfLTVDf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 16:03:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576875814;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=m4Ydwgp5PpMnSage4lUP1t9xcFgD9PS/bCLMno8IgRs=;
        b=g338PQH4L5FEQFySm2VjtVGXXjdOgtOAPLXB9UEXosY+8CPBmhXS/9Jugq1+hRNe+xwYFX
        94TIHhAoU79ZtJqC36YX7ZzYrds+7WRxpZFkqRRa7Zd2NfFKT9b9aNaDZ7UKKUsCDUdrLe
        idIRP1YDQoAYdkEKhYa1BYCPkUZ8OLU=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-203-dZ5kqtcuOHC39VC3xRIPlw-1; Fri, 20 Dec 2019 16:03:33 -0500
X-MC-Unique: dZ5kqtcuOHC39VC3xRIPlw-1
Received: by mail-qk1-f199.google.com with SMTP id s9so6676195qkg.21
        for <linux-kernel@vger.kernel.org>; Fri, 20 Dec 2019 13:03:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=m4Ydwgp5PpMnSage4lUP1t9xcFgD9PS/bCLMno8IgRs=;
        b=oZ7C+chcbugs7YSQ5G3jRsht6hYkuWLsm1YBeulO9BJsW2RRlYMYyqgYj/MUM36EIi
         5qIDghtxlXDWl+VhveTjCCyk/XRr+OOSCuCJ6F2m3hd2nz6FI8HiJAPmW8nZu6s2VRV6
         g2Ptg4r4tA+nK40tJaN1nP70lOMR8am3O7YSzyO6yHAfIk9GkP8+D+uQdQ7G+4mFMffp
         86qd9q3aDNONEzB3Xc+lXMOZ+OB9EcC0kM2kyHDyFNeSz4Mw78CAcuwwaXsedYnlMzI9
         PMNtiTLQQZKuldfHcO1dcJW2IrvpmCZvDVdh9D0mDr+2fhXg9f9ddIMD7B9u+zllkTEB
         cbRw==
X-Gm-Message-State: APjAAAW0BFfF9yxJGVC4S7hXWdOYmPLbvAyFDjd8/EN2EN4jdA33FOiB
        t4NptLxzaO88zVXSXVHWSndRAypvjwQHo9WAw9yP6pCEGvIJLNpDosXIRze6H6ZZC3nskQARMLj
        aD1JEN+1/3MabEgxzHjma8CUM
X-Received: by 2002:a05:620a:1324:: with SMTP id p4mr15563895qkj.497.1576875812886;
        Fri, 20 Dec 2019 13:03:32 -0800 (PST)
X-Google-Smtp-Source: APXvYqyzpJoDwbumEgXM2rd/MSIPuBvYBc/66AQA/wq59Gx92NiDKpzaG+U5dMYCgnpLzFCTUZBrpA==
X-Received: by 2002:a05:620a:1324:: with SMTP id p4mr15563877qkj.497.1576875812682;
        Fri, 20 Dec 2019 13:03:32 -0800 (PST)
Received: from xz-x1.redhat.com ([104.156.64.74])
        by smtp.gmail.com with ESMTPSA id a9sm3061018qtb.36.2019.12.20.13.03.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2019 13:03:31 -0800 (PST)
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
Subject: [PATCH v2 02/17] KVM: X86: Change parameter for fast_page_fault tracepoint
Date:   Fri, 20 Dec 2019 16:03:11 -0500
Message-Id: <20191220210326.49949-3-peterx@redhat.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191220210326.49949-1-peterx@redhat.com>
References: <20191220210326.49949-1-peterx@redhat.com>
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

