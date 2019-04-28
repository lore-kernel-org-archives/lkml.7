Return-Path: <SRS0=wfQU=S6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7BC4C43219
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 02:33:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9344B20881
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 02:33:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZBSt/SG+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbfD1Cdt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 22:33:49 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35628 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726112AbfD1Cdt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 22:33:49 -0400
Received: by mail-pg1-f194.google.com with SMTP id h1so3455536pgs.2;
        Sat, 27 Apr 2019 19:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:mime-version
         :content-disposition:user-agent;
        bh=8pdP/pIbSMTEUfQnT+0vcRdQjYsBt7dW9GatpOSe0b0=;
        b=ZBSt/SG+mbZSNJMGMysW1W8y1DcfuWBMt+y1GCEjXy45Ycibqoks6g1MWKq1/HxzMP
         bSlln+KNPYYYwpZv7PvIRsaW1DmrTKl7wOG2dRigldgxY0d5jg/rMNUa8Fttst7kmURM
         CgUVb7R6OqNx2s/1InmJ10P36fc9r5L1v0fh8M7V8kJYQWLtsIE2hWF/bfchdJBbJkSz
         2exaE1RAInpyMPe89byC/3o45z3ldMmNJDU4APVDKtcq7R9B33YH6Q3om2WeIawN9AeS
         wdn5FTbGhmPb5FbTpL2arESdEiGE5ja9ngXB/3d3oPy3E4NmVNqoDVPgclnYTf+7THQ2
         YnHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:mime-version:content-disposition:user-agent;
        bh=8pdP/pIbSMTEUfQnT+0vcRdQjYsBt7dW9GatpOSe0b0=;
        b=oHQqRSrreZ6ZdUk/2md3Qm7KUyTjOfZgxh9ZU9M6VDVeV1kuJSSnikQ0onKgVLMjHE
         NZZ4qJaW6Z4P6szvuqwVz7ruLLGBoQjog5UhL093gPuJqkQMxBBTpVLT5RJakYI/VzxE
         WSSPo1m4lvmm/fBkH8FAOWEKRwqZNa4j59zBEB/07Y0DKeGVfYv1lb1gDksRm1WtrVjU
         59A888kY0QRcQe2ympT9svfPDS5wlBeOel/bilk3s70bJEtqv3vDHb/PzIG6gOEBNHuo
         n1C4lUxaFg1g3+4yluf+cujC0B33HPWb5eyBeLyzxY5fJIGyvJmEP/8znw8ntM7ldy1P
         XshQ==
X-Gm-Message-State: APjAAAU3oYfCdyIkUtT88v53XutPQEb7/mIf0dBVi+bC1arAIKUFGbye
        FK8oqBewfPP9FT7YZI0ZxJg=
X-Google-Smtp-Source: APXvYqxZvLvOc3rGYU2DbViR+D8bUUYIlr9cbTBVek3/r2LkNuOFbboTkGmUNKlIo85ASnXVLCgCbQ==
X-Received: by 2002:a63:d512:: with SMTP id c18mr11227831pgg.252.1556418828679;
        Sat, 27 Apr 2019 19:33:48 -0700 (PDT)
Received: from udknight.localhost ([183.250.89.86])
        by smtp.gmail.com with ESMTPSA id l19sm39348312pff.1.2019.04.27.19.33.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 27 Apr 2019 19:33:48 -0700 (PDT)
Received: from udknight.localhost (localhost [127.0.0.1])
        by udknight.localhost (8.14.9/8.14.4) with ESMTP id x3S2XLSf029356;
        Sun, 28 Apr 2019 10:33:23 +0800
Received: (from root@localhost)
        by udknight.localhost (8.14.9/8.14.9/Submit) id x3S2X293029347;
        Sun, 28 Apr 2019 10:33:02 +0800
Date:   Sun, 28 Apr 2019 10:33:02 +0800
From:   Wang YanQing <udknight@gmail.com>
To:     daniel@iogearbox.net
Cc:     ast@kernel.org, davem@davemloft.net, kuznet@ms2.inr.ac.ru,
        tglx@linutronix.de, netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] bpf, x32: Fix bug for BPF_ALU64 | BPF_NEG
Message-ID: <20190428023302.GA29326@udknight>
Mail-Followup-To: Wang YanQing <udknight@gmail.com>, daniel@iogearbox.net,
        ast@kernel.org, davem@davemloft.net, kuznet@ms2.inr.ac.ru,
        tglx@linutronix.de, netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.7.1 (2016-10-04)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---
 arch/x86/net/bpf_jit_comp32.c | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp32.c b/arch/x86/net/bpf_jit_comp32.c
index 8097b88..b29e82f 100644
--- a/arch/x86/net/bpf_jit_comp32.c
+++ b/arch/x86/net/bpf_jit_comp32.c
@@ -700,19 +700,12 @@ static inline void emit_ia32_neg64(const u8 dst[], bool dstk, u8 **pprog)
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
-- 
1.8.5.6.2.g3d8a54e.dirty
