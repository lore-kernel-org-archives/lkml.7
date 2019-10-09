Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D272BECE58C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 17:28:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F30C206BB
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 17:28:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570642108;
	bh=HAqjkv96qKv96CwQ5QSUQj+MIDryYPeFAPctadqPLWE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NFjgGR0kNQHDxRMMcolleE3AA6/PiQz8vMJTLPtMYrpOYS+ifK04V59vw9fc7Iz8l
	 0MtesnzvF1lY5Y+GOQ4qsP5wIIjvKbvZiG1PZoSWSFmGwgX3Q0oJRzGZ61CT9Epmf7
	 nLtAV0KtiFY4hUfILRHeNj/zo+xspKsBpQQXO7CE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732290AbfJIRYY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 13:24:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:48626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732123AbfJIRYH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 13:24:07 -0400
Received: from sasha-vm.mshome.net (unknown [167.220.2.234])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5138121D56;
        Wed,  9 Oct 2019 17:24:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570641846;
        bh=HAqjkv96qKv96CwQ5QSUQj+MIDryYPeFAPctadqPLWE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bOxDhkKVnj3odCphIalpV3WZkRRMqBTYo9k1d7WW1zMLBlNKvrm2h0WRdothKD550
         oNXZg1AXyI/QNL/ICXK7m0HjgyFp1gZLsViCpskzqWGHPrpIPLshDw0yDE/lVy9hYh
         OmYzCNJ7P9VEy6y+SL5oafeYz1t7K1Z/lMxgf1OE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jim Mattson <jmattson@google.com>, Marc Orr <marcorr@google.com>,
        Peter Shier <pshier@google.com>,
        Jacob Xu <jacobhxu@google.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sasha Levin <sashal@kernel.org>, kvm@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 09/26] kvm: x86: Use AMD CPUID semantics for AMD vCPUs
Date:   Wed,  9 Oct 2019 13:05:41 -0400
Message-Id: <20191009170558.32517-9-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191009170558.32517-1-sashal@kernel.org>
References: <20191009170558.32517-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jim Mattson <jmattson@google.com>

[ Upstream commit 5f41a37b151f6459e0b650a2f4d1d59b6c02d1ab ]

When the guest CPUID information represents an AMD vCPU, return all
zeroes for queries of undefined CPUID leaves, whether or not they are
in range.

Signed-off-by: Jim Mattson <jmattson@google.com>
Fixes: bd22f5cfcfe8f6 ("KVM: move and fix substitue search for missing CPUID entries")
Reviewed-by: Marc Orr <marcorr@google.com>
Reviewed-by: Peter Shier <pshier@google.com>
Reviewed-by: Jacob Xu <jacobhxu@google.com>
Cc: Sean Christopherson <sean.j.christopherson@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kvm/cpuid.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index ada2cae6bec51..0854a2a32a61a 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -916,9 +916,11 @@ bool kvm_cpuid(struct kvm_vcpu *vcpu, u32 *eax, u32 *ebx,
 	/*
 	 * Intel CPUID semantics treats any query for an out-of-range
 	 * leaf as if the highest basic leaf (i.e. CPUID.0H:EAX) were
-	 * requested.
+	 * requested. AMD CPUID semantics returns all zeroes for any
+	 * undefined leaf, whether or not the leaf is in range.
 	 */
-	if (!entry && check_limit && !cpuid_function_in_range(vcpu, function)) {
+	if (!entry && check_limit && !guest_cpuid_is_amd(vcpu) &&
+	    !cpuid_function_in_range(vcpu, function)) {
 		max = kvm_find_cpuid_entry(vcpu, 0, 0);
 		if (max) {
 			function = max->eax;
-- 
2.20.1

