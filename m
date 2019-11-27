Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BE8EC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 20:44:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 572EF217F9
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 20:44:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574887455;
	bh=SD1+ZK9OmCUCUovyv9SYJ8BesDSNpcNeA9aYJoHtpTQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lLELq43ngVjf3aHyOsTf0UMuIsILwJEaaRjYhvBCjM/YOl+CU98AyhxiE2dqFiUUh
	 UzbmxYBy7xW1dsStgtwWuhe1JLQ6Wwf9ibDYSZPlZ820AMTpo483UUjS8gNWu8+dJo
	 96YWnb8b+FYb/S+XnLYNVZOMh+ZSrPiOrgjwDzUQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729564AbfK0UoO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 15:44:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:53116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727937AbfK0UoL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 15:44:11 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 102F921775;
        Wed, 27 Nov 2019 20:44:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574887451;
        bh=SD1+ZK9OmCUCUovyv9SYJ8BesDSNpcNeA9aYJoHtpTQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OttUWmrgPuRCmOc+Q+2sETYTif261wc8v6yMhsK9gwpZ/4kO3nwKYo7PocnbZqQ29
         nfcnmqC/Hg6g5sNzs53OuiZ5xWbneWq+FkB2amT2LA63tpX7UX+1Pv+LsVhOWsAqkM
         dfAggYw/kt/Sx0ObuyGDAQJ5Psw0WrjzBdTkfjDg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yang yingliang <yangyingliang@huawei.com>,
        zhong jiang <zhongjiang@huawei.com>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@suse.com>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 109/151] mm/memory_hotplug: Do not unlock when fails to take the device_hotplug_lock
Date:   Wed, 27 Nov 2019 21:31:32 +0100
Message-Id: <20191127203042.581166556@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191127203000.773542911@linuxfoundation.org>
References: <20191127203000.773542911@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: zhong jiang <zhongjiang@huawei.com>

[ Upstream commit d2ab99403ee00d8014e651728a4702ea1ae5e52c ]

When adding the memory by probing memory block in sysfs interface, there is an
obvious issue that we will unlock the device_hotplug_lock when fails to takes it.

That issue was introduced in Commit 8df1d0e4a265
("mm/memory_hotplug: make add_memory() take the device_hotplug_lock")

We should drop out in time when fails to take the device_hotplug_lock.

Fixes: 8df1d0e4a265 ("mm/memory_hotplug: make add_memory() take the device_hotplug_lock")
Reported-by: Yang yingliang <yangyingliang@huawei.com>
Signed-off-by: zhong jiang <zhongjiang@huawei.com>
Reviewed-by: Oscar Salvador <osalvador@suse.de>
Reviewed-by: David Hildenbrand <david@redhat.com>
Acked-by: Michal Hocko <mhocko@suse.com>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/base/memory.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/memory.c b/drivers/base/memory.c
index 9f96f1b43c15f..6a3694a4843f8 100644
--- a/drivers/base/memory.c
+++ b/drivers/base/memory.c
@@ -502,7 +502,7 @@ memory_probe_store(struct device *dev, struct device_attribute *attr,
 
 	ret = lock_device_hotplug_sysfs();
 	if (ret)
-		goto out;
+		return ret;
 
 	nid = memory_add_physaddr_to_nid(phys_addr);
 	ret = __add_memory(nid, phys_addr,
-- 
2.20.1



