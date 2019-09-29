Return-Path: <SRS0=maO4=XY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28BE6C4360C
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 17:31:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F16CA21920
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 17:31:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569778272;
	bh=47e/QRH3Lx+tLsLUboT3gBgack0Ca/VqP2tRR39YmZo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kDqPo3L+Qk/se7gJz+pq3lULrFV/rnqJZekARAsWicn4LKzN5oYHAGx/BtXCgVg/S
	 ogEF8HO3UaD1Hm1hk10eSFUNPuIBSVDnHkuG1P0idDBs7mN3lUVwH+yq0ws042lPXk
	 G1RCflm1SXJRiWGe3BEi2tfo660k99cbGwqO9lQY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729164AbfI2RbI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Sep 2019 13:31:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:41498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726149AbfI2RbH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Sep 2019 13:31:07 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9DFAE218AC;
        Sun, 29 Sep 2019 17:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569778266;
        bh=47e/QRH3Lx+tLsLUboT3gBgack0Ca/VqP2tRR39YmZo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FrNuFjbKSxQ81nu/aUXxgb8NEH17c/9b+Eb8QakPhmX4cBq4N/xOeJztBWL1SGZhy
         svTq9FAUm6GctjvNO7P/vB//ZIifImuxXh+0hSAObmdTI7U54ZMwKN6VcWYF0xXFkz
         t1cwROUyECF8uyFgLLFfouk7sOUZP0/WEw9mVEBU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Paul Burton <paul.burton@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-mips@vger.kernel.org, clang-built-linux@googlegroups.com,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.3 04/49] MIPS: tlbex: Explicitly cast _PAGE_NO_EXEC to a boolean
Date:   Sun, 29 Sep 2019 13:30:04 -0400
Message-Id: <20190929173053.8400-4-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190929173053.8400-1-sashal@kernel.org>
References: <20190929173053.8400-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nathan Chancellor <natechancellor@gmail.com>

[ Upstream commit c59ae0a1055127dd3828a88e111a0db59b254104 ]

clang warns:

arch/mips/mm/tlbex.c:634:19: error: use of logical '&&' with constant
operand [-Werror,-Wconstant-logical-operand]
        if (cpu_has_rixi && _PAGE_NO_EXEC) {
                         ^  ~~~~~~~~~~~~~
arch/mips/mm/tlbex.c:634:19: note: use '&' for a bitwise operation
        if (cpu_has_rixi && _PAGE_NO_EXEC) {
                         ^~
                         &
arch/mips/mm/tlbex.c:634:19: note: remove constant to silence this
warning
        if (cpu_has_rixi && _PAGE_NO_EXEC) {
                        ~^~~~~~~~~~~~~~~~
1 error generated.

Explicitly cast this value to a boolean so that clang understands we
intend for this to be a non-zero value.

Fixes: 00bf1c691d08 ("MIPS: tlbex: Avoid placing software PTE bits in Entry* PFN fields")
Link: https://github.com/ClangBuiltLinux/linux/issues/609
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Paul Burton <paul.burton@mips.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: James Hogan <jhogan@kernel.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: linux-mips@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: clang-built-linux@googlegroups.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/mips/mm/tlbex.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
index 144ceb0fba88f..bece1264d1c5a 100644
--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -631,7 +631,7 @@ static __maybe_unused void build_convert_pte_to_entrylo(u32 **p,
 		return;
 	}
 
-	if (cpu_has_rixi && _PAGE_NO_EXEC) {
+	if (cpu_has_rixi && !!_PAGE_NO_EXEC) {
 		if (fill_includes_sw_bits) {
 			UASM_i_ROTR(p, reg, reg, ilog2(_PAGE_GLOBAL));
 		} else {
-- 
2.20.1

