Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7428BC432C1
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 08:26:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F98620673
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 08:26:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2634083AbfIYI01 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 04:26:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38164 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390395AbfIYI01 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 04:26:27 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 544931DCD;
        Wed, 25 Sep 2019 08:26:26 +0000 (UTC)
Received: from t460s.redhat.com (ovpn-117-14.ams2.redhat.com [10.36.117.14])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9AF61167A3;
        Wed, 25 Sep 2019 08:26:22 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        Oscar Salvador <osalvador@suse.de>
Subject: [PATCH v1] drivers/base/memory.c: Drop the mem_sysfs_mutex
Date:   Wed, 25 Sep 2019 10:26:21 +0200
Message-Id: <20190925082621.4927-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.71]); Wed, 25 Sep 2019 08:26:26 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The mem_sysfs_mutex isn't really helpful. Also, it's not really clear what
the mutex protects at all.

The device lists of the memory subsystem are protected separately. We don't
need that mutex when looking up. creating, or removing independent
devices. find_memory_block_by_id() will perform locking on its own and
grab a reference of the returned device.

At the time memory_dev_init() is called, we cannot have concurrent
hot(un)plug operations yet - we're still fairly early during boot. We
don't need any locking.

The creation/removal of memory block devices should be protected
on a higher level - especially using the device hotplug lock to avoid
documented issues (see Documentation/core-api/memory-hotplug.rst) - or
if that is reworked, using similar locking.

Protecting in the context of these functions only doesn't really make
sense. Especially, if we would have a situation where the same memory
blocks are created/deleted at the same time, there is something horribly
going wrong (imagining adding/removing a DIMM at the same time from two
call paths) - after the functions succeeded something else in the
callers would blow up (e.g., create_memory_block_devices() succeeded but
there are no memory block devices anymore).

All relevant call paths (except when adding memory early during boot
via ACPI, which is now documented) hold the device hotplug lock when
adding memory, and when removing memory. Let's document that instead.

Add a simple safety net to create_memory_block_devices() in case we
would actually remove memory blocks while adding them, so we'll never
dereference a NULL pointer. Simplify memory_dev_init() now that the
lock is gone.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Oscar Salvador <osalvador@suse.de>
Signed-off-by: David Hildenbrand <david@redhat.com>
---

Tested using my usual x86-64 DIMM based hot(un)plug setup.

---
 drivers/base/memory.c | 33 ++++++++++++++-------------------
 1 file changed, 14 insertions(+), 19 deletions(-)

diff --git a/drivers/base/memory.c b/drivers/base/memory.c
index 6bea4f3f8040..634aab8e1e19 100644
--- a/drivers/base/memory.c
+++ b/drivers/base/memory.c
@@ -19,15 +19,12 @@
 #include <linux/memory.h>
 #include <linux/memory_hotplug.h>
 #include <linux/mm.h>
-#include <linux/mutex.h>
 #include <linux/stat.h>
 #include <linux/slab.h>
 
 #include <linux/atomic.h>
 #include <linux/uaccess.h>
 
-static DEFINE_MUTEX(mem_sysfs_mutex);
-
 #define MEMORY_CLASS_NAME	"memory"
 
 #define to_memory_block(dev) container_of(dev, struct memory_block, dev)
@@ -702,6 +699,8 @@ static void unregister_memory(struct memory_block *memory)
  * Create memory block devices for the given memory area. Start and size
  * have to be aligned to memory block granularity. Memory block devices
  * will be initialized as offline.
+ *
+ * Called under device_hotplug_lock.
  */
 int create_memory_block_devices(unsigned long start, unsigned long size)
 {
@@ -715,7 +714,6 @@ int create_memory_block_devices(unsigned long start, unsigned long size)
 			 !IS_ALIGNED(size, memory_block_size_bytes())))
 		return -EINVAL;
 
-	mutex_lock(&mem_sysfs_mutex);
 	for (block_id = start_block_id; block_id != end_block_id; block_id++) {
 		ret = init_memory_block(&mem, block_id, MEM_OFFLINE);
 		if (ret)
@@ -727,11 +725,12 @@ int create_memory_block_devices(unsigned long start, unsigned long size)
 		for (block_id = start_block_id; block_id != end_block_id;
 		     block_id++) {
 			mem = find_memory_block_by_id(block_id);
+			if (WARN_ON_ONCE(!mem))
+				continue;
 			mem->section_count = 0;
 			unregister_memory(mem);
 		}
 	}
-	mutex_unlock(&mem_sysfs_mutex);
 	return ret;
 }
 
@@ -739,6 +738,8 @@ int create_memory_block_devices(unsigned long start, unsigned long size)
  * Remove memory block devices for the given memory area. Start and size
  * have to be aligned to memory block granularity. Memory block devices
  * have to be offline.
+ *
+ * Called under device_hotplug_lock.
  */
 void remove_memory_block_devices(unsigned long start, unsigned long size)
 {
@@ -751,7 +752,6 @@ void remove_memory_block_devices(unsigned long start, unsigned long size)
 			 !IS_ALIGNED(size, memory_block_size_bytes())))
 		return;
 
-	mutex_lock(&mem_sysfs_mutex);
 	for (block_id = start_block_id; block_id != end_block_id; block_id++) {
 		mem = find_memory_block_by_id(block_id);
 		if (WARN_ON_ONCE(!mem))
@@ -760,7 +760,6 @@ void remove_memory_block_devices(unsigned long start, unsigned long size)
 		unregister_memory_block_under_nodes(mem);
 		unregister_memory(mem);
 	}
-	mutex_unlock(&mem_sysfs_mutex);
 }
 
 /* return true if the memory block is offlined, otherwise, return false */
@@ -794,12 +793,13 @@ static const struct attribute_group *memory_root_attr_groups[] = {
 };
 
 /*
- * Initialize the sysfs support for memory devices...
+ * Initialize the sysfs support for memory devices. At the time this function
+ * is called, we cannot have concurrent creation/deletion of memory block
+ * devices, the device_hotplug_lock is not needed.
  */
 void __init memory_dev_init(void)
 {
 	int ret;
-	int err;
 	unsigned long block_sz, nr;
 
 	/* Validate the configured memory block size */
@@ -810,24 +810,19 @@ void __init memory_dev_init(void)
 
 	ret = subsys_system_register(&memory_subsys, memory_root_attr_groups);
 	if (ret)
-		goto out;
+		panic("%s() failed to register subsystem: %d\n", __func__, ret);
 
 	/*
 	 * Create entries for memory sections that were found
 	 * during boot and have been initialized
 	 */
-	mutex_lock(&mem_sysfs_mutex);
 	for (nr = 0; nr <= __highest_present_section_nr;
 	     nr += sections_per_block) {
-		err = add_memory_block(nr);
-		if (!ret)
-			ret = err;
+		ret = add_memory_block(nr);
+		if (ret)
+			panic("%s() failed to add memory block: %d\n", __func__,
+			      ret);
 	}
-	mutex_unlock(&mem_sysfs_mutex);
-
-out:
-	if (ret)
-		panic("%s() failed: %d\n", __func__, ret);
 }
 
 /**
-- 
2.21.0

