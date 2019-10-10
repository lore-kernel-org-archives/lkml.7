Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1D97C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 14:12:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C996F206A1
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 14:12:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726383AbfJJOMG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 10:12:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46580 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726084AbfJJOMF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 10:12:05 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 55C343084032;
        Thu, 10 Oct 2019 14:12:05 +0000 (UTC)
Received: from t460s.redhat.com (ovpn-117-218.ams2.redhat.com [10.36.117.218])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 220B75C1B2;
        Thu, 10 Oct 2019 14:12:00 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v1] drivers/base/memory.c: Don't access uninitialized memmaps in soft_offline_page_store()
Date:   Thu, 10 Oct 2019 16:12:00 +0200
Message-Id: <20191010141200.8985-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Thu, 10 Oct 2019 14:12:05 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Uninitialized memmaps contain garbage and in the worst case trigger kernel
BUGs, especially with CONFIG_PAGE_POISONING. They should not get
touched.

Right now, when trying to soft-offline a PFN that resides on a memory
block that was never onlined, one gets a misleading error with
CONFIG_PAGE_POISONING:
  :/# echo 5637144576 > /sys/devices/system/memory/soft_offline_page
  [   23.097167] soft offline: 0x150000 page already poisoned

But the actual result depends on the garbage in the memmap.

soft_offline_page() can only work with online pages, it returns -EIO in
case of ZONE_DEVICE. Make sure to only forward pages that are online
(iow, managed by the buddy) and, therefore, have an initialized memmap.

Add a check against pfn_to_online_page() and similarly return -EIO.

Fixes: f1dd2cd13c4b ("mm, memory_hotplug: do not associate hotadded memory to zones until online") # visible after d0dc12e86b319
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/base/memory.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/base/memory.c b/drivers/base/memory.c
index 6bea4f3f8040..55907c27075b 100644
--- a/drivers/base/memory.c
+++ b/drivers/base/memory.c
@@ -540,6 +540,9 @@ static ssize_t soft_offline_page_store(struct device *dev,
 	pfn >>= PAGE_SHIFT;
 	if (!pfn_valid(pfn))
 		return -ENXIO;
+	/* Only online pages can be soft-offlined (esp., not ZONE_DEVICE). */
+	if (!pfn_to_online_page(pfn))
+		return -EIO;
 	ret = soft_offline_page(pfn_to_page(pfn), 0);
 	return ret == 0 ? count : ret;
 }
-- 
2.21.0

