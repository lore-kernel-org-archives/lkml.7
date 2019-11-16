Return-Path: <SRS0=try7=ZI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BFA4C432C3
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 16:20:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 094D921479
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 16:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573921209;
	bh=pDHn+HksLh2BBFaUeCFU7cSKTlRwKXjRdFc2nsgwYLw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BT34L3KTpDKb3U9BGjaKwu+dSt7w+vZiHWS0qFp4lNEAiQwXjyj1J0FtOyM6FyLe1
	 QMF22j2iqb96G2DDwGmcNy7zM9fuFiuQlgt1thDwIbnYIlB8UTM5REJ986C+162DN1
	 gYjxDnmFXWvbhoQRhLsh7A5H88yIVDkaQ+iJlIJc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729062AbfKPPoq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Nov 2019 10:44:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:49744 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728105AbfKPPol (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Nov 2019 10:44:41 -0500
Received: from sasha-vm.mshome.net (unknown [50.234.116.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 034392072D;
        Sat, 16 Nov 2019 15:44:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573919081;
        bh=pDHn+HksLh2BBFaUeCFU7cSKTlRwKXjRdFc2nsgwYLw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ecYt9noIbwejYJ5IRSz1ANQCSV7hvS1R6whPlewxDX/pU1DUY5XacdLgotDylIQk6
         6Z+LYFUnpbUkIb/RD7GHLvBRi4uD2sUdQ3N4Au2LA6HAgn99RTww5wbPozCl8B5J3L
         ZUb2CsUk6GA0F9bfJfJ/TmwLPIb0mJovAPWtkdZI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>, linuxppc-dev@lists.ozlabs.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 146/237] selftests/powerpc/switch_endian: Fix out-of-tree build
Date:   Sat, 16 Nov 2019 10:39:41 -0500
Message-Id: <20191116154113.7417-146-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191116154113.7417-1-sashal@kernel.org>
References: <20191116154113.7417-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Ellerman <mpe@ellerman.id.au>

[ Upstream commit 266bac361d5677e61a6815bd29abeb3bdced2b07 ]

For the out-of-tree build to work we need to tell switch_endian_test
to look for check-reversed.S in $(OUTPUT).

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/powerpc/switch_endian/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/powerpc/switch_endian/Makefile b/tools/testing/selftests/powerpc/switch_endian/Makefile
index fcd2dcb8972ba..bdc081afedb0f 100644
--- a/tools/testing/selftests/powerpc/switch_endian/Makefile
+++ b/tools/testing/selftests/powerpc/switch_endian/Makefile
@@ -8,6 +8,7 @@ EXTRA_CLEAN = $(OUTPUT)/*.o $(OUTPUT)/check-reversed.S
 top_srcdir = ../../../../..
 include ../../lib.mk
 
+$(OUTPUT)/switch_endian_test: ASFLAGS += -I $(OUTPUT)
 $(OUTPUT)/switch_endian_test: $(OUTPUT)/check-reversed.S
 
 $(OUTPUT)/check-reversed.o: $(OUTPUT)/check.o
-- 
2.20.1

