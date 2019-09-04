Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33519C3A5A8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 16:37:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0680E2087E
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 16:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567615051;
	bh=3ik4bgJ5YXQxYvOQAuXEIGWzx/SBwsyTdJ0MmYEPnW8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Xa+hNW8I3oB8Ta5I10iMyk/akWE12xofHhP9S+xOoJFxByGc+FBFtoVwwunAncC1J
	 bxycuTJcwcYKtbcyaPaXH8z6pJjakfJ/49nErAhWJJxlpAqLPiHLv7mK/pzErwqK/r
	 SvkKMmvzduFzITavA87IA/2iHIajTq37yeSC0sN8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731953AbfIDQha (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 12:37:30 -0400
Received: from mga05.intel.com ([192.55.52.43]:47260 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731478AbfIDQh3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 12:37:29 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Sep 2019 09:37:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,467,1559545200"; 
   d="scan'208";a="199068030"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by fmsmga001.fm.intel.com with ESMTP; 04 Sep 2019 09:37:28 -0700
Date:   Wed, 4 Sep 2019 10:35:57 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@fb.com>,
        Hannes Reinecke <hare@suse.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        Keith Busch <keith.busch@intel.com>
Subject: Re: [PATCH] nvme-core: Fix subsystem instance mismatches
Message-ID: <20190904163557.GF21302@localhost.localdomain>
References: <20190831000139.7662-1-logang@deltatee.com>
 <20190831152910.GA29439@localhost.localdomain>
 <33af4d94-9f6d-9baa-01fa-0f75ccee263e@deltatee.com>
 <20190903164620.GA20847@localhost.localdomain>
 <20190904060558.GA10849@lst.de>
 <20190904144426.GB21302@localhost.localdomain>
 <20190904154215.GA20422@lst.de>
 <20190904155445.GD21302@localhost.localdomain>
 <ef3bf93b-cb47-95c5-7d96-f81d9acfdb55@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef3bf93b-cb47-95c5-7d96-f81d9acfdb55@deltatee.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 04, 2019 at 10:07:12AM -0600, Logan Gunthorpe wrote:
> Yes, I agree, we can't solve the mismatch problem in the general case:
> with sequences of hot plug events there will always be a case that
> mismatches. I just think we can do better in the simple common default case.

This may be something where udev can help us. I might be able to find
some time to look at that, but not today.
 
> > Can we just ensure there is never a matching controller then? This
> > patch will accomplish that and simpler than wrapping the instance in a
> > refcount'ed object:
> > 
> > http://lists.infradead.org/pipermail/linux-nvme/2019-May/024142.html
> 
> I don't really like that idea. It reduces the confusion caused by
> mismatching numbers, but causes the controller to never match the
> namespace, which is also confusing but in a different way.
> 
> I like the nvme_instance idea. It's not going to be perfect but it has
> some nice properties: the subsystem will try to match the controller's
> instance whenever possible, but in cases where it doesn't, the instance
> number of the subsystem will never be the same as an existing controller.
> 
> I'll see if I can work up a quick patch set and see what people think.

How about this: we have the subsys copy the controller's instance,
and the nvme_free_ctrl() doesn't release it if its subsys matches?

---
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 14c0bfb55615..8a8279ece5ee 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -81,7 +81,6 @@ EXPORT_SYMBOL_GPL(nvme_reset_wq);
 struct workqueue_struct *nvme_delete_wq;
 EXPORT_SYMBOL_GPL(nvme_delete_wq);
 
-static DEFINE_IDA(nvme_subsystems_ida);
 static LIST_HEAD(nvme_subsystems);
 static DEFINE_MUTEX(nvme_subsystems_lock);
 
@@ -2344,7 +2343,8 @@ static void nvme_release_subsystem(struct device *dev)
 	struct nvme_subsystem *subsys =
 		container_of(dev, struct nvme_subsystem, dev);
 
-	ida_simple_remove(&nvme_subsystems_ida, subsys->instance);
+	if (subsys->instance >= 0)
+		ida_simple_remove(&nvme_instance_ida, subsys->instance);
 	kfree(subsys);
 }
 
@@ -2473,12 +2473,8 @@ static int nvme_init_subsystem(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
 	subsys = kzalloc(sizeof(*subsys), GFP_KERNEL);
 	if (!subsys)
 		return -ENOMEM;
-	ret = ida_simple_get(&nvme_subsystems_ida, 0, 0, GFP_KERNEL);
-	if (ret < 0) {
-		kfree(subsys);
-		return ret;
-	}
-	subsys->instance = ret;
+
+	subsys->instance = -1;
 	mutex_init(&subsys->lock);
 	kref_init(&subsys->ref);
 	INIT_LIST_HEAD(&subsys->ctrls);
@@ -2497,7 +2493,7 @@ static int nvme_init_subsystem(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
 	subsys->dev.class = nvme_subsys_class;
 	subsys->dev.release = nvme_release_subsystem;
 	subsys->dev.groups = nvme_subsys_attrs_groups;
-	dev_set_name(&subsys->dev, "nvme-subsys%d", subsys->instance);
+	dev_set_name(&subsys->dev, "nvme-subsys%d", ctrl->instance);
 	device_initialize(&subsys->dev);
 
 	mutex_lock(&nvme_subsystems_lock);
@@ -2528,6 +2524,8 @@ static int nvme_init_subsystem(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
 		goto out_put_subsystem;
 	}
 
+	if (!found)
+		subsys->instance = ctrl->instance;
 	ctrl->subsys = subsys;
 	list_add_tail(&ctrl->subsys_entry, &subsys->ctrls);
 	mutex_unlock(&nvme_subsystems_lock);
@@ -3803,7 +3801,9 @@ static void nvme_free_ctrl(struct device *dev)
 		container_of(dev, struct nvme_ctrl, ctrl_device);
 	struct nvme_subsystem *subsys = ctrl->subsys;
 
-	ida_simple_remove(&nvme_instance_ida, ctrl->instance);
+	if (subsys && ctrl->instance != subsys->instance)
+		ida_simple_remove(&nvme_instance_ida, ctrl->instance);
+
 	kfree(ctrl->effects);
 	nvme_mpath_uninit(ctrl);
 	__free_page(ctrl->discard_page);
@@ -4085,7 +4085,6 @@ static int __init nvme_core_init(void)
 
 static void __exit nvme_core_exit(void)
 {
-	ida_destroy(&nvme_subsystems_ida);
 	class_destroy(nvme_subsys_class);
 	class_destroy(nvme_class);
 	unregister_chrdev_region(nvme_chr_devt, NVME_MINORS);
--
