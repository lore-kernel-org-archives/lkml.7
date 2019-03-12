Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13B09C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:32:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB4A22087C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:32:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552411951;
	bh=APZPdU7VhwYSGbvYpfEmcCtHjzc0PYTNatcOl+t67OE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=x/OMFEehGgQ/PMCIfbUIzRdsCGKGLqu3IN7Heegozy0AebV3EQD+LksCSvjAE15+0
	 i7OkQ6Qf638jCXUcAVaBufyGnmeh1TpeB+as2VHGGoWA6iroKZiczLDc9yapwzM/H2
	 +er4gJFhr2qjWhC7os6yc4RRXxj20ihmuh6DFN3k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729557AbfCLRcS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:32:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:60292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729418AbfCLRRF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:17:05 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D843F2087C;
        Tue, 12 Mar 2019 17:17:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552411025;
        bh=APZPdU7VhwYSGbvYpfEmcCtHjzc0PYTNatcOl+t67OE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IB3ijwoQNlPj9ajRuZuDMkpYDfyDypbVNcCfmNoCcrYST5pYvEPd5/5/In1YH3ZhE
         p/gaOjdqekWpLOECN4rLga3h2GoTiL4ncJ4gBBnUXv+g/d+M/I0Y9r0JYWWFmQfC6N
         K1mBSKu4qczBMPypx5g6tQM8l865azXrbXds3ax4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jun-Ru Chang <jrjang@realtek.com>,
        Tony Wu <tonywu@realtek.com>,
        Paul Burton <paul.burton@mips.com>, ralf@linux-mips.org,
        jhogan@kernel.org, macro@mips.com, yamada.masahiro@socionext.com,
        peterz@infradead.org, mingo@kernel.org, linux-mips@vger.kernel.org,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 115/135] MIPS: Remove function size check in get_frame_info()
Date:   Tue, 12 Mar 2019 10:09:22 -0700
Message-Id: <20190312170351.821104117@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312170341.127810985@linuxfoundation.org>
References: <20190312170341.127810985@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

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
index e8b166e9146a..ea563bfea0e1 100644
--- a/arch/mips/kernel/process.c
+++ b/arch/mips/kernel/process.c
@@ -370,7 +370,7 @@ static inline int is_sp_move_ins(union mips_instruction *ip, int *frame_size)
 static int get_frame_info(struct mips_frame_info *info)
 {
 	bool is_mmips = IS_ENABLED(CONFIG_CPU_MICROMIPS);
-	union mips_instruction insn, *ip, *ip_end;
+	union mips_instruction insn, *ip;
 	const unsigned int max_insns = 128;
 	unsigned int last_insn_size = 0;
 	unsigned int i;
@@ -383,10 +383,9 @@ static int get_frame_info(struct mips_frame_info *info)
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



