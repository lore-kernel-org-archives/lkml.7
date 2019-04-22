Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2FC6C10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 20:11:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6D9B2075A
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 20:11:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555963909;
	bh=0NHLvwfoKQMlaQaxzUsbEC/SYdZ/fTDhC2rT8mW3vRE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EEzntDDAj7F8gRxNFcNJQJ6jS7YTIWIi0E0CtEMzlSaj7dhIIAsKuP2bCEj72CNTn
	 9Qz8zAfKK6xveledjggCCqzFA7fGDy2pjDviQTo7e/33ZWFlD8wSzFrOMvaCyERyT1
	 fYeLDQa3e6cLcT13YybY7rlLYEMhfy1KJh2ozVeI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728654AbfDVTmO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 15:42:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:42434 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728506AbfDVTmJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 15:42:09 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5B737218B0;
        Mon, 22 Apr 2019 19:42:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555962128;
        bh=0NHLvwfoKQMlaQaxzUsbEC/SYdZ/fTDhC2rT8mW3vRE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HTZtNH/hwo2s/QyPA2VCKie4O/54fftqFWpEeyPCa1l7tap7esV8mLuxSG4Q/165F
         W4/iWfNt8bR6w0TVz3jw5FCwSvfpv1tIYvlDE0ao1SRXpJS8VJ7ScACkFmpoZZZtm9
         WqKIYptD6RcIQoLQW+P1OrY+3L/U1DJOkGit9viE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.0 03/98] s390: limit brk randomization to 32MB
Date:   Mon, 22 Apr 2019 15:40:30 -0400
Message-Id: <20190422194205.10404-3-sashal@kernel.org>
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

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

[ Upstream commit cd479eccd2e057116d504852814402a1e68ead80 ]

For a 64-bit process the randomization of the program break is quite
large with 1GB. That is as big as the randomization of the anonymous
mapping base, for a test case started with '/lib/ld64.so.1 <exec>'
it can happen that the heap is placed after the stack. To avoid
this limit the program break randomization to 32MB for 64-bit and
keep 8MB for 31-bit.

Reported-by: Stefan Liebler <stli@linux.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Sasha Levin (Microsoft) <sashal@kernel.org>
---
 arch/s390/include/asm/elf.h | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/s390/include/asm/elf.h b/arch/s390/include/asm/elf.h
index 7d22a474a040..f74639a05f0f 100644
--- a/arch/s390/include/asm/elf.h
+++ b/arch/s390/include/asm/elf.h
@@ -252,11 +252,14 @@ do {								\
 
 /*
  * Cache aliasing on the latest machines calls for a mapping granularity
- * of 512KB. For 64-bit processes use a 512KB alignment and a randomization
- * of up to 1GB. For 31-bit processes the virtual address space is limited,
- * use no alignment and limit the randomization to 8MB.
+ * of 512KB for the anonymous mapping base. For 64-bit processes use a
+ * 512KB alignment and a randomization of up to 1GB. For 31-bit processes
+ * the virtual address space is limited, use no alignment and limit the
+ * randomization to 8MB.
+ * For the additional randomization of the program break use 32MB for
+ * 64-bit and 8MB for 31-bit.
  */
-#define BRK_RND_MASK	(is_compat_task() ? 0x7ffUL : 0x3ffffUL)
+#define BRK_RND_MASK	(is_compat_task() ? 0x7ffUL : 0x1fffUL)
 #define MMAP_RND_MASK	(is_compat_task() ? 0x7ffUL : 0x3ff80UL)
 #define MMAP_ALIGN_MASK	(is_compat_task() ? 0 : 0x7fUL)
 #define STACK_RND_MASK	MMAP_RND_MASK
-- 
2.19.1

