Return-Path: <SRS0=try7=ZI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 756EFC432C3
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 16:14:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49082214DE
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 16:14:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573920869;
	bh=L4QbWVzfIJSe4VDi2e6Gwm+s3G1sQIYBlYSwyB3DNpc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CAzbDToNeKux4l827Ak3LzuMzJZavVfbtlDmPUoAqUGSeU4MzS8/cHVglcTRrCRaW
	 TNesJbrBWdKDDTLW85HWxjWUO5D/Uq/GXHkqLyhmZO9YAe1wNYjxzWG4qskpdna1Om
	 LbWSztXsVV34tIP4NDsVFLaEnaYXte8XFyEawUtM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729809AbfKPPrs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Nov 2019 10:47:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:53746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729623AbfKPPrK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Nov 2019 10:47:10 -0500
Received: from sasha-vm.mshome.net (unknown [50.234.116.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E11F820885;
        Sat, 16 Nov 2019 15:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573919230;
        bh=L4QbWVzfIJSe4VDi2e6Gwm+s3G1sQIYBlYSwyB3DNpc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hOMK+7bJZrnZQyLoEeGWcHaOOwSAD8KzAd2W59iXwKfaIANCS/V9sP8hKA6fp6zH+
         8WiRX3CiJkCPGgZfm14pv5LGgBpa6d6MJtH8TZmV8CsSbBxJpMtTaz13ZNsGblLB3Q
         iGim2DUMrNTIg3qyiBd4Pk5LgeZFU0w/rwifdMEc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     zhong jiang <zhongjiang@huawei.com>,
        Yang yingliang <yangyingliang@huawei.com>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 235/237] mm/memory_hotplug: Do not unlock when fails to take the device_hotplug_lock
Date:   Sat, 16 Nov 2019 10:41:10 -0500
Message-Id: <20191116154113.7417-235-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191116154113.7417-1-sashal@kernel.org>
References: <20191116154113.7417-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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
index 0f8e77f78cc80..ac1574a696100 100644
--- a/drivers/base/memory.c
+++ b/drivers/base/memory.c
@@ -510,7 +510,7 @@ memory_probe_store(struct device *dev, struct device_attribute *attr,
 
 	ret = lock_device_hotplug_sysfs();
 	if (ret)
-		goto out;
+		return ret;
 
 	nid = memory_add_physaddr_to_nid(phys_addr);
 	ret = __add_memory(nid, phys_addr,
-- 
2.20.1

