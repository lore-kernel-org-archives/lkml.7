Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C08ADC3A5A8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 16:02:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A8882341D
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 16:02:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567612949;
	bh=2ibOJCskqyyIBOusPY1iCMu2HpaNxbbIeVYJZPmsBhE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=L0S9DkK2QoxXH3cmoPRmRdXqMD7YtKq6JXIhWXnRe45G4tyxkUhhGLHsUDRMAnGgD
	 P7dILxBj4M91UgcFzhb7vF4yw3QIn9GTAZ5fjrM5a3AyfNVfm9k+5qgZTuY/p8tLxF
	 bKQPZNiXVxBdsk61g0P0WM4GpwI9WkQU5+6l7rDA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733295AbfIDQC2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 12:02:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:38342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733258AbfIDQCZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 12:02:25 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 145682070C;
        Wed,  4 Sep 2019 16:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567612944;
        bh=2ibOJCskqyyIBOusPY1iCMu2HpaNxbbIeVYJZPmsBhE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Yks6/Nv+F1HZip3lKAasBHIkJrIffMDanhXmzhyTfmaB6bmevVJbsDlaq+Rjo1hvy
         0asDP6xP2r0cOHZPP8vQRHFE9SZG7rCBWwWQyN+avbNueHXKbrDGjRxSM+aQbyi6DT
         9V9J26YtBKKycp73g0e6+t1Q0QcKGmT/UR30kBok=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ilya Leoshkevich <iii@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 02/27] s390/bpf: fix lcgr instruction encoding
Date:   Wed,  4 Sep 2019 12:01:55 -0400
Message-Id: <20190904160220.4545-2-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190904160220.4545-1-sashal@kernel.org>
References: <20190904160220.4545-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ilya Leoshkevich <iii@linux.ibm.com>

[ Upstream commit bb2d267c448f4bc3a3389d97c56391cb779178ae ]

"masking, test in bounds 3" fails on s390, because
BPF_ALU64_IMM(BPF_NEG, BPF_REG_2, 0) ignores the top 32 bits of
BPF_REG_2. The reason is that JIT emits lcgfr instead of lcgr.
The associated comment indicates that the code was intended to
emit lcgr in the first place, it's just that the wrong opcode
was used.

Fix by using the correct opcode.

Fixes: 054623105728 ("s390/bpf: Add s390x eBPF JIT compiler backend")
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Acked-by: Vasily Gorbik <gor@linux.ibm.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/s390/net/bpf_jit_comp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/net/bpf_jit_comp.c b/arch/s390/net/bpf_jit_comp.c
index 896344b6e0363..e4616090732a4 100644
--- a/arch/s390/net/bpf_jit_comp.c
+++ b/arch/s390/net/bpf_jit_comp.c
@@ -881,7 +881,7 @@ static noinline int bpf_jit_insn(struct bpf_jit *jit, struct bpf_prog *fp, int i
 		break;
 	case BPF_ALU64 | BPF_NEG: /* dst = -dst */
 		/* lcgr %dst,%dst */
-		EMIT4(0xb9130000, dst_reg, dst_reg);
+		EMIT4(0xb9030000, dst_reg, dst_reg);
 		break;
 	/*
 	 * BPF_FROM_BE/LE
-- 
2.20.1

