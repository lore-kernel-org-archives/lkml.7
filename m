Return-Path: <SRS0=try7=ZI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5130DC432C3
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 15:51:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FE112184B
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 15:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573919476;
	bh=2M4bqX0FVUlvTYzZ0S0NnLRYZpiCJU8Fr7rhThqDBW0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AaeXW25EwZBJA1zSJoALEt65J5V5BBMXMKjs21XAG3a2xMO76jVyt+uh5x6vOl9QG
	 p9S4lIIXXIjGDrs0pwhXG7nKb9KWQaKCBlyJke+Wv0XnGfLR3I8GpFW14e7+WOUGul
	 6a2qD4pCuC0cf37fFj56+k9a3ndBJ7sJT4HlF+nM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730700AbfKPPvP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Nov 2019 10:51:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:59204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730633AbfKPPuu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Nov 2019 10:50:50 -0500
Received: from sasha-vm.mshome.net (unknown [50.234.116.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0739321844;
        Sat, 16 Nov 2019 15:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573919449;
        bh=2M4bqX0FVUlvTYzZ0S0NnLRYZpiCJU8Fr7rhThqDBW0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XpBT6S9YjSAajSYfee56Oc8S16h5fO3KGXSLrFL8k+aPEQcK/ddDWkyJqKHSYEuG+
         YruuGzh5lt4dNQFwZvSH6EmiwbpXGh///cO82oL4oRuFrhZEg0lg3GTSJS3nLCaeVv
         0xxqaxuwegxDsijo1XWuvVew6HPkv3MT6mAHtedI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     zhong jiang <zhongjiang@huawei.com>,
        Yang yingliang <yangyingliang@huawei.com>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 148/150] mm/memory_hotplug: Do not unlock when fails to take the device_hotplug_lock
Date:   Sat, 16 Nov 2019 10:47:26 -0500
Message-Id: <20191116154729.9573-148-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191116154729.9573-1-sashal@kernel.org>
References: <20191116154729.9573-1-sashal@kernel.org>
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
index 8e5818e735e2f..fe1557aa9b103 100644
--- a/drivers/base/memory.c
+++ b/drivers/base/memory.c
@@ -519,7 +519,7 @@ memory_probe_store(struct device *dev, struct device_attribute *attr,
 
 	ret = lock_device_hotplug_sysfs();
 	if (ret)
-		goto out;
+		return ret;
 
 	nid = memory_add_physaddr_to_nid(phys_addr);
 	ret = __add_memory(nid, phys_addr,
-- 
2.20.1

