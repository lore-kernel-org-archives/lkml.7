Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A2D6C31E40
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 08:08:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46B6D20651
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 08:08:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732264AbfHFIIb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 04:08:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42374 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728918AbfHFIIb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 04:08:31 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 351893CA18;
        Tue,  6 Aug 2019 08:08:31 +0000 (UTC)
Received: from t460s.redhat.com (ovpn-117-71.ams2.redhat.com [10.36.117.71])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4A1F65D704;
        Tue,  6 Aug 2019 08:08:27 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>
Subject: [PATCH v1] drivers/base/memory.c: Fixup documentation of removable/phys_index/block_size_bytes
Date:   Tue,  6 Aug 2019 10:08:26 +0200
Message-Id: <20190806080826.5963-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Tue, 06 Aug 2019 08:08:31 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's rephrase to memory block terminology and add some further
clarifications.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Oscar Salvador <osalvador@suse.de>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/base/memory.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/base/memory.c b/drivers/base/memory.c
index cb80f2bdd7de..790b3bcd63a6 100644
--- a/drivers/base/memory.c
+++ b/drivers/base/memory.c
@@ -116,10 +116,8 @@ static unsigned long get_memory_block_size(void)
 }
 
 /*
- * use this as the physical section index that this memsection
- * uses.
+ * Show the first physical section index (number) of this memory block.
  */
-
 static ssize_t phys_index_show(struct device *dev,
 			       struct device_attribute *attr, char *buf)
 {
@@ -131,7 +129,10 @@ static ssize_t phys_index_show(struct device *dev,
 }
 
 /*
- * Show whether the section of memory is likely to be hot-removable
+ * Show whether the memory block is likely to be offlineable (or is already
+ * offline). Once offline, the memory block could be removed. The return
+ * value does, however, not indicate that there is a way to remove the
+ * memory block.
  */
 static ssize_t removable_show(struct device *dev, struct device_attribute *attr,
 			      char *buf)
@@ -455,7 +456,7 @@ static DEVICE_ATTR_RO(phys_device);
 static DEVICE_ATTR_RO(removable);
 
 /*
- * Block size attribute stuff
+ * Show the memory block size (shared by all memory blocks).
  */
 static ssize_t block_size_bytes_show(struct device *dev,
 				     struct device_attribute *attr, char *buf)
-- 
2.21.0

