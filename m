Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D07C3C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:24:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 961BF2063F
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:24:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554139463;
	bh=D8ijYwnWzFGAD/bHfhcF37FI/dvhKFxp6cVlK4Y+DvI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OU5oFcGLPVGa1nKITZ9e/3/flAtHdilHepQRJhX6k4rHjie8Bc49SzA431lFlDAUM
	 iL40iB3f3kqDdIzl3piEPyCMy8fzw1gEwfvuLLBWhB3lDmpXkiGizt/4NODp/XYNVZ
	 +aPmn6ZAzgz5ca7uA9QVD9eUIh2WixA1lqlXxTq8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732248AbfDARYW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:24:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:54688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732236AbfDARYR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:24:17 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 320952063F;
        Mon,  1 Apr 2019 17:24:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554139456;
        bh=D8ijYwnWzFGAD/bHfhcF37FI/dvhKFxp6cVlK4Y+DvI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2l7+nHu0Q9iwasIZQ2HtpNVe1ahyowsbdf3xyoF1uPPS5AwGpreHV6eossSiwNnH+
         LLjxEfQmRXlsrZj5gmJZa/hd2iWwvThFxhUZnd8rxo6vDdbyK+ml+F822FlqjBBIug
         XQCraAFPkI1b2Vg6IawhZXEb7TWGvqo6JmkvGnRs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Diana Craciun <diana.craciun@nxp.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 4.14 044/107] powerpc/fsl: Add macro to flush the branch predictor
Date:   Mon,  1 Apr 2019 19:01:59 +0200
Message-Id: <20190401170049.635913900@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170045.246405031@linuxfoundation.org>
References: <20190401170045.246405031@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -802,4 +802,14 @@ END_FTR_SECTION_IFCLR(CPU_FTR_601)
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


