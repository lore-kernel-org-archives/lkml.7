Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2B74C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:22:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAF692054F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:22:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553257321;
	bh=gUovc59oY1wd9o/1FxlSR6Wqxmm9DD6HT3jwzfmMW88=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=u/p7P360gNSWVTPwutgvUeqW+ab+laCJ0XrRTA174ffJrLDnHBFwHhknQ5OikxY/N
	 SQRbHpPAyWqYGDKfRlNtZfp1NkhC5j0xY3AbgW+kfPGLPfDB+b496LBw2W8R2lwJlo
	 kGyRQnArvf62XRpBmdNez9vJU5Xrs8l2h5dKFj7c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390514AbfCVMWA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:22:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:32838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390442AbfCVMVx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:21:53 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 25B39218B0;
        Fri, 22 Mar 2019 12:21:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553257312;
        bh=gUovc59oY1wd9o/1FxlSR6Wqxmm9DD6HT3jwzfmMW88=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eZ/0wxXfKyEok+d+feBCmtHerDrsZT1S9ZVEuUDl8HRO3LPE7gHDJWbvpvCuCqvf3
         MXhm7YnjBODlYUTOQggRz7HZfFkBN587rtTpxMY/N6OhY9s2SNdE3UQMY2zk9sOzeH
         tWvywtiigvlbiwfnUbBntJ49vpVSEolFMG3SYD0k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 5.0 162/238] powerpc/64s/hash: Fix assert_slb_presence() use of the slbfee. instruction
Date:   Fri, 22 Mar 2019 12:16:21 +0100
Message-Id: <20190322111307.859747886@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111258.383569278@linuxfoundation.org>
References: <20190322111258.383569278@linuxfoundation.org>
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

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nicholas Piggin <npiggin@gmail.com>

commit 7104dccfd052fde51eecc9972dad9c40bd3e0d11 upstream.

The slbfee. instruction must have bit 24 of RB clear, failure to do
so can result in false negatives that result in incorrect assertions.

This is not obvious from the ISA v3.0B document, which only says:

    The hardware ignores the contents of RB 36:38 40:63 -- p.1032

This patch fixes the bug and also clears all other bits from PPC bit
36-63, which is good practice when dealing with reserved or ignored
bits.

Fixes: e15a4fea4dee ("powerpc/64s/hash: Add some SLB debugging tests")
Cc: stable@vger.kernel.org # v4.20+
Reported-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Tested-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/powerpc/mm/slb.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/arch/powerpc/mm/slb.c
+++ b/arch/powerpc/mm/slb.c
@@ -69,6 +69,11 @@ static void assert_slb_presence(bool pre
 	if (!cpu_has_feature(CPU_FTR_ARCH_206))
 		return;
 
+	/*
+	 * slbfee. requires bit 24 (PPC bit 39) be clear in RB. Hardware
+	 * ignores all other bits from 0-27, so just clear them all.
+	 */
+	ea &= ~((1UL << 28) - 1);
 	asm volatile(__PPC_SLBFEE_DOT(%0, %1) : "=r"(tmp) : "r"(ea) : "cr0");
 
 	WARN_ON(present == (tmp == 0));


