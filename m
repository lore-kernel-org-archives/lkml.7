Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65759C10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 19:47:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2841821906
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 19:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555962457;
	bh=XT1k/uhoLQ7FrR5InreJN+naH+JneXwmT1v6Lddt2YE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=llErn73gZ7835xVKnMFStgUNOmhY5rQw124wztVB6Vo6ojiqVOGi6syGJHEwswJeM
	 E8f4mnjLTuFcn+l0OU8AROOuSOXpceBcC6708xfdS9WRTBg7vhpDw+UoI0xO2scTb4
	 DnhhCj8o1AQNGvmkM9PJnEz0N7Jl4y1Cwf4uqpf4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730307AbfDVTrg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 15:47:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:50368 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730276AbfDVTrc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 15:47:32 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2FD8C21904;
        Mon, 22 Apr 2019 19:47:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555962451;
        bh=XT1k/uhoLQ7FrR5InreJN+naH+JneXwmT1v6Lddt2YE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WSGdCvZEB93KrEpQhfmMaiRYUgbefSPCKYMmkhKcMDxH9veyfgCZ7I8obqqW0k2zy
         oLYO75AVvBMvkrtofc8bK1mW9guAtM0bsdXUU9IdbMFiYFfCpPSW4eIBGhw7GwgEcF
         wWUIe2MbtBPl9vj7FF7jYXfgRYMwSW9zSMHP3xJI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Sasha Levin <sashal@kernel.org>, linux-s390@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 02/43] s390: limit brk randomization to 32MB
Date:   Mon, 22 Apr 2019 15:46:46 -0400
Message-Id: <20190422194727.12495-2-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190422194727.12495-1-sashal@kernel.org>
References: <20190422194727.12495-1-sashal@kernel.org>
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
index 1a61b1b997f2..3055c030f765 100644
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

