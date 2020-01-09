Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81F5DC282DD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 16:09:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55D8A206ED
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 16:09:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AoQiNHr/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387440AbgAIQJk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 11:09:40 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:20093 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387430AbgAIQJi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 11:09:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578586177;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NXlvrJt6z83MLX+WxwdFOCINB+GcX+Yj981D0b2qPGQ=;
        b=AoQiNHr/kMk+jVWM21dkD/M1ITTKfOgLtEEWGY6GoMQr20bGUG2bIsybpij6MRJFSgS47+
        8eMlX+wcqT46PUskfqiH9l8SHQ5/C2FSmvj2vijx1xDgdgQS/ZejiuOV61WeyEEy5ZE5bk
        I3Wpk9SLOuoA0WcmWargHlkr65EkEMI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-215-UztTS9imPWWleT3bvJwlBA-1; Thu, 09 Jan 2020 11:09:36 -0500
X-MC-Unique: UztTS9imPWWleT3bvJwlBA-1
Received: by mail-wr1-f72.google.com with SMTP id o6so3042297wrp.8
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 08:09:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NXlvrJt6z83MLX+WxwdFOCINB+GcX+Yj981D0b2qPGQ=;
        b=h7fRAMYetl7TZDHtPuqkVBE3todtoqaE0eyv4tZhkQS+Pvtp4t7qRnHTDz2HWhjoHb
         vjQKsW8KtjqASPzn8tQ60MqLGOnbnQaeYPXtO0tizJiqpr5/FOhLORslShiwDOvMukCV
         xi4AySVAzOghMOmIMaf29vC6rDBHc8jS90r6WyZfAZRkqt6pICNoJBQOpFs+TaPGFcTe
         ImH0iRIIN6mt+Bmq7egIesXLtJH7obzDnVZ8aHE9RZpdZ4pgQa9xdhfk6LmjzP70yW9y
         FnuGlelaDIjDYYjQ0mzaSCkbzUtwecWZBuduVmc6WoH3be74RdcTPlcXatX8hgPeRjxl
         2UaA==
X-Gm-Message-State: APjAAAUqBWJBPOlHi27+SWvMgeHpspG/sfA5AKEPP60dmZFn9vL4RReD
        b7oZuLi2S2Muv3NMBbX10vI6I2MJSXDPqGMdsiHjxnTm56d7th9Y8q6BT53jh/bLQC/MdVM64Ka
        HLF6b5Hm0Sr0JOnKiD++10OFZ
X-Received: by 2002:a7b:cbc9:: with SMTP id n9mr5807749wmi.89.1578586175319;
        Thu, 09 Jan 2020 08:09:35 -0800 (PST)
X-Google-Smtp-Source: APXvYqzmBZZfDXBq6RqR3Rkcb9sOH+t9Q3MfPwQWoV78KSevOPVEW0amjALm+VNPMHJy5/8IKwjOOA==
X-Received: by 2002:a7b:cbc9:: with SMTP id n9mr5807724wmi.89.1578586175172;
        Thu, 09 Jan 2020 08:09:35 -0800 (PST)
Received: from redfedo.redhat.com (host81-140-166-164.range81-140.btcentralplus.com. [81.140.166.164])
        by smtp.gmail.com with ESMTPSA id e8sm8517707wrt.7.2020.01.09.08.09.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 08:09:34 -0800 (PST)
From:   Julien Thierry <jthierry@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     jpoimboe@redhat.com, peterz@infradead.org, raphael.gault@arm.com,
        catalin.marinas@arm.com, will@kernel.org,
        Julien Thierry <jthierry@redhat.com>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        kvmarm@lists.cs.columbia.edu
Subject: [RFC v5 52/57] arm64: kernel: Annotate non-standard stack frame functions
Date:   Thu,  9 Jan 2020 16:02:55 +0000
Message-Id: <20200109160300.26150-53-jthierry@redhat.com>
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

Annotate assembler functions which are callable but do not
setup a correct stack frame.

Signed-off-by: Raphael Gault <raphael.gault@arm.com>
Signed-off-by: Julien Thierry <jthierry@redhat.com>
Cc: Marc Zyngier <maz@kernel.org>
Cc: James Morse <james.morse@arm.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: kvmarm@lists.cs.columbia.edu
---
 arch/arm64/kernel/hyp-stub.S | 3 +++
 arch/arm64/kvm/hyp-init.S    | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/arch/arm64/kernel/hyp-stub.S b/arch/arm64/kernel/hyp-stub.S
index 73d46070b315..8917d42f38c7 100644
--- a/arch/arm64/kernel/hyp-stub.S
+++ b/arch/arm64/kernel/hyp-stub.S
@@ -6,6 +6,7 @@
  * Author:	Marc Zyngier <marc.zyngier@arm.com>
  */

+#include <linux/frame.h>
 #include <linux/init.h>
 #include <linux/linkage.h>
 #include <linux/irqchip/arm-gic-v3.h>
@@ -42,6 +43,7 @@ ENTRY(__hyp_stub_vectors)
 	ventry	el1_fiq_invalid			// FIQ 32-bit EL1
 	ventry	el1_error_invalid		// Error 32-bit EL1
 ENDPROC(__hyp_stub_vectors)
+asm_stack_frame_non_standard __hyp_stub_vectors

 	.align 11

@@ -69,6 +71,7 @@ el1_sync:
 9:	mov	x0, xzr
 	eret
 ENDPROC(el1_sync)
+asm_stack_frame_non_standard el1_sync

 .macro invalid_vector	label
 \label:
diff --git a/arch/arm64/kvm/hyp-init.S b/arch/arm64/kvm/hyp-init.S
index 160be2b4696d..63deea39313d 100644
--- a/arch/arm64/kvm/hyp-init.S
+++ b/arch/arm64/kvm/hyp-init.S
@@ -12,6 +12,7 @@
 #include <asm/pgtable-hwdef.h>
 #include <asm/sysreg.h>
 #include <asm/virt.h>
+#include <linux/frame.h>

 	.text
 	.pushsection	.hyp.idmap.text, "ax"
@@ -118,6 +119,7 @@ CPU_BE(	orr	x4, x4, #SCTLR_ELx_EE)
 	/* Hello, World! */
 	eret
 ENDPROC(__kvm_hyp_init)
+asm_stack_frame_non_standard __kvm_hyp_init

 ENTRY(__kvm_handle_stub_hvc)
 	cmp	x0, #HVC_SOFT_RESTART
@@ -159,6 +161,7 @@ reset:
 	eret

 ENDPROC(__kvm_handle_stub_hvc)
+asm_stack_frame_non_standard __kvm_handle_stub_hvc

 	.ltorg

--
2.21.0

