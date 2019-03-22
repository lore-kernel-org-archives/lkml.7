Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA0F1C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:10:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76B7F2083D
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553256657;
	bh=5fYPGOiRMcYQrOHBEBRIyt6RcpGfAnwbJrDhUeNk6kI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jUhtk5KTyxwG8g4LzKCEwHCmSEuyGb2OvkmDYdtcraZjXSzVm0IravsxZnI8W1gIe
	 0B6eV6xb1VXviTr0rDu1gn17YsFf6UtcEh7jBMm8g9pwIWN/CLyUQn/H8ERtBOH6fr
	 wLw2akrm3AMcS3Wb5PpQyC5qSya1j06TLCfu78sw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389472AbfCVMKz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:10:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:49292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389111AbfCVMKx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:10:53 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 410902082C;
        Fri, 22 Mar 2019 12:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553256652;
        bh=5fYPGOiRMcYQrOHBEBRIyt6RcpGfAnwbJrDhUeNk6kI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=v5woDywS42FgGbYc7jb5f7yDLb+bEx4T3O/b+enyJwmVI3qeBad9wMyBasnqraPl4
         BIy47FKB3eCgFAkfLF/Ypeyn8pzYVU0gXtzKGaIjUGI7nWhmlqeIzsOwXSgnEghoF+
         wdeHchwzxjpTdsp2BjAHu32ffMh+n/ysbETatPuY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 4.19 278/280] KVM: nVMX: Ignore limit checks on VMX instructions using flat segments
Date:   Fri, 22 Mar 2019 12:17:11 +0100
Message-Id: <20190322111347.752867653@linuxfoundation.org>
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

From: Sean Christopherson <sean.j.christopherson@intel.com>

commit 34333cc6c2cb021662fd32e24e618d1b86de95bf upstream.

Regarding segments with a limit==0xffffffff, the SDM officially states:

    When the effective limit is FFFFFFFFH (4 GBytes), these accesses may
    or may not cause the indicated exceptions.  Behavior is
    implementation-specific and may vary from one execution to another.

In practice, all CPUs that support VMX ignore limit checks for "flat
segments", i.e. an expand-up data or code segment with base=0 and
limit=0xffffffff.  This is subtly different than wrapping the effective
address calculation based on the address size, as the flat segment
behavior also applies to accesses that would wrap the 4g boundary, e.g.
a 4-byte access starting at 0xffffffff will access linear addresses
0xffffffff, 0x0, 0x1 and 0x2.

Fixes: f9eb4af67c9d ("KVM: nVMX: VMX instructions: add checks for #GP/#SS exceptions")
Cc: stable@vger.kernel.org
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kvm/vmx.c |   12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -8251,10 +8251,16 @@ static int get_vmx_mem_address(struct kv
 		/* Protected mode: #GP(0)/#SS(0) if the segment is unusable.
 		 */
 		exn = (s.unusable != 0);
-		/* Protected mode: #GP(0)/#SS(0) if the memory
-		 * operand is outside the segment limit.
+
+		/*
+		 * Protected mode: #GP(0)/#SS(0) if the memory operand is
+		 * outside the segment limit.  All CPUs that support VMX ignore
+		 * limit checks for flat segments, i.e. segments with base==0,
+		 * limit==0xffffffff and of type expand-up data or code.
 		 */
-		exn = exn || (off + sizeof(u64) > s.limit);
+		if (!(s.base == 0 && s.limit == 0xffffffff &&
+		     ((s.type & 8) || !(s.type & 4))))
+			exn = exn || (off + sizeof(u64) > s.limit);
 	}
 	if (exn) {
 		kvm_queue_exception_e(vcpu,


