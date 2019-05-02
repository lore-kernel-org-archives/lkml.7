Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81EA2C43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 15:33:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F4352081C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 15:33:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556811193;
	bh=AoYRiac6rFuvgBx94Y9LNGWvmUQAAaWakSRA5xQyUgg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oyRlrmdul/P2Gtm0mVIs32EprlfZq88n6+pvYG71faPp5xo/P9Sv9FS6U3Pqhp23e
	 gwPuRO3A3V9dTqlm95S+8c00IZfBm5Q7rJ4kawLatxHf49gs6l49u3J0QemeXvwsTA
	 NfIMDGXrH3LxfnSj8IlKiKiylv8+D4KPKhbnndno=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729344AbfEBPdM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 11:33:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:53270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728354AbfEBPdJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 11:33:09 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BB33E21743;
        Thu,  2 May 2019 15:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556811188;
        bh=AoYRiac6rFuvgBx94Y9LNGWvmUQAAaWakSRA5xQyUgg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TjblWLOFmxWapWcboLX3kruhfRxpsNNd5WAPR0/mUK9lEj/Bk0zok2aKQ1lQdIF0u
         O5s4FqKbljJ5eiQWf3mWlSR1m5ZjVmTLC44PvpRMhBNf4WCBpyMXQbENclmp5DoeRz
         FmFZvZIeGeqB7q7L4gD+aaIR8NBz5YmjQIYpL9ic=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ralph Campbell <rcampbell@nvidia.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Craig Bergstrom <craigb@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Fengguang Wu <fengguang.wu@intel.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sander Eikelenboom <linux@eikelenboom.it>,
        Sean Young <sean@mess.org>,
        "Sasha Levin (Microsoft)" <sashal@kernel.org>
Subject: [PATCH 5.0 076/101] x86/mm: Dont exceed the valid physical address space
Date:   Thu,  2 May 2019 17:21:18 +0200
Message-Id: <20190502143344.976370304@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190502143339.434882399@linuxfoundation.org>
References: <20190502143339.434882399@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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



