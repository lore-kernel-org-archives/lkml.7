Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10339C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 19:12:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8F4C2184E
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 19:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552504357;
	bh=0xOAyFmhk06ZGLVjVE99rx1PYfwNibq4u5tzXeA1xYU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dGV9wMK04JQJQVcbRfHwxdklu9q4QtYzlEiF0QFuypyoLML7lYc7R2asziVSSZSUY
	 QXAIIBkYxqsvKaqjbVAhIu4IPyKThNRjnteLRHlRpkro1WPTyF1yoNgDYe9yPYNPlB
	 xqkgKLMc1wJQbm+VRoJ7JPY9qPkbzfdNZRw0Bx6k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727248AbfCMTMg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 15:12:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:43176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726263AbfCMTMf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 15:12:35 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4633621871;
        Wed, 13 Mar 2019 19:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552504354;
        bh=0xOAyFmhk06ZGLVjVE99rx1PYfwNibq4u5tzXeA1xYU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V8y3wJXt1PBa5VnVmluaOoiQORnPcI4D2MpQMnEhiRcWpoyoRFT8PiU8SmfaQrzLp
         N1sgpCLU+RBMDfn4sh0CB8Ah5yoaQ4OC4YYgGqPUodlxzYl83KUz4hLZbPn9xCm+D7
         9hYmbKqRyfcNUYkBITApb+hVRNygc9oJgdBIXwJY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jiong Wang <jiong.wang@netronome.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, oss-drivers@netronome.com
Subject: [PATCH AUTOSEL 4.20 54/60] nfp: bpf: fix code-gen bug on BPF_ALU | BPF_XOR | BPF_K
Date:   Wed, 13 Mar 2019 15:10:15 -0400
Message-Id: <20190313191021.158171-54-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190313191021.158171-1-sashal@kernel.org>
References: <20190313191021.158171-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiong Wang <jiong.wang@netronome.com>

[ Upstream commit 71c190249f0ced5b26377ea6bf829ab3af77a40c ]

The intended optimization should be A ^ 0 = A, not A ^ -1 = A.

Fixes: cd7df56ed3e6 ("nfp: add BPF to NFP code translator")
Reviewed-by: Jakub Kicinski <jakub.kicinski@netronome.com>
Signed-off-by: Jiong Wang <jiong.wang@netronome.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/netronome/nfp/bpf/jit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/netronome/nfp/bpf/jit.c b/drivers/net/ethernet/netronome/nfp/bpf/jit.c
index 97d33bb4d84d..0762401ee3fe 100644
--- a/drivers/net/ethernet/netronome/nfp/bpf/jit.c
+++ b/drivers/net/ethernet/netronome/nfp/bpf/jit.c
@@ -2309,7 +2309,7 @@ static int xor_reg(struct nfp_prog *nfp_prog, struct nfp_insn_meta *meta)
 
 static int xor_imm(struct nfp_prog *nfp_prog, struct nfp_insn_meta *meta)
 {
-	return wrp_alu32_imm(nfp_prog, meta, ALU_OP_XOR, !~meta->insn.imm);
+	return wrp_alu32_imm(nfp_prog, meta, ALU_OP_XOR, !meta->insn.imm);
 }
 
 static int and_reg(struct nfp_prog *nfp_prog, struct nfp_insn_meta *meta)
-- 
2.19.1

