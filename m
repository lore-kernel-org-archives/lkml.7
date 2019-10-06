Return-Path: <SRS0=Dm7n=X7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDA39ECE58F
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 17:47:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 987A022486
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 17:47:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570384044;
	bh=Rq5KCnNb5DcsX1r+Iur5At0kw9Uc65vXdmpWwLR0yhI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DyTBjaybJk5em8uwfMshqeRT+1jMgNn+VYp/eSc9vcajL7kdMVnE7iFOGez3CGINt
	 nOrpAcowB4l0PblC915RXTGMBQzrYrWGnrttr6eQuc9qghkIwY4Qw+tbpKtLH6ZdHO
	 suriux/CHb1aKoeOLpPLZcj842rcE2Z9j1aTn0Aw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731731AbfJFRor (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Oct 2019 13:44:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:44954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731708AbfJFRoj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 13:44:39 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2433F2080F;
        Sun,  6 Oct 2019 17:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570383878;
        bh=Rq5KCnNb5DcsX1r+Iur5At0kw9Uc65vXdmpWwLR0yhI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WUMpSkcx80g3zFFn03CZ6jckz0XaF21TROIVlV2yzN+HjPRd5IHze5ifboqJqjd2T
         G1ikvPBVoh6CY1ZRUQXaRJFfC1WCcYKvWkBNIloWPe3F3OlLH1QQ/C6a8UtletiRNE
         rnLTunuGPxFBTC6wXWFJ+0NOdah4vv3o3Acg1l80=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alexandre Ghiti <alex@ghiti.fr>,
        Kees Cook <keescook@chromium.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoph Hellwig <hch@infradead.org>,
        Christoph Hellwig <hch@lst.de>,
        James Hogan <jhogan@kernel.org>,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Burton <paul.burton@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Russell King <linux@armlinux.org.uk>,
        Will Deacon <will.deacon@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.3 127/166] arm: use STACK_TOP when computing mmap base address
Date:   Sun,  6 Oct 2019 19:21:33 +0200
Message-Id: <20191006171223.969132237@linuxfoundation.org>
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

From: Alexandre Ghiti <alex@ghiti.fr>

[ Upstream commit 86e568e9c0525fc40e76d827212d5e9721cf7504 ]

mmap base address must be computed wrt stack top address, using TASK_SIZE
is wrong since STACK_TOP and TASK_SIZE are not equivalent.

Link: http://lkml.kernel.org/r/20190730055113.23635-8-alex@ghiti.fr
Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
Acked-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
Cc: Albert Ou <aou@eecs.berkeley.edu>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: Christoph Hellwig <hch@lst.de>
Cc: James Hogan <jhogan@kernel.org>
Cc: Palmer Dabbelt <palmer@sifive.com>
Cc: Paul Burton <paul.burton@mips.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Will Deacon <will.deacon@arm.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/mm/mmap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mm/mmap.c b/arch/arm/mm/mmap.c
index bff3d00bda5be..0b94b674aa91f 100644
--- a/arch/arm/mm/mmap.c
+++ b/arch/arm/mm/mmap.c
@@ -19,7 +19,7 @@
 
 /* gap between mmap and stack */
 #define MIN_GAP		(128*1024*1024UL)
-#define MAX_GAP		((TASK_SIZE)/6*5)
+#define MAX_GAP		((STACK_TOP)/6*5)
 #define STACK_RND_MASK	(0x7ff >> (PAGE_SHIFT - 12))
 
 static int mmap_is_legacy(struct rlimit *rlim_stack)
@@ -51,7 +51,7 @@ static unsigned long mmap_base(unsigned long rnd, struct rlimit *rlim_stack)
 	else if (gap > MAX_GAP)
 		gap = MAX_GAP;
 
-	return PAGE_ALIGN(TASK_SIZE - gap - rnd);
+	return PAGE_ALIGN(STACK_TOP - gap - rnd);
 }
 
 /*
-- 
2.20.1



