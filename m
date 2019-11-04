Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4CD2CA9ECF
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 19:15:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97CDD20869
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 19:15:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZWLhtpw5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729131AbfKDTPb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 14:15:31 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41014 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728409AbfKDTPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 14:15:31 -0500
Received: by mail-wr1-f68.google.com with SMTP id p4so18405142wrm.8
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2019 11:15:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CGfA4APfEubm1amTj9pnW92uq+9vWWfdcxYaVFU+qyQ=;
        b=ZWLhtpw5Y8itG6RdER5q3n+rKh3sxSogacSppWVjEnucwPabPz7TSMwVd8Q3IxhR/x
         xd9rJG0zFeNNRoegVWki21EcIlfG7MFA5px9clBkL3jwcQk357K3Pw73aaaQV74hbNKb
         dZc75UJUpSvSNKGnKVMMnrJXiTRXKyXbWdOEJcHQ5CVvXSQpJ8OgjFg5grcjpjz0KKPx
         ahYvImzL0jhEqszyhL/ifHOG/f66GN8xxUrErSK2+3BXgF5pyF3Xys7mQxpzfALLA6f5
         dWziZCL+sx2eVzmnCLyKQxCPlpGAcBovAobu9+0gvmfTT1l7CcoVrUz6hQzp0Mc1orEc
         I20Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CGfA4APfEubm1amTj9pnW92uq+9vWWfdcxYaVFU+qyQ=;
        b=A5qjj+hnugTtl/ZVGVHWmhez0SkZoem8thLvvmwHfAtAGrZpxEpUYnyCpg6iajqpma
         5Em3MDK+l0AseYtUOww7EEsz3wOsUQyQ3M//UGS/vg9vvAWpL/gEjPobS2d/44989IJL
         Zcd7Qe52ZGoWrcOOihJDbujEwT2IPXYQoM6AGPIGMsV4Zjem2i3cPrhLcriILs+15vFl
         iwaZgItlnVLcWyrwNhir+OyNtj2e6ZoJMCzpW61zDEUatVqv39FAcMF4aMvep8AUw5gL
         BfoAr/xuvKZzCnOzCxExMx3CwTzHOCkHISFx5LZDklDON4MZtcG49jHicXrSxFWxFMRF
         3XKg==
X-Gm-Message-State: APjAAAUEXs7FannpSbh6skGaacSy8RAbOJ2LkKH1Fu8PZ2xKi56jTgaN
        ORcni53Nn1y1kdajlx5oMBwkFg==
X-Google-Smtp-Source: APXvYqzgRnspvZEPDvCYUC+JCKvP8etQsmMwHGGdX9adwW1yl8y7jQUzMGxQNSrYKNikdLccPHWlBg==
X-Received: by 2002:adf:d1a3:: with SMTP id w3mr26484328wrc.9.1572894927195;
        Mon, 04 Nov 2019 11:15:27 -0800 (PST)
Received: from lophozonia ([85.195.192.192])
        by smtp.gmail.com with ESMTPSA id t24sm28146473wra.55.2019.11.04.11.15.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2019 11:15:26 -0800 (PST)
Date:   Mon, 4 Nov 2019 20:15:24 +0100
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Will Deacon <will@kernel.org>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        iommu@lists.linux-foundation.org,
        Robin Murphy <robin.murphy@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/7] iommu/arm-smmu-v3: Allow building as a module
Message-ID: <20191104191524.GA2786242@lophozonia>
References: <20191030145112.19738-1-will@kernel.org>
 <20191030145112.19738-6-will@kernel.org>
 <20191030193148.GA8432@8bytes.org>
 <20191031154247.GB28061@willie-the-truck>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="UlVJffcvxoiEqYs2"
Content-Disposition: inline
In-Reply-To: <20191031154247.GB28061@willie-the-truck>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--UlVJffcvxoiEqYs2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 31, 2019 at 03:42:47PM +0000, Will Deacon wrote:
> > Sorry for the stupid question, but what prevents the iommu module from
> > being unloaded when there are active users? There are no symbol
> > dependencies to endpoint device drivers, because the interface is only
> > exposed through the iommu-api, right? Is some sort of manual module
> > reference counting needed?
> 
> Generally, I think unloading the IOMMU driver module while there are
> active users is a pretty bad idea, much like unbinding the driver via
> /sys in the same situation would also be fairly daft. However, I *think*
> the code in __device_release_driver() tries to deal with this by
> iterating over the active consumers and ->remove()ing them first.

