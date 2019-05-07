Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D83FDC004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 05:38:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB36D21530
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 05:38:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557207483;
	bh=itR4g2WKHerLiXBWp4LPWTXItI1Mg4Qe2yr2sz5HZKU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DdF/c2pssLYZZx+8s7+nDq6dQyjkJvzSq7duvVM9gtf+Zg2YT2iLY0bliEQP3k/Lg
	 bCVxEDduO6mK+bO88WwYvkw6kXCMACrjaUicERVIgR5mxMxx/G0RZSJo1LwMhYw7da
	 r3ugdYVMwB72OFuMxCgdi8rNDh7/y8sA13uSgWl8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728507AbfEGFiB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 01:38:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:57694 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727317AbfEGFhz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 01:37:55 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 56E8720578;
        Tue,  7 May 2019 05:37:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557207474;
        bh=itR4g2WKHerLiXBWp4LPWTXItI1Mg4Qe2yr2sz5HZKU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=v2neQjX7kj2u9VkKRpbKe1RyuhamhyfXKUpbT0d1YURnaU+lO9s/LjTSdliNbxVqN
         x5R8uRj4VSzISl5V+ApPuA0nrYlVb4//fha5tRn5Wq42tp7L2I2Ol3w5d2Jf24TJPu
         l9F+6puP1sO182pRL8/zVOpRwHVoZ7xajKUBRO4g=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Wei Yang <richard.weiyang@gmail.com>,
        Michal Hocko <mhocko@suse.com>,
        Pankaj Gupta <pagupta@redhat.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Qian Cai <cai@lca.pw>, Arun KS <arunks@codeaurora.org>,
        Mathieu Malaterre <malat@debian.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>, linux-mm@kvack.org
Subject: [PATCH AUTOSEL 4.19 63/81] mm/memory_hotplug.c: drop memory device reference after find_memory_block()
Date:   Tue,  7 May 2019 01:35:34 -0400
Message-Id: <20190507053554.30848-63-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190507053554.30848-1-sashal@kernel.org>
References: <20190507053554.30848-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Hildenbrand <david@redhat.com>

[ Upstream commit 89c02e69fc5245f8a2f34b58b42d43a737af1a5e ]

Right now we are using find_memory_block() to get the node id for the
pfn range to online.  We are missing to drop a reference to the memory
block device.  While the device still gets unregistered via
device_unregister(), resulting in no user visible problem, the device is
never released via device_release(), resulting in a memory leak.  Fix
that by properly using a put_device().

Link: http://lkml.kernel.org/r/20190411110955.1430-1-david@redhat.com
Fixes: d0dc12e86b31 ("mm/memory_hotplug: optimize memory hotplug")
Signed-off-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Oscar Salvador <osalvador@suse.de>
Reviewed-by: Wei Yang <richard.weiyang@gmail.com>
Acked-by: Michal Hocko <mhocko@suse.com>
Acked-by: Pankaj Gupta <pagupta@redhat.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
Cc: Qian Cai <cai@lca.pw>
Cc: Arun KS <arunks@codeaurora.org>
Cc: Mathieu Malaterre <malat@debian.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/memory_hotplug.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 156991edec2a..af6735562215 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -901,6 +901,7 @@ int __ref online_pages(unsigned long pfn, unsigned long nr_pages, int online_typ
 	 */
 	mem = find_memory_block(__pfn_to_section(pfn));
 	nid = mem->nid;
+	put_device(&mem->dev);
 
 	/* associate pfn range with the zone */
 	zone = move_pfn_range(online_type, nid, pfn, nr_pages);
-- 
2.20.1

