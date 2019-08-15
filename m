Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E367BC433FF
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 07:41:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B99AE205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 07:41:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ng42SaxJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730519AbfHOHlc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 03:41:32 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52091 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726366AbfHOHla (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 03:41:30 -0400
Received: by mail-wm1-f65.google.com with SMTP id 207so512886wma.1;
        Thu, 15 Aug 2019 00:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=203QBNRDsU40BweVYIq1zq8GgAZoiZ5+xgte91iuHBU=;
        b=Ng42SaxJFviZnyyCgxsk/FOSqiD/Sn01vMiC8x4tb1/goIwVrzJkro47ZoVAApjXQO
         cVg872uh763mngEDr0oshvojOsSdrCoPecllBRuOtSeqVV6G2nR2o8BBEd2wHbzNuL+D
         igeB8whp1VKXxh1tQ3w2LAd+3gGLCOApgDSnf/bcC94HTnKF6roG+rD0pRgHlc1/2Wb3
         eRweOeF5Iz3SZOLXcFJu6Biia6d9fE/JmLMUmSkciSMEqO/Xt02DVRr9wzn6rdMSUj/C
         bNJKur64jHGFLLN44PZfuuGhwqtqrqWHo3low/lETBm7ydfrWVVbEsqRlL6Vk161l9RJ
         2mfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=203QBNRDsU40BweVYIq1zq8GgAZoiZ5+xgte91iuHBU=;
        b=fbx4PN9DLrryG+uHzCd59oiMSWvCB24edz4/kw+XaonHjpd/2B3M/3JhEjZ/y+qWwR
         BaO/x5YnylCOSAVoKEgzGgtp+1uSFYvwUaQesx3J4qCr/5qpLTvsBXkQBBq62ILyjqnU
         qRXjpOGNTytcXAmQZOwnHfK/RPphCb68hTNLASgNha8K9mcmEsbek9kKXg8Hndgl/RE5
         XTi0rCztoCcuGx+y9mgFOoJM19iHtzqOgcfgli106rrRiCjRlf+qFujY7bK4AQUYU12W
         OU+hP3SPaUwaWTLBA4w9rPcvrTWg44AseGlRfVnho1r0JFxLctGRE31uC5QLQH37izxq
         Ug9A==
X-Gm-Message-State: APjAAAXWB+xuJ0LzBq7CWswlMmgv6QDNKZ2eWTx6yxj9h3qJwue8qVQN
        lO/36gRlrdVFaCbZvaT6oVwmqAil
X-Google-Smtp-Source: APXvYqyBizrggMLtsrNCSp7vAMF2maezD72y4g4CI0QEtyKDHYeZ6fTHFIabzDLHeTwvA098jnLIZA==
X-Received: by 2002:a1c:6385:: with SMTP id x127mr1374763wmb.140.1565854888194;
        Thu, 15 Aug 2019 00:41:28 -0700 (PDT)
Received: from 640k.localdomain.com ([93.56.166.5])
        by smtp.gmail.com with ESMTPSA id m23sm809796wml.41.2019.08.15.00.41.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Aug 2019 00:41:27 -0700 (PDT)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: [PATCH 2/2] KVM: x86: always expose VIRT_SSBD to guests
Date:   Thu, 15 Aug 2019 09:41:23 +0200
Message-Id: <1565854883-27019-3-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1565854883-27019-1-git-send-email-pbonzini@redhat.com>
References: <1565854883-27019-1-git-send-email-pbonzini@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Even though it is preferrable to use SPEC_CTRL (represented by
X86_FEATURE_AMD_SSBD) instead of VIRT_SPEC, VIRT_SPEC is always
supported anyway because otherwise it would be impossible to
migrate from old to new CPUs.  Make this apparent in the
result of KVM_GET_SUPPORTED_CPUID as well.

Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Reported-by: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/cpuid.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 145ec050d45d..5865bc73bbb5 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -747,11 +747,13 @@ static inline int __do_cpuid_func(struct kvm_cpuid_entry2 *entry, u32 function,
 		entry->ebx &= kvm_cpuid_8000_0008_ebx_x86_features;
 		cpuid_mask(&entry->ebx, CPUID_8000_0008_EBX);
 		/*
-		 * The preference is to use SPEC CTRL MSR instead of the
-		 * VIRT_SPEC MSR.
+		 * VIRT_SPEC is only implemented for AMD processors,
+		 * but the host could set AMD_SSBD if it wanted even
+		 * for Intel processors.
 		 */
-		if (boot_cpu_has(X86_FEATURE_LS_CFG_SSBD) &&
-		    !boot_cpu_has(X86_FEATURE_AMD_SSBD))
+		if ((boot_cpu_has(X86_FEATURE_LS_CFG_SSBD) ||
+		     boot_cpu_has(X86_FEATURE_AMD_SSBD)) &&
+		    boot_cpu_has(X86_FEATURE_SVM))
 			entry->ebx |= F(VIRT_SSBD);
 		break;
 	}
-- 
1.8.3.1

