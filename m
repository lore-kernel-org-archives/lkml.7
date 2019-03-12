Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E13E3C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:55:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEBC92087C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552413312;
	bh=B4Oq8vY4v/PHUA2mwC/kSY6YkPUrqqt1DPEqiaRRvLQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oGSgHOgzaNyFZYwzbcxdbTHf7QiAiPg5LfYhq+Z8TsC9qChANiTFM7P6yHD1LKNV1
	 3tmw8u6VLB//NrnJkmbEYW2yCbs45H6p++srrtnOFbFoSxQpgJ/gagnczL8jZ7lb9L
	 yuTp9pRko7EsFD+7o8vGrbZcnY3PiXxQeRSPPH6s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728232AbfCLROF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:14:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:49744 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727916AbfCLRNY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:13:24 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 209B12183E;
        Tue, 12 Mar 2019 17:13:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552410804;
        bh=B4Oq8vY4v/PHUA2mwC/kSY6YkPUrqqt1DPEqiaRRvLQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wFWJ5ckSE/I95DE7WEmN43xH9+qJBrDs4uHI56joUlBeCUICdrVWs3lRZUmX39jo5
         +fTmIcGMpqwIG3Rhz7vnhCdTK7Pp9ZRzgE3z2DIviJqFMoxeDmOv4Xw5cZ/GjThheh
         EBTI8js2sfQfnMBdBGrtPnRAFazZ72NQ3tZyQjZ8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jun-Ru Chang <jrjang@realtek.com>,
        Tony Wu <tonywu@realtek.com>,
        Paul Burton <paul.burton@mips.com>, ralf@linux-mips.org,
        jhogan@kernel.org, macro@mips.com, yamada.masahiro@socionext.com,
        peterz@infradead.org, mingo@kernel.org, linux-mips@vger.kernel.org,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 132/171] MIPS: Remove function size check in get_frame_info()
Date:   Tue, 12 Mar 2019 10:08:32 -0700
Message-Id: <20190312170359.084168929@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312170347.868927101@linuxfoundation.org>
References: <20190312170347.868927101@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index d4f7fd4550e1..85522c137f19 100644
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



