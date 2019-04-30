Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF56BC43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 12:02:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B73D32075E
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 12:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556625744;
	bh=yYIENNpEJtEjRnvVz1tLUNu+L22UX2sQTB90+e5KDos=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Ln314Hitc7ptxaEfD2AflTOsR/DfNa9Fuv3Okj6hLYyx2dwkThF7B/NAFvHXNTw4M
	 QrKNHV3ucXeHq2EZbFQZvMSoAbr1Es+YZcDIy0hcwvQ9QXNi005BXSq2CMyLvlo2Sk
	 oeMx91wO9AsG+tv8wbee5B+LuAq5+xkySPd+z8Po=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730103AbfD3LoK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 07:44:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:55116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728168AbfD3LoI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 07:44:08 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F395321670;
        Tue, 30 Apr 2019 11:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556624648;
        bh=yYIENNpEJtEjRnvVz1tLUNu+L22UX2sQTB90+e5KDos=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xL69sAz5rNNKTr/afl5ZhHecIP6HnDjXma465CkZMd3ft4QC1AsF6aeunOgmS0jrw
         YdJuRaA1YOAA84n7DZN0pCo0zEKDcX6MH30ZWb5/J2P+62LQHh2/F2uXJG2jFJEx9D
         XjuLsSbuZ7/p1CWmIMdsrDHmi5Ypvgja2MEH6hu0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Christian Zigotzky <chzigotzky@xenosoft.de>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 020/100] powerpc/vdso32: fix CLOCK_MONOTONIC on PPC64
Date:   Tue, 30 Apr 2019 13:37:49 +0200
Message-Id: <20190430113609.817538809@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190430113608.616903219@linuxfoundation.org>
References: <20190430113608.616903219@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit dd9a994fc68d196a052b73747e3366c57d14a09e ]

Commit b5b4453e7912 ("powerpc/vdso64: Fix CLOCK_MONOTONIC
inconsistencies across Y2038") changed the type of wtom_clock_sec
to s64 on PPC64. Therefore, VDSO32 needs to read it with a 4 bytes
shift in order to retrieve the lower part of it.

Fixes: b5b4453e7912 ("powerpc/vdso64: Fix CLOCK_MONOTONIC inconsistencies across Y2038")
Reported-by: Christian Zigotzky <chzigotzky@xenosoft.de>
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/kernel/vdso32/gettimeofday.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/vdso32/gettimeofday.S b/arch/powerpc/kernel/vdso32/gettimeofday.S
index 769c2624e0a6..75cff3f336b3 100644
--- a/arch/powerpc/kernel/vdso32/gettimeofday.S
+++ b/arch/powerpc/kernel/vdso32/gettimeofday.S
@@ -98,7 +98,7 @@ V_FUNCTION_BEGIN(__kernel_clock_gettime)
 	 * can be used, r7 contains NSEC_PER_SEC.
 	 */
 
-	lwz	r5,WTOM_CLOCK_SEC(r9)
+	lwz	r5,(WTOM_CLOCK_SEC+LOPART)(r9)
 	lwz	r6,WTOM_CLOCK_NSEC(r9)
 
 	/* We now have our offset in r5,r6. We create a fake dependency
-- 
2.19.1



