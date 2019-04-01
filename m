Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE637C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:39:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F05420857
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554140372;
	bh=+1oksBOizrkmnGsProq/jM/xtKtaaX4m95XH5K2xL8w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NKm0YciDVNDO2GDSTVZZoYEJf2awwXorRfbyKYTFj28acpTDeu2BVKDm1q1TEGqAo
	 KE2ZGZUsLp+C+T2CCLKPtGuqRC0/Oi6PtykI1+VnQi+GKz2HQqJ1FnUVfFRLdKbrHd
	 6qoMkY80U29H5eapF5gCFLTMY4C6IIg30yUzspuc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388461AbfDARjb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:39:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:53170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388448AbfDARjZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:39:25 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E7B69205C9;
        Mon,  1 Apr 2019 17:39:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554140365;
        bh=+1oksBOizrkmnGsProq/jM/xtKtaaX4m95XH5K2xL8w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UsXmrcOpmfuzFrv4C2jVhCciZ9pEZxLzUrjNLVqPfFVNTdOGd28vHhvluy/FWeXeY
         LR6rIFfubHqE5klfloLZxjos0tu+ddKPuZDg965jDC8DbzHNUJ49H2YlxFlmXcHU0K
         936A2fTnDlShNxf0aPLF+U4ggGQbNe01eFaTQeOQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 3.18 14/50] asm-generic: Fix local variable shadow in __set_fixmap_offset
Date:   Mon,  1 Apr 2019 19:02:57 +0200
Message-Id: <20190401170042.765941449@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170041.257273804@linuxfoundation.org>
References: <20190401170041.257273804@linuxfoundation.org>
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

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 3694bd76781b76c4f8d2ecd85018feeb1609f0e5 ]

Currently __set_fixmap_offset is a macro function which has a local
variable called 'addr'. If a caller passes a 'phys' parameter which is
derived from a variable also called 'addr', the local variable will
shadow this, and the compiler will complain about the use of an
uninitialized variable. To avoid the issue with namespace clashes,
'addr' is prefixed with a liberal sprinkling of underscores.

Turning __set_fixmap_offset into a static inline breaks the build for
several architectures. Fixing this properly requires updates to a number
of architectures to make them agree on the prototype of __set_fixmap (it
could be done as a subsequent patch series).

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Arnd Bergmann <arnd@arndb.de>
[catalin.marinas@arm.com: squashed the original function patch and macro fixup]
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/asm-generic/fixmap.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/asm-generic/fixmap.h b/include/asm-generic/fixmap.h
index f23174fb9ec4..10889b63af8f 100644
--- a/include/asm-generic/fixmap.h
+++ b/include/asm-generic/fixmap.h
@@ -67,12 +67,12 @@ static inline unsigned long virt_to_fix(const unsigned long vaddr)
 #endif
 
 /* Return a pointer with offset calculated */
-#define __set_fixmap_offset(idx, phys, flags)		      \
-({							      \
-	unsigned long addr;				      \
-	__set_fixmap(idx, phys, flags);			      \
-	addr = fix_to_virt(idx) + ((phys) & (PAGE_SIZE - 1)); \
-	addr;						      \
+#define __set_fixmap_offset(idx, phys, flags)				\
+({									\
+	unsigned long ________addr;					\
+	__set_fixmap(idx, phys, flags);					\
+	________addr = fix_to_virt(idx) + ((phys) & (PAGE_SIZE - 1));	\
+	________addr;							\
 })
 
 #define set_fixmap_offset(idx, phys) \
-- 
2.19.1



