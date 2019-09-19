Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A5BFC3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 22:16:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B08C21907
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 22:16:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568931363;
	bh=a8PcxwkH/yhBpP/Uv+e/tOJ3RH9mLDf+5boZSmLhLN8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tdlJKVpXoWYYaRNfVKmLmKzDWOPiNFP+JCckvtZ/AHvfo9W0oNDsgmzKK9gs5RUOF
	 9OODu2wdzI/t+NN+FMJK0hBS9v2Z58v/W70duoxKzJCnsfFi/poIuZCMVghH/MprqI
	 M5uZQIf5ReYsO4KK9fNm4o/oInp6LFn/6RbRkxi8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406247AbfISWQC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 18:16:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:55968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406216AbfISWPy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 18:15:54 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6F0E420678;
        Thu, 19 Sep 2019 22:15:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568931354;
        bh=a8PcxwkH/yhBpP/Uv+e/tOJ3RH9mLDf+5boZSmLhLN8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EHz/9uIwBwoEKzGBJWCoRmL/F7YpoyPnDYNpWbfdAwO4Rfp7WPQCR95YJDn9k0A5S
         17iBupqZ0cqis8dTH6qLTy1yrsRmVQf8k8c0SXHG555R9ocvoghYAh+M9GqA4CDgxk
         eJFVeOtQCmXDR/Vf5bOXYhRxIMXcGl0fQnYxkoIc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ilya Leoshkevich <iii@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 16/59] s390/bpf: fix lcgr instruction encoding
Date:   Fri, 20 Sep 2019 00:03:31 +0200
Message-Id: <20190919214800.852584636@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190919214755.852282682@linuxfoundation.org>
References: <20190919214755.852282682@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
index bc9431aace05d..fcb9e840727cd 100644
--- a/arch/s390/net/bpf_jit_comp.c
+++ b/arch/s390/net/bpf_jit_comp.c
@@ -882,7 +882,7 @@ static noinline int bpf_jit_insn(struct bpf_jit *jit, struct bpf_prog *fp, int i
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



