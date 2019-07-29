Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6376C76186
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 20:07:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FB11205F4
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 20:07:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564430853;
	bh=Bk4euBxqH5qlll/EnIf32IESFKGEKVT4LqtJsXFNGTE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xM5ezqHUY/BjB7d1FP3u9NV2F+uOxZJXldKLleu+ZU757XRGjW/etvrDR2hh8DCaL
	 3l2XYEEG2iEM+nA/K/xqUFNmmz5k/kzWVl8lEUXB9nafOfBSYJxVUvyB2OHKnaCR0z
	 oLReSdcghYXyka1K0F9N0hfSSalrdxHtvZzTPu18=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387909AbfG2TjI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 15:39:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:54112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388925AbfG2TjE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 15:39:04 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3A4382171F;
        Mon, 29 Jul 2019 19:39:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564429143;
        bh=Bk4euBxqH5qlll/EnIf32IESFKGEKVT4LqtJsXFNGTE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HVv+HESF+Zocdz3+I7by6SK+AzzM23C1U13/Md7EXyvizjERySkEX/44viDi6vhE0
         uv9cvd5PjFGHharfua2WvR/4oO1TSBYPOVfNXmpz2FlfPnANtKEfrCOWsgpSzyIaG+
         BRJss+4VFK4X+Cf7H/i088V2vxkKmJ1k9FpufO4c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Florian Weimer <fweimer@redhat.com>,
        Jann Horn <jannh@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 274/293] mm/gup.c: remove some BUG_ONs from get_gate_page()
Date:   Mon, 29 Jul 2019 21:22:45 +0200
Message-Id: <20190729190845.306981562@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190729190820.321094988@linuxfoundation.org>
References: <20190729190820.321094988@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit b5d1c39f34d1c9bca0c4b9ae2e339fbbe264a9c7 ]

If we end up without a PGD or PUD entry backing the gate area, don't BUG
-- just fail gracefully.

It's not entirely implausible that this could happen some day on x86.  It
doesn't right now even with an execute-only emulated vsyscall page because
the fixmap shares the PUD, but the core mm code shouldn't rely on that
particular detail to avoid OOPSing.

Link: http://lkml.kernel.org/r/a1d9f4efb75b9d464e59fd6af00104b21c58f6f7.1561610798.git.luto@kernel.org
Signed-off-by: Andy Lutomirski <luto@kernel.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Andrew Morton <akpm@linux-foundation.org>
Cc: Florian Weimer <fweimer@redhat.com>
Cc: Jann Horn <jannh@google.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/gup.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index cee599d1692c..12b9626b1a9e 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -442,11 +442,14 @@ static int get_gate_page(struct mm_struct *mm, unsigned long address,
 		pgd = pgd_offset_k(address);
 	else
 		pgd = pgd_offset_gate(mm, address);
-	BUG_ON(pgd_none(*pgd));
+	if (pgd_none(*pgd))
+		return -EFAULT;
 	p4d = p4d_offset(pgd, address);
-	BUG_ON(p4d_none(*p4d));
+	if (p4d_none(*p4d))
+		return -EFAULT;
 	pud = pud_offset(p4d, address);
-	BUG_ON(pud_none(*pud));
+	if (pud_none(*pud))
+		return -EFAULT;
 	pmd = pmd_offset(pud, address);
 	if (!pmd_present(*pmd))
 		return -EFAULT;
-- 
2.20.1