> I'm without hardware access at the moment, so I haven't been able to
> test this myself. We could nobble the module_exit() hook, but there's
> still the "force unload" option depending on the .config.

Shame that we can't completely prevent module unloading, because handling
rmmod cleanly is tricky.

On module unload we also need to tidy up the bus->iommu_ops installed by
bus_set_iommu(), and remove the IOMMU groups (and probably other leaks I
missed). I have a solution for the bus->iommu_ops, which is simply adding
a bus_unset_iommu() counterpart with a refcount, but it doesn't deal with
the IOMMU groups cleanly. If there are multiple IOMMU instances managing
one bus, then we should only remove the IOMMU groups belonging to the
instance that is being removed.

I'll think about this more, but the simple solution is attached if you
want to test. It at least works with a single IOMMU now:

$ modprobe virtio-iommu
[   25.180965] virtio_iommu virtio0: input address: 64 bits
[   25.181437] virtio_iommu virtio0: page mask: 0xfffffffffffff000
[   25.214493] virtio-pci 0000:00:03.0: Adding to iommu group 0
[   25.233252] virtio-pci 0000:00:03.0: enabling device (0000 -> 0003)
[   25.334810] e1000e 0000:00:02.0: Adding to iommu group 1
[   25.348997] e1000e 0000:00:02.0: enabling device (0000 -> 0002)
... net test etc

$ rmmod virtio-iommu
[   34.084816] e1000e: eth1 NIC Link is Down
[   34.212152] pci 0000:00:02.0: Removing from iommu group 1
[   34.250558] pci 0000:00:03.0: Removing from iommu group 0
[   34.261570] virtio_iommu virtio0: device removed

$ modprobe virtio-iommu
[   34.828982] virtio_iommu virtio0: input address: 64 bits
[   34.829442] virtio_iommu virtio0: page mask: 0xfffffffffffff000
[   34.844576] virtio-pci 0000:00:03.0: Adding to iommu group 0
[   34.916449] e1000e 0000:00:02.0: Adding to iommu group 1

Thanks,
Jean

--UlVJffcvxoiEqYs2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-iommu-Add-bus_unset_iommu.patch"

From 5437fcaabe1d4671e2dc5b90b7898c0bf698111b Mon Sep 17 00:00:00 2001
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
Date: Mon, 4 Nov 2019 15:52:36 +0100
Subject: [PATCH] iommu: Add bus_unset_iommu()

Let modular IOMMU drivers undo bus_set_iommu(). Keep track of bus
registrations with a list and refcount, and remove the iommu_ops from
the bus when there are no IOMMU providers anymore.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/iommu/iommu.c | 101 ++++++++++++++++++++++++++++++++++--------
 include/linux/iommu.h |   1 +
 2 files changed, 84 insertions(+), 18 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 393a5376d7c6..f9bac5633f2a 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -31,6 +31,9 @@ static unsigned int iommu_def_domain_type __read_mostly;
 static bool iommu_dma_strict __read_mostly = true;
 static u32 iommu_cmd_line __read_mostly;
 
+static DEFINE_MUTEX(iommu_bus_notifiers_lock);
+static LIST_HEAD(iommu_bus_notifiers);
+
 struct iommu_group {
 	struct kobject kobj;
 	struct kobject *devices_kobj;
@@ -58,6 +61,14 @@ struct iommu_group_attribute {
 			 const char *buf, size_t count);
 };
 
