Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 959D8C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:15:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56A3D21939
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:15:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553256924;
	bh=fAeIm/VJviWEZ+qzqFqkXDoDLzbmFvbJNR/Mm5BVk+0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UGOgkX0pkz+MJ1Lamv45dbVvWIw/1Zrn1JByPevw184hqOzob18GankTGJGydIadF
	 QVdtJDBoJoZoMkokVqTRgiytPPomjNG/+/XwkLCe6P9MO+rn3SIlWitMgxqYuOpvTL
	 ctEe7gfNG1nE2By2zqoJw7jzNcOaeP8fF1jXcYSA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390051AbfCVMPX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:15:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:53752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390044AbfCVMPU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:15:20 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8CFC421939;
        Fri, 22 Mar 2019 12:15:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553256919;
        bh=fAeIm/VJviWEZ+qzqFqkXDoDLzbmFvbJNR/Mm5BVk+0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2mk8RVS6VPCxSsjgVT1Ntikya5nYnw9Vi9xZgIZNg+aD7USIW0LpFGAGRRT7v6vz0
         9os/xrvdAPTbqm3dvaYvcAvLJ5GhTfznE5pWe9/EMXL9Ez+FCfdmOWzZ9qtH5NQ+iF
         V2YTIoH9WopQ4Uk6HzfaZ3RTkKaPiVkMh0pcV9NY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Marc Hartmayer <mhartmay@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Tony Krowiak <akrowiak@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [PATCH 5.0 076/238] s390: vfio_ap: link the vfio_ap devices to the vfio_ap bus subsystem
Date:   Fri, 22 Mar 2019 12:14:55 +0100
Message-Id: <20190322111303.090479615@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111258.383569278@linuxfoundation.org>
References: <20190322111258.383569278@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pierre Morel <pmorel@linux.ibm.com>

commit 36360658eb5a6cf04bb9f2704d1e4ce54037ec99 upstream.

Libudev relies on having a subsystem link for non-root devices. To
avoid libudev (and potentially other userspace tools) choking on the
matrix device let us introduce a matrix bus and with it the matrix
bus subsytem. Also make the matrix device reside within the matrix
bus.

Doing this we remove the forced link from the matrix device to the
vfio_ap driver and the device_type we do not need anymore.

Since the associated matrix driver is not the vfio_ap driver any more,
we have to change the search for the devices on the vfio_ap driver in
the function vfio_ap_verify_queue_reserved.
Fixes: 1fde573413b5 ("s390: vfio-ap: base implementation of VFIO AP device driver")
Cc: stable@vger.kernel.org

Reported-by: Marc Hartmayer <mhartmay@linux.ibm.com>
Reported-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
Tested-by: Christian Borntraeger <borntraeger@de.ibm.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: Tony Krowiak <akrowiak@linux.ibm.com>
Acked-by: Halil Pasic <pasic@linux.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/s390/crypto/vfio_ap_drv.c     |   44 +++++++++++++++++++++++++++-------
 drivers/s390/crypto/vfio_ap_ops.c     |    4 +--
 drivers/s390/crypto/vfio_ap_private.h |    1 
 3 files changed, 38 insertions(+), 11 deletions(-)

--- a/drivers/s390/crypto/vfio_ap_drv.c
+++ b/drivers/s390/crypto/vfio_ap_drv.c
@@ -15,7 +15,6 @@
 #include "vfio_ap_private.h"
 
 #define VFIO_AP_ROOT_NAME "vfio_ap"
-#define VFIO_AP_DEV_TYPE_NAME "ap_matrix"
 #define VFIO_AP_DEV_NAME "matrix"
 
 MODULE_AUTHOR("IBM Corporation");
@@ -24,10 +23,6 @@ MODULE_LICENSE("GPL v2");
 
 static struct ap_driver vfio_ap_drv;
 
