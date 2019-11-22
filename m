Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFEF5C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 05:51:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E1DB2071F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 05:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574401878;
	bh=SU3bXKKx/dkgHEj3sTW+zNMTS0vgQmlPDlzLKapDzcE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fmxzng8d5YoasfX2QFOLblvRJtTkM5OuCDJoNE/gO6ccSN2L4DZuo2ufoIzf8TAMb
	 dRaOTmnraFwZ+Pn2LfHcNeKCwvaa7PlTHIt4FswjmshO11hgao6fNlex8EaFrQhbsZ
	 i0RF6ze5y6F8QK3HBPW15lvj0m4ObwkS7JUeBuA0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728080AbfKVFvR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 00:51:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:56132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728041AbfKVFvM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 00:51:12 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 134F42070E;
        Fri, 22 Nov 2019 05:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574401871;
        bh=SU3bXKKx/dkgHEj3sTW+zNMTS0vgQmlPDlzLKapDzcE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=diaJxDVtLqpyIucblmwEu0/+vDFy/OM8N8VrgtP05l5z+4f29FSq2XvhJvBcTLRPO
         UXlpILTr6n+LYKXU5qqPfqqQrj49FePEdAgRpkp/5gbtQ+a92EsslIyVwR0rhDbKgX
         P254A9C8Vx2lXcVMdqaF2lKmaDs8mMnnDYKvi/dM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH AUTOSEL 4.19 107/219] powerpc/xmon: fix dump_segments()
Date:   Fri, 22 Nov 2019 00:47:19 -0500
Message-Id: <20191122054911.1750-100-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191122054911.1750-1-sashal@kernel.org>
References: <20191122054911.1750-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christophe Leroy <christophe.leroy@c-s.fr>

[ Upstream commit 32c8c4c621897199e690760c2d57054f8b84b6e6 ]

mfsrin() takes segment num from bits 31-28 (IBM bits 0-3).

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
[mpe: Clarify bit numbering]
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/xmon/xmon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index bb5db7bfd8539..f0fa22e7d36c7 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -3493,7 +3493,7 @@ void dump_segments(void)
 
 	printf("sr0-15 =");
 	for (i = 0; i < 16; ++i)
-		printf(" %x", mfsrin(i));
+		printf(" %x", mfsrin(i << 28));
 	printf("\n");
 }
 #endif
-- 
2.20.1

