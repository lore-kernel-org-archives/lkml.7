Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B996C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 00:55:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4144B2064A
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 00:55:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553907320;
	bh=RwNR+kjl5ZS6DhvRQw2XoNrM1bCe4f5UOribRFTK8tQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cDvizuSqsxTSnz0gbUW6BTCYB7kOD8LWSsxTYGb+A8VXvSccfd7meXn3nX0SOYFHG
	 sa10m2iiiS2g39I8fmVRWc1Gjt5824y2RyoHzM3y7/bsslMbBdAn5LzkP8xw4PiROj
	 w12n0bS2b3nBBihW3vnp7KFMB+oGrBfoveSDN/VY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730945AbfC3AzS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 20:55:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:34392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731698AbfC3AzN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 20:55:13 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8FF162064A;
        Sat, 30 Mar 2019 00:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553907312;
        bh=RwNR+kjl5ZS6DhvRQw2XoNrM1bCe4f5UOribRFTK8tQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tCpyr4nBRN+tk638f1iyS8WTVn+4mGbRqFyQ5bM3Cutv95XIyRgqkwYGk0gt5GXAi
         StqlABKvhzWX/JA5VmoG6PoqPLMhmc1bSiSF9DJFKDvx5VyUkk/Vdok6B4pn4azSAk
         /HeOWeOLNRGSMqtIlk5bUXwVxMpbHGjO/U/3jdZ0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Matteo Croce <mcroce@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 18/37] x86/mm: Don't leak kernel addresses
Date:   Fri, 29 Mar 2019 20:54:19 -0400
Message-Id: <20190330005441.27540-18-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190330005441.27540-1-sashal@kernel.org>
References: <20190330005441.27540-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matteo Croce <mcroce@redhat.com>

[ Upstream commit a3151724437f54076cc10bc02b1c4f0003ae36cd ]

Since commit:

  ad67b74d2469d9b8 ("printk: hash addresses printed with %p")

at boot "____ptrval____" is printed instead of actual addresses:

    found SMP MP-table at [mem 0x000f5cc0-0x000f5ccf] mapped at [(____ptrval____)]

Instead of changing the print to "%px", and leaking a kernel addresses,
just remove the print completely, like in:

  071929dbdd865f77 ("arm64: Stop printing the virtual memory layout").

Signed-off-by: Matteo Croce <mcroce@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kernel/mpparse.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/mpparse.c b/arch/x86/kernel/mpparse.c
index bc6bc6689e68..1c52acaa5bec 100644
--- a/arch/x86/kernel/mpparse.c
+++ b/arch/x86/kernel/mpparse.c
@@ -596,8 +596,8 @@ static int __init smp_scan_config(unsigned long base, unsigned long length)
 			mpf_base = base;
 			mpf_found = true;
 
-			pr_info("found SMP MP-table at [mem %#010lx-%#010lx] mapped at [%p]\n",
-				base, base + sizeof(*mpf) - 1, mpf);
+			pr_info("found SMP MP-table at [mem %#010lx-%#010lx]\n",
+				base, base + sizeof(*mpf) - 1);
 
 			memblock_reserve(base, sizeof(*mpf));
 			if (mpf->physptr)
-- 
2.19.1

