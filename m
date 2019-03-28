Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63E65C4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 13:18:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37D022173C
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 13:18:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727054AbfC1NS2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 09:18:28 -0400
Received: from terminus.zytor.com ([198.137.202.136]:40767 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725779AbfC1NS2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 09:18:28 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x2SDGE1g3331780
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 28 Mar 2019 06:16:14 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x2SDG9TR3331769;
        Thu, 28 Mar 2019 06:16:09 -0700
Date:   Thu, 28 Mar 2019 06:16:09 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Ralph Campbell <tipbot@zytor.com>
Message-ID: <tip-92c77f7c4d5dfaaf45b2ce19360e69977c264766@git.kernel.org>
Cc:     rcampbell@nvidia.com, linux@eikelenboom.it,
        boris.ostrovsky@oracle.com, mchehab@s-opensource.com,
        linux-kernel@vger.kernel.org, hans.verkuil@cisco.com,
        mingo@kernel.org, tglx@linutronix.de, craigb@google.com,
        hpa@zytor.com, torvalds@linux-foundation.org, sean@mess.org,
        fengguang.wu@intel.com, peterz@infradead.org,
        gregkh@linuxfoundation.org
Reply-To: peterz@infradead.org, fengguang.wu@intel.com,
          gregkh@linuxfoundation.org, torvalds@linux-foundation.org,
          sean@mess.org, linux-kernel@vger.kernel.org,
          mchehab@s-opensource.com, hans.verkuil@cisco.com,
          mingo@kernel.org, tglx@linutronix.de, hpa@zytor.com,
          craigb@google.com, rcampbell@nvidia.com, linux@eikelenboom.it,
          boris.ostrovsky@oracle.com
In-Reply-To: <20190326001817.15413-2-rcampbell@nvidia.com>
References: <20190326001817.15413-2-rcampbell@nvidia.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/mm: Don't exceed the valid physical address
 space
Git-Commit-ID: 92c77f7c4d5dfaaf45b2ce19360e69977c264766
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  92c77f7c4d5dfaaf45b2ce19360e69977c264766
Gitweb:     https://git.kernel.org/tip/92c77f7c4d5dfaaf45b2ce19360e69977c264766
Author:     Ralph Campbell <rcampbell@nvidia.com>
AuthorDate: Mon, 25 Mar 2019 17:18:17 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 28 Mar 2019 14:13:51 +0100

x86/mm: Don't exceed the valid physical address space

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
