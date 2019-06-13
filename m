Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07BBFC31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:06:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D54AD20679
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:06:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560442014;
	bh=7jtANu9nOjxLCoBnOdWXOj89ThgJw/5Uig2La2ne0tg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lDf0Bv5TMbz5ZoSjbfDk2W5sMV9TkWvd5EohE1eOZZHOVyv4gEcb1h4YUD5/7qHOQ
	 1KwQmXzcl4UCMcGHOYIgyBIT4M06ecuPO8YFVU0m/Nt7rkimVSoiadkgxG+gh6w53e
	 kVOng7KKnG5lxOPVSxO38u4kN4chKnd7KekpIbqg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728295AbfFMQGk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 12:06:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:34584 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731316AbfFMIpz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 04:45:55 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4B172215EA;
        Thu, 13 Jun 2019 08:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560415554;
        bh=7jtANu9nOjxLCoBnOdWXOj89ThgJw/5Uig2La2ne0tg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=avL8xhnzKUD1lpfoIf2I6QDS5Nz7kf9vL5M32FIoabcqSl1eJWhscrirPcdU/FdK1
         LQd4sxeX0m6SJsD0fMr1Vc3FXmz034WkKEAB17AlHAcFTGSijdUrWdAEhvTqh7wCiP
         8iLpu7qP4K35RQ2zvnMNXAD+TP8/xAhSQJMgcjOU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Baoquan He <bhe@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>,
        Wei Yang <richard.weiyang@gmail.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.1 019/155] mm/memory_hotplug.c: fix the wrong usage of N_HIGH_MEMORY
Date:   Thu, 13 Jun 2019 10:32:11 +0200
Message-Id: <20190613075653.828541511@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190613075652.691765927@linuxfoundation.org>
References: <20190613075652.691765927@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit d3ba3ae19751e476b0840a0c9a673a5766fa3219 ]

In node_states_check_changes_online(), N_HIGH_MEMORY is used to substitute
ZONE_HIGHMEM directly.  This is not right.  N_HIGH_MEMORY is to mark the
memory state of node.  Here zone index is checked, which should be
compared with 'ZONE_HIGHMEM' accordingly.

Replace it with ZONE_HIGHMEM.

This is a code cleanup - no known runtime effects.

Link: http://lkml.kernel.org/r/20190320080732.14933-1-bhe@redhat.com
Fixes: 8efe33f40f3e ("mm/memory_hotplug.c: simplify node_states_check_changes_online")
Signed-off-by: Baoquan He <bhe@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Acked-by: Michal Hocko <mhocko@suse.com>
Reviewed-by: Oscar Salvador <osalvador@suse.de>
Cc: Wei Yang <richard.weiyang@gmail.com>
Cc: Mike Rapoport <rppt@linux.ibm.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/memory_hotplug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 28587f290109..547e48addced 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -700,7 +700,7 @@ static void node_states_check_changes_online(unsigned long nr_pages,
 	if (zone_idx(zone) <= ZONE_NORMAL && !node_state(nid, N_NORMAL_MEMORY))
 		arg->status_change_nid_normal = nid;
 #ifdef CONFIG_HIGHMEM
-	if (zone_idx(zone) <= N_HIGH_MEMORY && !node_state(nid, N_HIGH_MEMORY))
+	if (zone_idx(zone) <= ZONE_HIGHMEM && !node_state(nid, N_HIGH_MEMORY))
 		arg->status_change_nid_high = nid;
 #endif
 }
-- 
2.20.1