+struct iommu_bus_notifier {
+	struct notifier_block	nb;
+	const struct iommu_ops	*ops;
+	struct bus_type		*bus;
+	struct list_head	list;
+	refcount_t		refs;
+};
+
 static const char * const iommu_group_resv_type_string[] = {
 	[IOMMU_RESV_DIRECT]			= "direct",
 	[IOMMU_RESV_DIRECT_RELAXABLE]		= "direct-relaxable",
@@ -1494,15 +1505,29 @@ static int iommu_bus_notifier(struct notifier_block *nb,
 static int iommu_bus_init(struct bus_type *bus, const struct iommu_ops *ops)
 {
 	int err;
-	struct notifier_block *nb;
+	struct iommu_bus_notifier *iommu_notifier;
 
-	nb = kzalloc(sizeof(struct notifier_block), GFP_KERNEL);
-	if (!nb)
-		return -ENOMEM;
+	list_for_each_entry(iommu_notifier, &iommu_bus_notifiers, list) {
+		if (iommu_notifier->ops == ops && iommu_notifier->bus == bus) {
+			refcount_inc(&iommu_notifier->refs);
+			return 0;
+		}
+	}
+
+	bus->iommu_ops = ops;
+
+	iommu_notifier = kzalloc(sizeof(*iommu_notifier), GFP_KERNEL);
+	if (!iommu_notifier) {
+		err = -ENOMEM;
+		goto out_clear;
+	}
 
-	nb->notifier_call = iommu_bus_notifier;
+	iommu_notifier->ops = ops;
+	iommu_notifier->bus = bus;
+	iommu_notifier->nb.notifier_call = iommu_bus_notifier;
+	refcount_set(&iommu_notifier->refs, 1);
 
-	err = bus_register_notifier(bus, nb);
+	err = bus_register_notifier(bus, &iommu_notifier->nb);
 	if (err)
 		goto out_free;
 
@@ -1510,20 +1535,47 @@ static int iommu_bus_init(struct bus_type *bus, const struct iommu_ops *ops)
 	if (err)
 		goto out_err;
 
-
+	list_add(&iommu_notifier->list, &iommu_bus_notifiers);
 	return 0;
 
 out_err:
 	/* Clean up */
 	bus_for_each_dev(bus, NULL, NULL, remove_iommu_group);
-	bus_unregister_notifier(bus, nb);
-
+	bus_unregister_notifier(bus, &iommu_notifier->nb);
 out_free:
-	kfree(nb);
+	kfree(iommu_notifier);
+out_clear:
+	bus->iommu_ops = NULL;
 
 	return err;
 }
 
+static int iommu_bus_remove(struct bus_type *bus, const struct iommu_ops *ops)
+{
+	struct iommu_bus_notifier *tmp;
+	struct iommu_bus_notifier *iommu_notifier = NULL;
+
+	list_for_each_entry(tmp, &iommu_bus_notifiers, list) {
+		if (tmp->ops == ops && tmp->bus == bus) {
+			iommu_notifier = tmp;
+			break;
+		}
+	}
+
+	if (!iommu_notifier)
+		return -ESRCH;
+
+	if (!refcount_dec_and_test(&iommu_notifier->refs))
+		return 0;
+
+	list_del(&iommu_notifier->list);
+	bus_for_each_dev(bus, NULL, NULL, remove_iommu_group);
+	bus_unregister_notifier(bus, &iommu_notifier->nb);
+	kfree(iommu_notifier);
+	bus->iommu_ops = NULL;
+	return 0;
+}
+
 /**
  * bus_set_iommu - set iommu-callbacks for the bus
  * @bus: bus.
@@ -1541,20 +1593,33 @@ int bus_set_iommu(struct bus_type *bus, const struct iommu_ops *ops)
 {
 	int err;
 
-	if (bus->iommu_ops != NULL)
-		return -EBUSY;
-
-	bus->iommu_ops = ops;
-
 	/* Do IOMMU specific setup for this bus-type */
-	err = iommu_bus_init(bus, ops);
-	if (err)
-		bus->iommu_ops = NULL;
+	mutex_lock(&iommu_bus_notifiers_lock);
+	if (bus->iommu_ops != NULL && bus->iommu_ops != ops)
+		err = -EBUSY;
+	else
+		err = iommu_bus_init(bus, ops);
+	mutex_unlock(&iommu_bus_notifiers_lock);
 
 	return err;
 }
 EXPORT_SYMBOL_GPL(bus_set_iommu);
 
+int bus_unset_iommu(struct bus_type *bus, const struct iommu_ops *ops)
+{
+	int err;
+
+	mutex_lock(&iommu_bus_notifiers_lock);
+	if (bus->iommu_ops != ops)
+		err = -EINVAL;
+	else
+		err = iommu_bus_remove(bus, ops);
+	mutex_unlock(&iommu_bus_notifiers_lock);
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(bus_unset_iommu);
+
 bool iommu_present(struct bus_type *bus)
 {
 	return bus->iommu_ops != NULL;
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 29bac5345563..15c9115e31ff 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -408,6 +408,7 @@ static inline void iommu_iotlb_gather_init(struct iommu_iotlb_gather *gather)
 #define IOMMU_GROUP_NOTIFY_UNBOUND_DRIVER	6 /* Post Driver unbind */
 
 extern int bus_set_iommu(struct bus_type *bus, const struct iommu_ops *ops);
+extern int bus_unset_iommu(struct bus_type *bus, const struct iommu_ops *ops);
 extern bool iommu_present(struct bus_type *bus);
 extern bool iommu_capable(struct bus_type *bus, enum iommu_cap cap);
 extern struct iommu_domain *iommu_domain_alloc(struct bus_type *bus);
-- 
2.23.0


--UlVJffcvxoiEqYs2--
