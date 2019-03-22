Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB7F6C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:08:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA24E206C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:08:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553256519;
	bh=UZo46b/UMOICWI20aXGhQSjwTvzGIvt0bfcSyMv7K4s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=W4rrD7akvWNFYFXOGOp3fCRRS4vYmRQ8+7W9bmpLngh2O/nSs3tD7tmHcgXgsJhZr
	 nrAaYHBRcrT2iRjWQfyY1OAB/4RArpOGeu6keIszn82myUsBtLxDZmFjQAObTWJSEG
	 Agb6zF2kAKfsFAb35Hu+TQiB30ApTDFZh7pSj2qA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389189AbfCVMIi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:08:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:46990 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388943AbfCVMIg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:08:36 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 955352082C;
        Fri, 22 Mar 2019 12:08:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553256516;
        bh=UZo46b/UMOICWI20aXGhQSjwTvzGIvt0bfcSyMv7K4s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TaQeEV2SJb08qBYE04Q8/MtGjrpzc5hG/uxEkEQb15MLo03g7XNnPzU4ABqaBcj0w
         HraorzlIC6rDdan7hFlwbYSbmjd9FAnwLir8lQKTM5DeLjFFNl+j03tdYFYSnSvKl7
         GbnyxV3KsrrX+99yZZnEefQQv16SxyMKdgZ7nwsw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Christoffer Dall <christoffer.dall@arm.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>
Subject: [PATCH 4.19 234/280] arm64: KVM: Fix architecturally invalid reset value for FPEXC32_EL2
Date:   Fri, 22 Mar 2019 12:16:27 +0100
Message-Id: <20190322111337.884528764@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111306.356185024@linuxfoundation.org>
References: <20190322111306.356185024@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dave Martin <Dave.Martin@arm.com>

commit c88b093693ccbe41991ef2e9b1d251945e6e54ed upstream.

Due to what looks like a typo dating back to the original addition
of FPEXC32_EL2 handling, KVM currently initialises this register to
an architecturally invalid value.

As a result, the VECITR field (RES1) in bits [10:8] is initialised
with 0, and the two reserved (RES0) bits [6:5] are initialised with
1.  (In the Common VFP Subarchitecture as specified by ARMv7-A,
these two bits were IMP DEF.  ARMv8-A removes them.)

This patch changes the reset value from 0x70 to 0x700, which
reflects the architectural constraints and is presumably what was
originally intended.

Cc: <stable@vger.kernel.org> # 4.12.x-
Cc: Christoffer Dall <christoffer.dall@arm.com>
Fixes: 62a89c44954f ("arm64: KVM: 32bit handling of coprocessor traps")
Signed-off-by: Dave Martin <Dave.Martin@arm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm64/kvm/sys_regs.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -1456,7 +1456,7 @@ static const struct sys_reg_desc sys_reg
 
 	{ SYS_DESC(SYS_DACR32_EL2), NULL, reset_unknown, DACR32_EL2 },
 	{ SYS_DESC(SYS_IFSR32_EL2), NULL, reset_unknown, IFSR32_EL2 },
-	{ SYS_DESC(SYS_FPEXC32_EL2), NULL, reset_val, FPEXC32_EL2, 0x70 },
+	{ SYS_DESC(SYS_FPEXC32_EL2), NULL, reset_val, FPEXC32_EL2, 0x700 },
 };
 
 static bool trap_dbgidr(struct kvm_vcpu *vcpu,


