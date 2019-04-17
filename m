Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 736AFC282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 12:02:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42C1F206BA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 12:02:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732029AbfDQMCL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 08:02:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41322 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731717AbfDQMCK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 08:02:10 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5DFB8C060200;
        Wed, 17 Apr 2019 12:02:10 +0000 (UTC)
Received: from t460s.redhat.com (ovpn-117-141.ams2.redhat.com [10.36.117.141])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 216905D9E1;
        Wed, 17 Apr 2019 12:02:04 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Wei Yang <richard.weiyang@gmail.com>, Qian Cai <cai@lca.pw>,
        Arun KS <arunks@codeaurora.org>,
        Mathieu Malaterre <malat@debian.org>
Subject: [PATCH] mm/memory_hotplug: Fixup "Release memory resource after arch_remove_memory()"
Date:   Wed, 17 Apr 2019 14:02:04 +0200
Message-Id: <20190417120204.6997-1-david@redhat.com>
In-Reply-To: <20190409100148.24703-2-david@redhat.com>
References: <20190409100148.24703-2-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Wed, 17 Apr 2019 12:02:10 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pr_warn with "%pa" expects a pointer to phys_addr_t or resource_size_t.
So let's propery use resource_size_t for the start address and size,
we are dealing with resources after all.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Michal Hocko <mhocko@suse.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
Cc: Wei Yang <richard.weiyang@gmail.com>
Cc: Qian Cai <cai@lca.pw>
Cc: Arun KS <arunks@codeaurora.org>
Cc: Mathieu Malaterre <malat@debian.org>
Reviewed-by: Oscar Salvador <osalvador@suse.de>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/memory_hotplug.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 093f6dc66f46..328878b6799d 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1800,7 +1800,8 @@ void try_offline_node(int nid)
 }
 EXPORT_SYMBOL(try_offline_node);
 
-static void __release_memory_resource(u64 start, u64 size)
+static void __release_memory_resource(resource_size_t start,
+				      resource_size_t size)
 {
 	int ret;
 
-- 
2.20.1

