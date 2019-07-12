Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AF95C742A8
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 08:51:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AE442166E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 08:51:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="UR3LEgR9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbfGLIvq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 04:51:46 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:46518 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726222AbfGLIvp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 04:51:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1562921504; x=1594457504;
  h=from:to:cc:subject:date:message-id;
  bh=gIX56E206Ygtmlz0jOLcOvzHgmUrVjC3hqqjQDtHYu4=;
  b=UR3LEgR9qvTWGJK4w2V/1+WTqanObJxl+AXKqhv/UTFNBj9dwl2aEtUQ
   mYmYFjEZYW6UlVa2xfR3uuFuviZy/w0dnTDJckC4JI5D/VU/5XBJmYCKC
   ncXqewPnym8CtD9FIqFJDBQLgNqK6Gd4OCbvD7ZT4axMplzkBfkPjsahe
   A=;
X-IronPort-AV: E=Sophos;i="5.62,481,1554768000"; 
   d="scan'208";a="685113937"
Received: from sea3-co-svc-lb6-vlan2.sea.amazon.com (HELO email-inbound-relay-2b-859fe132.us-west-2.amazon.com) ([10.47.22.34])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 12 Jul 2019 08:51:43 +0000
Received: from u54e1ad5160425a4b64ea.ant.amazon.com (pdx2-ws-svc-lb17-vlan3.amazon.com [10.247.140.70])
        by email-inbound-relay-2b-859fe132.us-west-2.amazon.com (Postfix) with ESMTPS id 0FFBE222159;
        Fri, 12 Jul 2019 08:51:41 +0000 (UTC)
Received: from u54e1ad5160425a4b64ea.ant.amazon.com (localhost [127.0.0.1])
        by u54e1ad5160425a4b64ea.ant.amazon.com (8.15.2/8.15.2/Debian-3) with ESMTP id x6C8pb32024010;
        Fri, 12 Jul 2019 10:51:38 +0200
Received: (from karahmed@localhost)
        by u54e1ad5160425a4b64ea.ant.amazon.com (8.15.2/8.15.2/Submit) id x6C8pZ4Q024001;
        Fri, 12 Jul 2019 10:51:35 +0200
From:   KarimAllah Ahmed <karahmed@amazon.de>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     KarimAllah Ahmed <karahmed@amazon.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Baoquan He <bhe@redhat.com>, Qian Cai <cai@lca.pw>,
        Wei Yang <richard.weiyang@gmail.com>,
        Logan Gunthorpe <logang@deltatee.com>
Subject: [PATCH] mm: sparse: Skip no-map regions in memblocks_present
Date:   Fri, 12 Jul 2019 10:51:31 +0200
Message-Id: <1562921491-23899-1-git-send-email-karahmed@amazon.de>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do not mark regions that are marked with nomap to be present, otherwise
these memblock cause unnecessarily allocation of metadata.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Pavel Tatashin <pasha.tatashin@oracle.com>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Mike Rapoport <rppt@linux.ibm.com>
Cc: Baoquan He <bhe@redhat.com>
Cc: Qian Cai <cai@lca.pw>
Cc: Wei Yang <richard.weiyang@gmail.com>
Cc: Logan Gunthorpe <logang@deltatee.com>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: KarimAllah Ahmed <karahmed@amazon.de>
---
 mm/sparse.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mm/sparse.c b/mm/sparse.c
index fd13166..33810b6 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -256,6 +256,10 @@ void __init memblocks_present(void)
 	struct memblock_region *reg;
 
 	for_each_memblock(memory, reg) {
+
+		if (memblock_is_nomap(reg))
+			continue;
+
 		memory_present(memblock_get_region_node(reg),
 			       memblock_region_memory_base_pfn(reg),
 			       memblock_region_memory_end_pfn(reg));
-- 
2.7.4

