Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AC87ECE58C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 17:29:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F02F220679
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 17:29:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570642146;
	bh=NNl2VEcS5iXIkcI2f5gpfTalyoIENeQKXES09/ID1C8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tHmMPXOvtumK00+GWOChUsNYM6Sx8NT444mMFKRx/gczOPEomUp3aMJ0uUYWBpqb5
	 GT27ETuIrwMhqWz4N3o8dtqpc+fgS19lOW+IUQTOyQx4IJ3BKb6HslRd9006vcqpJW
	 1f2QLE0wQQnn/+Uf/5sPlDmtmPA0ddvkq/nG0jug=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732237AbfJIRYS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 13:24:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:48034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731995AbfJIRYB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 13:24:01 -0400
Received: from sasha-vm.mshome.net (unknown [167.220.2.234])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 45E8321D7C;
        Wed,  9 Oct 2019 17:24:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570641841;
        bh=NNl2VEcS5iXIkcI2f5gpfTalyoIENeQKXES09/ID1C8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jH/BU0hBjW7mRS/bT+t2ndJ1fZw31uybVEqAgUW74xQV5yCmCWQlIPQjs7B7ATO3X
         kmMH5SKlVTxINbktVu9aVEqkcSSXfuL+qBQd3P/jhdLIPZV/jUx6qI/qy3sW9Rz8eJ
         ra21LFfN1KOb1lSRqYXCpfiUcKeIzwJ3+sD2A61I=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sasha Levin <sashal@kernel.org>, kvm@vger.kernel.org
Subject: [PATCH AUTOSEL 5.3 28/68] KVM: x86: Expose XSAVEERPTR to the guest
Date:   Wed,  9 Oct 2019 13:05:07 -0400
Message-Id: <20191009170547.32204-28-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191009170547.32204-1-sashal@kernel.org>
References: <20191009170547.32204-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

[ Upstream commit 504ce1954fba888936c9d13ccc1e3db9b8f613d5 ]

I was surprised to see that the guest reported `fxsave_leak' while the
host did not. After digging deeper I noticed that the bits are simply
masked out during enumeration.

The XSAVEERPTR feature is actually a bug fix on AMD which means the
kernel can disable a workaround.

Pass XSAVEERPTR to the guest if available on the host.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kvm/cpuid.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index fd1b8db8bf242..59b66e343fa5a 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -479,6 +479,7 @@ static inline int __do_cpuid_func(struct kvm_cpuid_entry2 *entry, u32 function,
 
 	/* cpuid 0x80000008.ebx */
 	const u32 kvm_cpuid_8000_0008_ebx_x86_features =
+		F(XSAVEERPTR) |
 		F(WBNOINVD) | F(AMD_IBPB) | F(AMD_IBRS) | F(AMD_SSBD) | F(VIRT_SSBD) |
 		F(AMD_SSB_NO) | F(AMD_STIBP) | F(AMD_STIBP_ALWAYS_ON);
 
-- 
2.20.1

