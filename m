Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C702FC10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 20:06:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FC31204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 20:06:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555963616;
	bh=6Jgx9YpbHstl/xcSD121vWXM28lK2hGsq9iqOgm/BXs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kju4dQ76j9xJfUUna3XxbzJp4hx7g+Asxj35MRuF+c0XRSxZLry4BKCrJVEXpbppe
	 BGavsePUElxqsJPDV36FlHmZn9FgMgKAOqqrwMnubO/TIqMC0jztn55f6xoSckFPMs
	 o1BgSbaOP1WMYJr2+kxXuRHgejIkOQ4SZapQin04=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732354AbfDVUGz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 16:06:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:45488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729456AbfDVTo0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 15:44:26 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6B17F218E0;
        Mon, 22 Apr 2019 19:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555962265;
        bh=6Jgx9YpbHstl/xcSD121vWXM28lK2hGsq9iqOgm/BXs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Gi57aGyW621HzEJMbGCdzG5ECc99rBx6iGyVq5DaTJGJ/Bxx41GVhQSeNr6QTZafQ
         4HuJlIzGYYRsZpP+nChUTti4RN7HEUjKyAyWug1Ip8vTgVm39KERwHKdjbzWSsd/b0
         TbopuZDiee1Gzp5qxXGJ9mU2YD4DTuu+6LnieMqU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ralph Campbell <rcampbell@nvidia.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Craig Bergstrom <craigb@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Fengguang Wu <fengguang.wu@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sander Eikelenboom <linux@eikelenboom.it>,
        Sean Young <sean@mess.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.0 73/98] x86/mm: Don't exceed the valid physical address space
Date:   Mon, 22 Apr 2019 15:41:40 -0400
Message-Id: <20190422194205.10404-73-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190422194205.10404-1-sashal@kernel.org>
References: <20190422194205.10404-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ralph Campbell <rcampbell@nvidia.com>

[ Upstream commit 92c77f7c4d5dfaaf45b2ce19360e69977c264766 ]

valid_phys_addr_range() is used to sanity check the physical address range
of an operation, e.g., access to /dev/mem. It uses __pa(high_memory)
internally.

If memory is populated at the end of the physical address space, then
__pa(high_memory) is outside of the physical address space because:

   high_memory = (void *)__va(max_pfn * PAGE_SIZE - 1) + 1;

For the comparison in valid_phys_addr_range() this is not an issue, but if
CONFIG_DEBUG_VIRTUAL is enabled, __pa() maps to __phys_addr(), which
verifies that the resulting physical address is within the valid physical
address space of the CPU. So in the case that memory is populated at the
end of the physical address space, this is not true and triggers a
VIRTUAL_BUG_ON().

Use __pa(high_memory - 1) to prevent the conversion from going beyond
the end of valid physical addresses.

Fixes: be62a3204406 ("x86/mm: Limit mmap() of /dev/mem to valid physical addresses")
Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Craig Bergstrom <craigb@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Fengguang Wu <fengguang.wu@intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Hans Verkuil <hans.verkuil@cisco.com>
Cc: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Sander Eikelenboom <linux@eikelenboom.it>
Cc: Sean Young <sean@mess.org>

Link: https://lkml.kernel.org/r/20190326001817.15413-2-rcampbell@nvidia.com
Signed-off-by: Sasha Levin (Microsoft) <sashal@kernel.org>
---
 arch/x86/mm/mmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/mm/mmap.c b/arch/x86/mm/mmap.c
index db3165714521..dc726e07d8ba 100644
--- a/arch/x86/mm/mmap.c
+++ b/arch/x86/mm/mmap.c
@@ -230,7 +230,7 @@ bool mmap_address_hint_valid(unsigned long addr, unsigned long len)
 /* Can we access it for direct reading/writing? Must be RAM: */
 int valid_phys_addr_range(phys_addr_t addr, size_t count)
 {
-	return addr + count <= __pa(high_memory);
+	return addr + count - 1 <= __pa(high_memory - 1);
 }
 
 /* Can we access it through mmap? Must be a valid physical address: */
-- 
2.19.1

