Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04260C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:35:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C787021019
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551688510;
	bh=9T9zF1WiXvhVaLd7tbq5fxAoE2Avrr/lRpYykcnwTFw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GM+c+bpSVwTfJTBor7L1hQPWBx9oo8FeCmg2WFW1r6TA+F6eX9WvuvPhgbLNAb9Gs
	 7GxwgQtycR/qLRWbWqzJiEJTvyLsrauhP3G/vdsvz4WGtegSVCD6mO+n46ZoXkaJ5+
	 DDLt3N5apxiuPTK/807dBQv4y0FuQ+/Ukr4jxmz0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727869AbfCDIfJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 03:35:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:42626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728390AbfCDIfF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 03:35:05 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 579B920823;
        Mon,  4 Mar 2019 08:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551688504;
        bh=9T9zF1WiXvhVaLd7tbq5fxAoE2Avrr/lRpYykcnwTFw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MSLg05gyg1JvaYxaxSL12eiFVZrlVVlr4xeunz4kZQpBfTd55GEZWUBwVxnbH+RWf
         LQDy4SwfirIIQtnOoVnSK/c/AM2G3lxkz2EWARdc5RBXZRs8eR4VT96fTFYM2vuHQJ
         SR3OGJ7eq15+7ipsRvVTym1L9XeLzFrGQnmhM0MQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ben Gardon <bgardon@google.com>,
        Jim Mattson <jmattson@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 66/88] kvm: selftests: Fix region overlap check in kvm_util
Date:   Mon,  4 Mar 2019 09:22:49 +0100
Message-Id: <20190304081633.195432642@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190304081630.610632175@linuxfoundation.org>
References: <20190304081630.610632175@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 94a980c39c8e3f8abaff5d3b5bbcd4ccf1c02c4f ]

Fix a call to userspace_mem_region_find to conform to its spec of
taking an inclusive, inclusive range. It was previously being called
with an inclusive, exclusive range. Also remove a redundant region bounds
check in vm_userspace_mem_region_add. Region overlap checking is already
performed by the call to userspace_mem_region_find.

Tested: Compiled tools/testing/selftests/kvm with -static
	Ran all resulting test binaries on an Intel Haswell test machine
	All tests passed

Signed-off-by: Ben Gardon <bgardon@google.com>
Reviewed-by: Jim Mattson <jmattson@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/kvm/lib/kvm_util.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index 1b41e71283d5b..6ee49133ad226 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -532,7 +532,7 @@ void vm_userspace_mem_region_add(struct kvm_vm *vm,
 	 * already exist.
 	 */
 	region = (struct userspace_mem_region *) userspace_mem_region_find(
-		vm, guest_paddr, guest_paddr + npages * vm->page_size);
+		vm, guest_paddr, (guest_paddr + npages * vm->page_size) - 1);
 	if (region != NULL)
 		TEST_ASSERT(false, "overlapping userspace_mem_region already "
 			"exists\n"
@@ -548,15 +548,10 @@ void vm_userspace_mem_region_add(struct kvm_vm *vm,
 		region = region->next) {
 		if (region->region.slot == slot)
 			break;
-		if ((guest_paddr <= (region->region.guest_phys_addr
-				+ region->region.memory_size))
-			&& ((guest_paddr + npages * vm->page_size)
-				>= region->region.guest_phys_addr))
-			break;
 	}
 	if (region != NULL)
 		TEST_ASSERT(false, "A mem region with the requested slot "
-			"or overlapping physical memory range already exists.\n"
+			"already exists.\n"
 			"  requested slot: %u paddr: 0x%lx npages: 0x%lx\n"
 			"  existing slot: %u paddr: 0x%lx size: 0x%lx",
 			slot, guest_paddr, npages,
-- 
2.19.1



