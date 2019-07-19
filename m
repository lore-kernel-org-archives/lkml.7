Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B206C76195
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 16:42:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 051BB2186A
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 16:42:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u0N3+jtR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731279AbfGSQmW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 12:42:22 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37447 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731228AbfGSQmU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 12:42:20 -0400
Received: by mail-wm1-f67.google.com with SMTP id f17so29598180wme.2;
        Fri, 19 Jul 2019 09:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:subject:date:message-id;
        bh=NX3B7F93lLikDxkB/4J8Fzq5bn6+NjQsj9cKn6LWoco=;
        b=u0N3+jtRDEK9M87I8GTbRnqE10+0YVabk6iok++cc1VXxHma8Sq14EEEGMawUepzw3
         Jtxgqv+eRW3G0pA57y5MioTheixX+6zh9OJm1hTIT3/tYfuoIKYyApqrrnsEuSsitzdD
         AtYyIIzyuntIvXOHPt97ThReW5Y0Fsmv0DlGvuQ1rbnZvJlJ6yi9A2vKkEo3dKm6/XuE
         sIt5AW5gkkxQsAg6AVbQzzt10kVggx7cntRsNoHALl6kuIgoOcZUDJnVTNVJOKiU8FNl
         m3jJHsl25Shycr218Hpz8M2Ul2j4gORyVRsnFFnaoY3wzyA7/KlSVfS1NRgrGEQzNSiK
         POEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:subject:date:message-id;
        bh=NX3B7F93lLikDxkB/4J8Fzq5bn6+NjQsj9cKn6LWoco=;
        b=hpW6kwqH2L3NKFVMOCTgg6DDBfJk2mO26r43iMYiNyQ8Nf7L9/CPTt3Jskl4IiTNwg
         wuflz/9tb6AmJhpgv4LdaRNRuTTzY7dMqNUMnykvOaYvy7oK9L6WOsVGMV+XXFUtTRei
         Gbiztab8QYnx8j2lK34tKwBYO+PPMsELHbBdHIEZ6t9bN3Hg5YXg5N5A7ew/DpB6mRNx
         imSOaqFXlpTM1lpsQZpc+tkpTld3IUNDTq5JnOCJVKA1Of4Y8UFUPDyczMMKrSEPvFBv
         E+Ej9pJpdIp2HehfZrAHv+v7ca8ftWe2kVFqRhXjZsiQZjVdlOp7iy4jruOrKrn1sIg+
         Y5Dw==
X-Gm-Message-State: APjAAAX9NUNVOBw1SZ7OzUAKfsUxFl2KiolP/Ou+kSVKSEir9sgx7x6T
        ugaVsd45j00NxsxMRr5TWLXRxt2SD6g=
X-Google-Smtp-Source: APXvYqzRtIqoH3g+yreywZ79h+eaSBnq5usBebRQYqAqoIuzz/45Z+2gZGKwq89p536Jr4Z0tQtcOA==
X-Received: by 2002:a1c:f418:: with SMTP id z24mr191826wma.80.1563554538117;
        Fri, 19 Jul 2019 09:42:18 -0700 (PDT)
Received: from 640k.localdomain ([93.56.166.5])
        by smtp.gmail.com with ESMTPSA id g19sm32764233wmg.10.2019.07.19.09.42.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Jul 2019 09:42:16 -0700 (PDT)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Subject: [PATCH] KVM: VMX: WARN on invalid vmptrld or vmclear
Date:   Fri, 19 Jul 2019 18:42:13 +0200
Message-Id: <1563554534-46556-2-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/vmx/ops.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/vmx/ops.h b/arch/x86/kvm/vmx/ops.h
index 2200fb698dd0..b143cee701c3 100644
--- a/arch/x86/kvm/vmx/ops.h
+++ b/arch/x86/kvm/vmx/ops.h
@@ -186,7 +186,7 @@ static inline void vmcs_clear(struct vmcs *vmcs)
 
 	asm volatile (__ex("vmclear %1") CC_SET(na)
 		      : CC_OUT(na) (error) : "m"(phys_addr));
-	if (unlikely(error))
+	if (WARN_ON_ONCE(error))
 		printk(KERN_ERR "kvm: vmclear fail: %p/%llx\n",
 		       vmcs, phys_addr);
 }
@@ -201,7 +201,7 @@ static inline void vmcs_load(struct vmcs *vmcs)
 
 	asm volatile (__ex("vmptrld %1") CC_SET(na)
 		      : CC_OUT(na) (error) : "m"(phys_addr));
-	if (unlikely(error))
+	if (WARN_ON_ONCE(error))
 		printk(KERN_ERR "kvm: vmptrld %p/%llx failed\n",
 		       vmcs, phys_addr);
 }
-- 
1.8.3.1

