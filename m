Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF447C2D0D2
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 21:17:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF728206DA
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 21:17:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T3p6McAp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727593AbfLTVQp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 16:16:45 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:59501 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727552AbfLTVQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 16:16:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576876601;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=m4Ydwgp5PpMnSage4lUP1t9xcFgD9PS/bCLMno8IgRs=;
        b=T3p6McApLyOvmU4IjHegRNpfdW0+JrMoVgWZ5APBA+aobQB64ZneJYxLTL8ZyqMcALX9C0
        PMEYyBEpPaUdzHumjGyotMegrrkNyXSScqcJ23JNt2likQrcFwt2LDMGzzQHxq2yjzPg3J
        lQMTCfGhRA6bpolIg6GD3S4M8PZedmY=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-367-69LpYB8oNuWxe5EK5AxctQ-1; Fri, 20 Dec 2019 16:16:40 -0500
X-MC-Unique: 69LpYB8oNuWxe5EK5AxctQ-1
Received: by mail-qk1-f199.google.com with SMTP id u30so6776070qke.13
        for <linux-kernel@vger.kernel.org>; Fri, 20 Dec 2019 13:16:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=m4Ydwgp5PpMnSage4lUP1t9xcFgD9PS/bCLMno8IgRs=;
        b=lxa4u8UgmCrgQL8HOlzOHK9DESHKJbDo9DCy9RrFKSmF8Zq8Fb5JWv3EoCbUcAG9Om
         ekOqXJuHNyjsewsRYYcEUCFQaSmqr1bd3diMzaDFRs9jqgh7qw1YtdsY5cQ1YZ8P8nko
         BE0LcOpW+eZCSmuVkt8Vr3vHKAKiBTDcbg/rFb2sV40h4eTkLg/zSUbwzDnv74/66WmZ
         NiPhpE3XgCBPdvt/jijIz6CZEDoWtBLy65LGFXKFYbyZd5CHTXGK8Cf92oYGxyOHAcrt
         UGvdjKfn5Wq2Bz+gJnum6xIjIdH8TTOhrhX06L7nYJJ3xYwyVEIZOYPSCs+aO6dJ3Ui1
         u2pQ==
X-Gm-Message-State: APjAAAVIqFx3wsVzdtaJT2r/XVCs7FXGxm7mwoLUZ9NJETpi8eRUrOO2
        m2xTWdjVFYQhIvoxr/hiT+QbV4xb3NMDrebuWuHgXOa10pOj0jJrN/Ka6h5MNvRT29qgNUMonew
        akJBN9u/wejZnSgTGkcX9lKmA
X-Received: by 2002:a37:b283:: with SMTP id b125mr15582021qkf.352.1576876600405;
        Fri, 20 Dec 2019 13:16:40 -0800 (PST)
X-Google-Smtp-Source: APXvYqxqq3JoIUjXp2hoYBTRFQiEJY1jwKxiTuHZFetaPNnJ4sDqpMkgZlBdB0zLL7zuFba+vifoJg==
X-Received: by 2002:a37:b283:: with SMTP id b125mr15581997qkf.352.1576876600127;
        Fri, 20 Dec 2019 13:16:40 -0800 (PST)
Received: from xz-x1.redhat.com ([104.156.64.74])
        by smtp.gmail.com with ESMTPSA id d25sm3385231qtq.11.2019.12.20.13.16.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2019 13:16:39 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Michael S . Tsirkin" <mst@redhat.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>, peterx@redhat.com,
        Jason Wang <jasowang@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Christophe de Dinechin <dinechin@redhat.com>
Subject: [PATCH v2 02/17] KVM: X86: Change parameter for fast_page_fault tracepoint
Date:   Fri, 20 Dec 2019 16:16:19 -0500
Message-Id: <20191220211634.51231-3-peterx@redhat.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191220211634.51231-1-peterx@redhat.com>
References: <20191220211634.51231-1-peterx@redhat.com>
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

