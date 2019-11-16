Return-Path: <SRS0=try7=ZI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E5E9C432C3
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 15:59:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E3D720815
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 15:59:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573919957;
	bh=XfgCfnrwVlI0xhEffsc94hS7kRvulEZZSEhyKm4+mSc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gkASq1DjsHKi9vGXxx2oeXJorYhDjzzwG8fWT0DSXcoeKBI1dhDBEn5bAA/9Up9Bs
	 m741wZF+0rRwTmpHPDFpKKxcv3JSU8rgK8Vd4/pFoi1KzooK6vU2XxLJ6xUjr2WFfQ
	 kfdNc+Fen4Z/p6nkAPlQIckg7UjCeWPs6DlshRQc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731364AbfKPPx7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Nov 2019 10:53:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:35262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731344AbfKPPx4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Nov 2019 10:53:56 -0500
Received: from sasha-vm.mshome.net (unknown [50.234.116.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 312E621887;
        Sat, 16 Nov 2019 15:53:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573919635;
        bh=XfgCfnrwVlI0xhEffsc94hS7kRvulEZZSEhyKm4+mSc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CnMVJewYEYu+Y09R/Xse3P/Vyr7qB+p9rXmhLx/v5BXF2zL9ceus3TdxZEM+4yg1v
         qikRulBDn9fV32nDZnBI/7MmEbqed+paOFggSr6fEscn4dPXKnvxBcG0R+BnPZZ2Nw
         QUq/M8MyJjR99RgvchXtA5kgb7tTKWiRvFsaPuFE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Uros Bizjak <ubizjak@gmail.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sasha Levin <sashal@kernel.org>, kvm@vger.kernel.org
Subject: [PATCH AUTOSEL 4.4 15/77] KVM/x86: Fix invvpid and invept register operand size in 64-bit mode
Date:   Sat, 16 Nov 2019 10:52:37 -0500
Message-Id: <20191116155339.11909-15-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191116155339.11909-1-sashal@kernel.org>
References: <20191116155339.11909-1-sashal@kernel.org>
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
index f8f9d1b368bf8..a3aa07b2f61e1 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -1299,7 +1299,7 @@ static int __find_msr_index(struct vcpu_vmx *vmx, u32 msr)
 	return -1;
 }
 
-static inline void __invvpid(int ext, u16 vpid, gva_t gva)
+static inline void __invvpid(unsigned long ext, u16 vpid, gva_t gva)
 {
     struct {
 	u64 vpid : 16;
@@ -1313,7 +1313,7 @@ static inline void __invvpid(int ext, u16 vpid, gva_t gva)
 		  : : "a"(&operand), "c"(ext) : "cc", "memory");
 }
 
-static inline void __invept(int ext, u64 eptp, gpa_t gpa)
+static inline void __invept(unsigned long ext, u64 eptp, gpa_t gpa)
 {
 	struct {
 		u64 eptp, gpa;
-- 
2.20.1

