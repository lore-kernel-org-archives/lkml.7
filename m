Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AA35C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:25:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5977320880
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:25:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554139528;
	bh=pFF7mkFuGhghtQH+jv9dgW7dn/dvbj1E3wrOuK6KLMo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=w4nuF5gom/CvR40YHtRZbFeZ0mSmV3c+0cKjTocvNabGsCaLXCWrhc/HGJX0JOxJX
	 9XtxtuXXhvsi7W7FU+u7GdZa/AamRoHR/CtFBHrh7sokwMmJ2s5TebS2Kms68SLLm5
	 efC8ElYizCuOXy+ZLa3fGMOGaYOAtZ5hCPZXZd0k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732418AbfDARZ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:25:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:56664 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732406AbfDARZX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:25:23 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 23BBA2063F;
        Mon,  1 Apr 2019 17:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554139522;
        bh=pFF7mkFuGhghtQH+jv9dgW7dn/dvbj1E3wrOuK6KLMo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2esIuASnutsFzH2vLsxPNSoMiHiJirSH5UiMqiF/8xx5rqgIXsd5pEZK39giWqh6L
         zWH5bZPelrrIopSZx/KR+RNKjIs+yha+uLu+X14X12/z6OZB2EeHXlR1331XQLz5lF
         9+tVCYd5X9xxdrqMY/Esz2Q05krniWnsXpRF9Mn8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lars Persson <larper@axis.com>,
        Paul Burton <paul.burton@mips.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Ralf Baechle <ralf@linux-mips.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.14 100/107] mm/migrate.c: add missing flush_dcache_page for non-mapped page migrate
Date:   Mon,  1 Apr 2019 19:02:55 +0200
Message-Id: <20190401170054.789906055@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170045.246405031@linuxfoundation.org>
References: <20190401170045.246405031@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lars Persson <lars.persson@axis.com>

commit d2b2c6dd227ba5b8a802858748ec9a780cb75b47 upstream.

Our MIPS 1004Kc SoCs were seeing random userspace crashes with SIGILL
and SIGSEGV that could not be traced back to a userspace code bug.  They
had all the magic signs of an I/D cache coherency issue.

Now recently we noticed that the /proc/sys/vm/compact_memory interface
was quite efficient at provoking this class of userspace crashes.

Studying the code in mm/migrate.c there is a distinction made between
migrating a page that is mapped at the instant of migration and one that
is not mapped.  Our problem turned out to be the non-mapped pages.

For the non-mapped page the code performs a copy of the page content and
all relevant meta-data of the page without doing the required D-cache
maintenance.  This leaves dirty data in the D-cache of the CPU and on
the 1004K cores this data is not visible to the I-cache.  A subsequent
page-fault that triggers a mapping of the page will happily serve the
process with potentially stale code.

What about ARM then, this bug should have seen greater exposure? Well
ARM became immune to this flaw back in 2010, see commit c01778001a4f
("ARM: 6379/1: Assume new page cache pages have dirty D-cache").

My proposed fix moves the D-cache maintenance inside move_to_new_page to
make it common for both cases.

Link: http://lkml.kernel.org/r/20190315083502.11849-1-larper@axis.com
Fixes: 97ee0524614 ("flush cache before installing new page at migraton")
Signed-off-by: Lars Persson <larper@axis.com>
Reviewed-by: Paul Burton <paul.burton@mips.com>
Acked-by: Mel Gorman <mgorman@techsingularity.net>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 mm/migrate.c |   11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -247,10 +247,8 @@ static bool remove_migration_pte(struct
 				pte = swp_entry_to_pte(entry);
 			} else if (is_device_public_page(new)) {
 				pte = pte_mkdevmap(pte);
-				flush_dcache_page(new);
 			}
-		} else
-			flush_dcache_page(new);
+		}
 
 #ifdef CONFIG_HUGETLB_PAGE
 		if (PageHuge(new)) {
@@ -971,6 +969,13 @@ static int move_to_new_page(struct page
 		 */
 		if (!PageMappingFlags(page))
 			page->mapping = NULL;
+
+		if (unlikely(is_zone_device_page(newpage))) {
+			if (is_device_public_page(newpage))
+				flush_dcache_page(newpage);
+		} else
+			flush_dcache_page(newpage);
+
 	}
 out:
 	return rc;


