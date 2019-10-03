Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C5F9C32792
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 15:59:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09935207FF
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 15:59:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570118368;
	bh=l/ugDr4sRjwKVRrLRMbudXpwi4PwmzZqQrPyWw0kkBs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=J+WYHiiOGFQhEuXlchGL0DTOsQHULp7xZs8fOW2d27Fh9MD7Y+hRkQ9gwT62bIGaG
	 65/WfUXPU5U36mYwDpa0Amua8KkPQlaWHVqoXkCiZAUthz7ECVU/04QeqvIe0jJ4IO
	 D1RYwPTwgGRUs5+XIr860BD6d7tsKOHdoTVbUUWA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731335AbfJCP71 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 11:59:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:42362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731170AbfJCP7W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 11:59:22 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 38AEC207FF;
        Thu,  3 Oct 2019 15:59:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570118361;
        bh=l/ugDr4sRjwKVRrLRMbudXpwi4PwmzZqQrPyWw0kkBs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bj6bdRzFEKlbtfAGXI05g5s3fUXC4M5qiPvidSo2em3zqmck+7Q3BsDL70cWiMnwL
         x78n2TnKm8nAIFHwSUQpplZKJi7aT74Pojj/wuvEH6diEFsMR39wK8Yd30ACH2GV0s
         XFAuA1uzx0Sgl2Q00xJDEIibh0pJSKHtTIz9x/Is=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Denis Lunev <den@virtuozzo.com>,
        Roman Kagan <rkagan@virtuozzo.com>,
        Denis Plotnikov <dplotnikov@virtuozzo.com>,
        Jan Dakinevich <jan.dakinevich@virtuozzo.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 4.4 81/99] KVM: x86: always stop emulation on page fault
Date:   Thu,  3 Oct 2019 17:53:44 +0200
Message-Id: <20191003154335.856804026@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191003154252.297991283@linuxfoundation.org>
References: <20191003154252.297991283@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jan Dakinevich <jan.dakinevich@virtuozzo.com>

commit 8530a79c5a9f4e29e6ffb35ec1a79d81f4968ec8 upstream.

inject_emulated_exception() returns true if and only if nested page
fault happens. However, page fault can come from guest page tables
walk, either nested or not nested. In both cases we should stop an
attempt to read under RIP and give guest to step over its own page
fault handler.

This is also visible when an emulated instruction causes a #GP fault
and the VMware backdoor is enabled.  To handle the VMware backdoor,
KVM intercepts #GP faults; with only the next patch applied,
x86_emulate_instruction() injects a #GP but returns EMULATE_FAIL
instead of EMULATE_DONE.   EMULATE_FAIL causes handle_exception_nmi()
(or gp_interception() for SVM) to re-inject the original #GP because it
thinks emulation failed due to a non-VMware opcode.  This patch prevents
the issue as x86_emulate_instruction() will return EMULATE_DONE after
injecting the #GP.

Fixes: 6ea6e84309ca ("KVM: x86: inject exceptions produced by x86_decode_insn")
Cc: stable@vger.kernel.org
Cc: Denis Lunev <den@virtuozzo.com>
Cc: Roman Kagan <rkagan@virtuozzo.com>
Cc: Denis Plotnikov <dplotnikov@virtuozzo.com>
Signed-off-by: Jan Dakinevich <jan.dakinevich@virtuozzo.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kvm/x86.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -5486,8 +5486,10 @@ int x86_emulate_instruction(struct kvm_v
 			if (reexecute_instruction(vcpu, cr2, write_fault_to_spt,
 						emulation_type))
 				return EMULATE_DONE;
-			if (ctxt->have_exception && inject_emulated_exception(vcpu))
+			if (ctxt->have_exception) {
+				inject_emulated_exception(vcpu);
 				return EMULATE_DONE;
+			}
 			if (emulation_type & EMULTYPE_SKIP)
 				return EMULATE_FAIL;
 			return handle_emulation_failure(vcpu);


