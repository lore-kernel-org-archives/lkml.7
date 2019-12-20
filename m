Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C936C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 21:02:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00F772146E
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 21:02:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hgiV5wlj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727707AbfLTVCc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 16:02:32 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:31733 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727478AbfLTVBy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 16:01:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576875713;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=m4Ydwgp5PpMnSage4lUP1t9xcFgD9PS/bCLMno8IgRs=;
        b=hgiV5wlj3wFmzZwH/RHvvGqBrK/BNLeSLIE0aaDrKVhutX1D2ZtQ6qtU2z7EG3D+C/uOuX
        P7j3F+aVU1UxVY2a/UGPd6aBYLp3RJrQ2Y8IVsx3qxGXNsO/GTmHPfFdC7z9OQhrOTu+Za
        UO1Zrn81udgPGKsSDe22EN/NSxefPrU=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-261-CQ-f8BNwNqGDSa3PN0JHXQ-1; Fri, 20 Dec 2019 16:01:52 -0500
X-MC-Unique: CQ-f8BNwNqGDSa3PN0JHXQ-1
Received: by mail-qt1-f197.google.com with SMTP id b14so6840048qtt.1
        for <linux-kernel@vger.kernel.org>; Fri, 20 Dec 2019 13:01:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=m4Ydwgp5PpMnSage4lUP1t9xcFgD9PS/bCLMno8IgRs=;
        b=lZ31x2pTwhacyt6BnUzow/2m/olnVVXHsP7atcFO3FWbM2bPXhu2Yer8plCqJqMNlq
         +wgEpkflbjhmRDXv5YGMtu2du3MQVPSWzQGXPOpsbBHjJYJhOlf+uTPAdBW4WP/O4rqz
         nK/2zciUKM2/cuOYNwxyVJ7mNud+SiM8RmK64bVgUIYgTXaePiDi9hP1X925mK26nx/5
         UFx+J33jlR+PL9MRnl9qVhIbhg24SukCVilz4D2TFeLHaQB+3BTndI0Nlm+LQ4fwEybH
         11RqDzwBK2eZ84dhO8VvNSipc0oE1wf1tmhDCE5ltZC/GrY8g96a99320n2kBNpAmjdo
         AxMg==
X-Gm-Message-State: APjAAAX8hFjxQCOOUaC/irQi2QRWL5cq7Fi/YpmLeHuQ0MyChVYEqaf+
        e7ZgLuHqYsZxzhn2WP0wi/4PLeM7Dzulv+rrf53kEZA2xwYHpOphZbEAyuWM+XG0NkuiBTnpZ8x
        jf8dmDkkY0nMo42pm2GRUBJln
X-Received: by 2002:a0c:a145:: with SMTP id d63mr14562956qva.120.1576875711978;
        Fri, 20 Dec 2019 13:01:51 -0800 (PST)
X-Google-Smtp-Source: APXvYqyyE0CUezS064v/bD144uhIMYKgEXzWV3W5bB3BV3yElQzPwD/3hl0DjnyDKfJVzzqxYHiA7w==
X-Received: by 2002:a0c:a145:: with SMTP id d63mr14562932qva.120.1576875711752;
        Fri, 20 Dec 2019 13:01:51 -0800 (PST)
Received: from xz-x1.redhat.com ([104.156.64.74])
        by smtp.gmail.com with ESMTPSA id q25sm3243836qkq.88.2019.12.20.13.01.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2019 13:01:51 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jason Wang <jasowang@redhat.com>, peterx@redhat.com,
        Paolo Bonzini <pbonzini@redhat.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Christophe de Dinechin <dinechin@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        "Michael S . Tsirkin" <mst@redhat.com>
Subject: [PATCH v2 02/17] KVM: X86: Change parameter for fast_page_fault tracepoint
Date:   Fri, 20 Dec 2019 16:01:32 -0500
Message-Id: <20191220210147.49617-3-peterx@redhat.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191220210147.49617-1-peterx@redhat.com>
References: <20191220210147.49617-1-peterx@redhat.com>
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

