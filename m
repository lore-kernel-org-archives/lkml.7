Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEF34C43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 01:50:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90CF7206BA
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 01:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556329802;
	bh=tgmneZ/Rq6Q4TJJyBwSnDM24vNKJwKcUa1sW326uH8k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VohuMS4u6vNWM8bFKd7tjWzUvDyk7FHLtnvcB7QseV4f13/SmlYlKgklSG4ev8qmF
	 lZljor5dFZcmy8tbC5ohcjYNSNJ2OpNFXvBTbKq6C9xfYZ61SxvXVsdL9Mg8dy/uGr
	 XkfdsLqnM18X3021R3JOnx9RwH+TmeoAHzCG4Amo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728383AbfD0BuB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 21:50:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:45798 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727879AbfD0Bls (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 21:41:48 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 65FA121655;
        Sat, 27 Apr 2019 01:41:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556329308;
        bh=tgmneZ/Rq6Q4TJJyBwSnDM24vNKJwKcUa1sW326uH8k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RXq5DdquUuKmyQoApZZoNDmZOSWpfXrnrP2cISqI4Aynxt78xD8dK9rzquuhWQ0ef
         dD0avpNGO8NASBXHK3VzGSISx8bcg8/IKETuI1dr/3AIc/2kyD7d+avr8B6LbsR9Cv
         U9DYhMiM85hah2C5SI6Rdn2UO5IGvPe3oZqGkZe4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH AUTOSEL 4.19 33/53] powerpc/vdso32: fix CLOCK_MONOTONIC on PPC64
Date:   Fri, 26 Apr 2019 21:40:30 -0400
Message-Id: <20190427014051.7522-33-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190427014051.7522-1-sashal@kernel.org>
References: <20190427014051.7522-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christophe Leroy <christophe.leroy@c-s.fr>

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

