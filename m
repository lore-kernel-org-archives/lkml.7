Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D83F1C282DD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 16:09:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEB3C20661
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 16:09:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qe09McnF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387401AbgAIQJC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 11:09:02 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:26125 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1733300AbgAIQJC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 11:09:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578586141;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kEfbHgsVU9eDoIkKPm/bUyQidxKwrK2z05bxXpj07hQ=;
        b=Qe09McnFhMy5DL6rGU1IruhX+EF8DypSZDafMSjzwam/+FMECMbprppyREzfYJnQzVcEZI
        ZHmheZbEBH3J9cq+BGfsSAfF2DAxznCQQKgWku/gxqTbMRUifoByy/f1B567m1TofxCWNx
        mPjoCj3IyvTA0ZuPQM0UP7EIz8ygx3g=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-392-jD3QavGYMq-dWS1hAy2coQ-1; Thu, 09 Jan 2020 11:09:00 -0500
X-MC-Unique: jD3QavGYMq-dWS1hAy2coQ-1
Received: by mail-wr1-f70.google.com with SMTP id f15so3079858wrr.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 08:08:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kEfbHgsVU9eDoIkKPm/bUyQidxKwrK2z05bxXpj07hQ=;
        b=Cxzcmaw5LfBMZ95Xsrye4Z7uQ1+wfubw3irpyVcD0noxzR7zW7j8fIP0J6ye/a7cv9
         kjAs4nl9QQ7/u2K4E0CY7hmeM/LMkHtl9b0CDDxZH20LVPr86JVXPgM/XwWIdxq4I/Z1
         8idlgNhrG7hpDjm8sJVlpRQL/oJIbZE0ErubRCVbX6F2G01SZxhsQQmLi2zg43ajxq9l
         hMQPXssrnKkxp4Ktc6EN9m7blwSaOkc0UfIvzYULXTgCwplaKv/lvaHzVi6VkY2d2oSF
         JDHXwiNSmyIDsuRfXEC7cjdrUyERv8BoV12o9G0Fn6vdFCHwYZtiiIUiEuvZOFkffxVb
         Z2cA==
X-Gm-Message-State: APjAAAXHh6sOhko+swX6KUohT0bDbjCD9qfT519JOBtVFI27rbe9Beq4
        ebneqeyhpYX95m2aFL57gefNrn+yMk+Cg7CseWIK1aFTj7qY0LfeG7JYPpFqaTo5qgSFr4R8nSD
        7PtPFXUyXUxu97iJTDFQQvu6Q
X-Received: by 2002:adf:e3d0:: with SMTP id k16mr12018284wrm.241.1578586138794;
        Thu, 09 Jan 2020 08:08:58 -0800 (PST)
X-Google-Smtp-Source: APXvYqzSLia58QbEuzIUwye/7K2S8R5lieQsiVKxVvK2wzbrjNJr4CLjCo4Rn4vyl1YI3pmhsGWMjA==
X-Received: by 2002:adf:e3d0:: with SMTP id k16mr12018264wrm.241.1578586138549;
        Thu, 09 Jan 2020 08:08:58 -0800 (PST)
Received: from redfedo.redhat.com (host81-140-166-164.range81-140.btcentralplus.com. [81.140.166.164])
        by smtp.gmail.com with ESMTPSA id v8sm8403505wrw.2.2020.01.09.08.08.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 08:08:58 -0800 (PST)
From:   Julien Thierry <jthierry@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     jpoimboe@redhat.com, peterz@infradead.org, raphael.gault@arm.com,
        catalin.marinas@arm.com, will@kernel.org,
        Julien Thierry <jthierry@redhat.com>
Subject: [RFC v5 48/57] arm64: sleep: Prevent stack frame warnings from objtool
Date:   Thu,  9 Jan 2020 16:02:51 +0000
Message-Id: <20200109160300.26150-49-jthierry@redhat.com>
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

This code doesn't respect the Arm PCS but it is intended this
way. Adapting it to respect the PCS would result in altering the
behaviour.

In order to suppress objtool's warnings, we setup a stack frame
for __cpu_suspend_enter and annotate cpu_resume and _cpu_resume
as having non-standard stack frames.

Signed-off-by: Raphael Gault <raphael.gault@arm.com>
Signed-off-by: Julien Thierry <jthierry@redhat.com>
---
 arch/arm64/kernel/sleep.S | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/kernel/sleep.S b/arch/arm64/kernel/sleep.S
index f5b04dd8a710..55c7c099d32c 100644
--- a/arch/arm64/kernel/sleep.S
+++ b/arch/arm64/kernel/sleep.S
@@ -1,5 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 #include <linux/errno.h>
+#include <linux/frame.h>
 #include <linux/linkage.h>
 #include <asm/asm-offsets.h>
 #include <asm/assembler.h>
@@ -90,6 +91,7 @@ ENTRY(__cpu_suspend_enter)
 	str	x0, [x1]
 	add	x0, x0, #SLEEP_STACK_DATA_SYSTEM_REGS
 	stp	x29, lr, [sp, #-16]!
+	mov	x29, sp
 	bl	cpu_do_suspend
 	ldp	x29, lr, [sp], #16
 	mov	x0, #1
@@ -146,3 +148,6 @@ ENTRY(_cpu_resume)
 	mov	x0, #0
 	ret
 ENDPROC(_cpu_resume)
+
+	asm_stack_frame_non_standard cpu_resume
+	asm_stack_frame_non_standard _cpu_resume
-- 
2.21.0

