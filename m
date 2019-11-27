Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E065C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 20:35:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67073215E5
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 20:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574886905;
	bh=JadU7RXG0vhQpSjpd6IvdvyjnC7SaQAKpVyfBtCPbz0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tPzh4Bswq9kwtUONJOcVZRt3v2kwsJMYxxPUE8J2zDp5NdZlYLqFyMdFWf7FZFnZl
	 CsQhloUTQAhUYepdz865cx626x5lLQERnqnXGa49tLdHts1Ywmy6vPArdU4FkQ8UhU
	 xTpgRT2YTs3jx2xED5nPSEIHsKNatelx0AX1BU1Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727788AbfK0UfE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 15:35:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:35576 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727749AbfK0Uez (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 15:34:55 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E8A9C215E5;
        Wed, 27 Nov 2019 20:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574886895;
        bh=JadU7RXG0vhQpSjpd6IvdvyjnC7SaQAKpVyfBtCPbz0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SQnj8xp0D7GBgJhd2JY81Y9EhJJtgYa6HA8UBnLKSkRHT2DxGLGoETWKWkBYvhgCT
         98KAoeVkVZ7R2qbGcZ2ul+ihb75iYFil3zvNeV//L11BAQSYzMuiCAedxE3eOcdXg/
         N+lyaJ0IfdoJ8nLEKCKB0F/EeWqQgtcNycrqMWN4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Uros Bizjak <ubizjak@gmail.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 035/132] KVM/x86: Fix invvpid and invept register operand size in 64-bit mode
Date:   Wed, 27 Nov 2019 21:30:26 +0100
Message-Id: <20191127202930.091213175@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191127202857.270233486@linuxfoundation.org>
References: <20191127202857.270233486@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
index 1b3a432f6fd53..9344ac6b4f99d 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -1298,7 +1298,7 @@ static int __find_msr_index(struct vcpu_vmx *vmx, u32 msr)
 	return -1;
 }
 
-static inline void __invvpid(int ext, u16 vpid, gva_t gva)
+static inline void __invvpid(unsigned long ext, u16 vpid, gva_t gva)
 {
     struct {
 	u64 vpid : 16;
@@ -1312,7 +1312,7 @@ static inline void __invvpid(int ext, u16 vpid, gva_t gva)
 		  : : "a"(&operand), "c"(ext) : "cc", "memory");
 }
 
-static inline void __invept(int ext, u64 eptp, gpa_t gpa)
+static inline void __invept(unsigned long ext, u64 eptp, gpa_t gpa)
 {
 	struct {
 		u64 eptp, gpa;
-- 
2.20.1



