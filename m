Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1002BC00306
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 02:17:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 226E8206DE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 02:17:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404359AbfIFCRo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 22:17:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45064 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404334AbfIFCRk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 22:17:40 -0400
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 574683DE0B
        for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2019 02:17:40 +0000 (UTC)
Received: by mail-pl1-f197.google.com with SMTP id v4so2623331plp.23
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2019 19:17:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=U9X2ocg4xLLzJVV8u6FR7s0StrvzfFTOD0TsbOAZvYI=;
        b=Vv2DwtocUDNYX0iMpMKEpTxAOLnH+jJ21jow1Y52ERgeQ7eN4YlMhpA9GKRC1vJ61K
         MKqF9LMM06ggI2hNhTISQDXu8XpN/cTPXvL+lkszTLtAmqQ+0FVCrkjol3f8JFpeC+0O
         nu+2KrP87LsXG2Hr9TWgxoV4PmTAVKSByByjPpFTX1ccCF1M13KW2RXx1MbEYBiXLQB8
         Xva/ut40jJ/OhwYqFUl5MVvJqZ9jjaaujnpOnk4D0JPcdkvG+gaQl1AUJ/0BIVllwLbS
         /qHf7hmeV/o00dEHmhhvLvIqw+f1JqiDAJla4CRYLiBYUSn5RJNya9KRmrhDShQTFrBt
         RPFg==
X-Gm-Message-State: APjAAAVoC9pRnktYTePl2/RTIbLX2sS1FqXQoNx/kYbT7nJUpdxyxhWp
        EIcqo8m9GYtTBv9KiD7KBAYQmMwSRZtw9mco8ppBz3h9EdwJzr+AEvYcC//VfnD/HpdMcVXasOr
        biQpnx2lIsLCoJXlq1pqbUaWR
X-Received: by 2002:a17:902:e584:: with SMTP id cl4mr6712913plb.160.1567736259394;
        Thu, 05 Sep 2019 19:17:39 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzA7XI63VxKtVoT9lqWgBy/9HesvkQuEH5lLydx5b5gBH692ZTbf+VCfENgHvilhjZtCmHvMQ==
X-Received: by 2002:a17:902:e584:: with SMTP id cl4mr6712905plb.160.1567736259246;
        Thu, 05 Sep 2019 19:17:39 -0700 (PDT)
Received: from xz-x1.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id a11sm8212359pfg.94.2019.09.05.19.17.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2019 19:17:38 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <kernellwp@gmail.com>,
        Krish Sadhukhan <krish.sadhukhan@oracle.com>, peterx@redhat.com
Subject: [PATCH v4 2/4] KVM: X86: Remove tailing newline for tracepoints
Date:   Fri,  6 Sep 2019 10:17:20 +0800
Message-Id: <20190906021722.2095-3-peterx@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190906021722.2095-1-peterx@redhat.com>
References: <20190906021722.2095-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's done by TP_printk() already.

Reviewed-by: Krish Sadhukhan <krish.sadhukhan@oracle.com>
Reviewed-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/x86/kvm/trace.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/trace.h b/arch/x86/kvm/trace.h
index 20d6cac9f157..8a7570f8c943 100644
--- a/arch/x86/kvm/trace.h
+++ b/arch/x86/kvm/trace.h
@@ -1323,7 +1323,7 @@ TRACE_EVENT(kvm_avic_incomplete_ipi,
 		__entry->index = index;
 	),
 
-	TP_printk("vcpu=%u, icrh:icrl=%#010x:%08x, id=%u, index=%u\n",
+	TP_printk("vcpu=%u, icrh:icrl=%#010x:%08x, id=%u, index=%u",
 		  __entry->vcpu, __entry->icrh, __entry->icrl,
 		  __entry->id, __entry->index)
 );
@@ -1348,7 +1348,7 @@ TRACE_EVENT(kvm_avic_unaccelerated_access,
 		__entry->vec = vec;
 	),
 
-	TP_printk("vcpu=%u, offset=%#x(%s), %s, %s, vec=%#x\n",
+	TP_printk("vcpu=%u, offset=%#x(%s), %s, %s, vec=%#x",
 		  __entry->vcpu,
 		  __entry->offset,
 		  __print_symbolic(__entry->offset, kvm_trace_symbol_apic),
-- 
2.21.0

