Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C72EC433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 12:57:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C94320B7C
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 12:57:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406972AbfHIM5i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 08:57:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57726 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726232AbfHIM5g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 08:57:36 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 68DC46CCD7;
        Fri,  9 Aug 2019 12:57:36 +0000 (UTC)
Received: from t460s.redhat.com (ovpn-117-120.ams2.redhat.com [10.36.117.120])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EC9C36C8FA;
        Fri,  9 Aug 2019 12:57:33 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Borislav Petkov <bp@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Ingo Molnar <mingo@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Nadav Amit <namit@vmware.com>,
        Wei Yang <richardw.yang@linux.intel.com>,
        Oscar Salvador <osalvador@suse.de>
Subject: [PATCH v1 1/4] resource: Use PFN_UP / PFN_DOWN in walk_system_ram_range()
Date:   Fri,  9 Aug 2019 14:56:58 +0200
Message-Id: <20190809125701.3316-2-david@redhat.com>
In-Reply-To: <20190809125701.3316-1-david@redhat.com>
References: <20190809125701.3316-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Fri, 09 Aug 2019 12:57:36 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This makes it clearer that we will never call func() with duplicate PFNs
in case we have multiple sub-page memory resources. All unaligned parts
of PFNs are completely discarded.

Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Borislav Petkov <bp@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Nadav Amit <namit@vmware.com>
Cc: Wei Yang <richardw.yang@linux.intel.com>
Cc: Oscar Salvador <osalvador@suse.de>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 kernel/resource.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/resource.c b/kernel/resource.c
index 7ea4306503c5..88ee39fa9103 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -487,8 +487,8 @@ int walk_system_ram_range(unsigned long start_pfn, unsigned long nr_pages,
 	while (start < end &&
 	       !find_next_iomem_res(start, end, flags, IORES_DESC_NONE,
 				    false, &res)) {
-		pfn = (res.start + PAGE_SIZE - 1) >> PAGE_SHIFT;
-		end_pfn = (res.end + 1) >> PAGE_SHIFT;
+		pfn = PFN_UP(res.start);
+		end_pfn = PFN_DOWN(res.end + 1);
 		if (end_pfn > pfn)
 			ret = (*func)(pfn, end_pfn - pfn, arg);
 		if (ret)
-- 
2.21.0

