Return-Path: <SRS0=try7=ZI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C716C432C3
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 16:04:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A6652089D
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 16:04:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573920293;
	bh=wUt4D1DEg1f6rjOKaBENefHuGSbzJpjSw8JuUHmPraw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gw7POtHkcpOzEF0N49KAteapHXXw90/N1FONRZ+ubjr3eBk088kyEq2d6E+V8TfmC
	 PM7pNeGoUyBoMY+w4C9192VQ0JsbmfywgDLdvr4UmPlVSqTyBIfb8QSP8xD624zgxk
	 wfu+I0qG9buXip12n8C7hVeeiJui89YQM6LZefaI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730784AbfKPPvd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Nov 2019 10:51:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:60058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729874AbfKPPv0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Nov 2019 10:51:26 -0500
Received: from sasha-vm.mshome.net (unknown [50.234.116.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BAEF4214E0;
        Sat, 16 Nov 2019 15:51:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573919486;
        bh=wUt4D1DEg1f6rjOKaBENefHuGSbzJpjSw8JuUHmPraw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VabG4pgXcXmPcyVrvueFo2zYAUz6BSTUsywyAEhnZKB7TndJg65/iE1zQZ0zwdz4Y
         Vg3MEQ1Vcu6rJNlU4ZACAhqIRLpsRpLHWwamYQC2Nn4qcbc29jL4wWwvEOEPCA4hJy
         JzS7jH5HijzyVBMttkWBSI5+4CZcXHzT0V25gIps=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Uros Bizjak <ubizjak@gmail.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sasha Levin <sashal@kernel.org>, kvm@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 17/99] KVM/x86: Fix invvpid and invept register operand size in 64-bit mode
Date:   Sat, 16 Nov 2019 10:49:40 -0500
Message-Id: <20191116155103.10971-17-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191116155103.10971-1-sashal@kernel.org>
References: <20191116155103.10971-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Uros Bizjak <ubizjak@gmail.com>

[ Upstream commit 5ebb272b2ea7e02911a03a893f8d922d49f9bb4a ]

Register operand size of invvpid and invept instruction in 64-bit mode
has always 64 bits. Adjust inline function argument type to reflect
correct size.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kvm/vmx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index 6b66d1f0d1859..b33d6f27399c8 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -1547,7 +1547,7 @@ static int __find_msr_index(struct vcpu_vmx *vmx, u32 msr)
 	return -1;
 }
 
-static inline void __invvpid(int ext, u16 vpid, gva_t gva)
+static inline void __invvpid(unsigned long ext, u16 vpid, gva_t gva)
 {
     struct {
 	u64 vpid : 16;
@@ -1561,7 +1561,7 @@ static inline void __invvpid(int ext, u16 vpid, gva_t gva)
 		  : : "a"(&operand), "c"(ext) : "cc", "memory");
 }
 
-static inline void __invept(int ext, u64 eptp, gpa_t gpa)
+static inline void __invept(unsigned long ext, u64 eptp, gpa_t gpa)
 {
 	struct {
 		u64 eptp, gpa;
-- 
2.20.1

