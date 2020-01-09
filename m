Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 064A2C282DD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 16:09:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE5FC2080D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 16:09:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d7fqNDuX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387410AbgAIQJF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 11:09:05 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:23401 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1733300AbgAIQJD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 11:09:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578586142;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4dPDKFSZi3e3u+46jDRIhE74sgAn3tXL+nGRZRHhzxI=;
        b=d7fqNDuXKGF2XLLHSzG8vcPjBLx6rY25RjoNT3JqGPEGcr795Z+PJaPhE2BKGXeejyqpqB
        RQnlhu41+vIXR8SWHcIGIZKbDy61kDD1PFKlFsKKYEoBFVoet1aYTWTf9oAIxQB9hohTMO
        9n6pfRaNTwrrYPJhekN/E7oMGgfMoic=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-284-0DcdCpzlNyuoBW7hHuh1fQ-1; Thu, 09 Jan 2020 11:09:01 -0500
X-MC-Unique: 0DcdCpzlNyuoBW7hHuh1fQ-1
Received: by mail-wr1-f69.google.com with SMTP id t3so3024402wrm.23
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 08:09:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4dPDKFSZi3e3u+46jDRIhE74sgAn3tXL+nGRZRHhzxI=;
        b=ilKoEhZBGMQ45M3KiWuOn1uWwEStufKLuXe/LdpVKzQg7kMLZf9bF040qSif7Pr7eI
         WbnOriPheR4X+5OMUKbr/QJD/qrq/TkXk7egJHJjVA1v6eYwwHBG7M0pLOgdot77kBJW
         ezR2w5o4aBxSj9hMl8scvkHaHlt+CwN3meI+ffWddcZ0yqLTofPga3xJER9ms8hEpxr/
         anaq+9BO4V1a1r23iGs1zTvlY7DrgyB0OQdZ8iK3JsdgoReBmmWPKW9GzqYmLW9WeVUP
         DoYZQHzrwuHxVdMAg0atmF0MDUzaCohmparCHHTkhcS5yyt743IAPGp9pdyezOQdQKn/
         mVlw==
X-Gm-Message-State: APjAAAX7G2vHxQQmz2uL+jVtFp5KHXgwGC+Xvd/dKY1KsglNUYzmHmHC
        wdb/jPFSNiQpZHLdqKZEB5/1vfddtsWMdD1vOY5yWXWpJMzIzk29/ZowjAnf2f6/Jab5am6u7ka
        SAZswalkjseTfPTM01zEvNLKV
X-Received: by 2002:adf:a746:: with SMTP id e6mr12285683wrd.329.1578586140100;
        Thu, 09 Jan 2020 08:09:00 -0800 (PST)
X-Google-Smtp-Source: APXvYqxidILoaEYUa5ievTi0I/NuFQayb9Diwg52FSlLGCUYTke4Wmfm1U43xAy4el85wmxpFXckwg==
X-Received: by 2002:adf:a746:: with SMTP id e6mr12285661wrd.329.1578586139895;
        Thu, 09 Jan 2020 08:08:59 -0800 (PST)
Received: from redfedo.redhat.com (host81-140-166-164.range81-140.btcentralplus.com. [81.140.166.164])
        by smtp.gmail.com with ESMTPSA id v8sm8403505wrw.2.2020.01.09.08.08.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 08:08:59 -0800 (PST)
From:   Julien Thierry <jthierry@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     jpoimboe@redhat.com, peterz@infradead.org, raphael.gault@arm.com,
        catalin.marinas@arm.com, will@kernel.org,
        Julien Thierry <jthierry@redhat.com>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        kvmarm@lists.cs.columbia.edu
Subject: [RFC v5 49/57] arm64: kvm: Annotate non-standard stack frame functions
Date:   Thu,  9 Jan 2020 16:02:52 +0000
Message-Id: <20200109160300.26150-50-jthierry@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200109160300.26150-1-jthierry@redhat.com>
References: <20200109160300.26150-1-jthierry@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Raphael Gault <raphael.gault@arm.com>

Both __guest_entry and __guest_exit functions do not setup
a correct stack frame. Because they can be considered as callable
functions, even if they are particular cases, we chose to silence
the warnings given by objtool by annotating them as non-standard.

Signed-off-by: Raphael Gault <raphael.gault@arm.com>
Signed-off-by: Julien Thierry <jthierry@redhat.com>
Cc: Marc Zyngier <maz@kernel.org>
Cc: James Morse <james.morse@arm.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: kvmarm@lists.cs.columbia.edu
---
 arch/arm64/kvm/hyp/entry.S | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/kvm/hyp/entry.S b/arch/arm64/kvm/hyp/entry.S
index e5cc8d66bf53..c3443bfd0944 100644
--- a/arch/arm64/kvm/hyp/entry.S
+++ b/arch/arm64/kvm/hyp/entry.S
@@ -15,6 +15,7 @@
 #include <asm/kvm_asm.h>
 #include <asm/kvm_mmu.h>
 #include <asm/kvm_ptrauth.h>
+#include <linux/frame.h>

 #define CPU_GP_REG_OFFSET(x)	(CPU_GP_REGS + x)
 #define CPU_XREG_OFFSET(x)	CPU_GP_REG_OFFSET(CPU_USER_PT_REGS + 8*x)
@@ -97,6 +98,7 @@ alternative_else_nop_endif
 	eret
 	sb
 ENDPROC(__guest_enter)
+asm_stack_frame_non_standard __guest_enter

 ENTRY(__guest_exit)
 	// x0: return code
@@ -193,3 +195,4 @@ abort_guest_exit_end:
 	orr	x0, x0, x5
 1:	ret
 ENDPROC(__guest_exit)
+asm_stack_frame_non_standard __guest_exit
--
2.21.0

