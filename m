Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F642C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 10:23:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 326E72067C
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 10:23:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727434AbfLQKXj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 05:23:39 -0500
Received: from smtp1.axis.com ([195.60.68.17]:4462 "EHLO smtp1.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726411AbfLQKXj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 05:23:39 -0500
IronPort-SDR: olos7RgV0aFCzW+bUUn0tK2MWoDKJsoEdL/t1GiX/kM71PMjnlnsXWjAXZLSiau3qWEvI4Lj6R
 X2sjFQfSJfg8bkB/gNmbizfkYrWeHroDKeisiU+YEaMgQtBCGRIQYWUsiIC1vUQLY1UdEugjVq
 +j9l43yK0Mhl1nCj2FTAkMKmTusAvdn527/q7slSaR5Ni2ENYzBzwT5zI8RKHGXrO+f15WL2Zc
 Ur3GXjJcV/AQXpxozLus0K7XfQL9Mg6BRBoa5mtbBlMW+hBGI4RcGn6jl2nEDzrTmSQJgZChsM
 Q9E=
X-IronPort-AV: E=Sophos;i="5.69,325,1571695200"; 
   d="scan'208";a="3670839"
X-Axis-User: NO
X-Axis-NonUser: YES
X-Virus-Scanned: Debian amavisd-new at bastet.se.axis.com
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     akpm@linux-foundation.org
Cc:     arnd@arndb.de, treding@nvidia.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Vincent Whitchurch <rabinv@axis.com>
Subject: [PATCH] asm/sections: Check for overflow in memory_contains()
Date:   Tue, 17 Dec 2019 11:22:38 +0100
Message-Id: <20191217102238.14792-1-vincent.whitchurch@axis.com>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ARM uses memory_contains() from its stacktrace code via this function:

 static inline bool in_entry_text(unsigned long addr)
 {
 	return memory_contains(__entry_text_start, __entry_text_end,
 			       (void *)addr, 1);
 }

addr is taken from the stack and can be a completely invalid.  If addr
is 0xffffffff, there is an overflow in the pointer arithmetic in
memory_contains() and in_entry_text() incorrectly returns true.

Fix this by adding an overflow check.  The check is done on unsigned
longs to avoid undefined behaviour.

Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---
 include/asm-generic/sections.h | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/include/asm-generic/sections.h b/include/asm-generic/sections.h
index d1779d442aa5..e6e1b381c5df 100644
--- a/include/asm-generic/sections.h
+++ b/include/asm-generic/sections.h
@@ -105,7 +105,15 @@ static inline int arch_is_kernel_initmem_freed(unsigned long addr)
 static inline bool memory_contains(void *begin, void *end, void *virt,
 				   size_t size)
 {
-	return virt >= begin && virt + size <= end;
+	unsigned long membegin = (unsigned long)begin;
+	unsigned long memend = (unsigned long)end;
+	unsigned long objbegin = (unsigned long)virt;
+	unsigned long objend = objbegin + size;
+
+	if (objend < objbegin)
+		return false;
+
+	return objbegin >= membegin && objend <= memend;
 }
 
 /**
-- 
2.20.0

