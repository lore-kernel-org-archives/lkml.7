Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8440C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 01:06:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B507F206DD
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 01:06:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553907964;
	bh=adC080+lYXQp/+OPTHAwFYTkd60xB6dfS/JrS3+/GQc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=p7ipafwd2lqt6loXpzbWGkKTXCSs/JeExCiP01MWow51LYlCuyhXCNMMKPXF3Lm8z
	 T04NRyHNIkFrv3qpoITBO8AK9VboM8HMlotIq75ZbXYvstMyl0aQEax51HjW7IjBUa
	 EYCCp70EdTjNTx3MOCBug5bBFG55/KKDvTeQMEKM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731544AbfC3BGD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 21:06:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:60652 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731355AbfC3Axq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 20:53:46 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0B74F218D0;
        Sat, 30 Mar 2019 00:53:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553907226;
        bh=adC080+lYXQp/+OPTHAwFYTkd60xB6dfS/JrS3+/GQc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0hT0ZwrMfDs30GsXWmY2xtY88nBeQihxPSSKVfMgn09dei3KnxixYWNNhmTiYRdW7
         GVkBC55yWVG8Q1P4yNbFyt04XaO0YM11vZ4ELudHRmqTlC1TlM5UYaTagulNvsCw2K
         lmj2EMx18xsp9dhKvSqAY9gfKK3KIdJfxPlqY3WU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Matteo Croce <mcroce@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 26/52] x86/mm: Don't leak kernel addresses
Date:   Fri, 29 Mar 2019 20:52:33 -0400
Message-Id: <20190330005301.26868-26-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190330005301.26868-1-sashal@kernel.org>
References: <20190330005301.26868-1-sashal@kernel.org>
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
index f1c5eb99d445..ddb1ca6923b1 100644
--- a/arch/x86/kernel/mpparse.c
+++ b/arch/x86/kernel/mpparse.c
@@ -599,8 +599,8 @@ static int __init smp_scan_config(unsigned long base, unsigned long length)
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

