Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55F10C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 19:23:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24807217D4
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 19:23:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558553011;
	bh=yXAs6xjmO09egqVlHkZmk/XbA+GIQAw/el2/6CZuqm4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rfbeCHcKKR0rcZCW+dbWL8E0N2tbPkU2jOWYuWrhTQ+APeRjWmoqeuTUL2DlLj1Ew
	 TiD9h9vBDysj1Zaq56OYk7mhCqHD1P8xzT/tJLwuDQfKw5+Kq9VPd1856LK4CYRJ9Y
	 R7rXVnLEIBuWkqchkxfG/QP1D866tVWmA5Bqm/Nc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730907AbfEVTXa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 15:23:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:44322 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730893AbfEVTX1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 15:23:27 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C57F5217D9;
        Wed, 22 May 2019 19:23:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558553006;
        bh=yXAs6xjmO09egqVlHkZmk/XbA+GIQAw/el2/6CZuqm4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pp4vMVrdBpvOhMX7xdlzXB8NXiae6t9F5zlU0vG/iaWUmschhv1g57K1M6TtTtu4S
         2l6SCNWbPBVfjEcwENDgT06N3CjSE0LRJmh2adi4Tu+ZpfLoOczX0qUX8eJ+Eq76wO
         WjhA6/DE8zZ7BwriJhvbbc0D9AE2en7hbLa/1Ack=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Will Deacon <will.deacon@arm.com>, stable@kernel.org,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.1 073/375] arm64: futex: Fix FUTEX_WAKE_OP atomic ops with non-zero result value
Date:   Wed, 22 May 2019 15:16:13 -0400
Message-Id: <20190522192115.22666-73-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190522192115.22666-1-sashal@kernel.org>
References: <20190522192115.22666-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Will Deacon <will.deacon@arm.com>

[ Upstream commit 84ff7a09c371bc7417eabfda19bf7f113ec917b6 ]

Rather embarrassingly, our futex() FUTEX_WAKE_OP implementation doesn't
explicitly set the return value on the non-faulting path and instead
leaves it holding the result of the underlying atomic operation. This
means that any FUTEX_WAKE_OP atomic operation which computes a non-zero
value will be reported as having failed. Regrettably, I wrote the buggy
code back in 2011 and it was upstreamed as part of the initial arm64
support in 2012.

The reasons we appear to get away with this are:

  1. FUTEX_WAKE_OP is rarely used and therefore doesn't appear to get
     exercised by futex() test applications

  2. If the result of the atomic operation is zero, the system call
     behaves correctly

  3. Prior to version 2.25, the only operation used by GLIBC set the
     futex to zero, and therefore worked as expected. From 2.25 onwards,
     FUTEX_WAKE_OP is not used by GLIBC at all.

Fix the implementation by ensuring that the return value is either 0
to indicate that the atomic operation completed successfully, or -EFAULT
if we encountered a fault when accessing the user mapping.

Cc: <stable@kernel.org>
Fixes: 6170a97460db ("arm64: Atomic operations")
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/include/asm/futex.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/futex.h b/arch/arm64/include/asm/futex.h
index 6fb2214333a24..2d78ea6932b7b 100644
--- a/arch/arm64/include/asm/futex.h
+++ b/arch/arm64/include/asm/futex.h
@@ -58,7 +58,7 @@ do {									\
 static inline int
 arch_futex_atomic_op_inuser(int op, int oparg, int *oval, u32 __user *_uaddr)
 {
-	int oldval = 0, ret, tmp;
+	int oldval, ret, tmp;
 	u32 __user *uaddr = __uaccess_mask_ptr(_uaddr);
 
 	pagefault_disable();
-- 
2.20.1

