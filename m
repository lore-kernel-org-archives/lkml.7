Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 920DEC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:32:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 627A920830
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:32:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554139976;
	bh=o8wTsXt+Q/bdbUIDySUEkSMfGL9I4Del51hgPqMFua0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nQJWv2v9Ng9jRZQZhwG56K4afKG7uGIEmtRDueabW9BWFlhErWyxyyOWU/xF3a9+r
	 ZBJTM3p2z6piKIWM0VdyOe3A+Q6H+9o5Gj6EU7vukaiQ1ml6f+8xqNmUqmlviTL/5J
	 1TmAH8C24boD6J5TU+S/tut4pr65tyhdCJ1OT+po=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732890AbfDARcz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:32:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:41316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729057AbfDARcx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:32:53 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3413D20856;
        Mon,  1 Apr 2019 17:32:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554139972;
        bh=o8wTsXt+Q/bdbUIDySUEkSMfGL9I4Del51hgPqMFua0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tlbhHALvuvHVqat5R9u0wGqccD3JAHvKZfjdz1bRscQy4s+MjT0h08MPneuB3qpKP
         9UyUJnICkkGYPTDARS7KWu7YY987DvKN5ldMw//ohE0uWP9D0VGdWX4ts5fjndh1vA
         bBp0jQv67G5qxyUNzq8wcCJAe0D1icu5i+7FgDPg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 068/131] asm-generic: Fix local variable shadow in __set_fixmap_offset
Date:   Mon,  1 Apr 2019 19:02:18 +0200
Message-Id: <20190401170057.878844138@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170051.645954551@linuxfoundation.org>
References: <20190401170051.645954551@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

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
index 1cbb8338edf3..827e4d3bbc7a 100644
--- a/include/asm-generic/fixmap.h
+++ b/include/asm-generic/fixmap.h
@@ -70,12 +70,12 @@ static inline unsigned long virt_to_fix(const unsigned long vaddr)
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



