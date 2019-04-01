Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7107C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 18:01:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C8612084B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 18:01:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554141687;
	bh=1mXwuoEPMb509jPkM7JJV1MJV1qeBiI0giJP7UAnCIg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=z3JmcaGRKWl1O3fbzyDxuajzG0do+kDWBctRRkxqRimPsCXv7tsVLFSQ8PNjpOldY
	 zIZDiMwOSqIz4G3CeEdg6xN2HEM1051HI1hC7/RvgjTrwrTwnJ4p+lj3NXvfzPH/bN
	 s+o5VbeOoywjQVmJylulnY1n+E2jRgG5icZNgcMM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731273AbfDASB0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 14:01:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:40882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730964AbfDARQD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:16:03 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1ABE720856;
        Mon,  1 Apr 2019 17:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554138962;
        bh=1mXwuoEPMb509jPkM7JJV1MJV1qeBiI0giJP7UAnCIg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SlqqCnjxJ7oj/nave/EEEfncmGWsdNT/mVTsiY14+1G0YrFhmnIHRKxA+Qlmfo4LB
         I68RD0/bdDn9BmGm4uNkdYYkLtnbOFHRU0xNjGgjpZid9hUKRbb2ToOGqt/dP+ry4u
         eQgFMJF1rT9mcWMU3jwgLP/tQBRgYOSu2VzFo4YE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Diana Craciun <diana.craciun@nxp.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 4.19 034/134] powerpc/fsl: Add macro to flush the branch predictor
Date:   Mon,  1 Apr 2019 19:01:10 +0200
Message-Id: <20190401170047.933671848@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170044.243719205@linuxfoundation.org>
References: <20190401170044.243719205@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Diana Craciun <diana.craciun@nxp.com>

commit 1cbf8990d79ff69da8ad09e8a3df014e1494462b upstream.

The BUCSR register can be used to invalidate the entries in the
branch prediction mechanisms.

Signed-off-by: Diana Craciun <diana.craciun@nxp.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/powerpc/include/asm/ppc_asm.h |   10 ++++++++++
 1 file changed, 10 insertions(+)

--- a/arch/powerpc/include/asm/ppc_asm.h
+++ b/arch/powerpc/include/asm/ppc_asm.h
@@ -821,4 +821,14 @@ END_FTR_SECTION_IFCLR(CPU_FTR_601)
 	stringify_in_c(.long (_target) - . ;)	\
 	stringify_in_c(.previous)
 
+#ifdef CONFIG_PPC_FSL_BOOK3E
+#define BTB_FLUSH(reg)			\
+	lis reg,BUCSR_INIT@h;		\
+	ori reg,reg,BUCSR_INIT@l;	\
+	mtspr SPRN_BUCSR,reg;		\
+	isync;
+#else
+#define BTB_FLUSH(reg)
+#endif /* CONFIG_PPC_FSL_BOOK3E */
+
 #endif /* _ASM_POWERPC_PPC_ASM_H */


