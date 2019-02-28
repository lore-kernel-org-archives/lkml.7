Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66427C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:29:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 252FE20C01
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:29:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551367748;
	bh=L+hbZ7fSxfbGTnpeQKZtlJuuEWJaJbvt777eMxAH1Xw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kCPMjUjjxWv6lVsLd6dEOCicizMo3lTaRxnYnDBaBDl+NUCRrWE+exwgH+SKJd/FN
	 K5XzOKVosU0kTZbYO2lwZN9Y01+ownses2DqUA2uE3oOnXfyo9brqPIBP0YPN+wtxV
	 Wb6bZ9UOSmH9f0F4hyfEIqfO38rEm0djkKiseNTI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387789AbfB1PKr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 10:10:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:43514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387771AbfB1PKn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 10:10:43 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 00F3E2171F;
        Thu, 28 Feb 2019 15:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551366642;
        bh=L+hbZ7fSxfbGTnpeQKZtlJuuEWJaJbvt777eMxAH1Xw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WeRBKrqvFfxPYIPIy1z3zFTx4545FbuRQtc5EgY7bMdrzRR7DlnXDa+i6U3dxJL++
         l0GoKlCt4p9DFwOQxkVsmyV+vbIU2FgnOVGqfQhev0ZB/W7rwZokMKkM2ZrUr2xKC5
         +xSCtytbAaBeDTjl/gCKbXPLkHe7JZDHlAJyRZPk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jun-Ru Chang <jrjang@realtek.com>, Tony Wu <tonywu@realtek.com>,
        Paul Burton <paul.burton@mips.com>, ralf@linux-mips.org,
        jhogan@kernel.org, macro@mips.com, yamada.masahiro@socionext.com,
        peterz@infradead.org, mingo@kernel.org, linux-mips@vger.kernel.org,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.20 68/81] MIPS: Remove function size check in get_frame_info()
Date:   Thu, 28 Feb 2019 10:08:00 -0500
Message-Id: <20190228150813.10256-68-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190228150813.10256-1-sashal@kernel.org>
References: <20190228150813.10256-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jun-Ru Chang <jrjang@realtek.com>

[ Upstream commit 2b424cfc69728224fcb5fad138ea7260728e0901 ]

Patch (b6c7a324df37b "MIPS: Fix get_frame_info() handling of
microMIPS function size.") introduces additional function size
check for microMIPS by only checking insn between ip and ip + func_size.
However, func_size in get_frame_info() is always 0 if KALLSYMS is not
enabled. This causes get_frame_info() to return immediately without
calculating correct frame_size, which in turn causes "Can't analyze
schedule() prologue" warning messages at boot time.

This patch removes func_size check, and let the frame_size check run
up to 128 insns for both MIPS and microMIPS.

Signed-off-by: Jun-Ru Chang <jrjang@realtek.com>
Signed-off-by: Tony Wu <tonywu@realtek.com>
Signed-off-by: Paul Burton <paul.burton@mips.com>
Fixes: b6c7a324df37b ("MIPS: Fix get_frame_info() handling of microMIPS function size.")
Cc: <ralf@linux-mips.org>
Cc: <jhogan@kernel.org>
Cc: <macro@mips.com>
Cc: <yamada.masahiro@socionext.com>
Cc: <peterz@infradead.org>
Cc: <mingo@kernel.org>
Cc: <linux-mips@vger.kernel.org>
Cc: <linux-kernel@vger.kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/mips/kernel/process.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/mips/kernel/process.c b/arch/mips/kernel/process.c
index d4f7fd4550e10..85522c137f19f 100644
--- a/arch/mips/kernel/process.c
+++ b/arch/mips/kernel/process.c
@@ -371,7 +371,7 @@ static inline int is_sp_move_ins(union mips_instruction *ip, int *frame_size)
 static int get_frame_info(struct mips_frame_info *info)
 {
 	bool is_mmips = IS_ENABLED(CONFIG_CPU_MICROMIPS);
-	union mips_instruction insn, *ip, *ip_end;
+	union mips_instruction insn, *ip;
 	const unsigned int max_insns = 128;
 	unsigned int last_insn_size = 0;
 	unsigned int i;
@@ -384,10 +384,9 @@ static int get_frame_info(struct mips_frame_info *info)
 	if (!ip)
 		goto err;
 
-	ip_end = (void *)ip + info->func_size;
-
-	for (i = 0; i < max_insns && ip < ip_end; i++) {
+	for (i = 0; i < max_insns; i++) {
 		ip = (void *)ip + last_insn_size;
+
 		if (is_mmips && mm_insn_16bit(ip->halfword[0])) {
 			insn.word = ip->halfword[0] << 16;
 			last_insn_size = 2;
-- 
2.19.1

