Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0367C43219
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 19:19:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78F8D20651
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 19:19:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="CqskdudS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726297AbfEATS7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 15:18:59 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:42026 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726225AbfEATSx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 15:18:53 -0400
Received: by mail-qt1-f196.google.com with SMTP id p20so21053603qtc.9
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2019 12:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=XCMEqsTnk0N2iAxyILP6Z/EwAN/LZaWM24sWvUxI210=;
        b=CqskdudS7mwUlxptslgcXZ0QXR8Q/fCHG6QqeM31KcRRrgba1pDwhhpkltcSnQ8E+L
         gVy3qEXIP9svc8iYegEcV/mBtjU32rZrilr/1yEVwo3ZBgQDRnFeooOZWLI8PWqA/aqM
         2/abCp/DzPl3aAXbPZE+wmVPChF1H6i7y2NZdzqN2QTmKPCkeyYfe/ey1dloFGFUYdQ7
         o7Gv4D4ybUKpi4nRzae4TegIE0OMPPpqe7hjxF3DaArCCD0eBslynFzDIPmzA8HLX8iU
         HvG+db1yeo/SI2iFKCPOwjyYWIRzRQ1gJWm58qJrs6DibYEVtfnlNuz1y4juHcc9P8NZ
         f31Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XCMEqsTnk0N2iAxyILP6Z/EwAN/LZaWM24sWvUxI210=;
        b=QBgrdxhUwnp14X1OTQUaUfyhTFrpe4cszwn4KDjeTJHetRJCR4X0Aog0Yy0FJ3/SU6
         qm2UnEq4MxiSRfubrdRG0S31rT4PqKcnEMX3b9zmZMZXFRQE6XlazMPuz445z19V5HEU
         P/TFXMaEQkDMhuo57Xra8Zg2R1yqS5dlaiJRtf7UpENnjnwmSd3rlXD9Vi8dxzVIwzsC
         F70hX6aBEoBJzuVbvJVRLAP9+z7bhhIFhQazK1pk6rvKUmcedhGZxbNiYTDFYwqmKaeH
         zCIWKfh+dY/ydOR7W3ssQ2pdCwh6CKnOVMLdFct5Nh+RiT8HYXsOj4Cf7a3XZXYaTEU1
         ZvWg==
X-Gm-Message-State: APjAAAWMnWXi1U++hZ7JJPgopPEzAZMGr+lC0LPtycGZ8M2pgXyuSJtH
        KGz/a3oZ4G1ebt0ipMeQPDJ7nA==
X-Google-Smtp-Source: APXvYqzmNaTzzfNQY+U4p8zlZSxKvZsU3NG8OeWx/CjintReZDdamrlUDLJx9jczTgf2Hvh5qF+FYA==
X-Received: by 2002:ac8:3553:: with SMTP id z19mr51949671qtb.146.1556738332321;
        Wed, 01 May 2019 12:18:52 -0700 (PDT)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id x47sm12610946qth.68.2019.05.01.12.18.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 May 2019 12:18:51 -0700 (PDT)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, jmorris@namei.org, sashal@kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-nvdimm@lists.01.org, akpm@linux-foundation.org,
        mhocko@suse.com, dave.hansen@linux.intel.com,
        dan.j.williams@intel.com, keith.busch@intel.com,
        vishal.l.verma@intel.com, dave.jiang@intel.com, zwisler@kernel.org,
        thomas.lendacky@amd.com, ying.huang@intel.com,
        fengguang.wu@intel.com, bp@suse.de, bhelgaas@google.com,
        baiyaowei@cmss.chinamobile.com, tiwai@suse.de, jglisse@redhat.com,
        david@redhat.com
Subject: [v4 2/2] device-dax: "Hotremove" persistent memory that is used like normal RAM
Date:   Wed,  1 May 2019 15:18:46 -0400
Message-Id: <20190501191846.12634-3-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190501191846.12634-1-pasha.tatashin@soleen.com>
References: <20190501191846.12634-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is now allowed to use persistent memory like a regular RAM, but
currently there is no way to remove this memory until machine is
rebooted.

This work expands the functionality to also allows hotremoving
previously hotplugged persistent memory, and recover the device for use
for other purposes.

To hotremove persistent memory, the management software must first
offline all memory blocks of dax region, and than unbind it from
device-dax/kmem driver. So, operations should look like this:

echo offline > echo offline > /sys/devices/system/memory/memoryN/state
...
echo dax0.0 > /sys/bus/dax/drivers/kmem/unbind

Note: if unbind is done without offlining memory beforehand, it won't be
possible to do dax0.0 hotremove, and dax's memory is going to be part of
System RAM until reboot.

Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
---
 drivers/dax/dax-private.h |  2 +
 drivers/dax/kmem.c        | 99 +++++++++++++++++++++++++++++++++++++--
 2 files changed, 97 insertions(+), 4 deletions(-)

