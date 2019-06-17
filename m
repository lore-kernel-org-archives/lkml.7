Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF4A3C31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 21:23:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC54620657
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 21:23:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560806605;
	bh=m9Q9Vlgl+kNwOg3Xk7nW9kRT4PszanSRflTUJekU/bQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0CM0xh9lwwezpaSRyvDsnEpEnMKQiv4dgp08Wda0ozbK2DF9a3daSnPg3dF4U9FDX
	 ntMGG4GGNZyK6TrcUMVSHW204o7KsgDdiZhXm0f6tecEPCeGEmeKW8t+yOTlJe9ugo
	 Ul1a2iiAWsdgcxe1wCDf36lWtu4aFYdDkDc1Zu/c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729317AbfFQVXY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 17:23:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:48416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729308AbfFQVXU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 17:23:20 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 98627208E4;
        Mon, 17 Jun 2019 21:23:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560806600;
        bh=m9Q9Vlgl+kNwOg3Xk7nW9kRT4PszanSRflTUJekU/bQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R4hBs+D0sBP9PhaSQjFD/11tabiOfHHx1XRIdHxk+3PhwxShadyCriuY1b/hAydRf
         py82SMYVb7BahHbX67Hgduz5VjXJuiZiCC9BjRfq6k5ljTBVU0qwOJogq9LQajOnH8
         G/Qb7yY6LtoB5Sr9wZg1+zyCw6rTgtLM1+dhnaJo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.1 091/115] KVM: s390: fix memory slot handling for KVM_SET_USER_MEMORY_REGION
Date:   Mon, 17 Jun 2019 23:09:51 +0200
Message-Id: <20190617210804.577765445@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190617210759.929316339@linuxfoundation.org>
References: <20190617210759.929316339@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
index c4180ecfbb2a..ee35f1112db9 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -4413,21 +4413,28 @@ void kvm_arch_commit_memory_region(struct kvm *kvm,
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



