Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02499C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 06:22:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF52520801
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 06:22:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573798949;
	bh=q1GF1yG6zWlTOILmKVCGAMY9CFw+S/DW18hdKZTr1yM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LFGB5mO5Hc2EEGM9hsF7U/tJSFXP9/NxVe6Udj+8FFi2Bk9SJy1eEYKPsFog2szkI
	 utuarxLHO8xxq58JYzD2iRE5cmWLCMdN7B04E3b2vthJNa1lxtj6JETfv6Uu22uKSq
	 jKQBgAW/VZbIeaZ92SLGGttV5CvYGfnEShGXZYsY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727732AbfKOGW3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 01:22:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:51734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727685AbfKOGWX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 01:22:23 -0500
Received: from localhost (unknown [104.132.150.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9DDD62081E;
        Fri, 15 Nov 2019 06:22:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573798943;
        bh=q1GF1yG6zWlTOILmKVCGAMY9CFw+S/DW18hdKZTr1yM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P5yP8UhLVDj/7VQLlEgGvcSB9+k7gNN9+iSckviiDlU1kaa8VT7ZptfwMjUVWHVVO
         2GlSfUbAkpOh9SqXpdOAamfZWSBTWL1HU0JU7qR4oavcELZWPgFaNEvhFK/EVHWqvG
         Zcl9PaxB7evCUE+Z9W+M+rl5szFNcVnjqnX/GP60=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Ben Hutchings <ben@decadent.org.uk>
Subject: [PATCH 4.9 21/31] KVM: x86: remove now unneeded hugepage gfn adjustment
Date:   Fri, 15 Nov 2019 14:20:50 +0800
Message-Id: <20191115062017.892821068@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191115062009.813108457@linuxfoundation.org>
References: <20191115062009.813108457@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo Bonzini <pbonzini@redhat.com>

commit d679b32611c0102ce33b9e1a4e4b94854ed1812a upstream.

After the previous patch, the low bits of the gfn are masked in
both FNAME(fetch) and __direct_map, so we do not need to clear them
in transparent_hugepage_adjust.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kvm/mmu.c         |    9 +++------
 arch/x86/kvm/paging_tmpl.h |    2 +-
 2 files changed, 4 insertions(+), 7 deletions(-)

--- a/arch/x86/kvm/mmu.c
+++ b/arch/x86/kvm/mmu.c
@@ -2824,11 +2824,10 @@ static int kvm_handle_bad_page(struct kv
 }
 
 static void transparent_hugepage_adjust(struct kvm_vcpu *vcpu,
-					gfn_t *gfnp, kvm_pfn_t *pfnp,
+					gfn_t gfn, kvm_pfn_t *pfnp,
 					int *levelp)
 {
 	kvm_pfn_t pfn = *pfnp;
-	gfn_t gfn = *gfnp;
 	int level = *levelp;
 
 	/*
@@ -2855,8 +2854,6 @@ static void transparent_hugepage_adjust(
 		mask = KVM_PAGES_PER_HPAGE(level) - 1;
 		VM_BUG_ON((gfn & mask) != (pfn & mask));
 		if (pfn & mask) {
-			gfn &= ~mask;
-			*gfnp = gfn;
 			kvm_release_pfn_clean(pfn);
 			pfn &= ~mask;
 			kvm_get_pfn(pfn);
@@ -3060,7 +3057,7 @@ static int nonpaging_map(struct kvm_vcpu
 		goto out_unlock;
 	make_mmu_pages_available(vcpu);
 	if (likely(!force_pt_level))
-		transparent_hugepage_adjust(vcpu, &gfn, &pfn, &level);
+		transparent_hugepage_adjust(vcpu, gfn, &pfn, &level);
 	r = __direct_map(vcpu, v, write, map_writable, level, pfn, prefault);
 out_unlock:
 	spin_unlock(&vcpu->kvm->mmu_lock);
@@ -3595,7 +3592,7 @@ static int tdp_page_fault(struct kvm_vcp
 		goto out_unlock;
 	make_mmu_pages_available(vcpu);
 	if (likely(!force_pt_level))
-		transparent_hugepage_adjust(vcpu, &gfn, &pfn, &level);
+		transparent_hugepage_adjust(vcpu, gfn, &pfn, &level);
 	r = __direct_map(vcpu, gpa, write, map_writable, level, pfn, prefault);
 out_unlock:
 	spin_unlock(&vcpu->kvm->mmu_lock);
--- a/arch/x86/kvm/paging_tmpl.h
+++ b/arch/x86/kvm/paging_tmpl.h
@@ -806,7 +806,7 @@ static int FNAME(page_fault)(struct kvm_
 	kvm_mmu_audit(vcpu, AUDIT_PRE_PAGE_FAULT);
 	make_mmu_pages_available(vcpu);
 	if (!force_pt_level)
-		transparent_hugepage_adjust(vcpu, &walker.gfn, &pfn, &level);
+		transparent_hugepage_adjust(vcpu, walker.gfn, &pfn, &level);
 	r = FNAME(fetch)(vcpu, addr, &walker, write_fault,
 			 level, pfn, map_writable, prefault);
 	kvm_mmu_audit(vcpu, AUDIT_POST_PAGE_FAULT);


