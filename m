Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92843C4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 08:39:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6163121920
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 08:39:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570696750;
	bh=zCNBAvfBC2GkCrSrnVZbh81b4yRACjXiRWvWQuy7CBc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cO0zxgCmnmwP1tkH/MkSqS04K4mRgibc7wUIjpCduVMv0z9nVrreeWLSn9D8CoAVw
	 Gn8goMtAT03BGoRrO3fXX+zKSirxZ+hPRCv7kJcfhvJrv1K0kqH8iyKbfL49aRLPCE
	 95Z+WBRakQ5ryRtl7qRyfRBuI9sFBeB1Pyeuw2gk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387793AbfJJIjJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 04:39:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:42324 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387767AbfJJIjG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 04:39:06 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4D48D20B7C;
        Thu, 10 Oct 2019 08:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570696745;
        bh=zCNBAvfBC2GkCrSrnVZbh81b4yRACjXiRWvWQuy7CBc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AFUsE56+kKc201824jywSAyew612qaWxLHW7dn9+TsQZTQJkD4Z8cpNxy/ftVjXn9
         CK2tVtkjtFRYuoDHBPTPzBLWVJan8EGgN09oWLlNie5gKseul3Ig67hU3jRSsuI8uv
         FSfNys7j6eO9fCFDifQp41t1rBJG+Twi/eVXWJvk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Subject: [PATCH 5.3 009/148] KVM: s390: fix __insn32_query() inline assembly
Date:   Thu, 10 Oct 2019 10:34:30 +0200
Message-Id: <20191010083611.628970243@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191010083609.660878383@linuxfoundation.org>
References: <20191010083609.660878383@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Carstens <heiko.carstens@de.ibm.com>

commit b1c41ac3ce569b04644bb1e3fd28926604637da3 upstream.

The inline assembly constraints of __insn32_query() tell the compiler
that only the first byte of "query" is being written to. Intended was
probably that 32 bytes are written to.

Fix and simplify the code and just use a "memory" clobber.

Fixes: d668139718a9 ("KVM: s390: provide query function for instructions returning 32 byte")
Cc: stable@vger.kernel.org # v5.2+
Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/s390/kvm/kvm-s390.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -332,7 +332,7 @@ static inline int plo_test_bit(unsigned
 	return cc == 0;
 }
 
-static inline void __insn32_query(unsigned int opcode, u8 query[32])
+static inline void __insn32_query(unsigned int opcode, u8 *query)
 {
 	register unsigned long r0 asm("0") = 0;	/* query function */
 	register unsigned long r1 asm("1") = (unsigned long) query;
@@ -340,9 +340,9 @@ static inline void __insn32_query(unsign
 	asm volatile(
 		/* Parameter regs are ignored */
 		"	.insn	rrf,%[opc] << 16,2,4,6,0\n"
-		: "=m" (*query)
+		:
 		: "d" (r0), "a" (r1), [opc] "i" (opcode)
-		: "cc");
+		: "cc", "memory");
 }
 
 #define INSN_SORTL 0xb938


