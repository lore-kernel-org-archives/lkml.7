Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF1F7C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:30:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F4F2208E4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551688252;
	bh=rae7IBApMra51kMwi+gjqMXUaiTupah0oHUHnsAEMDs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mPFkY5Ax1j8foOd374iYEOcpbVkkq26MaacPoWHdqm53QcXZ+cgjhPof6Yoc2Q3rn
	 V7XARWnSgjnbP7cF88wWvSXFFePb8B2H6gwy5lzNyI6zD7h+ZQq/h7aKEaGBN8EQpd
	 qGWLK/huX2FKwuI9RrmuEz4yZwXxohYmDlm4oY2k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727791AbfCDIau (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 03:30:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:59586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726254AbfCDIas (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 03:30:48 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0C22A20823;
        Mon,  4 Mar 2019 08:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551688247;
        bh=rae7IBApMra51kMwi+gjqMXUaiTupah0oHUHnsAEMDs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=v2Bo++TryMCaYb3i2dyBhCfNSAzYTZXpqqE8hgWvZ0LrEwuygvM1kDcPqFgt9luyQ
         r+wErUoelRGADsdIgqbhYW1gOSe/qy2dk0dTWkAyFV8+0z+AdZf390s/PPAhT4ZXen
         4vRowSPdhccitLUIl1lopYQHbDh+WY3izwYzJeUY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ben Gardon <bgardon@google.com>,
        Jim Mattson <jmattson@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 64/78] kvm: selftests: Fix region overlap check in kvm_util
Date:   Mon,  4 Mar 2019 09:22:47 +0100
Message-Id: <20190304081628.427365367@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190304081625.508788074@linuxfoundation.org>
References: <20190304081625.508788074@linuxfoundation.org>
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
index 6fd8c089cafcd..fb5d2d1e0c048 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -590,7 +590,7 @@ void vm_userspace_mem_region_add(struct kvm_vm *vm,
 	 * already exist.
 	 */
 	region = (struct userspace_mem_region *) userspace_mem_region_find(
-		vm, guest_paddr, guest_paddr + npages * vm->page_size);
+		vm, guest_paddr, (guest_paddr + npages * vm->page_size) - 1);
 	if (region != NULL)
 		TEST_ASSERT(false, "overlapping userspace_mem_region already "
 			"exists\n"
@@ -606,15 +606,10 @@ void vm_userspace_mem_region_add(struct kvm_vm *vm,
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



