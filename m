Return-Path: <SRS0=try7=ZI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A486C432C3
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 15:41:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CC0220718
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 15:41:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573918891;
	bh=wtjYU+nHjHQOYZA/U7nBjkeTi8Gils3V5XygPliyQmI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UbVHxebIBfwxeE5l77VyyjKjbokY+9r7q5sU+ymqTs6wmYEdjiJOR4XKJWMZT3oie
	 /AvdalX+/CUhnqMlwlOpcvZSwXR6zFJU2lJ2ZsreBAnHHubTt7/njkrxdBIWDNijrJ
	 zrJ6nFD8olx+s4hkT30Viwm00l1Ksd1hi33eolvI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727883AbfKPPl3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Nov 2019 10:41:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:44456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727856AbfKPPlY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Nov 2019 10:41:24 -0500
Received: from sasha-vm.mshome.net (unknown [50.234.116.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2926020730;
        Sat, 16 Nov 2019 15:41:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573918884;
        bh=wtjYU+nHjHQOYZA/U7nBjkeTi8Gils3V5XygPliyQmI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Cb/ebQ3/iq8YDPq0YyQJ2O13Qa9Z9BCZJmzux4/sdWYA2aP6/ZXPVZ1akdAfewA3R
         gL1OwiIJ4Xe6lrgkL9Tx8LbjAK8XN00Xl82HTIAwV1gPhwiPRaeBRUhwFXtGcAmdWl
         MmP5+EqnlDO+7pBxZRDzvKxJJ/UUJivjIiFGOEWk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Joel Stanley <joel@jms.id.au>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH AUTOSEL 4.19 012/237] powerpc/boot: Disable vector instructions
Date:   Sat, 16 Nov 2019 10:37:27 -0500
Message-Id: <20191116154113.7417-12-sashal@kernel.org>
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

From: Joel Stanley <joel@jms.id.au>

[ Upstream commit e8e132e6885962582784b6fa16a80d07ea739c0f ]

This will avoid auto-vectorisation when building with higher
optimisation levels.

We don't know if the machine can support VSX and even if it's present
it's probably not going to be enabled at this point in boot.

These flag were both added prior to GCC 4.6 which is the minimum
compiler version supported by upstream, thanks to Segher for the
details.

Signed-off-by: Joel Stanley <joel@jms.id.au>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/boot/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index 25e3184f11f78..7d5ddf53750ce 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -32,8 +32,8 @@ else
 endif
 
 BOOTCFLAGS    := -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs \
-		 -fno-strict-aliasing -Os -msoft-float -pipe \
-		 -fomit-frame-pointer -fno-builtin -fPIC -nostdinc \
+		 -fno-strict-aliasing -Os -msoft-float -mno-altivec -mno-vsx \
+		 -pipe -fomit-frame-pointer -fno-builtin -fPIC -nostdinc \
 		 -D$(compress-y)
 
 ifdef CONFIG_PPC64_BOOT_WRAPPER
-- 
2.20.1

