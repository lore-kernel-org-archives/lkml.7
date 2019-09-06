Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75B27C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 02:17:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82F2D206DE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 02:17:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404347AbfIFCRk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 22:17:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44420 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404334AbfIFCRh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 22:17:37 -0400
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3B61EC0578F8
        for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2019 02:17:37 +0000 (UTC)
Received: by mail-pg1-f197.google.com with SMTP id j9so2448756pgk.20
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2019 19:17:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PI0dvyELfgDR6EZuTiL1mpi7X9aW26KSG8PfN04SbrI=;
        b=FkfgDiJDBa+kVaPWUJmXN3rEgyVBvVO8TPFBq9q2SPiMj1cn94ZQg3ix638QyPLrnr
         pmS9PBVkCwI4GHa7haZDuDMNRA6JV+oadgPuDdgyQsqVo5vUC+BM45/+jWdhl33VF40Q
         Y3wxhsX6AkLG2TjRpgKhHDO2gi4EqH14CPjUNRFJWJprsKTCnqh/2SIAbFDJRGp0Zv/V
         JUVqNGdqCa5lQSomG5NFH/d7SOcxGZ8rxw6HdcocVUP4uuzmY5CPl1XjaCWS9AerR7rb
         eYamDbNynG3H615Fiki92OOS3mbGxTZkY/zbzaVcUpf84mTNmhUF0ICDQ7b/U9grkImI
         wy9A==
X-Gm-Message-State: APjAAAW9o7K0Dll1xEEcjmzpOPfdvKpvS0PL/ccf3I9d8RcpWwBa2qMs
        vlCqStS0Y5tRUgBIlN38886+ftuJekhSqh+d0fhVqlTKJa0yyl1oP1W4La8DhrGaE0ZQ6cTIc9N
        bvdB2t3GT9tCvdLrlS87kVCLs
X-Received: by 2002:a17:902:a507:: with SMTP id s7mr6835205plq.66.1567736256238;
        Thu, 05 Sep 2019 19:17:36 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyHNmYW/Tb/4gB158GISbxVxqvjGZfcetpu67IukX/XY4cAL70pd1u6vIEnBjmgKmkvmFrjng==
X-Received: by 2002:a17:902:a507:: with SMTP id s7mr6835191plq.66.1567736256066;
        Thu, 05 Sep 2019 19:17:36 -0700 (PDT)
Received: from xz-x1.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id a11sm8212359pfg.94.2019.09.05.19.17.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2019 19:17:35 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <kernellwp@gmail.com>,
        Krish Sadhukhan <krish.sadhukhan@oracle.com>, peterx@redhat.com
Subject: [PATCH v4 1/4] KVM: X86: Trace vcpu_id for vmexit
Date:   Fri,  6 Sep 2019 10:17:19 +0800
Message-Id: <20190906021722.2095-2-peterx@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190906021722.2095-1-peterx@redhat.com>
References: <20190906021722.2095-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tracing the ID helps to pair vmenters and vmexits for guests with
multiple vCPUs.

Reviewed-by: Krish Sadhukhan <krish.sadhukhan@oracle.com>
Reviewed-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/x86/kvm/trace.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/trace.h b/arch/x86/kvm/trace.h
index b5c831e79094..20d6cac9f157 100644
--- a/arch/x86/kvm/trace.h
+++ b/arch/x86/kvm/trace.h
@@ -232,17 +232,20 @@ TRACE_EVENT(kvm_exit,
 		__field(	u32,	        isa             )
 		__field(	u64,	        info1           )
 		__field(	u64,	        info2           )
+		__field(	unsigned int,	vcpu_id         )
 	),
 
 	TP_fast_assign(
 		__entry->exit_reason	= exit_reason;
 		__entry->guest_rip	= kvm_rip_read(vcpu);
 		__entry->isa            = isa;
+		__entry->vcpu_id        = vcpu->vcpu_id;
 		kvm_x86_ops->get_exit_info(vcpu, &__entry->info1,
 					   &__entry->info2);
 	),
 
-	TP_printk("reason %s rip 0x%lx info %llx %llx",
+	TP_printk("vcpu %u reason %s rip 0x%lx info %llx %llx",
+		  __entry->vcpu_id,
 		 (__entry->isa == KVM_ISA_VMX) ?
 		 __print_symbolic(__entry->exit_reason, VMX_EXIT_REASONS) :
 		 __print_symbolic(__entry->exit_reason, SVM_EXIT_REASONS),
-- 
2.21.0