diff --git a/drivers/dax/dax-private.h b/drivers/dax/dax-private.h
index a45612148ca0..999aaf3a29b3 100644
--- a/drivers/dax/dax-private.h
+++ b/drivers/dax/dax-private.h
@@ -53,6 +53,7 @@ struct dax_region {
  * @pgmap - pgmap for memmap setup / lifetime (driver owned)
  * @ref: pgmap reference count (driver owned)
  * @cmp: @ref final put completion (driver owned)
+ * @dax_mem_res: physical address range of hotadded DAX memory
  */
 struct dev_dax {
 	struct dax_region *region;
@@ -62,6 +63,7 @@ struct dev_dax {
 	struct dev_pagemap pgmap;
 	struct percpu_ref ref;
 	struct completion cmp;
+	struct resource *dax_kmem_res;
 };
 
 static inline struct dev_dax *to_dev_dax(struct device *dev)
diff --git a/drivers/dax/kmem.c b/drivers/dax/kmem.c
index 4c0131857133..72b868066026 100644
--- a/drivers/dax/kmem.c
+++ b/drivers/dax/kmem.c
@@ -71,21 +71,112 @@ int dev_dax_kmem_probe(struct device *dev)
 		kfree(new_res);
 		return rc;
 	}
+	dev_dax->dax_kmem_res = new_res;
 
 	return 0;
 }
 
+#ifdef CONFIG_MEMORY_HOTREMOVE
+static int
+check_devdax_mem_offlined_cb(struct memory_block *mem, void *arg)
+{
+	/* Memory block device */
+	struct device *mem_dev = &mem->dev;
+	bool is_offline;
+
+	device_lock(mem_dev);
+	is_offline = mem_dev->offline;
+	device_unlock(mem_dev);
+
+	/*
+	 * Check that device-dax's memory_blocks are offline. If a memory_block
+	 * is not offline a warning is printed and an error is returned.
+	 */
+	if (!is_offline) {
+		/* Dax device device */
+		struct device *dev = (struct device *)arg;
+		struct dev_dax *dev_dax = to_dev_dax(dev);
+		struct resource *res = &dev_dax->region->res;
+		unsigned long spfn = section_nr_to_pfn(mem->start_section_nr);
+		unsigned long epfn = section_nr_to_pfn(mem->end_section_nr) +
+						       PAGES_PER_SECTION - 1;
+		phys_addr_t spa = spfn << PAGE_SHIFT;
+		phys_addr_t epa = epfn << PAGE_SHIFT;
+
+		dev_err(dev,
+			"DAX region %pR cannot be hotremoved until the next reboot. Memory block [%pa-%pa] is not offline.\n",
+			res, &spa, &epa);
+
+		return -EBUSY;
+	}
+
+	return 0;
+}
+
+static int dev_dax_kmem_remove(struct device *dev)
+{
+	struct dev_dax *dev_dax = to_dev_dax(dev);
+	struct resource *res = dev_dax->dax_kmem_res;
+	resource_size_t kmem_start;
+	resource_size_t kmem_size;
+	unsigned long start_pfn;
+	unsigned long end_pfn;
+	int rc;
+
+	kmem_start = res->start;
+	kmem_size = resource_size(res);
+	start_pfn = kmem_start >> PAGE_SHIFT;
+	end_pfn = start_pfn + (kmem_size >> PAGE_SHIFT) - 1;
+
+	/*
+	 * Keep hotplug lock while checking memory state, and also required
+	 * during __remove_memory() call. Admin can't change memory state via
+	 * sysfs while this lock is kept.
+	 */
+	lock_device_hotplug();
+
+	/*
+	 * Walk and check that every singe memory_block of dax region is
+	 * offline. Hotremove can succeed only when every memory_block is
+	 * offlined beforehand.
+	 */
+	rc = walk_memory_range(start_pfn, end_pfn, dev,
+			       check_devdax_mem_offlined_cb);
+
+	/*
+	 * If admin has not offlined memory beforehand, we cannot hotremove dax.
+	 * Unfortunately, because unbind will still succeed there is no way for
+	 * user to hotremove dax after this.
+	 */
+	if (rc) {
+		unlock_device_hotplug();
+		return rc;
+	}
+
+	/* Hotremove memory, cannot fail because memory is already offlined */
+	__remove_memory(dev_dax->target_node, kmem_start, kmem_size);
+	unlock_device_hotplug();
+
+	/* Release and free dax resources */
+	release_resource(res);
+	kfree(res);
+	dev_dax->dax_kmem_res = NULL;
+
+	return 0;
+}
+#else
 static int dev_dax_kmem_remove(struct device *dev)
 {
 	/*
-	 * Purposely leak the request_mem_region() for the device-dax
-	 * range and return '0' to ->remove() attempts. The removal of
-	 * the device from the driver always succeeds, but the region
-	 * is permanently pinned as reserved by the unreleased
+	 * Without hotremove purposely leak the request_mem_region() for the
+	 * device-dax range and return '0' to ->remove() attempts. The removal
+	 * of the device from the driver always succeeds, but the region is
+	 * permanently pinned as reserved by the unreleased
 	 * request_mem_region().
 	 */
 	return 0;
 }
+#endif /* CONFIG_MEMORY_HOTREMOVE */
 
 static struct dax_device_driver device_dax_kmem_driver = {
 	.drv = {
-- 
2.21.0

