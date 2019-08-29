Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB697C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 03:52:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AD7F23403
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 03:52:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=d-silva.org header.i=@d-silva.org header.b="kQTlD7Q2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727281AbfH2DwC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 23:52:02 -0400
Received: from ushosting.nmnhosting.com ([66.55.73.32]:44878 "EHLO
        ushosting.nmnhosting.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727188AbfH2DwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 23:52:02 -0400
Received: from mail2.nmnhosting.com (unknown [202.169.106.97])
        by ushosting.nmnhosting.com (Postfix) with ESMTPS id CE9F02DC009A;
        Wed, 28 Aug 2019 23:52:00 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=d-silva.org;
        s=201810a; t=1567050721;
        bh=HPG14nExqVPJ4V/n3bFbBw+g46PVLmmj5APpE7/lKv4=;
        h=From:To:Cc:Subject:Date:From;
        b=kQTlD7Q2CwsLpIAZBeIdnTDzDkyyTPD3/t4onT0b6wizxqd6CU+/B6GnFwc77UXLW
         zQufTKy0xiD0dpWg0Ej/sLzg0w8u7v98Yw8KBWqEkbsecWc5nsA1tnXoPVBbeYduFC
         KSpWI6CDvTAmQORs7q7tQ1IF9Xw9exwBVH2fx03tRPKwsq6cKdnwykxAUmyuMh6ROa
         p3rVk3OrUkYlE07dOCRzmjerCf39jVYotQ0rVLnkjR2cB4TLtbqx6Ddhy7/jJmNwuw
         Y3MKalyHCpTOSTlj8vN3kV1niNWswuEupRqDZir3LfL2sjEdqOnlrO/qRn4IWC66a5
         NpEwzF3yaIf6cUeGGGZQzkoEdhCcmFMtOuzR+RIQDBAYQXlgo9C5friS3LsTPeydiE
         EdanqsVwmduOVy2VPEiXni6TvDCOzTFIMy8g2BpGMxH2+/rnEmMFTo5YO+JHsla89V
         H0yrSM4z59/+MclAR0fkDkBixbHm7I9b/oAz4yxtePbe8/IVfCV3sP2OK7LhvduRJo
         ZJ4S1KwXGj2tcDHNtGFF49UzDhZiebtyQUJ0MdbdGK0dQF0dm62zZFZBDKzU1HCbQE
         UekCp1vX9DXfXyoASEI6iz7QAQi/4eNkb7kfL7qCD/IzBPmUzizlrkvy/ehr/zU56N
         pcJZXyksl1oTi/zaJudzhOIc=
Received: from ibmlaptop.local (ibmlaptop.lan [10.0.1.179])
        (authenticated bits=0)
        by mail2.nmnhosting.com (8.15.2/8.15.2) with ESMTPSA id x7T3ppAq061198
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 29 Aug 2019 13:51:54 +1000 (AEST)
        (envelope-from alastair@d-silva.org)
From:   "Alastair D'Silva" <alastair@d-silva.org>
To:     alastair@d-silva.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Michal Hocko <mhocko@suse.com>,
        Wei Yang <richard.weiyang@gmail.com>, Qian Cai <cai@lca.pw>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Baoquan He <bhe@redhat.com>,
        Balbir Singh <bsingharora@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mm: Remove NULL check in clear_hwpoisoned_pages()
Date:   Thu, 29 Aug 2019 13:51:50 +1000
Message-Id: <20190829035151.20975-1-alastair@d-silva.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.6.2 (mail2.nmnhosting.com [10.0.1.20]); Thu, 29 Aug 2019 13:51:56 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no possibility for memmap to be NULL in the current
codebase.

This check was added in commit 95a4774d055c ("memory-hotplug:
update mce_bad_pages when removing the memory")
where memmap was originally inited to NULL, and only conditionally
given a value.

The code that could have passed a NULL has been removed, so there
is no longer a possibility that memmap can be NULL.

Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
---
 mm/sparse.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/mm/sparse.c b/mm/sparse.c
index 78979c142b7d..9f7e3682cdcb 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -754,9 +754,6 @@ static void clear_hwpoisoned_pages(struct page *memmap, int nr_pages)
 {
 	int i;
 
-	if (!memmap)
-		return;
-
 	/*
 	 * A further optimization is to have per section refcounted
 	 * num_poisoned_pages.  But that would need more space per memmap, so
-- 
2.21.0

