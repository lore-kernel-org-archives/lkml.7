Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3DBAC10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 18:46:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C036E218A1
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 18:46:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555354010;
	bh=SdZnkIgo4A0HaLXGSM4Nlg+ICex1cVEcKZmaTns+hMM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Gv5o4iT0JudMgHG8A7truyV1w6iwXH75B/nOOPYVEWavEKI1tc3XH0PZT/oZFBOIi
	 CF8dCSR6fQEByamV0h2wSYfN6PdvAsfIhcIJd0HaI9gvvXa88QwDSQf63DdTa9K32d
	 kycPEcXdsGXvWbao3Wj0q38vP2AOmUpMXhZxNBoA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728685AbfDOSqn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 14:46:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:49402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728662AbfDOSqi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 14:46:38 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 886172073F;
        Mon, 15 Apr 2019 18:46:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555353998;
        bh=SdZnkIgo4A0HaLXGSM4Nlg+ICex1cVEcKZmaTns+hMM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PJbq/JGvkuMyxupj300uMLbZbx/vB/qg7ha+SjSGhHSy/mAjw3CF9a60S1SbZCF+Y
         igVYK5bT7vE4vGfvcNuc5Dn+Va7d5CmqFANKDI5utHp+eahka4arnMNceFstja3xvB
         OBKMeop5JAiYLUUS3frI6eoWa8RnIYAgdhblCfGA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Diana Craciun <diana.craciun@nxp.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 33/76] powerpc/fsl: Add macro to flush the branch predictor
Date:   Mon, 15 Apr 2019 20:43:57 +0200
Message-Id: <20190415183716.189589453@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190415183707.712011689@linuxfoundation.org>
References: <20190415183707.712011689@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 1cbf8990d79ff69da8ad09e8a3df014e1494462b upstream.

The BUCSR register can be used to invalidate the entries in the
branch prediction mechanisms.

Signed-off-by: Diana Craciun <diana.craciun@nxp.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/include/asm/ppc_asm.h | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/powerpc/include/asm/ppc_asm.h b/arch/powerpc/include/asm/ppc_asm.h
index 24e95be3bfaf..bbd35ba36a22 100644
--- a/arch/powerpc/include/asm/ppc_asm.h
+++ b/arch/powerpc/include/asm/ppc_asm.h
@@ -780,4 +780,25 @@ END_FTR_SECTION_IFCLR(CPU_FTR_601)
 	.long 0x2400004c  /* rfid				*/
 #endif /* !CONFIG_PPC_BOOK3E */
 #endif /*  __ASSEMBLY__ */
+
+/*
+ * Helper macro for exception table entries
+ */
+#define EX_TABLE(_fault, _target)		\
+	stringify_in_c(.section __ex_table,"a";)\
+	stringify_in_c(.balign 4;)		\
+	stringify_in_c(.long (_fault) - . ;)	\
+	stringify_in_c(.long (_target) - . ;)	\
+	stringify_in_c(.previous)
+
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
-- 
2.19.1



