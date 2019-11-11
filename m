Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71216C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 18:35:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 409952196E
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 18:35:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573497354;
	bh=DgOeGiA0kYlJ1pwptbjhYwSRiBmoHrCye0hH9BMijLQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lY1QlHeqlW2YDTOsxcANVKWoY//y3JhV0SWzX6hjYDX06/Ph2nnf9oR4brHkyjaYb
	 LtmNsSO16v++mNM0T3CCtWN2ZigkPGJMPLYv9dX+aVQ7hXX9umH0gllXfmwAibPVHz
	 TV4mFa8FkmUqh9yQZxei0+M4hU1/A3z+LKW/rhok=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728618AbfKKSfx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 13:35:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:53838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728596AbfKKSft (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 13:35:49 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 03D812196E;
        Mon, 11 Nov 2019 18:35:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573497348;
        bh=DgOeGiA0kYlJ1pwptbjhYwSRiBmoHrCye0hH9BMijLQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yDfc0waTE+mJ83/fjioNmFOwQvf60cCPnTLaLpk4RyaIlTJ3J8WQPjlXnxB4mqLGo
         KWnrmMBJxHfGWnlpGr4Mhn9ePDHq7L6d4pd/MCdU0VIzMh3hxJRe50xL+W/HJaVMhs
         mzeWMNqrnsck4LvKBTmvMxCisKugWI4zHTEI+Nw4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Will Deacon <will@kernel.org>,
        Steve Capper <steve.capper@arm.com>,
        John Stultz <john.stultz@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH 4.14 023/105] arm64: Do not mask out PTE_RDONLY in pte_same()
Date:   Mon, 11 Nov 2019 19:27:53 +0100
Message-Id: <20191111181436.637567352@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191111181421.390326245@linuxfoundation.org>
References: <20191111181421.390326245@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Catalin Marinas <catalin.marinas@arm.com>

commit 6767df245f4736d0cf0c6fb7cf9cf94b27414245 upstream.

Following commit 73e86cb03cf2 ("arm64: Move PTE_RDONLY bit handling out
of set_pte_at()"), the PTE_RDONLY bit is no longer managed by
set_pte_at() but built into the PAGE_* attribute definitions.
Consequently, pte_same() must include this bit when checking two PTEs
for equality.

Remove the arm64-specific pte_same() function, practically reverting
commit 747a70e60b72 ("arm64: Fix copy-on-write referencing in HugeTLB")

Fixes: 73e86cb03cf2 ("arm64: Move PTE_RDONLY bit handling out of set_pte_at()")
Cc: <stable@vger.kernel.org> # 4.14.x-
Cc: Will Deacon <will@kernel.org>
Cc: Steve Capper <steve.capper@arm.com>
Reported-by: John Stultz <john.stultz@linaro.org>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm64/include/asm/pgtable.h |   17 -----------------
 1 file changed, 17 deletions(-)

--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -258,23 +258,6 @@ static inline void set_pte_at(struct mm_
 	set_pte(ptep, pte);
 }
 
-#define __HAVE_ARCH_PTE_SAME
-static inline int pte_same(pte_t pte_a, pte_t pte_b)
-{
-	pteval_t lhs, rhs;
-
-	lhs = pte_val(pte_a);
-	rhs = pte_val(pte_b);
-
-	if (pte_present(pte_a))
-		lhs &= ~PTE_RDONLY;
-
-	if (pte_present(pte_b))
-		rhs &= ~PTE_RDONLY;
-
-	return (lhs == rhs);
-}
-
 /*
  * Huge pte definitions.
  */


