Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C7F3C43215
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 10:55:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 267462071F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 10:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574420157;
	bh=+MDVunTPEMMpFv/BUNtzZS6Dddws/K6pUWQKAluF6Go=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IQmJzJNtTvwVKC5ZX7f1uI4j0JkPCfOITxW5J1LxTom4nADk9zgMjrdIcdt3kv5tU
	 HcKhSocDO/Op8fZd8jdPjjQSBMzNAoTFHr8GYl5NF/gwl6O1QIsjr+7fmUBY2p+BBh
	 2tjztKLBBw4jHx8m2xJNa3TF4SuTlAfAhjgz2MrI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730526AbfKVKz4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 05:55:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:43108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730008AbfKVKzv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 05:55:51 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 478AF20718;
        Fri, 22 Nov 2019 10:55:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574420150;
        bh=+MDVunTPEMMpFv/BUNtzZS6Dddws/K6pUWQKAluF6Go=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OdhyE+vkLyEvTJ+f2KVMIiTpstK3De+PavoLNpuTZvGza05VnIQx0O4GHLG0yc+dI
         1OO5kaLOHT621CGLPtTBVIZNaDMtJRyfMsGZrWzjT8BF2oQNqeloMCyX3hP0qiRzQ7
         Ev3BaVMuoalJSvNPY3yJnQHS4qzJWAAl2vCmb3Lw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Wang YanQing <udknight@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH 4.19 011/220] bpf, x32: Fix bug for BPF_ALU64 | BPF_NEG
Date:   Fri, 22 Nov 2019 11:26:16 +0100
Message-Id: <20191122100913.448861318@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191122100912.732983531@linuxfoundation.org>
References: <20191122100912.732983531@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wang YanQing <udknight@gmail.com>

commit b9aa0b35d878dff9ed19f94101fe353a4de00cc4 upstream.

The current implementation has two errors:

1: The second xor instruction will clear carry flag which
   is necessary for following sbb instruction.
2: The select coding for sbb instruction is wrong, the coding
   is "sbb dreg_hi,ecx", but what we need is "sbb ecx,dreg_hi".

This patch rewrites the implementation and fixes the errors.

This patch fixes below errors reported by bpf/test_verifier in x32
platform when the jit is enabled:

"
0: (b4) w1 = 4
1: (b4) w2 = 4
2: (1f) r2 -= r1
3: (4f) r2 |= r1
4: (87) r2 = -r2
5: (c7) r2 s>>= 63
6: (5f) r1 &= r2
7: (bf) r0 = r1
8: (95) exit
processed 9 insns (limit 131072), stack depth 0
0: (b4) w1 = 4
1: (b4) w2 = 4
2: (1f) r2 -= r1
3: (4f) r2 |= r1
4: (87) r2 = -r2
5: (c7) r2 s>>= 63
6: (5f) r1 &= r2
7: (bf) r0 = r1
8: (95) exit
processed 9 insns (limit 131072), stack depth 0
......
Summary: 1189 PASSED, 125 SKIPPED, 15 FAILED
"

Signed-off-by: Wang YanQing <udknight@gmail.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/net/bpf_jit_comp32.c |   19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

--- a/arch/x86/net/bpf_jit_comp32.c
+++ b/arch/x86/net/bpf_jit_comp32.c
@@ -698,19 +698,12 @@ static inline void emit_ia32_neg64(const
 		      STACK_VAR(dst_hi));
 	}
 
-	/* xor ecx,ecx */
-	EMIT2(0x31, add_2reg(0xC0, IA32_ECX, IA32_ECX));
-	/* sub dreg_lo,ecx */
-	EMIT2(0x2B, add_2reg(0xC0, dreg_lo, IA32_ECX));
-	/* mov dreg_lo,ecx */
-	EMIT2(0x89, add_2reg(0xC0, dreg_lo, IA32_ECX));
-
-	/* xor ecx,ecx */
-	EMIT2(0x31, add_2reg(0xC0, IA32_ECX, IA32_ECX));
-	/* sbb dreg_hi,ecx */
-	EMIT2(0x19, add_2reg(0xC0, dreg_hi, IA32_ECX));
-	/* mov dreg_hi,ecx */
-	EMIT2(0x89, add_2reg(0xC0, dreg_hi, IA32_ECX));
+	/* neg dreg_lo */
+	EMIT2(0xF7, add_1reg(0xD8, dreg_lo));
+	/* adc dreg_hi,0x0 */
+	EMIT3(0x83, add_1reg(0xD0, dreg_hi), 0x00);
+	/* neg dreg_hi */
+	EMIT2(0xF7, add_1reg(0xD8, dreg_hi));
 
 	if (dstk) {
 		/* mov dword ptr [ebp+off],dreg_lo */


