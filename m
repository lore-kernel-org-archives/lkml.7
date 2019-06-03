Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAA45C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 13:41:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4D9027BB3
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 13:41:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="SoxBGPZT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728919AbfFCNlW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 09:41:22 -0400
Received: from terminus.zytor.com ([198.137.202.136]:54363 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727506AbfFCNlW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 09:41:22 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x53Df6W7611879
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 3 Jun 2019 06:41:06 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x53Df6W7611879
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1559569267;
        bh=ugDYpScCfry1yiNAFZlLVJ4QEvVOEsD3LZccOBLSkX8=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=SoxBGPZTTDREtENOcZoKx+JKfwOJaSpK/84csvKlXaWf6KpMQlwFT6w0Wa+HOr7P0
         4cF06h6SDVJM/SqH/WTNOSxB90YBSyYIroqU/lgRMNoB97/1K8VyfYld7mXiExA+kI
         NSuT/GvZu2QdYhbx3qJ2CQzU/6UTtUcnTvd3BhEbNy2RHQRVyq+/RhpmQNdMalUZnz
         kgBfFsouVAFiUcfS/JbBTvpP4612fHldDexBMU5PW+OQ8gBP4ew+TCfIF0tQvHYrIv
         eEpb2GW2vNdGytj8EeO/HvY2ftKc8dZDyAJcYQpz+SANJ4RaN/HG03EOuVsf3NNdWE
         /qv1V3QvItU9A==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x53Df6of611876;
        Mon, 3 Jun 2019 06:41:06 -0700
Date:   Mon, 3 Jun 2019 06:41:06 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Mark Rutland <tipbot@zytor.com>
Message-ID: <tip-33e42ef571979fe6601ac838d338eb599d842a6d@git.kernel.org>
Cc:     tglx@linutronix.de, peterz@infradead.org, will.deacon@arm.com,
        hpa@zytor.com, palmer@sifive.com, mingo@kernel.org,
        mark.rutland@arm.com, torvalds@linux-foundation.org,
        aou@eecs.berkeley.edu, linux-kernel@vger.kernel.org
Reply-To: tglx@linutronix.de, hpa@zytor.com, palmer@sifive.com,
          peterz@infradead.org, will.deacon@arm.com, mark.rutland@arm.com,
          mingo@kernel.org, aou@eecs.berkeley.edu,
          linux-kernel@vger.kernel.org, torvalds@linux-foundation.org
In-Reply-To: <20190522132250.26499-12-mark.rutland@arm.com>
References: <20190522132250.26499-12-mark.rutland@arm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] locking/atomic, riscv: Fix
 atomic64_sub_if_positive() offset argument
Git-Commit-ID: 33e42ef571979fe6601ac838d338eb599d842a6d
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  33e42ef571979fe6601ac838d338eb599d842a6d
Gitweb:     https://git.kernel.org/tip/33e42ef571979fe6601ac838d338eb599d842a6d
Author:     Mark Rutland <mark.rutland@arm.com>
AuthorDate: Wed, 22 May 2019 14:22:43 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 3 Jun 2019 12:32:56 +0200

locking/atomic, riscv: Fix atomic64_sub_if_positive() offset argument

Presently the riscv implementation of atomic64_sub_if_positive() takes
a 32-bit offset value rather than a 64-bit offset value as it should do.
Thus, if called with a 64-bit offset, the value will be unexpectedly
truncated to 32 bits.

Fix this by taking the offset as a long rather than an int.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
Cc: Albert Ou <aou@eecs.berkeley.edu>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will.deacon@arm.com>
Cc: arnd@arndb.de
Cc: bp@alien8.de
Cc: catalin.marinas@arm.com
Cc: davem@davemloft.net
Cc: fenghua.yu@intel.com
Cc: heiko.carstens@de.ibm.com
Cc: herbert@gondor.apana.org.au
Cc: ink@jurassic.park.msu.ru
Cc: jhogan@kernel.org
Cc: linux@armlinux.org.uk
Cc: mattst88@gmail.com
Cc: mpe@ellerman.id.au
Cc: paul.burton@mips.com
Cc: paulus@samba.org
Cc: ralf@linux-mips.org
Cc: rth@twiddle.net
Cc: tony.luck@intel.com
Cc: vgupta@synopsys.com
Link: https://lkml.kernel.org/r/20190522132250.26499-12-mark.rutland@arm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/riscv/include/asm/atomic.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/include/asm/atomic.h b/arch/riscv/include/asm/atomic.h
index 9038aeb900a6..9c263bd9d5ad 100644
--- a/arch/riscv/include/asm/atomic.h
+++ b/arch/riscv/include/asm/atomic.h
@@ -332,7 +332,7 @@ static __always_inline int atomic_sub_if_positive(atomic_t *v, int offset)
 #define atomic_dec_if_positive(v)	atomic_sub_if_positive(v, 1)
 
 #ifndef CONFIG_GENERIC_ATOMIC64
-static __always_inline long atomic64_sub_if_positive(atomic64_t *v, int offset)
+static __always_inline long atomic64_sub_if_positive(atomic64_t *v, long offset)
 {
        long prev, rc;
 