-static struct device_type vfio_ap_dev_type = {
-	.name = VFIO_AP_DEV_TYPE_NAME,
-};
-
 struct ap_matrix_dev *matrix_dev;
 
 /* Only type 10 adapters (CEX4 and later) are supported
@@ -62,6 +57,22 @@ static void vfio_ap_matrix_dev_release(s
 	kfree(matrix_dev);
 }
 
+static int matrix_bus_match(struct device *dev, struct device_driver *drv)
+{
+	return 1;
+}
+
+static struct bus_type matrix_bus = {
+	.name = "matrix",
+	.match = &matrix_bus_match,
+};
+
+static struct device_driver matrix_driver = {
+	.name = "vfio_ap",
+	.bus = &matrix_bus,
+	.suppress_bind_attrs = true,
+};
+
 static int vfio_ap_matrix_dev_create(void)
 {
 	int ret;
@@ -71,6 +82,10 @@ static int vfio_ap_matrix_dev_create(voi
 	if (IS_ERR(root_device))
 		return PTR_ERR(root_device);
 
+	ret = bus_register(&matrix_bus);
+	if (ret)
+		goto bus_register_err;
+
 	matrix_dev = kzalloc(sizeof(*matrix_dev), GFP_KERNEL);
 	if (!matrix_dev) {
 		ret = -ENOMEM;
@@ -87,30 +102,41 @@ static int vfio_ap_matrix_dev_create(voi
 	mutex_init(&matrix_dev->lock);
 	INIT_LIST_HEAD(&matrix_dev->mdev_list);
 
-	matrix_dev->device.type = &vfio_ap_dev_type;
 	dev_set_name(&matrix_dev->device, "%s", VFIO_AP_DEV_NAME);
 	matrix_dev->device.parent = root_device;
+	matrix_dev->device.bus = &matrix_bus;
 	matrix_dev->device.release = vfio_ap_matrix_dev_release;
-	matrix_dev->device.driver = &vfio_ap_drv.driver;
+	matrix_dev->vfio_ap_drv = &vfio_ap_drv;
 
 	ret = device_register(&matrix_dev->device);
 	if (ret)
 		goto matrix_reg_err;
 
+	ret = driver_register(&matrix_driver);
+	if (ret)
+		goto matrix_drv_err;
+
 	return 0;
 
+matrix_drv_err:
+	device_unregister(&matrix_dev->device);
 matrix_reg_err:
 	put_device(&matrix_dev->device);
 matrix_alloc_err:
+	bus_unregister(&matrix_bus);
+bus_register_err:
 	root_device_unregister(root_device);
-
 	return ret;
 }
 
 static void vfio_ap_matrix_dev_destroy(void)
 {
+	struct device *root_device = matrix_dev->device.parent;
+
+	driver_unregister(&matrix_driver);
 	device_unregister(&matrix_dev->device);
-	root_device_unregister(matrix_dev->device.parent);
+	bus_unregister(&matrix_bus);
+	root_device_unregister(root_device);
 }
 
 static int __init vfio_ap_init(void)
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -198,8 +198,8 @@ static int vfio_ap_verify_queue_reserved
 	qres.apqi = apqi;
 	qres.reserved = false;
 
-	ret = driver_for_each_device(matrix_dev->device.driver, NULL, &qres,
-				     vfio_ap_has_queue);
+	ret = driver_for_each_device(&matrix_dev->vfio_ap_drv->driver, NULL,
+				     &qres, vfio_ap_has_queue);
 	if (ret)
 		return ret;
 
--- a/drivers/s390/crypto/vfio_ap_private.h
+++ b/drivers/s390/crypto/vfio_ap_private.h
@@ -40,6 +40,7 @@ struct ap_matrix_dev {
 	struct ap_config_info info;
 	struct list_head mdev_list;
 	struct mutex lock;
+	struct ap_driver  *vfio_ap_drv;
 };
 
 extern struct ap_matrix_dev *matrix_dev;


