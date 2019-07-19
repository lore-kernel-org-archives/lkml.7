Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52897C76188
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 04:00:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CD15218A6
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 04:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563508819;
	bh=NGAEa7nxCla6yeOxFjos63IrCBcidctWmzU3WpluPhM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rnZ6IH3B3Xp+GOTSgo1ArhHRQ7X2H+1XwdlL0bL0xQCmmbrbfaEwGvw2Dq6y7/nJF
	 CeOnqKEJptg4M864OX21VKKj9DjNqpZEL8+MNa25QsIPjGUwA3oYUzcO8gmb+ERI3Q
	 hIw+XxySrAzPMlyWwAa6TX7Gw8bOK5p0MOd3QzKc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728034AbfGSEAR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 00:00:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:60022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727243AbfGSEAJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 00:00:09 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 65DD821852;
        Fri, 19 Jul 2019 04:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563508809;
        bh=NGAEa7nxCla6yeOxFjos63IrCBcidctWmzU3WpluPhM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wXKrDihp/S1cVan7L4zfjmAgAIzXlz6fMWnxvGRTLBM8R1Dk3lWkTAvYLkcXDUbvS
         llI5C0scOH1cTUGYr8VC+JvcJHNLtbVmDeq/2JOUHnx/UwhuPELJgHtDPXdKpzRPpa
         9cFOvOfWe+SrDKyVuEwpMHFmr7ukTzxcgb2ssKjs=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ira Weiny <ira.weiny@intel.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Dan Williams <dan.j.williams@intel.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <sashal@kernel.org>, linux-mm@kvack.org
Subject: [PATCH AUTOSEL 5.2 102/171] mm/swap: fix release_pages() when releasing devmap pages
Date:   Thu, 18 Jul 2019 23:55:33 -0400
Message-Id: <20190719035643.14300-102-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190719035643.14300-1-sashal@kernel.org>
References: <20190719035643.14300-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

[ Upstream commit c5d6c45e90c49150670346967971e14576afd7f1 ]

release_pages() is an optimized version of a loop around put_page().
Unfortunately for devmap pages the logic is not entirely correct in
release_pages().  This is because device pages can be more than type
MEMORY_DEVICE_PUBLIC.  There are in fact 4 types, private, public, FS DAX,
and PCI P2PDMA.  Some of these have specific needs to "put" the page while
others do not.

This logic to handle any special needs is contained in
put_devmap_managed_page().  Therefore all devmap pages should be processed
by this function where we can contain the correct logic for a page put.

Handle all device type pages within release_pages() by calling
put_devmap_managed_page() on all devmap pages.  If
put_devmap_managed_page() returns true the page has been put and we
continue with the next page.  A false return of put_devmap_managed_page()
means the page did not require special processing and should fall to
"normal" processing.

This was found via code inspection while determining if release_pages()
and the new put_user_pages() could be interchangeable.[1]

[1] https://lkml.kernel.org/r/20190523172852.GA27175@iweiny-DESK2.sc.intel.com

Link: https://lkml.kernel.org/r/20190605214922.17684-1-ira.weiny@intel.com
Cc: Jérôme Glisse <jglisse@redhat.com>
Cc: Michal Hocko <mhocko@suse.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/swap.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/mm/swap.c b/mm/swap.c
index 7ede3eddc12a..607c48229a1d 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -740,15 +740,20 @@ void release_pages(struct page **pages, int nr)
 		if (is_huge_zero_page(page))
 			continue;
 
-		/* Device public page can not be huge page */
-		if (is_device_public_page(page)) {
+		if (is_zone_device_page(page)) {
 			if (locked_pgdat) {
 				spin_unlock_irqrestore(&locked_pgdat->lru_lock,
 						       flags);
 				locked_pgdat = NULL;
 			}
-			put_devmap_managed_page(page);
-			continue;
+			/*
+			 * ZONE_DEVICE pages that return 'false' from
+			 * put_devmap_managed_page() do not require special
+			 * processing, and instead, expect a call to
+			 * put_page_testzero().
+			 */
+			if (put_devmap_managed_page(page))
+				continue;
 		}
 
 		page = compound_head(page);
-- 
2.20.1

