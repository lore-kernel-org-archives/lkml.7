Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ECD5C43218
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 14:42:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06C1021773
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 14:42:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rr+6i7rP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391736AbfFKOmG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 10:42:06 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:37826 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391705AbfFKOmA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 10:42:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=92m0mWNJuHmY5cYpWlooP/cZgBBhq6eJcxducqZ88IQ=; b=rr+6i7rPu5se1K/u84C05O1tdY
        GzqfoR4ThRZnBYykD/g3PZVO7wt8FMplFhvZc9xK09NnOLWoT3OfPdCMgF6j8idQ5hVx9Llo1V/aA
        gkylDbMT/JiY3hZo9qmZ7jM0kZrPGMqnbWcr+ylPSRBycRzfkVl6yoTaZ1ZcJXTyhNuZUVuhmKdkL
        39NSJ31ih14hQPhzjcZ3GtnHRqtmiZsoUO6nKeiz7ttH5Iuyf6If7xjguwIwAwHBQreLYaFo0nkc2
        q9x/QDp+b7OsLJTf33M2uFsaCD+JFkB+KMn94HytN+qVUEV+oOEb6fRveAy1MReAX/mRXtPMLUcHi
        LLWRbdIw==;
Received: from mpp-cp1-natpool-1-037.ethz.ch ([82.130.71.37] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hahy7-0005mk-T7; Tue, 11 Jun 2019 14:41:48 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Khalid Aziz <khalid.aziz@oracle.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-mips@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-mm@kvack.org, x86@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 14/16] mm: switch gup_hugepte to use try_get_compound_head
Date:   Tue, 11 Jun 2019 16:41:00 +0200
Message-Id: <20190611144102.8848-15-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190611144102.8848-1-hch@lst.de>
References: <20190611144102.8848-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This applies the overflow fixes from 8fde12ca79aff
("mm: prevent get_user_pages() from overflowing page refcount")
to the powerpc hugepd code and brings it back in sync with the
other GUP cases.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 mm/gup.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/gup.c b/mm/gup.c
index 494aa4c3a55e..0733674b539d 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -2007,7 +2007,8 @@ static int gup_hugepte(pte_t *ptep, unsigned long sz, unsigned long addr,
 		refs++;
 	} while (addr += PAGE_SIZE, addr != end);
 
-	if (!page_cache_add_speculative(head, refs)) {
+	head = try_get_compound_head(head, refs);
+	if (!head) {
 		*nr -= refs;
 		return 0;
 	}
-- 
2.20.1

