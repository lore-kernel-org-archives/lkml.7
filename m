Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 942B7C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 09:37:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F95A20811
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 09:37:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728753AbfC2JhD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 05:37:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59224 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728689AbfC2JhC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 05:37:02 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 77886307D914;
        Fri, 29 Mar 2019 09:37:02 +0000 (UTC)
Received: from localhost (ovpn-12-24.pek2.redhat.com [10.72.12.24])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C9D3D60BFB;
        Fri, 29 Mar 2019 09:37:01 +0000 (UTC)
Date:   Fri, 29 Mar 2019 17:36:59 +0800
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, rafael@kernel.org, akpm@linux-foundation.org,
        mhocko@suse.com, osalvador@suse.de, rppt@linux.ibm.com,
        willy@infradead.org, fanc.fnst@cn.fujitsu.com
Subject: [PATCH v4 2/2] drivers/base/memory.c: Rename the misleading parameter
Message-ID: <20190329093659.GG7627@MiWiFi-R3L-srv>
References: <20190329082915.19763-1-bhe@redhat.com>
 <20190329082915.19763-2-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190329082915.19763-2-bhe@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Fri, 29 Mar 2019 09:37:02 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The input parameter 'phys_index' of memory_block_action() is actually
the section number, but not the phys_index of memory_block. This is
a relict from the past when one memory block could only contain one
section.

Rename it to start_section_nr.

Signed-off-by: Baoquan He <bhe@redhat.com>
Acked-by: Michal Hocko <mhocko@suse.com>
Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/base/memory.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/base/memory.c b/drivers/base/memory.c
index cb8347500ce2..9ea972b2ae79 100644
--- a/drivers/base/memory.c
+++ b/drivers/base/memory.c
@@ -231,13 +231,14 @@ static bool pages_correctly_probed(unsigned long start_pfn)
  * OK to have direct references to sparsemem variables in here.
  */
 static int
-memory_block_action(unsigned long phys_index, unsigned long action, int online_type)
+memory_block_action(unsigned long start_section_nr, unsigned long action,
+		    int online_type)
 {
 	unsigned long start_pfn;
 	unsigned long nr_pages = PAGES_PER_SECTION * sections_per_block;
 	int ret;
 
-	start_pfn = section_nr_to_pfn(phys_index);
+	start_pfn = section_nr_to_pfn(start_section_nr);
 
 	switch (action) {
 	case MEM_ONLINE:
@@ -251,7 +252,7 @@ memory_block_action(unsigned long phys_index, unsigned long action, int online_t
 		break;
 	default:
 		WARN(1, KERN_WARNING "%s(%ld, %ld) unknown action: "
-		     "%ld\n", __func__, phys_index, action, action);
+		     "%ld\n", __func__, start_section_nr, action, action);
 		ret = -EINVAL;
 	}
 
-- 
2.17.2

