Return-Path: <SRS0=ebdT=SX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5820DC282DD
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Apr 2019 01:44:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 280FB20833
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Apr 2019 01:44:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="ZcOj6/tW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727685AbfDUBoh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Apr 2019 21:44:37 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:39955 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbfDUBog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Apr 2019 21:44:36 -0400
Received: by mail-qt1-f194.google.com with SMTP id v7so5414651qti.7
        for <linux-kernel@vger.kernel.org>; Sat, 20 Apr 2019 18:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=KL328kJp7uYop/CaXZcmGRKfoBkXK0v1G+nukTp5itg=;
        b=ZcOj6/tWBZki8VSTYWIx2hC0zATUWkFU1OTXUPmLys73YN2QUPVmWMkCAzisCIphb4
         lagFcRl0UAa1+nKpZPFW6/ywAODOoC2ElJuMxdMZK+n/MVj6NLUv0dZbEJuUtuqfRbAG
         2vQO7zgIlXc6foQWwNvVaXJ4cmOF6Nv1Mbrym5SdV+qbCVa1vCnbCbAIPeojIxSuiyzv
         alULIAAU7iGCTj9LS/VnbEzAzTbYgUAZW4UQycLNdEUtMMs7BATfDuCFjGJGPJtHwATa
         X1SGiIiiccfzYurY/yFrS0TMcM5+2hTPgZVtuHjsxwv960+2M26QfeQOg2ZSfR+OrX9P
         Nihw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KL328kJp7uYop/CaXZcmGRKfoBkXK0v1G+nukTp5itg=;
        b=Hlum5JN696RzdiCcWWzg6hxqgAg6D40mtRAh/3zoWog7QvvKAKqOCyDwIaLywlHTIL
         QLVgSkBRRsnoMM/f7kC5TA/+Dvt5ssqPUlK2pBQrTd9pM/6bwUznIAEa2PMHlQsO3Fal
         1JA+i110TMfUBO6AiKIkj/3GhWqqT4fyCe/ErIkXE02acciSySPgBavd+VtytJN+wxN8
         m4RzO7+00uRFJlssOgQb9vIiNzp7bRfyQIJIqEZD0w8xCLDlc5QpNeIFFaPMUUK4IwMk
         VOqFQlo4NYDE1+SMAB6aM2JGalry9zkP7k1Y2NdVp+sr6dcZNtLKdciXmxwe3ViNXK63
         oN9Q==
X-Gm-Message-State: APjAAAU8bMXXDj0UoxZ7W3FwjWxlnyX1XWt5ClM9c8Mip7Ceyo77LKxK
        3o2ICUyE4dqwK4adtqKg/qm0/g==
X-Google-Smtp-Source: APXvYqwLrbFXWXl4ushQLhaJbuTDu4grdgvxRuAMcypo1JTsKGB8Q7Xxy+bv6W6dd9hWBd51O4WhFg==
X-Received: by 2002:ac8:1776:: with SMTP id u51mr436168qtk.151.1555811075671;
        Sat, 20 Apr 2019 18:44:35 -0700 (PDT)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id u1sm1385218qtj.50.2019.04.20.18.44.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 Apr 2019 18:44:34 -0700 (PDT)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, jmorris@namei.org, sashal@kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-nvdimm@lists.01.org, akpm@linux-foundation.org,
        mhocko@suse.com, dave.hansen@linux.intel.com,
        dan.j.williams@intel.com, keith.busch@intel.com,
        vishal.l.verma@intel.com, dave.jiang@intel.com, zwisler@kernel.org,
        thomas.lendacky@amd.com, ying.huang@intel.com,
        fengguang.wu@intel.com, bp@suse.de, bhelgaas@google.com,
        baiyaowei@cmss.chinamobile.com, tiwai@suse.de, jglisse@redhat.com
Subject: [v2 2/2] device-dax: "Hotremove" persistent memory that is used like normal RAM
Date:   Sat, 20 Apr 2019 21:44:29 -0400
Message-Id: <20190421014429.31206-3-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190421014429.31206-1-pasha.tatashin@soleen.com>
References: <20190421014429.31206-1-pasha.tatashin@soleen.com>
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
 drivers/dax/kmem.c        | 91 +++++++++++++++++++++++++++++++++++++--
 2 files changed, 89 insertions(+), 4 deletions(-)

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
index 4c0131857133..d4896b281036 100644
--- a/drivers/dax/kmem.c
+++ b/drivers/dax/kmem.c
@@ -71,21 +71,104 @@ int dev_dax_kmem_probe(struct device *dev)
 		kfree(new_res);
 		return rc;
 	}
+	dev_dax->dax_kmem_res = new_res;
 
 	return 0;
 }
 
+#ifdef CONFIG_MEMORY_HOTREMOVE
+/*
+ * Check that device-dax's memory_blocks are offline. If a memory_block is not
+ * offline a warning is printed and an error is returned. dax hotremove can
+ * succeed only when every memory_block is offlined beforehand.
+ */
+static int
+offline_memblock_cb(struct memory_block *mem, void *arg)
+{
+	struct device *mem_dev = &mem->dev;
+	bool is_offline;
+
+	device_lock(mem_dev);
+	is_offline = mem_dev->offline;
+	device_unlock(mem_dev);
+
+	if (!is_offline) {
+		struct device *dev = (struct device *)arg;
+		unsigned long spfn = section_nr_to_pfn(mem->start_section_nr);
+		unsigned long epfn = section_nr_to_pfn(mem->end_section_nr);
+		phys_addr_t spa = spfn << PAGE_SHIFT;
+		phys_addr_t epa = epfn << PAGE_SHIFT;
+
+		dev_warn(dev, "memory block [%pa-%pa] is not offline\n",
+			 &spa, &epa);
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
+	/*
+	 * dax kmem resource does not exist, means memory was never hotplugged.
+	 * So, nothing to do here.
+	 */
+	if (!res)
+		return 0;
+
+	kmem_start = res->start;
+	kmem_size = resource_size(res);
+	start_pfn = kmem_start >> PAGE_SHIFT;
+	end_pfn = start_pfn + (kmem_size >> PAGE_SHIFT) - 1;
+
+	/*
+	 * Walk and check that every singe memory_block of dax region is
+	 * offline
+	 */
+	lock_device_hotplug();
+	rc = walk_memory_range(start_pfn, end_pfn, dev, offline_memblock_cb);
+	unlock_device_hotplug();
+
+	/*
+	 * If admin has not offlined memory beforehand, we cannot hotremove dax.
+	 * Unfortunately, because unbind will still succeed there is no way for
+	 * user to hotremove dax after this.
+	 */
+	if (rc)
+		return rc;
+
+	/* Hotremove memory, cannot fail because memory is already offlined */
+	remove_memory(dev_dax->target_node, kmem_start, kmem_size);
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

