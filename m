Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11EEAC3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 22:12:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6A7C218AF
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 22:12:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568931177;
	bh=MvYti3+n7kM/43yLnLVWf0pMoCa1vY6xzGEgd7FD1J4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vbAUyPQYT6mW4TSW0okJBy8v/Cp9aeEPewLxZ9Ix7FVuDdaUrwKdHsayQOxDpp23N
	 B7pX4DkuzVaj4ulkJX2j8lgFiQicsN/V1eE10be8/nOpxu1P6lXHRuMRj76TKq6hzj
	 8f8My1db7XiW0PD+w4B4MzkV2MS8//GGK5syAe4Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406010AbfISWM4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 18:12:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:51938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404418AbfISWMy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 18:12:54 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 024BD2196F;
        Thu, 19 Sep 2019 22:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568931173;
        bh=MvYti3+n7kM/43yLnLVWf0pMoCa1vY6xzGEgd7FD1J4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NeUCHtldZYs48AaUCcjL0hzBwFPjKkpixOhpKfHE8OpK22nqfAVM2Nj5s5OIEVJw2
         tvh8g38o5SrGY/7x+H9KR5l1xk5AKQpoTDWb/szgXXcfnkDwM2Mhvh9niiPnE4tdcB
         n6F/jvkEJa2Zp0XOM+fU1MN462cJPRpsbfT5ICRM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Yauheni Kaliuta <yauheni.kaliuta@redhat.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 29/79] s390/bpf: use 32-bit index for tail calls
Date:   Fri, 20 Sep 2019 00:03:14 +0200
Message-Id: <20190919214810.403119719@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190919214807.612593061@linuxfoundation.org>
References: <20190919214807.612593061@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ilya Leoshkevich <iii@linux.ibm.com>

[ Upstream commit 91b4db5313a2c793aabc2143efb8ed0cf0fdd097 ]

"p runtime/jit: pass > 32bit index to tail_call" fails when
bpf_jit_enable=1, because the tail call is not executed.

This in turn is because the generated code assumes index is 64-bit,
while it must be 32-bit, and as a result prog array bounds check fails,
while it should pass. Even if bounds check would have passed, the code
that follows uses 64-bit index to compute prog array offset.

Fix by using clrj instead of clgrj for comparing index with array size,
and also by using llgfr for truncating index to 32 bits before using it
to compute prog array offset.

Fixes: 6651ee070b31 ("s390/bpf: implement bpf_tail_call() helper")
Reported-by: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Acked-by: Vasily Gorbik <gor@linux.ibm.com>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/s390/net/bpf_jit_comp.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/s390/net/bpf_jit_comp.c b/arch/s390/net/bpf_jit_comp.c
index a3ce1fdc3d802..2617e426c7926 100644
--- a/arch/s390/net/bpf_jit_comp.c
+++ b/arch/s390/net/bpf_jit_comp.c
@@ -1015,8 +1015,8 @@ static noinline int bpf_jit_insn(struct bpf_jit *jit, struct bpf_prog *fp, int i
 		/* llgf %w1,map.max_entries(%b2) */
 		EMIT6_DISP_LH(0xe3000000, 0x0016, REG_W1, REG_0, BPF_REG_2,
 			      offsetof(struct bpf_array, map.max_entries));
-		/* clgrj %b3,%w1,0xa,label0: if %b3 >= %w1 goto out */
-		EMIT6_PCREL_LABEL(0xec000000, 0x0065, BPF_REG_3,
+		/* clrj %b3,%w1,0xa,label0: if (u32)%b3 >= (u32)%w1 goto out */
+		EMIT6_PCREL_LABEL(0xec000000, 0x0077, BPF_REG_3,
 				  REG_W1, 0, 0xa);
 
 		/*
@@ -1042,8 +1042,10 @@ static noinline int bpf_jit_insn(struct bpf_jit *jit, struct bpf_prog *fp, int i
 		 *         goto out;
 		 */
 
-		/* sllg %r1,%b3,3: %r1 = index * 8 */
-		EMIT6_DISP_LH(0xeb000000, 0x000d, REG_1, BPF_REG_3, REG_0, 3);
+		/* llgfr %r1,%b3: %r1 = (u32) index */
+		EMIT4(0xb9160000, REG_1, BPF_REG_3);
+		/* sllg %r1,%r1,3: %r1 *= 8 */
+		EMIT6_DISP_LH(0xeb000000, 0x000d, REG_1, REG_1, REG_0, 3);
 		/* lg %r1,prog(%b2,%r1) */
 		EMIT6_DISP_LH(0xe3000000, 0x0004, REG_1, BPF_REG_2,
 			      REG_1, offsetof(struct bpf_array, ptrs));
-- 
2.20.1



