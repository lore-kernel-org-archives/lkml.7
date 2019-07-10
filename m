Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85895C73C63
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 01:17:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 537B02073D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 01:17:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="CgnZ01od"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727099AbfGJBRA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 21:17:00 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:44266 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727027AbfGJBQz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 21:16:55 -0400
Received: by mail-qk1-f196.google.com with SMTP id d79so612401qke.11
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2019 18:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=CVTJCjL61cT1sLEtn2w9JvdFUT6cQxdBQbzitEZ8G3w=;
        b=CgnZ01od2X5o9ZxnU3YxLA5iP6DGIirNV+yqbmaGGd37pbDw+kMM0vJ0slJQWHOgGz
         89n/NsZaNntd/HsoETEEEWONOoRpUvU+swsq3e0sogqmdn7o3c+6pgPWb0uMVxE0WqLg
         +7f3548VjFl28RcqVuZy3NVuR0FeaZeD2MTcqLaGipojj6pr7WHfHlZaKZDd6uR230L0
         JT4sctjsx1qzKG+wB2YuOCU2TWArwX6x/FgTtjBrPZrz5jK0b+CWmWzZQlS4c5VoVZtr
         JemrX7sEW8IBBYGZikmfiz6eQN+ryIQdDAWkxCVDBjzH3tTwnd+byUmpjy4XiunxSWhU
         BXQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CVTJCjL61cT1sLEtn2w9JvdFUT6cQxdBQbzitEZ8G3w=;
        b=E6Tp1eR8R1PdpD+wyjU+E7EVTg9uuQ11/nFTg1gz3If93SXyW2vL69FoSuNnXO0Fh7
         0hZOegqjE2zmt7kDbMO8yKD6yismpHcKP24wF6DuvDQD00d+XdEXB2Dz61rcUtvCwVtv
         3TDb67QHcHedTpVUowRTYaoC8ubJVN/jb5K3YC/7ePXk/stkck3PFRmTW0LnAoilsiuk
         xw63mIZKdy6Q4e6TZVMhAnqoy/gNcklwAS86VkEBMkn5T9jG9J+B21RU9pEk0TLw5Ipy
         Lc2R5qWESQJYh9jXMelhA6SBgYmKDWG8M0uopFiqzssiQzw/DMVmY10t9c5U3DIw3GMQ
         avqw==
X-Gm-Message-State: APjAAAV0oVusOxdoTxgUGcXu1u9cJTzowpe50Jp1PpH/2u/PKfB2UnI0
        950vpVui8EMxNBoTXmiTcWZKwB1OiNs=
X-Google-Smtp-Source: APXvYqys9rzeaiHpJCQSMGWFJQogIT5Nl/kLTQmCtVzEY7YWfkQtFYUrb2NcrUN7cHm0A3qL/HJzCg==
X-Received: by 2002:a05:620a:1661:: with SMTP id d1mr21322876qko.192.1562721414251;
        Tue, 09 Jul 2019 18:16:54 -0700 (PDT)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id u7sm260057qta.82.2019.07.09.18.16.52
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 09 Jul 2019 18:16:53 -0700 (PDT)
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
Subject: [v7 3/3] device-dax: "Hotremove" persistent memory that is used like normal RAM
Date:   Tue,  9 Jul 2019 21:16:47 -0400
Message-Id: <20190710011647.10944-4-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190710011647.10944-1-pasha.tatashin@soleen.com>
References: <20190710011647.10944-1-pasha.tatashin@soleen.com>
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

echo offline > /sys/devices/system/memory/memoryN/state
...
echo dax0.0 > /sys/bus/dax/drivers/kmem/unbind

Note: if unbind is done without offlining memory beforehand, it won't be
possible to do dax0.0 hotremove, and dax's memory is going to be part of
System RAM until reboot.

Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/dax/dax-private.h |  2 ++
 drivers/dax/kmem.c        | 41 +++++++++++++++++++++++++++++++++++----
 2 files changed, 39 insertions(+), 4 deletions(-)

diff --git a/drivers/dax/dax-private.h b/drivers/dax/dax-private.h
index b4177aafbbd1..9ee659ed5566 100644
--- a/drivers/dax/dax-private.h
+++ b/drivers/dax/dax-private.h
@@ -45,6 +45,7 @@ struct dax_region {
  * @pgmap - pgmap for memmap setup / lifetime (driver owned)
  * @ref: pgmap reference count (driver owned)
  * @cmp: @ref final put completion (driver owned)
+ * @dax_mem_res: physical address range of hotadded DAX memory
  */
 struct dev_dax {
 	struct dax_region *region;
@@ -54,6 +55,7 @@ struct dev_dax {
 	struct dev_pagemap pgmap;
 	struct percpu_ref ref;
 	struct completion cmp;
+	struct resource *dax_kmem_res;
 };
 
 static inline struct dev_dax *to_dev_dax(struct device *dev)
diff --git a/drivers/dax/kmem.c b/drivers/dax/kmem.c
index 4c0131857133..c52a8e5f2345 100644
--- a/drivers/dax/kmem.c
+++ b/drivers/dax/kmem.c
@@ -71,21 +71,54 @@ int dev_dax_kmem_probe(struct device *dev)
 		kfree(new_res);
 		return rc;
 	}
+	dev_dax->dax_kmem_res = new_res;
 
 	return 0;
 }
 
+#ifdef CONFIG_MEMORY_HOTREMOVE
+static int dev_dax_kmem_remove(struct device *dev)
+{
+	struct dev_dax *dev_dax = to_dev_dax(dev);
+	struct resource *res = dev_dax->dax_kmem_res;
+	resource_size_t kmem_start = res->start;
+	resource_size_t kmem_size = resource_size(res);
+	int rc;
+
+	/*
+	 * We have one shot for removing memory, if some memory blocks were not
+	 * offline prior to calling this function remove_memory() will fail, and
+	 * there is no way to hotremove this memory until reboot because device
+	 * unbind will succeed even if we return failure.
+	 */
+	rc = remove_memory(dev_dax->target_node, kmem_start, kmem_size);
+	if (rc) {
+		dev_err(dev,
+			"region %pR cannot be hotremoved, error (%d)\n",
+			res, rc);
+		return rc;
+	}
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
2.22.0

