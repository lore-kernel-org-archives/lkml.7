Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A483C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 13:35:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A54620833
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 13:35:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X9ZpCbCY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727513AbfDONfi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 09:35:38 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52692 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727129AbfDONfh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 09:35:37 -0400
Received: by mail-wm1-f65.google.com with SMTP id a184so20691203wma.2;
        Mon, 15 Apr 2019 06:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:subject:date:message-id;
        bh=TDHORHq8LhtoSP3rvKETc3qgG/j2Jq93Pleqnv3I2c8=;
        b=X9ZpCbCYF/jNAi3c/cKzUu2TFrJy2KmCu2rQsfCBEyTgg5w7DJJVlKTFaaeRwMsOB7
         lUedCniuQC8/HLTAB6DefGW8fsGKhBu/AKID466TSHUDfc/IA8LcsWAb0jYlXVfJBcB1
         V+ORMtExNFkh8ADnoCLebZKBP5biOtM5Y2uTriqSIszsATfrJs+bDZ2HrCMgCifeodCM
         75/9eArRjwJPr7B/Bilqr9ilHwZpGd89bHeVlAgcReR//7pJXShuP+aeYc40wQkn9l4O
         zLN4ZnEdPLcWz14jGhp2kP+NOQci79+EsWk2yB3424UV1ExakAgaO7XTiSXzL205OOP3
         KUGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:subject:date:message-id;
        bh=TDHORHq8LhtoSP3rvKETc3qgG/j2Jq93Pleqnv3I2c8=;
        b=r5w4UO+KpjiDtYdCwLZO5NqbTmX7qgHOu/Hyh8VrNyXrKM9OqZFz74s/dW28QWq2qA
         Mo3SOYJnCD51GC0P+FgO7Lfn+Z/uONBi/Gni9/DpQNx23XMRQQ+o/YdlMr/1MiQ1j31g
         kMHljj1/WTYKPNv10UHAa6dKsT4nNOvHykJOXDeabWvd4+keMvhoIRXVoVeWD/TXcqF9
         8rzxhvlxJE5NB+sWXodNYg3PgVutavkORWGQJpBvQKvliajeozcR8bUOspnIRItovB2U
         SoRI2a2QI+bVLYY7yHOuDT5JGK6NGZ3veZ6kO24tvjxHnc21qqUxWBZS752qeHpsa0Ml
         F8jg==
X-Gm-Message-State: APjAAAXvBTFgLBFuymTk0iCqKEoIyra/KpjXYsQImQ4ywud+dXCjE3q9
        p5mnq6LT8VOYDuomMN9oI9hoCeDn
X-Google-Smtp-Source: APXvYqwAjbGPinyMDuwZgh3VPapKF4iIr904WF0ATjoZdzCp3Qy4XEWGnKBylzolcU/KK5yRT1do6g==
X-Received: by 2002:a1c:1a4d:: with SMTP id a74mr22550148wma.50.1555335335323;
        Mon, 15 Apr 2019 06:35:35 -0700 (PDT)
Received: from 640k.lan ([93.56.166.5])
        by smtp.gmail.com with ESMTPSA id z20sm12965574wmf.34.2019.04.15.06.35.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Apr 2019 06:35:34 -0700 (PDT)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Subject: [PATCH] KVM: vmx: print more APICv fields in dump_vmcs
Date:   Mon, 15 Apr 2019 15:35:32 +0200
Message-Id: <1555335333-23636-1-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SVI, RVI, virtual-APIC page address and APIC-access page address fields
were left out of dump_vmcs.  Add them.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/vmx/vmx.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index ab432a930ae8..f8054dc1de65 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -5723,8 +5723,17 @@ static void dump_vmcs(void)
 	if (secondary_exec_control & SECONDARY_EXEC_TSC_SCALING)
 		pr_err("TSC Multiplier = 0x%016llx\n",
 		       vmcs_read64(TSC_MULTIPLIER));
-	if (cpu_based_exec_ctrl & CPU_BASED_TPR_SHADOW)
-		pr_err("TPR Threshold = 0x%02x\n", vmcs_read32(TPR_THRESHOLD));
+	if (cpu_based_exec_ctrl & CPU_BASED_TPR_SHADOW) {
+		if (secondary_exec_control & SECONDARY_EXEC_VIRTUAL_INTR_DELIVERY) {
+			u16 status = vmcs_read16(GUEST_INTR_STATUS);
+			pr_err("SVI|RVI = %02x|%02x ", status >> 8, status & 0xff);
+		}
+		pr_err(KERN_CONT "TPR Threshold = 0x%02x\n", vmcs_read32(TPR_THRESHOLD));
+		if (secondary_exec_control & (SECONDARY_EXEC_VIRTUALIZE_APIC_ACCESSES |
+		    			      SECONDARY_EXEC_VIRTUALIZE_X2APIC_MODE))
+			pr_err("APIC-access addr = 0x%016llx ", vmcs_read64(APIC_ACCESS_ADDR));
+		pr_err(KERN_CONT "virt-APIC addr=0x%016llx\n", vmcs_read64(VIRTUAL_APIC_PAGE_ADDR));
+	}
 	if (pin_based_exec_ctrl & PIN_BASED_POSTED_INTR)
 		pr_err("PostedIntrVec = 0x%02x\n", vmcs_read16(POSTED_INTR_NV));
 	if ((secondary_exec_control & SECONDARY_EXEC_ENABLE_EPT))
-- 
1.8.3.1

