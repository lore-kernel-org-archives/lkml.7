Return-Path: <SRS0=Dm7n=X7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46BD4C4360C
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 17:48:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DAE722486
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 17:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570384128;
	bh=47e/QRH3Lx+tLsLUboT3gBgack0Ca/VqP2tRR39YmZo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Ak9TuIYsE3E2ZUu5GGlW/hzwUy+XQflsjUf+JyktDU1+yNJjQgIQVVWCOE5mNoO07
	 w01VV4Vsvi1cbZyn+xDfoNdi9lFgCxiuvOblniZ5YtqWp8GwM7thT7Zus1Na8B5jnK
	 n0Wf/4wIJXPEBz/fUIUSGCqX78ra/Ap02t8V3Of8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730635AbfJFRnE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Oct 2019 13:43:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:42864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731409AbfJFRm4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 13:42:56 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B4822133F;
        Sun,  6 Oct 2019 17:42:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570383776;
        bh=47e/QRH3Lx+tLsLUboT3gBgack0Ca/VqP2tRR39YmZo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BYlGy27drSLuXjUCMbyF8RtX1XcTbSR+HSNomSacpeDP925p4NAOBK1ddvJnFdzAO
         IGF3rU88q8Ddsof6YIarq4ilAoBhTAeWqAhN7hMIEK9nXsWjeq9aPcHOU7GKdbfQaC
         qVdGUB6z4mCRg9Xe6YKaqHGHIvvqJcobxXQfSfx0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>,
        Paul Burton <paul.burton@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-mips@vger.kernel.org, clang-built-linux@googlegroups.com,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.3 084/166] MIPS: tlbex: Explicitly cast _PAGE_NO_EXEC to a boolean
Date:   Sun,  6 Oct 2019 19:20:50 +0200
Message-Id: <20191006171220.578235842@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191006171212.850660298@linuxfoundation.org>
References: <20191006171212.850660298@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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



