Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9EF7C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 10:17:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 925602089F
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 10:17:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561371449;
	bh=joX4oBxgWRfbTYhg0szXbGlMdRkBFd2o4j+rCTRn/x0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dM/LOr1KWiPB8MajDnWqL51LibHal22UKVwXj2y3K1B0vDn0C51mvxM740rFXgax0
	 Y9hExbEuwVQ1LY6I9QrHnXgqtsWLdqp4gUdHzSpitJ/iZH+De0rLrVqPk71PSUgBIT
	 r2p4sSmfJn7/976tS2eS8TSaIexRE/HnYmVL4EgE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730979AbfFXKR2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 06:17:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:55058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730957AbfFXKRY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 06:17:24 -0400
Received: from localhost (f4.8f.5177.ip4.static.sl-reverse.com [119.81.143.244])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4BAA1205C9;
        Mon, 24 Jun 2019 10:17:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561371443;
        bh=joX4oBxgWRfbTYhg0szXbGlMdRkBFd2o4j+rCTRn/x0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xawQ68yENsmVl3rZNFD96qhvJV6X9rsrDEQFxn2ZaNKullWoQC/635w7HMAm6rSzX
         TyCkaJr2uKC7piN0MttcMXEIeJbNgtn6DXg+c6Q2ZcEsDm9ayr7KkhLlssNV8X+Fy4
         2kkQC1Op3dyBfCSfggmHn5J4Nkm3OOeSQL386eTc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jiri Palecek <jpalecek@web.de>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 5.1 104/121] KVM: x86/mmu: Allocate PAE root array when using SVMs 32-bit NPT
Date:   Mon, 24 Jun 2019 17:57:16 +0800
Message-Id: <20190624092326.022031366@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190624092320.652599624@linuxfoundation.org>
References: <20190624092320.652599624@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Christopherson <sean.j.christopherson@intel.com>

commit b6b80c78af838bef17501416d5d383fedab0010a upstream.

SVM's Nested Page Tables (NPT) reuses x86 paging for the host-controlled
page walk.  For 32-bit KVM, this means PAE paging is used even when TDP
is enabled, i.e. the PAE root array needs to be allocated.

Fixes: ee6268ba3a68 ("KVM: x86: Skip pae_root shadow allocation if tdp enabled")
Cc: stable@vger.kernel.org
Reported-by: Jiri Palecek <jpalecek@web.de>
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kvm/mmu.c |   16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

--- a/arch/x86/kvm/mmu.c
+++ b/arch/x86/kvm/mmu.c
@@ -5591,14 +5591,18 @@ static int alloc_mmu_pages(struct kvm_vc
 	struct page *page;
 	int i;
 
-	if (tdp_enabled)
-		return 0;
-
 	/*
-	 * When emulating 32-bit mode, cr3 is only 32 bits even on x86_64.
-	 * Therefore we need to allocate shadow page tables in the first
-	 * 4GB of memory, which happens to fit the DMA32 zone.
+	 * When using PAE paging, the four PDPTEs are treated as 'root' pages,
+	 * while the PDP table is a per-vCPU construct that's allocated at MMU
+	 * creation.  When emulating 32-bit mode, cr3 is only 32 bits even on
+	 * x86_64.  Therefore we need to allocate the PDP table in the first
+	 * 4GB of memory, which happens to fit the DMA32 zone.  Except for
+	 * SVM's 32-bit NPT support, TDP paging doesn't use PAE paging and can
+	 * skip allocating the PDP table.
 	 */
+	if (tdp_enabled && kvm_x86_ops->get_tdp_level(vcpu) > PT32E_ROOT_LEVEL)
+		return 0;
+
 	page = alloc_page(GFP_KERNEL_ACCOUNT | __GFP_DMA32);
 	if (!page)
 		return -ENOMEM;


