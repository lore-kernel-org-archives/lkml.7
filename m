Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25124C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:24:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4A962054F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:24:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553257495;
	bh=s8cEIHr3N1afyrwafXUvAbNXQCjUbqMqcgN/Uf0P/eM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MF9/WQjN3H4fQzOyDw4waLJnVuAyqGWFTZY9nFBTfGBClxoXqhvuME90UHqPvnIkN
	 L12FuFwcYebd8+7u4chgmmytTZQsNbTPJM+GXz5rVnNLAJb4NY2Urucs8ZNi6VEpUT
	 0OR/VvzzlJTGO1f0ln8ZPonkb0kTtGIkwB1FW/7c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391120AbfCVMYx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:24:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:36728 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403819AbfCVMYo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:24:44 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B0CBC20685;
        Fri, 22 Mar 2019 12:24:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553257484;
        bh=s8cEIHr3N1afyrwafXUvAbNXQCjUbqMqcgN/Uf0P/eM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T2d0zudu3LNi32hZNl1skJYXrkX2mhmZ06nXOhPp5+2rI4TJloq3fVLhsTj30d6MM
         pFv5fchKhiRZj9unLipse0wQDdcDnOCLCyBazujEpj9SApcpXyVy6dkpGwzsLl+KiA
         sW2bNbRGst8qLPGiHGo2uQ5Xbys0iyULwy2oRY4M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 5.0 227/238] KVM: x86/mmu: Detect MMIO generation wrap in any address space
Date:   Fri, 22 Mar 2019 12:17:26 +0100
Message-Id: <20190322111311.748912636@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111258.383569278@linuxfoundation.org>
References: <20190322111258.383569278@linuxfoundation.org>
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

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sean Christopherson <sean.j.christopherson@intel.com>

commit e1359e2beb8b0a1188abc997273acbaedc8ee791 upstream.

The check to detect a wrap of the MMIO generation explicitly looks for a
generation number of zero.  Now that unique memslots generation numbers
are assigned to each address space, only address space 0 will get a
generation number of exactly zero when wrapping.  E.g. when address
space 1 goes from 0x7fffe to 0x80002, the MMIO generation number will
wrap to 0x2.  Adjust the MMIO generation to strip the address space
modifier prior to checking for a wrap.

Fixes: 4bd518f1598d ("KVM: use separate generations for each address space")
Cc: <stable@vger.kernel.org>
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kvm/mmu.c |   21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

--- a/arch/x86/kvm/mmu.c
+++ b/arch/x86/kvm/mmu.c
@@ -5893,11 +5893,28 @@ static bool kvm_has_zapped_obsolete_page
 
 void kvm_mmu_invalidate_mmio_sptes(struct kvm *kvm, u64 gen)
 {
+	gen &= MMIO_GEN_MASK;
+
+	/*
+	 * Shift to eliminate the "update in-progress" flag, which isn't
+	 * included in the spte's generation number.
+	 */
+	gen >>= 1;
+
+	/*
+	 * Generation numbers are incremented in multiples of the number of
+	 * address spaces in order to provide unique generations across all
+	 * address spaces.  Strip what is effectively the address space
+	 * modifier prior to checking for a wrap of the MMIO generation so
+	 * that a wrap in any address space is detected.
+	 */
+	gen &= ~((u64)KVM_ADDRESS_SPACE_NUM - 1);
+
 	/*
-	 * The very rare case: if the generation-number is round,
+	 * The very rare case: if the MMIO generation number has wrapped,
 	 * zap all shadow pages.
 	 */
-	if (unlikely((gen & MMIO_GEN_MASK) == 0)) {
+	if (unlikely(gen == 0)) {
 		kvm_debug_ratelimited("kvm: zapping shadow pages for mmio generation wraparound\n");
 		kvm_mmu_invalidate_zap_all_pages(kvm);
 	}


