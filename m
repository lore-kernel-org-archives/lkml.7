Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 261EBC49ED7
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 22:24:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0E8621D79
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 22:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568931853;
	bh=TELwY7OlCOCI4eSmoimyIpgGxWsKQxb8Ou88hpFh3io=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MTk/H+ItNkMumuo8Fqq2BgWcQq7YZd6Zn4NdhxI0DqFzfVvLVvw773Ih/suIFNM9E
	 pnjfySIxiDwBDA1FNTwSoYCZ56vAjBvfQ30X1dFmo0daw2hv9feBS3MQFVJfRw20sv
	 XwLWWLAyq2r6BHgZmoufKjxVKYFyv0QhzKLYjMc4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407132AbfISWYM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 18:24:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:40184 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407111AbfISWYH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 18:24:07 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B477520678;
        Thu, 19 Sep 2019 22:24:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568931847;
        bh=TELwY7OlCOCI4eSmoimyIpgGxWsKQxb8Ou88hpFh3io=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gEk6leaOxi/hMzwk5Sl4GxoJgzcIM2CYxgA+aPIHkpXpY8mknP50UTLDU8//ecp2m
         v3kKn8F8/6XXY65XBZ2wQV1cOerIoy4Sgc0Jd5XjEgV6ADCEdusfqqLH/zVR2wE5ew
         fOMpcqrBeoxT8g2FtoMQpYntBHWgQSUDtujxADUI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Yauheni Kaliuta <yauheni.kaliuta@redhat.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 37/56] s390/bpf: use 32-bit index for tail calls
Date:   Fri, 20 Sep 2019 00:04:18 +0200
Message-Id: <20190919214758.200709915@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190919214742.483643642@linuxfoundation.org>
References: <20190919214742.483643642@linuxfoundation.org>
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
index e53d410e88703..bcf409997d6dc 100644
--- a/arch/s390/net/bpf_jit_comp.c
+++ b/arch/s390/net/bpf_jit_comp.c
@@ -1067,8 +1067,8 @@ static noinline int bpf_jit_insn(struct bpf_jit *jit, struct bpf_prog *fp, int i
 		/* llgf %w1,map.max_entries(%b2) */
 		EMIT6_DISP_LH(0xe3000000, 0x0016, REG_W1, REG_0, BPF_REG_2,
 			      offsetof(struct bpf_array, map.max_entries));
-		/* clgrj %b3,%w1,0xa,label0: if %b3 >= %w1 goto out */
-		EMIT6_PCREL_LABEL(0xec000000, 0x0065, BPF_REG_3,
+		/* clrj %b3,%w1,0xa,label0: if (u32)%b3 >= (u32)%w1 goto out */
+		EMIT6_PCREL_LABEL(0xec000000, 0x0077, BPF_REG_3,
 				  REG_W1, 0, 0xa);
 
 		/*
@@ -1094,8 +1094,10 @@ static noinline int bpf_jit_insn(struct bpf_jit *jit, struct bpf_prog *fp, int i
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



