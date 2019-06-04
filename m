Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF6B7C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 23:25:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9713A20883
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 23:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559690711;
	bh=DamIEb+50B+9TqbS5cCDTsv/5NkSNk/denlHXKinPfc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=z7Ng677MA5k07ktMIX5fcLxSR5p5qTOkPdGc8QYVhG588Zb5mDZIJ/ZlmXtUNbTUu
	 A8dpfB9luvidquAky2ByZ9N0OpmN6+/p7l4oqz50DCnIJCmjbKIM375Ls79O5qlUTL
	 sWXg1gwusmAIEhEC4RLevjU50gJYY1Qh7ltZfa+Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727887AbfFDXZL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 19:25:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:36336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726893AbfFDXY6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 19:24:58 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2893620B7C;
        Tue,  4 Jun 2019 23:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559690697;
        bh=DamIEb+50B+9TqbS5cCDTsv/5NkSNk/denlHXKinPfc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vyjncz82u/BrQ832p1VZ2/JuYgsOk3uUH6n5Vry7FaUBfVWrOqq74Tiqa1YRz5Z9h
         oy3OFaDJ8YyMcZ0zruQlK86y1T48ThGj4K9o2OP81WgyG0jm1n/ItNthLsKVDVHYaw
         yj3W0WZbLX35ppC6bRhsMvzoNVqL+dK5+O5K9Xqg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Christian Borntraeger <borntraeger@de.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sasha Levin <sashal@kernel.org>, linux-s390@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 24/24] KVM: s390: fix memory slot handling for KVM_SET_USER_MEMORY_REGION
Date:   Tue,  4 Jun 2019 19:24:15 -0400
Message-Id: <20190604232416.7479-24-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190604232416.7479-1-sashal@kernel.org>
References: <20190604232416.7479-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christian Borntraeger <borntraeger@de.ibm.com>

[ Upstream commit 19ec166c3f39fe1d3789888a74cc95544ac266d4 ]

kselftests exposed a problem in the s390 handling for memory slots.
Right now we only do proper memory slot handling for creation of new
memory slots. Neither MOVE, nor DELETION are handled properly. Let us
implement those.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/s390/kvm/kvm-s390.c | 35 +++++++++++++++++++++--------------
 1 file changed, 21 insertions(+), 14 deletions(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 4f6adbea592b..66b7b6383d8b 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -3912,21 +3912,28 @@ void kvm_arch_commit_memory_region(struct kvm *kvm,
 				const struct kvm_memory_slot *new,
 				enum kvm_mr_change change)
 {
-	int rc;
-
-	/* If the basics of the memslot do not change, we do not want
-	 * to update the gmap. Every update causes several unnecessary
-	 * segment translation exceptions. This is usually handled just
-	 * fine by the normal fault handler + gmap, but it will also
-	 * cause faults on the prefix page of running guest CPUs.
-	 */
-	if (old->userspace_addr == mem->userspace_addr &&
-	    old->base_gfn * PAGE_SIZE == mem->guest_phys_addr &&
-	    old->npages * PAGE_SIZE == mem->memory_size)
-		return;
+	int rc = 0;
 
-	rc = gmap_map_segment(kvm->arch.gmap, mem->userspace_addr,
-		mem->guest_phys_addr, mem->memory_size);
+	switch (change) {
+	case KVM_MR_DELETE:
+		rc = gmap_unmap_segment(kvm->arch.gmap, old->base_gfn * PAGE_SIZE,
+					old->npages * PAGE_SIZE);
+		break;
+	case KVM_MR_MOVE:
+		rc = gmap_unmap_segment(kvm->arch.gmap, old->base_gfn * PAGE_SIZE,
+					old->npages * PAGE_SIZE);
+		if (rc)
+			break;
+		/* FALLTHROUGH */
+	case KVM_MR_CREATE:
+		rc = gmap_map_segment(kvm->arch.gmap, mem->userspace_addr,
+				      mem->guest_phys_addr, mem->memory_size);
+		break;
+	case KVM_MR_FLAGS_ONLY:
+		break;
+	default:
+		WARN(1, "Unknown KVM MR CHANGE: %d\n", change);
+	}
 	if (rc)
 		pr_warn("failed to commit memory region\n");
 	return;
-- 
2.20.1

