Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3A1BC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 13:58:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F91D20C01
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 13:58:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551362317;
	bh=OuI1kvg5DxXiReEYZuSUh9+LxZvLDdrkwELek33VrnM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=sch/CcO89X3OUGLCSr0ZC/C57TCSqVcoFdQ9dM5aNRvecuKnB2tpYR3AZbiEDyxZS
	 sehbINH+glazR5O4lCeMO6FE8t54G1H+GKArz2z28ED4+V4NQu2rNjTOSxUS9ZfTTI
	 uKX6dUfclu0hxmIT/4/A09aWIqPizcVlY9ushMa8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732017AbfB1N6g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 08:58:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:55994 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730687AbfB1N6f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 08:58:35 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 61DA720C01;
        Thu, 28 Feb 2019 13:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551362314;
        bh=OuI1kvg5DxXiReEYZuSUh9+LxZvLDdrkwELek33VrnM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k1MsznRhRaU85j3vfumrIKkqhddRfoDTwmoIHxhUXb8wtxPdULnuP23vl+hPigBfe
         elXwMw1VcdLDdzcYeDEfQGAWuIBj0jDtfmYhRX5eviM4/rPt2ktJ+Mx4LTpwDn/bxt
         L3kgdETf1VtU5/8uVkyO4ZvPg8xnRNOhPDIVaONA=
Date:   Thu, 28 Feb 2019 14:58:32 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH v2] device.h: reorganize struct device
Message-ID: <20190228135832.GA16272@kroah.com>
References: <20190226144108.25891-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190226144108.25891-1-gregkh@linuxfoundation.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

struct device is big, around 760 bytes on x86_64.  It's not a critical
structure, but it is embedded everywhere, so making it smaller is always
a good thing.

With a recent patch that moved a field from struct device to the private
structure, some benchmarks showed a very odd regression, despite this
structure having nothing to do with those benchmarks.  That caused me to
look into the layout of the structure.  Using 'pahole', it showed a
number of holes and ways that the structure could be reordered in order
to align some cachelines better, as well as reduce the size of the
overall structure.

Move 'struct kobj' to the start of the structure, to keep that access
in the first cacheline, and try to organize things a bit more compactly
where possible

By doing these few moves, the result removes at least 8 bytes from
'struct device' on a 64bit system.  Given we know there are systems with
at least 30k devices in memory at once, every little byte counts, and
this change could be a savings of 240k of kernel memory for them.  On
"normal" systems the overall memory savings would be much less.

Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Johan Hovold <johan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
v2: drop the first patch, and make this one a bit simpler to try to take
    advantage where we can.  It's not as much savings, but it's better
    than nothing.

 include/linux/device.h | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/linux/device.h b/include/linux/device.h
index 6cb4640b6160..4eaa09468ab9 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -967,18 +967,14 @@ struct dev_links_info {
  * a higher-level representation of the device.
  */
 struct device {
+	struct kobject kobj;
 	struct device		*parent;
 
 	struct device_private	*p;
 
-	struct kobject kobj;
 	const char		*init_name; /* initial name of the device */
 	const struct device_type *type;
 
-	struct mutex		mutex;	/* mutex to synchronize calls to
-					 * its driver.
-					 */
-
 	struct bus_type	*bus;		/* type of bus device is on */
 	struct device_driver *driver;	/* which driver has allocated this
 					   device */
@@ -986,6 +982,10 @@ struct device {
 					   core doesn't touch it */
 	void		*driver_data;	/* Driver data, set and get with
 					   dev_set/get_drvdata */
+	struct mutex		mutex;	/* mutex to synchronize calls to
+					 * its driver.
+					 */
+
 	struct dev_links_info	links;
 	struct dev_pm_info	power;
 	struct dev_pm_domain	*pm_domain;
@@ -1000,9 +1000,6 @@ struct device {
 	struct list_head	msi_list;
 #endif
 
-#ifdef CONFIG_NUMA
-	int		numa_node;	/* NUMA node this device is close to */
-#endif
 	const struct dma_map_ops *dma_ops;
 	u64		*dma_mask;	/* dma mask (if dma'able device) */
 	u64		coherent_dma_mask;/* Like dma_mask, but for
@@ -1029,6 +1026,9 @@ struct device {
 	struct device_node	*of_node; /* associated device tree node */
 	struct fwnode_handle	*fwnode; /* firmware device node */
 
+#ifdef CONFIG_NUMA
+	int		numa_node;	/* NUMA node this device is close to */
+#endif
 	dev_t			devt;	/* dev_t, creates the sysfs "dev" */
 	u32			id;	/* device instance */
 
-- 
2.21.0

